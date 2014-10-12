#version 3.6;
global_settings{assumed_gamma 1.0}
#default{ finish{ ambient 0.01 diffuse 0.01 }}

background { color rgb <0.005, 0.005, 0.005> }
//------------------------------------------
#include "colors.inc"
#include "textures.inc"

//------------------------------------------
// camera ----------------------------------
camera{ location  <0.0 , 1.0 ,-3.0>
        look_at   <0.0 , 1.0 , 0.0>
        right x*image_width/image_height
        angle 75 }

// sun -------------------------------------
light_source{<1500,3000,-2500> color White}

light_source {
  y * 30, Red * 100
  cylinder
  point_at y * 24
  radius 0.01
  falloff 0.02
  tightness 0.025
  photons {
    reflection on
    refraction on
  }
  parallel
  point_at y * 24
}

box {
  <-1,0,-1>,<1,0.01,1>
  texture {
    pigment {
      checker
      color rgb<1,1,1>
      color rgb<0.2,0.2,0.2>
    } scale 0.25
  }
}
