/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50525
Source Host           : localhost:3306
Source Database       : data_basicelearning

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2020-12-30 12:53:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for board_board
-- ----------------------------
DROP TABLE IF EXISTS `board_board`;
CREATE TABLE `board_board` (
  `pkid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL COMMENT '名称',
  `ip` varchar(200) DEFAULT NULL COMMENT '门禁ip',
  `sn` varchar(200) DEFAULT NULL COMMENT '门禁sn码',
  `createtime` datetime DEFAULT NULL COMMENT '创建日期',
  `categoryid` int(11) DEFAULT NULL COMMENT '分类id',
  `userid` int(11) DEFAULT NULL COMMENT '添加用户',
  `remark` varchar(250) DEFAULT NULL COMMENT '备注信息',
  `status` int(11) DEFAULT NULL COMMENT '门禁状态',
  `jktdid` int(11) DEFAULT NULL COMMENT '监控通道ID',
  PRIMARY KEY (`pkid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of board_board
-- ----------------------------
INSERT INTO `board_board` VALUES ('2', 'test1', '192.168.1.2', '234', '2020-12-14 09:06:50', '1', '1', 'test1', '0', '7');
INSERT INTO `board_board` VALUES ('3', 'test', '10.1.1.59', '125029170', '2020-12-14 14:54:45', '1', '1', 'test', '0', '6');
SET FOREIGN_KEY_CHECKS=1;
