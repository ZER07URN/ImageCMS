{$count = ShopCore::app()->SCart->totalItems()}
{if $count == 0}
    <div class="btn-bask">
        <button>
            <span class="frame-icon">
                <span class="icon_cleaner"></span>
            </span>
            <span class="text-cleaner">
                <span class="helper"></span>
                <span>
                    <span class="text-el">{lang('Корзина пуста','newLevel')}</span>
                </span>
            </span>
        </button>
    </div>
{else:}
    <div class="btn-bask pointer">
        <a data-drop="#popupCart" id="showCart" data-source="{shop_url('cart/api/renderCart')}" data-always="true">
            <span class="frame-icon">
                <span class="icon_cleaner"></span>
            </span>
            <span class="text-cleaner">
                <span class="helper"></span>
                <span>
                    <span class="text-el topCartCount">{echo $count}</span>
                    <span class="text-el">&nbsp;</span>
                    <span class="text-el plurProd">{echo SStringHelper::Pluralize($count, array(lang('товар','newLevel'),lang('товара','newLevel'),lang('товаров','newLevel')))}</span>
                    <span class="divider text-el">&#8226;</span>
                    <span class="d_i-b">
                        <span class="text-el topCartTotalPrice">{echo $cartPrice}</span>
                        <span class="text-el">&nbsp;<span class="curr">{$CS}</span></span>
                    </span>
                </span>
            </span>
        </a>
    </div>
{/if}