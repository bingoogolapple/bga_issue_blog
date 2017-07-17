<template>
  <ul class="label-list">
    <li>
      <span v-if="activeLabel == null">
        <el-tag :color="'#3593f2'" style="color: #ffffff;">ALL</el-tag>
      </span>
      <span v-else @click="setActiveLabel(null)">
        <el-tag :color="'#f2f5f8'">ALL</el-tag>
      </span>
    </li>
    <li v-for="label in labels">
      <span v-if="activeLabel != null && activeLabel.name === label.name">
        <el-tag :color="'#' + label.color" style="color: #ffffff;">{{label.name}}</el-tag>
      </span>
      <span v-else @click="setActiveLabel(label)">
        <el-tag :color="'#f2f5f8'">{{label.name}}</el-tag>
      </span>
    </li>
  </ul>
</template>
<style lang="scss" scoped>
  .label-list {
    padding: 18px 36px;
    display: block;
    list-style: none;
    li {
      float: left;
      margin: 12px;
      cursor: pointer;
      span {
        color: #849aa4;
        height: 30px;
        line-height: 30px;
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
    }
  }
</script>
