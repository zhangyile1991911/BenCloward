#ifndef CIRCLE_SDF_CGINC
#define CIRCLE_SDF_CGINC
#include "Common.cginc"
void CircleSDF(float2 uv,float size,float edgeMin,float edgeMax,
float strokeThickness,float bstrokeThicknessRelative,
out float fill,out float stroke,out float sdf,out float sdfStroke)
{
    //将圆心偏移到中心 映射 [-1,1] 范围
    uv = uv * 2.f  - 1.f;
    
    //计算圆心距
    float dist = length(uv);

    //计算描边长度相关
    float isRelative = step(0.5,bstrokeThicknessRelative);
    strokeThickness = strokeThickness * (isRelative * size + (1.0 - isRelative));

    float lerpA = size - strokeThickness;
    float lerpB = size + strokeThickness;
    float thicknessLerp = lerp(lerpA,lerpB,0.5f);

    //sign distance field
    float sdfCenter = size - strokeThickness * 0.5f;
    sdf = dist - sdfCenter;

    //计算填充
    fill = 1.0f - inverseLerp(edgeMin,edgeMax,sdf);
    fill = saturate(fill);

    stroke = inverseLerp(edgeMin,edgeMax,sdf);
    float edgeResult = 1.f - stroke;
    //描边
    sdfStroke = abs(sdf) - strokeThickness * 0.5f;
    stroke = 1.0f - inverseLerp(edgeMin,edgeMax,sdfStroke);
    stroke = saturate(stroke);
}

void CircleSDF_float(float2 uv, float size, float edgeMin, float edgeMax,
                     float strokeThickness, float bstrokeThicknessRelative,
                     out float fill, out float stroke, out float sdf, out float sdfStroke)
{
    CircleSDF(uv, size, edgeMin, edgeMax, strokeThickness, bstrokeThicknessRelative, fill, stroke, sdf, sdfStroke);
}
#endif