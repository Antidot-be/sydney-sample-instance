SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

-- --------------------------------------------------------

--
-- Table structure for table `applog`
--

CREATE TABLE IF NOT EXISTS `applog` (
`id` bigint(20) NOT NULL COMMENT 'PK',
  `timestamp` datetime NOT NULL COMMENT 'timestamp',
  `priorityName` varchar(20) CHARACTER SET latin1 DEFAULT NULL COMMENT 'Priority code',
  `priority` int(20) NOT NULL COMMENT 'priority number',
  `className` varchar(50) CHARACTER SET latin1 NOT NULL COMMENT 'class name where the event occured',
  `message` varchar(255) CHARACTER SET latin1 NOT NULL COMMENT 'logged message',
  `identity` varchar(50) CHARACTER SET latin1 DEFAULT NULL COMMENT 'login of the authenticated user',
  `HTTP_REFERER` varchar(200) CHARACTER SET latin1 NOT NULL COMMENT 'referer',
  `REMOTE_ADDR` varchar(50) CHARACTER SET latin1 NOT NULL COMMENT 'remote address',
  `REQUEST_METHOD` varchar(50) CHARACTER SET latin1 NOT NULL COMMENT 'method',
  `REQUEST_TIME` varchar(50) CHARACTER SET latin1 NOT NULL COMMENT 'request execution time',
  `mysqltimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `filfiles`
--

CREATE TABLE IF NOT EXISTS `filfiles` (
`id` bigint(20) NOT NULL,
  `label` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `desc` text CHARACTER SET latin1,
  `keywords` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `filename` varchar(255) CHARACTER SET latin1 NOT NULL,
  `type` varchar(4) CHARACTER SET latin1 DEFAULT NULL,
  `fweight` int(11) NOT NULL,
  `imgwidth` int(11) NOT NULL,
  `imgheight` int(11) NOT NULL,
  `techdata` varchar(255) CHARACTER SET latin1 NOT NULL,
  `filtype_id` bigint(20) DEFAULT NULL,
  `users_id` bigint(20) DEFAULT NULL,
  `safinstances_id` bigint(20) DEFAULT NULL,
  `datecreated` datetime NOT NULL,
  `datemodified` datetime NOT NULL,
  `istagged` tinyint(1) NOT NULL DEFAULT '0',
  `idxcontent` text CHARACTER SET latin1 COLLATE latin1_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Contains all the files browsable in the file manager.';

-- --------------------------------------------------------

--
-- Table structure for table `filfiles_filmetadata`
--

CREATE TABLE IF NOT EXISTS `filfiles_filmetadata` (
  `filmetadata_id` bigint(20) NOT NULL,
  `filfiles_id` bigint(20) NOT NULL,
`id` bigint(20) NOT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `filfolders`
--

CREATE TABLE IF NOT EXISTS `filfolders` (
`id` bigint(21) NOT NULL,
  `label` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `desc` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `safinstances_id` bigint(20) NOT NULL,
  `isnode` tinyint(1) NOT NULL DEFAULT '0',
  `isparam` tinyint(1) NOT NULL DEFAULT '0',
  `relevance` int(11) NOT NULL DEFAULT '50',
  `pagorder` int(11) NOT NULL,
  `linkedto` varchar(150) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `isSystemFolder` smallint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Folders containing files.';

-- --------------------------------------------------------

--
-- Table structure for table `filfolders_filfiles`
--

CREATE TABLE IF NOT EXISTS `filfolders_filfiles` (
  `filfolders_id` bigint(20) NOT NULL,
  `filfiles_id` bigint(20) NOT NULL,
`id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `filfolders_users`
--

CREATE TABLE IF NOT EXISTS `filfolders_users` (
  `filfolders_id` bigint(20) NOT NULL,
  `users_id` bigint(20) NOT NULL,
`id` bigint(20) NOT NULL,
  `hits` int(11) NOT NULL,
  `isconfig` tinyint(1) NOT NULL,
  `love` int(11) NOT NULL DEFAULT '0',
  `like` int(11) NOT NULL DEFAULT '0',
  `bomb` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `filmediatype`
--

CREATE TABLE IF NOT EXISTS `filmediatype` (
`id` bigint(20) NOT NULL,
  `label` varchar(100) CHARACTER SET latin1 NOT NULL,
  `desc` varchar(255) CHARACTER SET latin1 NOT NULL,
  `class` varchar(100) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `filmetadata`
--

CREATE TABLE IF NOT EXISTS `filmetadata` (
`id` bigint(20) NOT NULL,
  `label` varchar(150) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `safinstances_id` bigint(20) NOT NULL,
  `parent_id` bigint(20) NOT NULL,
  `isnode` tinyint(1) NOT NULL DEFAULT '0',
  `editable` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `filmetadata_filtype`
--

CREATE TABLE IF NOT EXISTS `filmetadata_filtype` (
  `filmetadata_id` bigint(20) NOT NULL,
  `filtype_id` bigint(20) NOT NULL,
`id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `filtype`
--

CREATE TABLE IF NOT EXISTS `filtype` (
`id` bigint(20) NOT NULL,
  `ext` varchar(4) CHARACTER SET latin1 DEFAULT NULL,
  `class` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `label` varchar(100) CHARACTER SET latin1 NOT NULL,
  `uploadable` tinyint(1) NOT NULL DEFAULT '1',
  `clientresizeable` tinyint(1) NOT NULL DEFAULT '0',
  `mimetype` varchar(200) CHARACTER SET latin1 NOT NULL,
  `filmediatype_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='File type could be image, flash, document, ...';

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE IF NOT EXISTS `languages` (
`id` bigint(21) NOT NULL,
  `label` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `isocode` varchar(2) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `active` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pagdivs`
--

CREATE TABLE IF NOT EXISTS `pagdivs` (
`id` bigint(20) NOT NULL,
  `label` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `params` text CHARACTER SET utf8,
  `params_draft` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `content` longtext CHARACTER SET utf8,
  `content_draft` longtext CHARACTER SET utf8 NOT NULL,
  `content_type_label` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('draft','revised','published','restored') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'draft',
  `datecreated` timestamp NULL DEFAULT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `order` int(11) NOT NULL,
  `usersgroups_id` bigint(20) NOT NULL DEFAULT '1',
  `isDeleted` smallint(1) NOT NULL DEFAULT '0',
  `wrkstatuses_id` bigint(20) NOT NULL,
  `online` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Piece of element (or DIV) included in a page.';

-- --------------------------------------------------------

--
-- Table structure for table `pagmenus`
--

CREATE TABLE IF NOT EXISTS `pagmenus` (
`id` bigint(20) NOT NULL,
  `label` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `desc` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Menu item on the layout. ';

-- --------------------------------------------------------

--
-- Table structure for table `pagmenus_safinstances`
--

CREATE TABLE IF NOT EXISTS `pagmenus_safinstances` (
  `pagmenus_id` bigint(20) NOT NULL,
  `safinstances_id` bigint(20) NOT NULL,
`id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pagstats`
--

CREATE TABLE IF NOT EXISTS `pagstats` (
`id` bigint(20) NOT NULL,
  `pagstructure_id` bigint(20) NOT NULL,
  `views` bigint(20) DEFAULT NULL,
  `unique` bigint(20) DEFAULT NULL,
  `timeonpage` bigint(20) DEFAULT NULL,
  `bounces` float DEFAULT NULL,
  `exits` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pagstructure`
--

CREATE TABLE IF NOT EXISTS `pagstructure` (
`id` bigint(20) NOT NULL,
  `label` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Label in the main language',
  `htmltitle` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `url` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `metadesc` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Description of the page',
  `metakeywords` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Keywords of the page',
  `parent_id` bigint(20) DEFAULT NULL COMMENT 'parent if this node',
  `safinstances_id` bigint(20) NOT NULL COMMENT 'webinstance for this node',
  `ishome` tinyint(1) NOT NULL COMMENT 'is it the homepage?',
  `status` enum('draft','revised','published','restored') CHARACTER SET utf8 NOT NULL DEFAULT 'draft' COMMENT 'published/draft/Revised...',
  `pagorder` int(11) NOT NULL COMMENT 'order of the item',
  `datecreated` timestamp NULL DEFAULT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_lastupdate_content` datetime NOT NULL,
  `who_modified` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `who_lastupdate_content` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `iscachable` tinyint(1) DEFAULT '0',
  `cachetime` int(11) NOT NULL DEFAULT '3600',
  `hits` bigint(20) NOT NULL DEFAULT '0',
  `redirecttoid` bigint(20) NOT NULL,
  `usersgroups_id` bigint(20) NOT NULL DEFAULT '1',
  `isDeleted` smallint(1) NOT NULL DEFAULT '0',
  `shortdesc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `colorcode` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `layout` varchar(60) COLLATE utf8_unicode_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Elements of the site structure.';

-- --------------------------------------------------------

--
-- Table structure for table `pagstructure_pagdivs`
--

CREATE TABLE IF NOT EXISTS `pagstructure_pagdivs` (
  `pagstructure_id` bigint(20) NOT NULL,
  `pagdivs_id` bigint(20) NOT NULL,
`id` bigint(20) NOT NULL,
  `order` int(11) NOT NULL,
  `zone` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pagstructure_pagmenus`
--

CREATE TABLE IF NOT EXISTS `pagstructure_pagmenus` (
  `pagstructure_id` bigint(20) NOT NULL,
  `pagmenus_id` bigint(20) NOT NULL,
`id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `safactions`
--

CREATE TABLE IF NOT EXISTS `safactions` (
`id` bigint(20) NOT NULL,
  `label` varchar(45) CHARACTER SET latin1 NOT NULL,
  `name` varchar(45) CHARACTER SET latin1 NOT NULL,
  `description` text CHARACTER SET latin1,
  `safcontrollers_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `safactivitylog`
--

CREATE TABLE IF NOT EXISTS `safactivitylog` (
`id` bigint(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `priorityName` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `priority` int(20) NOT NULL,
  `className` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `users_id` bigint(20) NOT NULL,
  `login` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `fname` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `lname` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `module` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `action` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `module_table` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `module_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `parent_id` bigint(20) NOT NULL,
  `safinstances_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `safcontrollers`
--

CREATE TABLE IF NOT EXISTS `safcontrollers` (
`id` bigint(20) NOT NULL COMMENT 'PK',
  `label` varchar(50) CHARACTER SET latin1 NOT NULL COMMENT 'Label of the controller',
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(150) CHARACTER SET latin1 NOT NULL COMMENT 'image to illustrate the controller',
  `description` varchar(255) CHARACTER SET latin1 NOT NULL COMMENT 'Description of the controller',
  `safmodules_id` bigint(20) NOT NULL COMMENT 'FK - link to modules'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT COMMENT='Available MVC Controllers';

-- --------------------------------------------------------

--
-- Table structure for table `safinstances`
--

CREATE TABLE IF NOT EXISTS `safinstances` (
`id` bigint(20) NOT NULL COMMENT 'PK',
  `label` varchar(50) CHARACTER SET latin1 NOT NULL COMMENT 'Name of the instance',
  `domain` varchar(50) CHARACTER SET latin1 NOT NULL COMMENT 'Complete URL',
  `description` varchar(200) CHARACTER SET latin1 NOT NULL COMMENT 'description',
  `languages_id` bigint(20) NOT NULL COMMENT 'FK - link to default language',
  `creationdate` datetime NOT NULL,
  `active` tinyint(1) NOT NULL,
  `offlinemessage` text COLLATE utf8_unicode_ci NOT NULL,
  `metakeywords` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Instances of the Sydney Antidot Framework.';

-- --------------------------------------------------------

--
-- Table structure for table `safinstances_safmodules`
--

CREATE TABLE IF NOT EXISTS `safinstances_safmodules` (
  `safinstances_id` bigint(20) NOT NULL COMMENT 'FK - link to safInstances',
  `safmodules_id` bigint(20) NOT NULL COMMENT 'FK - link to modules',
`id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT COMMENT='m2m safInstances and modules';

-- --------------------------------------------------------

--
-- Table structure for table `safinstances_users`
--

CREATE TABLE IF NOT EXISTS `safinstances_users` (
  `safinstances_id` bigint(20) NOT NULL,
  `users_id` bigint(20) NOT NULL,
`id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT COMMENT='m2m link between instances and users';

-- --------------------------------------------------------

--
-- Table structure for table `safmodules`
--

CREATE TABLE IF NOT EXISTS `safmodules` (
`id` bigint(20) NOT NULL COMMENT 'PK',
  `label` varchar(50) CHARACTER SET latin1 NOT NULL COMMENT 'Label of the module',
  `image` varchar(150) CHARACTER SET latin1 NOT NULL COMMENT 'image to illustrate the module',
  `description` varchar(255) CHARACTER SET latin1 NOT NULL COMMENT 'Description of the module',
  `usersgroups_id` bigint(20) NOT NULL COMMENT 'FK - link to usersgroups',
  `prefix` varchar(3) CHARACTER SET latin1 DEFAULT NULL COMMENT '3 letters prefix used for this module. The prefix is used in the DB tables for eg.',
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `showintab` tinyint(1) NOT NULL,
  `istechnical` tinyint(1) NOT NULL,
  `order` int(11) NOT NULL,
  `isalwaysactive` tinyint(1) NOT NULL,
  `isapplication` tinyint(1) NOT NULL,
  `longdesc` text COLLATE utf8_unicode_ci NOT NULL,
  `filfolders_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT COMMENT='Available MVC Module';

-- --------------------------------------------------------

--
-- Table structure for table `translation_data`
--

CREATE TABLE IF NOT EXISTS `translation_data` (
`id` int(11) NOT NULL,
  `safinstances_id` int(11) NOT NULL,
  `tbl_name` varchar(150) CHARACTER SET latin1 NOT NULL,
  `tbl_id` int(11) NOT NULL,
  `tbl_field` varchar(50) CHARACTER SET latin1 NOT NULL,
  `code_language` char(3) CHARACTER SET latin1 NOT NULL,
  `label` longtext CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
`id` bigint(20) NOT NULL COMMENT 'PK',
  `login` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Login name',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Password crypted with md5',
  `usersgroups_id` bigint(20) NOT NULL DEFAULT '1' COMMENT 'FK - link to groups',
  `valid` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'If the user is valid he can access the application. Otherwise he will be denied.',
  `fname` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'First name',
  `mdname` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'Middle name',
  `lname` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'Last name',
  `phone` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Direct phone line',
  `cell` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'E-mail address',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `safinstances_id` bigint(20) NOT NULL DEFAULT '2' COMMENT 'the saf instance from which the user registered',
  `subscribedate` datetime NOT NULL,
  `unsubscribedate` datetime NOT NULL,
  `modifieddate` datetime NOT NULL,
  `ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `creatoridentity` bigint(20) NOT NULL,
  `avatar` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `pagorder` int(11) NOT NULL,
  `lastlogindate` datetime DEFAULT NULL,
  `laststatuschange` datetime DEFAULT NULL,
  `lastpwdchanges` datetime DEFAULT NULL,
  `timeValidityPassword` bigint(20) DEFAULT '0' COMMENT 'Time Validity in seconds for the password compared to lastpwdchanges',
  `lastpwdhistory` blob COMMENT 'password history - serialized array'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT COMMENT='Contains the list of users who could access the application.';

-- --------------------------------------------------------

--
-- Table structure for table `usersgroups`
--

CREATE TABLE IF NOT EXISTS `usersgroups` (
`id` bigint(20) NOT NULL COMMENT 'PK',
  `name` varchar(50) CHARACTER SET latin1 NOT NULL COMMENT 'Short name of the group',
  `desc` varchar(50) CHARACTER SET latin1 NOT NULL COMMENT 'Description of the group',
  `parent_id` bigint(20) NOT NULL COMMENT 'FK â€“ link to a parent group. If a group1 is linked to group 2, group 1 will have the same rights as group 2 (and more if defined in the access list)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT COMMENT='Table containing the groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applog`
--
ALTER TABLE `applog`
 ADD PRIMARY KEY (`id`), ADD KEY `priority` (`priority`), ADD KEY `timestamp` (`timestamp`), ADD KEY `identity` (`identity`), ADD KEY `className` (`className`);

--
-- Indexes for table `filfiles`
--
ALTER TABLE `filfiles`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_filfiles_filtype` (`filtype_id`), ADD KEY `fk_filfiles_users` (`users_id`), ADD KEY `fk_filfiles_safinstances` (`safinstances_id`), ADD KEY `datecreated` (`datecreated`);

--
-- Indexes for table `filfiles_filmetadata`
--
ALTER TABLE `filfiles_filmetadata`
 ADD PRIMARY KEY (`id`), ADD KEY `filmetadata_id` (`filmetadata_id`), ADD KEY `filfiles_id` (`filfiles_id`);

--
-- Indexes for table `filfolders`
--
ALTER TABLE `filfolders`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_filfolders_filfolders` (`parent_id`), ADD KEY `safinstances_id` (`safinstances_id`), ADD KEY `label` (`label`), ADD KEY `relevance` (`relevance`), ADD KEY `pagorder` (`pagorder`), ADD KEY `linkedto` (`linkedto`);

--
-- Indexes for table `filfolders_filfiles`
--
ALTER TABLE `filfolders_filfiles`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_filfolders_has_filfiles_filfolders` (`filfolders_id`), ADD KEY `fk_filfolders_has_filfiles_filfiles` (`filfiles_id`);

--
-- Indexes for table `filfolders_users`
--
ALTER TABLE `filfolders_users`
 ADD PRIMARY KEY (`id`), ADD KEY `filfolders_id` (`filfolders_id`), ADD KEY `usersaboss_id` (`users_id`), ADD KEY `hits` (`hits`), ADD KEY `isconfig` (`isconfig`), ADD KEY `love` (`love`), ADD KEY `like` (`like`), ADD KEY `bomb` (`bomb`);

--
-- Indexes for table `filmediatype`
--
ALTER TABLE `filmediatype`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `filmetadata`
--
ALTER TABLE `filmetadata`
 ADD PRIMARY KEY (`id`), ADD KEY `label` (`label`), ADD KEY `safinstances_id` (`safinstances_id`), ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `filmetadata_filtype`
--
ALTER TABLE `filmetadata_filtype`
 ADD PRIMARY KEY (`id`), ADD KEY `filmetadata_id` (`filmetadata_id`), ADD KEY `filtype_id` (`filtype_id`);

--
-- Indexes for table `filtype`
--
ALTER TABLE `filtype`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `ext` (`ext`), ADD KEY `filmediatype_id` (`filmediatype_id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
 ADD PRIMARY KEY (`id`);


--
-- Indexes for table `pagmenus`
--
ALTER TABLE `pagmenus`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pagmenus_safinstances`
--
ALTER TABLE `pagmenus_safinstances`
 ADD PRIMARY KEY (`id`), ADD KEY `pagmenus_id` (`pagmenus_id`), ADD KEY `safinstances_id` (`safinstances_id`);

--
-- Indexes for table `pagstats`
--
ALTER TABLE `pagstats`
 ADD PRIMARY KEY (`id`), ADD KEY `pagstats_ibfk1` (`pagstructure_id`);

--
-- Indexes for table `pagstructure`
--
ALTER TABLE `pagstructure`
 ADD PRIMARY KEY (`id`), ADD KEY `parent_id` (`parent_id`), ADD KEY `safinstances_id` (`safinstances_id`), ADD KEY `pagorder` (`pagorder`), ADD KEY `usersgroups_id` (`usersgroups_id`);

ALTER TABLE `pagdivs`
ADD PRIMARY KEY (`id`), ADD KEY `usersgroups_id` (`usersgroups_id`);

--
-- Indexes for table `pagstructure_pagdivs`
--
ALTER TABLE `pagstructure_pagdivs`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_pagstructure_has_pagdivs_pagstructure` (`pagstructure_id`), ADD KEY `fk_pagstructure_has_pagdivs_pagdivs` (`pagdivs_id`);

--
-- Indexes for table `pagstructure_pagmenus`
--
ALTER TABLE `pagstructure_pagmenus`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_pagstructure_has_pagmenus_pagstructure` (`pagstructure_id`), ADD KEY `fk_pagstructure_has_pagmenus_pagmenus` (`pagmenus_id`);

--
-- Indexes for table `safactions`
--
ALTER TABLE `safactions`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_safactions_safcontrollers1` (`safcontrollers_id`), ADD KEY `name` (`name`);

--
-- Indexes for table `safactivitylog`
--
ALTER TABLE `safactivitylog`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `safcontrollers`
--
ALTER TABLE `safcontrollers`
 ADD PRIMARY KEY (`id`), ADD KEY `modules_id` (`safmodules_id`), ADD KEY `name` (`name`);

--
-- Indexes for table `safinstances`
--
ALTER TABLE `safinstances`
 ADD PRIMARY KEY (`id`), ADD KEY `languages_id` (`languages_id`);

--
-- Indexes for table `safinstances_safmodules`
--
ALTER TABLE `safinstances_safmodules`
 ADD PRIMARY KEY (`id`), ADD KEY `safinstances_id` (`safinstances_id`), ADD KEY `modules_id` (`safmodules_id`);

--
-- Indexes for table `safinstances_users`
--
ALTER TABLE `safinstances_users`
 ADD PRIMARY KEY (`id`), ADD KEY `safinstances_id` (`safinstances_id`), ADD KEY `users_id` (`users_id`);

--
-- Indexes for table `safmodules`
--
ALTER TABLE `safmodules`
 ADD PRIMARY KEY (`id`), ADD KEY `usersgroups_id` (`usersgroups_id`), ADD KEY `name` (`name`), ADD KEY `filfolders_id` (`filfolders_id`);

--
-- Indexes for table `translation_data`
--
ALTER TABLE `translation_data`
 ADD PRIMARY KEY (`id`), ADD KEY `safinstances_id` (`safinstances_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `login` (`login`), ADD KEY `groups_id` (`usersgroups_id`), ADD KEY `safinstances_id` (`safinstances_id`), ADD KEY `password` (`password`), ADD KEY `pagorder` (`pagorder`), ADD KEY `active` (`active`);

--
-- Indexes for table `usersgroups`
--
ALTER TABLE `usersgroups`
 ADD PRIMARY KEY (`id`), ADD KEY `parent_id` (`parent_id`);


--
-- AUTO_INCREMENT for table `applog`
--
ALTER TABLE `applog`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `filfiles`
--
ALTER TABLE `filfiles`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `filfiles_filmetadata`
--
ALTER TABLE `filfiles_filmetadata`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `filfolders`
--
ALTER TABLE `filfolders`
MODIFY `id` bigint(21) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `filfolders_filfiles`
--
ALTER TABLE `filfolders_filfiles`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `filfolders_users`
--
ALTER TABLE `filfolders_users`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `filmediatype`
--
ALTER TABLE `filmediatype`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `filmetadata`
--
ALTER TABLE `filmetadata`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `filmetadata_filtype`
--
ALTER TABLE `filmetadata_filtype`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `filtype`
--
ALTER TABLE `filtype`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
MODIFY `id` bigint(21) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pagdivs`
--
ALTER TABLE `pagdivs`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pagmenus`
--
ALTER TABLE `pagmenus`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pagmenus_safinstances`
--
ALTER TABLE `pagmenus_safinstances`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pagstats`
--
ALTER TABLE `pagstats`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pagstructure`
--
ALTER TABLE `pagstructure`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pagstructure_pagdivs`
--
ALTER TABLE `pagstructure_pagdivs`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pagstructure_pagmenus`
--
ALTER TABLE `pagstructure_pagmenus`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `safactions`
--
ALTER TABLE `safactions`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `safactivitylog`
--
ALTER TABLE `safactivitylog`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `safcontrollers`
--
ALTER TABLE `safcontrollers`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';
--
-- AUTO_INCREMENT for table `safinstances`
--
ALTER TABLE `safinstances`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';
--
-- AUTO_INCREMENT for table `safinstances_safmodules`
--
ALTER TABLE `safinstances_safmodules`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `safinstances_users`
--
ALTER TABLE `safinstances_users`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `safmodules`
--
ALTER TABLE `safmodules`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';
--
-- AUTO_INCREMENT for table `translation_data`
--
ALTER TABLE `translation_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';
--
-- AUTO_INCREMENT for table `usersgroups`
--
ALTER TABLE `usersgroups`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';
--
-- Constraints for dumped tables
--

--
-- Constraints for table `filfiles`
--
ALTER TABLE `filfiles`
ADD CONSTRAINT `filfiles_ibfk_2` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
ADD CONSTRAINT `filfiles_ibfk_3` FOREIGN KEY (`safinstances_id`) REFERENCES `safinstances` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `filfiles_filmetadata`
--
ALTER TABLE `filfiles_filmetadata`
ADD CONSTRAINT `filfiles_filmetadata_ibfk_1` FOREIGN KEY (`filmetadata_id`) REFERENCES `filmetadata` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `filfiles_filmetadata_ibfk_2` FOREIGN KEY (`filfiles_id`) REFERENCES `filfiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `filfolders_filfiles`
--
ALTER TABLE `filfolders_filfiles`
ADD CONSTRAINT `filfolders_filfiles_ibfk_3` FOREIGN KEY (`filfolders_id`) REFERENCES `filfolders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `filfolders_filfiles_ibfk_4` FOREIGN KEY (`filfiles_id`) REFERENCES `filfiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `filfolders_users`
--
ALTER TABLE `filfolders_users`
ADD CONSTRAINT `filfolders_users_ibfk_1` FOREIGN KEY (`filfolders_id`) REFERENCES `filfolders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `filfolders_users_ibfk_2` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `filmetadata_filtype`
--
ALTER TABLE `filmetadata_filtype`
ADD CONSTRAINT `filmetadata_filtype_ibfk_1` FOREIGN KEY (`filmetadata_id`) REFERENCES `filmetadata` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `filmetadata_filtype_ibfk_2` FOREIGN KEY (`filtype_id`) REFERENCES `filtype` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pagmenus_safinstances`
--
ALTER TABLE `pagmenus_safinstances`
ADD CONSTRAINT `pagmenus_safinstances_ibfk_1` FOREIGN KEY (`pagmenus_id`) REFERENCES `pagmenus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `pagmenus_safinstances_ibfk_2` FOREIGN KEY (`safinstances_id`) REFERENCES `safinstances` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pagstats`
--
ALTER TABLE `pagstats`
ADD CONSTRAINT `pagstats_ibfk1` FOREIGN KEY (`pagstructure_id`) REFERENCES `pagstructure` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pagstructure`
--
ALTER TABLE `pagstructure`
ADD CONSTRAINT `pagstructure_ibfk_2` FOREIGN KEY (`safinstances_id`) REFERENCES `safinstances` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `pagstructure_ibfk_3` FOREIGN KEY (`parent_id`) REFERENCES `pagstructure` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pagstructure_pagdivs`
--
ALTER TABLE `pagstructure_pagdivs`
ADD CONSTRAINT `pagstructure_pagdivs_ibfk_3` FOREIGN KEY (`pagstructure_id`) REFERENCES `pagstructure` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `pagstructure_pagdivs_ibfk_4` FOREIGN KEY (`pagdivs_id`) REFERENCES `pagdivs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pagstructure_pagmenus`
--
ALTER TABLE `pagstructure_pagmenus`
ADD CONSTRAINT `pagstructure_pagmenus_ibfk_3` FOREIGN KEY (`pagstructure_id`) REFERENCES `pagstructure` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `pagstructure_pagmenus_ibfk_4` FOREIGN KEY (`pagmenus_id`) REFERENCES `pagmenus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `safactions`
--
ALTER TABLE `safactions`
ADD CONSTRAINT `fk_safactions_safcontrollers1` FOREIGN KEY (`safcontrollers_id`) REFERENCES `safcontrollers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `safcontrollers`
--
ALTER TABLE `safcontrollers`
ADD CONSTRAINT `safcontrollers_ibfk_1` FOREIGN KEY (`safmodules_id`) REFERENCES `safmodules` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `safinstances`
--
ALTER TABLE `safinstances`
ADD CONSTRAINT `safinstances_ibfk_1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `safinstances_safmodules`
--
ALTER TABLE `safinstances_safmodules`
ADD CONSTRAINT `safinstances_safmodules_ibfk_3` FOREIGN KEY (`safinstances_id`) REFERENCES `safinstances` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `safinstances_safmodules_ibfk_4` FOREIGN KEY (`safmodules_id`) REFERENCES `safmodules` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `safinstances_users`
--
ALTER TABLE `safinstances_users`
ADD CONSTRAINT `safinstances_users_ibfk_3` FOREIGN KEY (`safinstances_id`) REFERENCES `safinstances` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `safinstances_users_ibfk_4` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `safmodules`
--
ALTER TABLE `safmodules`
ADD CONSTRAINT `safmodules_ibfk_1` FOREIGN KEY (`usersgroups_id`) REFERENCES `usersgroups` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`usersgroups_id`) REFERENCES `usersgroups` (`id`) ON DELETE CASCADE,
ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`safinstances_id`) REFERENCES `safinstances` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `usersgroups`
--
ALTER TABLE `usersgroups`
ADD CONSTRAINT `usersgroups_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `usersgroups` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;