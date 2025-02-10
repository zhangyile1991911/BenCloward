#ifndef CIRCLE_SDF_CGINC
#define CIRCLE_SDF_CGINC
#include "Common.cginc"
void CircleSDF(float2 uv,float2 size,float edgeMin,float edgeMax,float strokeThickness,float bstrokeThicknessRelative,
out float fill,out float stroke,out float sdf,out float sdfStroke)
{
    //将圆心偏移到中心
    uv = uv * 2.f;
    uv = uv - 1.f;
    //计算半径长度
    float dist = length(uv,float2(0.f,0.f));
    //计算描边长度相关
    float isRelative = step(0.5,bstrokeThicknessRelative);
    strokeThickness = size * strokeThickness * isRelative;
    float lerpA = size - strokeThickness;
    float lerpB = size + strokeThickness;
    float thicknessLerp = lerp(lerpA,lerpB,0.5f);
    //sign distance field
    sdf = dist - thicknessLerp;
    stroke = inverseLerp(edgeMin,edgeMax,sdf);
    float edgeResult = 1.f - stroke;
    fill = saturate(edgeResult);
    //描边
    sdfStroke = absolute(sdf) - strokeThickness;
    //
    stroke = inverseLerp(edgemin)
}
#endif