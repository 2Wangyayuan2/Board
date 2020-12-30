<#include "/controls/apptop.ftl"/>
<#include "/controls/topbar.ftl"/>
<#include "/controls/leftmenu.ftl"/>
<link rel="stylesheet" type="text/css" href="/assets/scripts/dtree/css/ui.css" />

<!-- 加载顶部bar -->
<@topBar title="${title}" titleUrl="/manage/board/index" currentUser=user icon="${menuConfig.icon}"/>

<div class="main-container ace-save-state" id="main-container">

  <!-- 加载左侧菜单 -->
  <@leftMenu indexUrl="/manage/board/index" menuList=menuConfig.menuList currentUrl="/manage/board/index"/>

  <div class="main-content">
    <div class="main-content-inner">
      <div class="breadcrumbs ace-save-state" id="breadcrumbs">
        <ul class="breadcrumb">
          <li>
            <i class="ace-icon fa fa-home home-icon"></i>
            <a href="/manage/video/index">导航页</a>
          </li>

          <li>
            <a href="#">门禁管理</a>
          </li>
          <li class="active">门禁列表管理</li>
        </ul>
      </div>

      <div class="page-content">
        <div class="row">
          <div class="col-xs-12" style="padding:0px;">
            <div>
              <div class="row search-page">
                <div class="col-xs-12">
                  <div class="row">
                    <div class="col-xs-12 col-sm-2">
                      <div id="tree" class="search-area well well-sm">

                      </div>
                    </div>
                    <div class="col-xs-12 col-sm-10 no-padding-left">
                      <div style="margin-bottom: 5px;">
                        <button id="btnAdd" style="float:left; margin-top: 2px" class="btn btn-success btn-mini radius-4"><i class="ace-icon fa fa-plus"></i>增加门禁板</button>
                        <button id="btnDel" style="float:left; margin-top: 2px; margin-left: 5px" class="btn btn-danger btn-mini radius-4"><i class="ace-icon fa fa-trash-o"></i>批量删除</button>
                        <button id="btnOpenAll" style="float:left; margin-top: 2px; margin-left: 5px" class="btn btn-info btn-mini radius-4"><i class="ace-icon fa fa-picture-o"></i>批量开门</button>
                        <label style="padding-top: 5px;width: 65px;" class="col-sm-1 no-padding-right" for="searchKey">搜索：</label>
                        <input type="text" id="searchKey" style="width: 250px;" placeholder="请输入门禁板名称" class="input-sm" />
                        <button style="margin-bottom: 3px; margin-left: 5px;" type="button" id="searchButton" class="btn btn-purple btn-xs">
                          <span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
                          搜索
                        </button>
                      </div>
                      <table id="grid-table"></table>
                      <div id="grid-pager"></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div><!-- /.col -->
        </div><!-- /.row -->

      </div><!-- /.page-content -->
    </div>
  </div>

  <!-- 加载底部版权 -->
  <#include "/controls/footer.ftl"/>

</div>

<#include "/controls/appbottom.ftl"/>
<script type="text/javascript" src="/assets/scripts/dtree/core.js"></script>
<script type="text/javascript" src="/assets/scripts/dtree/ui.js"></script>
<script type="text/javascript" src="/assets/scripts/dtree/cookie.js"></script>
<script type="text/javascript" src="/assets/scripts/dtree/dynatree.js"></script>
<script type="text/javascript" src="/assets/scripts/dtree/dtree.js"></script>

<script src="/assets/lib/js/jquery.jqGrid.min.js"></script>
<script src="/assets/lib/js/grid.locale-cn.js"></script>

<script type="text/javascript">
  jQuery(function ($) {
    var tree = $('#tree');
    tree.mac('dtree', {
      treeConfig: {
        title: '全部',
        rootVisible: true,
        clickFolderMode: 1
      },
      onActivate: function (node) {
        //node.data.code  0为单位;1为年级；2为班级
        categoryId = node.data.key;
        if(categoryId == "root") categoryId = 0;
        initDataList();
      },
      loader: {
        url: '/manage/board/getBoardCategoryListForTree',
        params: { id: '0',level:0 },
        autoLoad: true
      }
    });
  });

  jQuery(function ($) {
    var parent_column = $("#grid-table").closest('[class*="col-"]');
    //当页面大小变化时，让表格宽度自适应
    $(window).on('resize.jqGrid', function () {
      $("#grid-table").jqGrid("setGridWidth", parent_column.width() );
    })

    //当左侧菜单收缩时，让表格宽度自适应
    $(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
      if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
        setTimeout(function() {
          $("#grid-table").jqGrid('setGridWidth', parent_column.width() );
        }, 20);
      }
    })
    $("#grid-table").jqGrid({
      url: "/manage/board/getBoardListForPage",
      datatype: "json", // 从服务器端返回的数据类型，默认xml。可选类型：xml，local，json，jsonnp，script，xmlstring，jsonstring，clientside
      mtype: "POST", // 提交方式，默认为GET
      height: "auto", // 高度，表格高度。可为数值、百分比或'auto'
      colNames: ['编号','名称','IP','唯一码','监控通道','状态', '操作'], // 列显示名称，是一个数组对象
      colModel: [
        // name 表示列显示的名称；
        // index 表示传到服务器端用来排序用的列名称；
        // width 为列宽度；
        // align 为对齐方式；
        // sortable 表示是否可以排序
        {name: 'pkid', index: 'pkid', align: 'left',sortable:true, resize:false, hidden:true},
        {name: 'name', index: 'name', align: 'left',sortable:true, resize:false, hidden:false},
        {name: 'ip', index: 'ip', align: 'left',sortable:true, resize:false, hidden:false},
        {name: 'sn', index: 'sn', align: 'left',sortable:true, resize:false, hidden:false},
        {name: 'jktdid', index: 'jktdid', align: 'left',sortable:true, resize:false, hidden:false},
        {name: 'status', index: 'status', width:100, align: 'left',sortable:false, resize:false,
          formatter: function (value, grid, rows, state) {
            return "无状态";
          }},
        {
          name: 'action', index: '', sortable: false,fixed:true, width:300, resize: false,
          formatter: function (value, grid, rows, state) {
            var html = "<button class='btn btn-minier btn-success' title='编辑' onclick='modify("+rows.pkid+");'><i class=\"ace-icon fa fa-pencil\"></i>编辑</button>&nbsp;" +
              "<button class='btn btn-minier btn-danger' title='删除' onclick='del("+rows.pkid+",\""+rows.name+"\");'><i class=\"ace-icon fa fa-trash-o\"></i>删除</button>&nbsp;"+
              "<button class='btn btn-minier btn-info' title='开门' onclick='opendoor(\""+rows.ip+"\",\""+rows.sn+"\");'><i class=\"ace-icon fa fa-picture-o\"></i>开门</button>&nbsp;";
            return html;
          }
        }
      ],
      //rownumbers: true,// 显示左侧的序号
      altRows:true,// 设置为交替行表格,默认为false
      sortname:'pkid', // 排序列的名称，此参数会被传到后台
      sortorder:'desc', // 排序顺序，升序或者降序（ASC或DESC）
      viewrecords: true, // 是否在翻页导航栏显示记录总数
      rowNum: 8, // 每页显示记录数
      rowList: rowList, // 用于改变显示行数的下拉列表框的元素数组
      pager: $('#grid-pager'), // 定义翻页用的导航栏
      multiselect: true,
      //multikey: "ctrlKey",
      //multiboxonly: true,
      loadComplete : function() {
        var table = this;
        setTimeout(function(){
          //styleCheckbox(table);
          //updateActionIcons(table);
          updatePagerIcons(table);
          //enableTooltips(table);
        }, 0);
      }
    });
    $(window).triggerHandler('resize.jqGrid');

    jQuery("#grid-table").jqGrid('navGrid',"#grid-pager",
      {
        edit: false,
        editicon : 'ace-icon fa fa-pencil blue',
        add: false,
        addicon : 'ace-icon fa fa-plus-circle purple',
        del: false,
        delicon : 'ace-icon fa fa-trash-o red',
        search: false,
        searchicon : 'ace-icon fa fa-search orange',
        refresh: true,
        refreshicon : 'ace-icon fa fa-refresh green',
        view: false,
        viewicon : 'ace-icon fa fa-search-plus grey',
      }
    )

    //replace icons with FontAwesome icons like above
    function updatePagerIcons(table) {
      var replacement =
        {
          'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
          'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
          'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
          'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
        };
      $('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
        var icon = $(this);
        var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
        if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
      })
    }

    $("#btnAdd").on("click", function () {
      layer_show("增加门禁板信息", "/manage/board/adddoor", 530, 480);
      event.stopPropagation();
    });

    $("#searchButton").on("click", function () {
      initDataList();
    });

    $("#btnDel").on("click", function () {
      layer.confirm("确定删除选中的门禁板?", function (index) {
        layer.close(index);
        var ids=$('#grid-table').jqGrid('getGridParam','selarrrow');
        var videoIds = [];
        for(var i=0; i<ids.length; i++)
        {
          var rowData = $("#grid-table").jqGrid('getRowData',ids[i]);
          videoIds.push(rowData.pkid);
        }
        if(videoIds.length==0)
        {
          layer.msg("请选择要删除的门禁板", {icon:2});
          return;
        }
        jQuery.ajax({
          type: "POST",
          data: {"ids":videoIds.join(",")},
          dataType: "text",
          url: "/manage/board/dobatchdel",
          success: function (result) {
            layer.msg("已成功删除", {icon: 1, time: 1000}, function () {
              reloadData();
            });
          },
          error:function () {
            layer.msg("删除失败",{icon:2});
          }
        });
      })
    })

    $("#btnOpenAll").on("click", function () {
        var ids=$('#grid-table').jqGrid('getGridParam','selarrrow');
        var videoIds = [];
        for(var i=0; i<ids.length; i++)
        {
          var rowData = $("#grid-table").jqGrid('getRowData',ids[i]);
          videoIds.push(rowData.pkid);
        }
        if(videoIds.length==0)
        {
          layer.msg("请选择要开门的门禁板", {icon:2});
          return;
        }
        jQuery.ajax({
          type: "POST",
          data: {"ids":videoIds.join(",")},
          dataType: "text",
          url: "/manage/board/doControlDoors",
          success: function (result) {
            layer.msg("开门成功", {icon: 1, time: 1000}, function () {
              reloadData();
            });
          },
          error:function () {
            layer.msg("删除失败",{icon:2});
          }
        });
    })
  });

  function reloadData()
  {
    $("#grid-table").trigger("reloadGrid");
  }

  function modify(id)
  {
    layer_show("编辑门禁板信息", "/manage/board/editdoor?id="+id, 530, 480);
    event.stopPropagation();
  }

  var categoryId = null;
  function initDataList()
  {
    var searchKey = $("#searchKey").val();
    var postJson = {categoryId: categoryId,searchKey:searchKey};
    //传入查询条件参数
    $("#grid-table").jqGrid("setGridParam",{postData:postJson, page:1}).trigger("reloadGrid");
  }

  function del(id, name)
  {
    layer.confirm("确定删除门禁板“"+name+"?", function (index) {
      layer.close(index);
      jQuery.ajax({
        type: "POST",
        data: {"ids":id},
        dataType: "text",
        url: "/manage/board/dobatchdel",
        success: function (result) {
          layer.msg("已成功删除", {icon: 1, time: 1000}, function () {
            reloadData();
          });
        },
        error:function () {
          layer.msg("删除失败",{icon:2});
        }
      });
    })
    event.stopPropagation();
  }

  var currentLayObj;
  function setCurrentLayerObj(obj) {
    currentLayObj = obj;
  }

  function opendoor(ip,sn) {
    jQuery.ajax({
      type: "POST",
      data: {"controllerIP": ip,"controllerSN":sn},
      dataType: "json",
      url: "/manage/board/doControlDoor",
      success: function (result) {
        if(result=="1"){
          layer.msg("开门成功！", { time: 2000 }, function () {
            reloadData();
          });
        }else{
          layer.msg("开门失败！");
        }
      }
    });
    event.stopPropagation();
  }
</script>
