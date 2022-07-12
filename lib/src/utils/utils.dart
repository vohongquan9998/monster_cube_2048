import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_2048_program_language/src/model/hex_color.dart';

final Map<int, String> tileImage = <int, String>{
  2: 'mon01',
  4: 'mon02',
  8: 'mon03',
  16: 'mon04',
  32: 'mon05',
  64: 'mon06',
  128: 'mon07',
  256: 'mon08',
  512: 'mon09',
  1024: 'mon10',
  2048: 'mon11',
  4096: 'mon12',
  8192: 'mon13',
  16384: 'mon14',
  32768: 'mon15',
  65536: 'mon16',
  131072: 'mon17',
  262144: 'mon18',
  524288: 'mon19',
  1048576: 'mon20',
  2097152: 'mon21',
  4194304: 'mon22',
  8388608: 'mon23',
  16777216: 'mon24',
};

List<int> tileArray = [
  2,
  4,
  8,
  16,
  32,
  64,
  128,
  256,
  512,
  1024,
  2048,
  4096,
  8192,
  16384,
  32768,
  65536,
  131072,
  262144,
  524288,
  1048576,
  2097152,
  4194304,
  8388608,
  16777216,
];

final Map<int, String> tileBlue = <int, String>{
  2: 'mon01_A',
  4: 'mon02_A',
  8: 'mon03_A',
  16: 'mon04_A',
  32: 'mon05_B',
  64: 'mon06_B',
  128: 'mon07_B',
  256: 'mon08_B',
  512: 'mon09_B',
  1024: 'mon10_A',
  2048: 'mon11_B',
  4096: 'mon12_B',
  8192: 'mon13_B',
  16384: 'mon14_B',
  32768: 'mon15_B',
  65536: 'mon16_B',
  131072: 'mon17_B',
  262144: 'mon18_B',
  524288: 'mon19_B',
  1048576: 'mon20_A',
  2097152: 'mon21_A',
  4194304: 'mon22_A',
  8388608: 'mon23_A',
  16777216: 'mon19_G',
};
final Map<int, String> tileRed = <int, String>{
  2: 'mon01_A',
  4: 'mon02_A',
  8: 'mon03_A',
  16: 'mon04_A',
  32: 'mon05_R',
  64: 'mon06_R',
  128: 'mon07_R',
  256: 'mon08_R',
  512: 'mon09_R',
  1024: 'mon10_A',
  2048: 'mon11_R',
  4096: 'mon12_R',
  8192: 'mon13_R',
  16384: 'mon14_R',
  32768: 'mon15_R',
  65536: 'mon16_R',
  131072: 'mon17_R',
  262144: 'mon18_R',
  524288: 'mon19_R',
  1048576: 'mon20_A',
  2097152: 'mon21_A',
  4194304: 'mon22_A',
  8388608: 'mon23_A',
  16777216: 'mon19_B',
};
final Map<int, String> tileGreen = <int, String>{
  2: 'mon01_A',
  4: 'mon02_A',
  8: 'mon03_A',
  16: 'mon04_A',
  32: 'mon05_G',
  64: 'mon06_G',
  128: 'mon07_G',
  256: 'mon08_G',
  512: 'mon09_G',
  1024: 'mon10_A',
  2048: 'mon11_G',
  4096: 'mon12_G',
  8192: 'mon13_G',
  16384: 'mon14_G',
  32768: 'mon15_G',
  65536: 'mon16_G',
  131072: 'mon17_G',
  262144: 'mon18_G',
  524288: 'mon19_G',
  1048576: 'mon20_A',
  2097152: 'mon21_A',
  4194304: 'mon22_A',
  8388608: 'mon23_A',
  16777216: 'mon19_R',
};

final int maxScores = 32000000;
final String HUD_topR = "icon_2048_top_R_hud";
final String HUD_topB = "icon_2048_top_B_hud";
final String HUD_topG = "icon_2048_top_G_hud";

final String HUD_bottomR = "icon_2048_bottom_R_hud";
final String HUD_bottomB = "icon_2048_bottom_B_hud";
final String HUD_bottomG = "icon_2048_bottom_G_hud";

final String HUD_tile_R = "2048frame_R";
final String HUD_tile_B = "2048frame_B_2";
final String HUD_tile_G = "2048frame_G_2";

final String HUD_return_button_R = "icon_2048_return_R";
final String HUD_return_button_B = "icon_2048_return_B";
final String HUD_return_button_G = "icon_2048_return_G";

final String HUD_restart_button_R = "icon_2048_restart_R";
final String HUD_restart_button_B = "icon_2048_restart_B";
final String HUD_restart_button_G = "icon_2048_restart_G";

final String HUD_dex_button_R = "icon_2048_dex_R";
final String HUD_dex_button_B = "icon_2048_dex_B";
final String HUD_dex_button_G = "icon_2048_dex_G";

final String HUD_audioOn_button_R = "icon_2048_audio_on_R";
final String HUD_audioOn_button_B = "icon_2048_audio_on_B";
final String HUD_audioOn_button_G = "icon_2048_audio_on_G";

final String HUD_audioOff_button_R = "icon_2048_audio_off_R";
final String HUD_audioOff_button_B = "icon_2048_audio_off_B";
final String HUD_audioOff_button_G = "icon_2048_audio_off_G";

final String HUD_fx_button_R = "icon_2048_fx_R";
final String HUD_fx_button_B = "icon_2048_fx_B";
final String HUD_fx_button_G = "icon_2048_fx_G";

final String HUD_mon_button_R = "icon_2048_monsters_R";
final String HUD_mon_button_B = "icon_2048_monsters_B";
final String HUD_mon_button_G = "icon_2048_monsters_G";

// final String returnTitle = "icon_2048_return";
// final String restartTitle = "icon_2048_restart";
// final String dexTitle = "icon_2048_dex";
// final String monTitle = "icon_2048_monsters";
// final String audioOnTitle = "icon_2048_audio_on";
// final String audioOffTitle = "icon_2048_audio_off";
final String fxfTitle = "icon_2048_fx";
final String gameOverIconTitle = "2048_gameOver_mon";

final String version = "v0.45";

final int trade_cost = 30;
final double max_height = 650;
final double max_width = 400;

double getSubtringValue(int i, double discout) {
  return ((tileArray[i] + (tileArray[i] * .50)) * 10) / discout;
}

double getSubtringValueTradeMonster(int i, double discout) {
  return (tileArray[i] * 10.0) / discout;
}

RadialGradient bgGradientR = RadialGradient(colors: [
  HexColor("#D2987B"),
  HexColor("#D2987B"),
  HexColor("#D2987B"),
  HexColor("#D2987B"),
  HexColor("#E35280"),
], radius: 1);

RadialGradient bgGradientB = RadialGradient(colors: [
  HexColor("#8BCAE2"),
  HexColor("#8BCAE2"),
  HexColor("#8BCAE2"),
  HexColor("#8BCAE2"),
  HexColor("#29ABE2"),
], radius: 1);

RadialGradient bgGradientG = RadialGradient(colors: [
  HexColor("#51a667"),
  HexColor("#51a667"),
  HexColor("#51a667"),
  HexColor("#51a667"),
  HexColor("#009245"),

// HexColor("#007E45"),
  // HexColor("#00632B"),
], radius: 1);

String down = "Down";
String up = "Up";
String left = "Left";
String right = "Right";

String tutorial1 = "2048_tutorial1";
String tutorial2 = "2048_tutorial2";
String tutorial3 = "2048_tutorial3";

// String easy_img = "stage_easy_tower";
// String normal_img = "stage_normal_tower";
// String hard_img = "stage_hard_tower";
// String master_img = "stage_master_tower";
String easy_img = "stage_easy";
String normal_img = "stage_normal";
String hard_img = "stage_hard";
String master_img = "stage_master";

String R_flag = "2048R_flag";
String G_flag = "2048G_flag";
String B_flag = "2048B_flag";
String Frame_flag = "2048Frame_flag";
