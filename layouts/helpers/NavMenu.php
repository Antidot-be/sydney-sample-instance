<?php

/**
 * Helper showing a basic menu
 */
class Menu_View_Helper_NavMenu extends Zend_View_Helper_Abstract
{

    /**
     * 
     * @param array $nodes
     * @param int $pageId Current page id
     * @return string $strMenu
     */
    public function navMenu($nodes = array(), $pageId)
    {
		$strMenu = '';

		foreach($nodes as $node){

			$selectedClass = ($node['id'] == $pageId)? 'selected' : '';
			$url = ($node['ishome'] == 1)? '/' : $this->view->sydneyUrl(0, (!empty($node['url']))? $node['url'] : $node['label']);
			$label = $node['label'];

			$strMenu .= <<<END
				<li class="$selectedClass">
					<a class="$selectedClass" href="$url">$label</a>
				</li>
END;
		}
		return $strMenu;
    }
}
