<template>
  <el-card class="label-list">
    <ul>
      <li v-for="label in labels">
        <el-tag v-if="activeLabel != null && activeLabel.name === label.name" :closable="true"
                @close="setActiveLabel(null)" class="m5" :color="'#' + label.color">{{label.name}}
        </el-tag>
        <span v-else class="tag" @click="setActiveLabel(label)">
          <el-tag class="m5" :color="'#' + label.color">{{label.name}}</el-tag>
        </span>
      </li>
    </ul>
  </el-card>
</template>
<style lang="scss" scoped>
  .label-list {
    position: fixed;
    left: 0px;
    top: 50px;
    bottom: 0px;
    width: 150px;
    border-radius: 0px;
    font-size: 1.4em;
    li {
      list-style-type: none;
      span {
        font-size: 18px;
      }
    }
  }
</style>
<script>
  import { mapGetters, mapActions } from 'vuex'

  export default {
    computed: {
      ...mapGetters([
        'labels',
        'activeLabel'
      ])
    },
    methods: {
      ...mapActions([
        'setLabels',
        'updateActiveLabel'
      ]),
      setActiveLabel (label) {
        this.updateActiveLabel(label)
        this.$router.replace('/')
      }
    },
    mounted: function () {
      this.$nextTick(function () {
        this.$gitHubApi.getLabels(this).then(response => {
          this.setLabels(response.data)
        }).catch(response => {
          console.log(response.data)
        })
      })
    }
  }
</script>
