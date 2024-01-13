from core.codegen import CodeGenerateor,FrontCodeGenerateor,DatabaseConfig

host = "127.0.0.1"  # mysql所在机子IP
port = 3306  # mysql端口
uname = "root"  # mysql数据库用户名
upwd = "root"  # mysql数据库密码
dbName = "jingyuan-starter"  # mysql数据库名称
db = DatabaseConfig(host=host, port=port, uname=uname, upwd=upwd, dbName=dbName)
prefix = ""  # 表名前缀，生成实体类时是否去掉表前缀，如果不需要就设置为空字符。
api_permi_base_code = 'system.feedback'
api_route = '/feedback'

def gen_python(table_name):
    basePath = "/Users/jingyuan-api-python"  # 生成文件所在项目的根路径
    package_name = "apps.system.feedback"  # 包路径，生成的文件中package的值
    template_dir = 'templates/python'

    # 代码模式：
    # admin表示是纯admin功能
    # ，api表示纯api功能，
    # api_adminquery表示是api功能，但是额外增加一个admin查询接口,
    # admin_apiquery表示admin主功能，额外增加api查询接口
    mode = 'api_adminquery'
    gen_service = True
    gen_api = True
    code_gen = CodeGenerateor(basePath=basePath, prefix=prefix, package_name=package_name, template_dir=template_dir,
                              api_permi_base_code=api_permi_base_code, api_route=api_route, db=db, mode=mode)
    code_gen.generate_models(table_name)
    if gen_service:
        code_gen.generate_services(table_name)
    if gen_api:
        code_gen.generate_api(table_name)

def gen_admin_front(table_name):
    basePath = "/Users/jingyuan-admin/src"  # 生成文件保存路径
    template_dir = 'templates/vueadmin'
    main_page_dir="/views/Vadmin/feedback"
    write_page_dir = "/views/Vadmin/feedback/components"
    api_page_dir = "/api/vadmin/feedback"
    code_gen = FrontCodeGenerateor(basePath=basePath, prefix=prefix, template_dir=template_dir,
                              api_permi_base_code=api_permi_base_code, api_route=api_route, db=db,main_page_dir=main_page_dir,write_page_dir=write_page_dir,api_ts_dir=api_page_dir)

    code_gen.generate_main_page(table_name,template_name='MainPage.vue.jinja2')
    code_gen.generate_write_apge(table_name)
    code_gen.generate_api(table_name,template_name='api.ts.jinja2')

def gen_uniapp(table_name):
    basePath = "/xxx/jingyuan-product-uniapp"  # 生成文件保存路径
    template_dir = 'templates/uniapp'
    main_page_dir="/pages/biz"
    api_page_dir = "/sheep/api"
    code_gen = FrontCodeGenerateor(basePath=basePath, prefix=prefix, template_dir=template_dir,
                              api_permi_base_code=api_permi_base_code, api_route=api_route, db=db,main_page_dir=main_page_dir,api_ts_dir=api_page_dir)

    code_gen.generate_main_page(table_name,template_name='page.vue.jinja2')
    code_gen.generate_api(table_name,template_name='api.js.jinja2',file_extention='.js')

if __name__ == "__main__":
    table_name = 'user_feedback'
    gen_python(table_name)
    gen_admin_file=True
    if gen_admin_file:
        gen_admin_front(table_name)

    gen_uniapp_file = True
    if gen_uniapp_file:
        gen_uniapp(table_name)