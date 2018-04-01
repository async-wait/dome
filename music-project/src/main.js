// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import 'babel-polyfill' // 编译es6 api
import App from './App'
import router from './router'
import VueLazyload from 'vue-lazyload'
import store from './vuex/store'
// 移动端适配问题，采用手淘的lib-flexible插件搭配rem来适配
// 把lib-flexible导入
import "lib-flexible"
// 在入口文件的地方引入less需要注意，用绝对路径
import "./common/less/index.less"

// 采用fastclick插件来解决移动端点击的300ms延迟
import Fastclick from "fastclick"
Fastclick.attach(document.body);

// 图片懒加载插件引入
Vue.use(VueLazyload, {
    error: require('./common/image/default.png'),
    loading: require('./common/image/default.png')
});




Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
    el: '#app',
    router,
    store,
    components: { App },
    template: '<App/>'
})