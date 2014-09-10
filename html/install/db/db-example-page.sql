INSERT INTO `safinstances_safmodules` (`safinstances_id`, `safmodules_id`) VALUES ({instanceid}, 1);
INSERT INTO `safinstances_safmodules` (`safinstances_id`, `safmodules_id`) VALUES ({instanceid}, 3);
INSERT INTO `safinstances_safmodules` (`safinstances_id`, `safmodules_id`) VALUES ({instanceid}, 4);
INSERT INTO `safinstances_safmodules` (`safinstances_id`, `safmodules_id`) VALUES ({instanceid}, 5);
INSERT INTO `safinstances_safmodules` (`safinstances_id`, `safmodules_id`) VALUES ({instanceid}, 7);
INSERT INTO `safinstances_safmodules` (`safinstances_id`, `safmodules_id`) VALUES ({instanceid}, 8);


INSERT INTO `pagstructure` (`id`, `label`, `htmltitle`, `url`, `metadesc`, `metakeywords`, `parent_id`, `safinstances_id`, `ishome`, `status`, `pagorder`, `datecreated`, `datemodified`, `date_lastupdate_content`, `who_modified`, `who_lastupdate_content`, `iscachable`, `cachetime`, `hits`, `redirecttoid`, `usersgroups_id`, `isDeleted`, `shortdesc`, `colorcode`, `layout`) VALUES
(1, 'Example page', 'This is an example page', 'example-page', '', '', NULL, {instanceid}, 1, 'published', 0, NULL, NOW(), NOW(), 'Sydney CMS', 'Sydney CMS', 0, 0, 1, 0, 0, 0, '', '', '');



INSERT INTO `pagdivs` (`id`, `label`, `params`, `params_draft`, `content`, `content_draft`, `pagdivtypes_id`, `status`, `datecreated`, `datemodified`, `order`, `usersgroups_id`, `isDeleted`, `wrkstatuses_id`, `online`) VALUES
(1, NULL, '', NULL, '<p>Hi !</p>\n\n<p>This is an example content page.<br />\nYou can edit it as you want.</p>\n', '', 2, 'published', NOW(), NOW(), 1, 1, 0, 0, 1);


INSERT INTO `pagstructure_pagdivs` (`pagstructure_id`, `pagdivs_id`, `id`, `order`, `zone`) VALUES (1, 1, 1, 1, NULL);
