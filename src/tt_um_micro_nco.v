/* This is a numerical controller oscillator with PDM output.
 *
 * -----------------------------------------------------------------------------
 *
 * Copyright (C) 2024 Gerrit Grutzeck (g.grutzeck@gfg-development.de)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * -----------------------------------------------------------------------------
 *
 * Author   : Gerrit Grutzeck g.grutzeck@gfg-development.de
 * File     : tt_um_micro_nco.v
 * Create   : Sep 6, 2024
 * Revise   : Sep 6, 2024
 * Revision : 1.0
 *
 * -----------------------------------------------------------------------------
 */

`default_nettype none

module tt_um_micro_gfg_development_nco (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
  reg [15 : 0] accu;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      accu        <= 0;
    end else begin
      accu        <= accu + {8'h00, ui_in};
    end
  end

  reg [8 : 0] qe;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      qe          <= 0;
    end else begin
      qe          <= {~qe[8], qe[7 : 0]} + {accu[15], accu[15 : 8]};
    end
  end

  assign uo_out[0]    = qe[8];
  assign uo_out[7:1]  = 0;

endmodule  // tt_um_factory_test
