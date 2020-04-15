<template>
<div class="container">
  <div class="row">
    <button class="btn btn-primary" @click="update">Get data</button>
    <div class="col-sm-12">
      <line-chart :chart-data="data" :height="100" :options="{responsive: true, maintainAspectRation: true}"></line-chart>
    </div>
  </div>
</div>

</template>
<script>
import LineChart from './LineChart'
export default {
  name: 'ChartlineComponent',
  components: { LineChart },
  data: ()=> ({
    data: []
  }),
  methods: {
    update() {
      axios.get('/chart-data').then(res => {
        this.data = res.data
      })
    }
  }
}
</script>