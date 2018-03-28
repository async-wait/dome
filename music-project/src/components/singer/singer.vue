<template>
    <div class="singer">
        <listview :data="singerList" @select="selectSinger"></listview>
        <router-view></router-view>
    </div>
</template>

<script>
    import { getSingerList } from 'api/getSinger'
    import { ERR_OK } from "api/config"
    import Singer from 'common/js/singer'
    import Listview from 'base/listview/listview'
    // 定义常量  “热门”
    const HOT_NAME = "热门"
    // 只获取热门数据的前10条
    const HOT_SINGER_LEN = 10

    export default {
        data(){
            return {
                singerList: []
            }
        },
        created(){
            this._getSingerList();
        },
        methods: {
            selectSinger(item){
                this.$router.push({
                    path: `/singer/${item.id}`
                })
            },
            _getSingerList(){
                getSingerList().then(res => {
                    if(res.code === ERR_OK){
                        this.singerList = this._normallizeSinger(res.data.list);
                    }
                });
            },
            _normallizeSinger(list){
                let map = {
                    hot: {
                        title: HOT_NAME,
                        items: []
                    }
                }
            
                list.forEach( (item, index) => {
                    if(index < HOT_SINGER_LEN){
                        map.hot.items.push(new Singer({
                            id: item.Fsinger_mid,
                            name: item.Fsinger_name
                        }))
                    }
                    const key = item.Findex;
                    if(!map[key]){
                        map[key] = {
                            title: key,
                            items: []
                        }
                    }
                    map[key].items.push(new Singer({
                        id: item.Fsinger_mid,
                        name: item.Fsinger_name
                    }))
                });
                // 对获取到的数据进行处理，整合
                let hot = [];
                let ret = [];
                for(let key in map){
                    // 判断如果title是a-z则保存到ret数组中
                    let val = map[key]
                    if(val.title.match(/[a-zA-Z]/)){
                        ret.push(map[key]);
                    }
                    if(val.title == HOT_NAME){
                        hot.push(map[key]);
                    }
                }
                // 对a-z的对象进行排序
                ret.sort((a, b) => {
                    return a.title.charCodeAt(0) - b.title.charCodeAt(0)
                });
                // 热门数组和排序的数据整合到一个数组里面
                return hot.concat(ret);
            }
        },
        components: {
            Listview
        }
    }
</script>

<style scoped lang="less">
    @import "../../common/less/variable.less";
    @import "../../common/less/mixin.less";
    .singer{
        color: #fff;
        position: fixed;
        width: 100%;
        .px2rem(top,176);
        bottom: 0
    }
</style>

