<?php

class Helper_EditorCarouselView extends Zend_View_Helper_Abstract
{
    public function EditorCarouselView()
    {
        $this->view->headScript()->appendFile('/assets/js/admin/ceEditors.carousel.js');
        return '
            <div class="editor files edefiles carousel-block" data-content-type="carousel-block">
                <p class="buttons sydney_editor_p">
                    <a class="button sydney_editor_a" href="save">Save as actual content</a>
                    <a class="button sydney_editor_a" href="save-draft">Save as draft</a>
                    <a class="button muted sydney_editor_a" href="cancel">Cancel</a>
                </p>
            </div>';
    }
}