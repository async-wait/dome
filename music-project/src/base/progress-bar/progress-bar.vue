<template>
  <div class="progress-bar">
      <div class="bar-inner">
          <div class="progress"></div>
          <div class="progress-btn-wrapper">
              <div class="progress-btn"></div>
          </div>
      </div>
  </div>
</template>

<script>
export default {
  
}
</script>

<style lang="less" scoped>
    @import "../../common/less/variable.less";
    @import "../../common/less/mixin.less";
    .progress-bar{
        .px2rem(height, 60);
        .bar-inner{
            position: relative;
            .px2rem(top, 26);
            .px2rem(height, 8);
            background:rgba(0, 0, 0, 0.3);
        }
        .progress{
            position: absolute;
            height: 100%;
            background: @color-theme;
        }
      .progress-btn-wrapper{
        position: absolute;
        .px2rem(left, -16);
        .px2rem(top, -26);
        .px2rem(width, 60);
        .px2rem(height, 60);
        .progress-btn{
            position: relative;
            .px2rem(top, 14);
            .px2rem(left, 14);
            box-sizing: border-box;
            .px2rem(width, 32);
            .px2rem(height, 32);
            border: 3px solid @color-text;
            border-radius: 50%;
            background: @color-theme;
        }
      }
    }
</style>

