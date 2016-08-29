<template>
  <div id="notes-list">
    <div id="list-header">
      <h2>Labels</h2>
      <div class="btn-group btn-group-justified" role="group">
        <div class="input-group search">
          <input type="text" class="form-control" v-model="search" placeholder="Search for label...">
          <span class="input-group-addon">
            <i class="glyphicon glyphicon-search"></i>
          </span>
        </div>
      </div>
    </div>

    <!-- 渲染Label列表 -->
    <div class="container">
      <div class="list-group">
        <a v-for="label in labels | filterBy search"
           class="list-group-item"
           href="#"
           :class="{active: activeLabel === label}"
           @click="setActiveLabel(label)">
          <h4 class="list-group-item-heading">
            {{label.name.trim().substring(0,18)}}
          </h4>
        </a>
      </div>
    </div>
  </div>
</template>

<script>
  import {setLabels, updateActiveLabel} from '../vuex/actions';
  import {labels, activeLabel} from '../vuex/getters';
  export default {
    data() {
      return {
        search: '',
      }
    },
    vuex: {
      getters: {
        labels,
        activeLabel
      },
      actions: {
        setLabels,
        updateActiveLabel
      }
    },
    ready: function () {
      this.$http.get('https://api.github.com/repos/bingoogolapple/bingoogolapple.github.io/labels?sort=count-desc').then(function (response) {
        this.setLabels(response.json())
      }, function (response) {
        console.log(response.data);
      });
    },
    methods: {
      setActiveLabel: function (label) {
        this.updateActiveLabel(label)
      }
    }
  }
</script>

<style lang="scss" scoped>
  #notes-list {
    float: left;
    width: 250px;
    height: 100%;
    background-color: #F5F5F5;
    font-family: 'Raleway', sans-serif;
    font-weight: 400;
    #list-header {
      padding: 5px 25px 25px 25px;
      h2 {
        font-weight: 300;
        text-align: center;
        font-size: 22px;
        padding-bottom: 8px;
        color: #009de7;
        border-bottom: 1px dotted #009de7;
        border-bottom-width: 2px;
      }
      .search {
        margin-top: 10px;
      }
    }
    .container {
      height: calc(100% - 204px);
      max-height: calc(100% - 204px);
      overflow: auto;
      width: 100%;
      padding: 0;
      .list-group-item {
        border: 0;
        border-radius: 0;
        .list-group-item-heading {
          font-weight: 300;
          font-size: 15px;
        }
      }
      .active {
        background-color: #2a3541;
      }
    }
  }
</style>
