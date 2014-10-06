<?php

class Helper_EditorGotoTopView extends Zend_View_Helper_Abstract
{
    public function EditorGotoTopView()
    {
        $this->view->headScript()->appendFile('/assets/js/admin/ceEditors.goto-top.js');
        return '
            <div class="editor goto-top-block" data-content-type="goto-top-block">
                <p class="sydney_editor_p">
                    Go to top helper!
                </p>

                <p class="buttons sydney_editor_p">
                    <a class="button sydney_editor_a" href="save">Save as actual content</a>
                    <a class="button sydney_editor_a" href="save-draft">Save as draft</a>
                    <a class="button muted sydney_editor_a" href="cancel">Cancel</a>
                </p>
            </div>';
    }
}