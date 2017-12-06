`timescale 1ns / 10ps

module Top_tb();

reg clk;
reg reset;
reg [15:0] weight1;

wire [15:0] ans [9:0][9:0];
wire weight2_loadNextRow;

Top DUT(
.clk(clk),
.reset(reset),
.weight1(weight1),
.ans(ans)
);

initial
begin
$dumpfile("Top.vcd");
$dumpvars(0, Top_tb);



$finish;
end


always
  #10 clk = !clk;

//Refresh weight2 row 
reg [4:0] count;
always @ (posedge weight2_loadNextRow)
count <= count + 1;
begin
case(count)

0: $readmemb("2w_0.txt", DUT.WEIGHT_2.mem_w2);
1: $readmemb("2w_1.txt", DUT.WEIGHT_2.mem_w2);
2: $readmemb("2w_2.txt", DUT.WEIGHT_2.mem_w2);
3: $readmemb("2w_3.txt", DUT.WEIGHT_2.mem_w2);
4: $readmemb("2w_4.txt", DUT.WEIGHT_2.mem_w2);
5: $readmemb("2w_5.txt", DUT.WEIGHT_2.mem_w2);
6: $readmemb("2w_6.txt", DUT.WEIGHT_2.mem_w2);
7: $readmemb("2w_7.txt", DUT.WEIGHT_2.mem_w2);
8: $readmemb("2w_8.txt", DUT.WEIGHT_2.mem_w2);
9: $readmemb("2w_9.txt", DUT.WEIGHT_2.mem_w2);
10: $readmemb("2w_10.txt", DUT.WEIGHT_2.mem_w2);
11: $readmemb("2w_11.txt", DUT.WEIGHT_2.mem_w2);
12: $readmemb("2w_12.txt", DUT.WEIGHT_2.mem_w2);
13: $readmemb("2w_13.txt", DUT.WEIGHT_2.mem_w2);
14: $readmemb("2w_14.txt", DUT.WEIGHT_2.mem_w2);
15: $readmemb("2w_15.txt", DUT.WEIGHT_2.mem_w2);
16: $readmemb("2w_16.txt", DUT.WEIGHT_2.mem_w2);
17: $readmemb("2w_17.txt", DUT.WEIGHT_2.mem_w2);
18: $readmemb("2w_18.txt", DUT.WEIGHT_2.mem_w2);
19: $readmemb("2w_19.txt", DUT.WEIGHT_2.mem_w2);
20: $readmemb("2w_20.txt", DUT.WEIGHT_2.mem_w2);
21: $readmemb("2w_21.txt", DUT.WEIGHT_2.mem_w2);
22: $readmemb("2w_22.txt", DUT.WEIGHT_2.mem_w2);
23: $readmemb("2w_23.txt", DUT.WEIGHT_2.mem_w2);
24: $readmemb("2w_24.txt", DUT.WEIGHT_2.mem_w2);
25: $readmemb("2w_25.txt", DUT.WEIGHT_2.mem_w2);
26: $readmemb("2w_26.txt", DUT.WEIGHT_2.mem_w2);
27: $readmemb("2w_27.txt", DUT.WEIGHT_2.mem_w2);
28: $readmemb("2w_28.txt", DUT.WEIGHT_2.mem_w2);
29: $readmemb("2w_29.txt", DUT.WEIGHT_2.mem_w2);
30: $readmemb("2w_30.txt", DUT.WEIGHT_2.mem_w2);
31: $readmemb("2w_31.txt", DUT.WEIGHT_2.mem_w2);
32: $readmemb("2w_32.txt", DUT.WEIGHT_2.mem_w2);
33: $readmemb("2w_33.txt", DUT.WEIGHT_2.mem_w2);
34: $readmemb("2w_34.txt", DUT.WEIGHT_2.mem_w2);
35: $readmemb("2w_35.txt", DUT.WEIGHT_2.mem_w2);
36: $readmemb("2w_36.txt", DUT.WEIGHT_2.mem_w2);
37: $readmemb("2w_37.txt", DUT.WEIGHT_2.mem_w2);
38: $readmemb("2w_38.txt", DUT.WEIGHT_2.mem_w2);
39: $readmemb("2w_39.txt", DUT.WEIGHT_2.mem_w2);
40: $readmemb("2w_40.txt", DUT.WEIGHT_2.mem_w2);
41: $readmemb("2w_41.txt", DUT.WEIGHT_2.mem_w2);
42: $readmemb("2w_42.txt", DUT.WEIGHT_2.mem_w2);
43: $readmemb("2w_43.txt", DUT.WEIGHT_2.mem_w2);
44: $readmemb("2w_44.txt", DUT.WEIGHT_2.mem_w2);
45: $readmemb("2w_45.txt", DUT.WEIGHT_2.mem_w2);
46: $readmemb("2w_46.txt", DUT.WEIGHT_2.mem_w2);
47: $readmemb("2w_47.txt", DUT.WEIGHT_2.mem_w2);
48: $readmemb("2w_48.txt", DUT.WEIGHT_2.mem_w2);
49: $readmemb("2w_49.txt", DUT.WEIGHT_2.mem_w2);
50: $readmemb("2w_50.txt", DUT.WEIGHT_2.mem_w2);
51: $readmemb("2w_51.txt", DUT.WEIGHT_2.mem_w2);
52: $readmemb("2w_52.txt", DUT.WEIGHT_2.mem_w2);
53: $readmemb("2w_53.txt", DUT.WEIGHT_2.mem_w2);
54: $readmemb("2w_54.txt", DUT.WEIGHT_2.mem_w2);
55: $readmemb("2w_55.txt", DUT.WEIGHT_2.mem_w2);
56: $readmemb("2w_56.txt", DUT.WEIGHT_2.mem_w2);
57: $readmemb("2w_57.txt", DUT.WEIGHT_2.mem_w2);
58: $readmemb("2w_58.txt", DUT.WEIGHT_2.mem_w2);
59: $readmemb("2w_59.txt", DUT.WEIGHT_2.mem_w2);
60: $readmemb("2w_60.txt", DUT.WEIGHT_2.mem_w2);
61: $readmemb("2w_61.txt", DUT.WEIGHT_2.mem_w2);
62: $readmemb("2w_62.txt", DUT.WEIGHT_2.mem_w2);
63: $readmemb("2w_63.txt", DUT.WEIGHT_2.mem_w2);
64: $readmemb("2w_64.txt", DUT.WEIGHT_2.mem_w2);
65: $readmemb("2w_65.txt", DUT.WEIGHT_2.mem_w2);
66: $readmemb("2w_66.txt", DUT.WEIGHT_2.mem_w2);
67: $readmemb("2w_67.txt", DUT.WEIGHT_2.mem_w2);
68: $readmemb("2w_68.txt", DUT.WEIGHT_2.mem_w2);
69: $readmemb("2w_69.txt", DUT.WEIGHT_2.mem_w2);
70: $readmemb("2w_70.txt", DUT.WEIGHT_2.mem_w2);
71: $readmemb("2w_71.txt", DUT.WEIGHT_2.mem_w2);
72: $readmemb("2w_72.txt", DUT.WEIGHT_2.mem_w2);
73: $readmemb("2w_73.txt", DUT.WEIGHT_2.mem_w2);
74: $readmemb("2w_74.txt", DUT.WEIGHT_2.mem_w2);
75: $readmemb("2w_75.txt", DUT.WEIGHT_2.mem_w2);
76: $readmemb("2w_76.txt", DUT.WEIGHT_2.mem_w2);
77: $readmemb("2w_77.txt", DUT.WEIGHT_2.mem_w2);
78: $readmemb("2w_78.txt", DUT.WEIGHT_2.mem_w2);
79: $readmemb("2w_79.txt", DUT.WEIGHT_2.mem_w2);
80: $readmemb("2w_80.txt", DUT.WEIGHT_2.mem_w2);
81: $readmemb("2w_81.txt", DUT.WEIGHT_2.mem_w2);
82: $readmemb("2w_82.txt", DUT.WEIGHT_2.mem_w2);
83: $readmemb("2w_83.txt", DUT.WEIGHT_2.mem_w2);
84: $readmemb("2w_84.txt", DUT.WEIGHT_2.mem_w2);
85: $readmemb("2w_85.txt", DUT.WEIGHT_2.mem_w2);
86: $readmemb("2w_86.txt", DUT.WEIGHT_2.mem_w2);
87: $readmemb("2w_87.txt", DUT.WEIGHT_2.mem_w2);
88: $readmemb("2w_88.txt", DUT.WEIGHT_2.mem_w2);
89: $readmemb("2w_89.txt", DUT.WEIGHT_2.mem_w2);
90: $readmemb("2w_90.txt", DUT.WEIGHT_2.mem_w2);
91: $readmemb("2w_91.txt", DUT.WEIGHT_2.mem_w2);
92: $readmemb("2w_92.txt", DUT.WEIGHT_2.mem_w2);
93: $readmemb("2w_93.txt", DUT.WEIGHT_2.mem_w2);
94: $readmemb("2w_94.txt", DUT.WEIGHT_2.mem_w2);
95: $readmemb("2w_95.txt", DUT.WEIGHT_2.mem_w2);
96: $readmemb("2w_96.txt", DUT.WEIGHT_2.mem_w2);
97: $readmemb("2w_97.txt", DUT.WEIGHT_2.mem_w2);
98: $readmemb("2w_98.txt", DUT.WEIGHT_2.mem_w2);
99: $readmemb("2w_99.txt", DUT.WEIGHT_2.mem_w2);
100: $readmemb("2w_100.txt", DUT.WEIGHT_2.mem_w2);
101: $readmemb("2w_101.txt", DUT.WEIGHT_2.mem_w2);
102: $readmemb("2w_102.txt", DUT.WEIGHT_2.mem_w2);
103: $readmemb("2w_103.txt", DUT.WEIGHT_2.mem_w2);
104: $readmemb("2w_104.txt", DUT.WEIGHT_2.mem_w2);
105: $readmemb("2w_105.txt", DUT.WEIGHT_2.mem_w2);
106: $readmemb("2w_106.txt", DUT.WEIGHT_2.mem_w2);
107: $readmemb("2w_107.txt", DUT.WEIGHT_2.mem_w2);
108: $readmemb("2w_108.txt", DUT.WEIGHT_2.mem_w2);
109: $readmemb("2w_109.txt", DUT.WEIGHT_2.mem_w2);
110: $readmemb("2w_110.txt", DUT.WEIGHT_2.mem_w2);
111: $readmemb("2w_111.txt", DUT.WEIGHT_2.mem_w2);
112: $readmemb("2w_112.txt", DUT.WEIGHT_2.mem_w2);
113: $readmemb("2w_113.txt", DUT.WEIGHT_2.mem_w2);
114: $readmemb("2w_114.txt", DUT.WEIGHT_2.mem_w2);
115: $readmemb("2w_115.txt", DUT.WEIGHT_2.mem_w2);
116: $readmemb("2w_116.txt", DUT.WEIGHT_2.mem_w2);
117: $readmemb("2w_117.txt", DUT.WEIGHT_2.mem_w2);
118: $readmemb("2w_118.txt", DUT.WEIGHT_2.mem_w2);
119: $readmemb("2w_119.txt", DUT.WEIGHT_2.mem_w2);
120: $readmemb("2w_120.txt", DUT.WEIGHT_2.mem_w2);
121: $readmemb("2w_121.txt", DUT.WEIGHT_2.mem_w2);
122: $readmemb("2w_122.txt", DUT.WEIGHT_2.mem_w2);
123: $readmemb("2w_123.txt", DUT.WEIGHT_2.mem_w2);
124: $readmemb("2w_124.txt", DUT.WEIGHT_2.mem_w2);
125: $readmemb("2w_125.txt", DUT.WEIGHT_2.mem_w2);
126: $readmemb("2w_126.txt", DUT.WEIGHT_2.mem_w2);
127: $readmemb("2w_127.txt", DUT.WEIGHT_2.mem_w2);
128: $readmemb("2w_128.txt", DUT.WEIGHT_2.mem_w2);
129: $readmemb("2w_129.txt", DUT.WEIGHT_2.mem_w2);
130: $readmemb("2w_130.txt", DUT.WEIGHT_2.mem_w2);
131: $readmemb("2w_131.txt", DUT.WEIGHT_2.mem_w2);
132: $readmemb("2w_132.txt", DUT.WEIGHT_2.mem_w2);
133: $readmemb("2w_133.txt", DUT.WEIGHT_2.mem_w2);
134: $readmemb("2w_134.txt", DUT.WEIGHT_2.mem_w2);
135: $readmemb("2w_135.txt", DUT.WEIGHT_2.mem_w2);
136: $readmemb("2w_136.txt", DUT.WEIGHT_2.mem_w2);
137: $readmemb("2w_137.txt", DUT.WEIGHT_2.mem_w2);
138: $readmemb("2w_138.txt", DUT.WEIGHT_2.mem_w2);
139: $readmemb("2w_139.txt", DUT.WEIGHT_2.mem_w2);
140: $readmemb("2w_140.txt", DUT.WEIGHT_2.mem_w2);
141: $readmemb("2w_141.txt", DUT.WEIGHT_2.mem_w2);
142: $readmemb("2w_142.txt", DUT.WEIGHT_2.mem_w2);
143: $readmemb("2w_143.txt", DUT.WEIGHT_2.mem_w2);
144: $readmemb("2w_144.txt", DUT.WEIGHT_2.mem_w2);
145: $readmemb("2w_145.txt", DUT.WEIGHT_2.mem_w2);
146: $readmemb("2w_146.txt", DUT.WEIGHT_2.mem_w2);
147: $readmemb("2w_147.txt", DUT.WEIGHT_2.mem_w2);
148: $readmemb("2w_148.txt", DUT.WEIGHT_2.mem_w2);
149: $readmemb("2w_149.txt", DUT.WEIGHT_2.mem_w2);
150: $readmemb("2w_150.txt", DUT.WEIGHT_2.mem_w2);
151: $readmemb("2w_151.txt", DUT.WEIGHT_2.mem_w2);
152: $readmemb("2w_152.txt", DUT.WEIGHT_2.mem_w2);
153: $readmemb("2w_153.txt", DUT.WEIGHT_2.mem_w2);
154: $readmemb("2w_154.txt", DUT.WEIGHT_2.mem_w2);
155: $readmemb("2w_155.txt", DUT.WEIGHT_2.mem_w2);
156: $readmemb("2w_156.txt", DUT.WEIGHT_2.mem_w2);
157: $readmemb("2w_157.txt", DUT.WEIGHT_2.mem_w2);
158: $readmemb("2w_158.txt", DUT.WEIGHT_2.mem_w2);
159: $readmemb("2w_159.txt", DUT.WEIGHT_2.mem_w2);
160: $readmemb("2w_160.txt", DUT.WEIGHT_2.mem_w2);
161: $readmemb("2w_161.txt", DUT.WEIGHT_2.mem_w2);
162: $readmemb("2w_162.txt", DUT.WEIGHT_2.mem_w2);
163: $readmemb("2w_163.txt", DUT.WEIGHT_2.mem_w2);
164: $readmemb("2w_164.txt", DUT.WEIGHT_2.mem_w2);
165: $readmemb("2w_165.txt", DUT.WEIGHT_2.mem_w2);
166: $readmemb("2w_166.txt", DUT.WEIGHT_2.mem_w2);
167: $readmemb("2w_167.txt", DUT.WEIGHT_2.mem_w2);
168: $readmemb("2w_168.txt", DUT.WEIGHT_2.mem_w2);
169: $readmemb("2w_169.txt", DUT.WEIGHT_2.mem_w2);
170: $readmemb("2w_170.txt", DUT.WEIGHT_2.mem_w2);
171: $readmemb("2w_171.txt", DUT.WEIGHT_2.mem_w2);
172: $readmemb("2w_172.txt", DUT.WEIGHT_2.mem_w2);
173: $readmemb("2w_173.txt", DUT.WEIGHT_2.mem_w2);
174: $readmemb("2w_174.txt", DUT.WEIGHT_2.mem_w2);
175: $readmemb("2w_175.txt", DUT.WEIGHT_2.mem_w2);
176: $readmemb("2w_176.txt", DUT.WEIGHT_2.mem_w2);
177: $readmemb("2w_177.txt", DUT.WEIGHT_2.mem_w2);
178: $readmemb("2w_178.txt", DUT.WEIGHT_2.mem_w2);
179: $readmemb("2w_179.txt", DUT.WEIGHT_2.mem_w2);
180: $readmemb("2w_180.txt", DUT.WEIGHT_2.mem_w2);
181: $readmemb("2w_181.txt", DUT.WEIGHT_2.mem_w2);
182: $readmemb("2w_182.txt", DUT.WEIGHT_2.mem_w2);
183: $readmemb("2w_183.txt", DUT.WEIGHT_2.mem_w2);
184: $readmemb("2w_184.txt", DUT.WEIGHT_2.mem_w2);
185: $readmemb("2w_185.txt", DUT.WEIGHT_2.mem_w2);
186: $readmemb("2w_186.txt", DUT.WEIGHT_2.mem_w2);
187: $readmemb("2w_187.txt", DUT.WEIGHT_2.mem_w2);
188: $readmemb("2w_188.txt", DUT.WEIGHT_2.mem_w2);
189: $readmemb("2w_189.txt", DUT.WEIGHT_2.mem_w2);
190: $readmemb("2w_190.txt", DUT.WEIGHT_2.mem_w2);
191: $readmemb("2w_191.txt", DUT.WEIGHT_2.mem_w2);
192: $readmemb("2w_192.txt", DUT.WEIGHT_2.mem_w2);
193: $readmemb("2w_193.txt", DUT.WEIGHT_2.mem_w2);
194: $readmemb("2w_194.txt", DUT.WEIGHT_2.mem_w2);
195: $readmemb("2w_195.txt", DUT.WEIGHT_2.mem_w2);
196: $readmemb("2w_196.txt", DUT.WEIGHT_2.mem_w2);
197: $readmemb("2w_197.txt", DUT.WEIGHT_2.mem_w2);
198: $readmemb("2w_198.txt", DUT.WEIGHT_2.mem_w2);
199: $readmemb("2w_199.txt", DUT.WEIGHT_2.mem_w2);

endcase
end



endmodule
