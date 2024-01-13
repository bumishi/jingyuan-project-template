-- MySQL dump 10.13  Distrib 8.0.16, for osx10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: jingyuan-starter
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_third_bind`
--

DROP TABLE IF EXISTS `user_third_bind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user_third_bind` (
  `user_id` int(10) unsigned NOT NULL,
  `open_id` varchar(100) NOT NULL COMMENT '第三方用户id',
  `third_type` varchar(10) NOT NULL COMMENT '第三方应用类型(weixin,douying)',
  `union_id` varchar(100) DEFAULT NULL COMMENT '微信跨应用的唯一id',
  `bind_time` datetime DEFAULT NULL COMMENT '绑定时间',
  PRIMARY KEY (`open_id`,`third_type`),
  UNIQUE KEY `user_third_bind_unique` (`union_id`,`third_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户绑定的第三方登录账号';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_third_bind`
--

LOCK TABLES `user_third_bind` WRITE;
/*!40000 ALTER TABLE `user_third_bind` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_third_bind` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vadmin_auth_menu`
--

DROP TABLE IF EXISTS `vadmin_auth_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vadmin_auth_menu` (
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '菜单图标',
  `redirect` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '重定向地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '前端组件地址',
  `path` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '前端路由地址',
  `disabled` tinyint(1) NOT NULL COMMENT '是否禁用',
  `hidden` tinyint(1) NOT NULL COMMENT '是否隐藏',
  `order` int(11) NOT NULL COMMENT '排序',
  `menu_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '菜单类型',
  `parent_id` int(11) DEFAULT NULL COMMENT '父菜单',
  `perms` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '权限标识',
  `noCache` tinyint(1) NOT NULL COMMENT '如果设置为true，则不会被 <keep-alive> 缓存(默认 false)',
  `breadcrumb` tinyint(1) NOT NULL COMMENT '如果设置为false，则不会在breadcrumb面包屑中显示(默认 true)',
  `affix` tinyint(1) NOT NULL COMMENT '如果设置为true，则会一直固定在tag项中(默认 false)',
  `noTagsView` tinyint(1) NOT NULL COMMENT '如果设置为true，则不会出现在tag中(默认 false)',
  `canTo` tinyint(1) NOT NULL COMMENT '设置为true即使hidden为true，也依然可以进行路由跳转(默认 false)',
  `alwaysShow` tinyint(1) NOT NULL COMMENT '当你一个路由下面的 children 声明的路由大于1个时，自动会变成嵌套的模式，\n    只有一个时，会将那个子路由当做根路由显示在侧边栏，若你想不管路由下面的 children 声明的个数都显示你的根路由，\n    你可以设置 alwaysShow: true，这样它就会忽略之前定义的规则，一直显示根路由(默认 true)',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `create_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_datetime` datetime DEFAULT NULL COMMENT '删除时间',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否软删除',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `ix_vadmin_auth_menu_perms` (`perms`),
  CONSTRAINT `vadmin_auth_menu_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `vadmin_auth_menu` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vadmin_auth_menu`
--

LOCK TABLES `vadmin_auth_menu` WRITE;
/*!40000 ALTER TABLE `vadmin_auth_menu` DISABLE KEYS */;
INSERT INTO `vadmin_auth_menu` VALUES ('仪表盘','ant-design:dashboard-filled','/dashboard/workplace','#','/dashboard',0,0,1,'0',NULL,NULL,0,1,0,0,0,0,1,'2022-08-13 10:56:32','2023-12-29 17:55:40',NULL,0),('系统管理','ep:lock','/sys/menu','#','/sys',0,0,1,'0',NULL,NULL,0,1,0,0,0,0,2,'2022-09-22 22:53:52','2023-12-30 10:55:21',NULL,0),('工作台',NULL,NULL,'views/Dashboard/Workplace','workplace',0,0,0,'1',1,NULL,0,1,0,0,0,0,4,'2022-10-12 16:59:27','2022-11-18 10:25:35',NULL,0),('数据概览',NULL,NULL,'views/Dashboard/Analysis/Analysis','analysis',1,0,1,'1',1,NULL,0,1,0,0,0,0,5,'2022-11-05 12:55:59','2023-12-29 19:54:42',NULL,0),('用户分布',NULL,NULL,'views/Dashboard/Map','map',1,0,2,'1',1,NULL,0,1,0,0,0,0,6,'2022-11-16 18:39:17','2023-12-29 19:54:31',NULL,0),('菜单管理',NULL,NULL,'views/Vadmin/Auth/Menu/Menu','menu',0,0,1,'1',2,NULL,0,1,0,0,0,0,7,'2022-09-22 17:21:30','2022-11-18 10:26:42',NULL,0),('角色管理',NULL,NULL,'views/Vadmin/Auth/Role/Role','role',0,0,2,'1',2,NULL,0,1,0,0,0,0,8,'2022-09-22 17:21:30','2022-11-18 10:26:56',NULL,0),('用户管理',NULL,NULL,'views/Vadmin/Auth/User/User','user',0,0,3,'1',2,NULL,0,1,0,0,0,0,9,'2022-09-22 17:21:30','2023-09-11 16:24:37',NULL,0),('字典配置',NULL,NULL,'views/Vadmin/System/Dict/Dict','dict',0,0,10,'1',2,NULL,0,1,0,0,0,0,10,'2022-10-04 21:02:55','2023-12-29 19:45:33',NULL,0),('日志管理','tdesign:catalog',NULL,'#','/record',0,0,99,'0',NULL,NULL,0,1,0,0,0,0,13,'2022-10-28 21:29:56','2022-11-05 11:50:05',NULL,0),('系统配置',NULL,NULL,'views/Vadmin/System/Settings/Settings','settings',0,0,0,'1',2,NULL,0,1,0,0,0,0,14,'2022-10-30 17:35:50','2023-12-29 19:45:05',NULL,0),('登录日志',NULL,NULL,'views/Vadmin/System/Record/Login/Login','login',0,0,0,'1',13,NULL,0,1,0,0,0,0,15,'2022-10-28 21:34:47','2022-10-28 21:36:05',NULL,0),('操作日志',NULL,NULL,'views/Vadmin/System/Record/Operation/Operation','operation',1,0,1,'1',13,NULL,0,1,0,0,0,0,16,'2022-10-28 22:12:15','2023-12-29 15:09:23',NULL,0),('新增菜单',NULL,NULL,NULL,NULL,0,0,0,'2',7,'auth.menu.create',0,1,0,0,0,0,17,'2022-11-18 14:21:26','2022-11-18 14:29:51',NULL,0),('编辑菜单',NULL,NULL,NULL,NULL,0,0,1,'2',7,'auth.menu.update',0,1,0,0,0,0,18,'2022-11-18 15:23:05','2022-11-18 15:23:05',NULL,0),('删除菜单',NULL,NULL,NULL,NULL,0,0,2,'2',7,'auth.menu.delete',0,1,0,0,0,0,19,'2022-11-18 15:23:27','2022-11-18 15:23:27',NULL,0),('新增角色',NULL,NULL,NULL,NULL,0,0,0,'2',8,'auth.role.create',0,1,0,0,0,0,20,'2022-11-18 15:11:55','2022-11-18 15:11:55',NULL,0),('编辑角色',NULL,NULL,NULL,NULL,0,0,1,'2',8,'auth.role.update',0,1,0,0,0,0,21,'2022-11-18 15:23:56','2022-11-18 15:23:56',NULL,0),('删除角色',NULL,NULL,NULL,NULL,0,0,2,'2',8,'auth.role.delete',0,1,0,0,0,0,22,'2022-11-18 15:24:11','2023-08-24 15:41:23',NULL,0),('新增用户',NULL,NULL,NULL,NULL,0,0,0,'2',9,'auth.user.create',0,1,0,0,0,0,23,'2022-11-18 15:26:19','2022-11-18 15:31:00',NULL,0),('编辑用户',NULL,NULL,NULL,NULL,0,0,1,'2',9,'auth.user.update',0,1,0,0,0,0,24,'2022-11-18 15:26:41','2022-11-18 15:26:41',NULL,0),('删除用户',NULL,NULL,NULL,NULL,0,0,2,'2',9,'auth.user.delete',0,1,0,0,0,0,25,'2022-11-18 15:27:06','2022-11-18 15:27:06',NULL,0),('批量导入用户',NULL,NULL,NULL,NULL,0,0,3,'2',9,'auth.user.import',0,1,0,0,0,0,26,'2022-11-18 15:27:36','2022-11-18 15:27:36',NULL,0),('导出筛选用户',NULL,NULL,NULL,NULL,0,0,4,'2',9,'auth.user.export',0,1,0,0,0,0,27,'2022-11-18 15:27:55','2022-11-18 15:27:55',NULL,0),('帮助中心','material-symbols:help-rounded',NULL,'#','/help',1,1,100,'0',NULL,NULL,0,1,0,0,0,1,38,'2023-02-16 16:33:03','2023-12-29 19:47:46',NULL,0),('常见问题类别',NULL,NULL,'views/Vadmin/Help/IssueCategory/IssueCategory','issue/category',0,0,0,'1',38,NULL,0,1,0,0,0,0,39,'2023-02-16 16:34:00','2023-09-11 12:32:06',NULL,0),('常见问题',NULL,NULL,'views/Vadmin/Help/Issue/Issue','issue',0,0,1,'1',38,NULL,0,1,0,0,0,0,40,'2023-02-16 17:12:53','2023-09-11 12:32:26',NULL,0),('常见问题表单',NULL,NULL,'views/Vadmin/Help/Issue/components/Write','issue/form',0,1,99,'1',38,NULL,0,1,0,0,0,0,42,'2023-02-21 23:41:24','2023-09-11 12:32:43',NULL,0),('智慧大屏','icon-park-solid:data-sheet','/screen/air',NULL,'/screen',1,0,3,'0',NULL,NULL,0,1,0,0,0,1,68,'2022-11-24 15:07:23','2023-12-29 19:54:55',NULL,0),('空气质量',NULL,NULL,'views/Vadmin/Screen/Air/Air','air',0,0,0,'1',68,NULL,0,1,0,0,0,0,69,'2022-11-24 15:08:09','2023-09-18 09:52:39',NULL,0),('定时任务',NULL,NULL,'views/Vadmin/System/Task/Task','task',1,0,20,'1',2,NULL,1,1,0,0,0,0,73,'2023-06-25 14:44:36','2023-12-29 19:46:15',NULL,0),('调度日志',NULL,NULL,'views/Vadmin/System/Record/Task/Task','task',1,0,2,'1',13,NULL,0,1,0,0,0,0,74,'2023-06-28 10:53:58','2023-12-29 16:40:09',NULL,0),('获取菜单列表',NULL,NULL,NULL,NULL,0,0,3,'2',7,'auth.menu.list',0,1,0,0,0,0,76,'2023-08-24 15:40:23','2023-08-24 15:40:23',NULL,0),('获取角色列表',NULL,NULL,NULL,NULL,0,0,3,'2',8,'auth.role.list',0,1,0,0,0,0,77,'2023-08-24 15:40:47','2023-08-24 15:40:47',NULL,0),('获取用户列表',NULL,NULL,NULL,NULL,0,0,6,'2',9,'auth.user.list',0,1,0,0,0,0,78,'2023-08-24 15:41:16','2023-08-24 15:41:16',NULL,0),('资源管理','line-md:image',NULL,'#','/resource',1,1,4,'0',NULL,NULL,0,1,0,0,0,1,79,'2023-08-25 13:56:25','2023-12-29 19:48:01',NULL,0),('图片资源',NULL,NULL,'views/Vadmin/Resource/Image/Image','images',0,0,1,'1',79,NULL,0,1,0,0,0,0,80,'2023-08-25 13:57:19','2023-09-14 11:11:32',NULL,0),('修改配置',NULL,NULL,NULL,NULL,0,0,1,'2',14,'system.setting.save',0,1,0,0,0,0,81,'2023-12-29 23:11:33','2023-12-29 23:11:33',NULL,0),('字典配置',NULL,NULL,NULL,NULL,0,0,1,'2',10,'system.dict.save',0,1,0,0,0,0,82,'2023-12-29 23:14:03','2023-12-29 23:14:03',NULL,0),('字典删除',NULL,NULL,NULL,NULL,0,0,2,'2',10,'system.dict.del',0,1,0,0,0,0,83,'2023-12-29 23:14:31','2023-12-29 23:14:31',NULL,0),('系统公告',NULL,NULL,'views/Vadmin/notice/Notice','notice',0,0,7,'1',2,NULL,0,1,0,0,0,0,84,'2024-01-04 14:10:29','2024-01-04 14:16:50',NULL,0);
/*!40000 ALTER TABLE `vadmin_auth_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vadmin_auth_role`
--

DROP TABLE IF EXISTS `vadmin_auth_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vadmin_auth_role` (
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `role_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '权限字符',
  `disabled` tinyint(1) NOT NULL COMMENT '是否禁用',
  `order` int(11) DEFAULT NULL COMMENT '排序',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '描述',
  `is_admin` tinyint(1) NOT NULL COMMENT '是否为超级角色',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `create_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_datetime` datetime DEFAULT NULL COMMENT '删除时间',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否软删除',
  PRIMARY KEY (`id`),
  KEY `ix_vadmin_auth_role_name` (`name`),
  KEY `ix_vadmin_auth_role_role_key` (`role_key`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vadmin_auth_role`
--

LOCK TABLES `vadmin_auth_role` WRITE;
/*!40000 ALTER TABLE `vadmin_auth_role` DISABLE KEYS */;
INSERT INTO `vadmin_auth_role` VALUES ('管理员','admin',0,0,NULL,1,1,'2022-08-13 10:58:18','2022-10-09 15:03:34',NULL,0);
/*!40000 ALTER TABLE `vadmin_auth_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vadmin_auth_role_menus`
--

DROP TABLE IF EXISTS `vadmin_auth_role_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vadmin_auth_role_menus` (
  `role_id` int(11) DEFAULT NULL,
  `menu_id` int(11) DEFAULT NULL,
  KEY `menu_id` (`menu_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `vadmin_auth_role_menus_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `vadmin_auth_menu` (`id`) ON DELETE CASCADE,
  CONSTRAINT `vadmin_auth_role_menus_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `vadmin_auth_role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vadmin_auth_role_menus`
--

LOCK TABLES `vadmin_auth_role_menus` WRITE;
/*!40000 ALTER TABLE `vadmin_auth_role_menus` DISABLE KEYS */;
/*!40000 ALTER TABLE `vadmin_auth_role_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vadmin_auth_user`
--

DROP TABLE IF EXISTS `vadmin_auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vadmin_auth_user` (
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '头像',
  `telephone` varchar(11) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '手机号',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '邮箱地址',
  `name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '姓名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '昵称',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '密码',
  `gender` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '性别',
  `is_active` tinyint(1) NOT NULL COMMENT '是否可用',
  `is_reset_password` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已经重置密码，没有重置的，登陆系统后必须重置密码',
  `last_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '最后一次登录IP',
  `last_login` datetime DEFAULT NULL COMMENT '最近一次登录时间',
  `is_staff` tinyint(1) NOT NULL COMMENT '是否为工作人员',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `create_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_datetime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_datetime` datetime DEFAULT NULL COMMENT '删除时间',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否软删除',
  PRIMARY KEY (`id`),
  KEY `ix_vadmin_auth_user_name` (`name`),
  KEY `ix_vadmin_auth_user_telephone` (`telephone`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vadmin_auth_user`
--

LOCK TABLES `vadmin_auth_user` WRITE;
/*!40000 ALTER TABLE `vadmin_auth_user` DISABLE KEYS */;
INSERT INTO `vadmin_auth_user` VALUES ('avatar/170478542604oIV2lP.png','18975828726',NULL,'管理员','vv','$2b$12$nGks7QCj8J/TP00ExYkVou/abkA8rDONH8i2/8AGVxylTz7IHghUe','1',1,1,'127.0.0.1','2024-01-09 15:27:10',1,1,'2022-08-11 20:17:04','2024-01-09 15:30:30',NULL,0);
/*!40000 ALTER TABLE `vadmin_auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vadmin_auth_user_roles`
--

DROP TABLE IF EXISTS `vadmin_auth_user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vadmin_auth_user_roles` (
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  KEY `role_id` (`role_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `vadmin_auth_user_roles_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `vadmin_auth_role` (`id`) ON DELETE CASCADE,
  CONSTRAINT `vadmin_auth_user_roles_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `vadmin_auth_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vadmin_auth_user_roles`
--

LOCK TABLES `vadmin_auth_user_roles` WRITE;
/*!40000 ALTER TABLE `vadmin_auth_user_roles` DISABLE KEYS */;
INSERT INTO `vadmin_auth_user_roles` VALUES (1,1);
/*!40000 ALTER TABLE `vadmin_auth_user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vadmin_help_issue`
--

DROP TABLE IF EXISTS `vadmin_help_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vadmin_help_issue` (
  `category_id` int(11) NOT NULL COMMENT '类别',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '内容',
  `view_number` int(11) NOT NULL COMMENT '查看次数',
  `is_active` tinyint(1) NOT NULL COMMENT '是否可见',
  `create_user_id` int(11) NOT NULL COMMENT '创建人',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `create_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_datetime` datetime DEFAULT NULL COMMENT '删除时间',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否软删除',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `create_user_id` (`create_user_id`),
  KEY `ix_vadmin_help_issue_title` (`title`),
  CONSTRAINT `vadmin_help_issue_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `vadmin_help_issue_category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `vadmin_help_issue_ibfk_2` FOREIGN KEY (`create_user_id`) REFERENCES `vadmin_auth_user` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='常见问题记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vadmin_help_issue`
--

LOCK TABLES `vadmin_help_issue` WRITE;
/*!40000 ALTER TABLE `vadmin_help_issue` DISABLE KEYS */;
INSERT INTO `vadmin_help_issue` VALUES (4,'如何退出登录？','<p>请点击[我的] - [应用设置] - [退出登录]即可退出登录</p>',0,1,1,10,'2023-02-27 15:47:07','2023-08-03 00:31:24',NULL,0),(4,'如何修改用户头像？','<p>请点击[我的] - [选择头像] - [点击提交]即可更换用户头像</p>',0,1,1,11,'2023-02-27 15:47:18','2023-07-22 17:57:11',NULL,0),(4,'如何修改登录密码？','<p>请点击[我的] - [应用设置] - [修改密码]即可修改登录密码</p>',0,1,1,12,'2023-02-27 15:47:28','2023-08-04 17:41:52',NULL,0);
/*!40000 ALTER TABLE `vadmin_help_issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vadmin_help_issue_category`
--

DROP TABLE IF EXISTS `vadmin_help_issue_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vadmin_help_issue_category` (
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '类别名称',
  `platform` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '展示平台',
  `is_active` tinyint(1) NOT NULL COMMENT '是否可见',
  `create_user_id` int(11) NOT NULL COMMENT '创建人',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `create_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_datetime` datetime DEFAULT NULL COMMENT '删除时间',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否软删除',
  PRIMARY KEY (`id`),
  KEY `create_user_id` (`create_user_id`),
  KEY `ix_vadmin_help_issue_category_name` (`name`),
  KEY `ix_vadmin_help_issue_category_platform` (`platform`),
  CONSTRAINT `vadmin_help_issue_category_ibfk_1` FOREIGN KEY (`create_user_id`) REFERENCES `vadmin_auth_user` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='常见问题类别表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vadmin_help_issue_category`
--

LOCK TABLES `vadmin_help_issue_category` WRITE;
/*!40000 ALTER TABLE `vadmin_help_issue_category` DISABLE KEYS */;
INSERT INTO `vadmin_help_issue_category` VALUES ('常见问题','1',1,1,4,'2023-02-27 15:45:35','2023-02-27 15:45:35',NULL,0);
/*!40000 ALTER TABLE `vadmin_help_issue_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vadmin_notice`
--

DROP TABLE IF EXISTS `vadmin_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vadmin_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '标题',
  `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '内容',
  `begin_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='系统运营公告';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vadmin_notice`
--

LOCK TABLES `vadmin_notice` WRITE;
/*!40000 ALTER TABLE `vadmin_notice` DISABLE KEYS */;
INSERT INTO `vadmin_notice` VALUES (12,'测试公告','测试公告内容','2024-01-05 00:00:00','2024-01-19 00:00:00','2024-01-06 17:38:34','2024-01-06 17:41:19');
/*!40000 ALTER TABLE `vadmin_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vadmin_record_login`
--

DROP TABLE IF EXISTS `vadmin_record_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vadmin_record_login` (
  `telephone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '手机号',
  `status` tinyint(1) NOT NULL COMMENT '是否登录成功',
  `platform` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '登陆平台',
  `login_method` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '认证方式',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '登陆地址',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '登陆地点',
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国家',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '县',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '城市',
  `county` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '区/县',
  `operator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '运营商',
  `postal_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '邮政编码',
  `area_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '地区区号',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '浏览器',
  `system` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '操作系统',
  `response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '响应信息',
  `request` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '请求信息',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `create_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_datetime` datetime DEFAULT NULL COMMENT '删除时间',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否软删除',
  PRIMARY KEY (`id`),
  KEY `ix_vadmin_record_login_telephone` (`telephone`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='登录记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vadmin_record_login`
--

LOCK TABLES `vadmin_record_login` WRITE;
/*!40000 ALTER TABLE `vadmin_record_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `vadmin_record_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vadmin_record_sms_send`
--

DROP TABLE IF EXISTS `vadmin_record_sms_send`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vadmin_record_sms_send` (
  `user_id` int(11) NOT NULL COMMENT '操作人',
  `status` tinyint(1) NOT NULL COMMENT '发送状态',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '发送内容',
  `telephone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '目标手机号',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '失败描述',
  `scene` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '发送场景',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `create_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_datetime` datetime DEFAULT NULL COMMENT '删除时间',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否软删除',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `vadmin_record_sms_send_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `vadmin_auth_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='短信发送记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vadmin_record_sms_send`
--

LOCK TABLES `vadmin_record_sms_send` WRITE;
/*!40000 ALTER TABLE `vadmin_record_sms_send` DISABLE KEYS */;
/*!40000 ALTER TABLE `vadmin_record_sms_send` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vadmin_resource_images`
--

DROP TABLE IF EXISTS `vadmin_resource_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vadmin_resource_images` (
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '原图片名称',
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '图片链接',
  `create_user_id` int(11) NOT NULL COMMENT '创建人',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `create_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_datetime` datetime DEFAULT NULL COMMENT '删除时间',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否软删除',
  PRIMARY KEY (`id`),
  KEY `create_user_id` (`create_user_id`),
  CONSTRAINT `vadmin_resource_images_ibfk_1` FOREIGN KEY (`create_user_id`) REFERENCES `vadmin_auth_user` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='图片素材表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vadmin_resource_images`
--

LOCK TABLES `vadmin_resource_images` WRITE;
/*!40000 ALTER TABLE `vadmin_resource_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `vadmin_resource_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vadmin_system_dict_details`
--

DROP TABLE IF EXISTS `vadmin_system_dict_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vadmin_system_dict_details` (
  `label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '字典标签',
  `value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '字典键值',
  `disabled` tinyint(1) NOT NULL COMMENT '字典状态，是否禁用',
  `is_default` tinyint(1) NOT NULL COMMENT '是否默认',
  `order` int(11) NOT NULL COMMENT '字典排序',
  `dict_type_id` int(11) NOT NULL COMMENT '关联字典类型',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `create_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_datetime` datetime DEFAULT NULL COMMENT '删除时间',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否软删除',
  PRIMARY KEY (`id`),
  KEY `dict_type_id` (`dict_type_id`),
  KEY `ix_vadmin_system_dict_details_label` (`label`),
  KEY `ix_vadmin_system_dict_details_value` (`value`),
  CONSTRAINT `vadmin_system_dict_details_ibfk_1` FOREIGN KEY (`dict_type_id`) REFERENCES `vadmin_system_dict_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='字典详情表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vadmin_system_dict_details`
--

LOCK TABLES `vadmin_system_dict_details` WRITE;
/*!40000 ALTER TABLE `vadmin_system_dict_details` DISABLE KEYS */;
INSERT INTO `vadmin_system_dict_details` VALUES ('男','0',0,0,0,1,NULL,2,'2022-10-07 12:07:43','2022-10-07 12:08:02',NULL,0),('女','1',0,0,1,1,NULL,4,'2022-10-08 13:55:32','2022-10-08 13:55:32',NULL,0),('目录','0',0,1,0,2,NULL,5,'2022-10-08 14:05:15','2022-10-08 14:05:38',NULL,0),('菜单','1',0,0,1,2,NULL,6,'2022-10-08 14:05:24','2022-10-08 14:05:24',NULL,0),('按钮','2',0,0,2,2,NULL,7,'2022-10-08 14:05:32','2022-10-08 14:05:32',NULL,0),('密码登录','0',0,0,0,3,NULL,8,'2022-12-03 23:48:33','2022-12-03 23:48:33',NULL,0),('短信登录','1',0,0,1,3,NULL,9,'2022-12-03 23:48:47','2022-12-03 23:48:47',NULL,0),('PC端管理系统','0',0,0,0,4,NULL,10,'2022-12-03 23:49:24','2022-12-03 23:49:24',NULL,0),('移动端管理系统','1',0,0,1,4,NULL,11,'2022-12-03 23:49:41','2022-12-03 23:49:41',NULL,0),('微信一键登录','2',0,0,2,3,NULL,12,'2023-02-23 22:48:57','2023-02-23 22:53:26',NULL,0),('时间间隔(interval)','interval',0,0,0,5,NULL,14,'2023-06-25 16:56:10','2023-06-26 15:52:15',NULL,0),('Cron 表达式','cron',0,0,1,5,NULL,15,'2023-06-25 16:57:28','2023-06-25 16:57:28',NULL,0),('指定日期时间(date)','date',0,0,2,5,NULL,16,'2023-06-25 16:57:41','2023-06-26 15:52:25',NULL,0);
/*!40000 ALTER TABLE `vadmin_system_dict_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vadmin_system_dict_type`
--

DROP TABLE IF EXISTS `vadmin_system_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vadmin_system_dict_type` (
  `dict_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '字典名称',
  `dict_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '字典类型',
  `disabled` tinyint(1) NOT NULL COMMENT '字典状态，是否禁用',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `create_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_datetime` datetime DEFAULT NULL COMMENT '删除时间',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否软删除',
  PRIMARY KEY (`id`),
  KEY `ix_vadmin_system_dict_type_dict_name` (`dict_name`),
  KEY `ix_vadmin_system_dict_type_dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vadmin_system_dict_type`
--

LOCK TABLES `vadmin_system_dict_type` WRITE;
/*!40000 ALTER TABLE `vadmin_system_dict_type` DISABLE KEYS */;
INSERT INTO `vadmin_system_dict_type` VALUES ('性别','sys_vadmin_gender',0,NULL,1,'2022-10-05 22:03:43','2022-10-08 13:57:16',NULL,0),('菜单类型','sys_vadmin_menu_type',0,NULL,2,'2022-10-08 13:57:32','2022-10-08 13:57:32',NULL,0),('认证方式','sys_vadmin_login_method',0,NULL,3,'2022-12-03 23:48:09','2022-12-03 23:48:09',NULL,0),('登录平台','sys_vadmin_platform',0,NULL,4,'2022-12-03 23:49:11','2022-12-03 23:49:11',NULL,0),('定时任务执行策略','vadmin_system_task_exec_strategy',0,'与定时任务中有约定，请勿随意更改',5,'2023-06-25 16:55:20','2023-06-30 09:23:29',NULL,0);
/*!40000 ALTER TABLE `vadmin_system_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vadmin_system_settings`
--

DROP TABLE IF EXISTS `vadmin_system_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vadmin_system_settings` (
  `config_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '配置表标签',
  `config_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '配置表键',
  `config_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '配置表内容',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注信息',
  `disabled` tinyint(1) NOT NULL COMMENT '是否禁用',
  `tab_id` int(11) NOT NULL COMMENT '关联tab标签',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `create_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_datetime` datetime DEFAULT NULL COMMENT '删除时间',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否软删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_vadmin_system_settings_config_key` (`config_key`),
  KEY `tab_id` (`tab_id`),
  CONSTRAINT `vadmin_system_settings_ibfk_1` FOREIGN KEY (`tab_id`) REFERENCES `vadmin_system_settings_tab` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='系统配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vadmin_system_settings`
--

LOCK TABLES `vadmin_system_settings` WRITE;
/*!40000 ALTER TABLE `vadmin_system_settings` DISABLE KEYS */;
INSERT INTO `vadmin_system_settings` VALUES ('系统标题','web_title','一站式指数基金投资平台',NULL,0,1,1,'2022-10-31 20:47:43','2024-01-08 22:26:22',NULL,0),('系统LOGO','web_logo','/media/system/logo.png',NULL,0,1,2,'2022-10-31 20:47:43','2024-01-08 22:26:22',NULL,0),('系统描述','web_desc','提供全球主流指数数据、指数基金、资产配置服务',NULL,0,1,3,'2022-10-31 20:47:43','2024-01-08 22:26:22',NULL,0),('ICO图标','web_ico','/media/system/favicon.ico',NULL,0,1,4,'2022-10-31 20:47:43','2023-01-16 18:10:07',NULL,0),('备案号','web_icp_number','粤ICP备20006224号',NULL,0,1,5,'2022-10-31 20:47:43','2024-01-08 22:26:22',NULL,0),('版权信息','web_copyright','Copyright ©2024-present 静远资产配置',NULL,0,1,6,'2022-10-31 20:47:43','2024-01-08 22:26:22',NULL,0),('百度统计代码','web_baidu',NULL,'（当前无法生效，已停用该配置）不包含<script>标签，只需要复制<script>标签内的内容即可',1,2,7,'2022-10-31 20:49:58','2022-11-22 16:35:43',NULL,0),('隐私协议','web_privacy','<p>静远资产配置助手（以下或称“我们”）深知个人信息对您的重要性，我们会尽全力保护您的个人信息及隐私安全。在您使用我们所提供的产品及/或服务（以下简称“我们的服务”）时，为了履行法定义务，或者为了向您提供服务所必需，或者为了不断优化用户体验，以及提供更安全的互联网环境，我们根据相关法律法规及技术规范等制定《隐私政策》（以下简称“本政策”），明确我们在收集、使用、管理及保护您的个人信息方面的原则及具体措施。</p><p><br></p><p>本政策适用于包括但不限于网站、小程序、H5、组件、widget等随技术发展出现的新形态所向您提供的各项产品及/或服务，无论您是通过计算机设备、移动终端还是其他设备获得我们的服务。</p><p><br></p><p>请您了解，本政策中所述客户端及相关服务可能会根据您装载客户端设备的型号、系统版本、浏览器版本、软件应用程序版本等因素而有所不同。最终的产品及/或服务以您实际使用的客户端为准。</p><p><br></p><p>目录</p><p>一、我们如何收集和使用您的个人信息</p><p><br></p><p>二、我们如何使用 Cookie 和同类技术</p><p><br></p><p>三、我们如何委托处理、共享、转让、公开披露您的个人信息</p><p><br></p><p>四、我们如何保护您的个人信息</p><p><br></p><p>五、您如何管理您的个人信息</p><p><br></p><p>六、本政策如何更新</p><p><br></p><p>七、如何联系我们</p><p><br></p><p>八、其他</p><p><br></p><p>一、我们如何收集和使用您的个人信息</p><p>您理解并同意，个人信息指单独使用或结合其他信息共同使用时能够确定个人身份的信息。您在使用我们的服务、与我们互动时，我们可能会收集您主动提供或者因使用我们的服务而产生的个人信息。根据您使用的产品及/或服务以及您与我们互动的不同，具体收集的数据类型也将有所不同。请您知悉，您并非必须向我们提供个人信息，您拒绝提供使用各项功能所必须的个人信息时，仍可以使用其他功能；但在某些情况下，如果您选择不提供，我们可能无法为您提供相关产品及/或服务，也无法回应或解决您所遇到的问题。</p><p><br></p><p>我们会遵循合法、正当、最小必要、公开透明的原则，收集和使用您的个人信息。为不断完善用户体验，我们会不断迭代或调整我们的服务，并因此可能需要收集新的个人信息或变更个人信息使用目的或方式。如前述过程中出现超出了与收集您的个人信息时所声称的目的或用途的，我们将以合理的方式向您告知，并在收集和使用前再次征得您的同意。</p><p><br></p><p>具体业务功能场景包括：</p><p><br></p><p>注册及登录账号</p><p>1.1 当您注册账号成为我们的用户后，才可以使用我们服务，包括但不限于创建资产账户、资产账户分析统计、创建标签组等。</p><p><br></p><p>1.2 当您注册及登录时，我们需要收集您的手机号码和网络运营商信息、验证码匹配结果，并创建账号UID。</p><p><br></p><p>如您使用第三方平台账号（如微信账号）进行登录，我们将根据您的授权获取该第三方账号的相关信息（包括：用户名、昵称、头像，具体以您的授权内容为准）。如您拒绝授权此类信息，您将无法使用第三方平台的账号登录，但不影响您使用手机号登陆并正常使用我们提供的服务。</p><p><br></p><p>当您成功注册静远资产配置助手账号后，我们将会在静远资产配置助手平台显示您的昵称、头像和简介信息。</p><p><br></p><p>1.3 请您谨慎考虑后提供上述信息，如您拒绝提供，我们将不会产生个人信息主体被识别或者关联的结果，但是会导致服务无法使用。</p><p><br></p><p>1.4 您提供的上述信息，将在您使用我们提供的服务期间持续授权我们收集和使用。当您注销账号时，我们将停止使用并删除上述信息。</p><p><br></p><p><br></p><p>资产管理功能</p><p>2.1 当您使用我们的资产管理功能时，我们会收集您自愿提供的个人资产数据等个人敏感信息，并进行加工处理和分析，以便向您提供更好的资产账户数据展示及账户分析等服务。帮助您生成资产账户、进行资产管理、收益查看、收益率统计、资产分组统计等。如您不再想提供此类信息，您可以随时随地自行删除相关数据。</p><p><br></p><p><br></p><p>二、我们如何使用 Cookie 和同类技术</p><p>当您使用我们的服务时，我们可能会保存您的登录状态，并且为您分配一个或多个“Cookie”小数据文件。Cookie 通常包含标识符、站点名称以及一些号码和字符。借助于 Cookie 我们将记录您的登录信息及在应用程序中的操作信息，以便我们存储您的偏好及使用习惯，避免您频繁操作造成使用不便，并帮助判断您的账户安全状态，以为您提供更方便、快捷、顺畅的用户体验和服务。您并不需要额外做任何工作，所有的收集、保存和加密工作都由系统自动完成。</p><p><br></p><p>我们不会将 Cookie 用于本政策所述目的之外的任何用途。您可根据自己的偏好管理或停用Cookie。有关详情，请参考 AboutCookies.org。如果停用 Cookie，您有可能无法享受最佳的服务体验，但不影响您正常使用我们提供的其他服务。</p><p><br></p><p>三、我们如何共享、转让、公开披露您的个人信息</p><p>共享</p><p>我们不会与任何公司、组织和个人分享您的个人信息，但以下情形除外：</p><p><br></p><p>(1) 您自行提出，或事先获得您的明确同意；</p><p><br></p><p>(2) 根据法律法规规定，或按政府主管部门的强制性要求；</p><p><br></p><p>(3) 依据您与我们关于个人信息提供的其他约定或者在具体场景下取得您的单独同意；</p><p><br></p><p><br></p><p>转让</p><p>我们不会将您的个人信息转让给第三方，但以下情形除外：</p><p><br></p><p>(1) 您自行提出，或事先获得您的明确同意；</p><p><br></p><p>(2) 在涉及合并、分立、解散、收购或破产清算时，如涉及向第三方转让您的个人信息，我们会在要求新的持有您个人信息的第三方继续受本政策的约束，否则我们将要求该等第三方重新向您取得授权同意。</p><p><br></p><p>公开披露</p><p>我们原则上不会对外公开披露所收集的个人信息，但以下情形除外：</p><p><br></p><p>(1) 您自行提出，或事先获得您明确同意；</p><p><br></p><p>(2) 在法律、司法程序、诉讼或政府主管部门强制性要求的情况下，我们可能会依据所要求的个人信息类型和披露方式公开披露您的个人信息。在可行的限度内，当我们收到上述披露信息的请求时，我们会要求请求方出具与之相应的法律文件，如传票或调查函等；</p><p><br></p><p>(3) 法律法规规定的其他情形。</p><p><br></p><p>事先征得授权同意的例外情形</p><p>根据相关法律法规，符合以下任一情形，我们处理您的个人信息无需征得您的同意：</p><p><br></p><p>(1) 为订立、履行您与我们之间的合同所必需，或者按照依法制定的劳动规章制度和依法签订的集体合同实施人力资源管理所必需；</p><p><br></p><p>(2) 为履行法定职责或者法定义务所必需；</p><p><br></p><p>(3) 为应对突发公共卫生事件，或者紧急情况下为保护您或其他自然人的生命健康和财产安全所必需；</p><p><br></p><p>(4) 为公共利益实施新闻报道、舆论监督等行为，在合理的范围内处理您的个人信息；</p><p><br></p><p>(5) 依照相关法律规定，在合理的范围内处理您自行公开或者其他已经合法公开的个人信息；</p><p><br></p><p>(6) 法律法规规定的其他无需征得您同意的情形。</p><p><br></p><p>请您了解，根据相关法律规定，共享、转让、公开披露经去标识化处理的个人信息，且确保数据接收方无法复原并重新识别个人信息主体的，我们对此类数据的处理将无需另行向您通知并征得您的同意。我们已知晓对外共享、转让、公开披露个人信息所承担的相应法律责任，并将采取合理措施保障个人信息安全。</p><p><br></p><p>四、我们如何保护您的个人信息</p><p>存储</p><p>1.1 存储地点：我们将在中华人民共和国境内收集到的个人信息存储于中华人民共和国境内，并依法对这些信息进行严格保密。</p><p><br></p><p>目前我们暂时不存在向境外提供个人信息的场景。 如未来我们因业务需要等，确需向中华人民共和国境外提供个人信息的，我们应具备相关法律规定的条件（通过国家网信部门组织的安全评估或按照国家网信部门制定的标准合同与境外接收方订立合同，约定双方的权利和义务等），并将向您告境外接收方的名称或者姓名、联系方式、处理目的、处理方式、个人信息的种类以及您向境外接收方行使个人信息主体权利的方式和程序等事项，取得您的单独同意。我们将采取必要措施，保障境外接收方处理个人信息的活动达到中国法律规定的个人信息保护标准。</p><p><br></p><p>1.2 存储期限：我们承诺始终按照法律规定，在实现您的个人信息处理目的所必要的最短时间内存储您的个人信息。超出上述期限后，我们会对您的个人信息进行删除或匿名化处理。</p><p><br></p><p>1.3 如我们的服务停止运营，或者您主动注销静远资产配置账号并终止使用我们的服务，我们将会停止处理您的个人信息，法律法规或监管部门另有规定的除外。</p><p><br></p><p>保护</p><p>2.1 为了保障您的信息安全，我们已在现有技术水平下使用符合业界标准的安全防护措施保护您的个人信息，采取物理防护、安全技术、管理制度等措施来降低未经授权访问、公开披露、使用、修改、损坏或丢失的风险。例如，我们会使用加密技术确保数据的保密性；我们会使用受信赖的保护机制防止数据遭到恶意攻击；我们会部署访问控制机制，确保只有授权人员才可访问个人信息；以及我们会举办安全和隐私保护培训课程，加强员工对于保护个人信息重要性的认识。</p><p><br></p><p>2.2 若发生或可能发生个人信息泄露、篡改、丢失等个人信息安全事件，我们会启动个人信息安全事件应急预案，阻止个人信息安全事件扩大。除非我们采取措施能够有效避免信息泄露、篡改、丢失造成危害的，我们将及时以推送通知、邮件等形式告知您个人信息安全事件的基本情况、我们即将或已经采取的处置措施和补救措施，以及我们对您的应对建议。</p><p><br></p><p>五、您如何管理您的个人信息</p><p>我们非常重视并尽全力保障您对个人信息的相关权利。</p><p><br></p><p>访问您的个人信息</p><p>除法律法规另有规定外，您有权访问您的个人信息。如果您想行使数据访问权，可以通过以下方式自行访问：</p><p><br></p><p>(1) 访问头像、昵称、手机号等基本信息：</p><p><br></p><p>通过【个人中心-个人信息】进行查询和访问；</p><p><br></p><p>(2) 访问手机号、密码：</p><p><br></p><p>通过【个人中心-个人信息】进行查询和访问。</p><p><br></p><p><br></p><p><br></p><p>更正您的个人信息</p><p>2.1 当您需要更改您的个人信息时，您可以通过上述“1. 访问您的个人信息”中罗列的方式进行更改。</p><p><br></p><p><br></p><p>删除您的个人信息</p><p>3.1 您在我们的服务时，可以直接删除相关信息，如资产账户、资产信息等。</p><p><br></p><p>3.2 除法律法规另有规定外，有下列情形之一的，我们将主动删除您的个人信息，您可以向我们提出删除个人信息的请求：</p><p><br></p><p>(1) 我们对您的个人信息的处理目的已实现、无法实现或者为实现处理目的不再必要；</p><p><br></p><p>(2) 我们停止提供服务，或者保存期限已届满；</p><p><br></p><p>(3) 您撤回此前向我们做出的同意；</p><p><br></p><p>(4) 我们违反法律、行政法规或与您的约定处理您的个人信息；</p><p><br></p><p>(5) 法律、行政法规规定的其他应当删除个人信息的情形。</p><p><br></p><p>3.3 由于法律法规规定的存储期限未届满，或者删除从技术上难以实现的，我们可能无法立即从系统中删除相应的信息，此时我们将对您的个人信息停止除存储和采取必要的安全保护措施之外的处理。</p><p><br></p><p><br></p><p>注销账户</p><p>如果您需要注销账户，您随时可以自行操作【个人中心-个人信息-注销】。账户注销后，将删除您的个人信息，但法律法规或监管机构另有规定需要留存的除外，且在依法保存的时间内国家机关仍有权依法查询。需要注意的是，一旦您申请注销静远资产配置助手账号，您将无法继续使用我们的服务，请您谨慎操作。</p><p><br></p><p><br></p><p>七、如何联系我们</p><p>如您对于本政策或相关事宜有任何疑问、投诉、建议等，特别是认为我们的个人信息处理行为损害了您的合法权益，您可随时通过以下方式联系我们。我们将在法律法规规定的期限内及时受理您的请求，并予以回复。</p><p><br></p><p> 发送邮件：bumishi@foxmail.com。</p><p><br></p>',NULL,0,4,8,'2022-11-04 13:50:21','2024-01-09 11:20:57',NULL,0),('用户协议','web_agreement','<p>《用户协议》（以下简称“本协议”）是由您与静远一站式指数基金资产配置平台（以下简称“静远资产配置助手”）以数据电文形式共同缔结的协议，请您务必审慎阅读、充分理解各条款内容，限制、免责条款可能以黑体加粗形式提示您注意。当您在线点击/勾选“同意”或“接受”键后，视为您已详细阅读并同意遵守本协议，本协议生效，则静远资产配置助手根据本协议为您提供网上服务。因此，除非您已阅读并接受本协议所有条款，否则您无权使用静远资产配置助手网上服务。</p><p>若您未满18周岁，请在法定监护人的陪同下阅读本协议，并特别注意未成年人使用条款。</p><p> &nbsp; &nbsp;有权在必要时更新协议内容并以通知、公告、声明或其它形式通知您。若您不同意修改内容，应立即停止使用相关服务；否则，您的任何对相关服务的登录、查看、使用等行为将被视为您对修改内容的理解和接受。</p><p>1.定义</p><p>如无特别说明，下列术语在本协议中的含义为：</p><p>1.1.您：指注册成功并使用静远资产配置助手网上服务的完全民事行为能力人，又称“学员”或“用户”。</p><p>1.2.静远资产配置助手：是本平台在本协议中的简称。</p><p>1.3.网上服务：指由静远资产配置助手运营的、通过计算机客户端、网页端、移动端等端口向您提供的各项网上服务的统称。</p><p>1.4.静远资产配置助手网络平台：是指静远资产配置助手借以向您提供各项网上服务的综合服务系统。</p><p>1.5.静远资产配置助手组成元素：指静远资产配置助手各端口页面所包含的及与静远资产配置助手相关的软件、文字、图片、音频、视频、图标、标识、界面设计、版面框架、编排方式、有关数据或电子文档等内容和信息。</p><p>1.6.本协议：指《用户注册协议》正文及其修订版本。上述内容一经正式发布，即为本协议不可分割的组成部分。</p><p>2.注册账号</p><p>2.1.您将在完成注册程序后获得静远资产配置助手网上服务的账号。您享有该账号的使用权。静远资产配置助手享有该账号的所有权。静远资产配置助手有权对账号的权限设计进行调整。</p><p>2.2.静远资产配置助手有理由认为该账号下的所有行为都是您的真实意思表示。您享有该账号下行为产生的所有权利，同时应承担该账号下所有行为及事件产生的义务及责任。若您账号下的行为对您、静远资产配置助手或第三方造成的损害，您将负全部责任。</p><p>若该账号通过静远资产配置助手网上服务展示任何违法、不道德或静远资产配置助手认为不合适的资料；或者静远资产配置助手有理由怀疑该资料属于程序或恶意操作，静远资产配置助手有权暂停或终止您的帐号，并拒绝您于现在和未来使用本服务之全部或任何部分。</p><p>2.3.账号的取得</p><p>2.3.1.您应当按照静远资产配置助手网络平台注册页面的要求完成注册程序，并保证填写的个人信息与您的身份信息一致，否则静远资产配置助手有权拒绝向您提供相关服务或承担任何义务。</p><p>2.3.2.除非您在个人信息中填写真实身份信息，否则您无权购买静远资产配置助手提供的网上付费服务（例如购买课程、题库等）。</p><p>2.3.3.静远资产配置助手有权核实您注册账号时所提供的身份信息是否真实、有效。若您违反注册要求，未使用您本人的真实身份信息进行注册，静远资产配置助手有权随时关闭您的账号。</p><p>2.3.4.静远资产配置助手有权采取技术与管理等合理措施保障您账号的安全、有效。</p><p>2.4.授权协助注册</p><p>若您在注册过程中主动向静远资产配置助手或其工作人员寻求支持和帮助，则您提出要求及指示的行为即视为您对静远资产配置助手协助您注册账号的委托授权，因此产生的后果及责任由您承担。</p><p>2.5.注册信息的修改</p><p>若您在注册成功并获得静远资产配置助手网络平台的账号后，需要修改注册信息，请按照静远资产配置助手出于安全考虑设置的相关修改程序操作。若静远资产配置助手有合理理由怀疑您提交的相关资料或信息属于恶意程序或恶意操作，则静远资产配置助手有权关闭您的账号，并有权拒绝您于现在和将来使用静远资产配置助手所提供服务之全部或任何部分。</p><p>2.6.账号的使用和保管</p><p>2.6.1.您有义务妥善保管并安全使用您的账号及密码并承担相关责任。若您未保管好自己的帐号和密码，因此而产生的任何损失或损害，静远资产配置助手无法也不承担任何责任。</p><p>2.6.2.若您发现您的账号使用出现异常（被他人盗用等任何安全问题），应立即通知静远资产配置助手并提供您的个人有效身份信息以供核实账户身份。经核实身份一致的，静远资产配置助手应当及时采取措施暂停该账号的登录和使用；身份不一致或者您拒绝提供个人有效身份证明的，静远资产配置助手有权拒绝您提出的关于该账号的管理请求。</p><p>2.6.3.您在静远资产配置助手注册的账号，仅限您个人使用，不得将账号与第三人共享或将账号转让、赠与他人等。否则，静远资产配置助手有权关闭您的账号。</p><p>2.7.若静远资产配置助手发现您的帐号存在异常状况(包括但不限于异地登陆、IP地址异常变动、发送注册信息变更请求等)，静远资产配置助手则有权依据其合理判断采取相应措施(包括但不限于要求用户进行手机实名认证、进行面部识别等)以保护帐号安全。</p><p>3.服务内容</p><p>3.1.基于自身的经营自主权，静远资产配置助手有权自主决定通过互联网提供的服务（产品）类型及内容。</p><p>静远资产配置助手网上服务目前包含以下内容：</p><p>3.1.1.基础服务：即静远资产配置助手网络平台上提供的非付费的网上服务，包括：指数信息查询、指数数据分析、指数基金数据分析、投资组合相关的账号管理、资产管理、收益分析等。</p><p>3.1.2.其他服务：静远资产配置助手通过网络平台为您提供的其他服务。</p><p>3.2.静远资产配置助手网上服务的具体内容以静远资产配置助手在您使用时实际提供给您的情况和版本为准。</p><p>3.3.静远资产配置助手在此许可您依本协议而获得静远资产配置助手网上服务之基础服务的使用权。</p><p>3.4.除非另有其它明示规定，静远资产配置助手网络平台内所增加或强化的任何新功能，包括所推出的新产品，均受到本使用协议之规范。</p><p>3.5.静远资产配置助手有随时调整各项服务费用收取标准的权利，但已完成支付的订单不受影响；您有权自主决定是否购买静远资产配置助手提供的网上增值服务（产品）。</p><p>3.6.针对增值服务(付费类课程产品和服务)的特别约定</p><p>用户可根据自身实际需求选择免费服务（产品）或有偿、付费服务（产品）。针对有偿课程服务（产品），用户请注意下述特别事项：</p><p>3.6.1.您可通过静远资产配置助手的计算机客户端、网页端、移动端等端口购买静远资产配置助手提供的有偿服务（产品）。根据您所订购产品的具体信息(以订购当时静远资产配置助手官网公示为准)，包括但不限于课程内容、课程安排、价格、退款政策等，在您支付完成后，将由静远资产配置助手系统后台生成1份电子订单，该电子订单系本协议之有效组成部分，是确定用户与静远资产配置助手各自权利义务的有效依据。支付完成后您即可根据所购买课程享受静远资产配置助手提供的各项服务。静远资产配置助手针对部分课程，可能会需要向您邮寄提供教材、讲义等课程资料，因此请您在提交订单前务必仔细核对收货人、收货地址及联系电话等信息。收货人与用户本人不一致的，收货人的行为和意思表示即视为用户的行为和意思表示，用户应对收货人的行为及意思表示的法律后果承担连带责任。</p><p>3.6.2.静远资产配置助手的任何一个帐号都只能由同一个用户使用，禁止多个用户使用同一个帐号。若静远资产配置助手有合理理由认为您的账号可能存在用户帐号被盗取、被盗用情形的，则静远资产配置助手有权将此帐号暂时或永久作无效处理并保留追究法律责任的权利。若您将帐号借给他人使用，您应承担由此产生的全部责任，并与实际使用人承担连带责任。</p><p>4.双方权利义务</p><p>4.1.静远资产配置助手仅负责通过网络平台向您提供网上服务，除此之外与相关网络服务有关的设备(如个人电脑、手机、及其他与接入互联网或移动网有关的装置)及所需的费用(如为接入互联网而支付的电话费及上网费、为使用移动网而支付的手机费)均应由您自行负担。</p><p>4.2.您在静远资产配置助手网络平台享有的部分网上服务（包括但不限于付费课程）可能受到有效期的限制，一旦有效期届满，该服务将会自动失效。请您在付费前仔细阅读相关条款。</p><p>4.3.您可以选择购买静远资产配置助手提供的增值（付费）服务。您应当在付费前仔细阅读并同意关于该付费服务的相关条款，包括但不限于按照静远资产配置助手的要求进行实名认证并同意将所填写的信息交由第三方机构进行校验。您应保证您所提供的资料和信息是真实、完整、有效的。</p><p>4.4.若您选择通过第三方支付平台等方式进行费用支付，在支付过程中因您自身原因或第三方支付平台原因造成的异常使您的帐号无法正常使用或遭受损失的，静远资产配置助手对此概不负责。</p><p>4.5.静远资产配置助手对于其通过网络平台所提供的网上服务的种类及内容拥有自主权。静远资产配置助手有权随时更改经营模式、管理应用程序及内部功能。</p><p>4.6.静远资产配置助手可能会通过应用官方网站、客服电话、管理员、或者其他的途径，向您提供诸如功能介绍、帐号申诉等客户服务，以上服务的提供应建立在以下前提条件之上：</p><p>(1)您应通过静远资产配置助手客服官方网站或者提供的其他途径了解这些客户服务的内容、要求以及资费，谨慎选择是否需要享受相应的客户服务，向静远资产配置助手真实地准确地表达您的需求；</p><p>(2)您应同意并接受静远资产配置助手关于该等客户服务的专门协议或条款。</p><p>4.7.为高效利用服务器资源，若您长期未使用账号登录静远资产配置助手网站，静远资产配置助手有权视需要，在提前通知的情况下，对该账号及其账号下的数据及相关信息采取删除等处置措施，上述处置可能导致您对该账号下相关权益的丧失，对此静远资产配置助手不承担任何责任。</p><p>4.8.您充分理解并同意接受静远资产配置助手通过短信或其他方式向您发送静远资产配置助手的相关商业信息。如您希望停止接收相关信息，可通过静远资产配置助手官方网站公布的联系方式与静远资产配置助手联系，静远资产配置助手将在核实您的身份后取消推送。</p><p>5.用户行为规范</p><p>5.1.您除了可以按照本协议的约定使用静远资产配置助手网上服务之外，不得进行任何侵犯静远资产配置助手及组成元素相关的知识产权的行为，也不得进行任何其他有损于静远资产配置助手或其他第三方合法权益的行为。</p><p>5.2.您仅可为非商业目的使用静远资产配置助手网上服务，包括但不限于接收、下载、安装、启动、升级、登录、显示、运行和/或截屏静远资产配置助手网站服务。</p><p>5.3.您不得以任何形式公开静远资产配置助手提供的网上课程（包括但不限于向任何第三方透露学习课程、与他人共享账号、将自己的账号提供给第三方使用、将学习课程公开播放或以任何方式供多人同时使用）。上述情况一经发现，静远资产配置助手有权立即关闭相应账号的学习权限，同时静远资产配置助手会进一步追究您违规使用账号引起的法律责任。</p><p>5.4.在使用静远资产配置助手网上服务的过程中，您必须遵守相关服务的具体使用规则，同时遵守以下基本行为规范，否则，静远资产配置助手有权立即关闭相应账号的学习权限，并进一步追究您行为的法律责任。</p><p>(1)不得为任何非法目的而使用网络服务系统；</p><p>(2)遵守所有与网络服务有关的网络协议、规定和程序；</p><p>(3)不得利用静远资产配置助手网络平台进行任何可能对互联网的正常运转造成不利影响的行为；</p><p>(4)不得利用静远资产配置助手网络平台进行任何对该平台不利的行为。</p><p>5.5.您应当保证对您所发表或者上传于静远资产配置助手网络平台的所有信息(即属于《中华人民共和国著作权法》规定的作品，包括但不限于文字、图片、音乐、电影、表演和录音录像制品和电脑程序等)均享有完整的知识产权，或者已经得到相关权利人的合法授权；若您违反本条规定造成本公司被第三人索赔的，您应全额补偿本公司一切费用(包括但不限于各种赔偿费、诉讼代理费及为此支出的其它合理费用)；当第三方认为您发表或者上传于静远资产配置助手网络平台的信息侵犯其权利，并根据《信息网络传播权保护条例》或者相关法律规定向本公司发送权利通知书时，您同意本公司可以自行判断决定删除涉嫌侵权信息，除非您提交书面证据材料排除侵权的可能性，本公司将不会自动恢复上述删除的信息。</p><p>5.6.若因您违反本协议或相关服务条款的规定，导致或产生第三方主张的任何索赔、要求或损失，您应当独立承担责任；静远资产配置助手因此遭受损失的，您也应当一并赔偿。</p><p>5.7.您必须严格遵守中华人民共和国相关法律法规，包括但不限于《中华人民共和国计算机信息系统安全保护条例》、《计算机软件保护条例》、《最高人民法院关于审理涉及计算机网络著作权纠纷案件适用法律若干问题的解释(法释[2004]1号)》、《全国人大常委会关于维护互联网安全的决定》、《互联网电子公告服务管理规定》、《互联网新闻信息服务管理规定》、《互联网著作权行政保护办法》和《信息网络传播权保护条例》等有关计算机互联网规定和知识产权的法律和法规、实施办法。</p><p>5.8.您不得在使用静远资产配置助手网上服务的过程中在静远资产配置助手网络平台的任何页面发布、转载、传送含有下列内容之一的信息：</p><p>（1）危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；</p><p>（2）损害国家荣誉和利益的；</p><p>（3）煽动民族仇恨、民族歧视、破坏民族团结的；</p><p>（4）破坏国家宗教政策，宣扬邪教和封建迷信的；</p><p>（5）散布谣言、淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；</p><p>（6）侮辱、诽谤他人，或侵害他人合法权利的；</p><p>（7）煽动非法集会、结社、游行、示威、聚众扰乱社会秩序的；</p><p>（8）其他违反法律、法规、规章、条例以及社会道德规范所限制或禁止的内容的。</p><p>5.9.若您在使用静远资产配置助手网上服务的过程中违反上述任何规定，则静远资产配置助手有权要求您改正或直接采取一切必要的措施(包括但不限于警告、限制或禁止使用全部或部分功能、账号封禁直至注销)以减轻不当行为而造成的影响，并公告处理结果；对于违反法律法规的行为，静远资产配置助手有权向有关部门报告，您应独自承担由此产生的一切法律责任。因此导致的您账号下数据及相关信息被删除以及相关权益丧失的，该损失由您自行承担，对此静远资产配置助手不承担任何责任。</p><p>5.10.您必须承担一切因您个人行为而直接或间接导致的法律责任。若您的行为给静远资产配置助手造成损失的，应承担赔偿责任。</p><p>6.权利声明</p><p>6.1.所有静远资产配置助手网络平台上的及静远资产配置助手在提供网上服务的过程中使用的组成元素均属于静远资产配置助手所有，并受版权、商标、专利和其它财产所有权法律的保护。严禁任何个人或单位在未经静远资产配置助手许可的情况下对上述内容进行翻版、复制、转载、篡改等一切侵权行为。您只有在本公司授权下才能为自用目的合理使用这些内容，而不能擅自复制、再造这些内容、或创造与这些内容有关的衍生作品或产品，否则，将承担法律责任。</p><p>6.2.静远资产配置助手对其专有内容、原创内容和其他通过授权取得的独占或者独家内容享有知识产权。未经静远资产配置助手书面许可，任何单位和个人不得私自予以转载、传播或者有任何其他侵犯静远资产配置助手知识产权的行为。否则，将承担法律责任。</p><p>6.3.若您使用静远资产配置助手网络平台的任何内容，均应注明其“来源于静远资产配置助手”并署上作者姓名，且与此相关的一切法律责任由您独立承担。静远资产配置助手对所有作品享有用于其它用途的优先权，包括但不限于网站、电子杂志、平面出版等，但在使用前会通知作者，并按同行业的标准支付稿酬。您将该账号在任何时间段发表的任何形式的内容的著作财产权无偿授权给静远资产配置助手使用，同时许可静远资产配置助手有权就任何主体侵权而单独提起诉讼，并获得赔偿。本协议已经构成《著作权法》第二十五条所规定的书面协议，其效力及于您在静远资产配置助手网站发布的任何受著作权法保护的内容。</p><p>6.4.您应保证您是在静远资产配置助手上传或发表内容的著作权人或已取得合法授权，并且该内容不会侵犯任何第三方的合法权益。若第三方提出关于著作权的异议，静远资产配置助手有权根据实际情况删除相关的内容，且有权追究您的法律责任。您的上述行为给静远资产配置助手或任何第三方造成损失的，应负责全额赔偿。</p><p>6.5.为营造公平、健康的网络环境，在您使用静远资产配置助手网上服务的过程中，静远资产配置助手有权通过技术手段了解您的相关终端设备信息。一经发现有任何未经授权、危害静远资产配置助手网上服务正常运营的相关程序，静远资产配置助手将收集所有与此有关的信息并采取合理措施予以打击。</p><p>6.6.本站所有内容仅代表作者自己的立场和观点，与本站无关，由作者本人承担一切法律责任。恶意转载静远资产配置助手网络平台上内容的，本站保留将其诉诸法律的权利。</p><p>6.7.“静远资产配置助手”为静远资产配置助手及其关联公司的注册商标，受中国法律保护。 对于“静远资产配置助手”等商标，任何人不得擅自使用。违反上述声明而给静远资产配置助手造成损失的，静远资产配置助手将依法追究其法律责任。</p><p>7.免责声明</p><p>7.1.由于互联网各个环节存在不稳定因素，静远资产配置助手无法保证其提供的网络服务一定能满足用户的要求，也不保证网络服务的及时性、安全性、准确性。</p><p>7.2.为方便用户，静远资产配置助手网络平台可能会提供其他国际互联网网站或资源的链接，但静远资产配置助手不保证前述网站或资源是否可以利用，亦不保证外部链接的准确性和完整性。同时，对于该等外部链接指向的不由静远资产配置助手实际控制的任何网页上的内容，静远资产配置助手不承担任何责任。若您因使用或依赖上述网站或资源受到损失或损害，静远资产配置助手及静远资产配置助手网络平台不承担任何责任。</p><p>7.3.对于因不可抗力或静远资产配置助手不能控制的原因造成的网络服务中断或其它缺陷造成的损失，静远资产配置助手不承担任何责任。由于地震、台风、洪水、火灾、战争、政府禁令以及其他不能预见并且对其发生和后果不能防止或避免的不可抗力原因，或互联网上的黑客攻击事件、计算机病毒、电信管制、停电，用户操作不当等非静远资产配置助手原因，导致本服务条款不能履行或不能完全履行，静远资产配置助手不承担责任。</p><p>7.4.静远资产配置助手有权于任何时间暂时或永久修改或终止部分或全部非付费服务，而无论其通知与否，静远资产配置助手对您和任何第三人均无需承担任何责任。</p><p>7.5.静远资产配置助手可根据知悉或掌握的信息独立决定随时变更、终止、中止您对任何静远资产配置助手网上服务的使用，无须向您发出任何提前通知，但根据法律法规规定、本协议或具体服务规则需要提前通知的除外。静远资产配置助手无需向您承担与此相关的任何责任，且有权要求您承担相应责任。</p><p>7.6.静远资产配置助手网上服务可能因软件漏洞、缺陷、版本更新缺陷、第三方病毒攻击、互联网连接或其他任何因素导致您的账号数据发生异常。在数据异常的原因未得到查明前，静远资产配置助手有权暂时冻结账号，且静远资产配置助手无须向您承担任何责任。</p><p>7.7.静远资产配置助手不对您与第三方交易的行为负责，包括但不限于您通过购买、接受赠与或者其他的方式从任何第三方获得产品、服务等，并且不受理因任何第三方交易发生纠纷而带来的申诉。</p><p>7.8.在您使用静远资产配置助手网上服务期间所存在的风险及一切后果将完全由用户本人承担。静远资产配置助手对此不承担任何责任。</p><p>7.8.1.在使用本协议项下服务的过程中，您可能会遇到网络信息或其他用户行为带来的风险，静远资产配置助手不对任何信息的真实性、适用性、合法性承担责任，也不对因侵权行为给用户造成的损害负责。这些风险包括但不限于：来自他人匿名或冒名的含有威胁、诽谤、令人反感或非法内容的信息；遭受他人误导、欺骗或其他导致或可能导致的任何心理、生理上的伤害以及经济上的损失；其他因网络信息或用户行为引起的风险。</p><p>7.8.2.您经由静远资产配置助手网络平台与广告商进行通讯联系或商业往来或参与促销活动的行为，完全属于您与广告商之间的行为，与静远资产配置助手及静远资产配置助手网络平台没有任何关系。若您因上述行为受到任何损害或损失，静远资产配置助手或静远资产配置助手网络平台不承担任何责任。</p>',NULL,0,5,9,'2022-11-04 13:50:56','2023-12-30 11:12:42',NULL,0),('开发者Key','map_key',NULL,'申请好的Web端开发者Key，首次调用 load 时必填',0,8,18,'2022-11-17 19:18:22','2022-11-17 19:18:22',NULL,0),('中心点位置','map_center','[105.602725, 37.076636]','设置地图的显示样式',0,8,19,'2022-11-17 19:19:45','2022-11-17 19:19:45',NULL,0),('显示样式','map_style','amap://styles/normal','初始化地图中心点位置',0,8,20,'2022-11-17 19:20:16','2022-11-17 19:20:16',NULL,0),('地图级别','map_zoom','5','初始化地图级别',0,8,21,'2022-11-17 19:33:01','2022-11-17 19:33:01',NULL,0),('地图模式','map_view_mode','3D','是否为3D地图模式',0,8,22,'2022-11-17 19:34:04','2022-11-17 19:34:04',NULL,0),('俯仰角度','map_pitch','20','地图初始俯仰角度，有效范围 0 度- 83 度',0,8,23,'2022-11-17 19:36:02','2022-11-17 19:36:02',NULL,0),('官方邮箱','wx_server_email','bumishi@foxmail.com',NULL,0,9,25,'2023-02-14 22:55:09','2024-01-09 10:58:46',NULL,0),('服务热线','wx_server_phone','18975828726',NULL,0,9,26,'2023-02-14 22:55:57','2024-01-09 10:58:46',NULL,0),('公司官网','wx_server_site','https://bumishi.cn',NULL,0,9,27,'2023-02-14 22:56:45','2024-01-09 10:58:46',NULL,0),('AppID','wx_server_app_id','',NULL,0,9,28,'2023-02-26 22:01:19','2024-01-09 10:58:46',NULL,0),('AppSecret','wx_server_app_secret','',NULL,0,9,29,'2023-02-26 22:01:46','2024-01-09 10:58:46',NULL,0),('邮箱账号','email_access',NULL,NULL,0,10,34,'2023-02-26 22:01:46','2023-02-27 09:50:02',NULL,0),('邮箱口令','email_password',NULL,NULL,0,10,35,'2023-02-26 22:01:46','2023-02-27 09:50:02',NULL,0),('邮箱服务器','email_server','smtp.163.com',NULL,0,10,36,'2023-02-26 22:01:46','2023-02-27 09:50:02',NULL,0),('邮箱端口','email_port','25',NULL,0,10,37,'2023-02-26 22:01:46','2023-02-27 09:50:02',NULL,0),('关于我们','web_about','<p># 静远基金投资，专注指数基金资产配置。</p><p>### 微信:jingyuanjijintouzi</p><p>### 公众号:静远资产配置</p>',NULL,0,3,38,'2024-01-09 11:25:21','2024-01-09 11:26:02',NULL,0);
/*!40000 ALTER TABLE `vadmin_system_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vadmin_system_settings_tab`
--

DROP TABLE IF EXISTS `vadmin_system_settings_tab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vadmin_system_settings_tab` (
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '标题',
  `classify` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '分类键',
  `tab_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'tab标题',
  `tab_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'tab标识符',
  `hidden` tinyint(1) NOT NULL COMMENT '是否隐藏',
  `disabled` tinyint(1) NOT NULL COMMENT '是否禁用',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `create_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_datetime` datetime DEFAULT NULL COMMENT '删除时间',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否软删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_vadmin_system_settings_tab_tab_name` (`tab_name`),
  KEY `ix_vadmin_system_settings_tab_classify` (`classify`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='系统配置分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vadmin_system_settings_tab`
--

LOCK TABLES `vadmin_system_settings_tab` WRITE;
/*!40000 ALTER TABLE `vadmin_system_settings_tab` DISABLE KEYS */;
INSERT INTO `vadmin_system_settings_tab` VALUES ('系统配置','web','基础配置','web_basic',0,0,1,'2022-10-31 19:52:45','2022-10-31 19:52:45',NULL,0),('系统配置','web','百度统计','web_baidu',1,1,2,'2022-10-31 19:52:45','2022-10-31 19:52:45',NULL,0),('系统配置','web','关于我们','web_about',0,0,3,'2022-10-31 19:52:45','2022-10-31 19:52:45',NULL,0),('系统配置','web','隐私政策','web_privacy',0,0,4,'2022-10-31 19:52:45','2022-10-31 19:52:45',NULL,0),('系统配置','web','用户协议','web_agreement',0,0,5,'2022-10-31 19:52:45','2022-10-31 19:52:45',NULL,0),('地图配置','map','用户分布','map_distribution',1,0,8,'2022-11-17 19:16:59','2022-11-17 19:16:59',NULL,0),('系统配置','web','微信服务端小程序','wx_server',0,0,9,'2023-02-14 22:53:18','2023-02-14 22:53:18',NULL,0),('系统配置','web','邮箱配置','web_email',1,1,10,'2023-02-14 22:53:18','2023-02-14 22:53:18',NULL,0);
/*!40000 ALTER TABLE `vadmin_system_settings_tab` ENABLE KEYS */;
UNLOCK TABLES;

create table user_feedback
(
    id          int auto_increment comment 'id'
        primary key,
    catalog     varchar(30) default '其他' not null comment '分类',
    mark        text                       null comment '描述',
    attachs     varchar(300)               null comment '附件图片地址',
    user_id     int                        null comment '用户',
    concat      varchar(20)                null comment '联系方式',
    create_time datetime                   null comment '反馈时间'
)
    comment '用户反馈';
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-10 22:58:03
