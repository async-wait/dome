import * as types from './mutation-types'

export const selectPlay = function({commit, state}, {list, index}){
    // 歌曲加入到数组
    commit(types.SET_SEQUENCE_LIST, list);
    commit(types.SET_PLAYLIST, list);
    // 获取当前的索引
    commit(types.SET_CURRENT_INDEX, index);
    // 全屏播放
    commit(types.SET_FULL_SCREEN, true);
    // 点击歌曲播放以后，播放状态改为true
    commit(types.SET_PLAY_STATE, true);
}