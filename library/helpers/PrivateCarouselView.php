<?php

class Helper_PrivateCarouselView extends Zend_View_Helper_Abstract
{
    public function privateCarouselView($actionsHtml = '', $content = '', $dbId = 0, $order = 0, $params = array(), $moduleName = 'adminpages', $pagstructureId = 0, $sharedInIds = '')
    {
        $picturedIds = explode(',', $content);

        $filesObject = new Filfiles();
        $files = $filesObject->getFileInfosByIdList($picturedIds);

        $imgList = array();
        /* We iterate throught all the files selected */
        foreach($files as $key => $file){
            $imgList[] = '<img data-file-id="' . $file['id'] . '" class="preview-image" src="/publicms/file/showimg/id/' . $file['id'] . '/dw/1140" alt="" style="width:200px" />';
        }

        $htmlImgList = implode("\n", $imgList);

        return '<li class="' . $params['addClass'] . ' sydney_editor_li"
                        data-content-type="carousel-block"
						dbid="' . $dbId . '"
						dborder="' . $order . '"
						pagstructureid="' . $pagstructureId . '">
			' . $actionsHtml . '
			<div class="content">
				'.$htmlImgList.'
			</div>
		</li>';
    }
}