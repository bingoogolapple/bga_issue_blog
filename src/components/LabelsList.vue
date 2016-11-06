<template>
  <div id="labels-list" class="panel panel-default">
    <div class="panel-heading">
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
    <div class="panel-body">
      <div class="list-group">
        <a v-for="label in filteredLabels"
           class="list-group-item"
           href="#"
           :class="{active: activeLabel.name === label.name}"
           @click="updateActiveLabel(label)">
          <h4 class="list-group-item-heading">
            {{label.name.trim().substring(0,18)}}
          </h4>
        </a>
      </div>
    </div>
  </div>
</template>

<script>
  import {setLabels, updateActiveLabel} from '../vuex/actions'
  import {labels, activeLabel, gitHubUsername} from '../vuex/getters'

  export default {
    data() {
      return {
        search: '',
      }
    },
    vuex: {
      getters: {
        labels,
        activeLabel,
        gitHubUsername
      },
      actions: {
        setLabels,
        updateActiveLabel
      }
    },
    computed: {
      filteredLabels: function () {
        var self = this
        return self.labels.filter(function (label) {
          return label.name.toLowerCase().indexOf(self.search.toLowerCase()) != -1
        })
      }
    },
    mounted: function () {
      this.$nextTick(function () {
        this.$http.get("https://api.github.com/repos/" + this.gitHubUsername + "/" + this.gitHubUsername + ".github.io/labels?sort=count-desc").then(function (response) {
          this.setLabels(response.json())
        }, function (response) {
          console.log(response.data)
        })
      })
    }
  }
</script>

<style lang="scss" scoped>
  #labels-list {
    margin: 0px;
    float: left;
    width: 240px;
    height: 100%;
    background-color: #F5F5F5;
    font-family: 'Raleway', sans-serif;
    font-weight: 400;
    .panel-heading {
      padding: 5px 25px 25px 25px;
      h2 {
        font-weight: 300;
        text-align: center;
        font-size: 22px;
        padding-bottom: 8px;
        color: #5079B4;
        border-bottom: 1px dotted #5079B4;
        border-bottom-width: 2px;
      }
      .search {
        margin-top: 10px;
      }
    }
    .panel-body {
      height: calc(100% - 140px);
      padding: 0px;
      margin: 0px;
      .list-group {
        margin: 0px;
        height: 100%;
        overflow-y: auto;
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
  }
</style>
