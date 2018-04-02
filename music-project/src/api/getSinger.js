import jsonp from 'common/js/jsonp'
import { commonParams, options } from "./config"

// 歌手组件中，歌手列表的数据
export function getSingerList() {
    const url = "https://c.y.qq.com/v8/fcg-bin/v8.fcg";
    let data = Object.assign({}, commonParams, {
        channel: 'singer',
        page: 'list',
        key: 'all_all_all',
        pagesize: 100,
        pagenum: 1,
        g_tk: 5381,
        loginUin: 0,
        hostUin: 0,
        format: 'jsonp',
        inCharset: 'utf8',
        outCharset: 'utf-8',
        notice: 0,
        platform: 'yqq',
        needNewCode: 0
    });
    return jsonp(url, data, options);
}

// 歌手详情组件的数据信息
export function getSingerDetail(singerId){
    const url = 'https://c.y.qq.com/v8/fcg-bin/fcg_v8_singer_track_cp.fcg'
    let data = Object.assign({}, commonParams, {
        g_tk: 5381,
        loginUin: 0,
        hostUin: 0,
        format: jsonp,
        inCharset: 'utf8',
        outCharset: 'utf-8',
        notice: 0,
        platform: 'yqq',
        needNewCode: 0,
        singermid: singerId,
        order: 'listen',
        begin: 0,
        num: 200,
        songstatus: 1
    });
    return jsonp(url, data, options);
}