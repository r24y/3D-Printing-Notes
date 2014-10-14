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
    right -x*image_width/image_height
    angle 75 }

// sun -------------------------------------
light_source{<1500,3000,-2500> color White}
light_source {
  y*5, Red * 100
  cylinder
  point_at <0,0,-1>
  radius 0.01
  falloff 0.02
  tightness 0.025
  photons {
    reflection on
    refraction on
  }
  parallel
  point_at <0,0,-1>
  rotate x * 10 translate z * 0.5 rotate y * 0 translate <0,0,0>
}
light_source {
  y*5, Red * 100
  cylinder
  point_at <0,0,-1>
  radius 0.01
  falloff 0.02
  tightness 0.025
  photons {
    reflection on
    refraction on
  }
  parallel
  point_at <0,0,-1>
  rotate x * 10 translate z * 0.5 rotate y * 120 translate <0,0,0>
}
light_source {
  y*5, Red * 100
  cylinder
  point_at <0,0,-1>
  radius 0.01
  falloff 0.02
  tightness 0.025
  photons {
    reflection on
    refraction on
  }
  parallel
  point_at <0,0,-1>
  rotate x * 10 translate z * 0.5 rotate y * 240 translate <0,0,0>
}
box {
    <-1.0,0,-1.0>,<1.0,0.001,1.0>
  texture {
    pigment {
      checker
      color rgb<1,1,1>
      color rgb<0.2,0.2,0.2>
    } scale 0.25
  }
}

box {
    <-1.2,-0.001,-1.2>,
    <1.2, 0, 1.2>
    texture{ pigment{ color White} }
}
