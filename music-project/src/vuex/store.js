import Vue from 'vue'
import Vuex from 'vuex'

import states from './states'
import mutations from './mutations'

Vue.use(Vuex)

const store = new Vuex.Store({
    states,
    mutations
});

export default store