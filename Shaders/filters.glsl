
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 texOffset;

uniform float values[9];
uniform float coeff;
uniform bool lum;

varying vec4 vertColor;
varying vec4 vertTexCoord; //texture coordinates of a fragment

const vec4 lumcoeff = vec4(0.299, 0.587, 0.114, 0);
//texOffset (=vec2(1/width, 1/height))
void main() {

  vec4 sum = vec4(0.0);
  vec2 tc[9];
  vec4 col;

  tc[0] = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t);
  tc[1] = vertTexCoord.st + vec2(         0.0, -texOffset.t);
  tc[2] = vertTexCoord.st + vec2(+texOffset.s, -texOffset.t);
  tc[3] = vertTexCoord.st + vec2(-texOffset.s,          0.0); //is the texel exactly one position to the right.
  tc[4] = vertTexCoord.st + vec2(         0.0,          0.0);
  tc[5] = vertTexCoord.st + vec2(+texOffset.s,          0.0);
  tc[6] = vertTexCoord.st + vec2(-texOffset.s, +texOffset.t);
  tc[7] = vertTexCoord.st + vec2(         0.0, +texOffset.t);
  tc[8] = vertTexCoord.st + vec2(+texOffset.s, +texOffset.t);

  for(int i=0; i<9; i++){
	col = texture2D(texture, tc[i]); //Returns a texel:the neighboring pixels in the texture 
	sum += values[i] * col;
  }
  sum *= coeff;
  
   if(lum){
	float lum = dot(sum, lumcoeff);
	gl_FragColor = vec4(lum, lum, lum, 1.0) * vertColor;  
   }
   else
	gl_FragColor = vec4(sum.rgb, 1.0) * vertColor;
   
}