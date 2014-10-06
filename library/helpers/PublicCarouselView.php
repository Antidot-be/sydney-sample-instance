<?php

class Helper_PublicCarouselView extends Zend_View_Helper_Abstract
{

    public function publicCarouselView($actionsHtml = '', $content = '', $dbId = 0, $order = 0, $params = array(), $pagstructureId = 0)
    {
        $picturedIds = explode(',', $content);

        $filesObject = new Filfiles();
        $files = $filesObject->getFileInfosByIdList($picturedIds); // Retrieve all fields save in DB

        $imgList = $carouselIndicator = array();
        /* We iterate throught all the files selected */
        foreach($files as $key => $file){
            $activeClass = ($key == 0)? ' active' : '';
            $carouselIndicator[] = '<li data-target="#carousel-example-generic" data-slide-to="'.$key.'"></li>';
            $imgList[] = '
                <div class="item '.$activeClass.'">
                    <img src="/publicms/file/showimg/id/' . $file['id'] . '/dw/1140" alt="" />
                    <div class="carousel-caption"></div>
                </div>';
        }

        $htmlIndicatorList = implode("\n", $carouselIndicator);
        $htmlImgList = implode("\n", $imgList);

        return '
            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
              <!-- Indicators -->
              <ol class="carousel-indicators">' . $htmlIndicatorList . '</ol>
              <div class="carousel-inner">' . $htmlImgList . '</div>

              <!-- Controls -->
              <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left"></span>
              </a>
              <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right"></span>
              </a>
            </div>
        ';
    }
}