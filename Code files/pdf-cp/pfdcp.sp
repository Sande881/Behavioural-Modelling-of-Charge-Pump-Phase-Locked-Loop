#Digital Logic and Testbench for PFD-CP

* Clocks
Vref ref 0 pulse(0 1 1u 1n 1n 10u 20u)
Vfb fb 0 pulse(0 1 5u 1n 1n 10u 20u)


* Bridge
.model my_adc adc_bridge(in_low=0.1 in_high=0.9)
.model my_dac dac_bridge(out_low=0.0 out_high=1.0)
.model my_pullup d_pullup(load=1.0)

* FF & Gate Models
.model my_dff d_dff(clk_delay=50p set_delay=50p reset_delay=50p ic=0)
.model my_and d_and(rise_delay=50p fall_delay=50p)


* Analog Clocks to Digital signal
A_adc_ref [ref] [ref_dig] my_adc
A_adc_fb [fb] [fb_dig] my_adc

* Data pins permanently high in DFF
A_pullup d_high my_pullup

* UP FF
A_dff_up d_high ref_dig NULL reset_dig up_dig NULL my_dff

* DOWN FF
A_dff_dn d_high fb_dig NULL reset_dig dn_dig NULL my_dff

* Reset for DFFs when both high
A_and [up_dig dn_dig] reset_dig my_and

* DAC
A_dac_up [up_dig] [up] my_dac
A_dac_dn [dn_dig] [dn] my_dac

* Charge Pump

.model pfdcp_test pfdcp
N1 up dn output pfdcp_test
C_load output 0 10p


.tran 1n 100u
.end
