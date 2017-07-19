<template>
  <ul class="label-list">
    <li>
      <span class="tag" v-if="activeLabel == null" style="background-color: #3593f2;">ALL</span>
      <span class="tag tag-unchecked" v-else @click="setActiveLabel(null)">ALL</span>
    </li>
    <li v-for="label in labels">
      <span class="tag" v-if="activeLabel != null && activeLabel.name === label.name" @click="setActiveLabel(null)"
            :style="{ backgroundColor: '#' + label.color}">{{label.name}}</span>
      <span v-else class="tag tag-unchecked" @click="setActiveLabel(label)">{{label.name}}</span>
    </li>
  </ul>
</template>
<style lang="scss" scoped>
  .label-list {
    padding: 30px 26px 15px 50px;
    display: inline-block;
    list-style: none;
    li {
      float: left;
      margin-bottom: 15px;
      margin-right: 10px;
    }
  }

  .tag-unchecked {
    background-color: #f2f5f8;
    color: #849aa4;
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
