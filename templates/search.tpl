
<div class="alert alert-success">{$nb_entries} {if $nb_entries==1}{$msg_entryfound}{else}{$msg_entriesfound}{/if}</div>

{if {$size_limit_reached}}
<div class="alert alert-warning"><i class="fa fa-fw fa-exclamation-triangle"></i> {$msg_sizelimit}</div>
{/if}

{if $results_display_mode=="boxes"}
<div class="row">

{foreach $entries as $entry}

    <div class="search-result {$search_result_bootstrap_column_class}{if $hover_effect} hvr-{$hover_effect}{/if}">
        <div class="panel panel-info">
            <div class="panel-heading text-center">
                <p class="panel-title">
                    <i class="fa fa-fw fa-{$attributes_map.{$search_result_title}.faclass}"></i>
                     {$entry.{$attributes_map.{$search_result_title}.attribute}.0|truncate:{$search_result_truncate_title_after}}
                </p>
            </div>
            <div class="panel-body">
            <div class="row">
            <div class="col-sm-4">
                <img src="photo.php?dn={$entry.dn|escape:'url'}" alt="{$entry.{$attributes_map.{$display_title}.attribute}.0}" class="img-responsive img-thumbnail center-block" />
            </div>
            <div class="col-sm-8">
            {foreach $search_result_items as $item}
                {$attribute=$attributes_map.{$item}.attribute}
                {$type=$attributes_map.{$item}.type}
                {$faclass=$attributes_map.{$item}.faclass}
                {if !({$entry.$attribute.0})}
                    {if {$search_result_show_undefined}}
                    <p><i class="fa fa-fw fa-{$faclass}"></i> <i>{$msg_notdefined}</i></p>
                    {/if}
                {continue}
                {/if}
                <p>
                    {foreach $entry.{$attribute} as $value}
                    {if $value@index ne 0}
                    <i class="fa fa-fw fa-{$faclass}"></i> 
                    {include 'value_displayer.tpl' value=$value type=$type truncate_value_after=$search_result_truncate_value_after ldap_params=$ldap_params search={$search} date_specifiers=$date_specifiers}<br />
                    {/if}
                    {/foreach}
                </p>
            {/foreach}
            </div>
            </div>
            </div>
            <div class="panel-footer text-center">
                <a href="index.php?page=display&dn={$entry.dn|escape:'url'}&search={$search}" class="btn btn-info" role="button"><i class="fa fa-fw fa-id-card"></i> {$msg_displayentry}</a>
            </div>
        </div>
    </div>

{/foreach}

</div>
{/if}

{if $results_display_mode=="rows"}
<table class="table table-striped table-condensed">
  <thead>
    <tr>
      <th></th>
{foreach $search_result_items as $item}
      <th>{$msg_label_{$item}}</th>
{/foreach}
    </tr>
  </thead>
  <tbody>
{foreach $entries as $entry}
    <tr>
      <th><a href="index.php?page=display&dn={$entry.dn|escape:'url'}&search={$search}" class="btn btn-info btn-sm" role="button" title="{$msg_displayentry}"><i class="fa fa-fw fa-id-card"></i></a></th>
{foreach $search_result_items as $item}
    {$attribute=$attributes_map.{$item}.attribute}
    {$type=$attributes_map.{$item}.type}
      <td>
                {if !({$entry.$attribute.0})}
                    {if {$search_result_show_undefined}}
                    <i>{$msg_notdefined}</i>
                    {/if}
                {continue}
                {/if}
                {foreach $entry.{$attribute} as $value}
                    {if $value@index ne 0}
                    {include 'value_displayer.tpl' value=$value type=$type truncate_value_after=$search_result_truncate_value_after ldap_params=$ldap_params search={$search} date_specifiers=$date_specifiers}<br />
                    {/if}
                {/foreach}
      </td>
{/foreach}
    </tr>
{/foreach}
  </tbody>
</table>
{/if}
