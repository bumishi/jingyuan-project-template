import pymysql
import os
import json
import time
from string import Template
import codecs
import sys
from dataclasses import dataclass
from jinja2 import Environment, PackageLoader

@dataclass
class DatabaseConfig:
    host:str  # mysql所在机子IP
    port :int  # mysql端口
    uname :str  # mysql数据库用户名
    upwd :str  # mysql数据库密码
    dbName :str  # mysql数据库名称

@dataclass
class TableMeta:
    table_name: str
    comment: str
    fields: list


@dataclass
class TableField:
    name: str
    sql_type: str
    comment: str
    # 是否可为空
    is_nullable: bool
    # 字符串类型最大长度
    max_len: int | None
    # 是否主键
    is_pk: bool
    py_type: str = None
    # sqlalchemy orm中的映射类型
    sqlalchemy_type: str = None

    def convertDataType(self):
        dbType = self.sql_type
        if dbType == "int" or dbType == "tinyint" or dbType == 'smallint':
            self.py_type = "int"
            self.sqlalchemy_type = "Integer"
        elif dbType == "varchar" or dbType == "char" or dbType == "longtext" or dbType == "text":
            self.py_type = "str"
            self.sqlalchemy_type = "String"
        elif dbType == "timestamp" or dbType == "date" or dbType == "datetime":
            self.py_type = "datetime"
            self.sqlalchemy_type = "DateTime"
        elif dbType == "date":
            self.py_type = "date"
            self.sqlalchemy_type = "Date"
        elif dbType == "bigint":
            self.py_type = "int"
            self.sqlalchemy_type = "BigInteger"
        elif dbType == "decimal":
            self.py_type = "Decimal"
            self.sqlalchemy_type = "Numeric"


def getTableMeta(tableName,db:DatabaseConfig) -> TableMeta:
    sql = "select column_name,data_type,column_comment,IS_NULLABLE,CHARACTER_MAXIMUM_LENGTH,COLUMN_KEY from information_schema.columns where  table_schema = '" + db.dbName + "' and table_name = '" + tableName + "' order by  ORDINAL_POSITION"
    conn = getConn(db)
    cur = getCur(conn)
    count = cur.execute(sql)
    columns = cur.fetchall()

    fields: list[TableField] = []
    for column in columns:
        table_field = TableField(name=column[0], sql_type=column[1], comment=column[2], is_nullable=column[3] == 'YES',
                                 max_len=column[4], is_pk=column[5] == 'PRI')
        table_field.convertDataType()
        fields.append(table_field)

    sql = "SELECT table_comment FROM information_schema.TABLES where table_name = '" + tableName + "' and table_schema = '" + db.dbName + "'"
    count = cur.execute(sql)
    tableComment = cur.fetchall()
    table_meta = TableMeta(table_name=tableName, fields=fields, comment=tableComment[0][0])

    cur.close()
    conn.commit()
    conn.close()
    return table_meta


# 数据库链接
def getConn(db:DatabaseConfig):
    conn = pymysql.connect(host=db.host, port=db.port, user=db.uname, passwd=db.upwd, db=db.dbName, charset='utf8')
    return conn


# 数据库游标
def getCur(conn):
    cur = conn.cursor()
    return cur

@dataclass
class CodeGenerateor:
    db: DatabaseConfig
    basePath: str  # 生成文件保存路径
    package_name: str  # 包路径，生成的文件中package的值
    template_dir: str
    prefix: str = ""  # 表名前缀，生成实体类时是否去掉表前缀，如果不需要就设置为空字符。
    api_permi_base_code: str = None
    api_route: str = None
    mode:str='both'

    def _createPackage(self):
        dirs = self.package_name.split(".")
        dirPath = self.basePath
        for pkg in dirs:
            dirPath = dirPath + "/" + pkg
            if not os.path.exists(dirPath):
                os.makedirs(dirPath)
                initFile = codecs.open(dirPath + "/__init__.py", "w", "utf-8")
                initFile.close()

    def __create_file(self, content: str, filename: str):
        # 生成文件
        filePath = self.basePath + "/" + self.package_name.replace(".", "/")
        if not filePath.endswith("/"):
            filePath = filePath + "/" + filename
        print('gen file '+filePath)
        entityFile = codecs.open(filePath, "w", "utf-8")
        entityFile.write(content)
        entityFile.close()

    # 获取类名
    def getClassName(self,tableName):
        # 去掉表前缀
        tableName = tableName.replace(self.prefix, "")
        className = ""
        if tableName.find("_") >= 0:
            subs = tableName.split("_")
            for sub in subs:
                className = className + sub.lower().capitalize()
        else:
            className = tableName.lower().capitalize()
        return className
    def generate_file(self, table_name, template_name, file_name, vars: dict = {}):
        table_meta = getTableMeta(table_name,self.db)
        print(table_meta)
        kvs = {'table': table_meta, 'entity': self.getClassName(table_name),'mode':self.mode}
        for k in vars.keys():
            kvs[k] = vars[k]
        env = Environment(loader=PackageLoader('core', self.template_dir))
        template_model = env.get_template(template_name)
        content_model = template_model.render(**kvs)
        self._createPackage()
        self.__create_file(content=content_model, filename=file_name)

    def generate_models(self, table_name):
        self.generate_file(table_name=table_name, file_name='models.py', template_name='models.jinja2')

    def generate_services(self, table_name):
        self.generate_file(table_name=table_name, file_name='service.py', template_name='service.jinja2')

    def generate_api(self, table_name):
        kvs = {'api_permi_base_code': self.api_permi_base_code,
               'api_route': self.api_route}
        if self.mode in ['api','admin_apiquery','api_adminquery']:
            self.generate_file(table_name=table_name, file_name='views_api.py', template_name='views_api.jinja2', vars=kvs)
        if self.mode in ['admin','api_adminquery','api_adminquery']:
            self.generate_file(table_name=table_name, file_name='views_admin.py', template_name='views_admin.jinja2', vars=kvs)

@dataclass
class FrontCodeGenerateor:
    db: DatabaseConfig
    basePath: str  # 生成文件基础路径
    template_dir: str
    api_permi_base_code: str
    api_route: str
    main_page_dir: str
    api_ts_dir: str
    prefix: str = ""  # 表名前缀，生成实体类时是否去掉表前缀，如果不需要就设置为空字符。
    write_page_dir: str=''
    def _createPackage(self,folder):
        dirs = folder.split(".")
        dirPath = self.basePath
        for pkg in dirs:
            dirPath = dirPath + "/" + pkg
            if not os.path.exists(dirPath):
                os.makedirs(dirPath)

    def __create_file(self, content: str, filename: str,folder:str):
        # 生成文件
        filePath = self.basePath + "/" + folder
        if not filePath.endswith("/"):
            filePath = filePath + "/" + filename
        entityFile = codecs.open(filePath, "w", "utf-8")
        entityFile.write(content)
        entityFile.close()

    # 获取类名
    def getClassName(self,tableName):
        # 去掉表前缀
        tableName = tableName.replace(self.prefix, "")
        className = ""
        if tableName.find("_") >= 0:
            subs = tableName.split("_")
            for sub in subs:
                className = className + sub.lower().capitalize()
        else:
            className = tableName.lower().capitalize()
        return className
    def generate_file(self, table_name, template_name, file_name, folder,vars: dict = {}):
        table_meta = getTableMeta(table_name,self.db)
        # print(table_meta)
        kvs = {'table': table_meta, 'entity': self.getClassName(table_name),'api_permi_base_code': self.api_permi_base_code,
               'api_route': self.api_route}
        for k in vars.keys():
            kvs[k] = vars[k]
        env = Environment(loader=PackageLoader('core', self.template_dir))
        template_model = env.get_template(template_name)
        content_model = template_model.render(**kvs)
        self._createPackage(folder)
        self.__create_file(content=content_model, filename=file_name,folder=folder)

    def generate_main_page(self, table_name,template_name):
        kvs = {'api_ts_dir': self.api_ts_dir}
        self.generate_file(table_name=table_name, file_name=self.getClassName(table_name)+'.vue', template_name=template_name,folder=self.main_page_dir,vars=kvs)

    def generate_write_apge(self, table_name):
        kvs = {'api_ts_dir': self.api_ts_dir}
        self.generate_file(table_name=table_name, file_name='Write.vue', template_name='Write.vue.jinja2',folder=self.write_page_dir,vars=kvs)

    def generate_api(self, table_name,template_name,file_extention='.ts'):
        self.generate_file(table_name=table_name, file_name=table_name+file_extention, template_name=template_name,folder=self.api_ts_dir)

# 数据库字段转驼峰式命名
def convertToCalm(field):
    returnValue = ""
    if field.find("_") >= 0:
        subs = field.split("_")
        for index, sub in enumerate(subs):
            if index == 0:
                returnValue = returnValue + sub
            else:
                returnValue = returnValue + sub.capitalize()
        return returnValue
    else:
        return field


# 获取时间，用于生成注释
def getSystemDate():
    return time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
