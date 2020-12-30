<#include "/controls/apptop.ftl"/>
<#include "/controls/topbar.ftl"/>
<#include "/controls/leftmenu.ftl"/>
<style>
  .layui-form-label{
    width: 100px;
  }
</style>
<div class="x-body">
  <form class="layui-form">

    <div style="height:30px;width:10px"></div>
    <div class="layui-form-item">
      <label for="name" class="layui-form-label">
        <span class="x-red"></span>名称
      </label>
      <div class="layui-input-inline">
        <input type="text" id="name" name="name" required="" lay-verify="required"
               autocomplete="off" class="layui-input">
      </div>
    </div>
    <div class="layui-form-item">
      <label for="ip" class="layui-form-label">
        门禁板ip
      </label>
      <div class="layui-input-inline">
        <input type="text" id="ip" name="ip" required=""
               autocomplete="off" class="layui-input">
      </div>
    </div>
    <div class="layui-form-item">
      <label for="sn" class="layui-form-label">
        识别码
      </label>
      <div class="layui-input-inline">
        <input type="text" id="sn" name="sn" required=""
               autocomplete="off" class="layui-input">
      </div>
    </div>
    <div class="layui-form-item">
      <label for="remark" class="layui-form-label">
        备注
      </label>
      <div class="layui-input-inline">
        <input type="text" id="remark" name="remark" required=""
               autocomplete="off" class="layui-input">
      </div>
    </div>
    <div class="layui-form-item">
      <label for="username" class="layui-form-label">
        <span class="x-red">*</span>所属类别
      </label>
      <div class="layui-input-inline">
        <select id="categoryid" name="categoryid" lay-verify="required">
          <option value="0">请选择终端屏所属类别</option>
          <#if (categoryList)?exists && (categoryList?size>0)>
            <#list categoryList as item>
              <option value="${item.pkid}">${item.name}</option>
            </#list>
          </#if>
        </select>
      </div>
    </div>
    <div class="layui-form-item" style="padding-left: 110px">
      <button class="layui-btn" lay-filter="add" lay-submit="">
        增加
      </button>
    </div>
  </form>
</div>
<script>
  layui.use(['form', 'layer'], function () {
    $ = layui.jquery;
    var form = layui.form
      , layer = layui.layer;


    //监听提交
    form.on('submit(add)', function (data) {
      if ($(this).hasClass("layui-btn-disabled")) return;
      $(this).addClass("layui-btn-disabled");
      $(this).text("添加中...");
      var obj = $(this);
      jQuery.ajax({
        type: "POST",
        data: data.field,
        dataType: "json",
        url: "/manage/board/doadd",
        success: function (result) {
          if (result == "0") {
            layer.alert("当门禁已存在！", {icon: 6});
            obj.removeClass("layui-btn-disabled");
            obj.text("增加");
          } else {
            layer.alert("增加成功", {icon: 6}, function () {
              // 获得frame索引
              var index = parent.layer.getFrameIndex(window.name);
              //关闭当前frame
              parent.layer.close(index);
              parent.reloadData();
            });
          }
        }
      });
      return false;
    });


  });
</script>

<#include "/controls/appbottom.ftl"/>
