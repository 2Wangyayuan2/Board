/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50525
Source Host           : localhost:3306
Source Database       : data_basicelearning

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2020-12-30 12:53:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tool_monitorservercommand
-- ----------------------------
DROP TABLE IF EXISTS `tool_monitorservercommand`;
CREATE TABLE `tool_monitorservercommand` (
  `pkid` int(11) NOT NULL AUTO_INCREMENT,
  `passid` varchar(250) DEFAULT NULL COMMENT '通道ID',
  `passname` varchar(250) DEFAULT NULL COMMENT '通道名称',
  `address` varchar(250) DEFAULT NULL COMMENT '监控地址',
  `pid` int(11) DEFAULT NULL,
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `service` int(11) DEFAULT NULL COMMENT '服务id',
  `isopen` int(11) DEFAULT NULL COMMENT '是否开启',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `display` int(11) DEFAULT '1' COMMENT '0:不显示 1:显示',
  PRIMARY KEY (`pkid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tool_monitorservercommand
-- ----------------------------
INSERT INTO `tool_monitorservercommand` VALUES ('4', '0002', '杭州分部监控', '', '0', '', '1', '2020-09-10 14:16:01', '4', '1', '7', '1');
INSERT INTO `tool_monitorservercommand` VALUES ('6', '0003', '多媒体教室02', '', '0', '', '1', '2020-09-02 18:12:03', '4', '1', '4', '1');
INSERT INTO `tool_monitorservercommand` VALUES ('7', '0001', '多媒体教室01', '', '0', '', '1', '2020-08-12 16:34:04', '4', '1', '6', '1');
SET FOREIGN_KEY_CHECKS=1;
