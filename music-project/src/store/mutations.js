import * as types from './mutation-types'


const mutations = {
    [types.SET_SINGER](state, singer) {
        state.singer = singer
    },
    [types.SET_PLAY_STATE](state, flag) {
        state.playing = flag
    },
    // 设置是否全屏
    [types.SET_FULL_SCREEN](state, flag) {
        state.fullScreen = flag
    },
    [types.SET_PLAYLIST](state, list) {
        state.playlist = list
    },
    [types.SET_SEQUENCE_LIST](state, list) {
        state.sequenceList = list
    },
    [types.SET_MODE](state, mode) {
        state.mode = mode
    },
    // 设置当前歌曲
    [types.SET_CURRENT_INDEX](state, index) {
        state.currentIndex = index
    }
}


export default mutations