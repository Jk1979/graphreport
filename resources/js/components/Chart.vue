<template>
<div class="relative flex items-center">
        <my-line
          v-if="showLine"
          :width="700"
          :height="300"
          :styles="styles"
          :options="options"
          :chart-data="lineData"
          :selected="selected"
        ></my-line>
    </div>

</template>
<script>
import MyLine from './Myline'
export default {
  name: 'chart',
  components: { MyLine},
  props: {
    selected: {
      type: Array,
      default: [],
    },
    lineData: {
      type: Object,
      default: {}
    }
  },
  
  data() {
    return {
      height: 300,
      showLine: false,
      options: {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
          display: false,
        },
        scales: {
		                yAxes: [{
		                    ticks: {
		                        beginAtZero:true
		                    }
		                }],
		                xAxes: [{
		                    display: true,
		                    scaleLabel: {
		                        display: true,
		                        labelString: 'value'
		                    }                        
		                }]                    
		            }
      },
      
      
    };
  },
  computed: {
    styles() {
      return {
        position: 'relative'
      }
    }
  },
  mounted() {
    // axios.get('/chart-data').then(res => {
    //   let lineData = res.data;
    //   lineData.datasets.forEach(dataset => {
    //     dataset.data = Object.keys(dataset.data).map(function(key) {
    //             return dataset.data[key];
    //     })
    //   });
    //   this.lineData = lineData;
    //   this.showLine = true;
    //   })
    
    this.showLine = true;
  }
}
</script>