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
      
      // lineData: {
      //   labels: [
      //     "01.02.2015", "02.02.2015", "04.02.2015", "06.02.2015", "07.02.2015", "07.02.2015",
      //     "08.02.2015", "09.02.2015", "19.02.2015", "21.02.2015", "22.02.2015", "10.02.2015",
      //     "28.02.2015","09.03.2015"
      //   ],
      //   datasets: [{
      //     hidden: false,
      //     label: "Acme",
      //     lineTension: 0,
      //     fill: false,
      //     borderColor: "#466FFF",
      //     backgroundColor: "#ffffff00",
      //     data: [30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41]
      //   }, {
      //     hidden: false,
      //     label: "Microsoft",
      //     lineTension: 0,
      //     fill: false,
      //     borderColor: "#FF4286",
      //     backgroundColor: "#ffffff00",
      //     data: [1200, 1201, 1202, 1203, 1204, 1205, 1206, 1207]
      //   }, {
      //     hidden: false,
      //     label: "Apple",
      //     lineTension: 0,
      //     fill: false,
      //     borderColor: "#31DDA9",
      //     backgroundColor: "#ffffff00",
      //     data: [0,0,0,0,0,0,0,0,0,10000, 100000, 399]
      //   }]
      // }
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