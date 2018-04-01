import Vue from 'vue'
import Vuex from 'vuex'

import states from './states'
import mutations from './mutations'
import * as getters from './getters'
import * as actions from './actions'
// 通过mutation修改state可以用logger来查看
import createLogger from 'vuex/dist/logger'
Vue.use(Vuex)


// 检测工具来检测state是否是通过mutation来修改,如果不是通过mutation来修改会报错
// 该模式存在损耗，只在开发环境中使用
const debug = process.env.NODE_ENV !== "production"

const store = new Vuex.Store({
    states,
    mutations,
    getters,
    actions,
    strict: debug,
    plugins: debug ? [createLogger()] : [] 
});

export default store