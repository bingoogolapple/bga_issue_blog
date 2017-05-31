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
  import { mapGetters, mapActions } from 'vuex'

  export default {
    data () {
      return {
        search: ''
      }
    },
    watch: {
      activeLabel: function (label) {
        console.log('activeLabel 改变了')
        this.$http.get('https://api.github.com/repos/' + this.gitHubUsername + '/' + this.gitHubUsername + '.github.io/issues?labels=' + label.name).then(response => {
          this.setIssues(response.data)
        }).catch(response => {
          console.log(response.data)
        })
      }
    },
    computed: {
      ...mapGetters([
        'issues',
        'activeIssue',
        'activeLabel',
        'gitHubUsername'
      ]),
      filteredIssues: function () {
        return this._.filter(this.issues, issue => {
          return this._.toLower(issue.name).indexOf(this._.toLower(this.search)) !== -1
        })
      }
    },
    methods: {
      ...mapActions([
        'setIssues',
        'updateActiveIssue'
      ]),
      setActiveIssue: function (issue) {
        this.updateActiveIssue(issue)
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
