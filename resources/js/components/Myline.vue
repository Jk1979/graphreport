<script>
//import LineChart from './LineChart'
import { Line, mixins } from 'vue-chartjs'
export default {
  extends: Line,
  mixins: [mixins.reactiveProp],
  name: 'my-line', 
  props: {
    chartData: {
      type: Object,
      default: null
    },
    options: {
      type: Object,
      default: null
    },
    selected: {
      type: Array,
      default: [],
    }
  },

  data() {
    return {
      selectedWatcher: null,
      // lineData: this.chartData
    }
  },
  computed: {
    lineData : {
      get () {
         return this.chartData;
      },
      set($val) {}
    }
    // lineData: function() {
    //   return this.chartData;
    // }
  },
  mounted() {
   
    this.renderChart(this.lineData, this.options);
    this.selectedWatcher = this.$watch('selected', this.updateChart, {
      deep: true
    });
    
  },
  watch: {
    chartData: function() {
      this.$data._chart.destroy();
      //this.renderChart(this.data, this.options);
      this.renderChart(this.lineData, this.options);
    }
  },
  methods: {
    updateChart(newVal) {
      const chart = this.$data._chart;

      // selected `checkbox`.
      const selected = this.$props.selected
        .map((item) => item.checked && item.name);

      this.lineData = {
        // ...this.$props.chartData,
        ...this.chartData,
        datasets: this.$props.chartData.datasets
          .forEach((item) => {
            item.hidden = !selected.includes(item.label)
          })
      }
      
      chart.update();
    }
  }
}
</script>


