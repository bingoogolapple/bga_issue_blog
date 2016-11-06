<template>
  <div id="issues-list" class="panel panel-default">
    <div class="panel-heading">
      <h2>Issues</h2>
      <div class="btn-group btn-group-justified" role="group">
        <div class="input-group search">
          <input type="text" class="form-control" v-model="search" placeholder="Search for issue...">
          <span class="input-group-addon">
            <i class="glyphicon glyphicon-search"></i>
          </span>
        </div>
      </div>
    </div>
    <div class="panel-body">
      <div class="list-group">
        <a v-for="issue in filteredIssues"
           class="list-group-item"
           href="#"
           :class="{active: activeIssue === issue}"
           @click="setActiveIssue(issue)">
          <h4 class="list-group-item-heading">
            {{issue.title.trim().substring(0,18)}}
          </h4>
        </a>
      </div>
    </div>
  </div>
</template>

<script>
  import {setIssues, updateActiveIssue} from '../vuex/actions'
  import {issues, activeIssue, activeLabel, gitHubUsername} from '../vuex/getters'

  export default {
    data() {
      return {
        search: ''
      }
    },
    vuex: {
      getters: {
        issues,
        activeIssue,
        activeLabel,
        gitHubUsername
      },
      actions: {
        setIssues,
        updateActiveIssue
      }
    },
    watch: {
      activeLabel: function (label) {
        this.$http.get("https://api.github.com/repos/" + this.gitHubUsername + "/" + this.gitHubUsername + ".github.io/issues?labels=" + label.name).then(function (response) {
          this.setIssues(response.json())
        }, function (response) {
          console.log(response.data)
        })
      }
    },
    methods: {
      setActiveIssue: function (issue) {
        this.updateActiveIssue(issue)
      }
    },
    computed: {
      filteredIssues: function () {
        var self = this
        return self.issues.filter(function (issue) {
          return issue.title.toLowerCase().indexOf(self.search.toLowerCase()) != -1 || issue.body.toLowerCase().indexOf(self.search.toLowerCase()) != -1
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  #issues-list {
    margin: 0px;
    float: left;
    width: 270px;
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
