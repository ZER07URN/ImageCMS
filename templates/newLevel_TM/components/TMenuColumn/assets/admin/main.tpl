{$categories = \ShopCore::app()->SCategoryTree->getTree();}
<form method="post" action="{site_url('admin/components/init_window/template_manager/updateComponent')}/{echo $handler}" id="component_{echo $handler}_form"> 
    <input type="hidden" name="handler" value="{echo $handler}">
    
    <table class="frame-level-menu frame_level table table-striped table-bordered table-hover table-condensed products_table">
        <thead>
            <tr>
                <td>{lang('Category', 'newLevel_TM')}</td>
                <td class="span3">{lang('Show in column', 'newLevel_TM')}</td>
            </tr>
        </thead>
        <tbody>
        <select name="openLevels">
            <option {if $openLevels == 'all'}selected="selected"{/if}value="all">{lang('Open all levels', 'newLevel_TM')}</option>
            <option {if $openLevels == '2'}selected="selected"{/if} value="2">{lang('Open two levels', 'newLevel_TM')}</option>
        </select>

        {foreach $categoriesT as $key => $category}
            {$children = $category['children'];}
            {$category = $category['category'];}
            <tr>
                <td>
                    <div class="title lev">
                        {if $children}
                            <button type="button" class="btn btn-small my_btn_s" data-rel="tooltip" data-placement="top" data-original-title="{lang('Toggle this category', 'newLevel_TM')}" style="display: none;" onclick="hideSubCategory(this)">
                                <i class="my_icon icon-minus"></i>
                            </button>
                            <button type="button" class="btn btn-small my_btn_s btn-primary" data-rel="tooltip" data-placement="top" data-original-title="{lang('Expand Category', 'newLevel_TM')}" onclick="showSubCategory(this)">
                                <i class="my_icon icon-plus"></i>
                            </button>
                        {/if}
                        <a href="/admin/components/run/shop/categories/edit/{$category->id}" class="pjax" data-rel="tooltip" data-placement="top" data-original-title="{lang('Editing category', 'newLevel_TM')}">
                            {echo $category->name}
                        </a>
                    </div>
                </td>
                <td></td>
            </tr>
            {if $children}
                <tr class="frame_level">
                    <td colspan="2">
                        <table>
                            <tbody>
                                {foreach $children as $child}
                                    {$children = $child['children'];}
                                    {$category = $child['category'];}
                                    <tr>
                                        <td>
                                            <div class="title lev">
                                                {if $children}
                                                    <button type="button" class="btn btn-small my_btn_s" data-rel="tooltip" data-placement="top" data-original-title="{lang('Toggle this category', 'newLevel_TM')}" style="display: none;" onclick="hideSubCategory(this)">
                                                        <i class="my_icon icon-minus"></i>
                                                    </button>
                                                    <button type="button" class="btn btn-small my_btn_s btn-primary" data-rel="tooltip" data-placement="top" data-original-title="{lang('Expand Category', 'newLevel_TM')}" onclick="showSubCategory(this)">
                                                        <i class="my_icon icon-plus"></i>
                                                    </button>
                                                {/if}
                                                <a href="/admin/components/run/shop/categories/edit/{$category->id}" class="pjax" data-rel="tooltip" data-placement="top" data-original-title="{lang('Editing category', 'newLevel_TM')}">
                                                    {echo $category->name}
                                                </a>
                                            </div>
                                        </td>
                                        <td class="span3 t-a_c">{echo $template->getComponent('TMenuColumn')->select_column_menu($category->id)}</td>
                                    </tr>
                                    {if $children}
                                        <tr class="frame_level">
                                            <td colspan="2">
                                                <table>
                                                    <tbody>
                                                        {foreach $children as $category}
                                                            <tr>
                                                                <td>
                                                                    <div class="title lev">
                                                                        <a href="/admin/components/run/shop/categories/edit/{$category->id}" class="pjax" data-rel="tooltip" data-placement="top" data-original-title="{lang('Editing category', 'newLevel_TM')}">
                                                                            {echo $category->name}
                                                                        </a>
                                                                    </div>
                                                                </td>
                                                                <td class="span3 t-a_c">{echo $template->getComponent('TMenuColumn')->select_column_menu($category->id)}</td>
                                                            </tr>
                                                        {/foreach}
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    {/if}
                                {/foreach}
                            </tbody>
                        </table>
                    </td>
                </tr>
            {/if}
        {/foreach}
        </tbody>
    </table>
    {form_csrf()}
</form>
<button type="button" class="btn btn-small action_on formSubmit btn-primary cattegoryColumnSaveButtonMod" data-form="#component_{echo $handler}_form" data-action="close">
    <i class="icon-ok icon-white"></i>{lang('Save', 'newLevel_TM')}
</button>
{literal}
    <script>
                                function showSubCategory(el) {
                                    $(el).hide().prev().show().end().closest('tr').next().show();
                                }
                                function hideSubCategory(el) {
                                    $(el).hide().next().show().end().closest('tr').next().hide();
                                }
    </script>
{/literal}