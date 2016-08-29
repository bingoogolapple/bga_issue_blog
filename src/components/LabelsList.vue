<template>
  <div id="notes-list">
    <div id="list-header">
      <h2>Label</h2>
    </div>

    <!-- 渲染Label列表 -->
    <div class="container">
      <div class="list-group">
        <a v-for="label in labels" class="list-group-item" href="#">
          <h4 class="list-group-item-heading">
            {{label.name}}
          </h4>
        </a>
      </div>
    </div>
  </div>
</template>

<script>
  import { setLabels } from '../vuex/actions';
  import {labels} from '../vuex/getters';
  export default {
    data() {
      return {
        search: ''
      }
    },
    vuex: {
      getters: {
        labels
      },
      actions: {
        setLabels
      }
    },
    ready: function () {
      this.$http.get('https://api.github.com/repos/bingoogolapple/bingoogolapple.github.io/labels').then(function (response) {
        this.setLabels(response.json())
      }, function (response) {
        console.log(response.data);
      });
    }
  }
</script>

<style lang="scss" scoped>
  #notes-list {
    float: left;
    width: 300px;
    height: 100%;
    background-color: #F5F5F5;
    font-family: 'Raleway', sans-serif;
    font-weight: 400;
    #list-header {
      padding: 5px 25px 25px 25px;
      h2 {
        font-weight: 300;
        text-transform: uppercase;
        text-align: center;
        font-size: 22px;
        padding-bottom: 8px;
      }
      .search {
        margin-top: 20px;
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
    }
  }
</style>
