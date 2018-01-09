
set dac_fifo_name axi_ad9371_dacfifo
set dac_fifo_address_width 10
set dac_data_width 128
set dac_dma_data_width 128

source $ad_hdl_dir/projects/common/zc706/zc706_system_bd.tcl
source $ad_hdl_dir/projects/common/zc706/zc706_plddr3_dacfifo_bd.tcl
source ../common/adrv9371x_bd.tcl

ad_ip_parameter sys_ps7 CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ 200
ad_connect sys_dma_clk sys_ps7/FCLK_CLK2
ad_connect sys_ps7/FCLK_RESET2_N sys_dma_rstgen/ext_reset_in

ad_ip_instance util_ds_buf axi_ad9371_tx_bufg
ad_ip_parameter axi_ad9371_tx_bufg CONFIG.C_BUF_TYPE {BUFG}
ad_connect axi_adrv9371x_xcvr_0/txoutclk axi_ad9371_tx_bufg/BUFG_I
ad_connect axi_ad9371_tx_bufg/BUFG_O axi_ad9371_tx_clkgen/clk

ad_ip_instance util_ds_buf axi_ad9371_rx_bufg
ad_ip_parameter axi_ad9371_rx_bufg CONFIG.C_BUF_TYPE {BUFG}
ad_connect axi_adrv9371x_xcvr_0/rxoutclk axi_ad9371_rx_bufg/BUFG_I
ad_connect axi_ad9371_rx_bufg/BUFG_O axi_ad9371_rx_clkgen/clk

ad_ip_instance util_ds_buf axi_ad9371_rx_os_bufg
ad_ip_parameter axi_ad9371_rx_os_bufg CONFIG.C_BUF_TYPE {BUFG}
ad_connect axi_adrv9371x_xcvr_1/rxoutclk axi_ad9371_rx_os_bufg/BUFG_I
ad_connect axi_ad9371_rx_os_bufg/BUFG_O axi_ad9371_rx_os_clkgen/clk

ad_connect axi_adrv9371x_xcvr_0/gt0_rx axi_ad9371_rx_os_jesd/rx_phy0
ad_connect axi_adrv9371x_xcvr_0/gt1_rx axi_ad9371_rx_jesd/rx_phy0
ad_connect axi_adrv9371x_xcvr_1/gt0_rx axi_ad9371_rx_jesd/rx_phy1
ad_connect axi_adrv9371x_xcvr_1/gt1_rx axi_ad9371_rx_os_jesd/rx_phy1

ad_connect axi_ad9371_tx_jesd/tx_phy1 axi_adrv9371x_xcvr_0/gt0_tx
ad_connect axi_ad9371_tx_jesd/tx_phy3 axi_adrv9371x_xcvr_0/gt1_tx
ad_connect axi_ad9371_tx_jesd/tx_phy0 axi_adrv9371x_xcvr_1/gt0_tx
ad_connect axi_ad9371_tx_jesd/tx_phy2 axi_adrv9371x_xcvr_1/gt1_tx

