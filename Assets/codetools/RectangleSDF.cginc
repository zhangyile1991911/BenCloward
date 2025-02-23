#ifndef RECTANGLE_SDF_CGINC
#define RECTANGLE_SDF_CGINC
#include "Common.cginc"

void RectangleSDF(float2 uv,float2 size,float edgeMin,float edgeMax,
float4 CornerRadius,
float strokeThickness,float isRelative,
float strokeDimension,float2 widthHeight,
float keepAspectRatio,
out float fill,out float stroke,out float sdf,out float sdfStroke)
{
    fill = 0.f;
    stroke = 0.f;
    sdfStroke = 0.f;
    //映射 [-1,1] 范围
    float2 remapUV = abs(uv * 2.0f - 1.0f);
    
    //如果相关的话,index = 1 反之 index = 0
    float relativeIndex = step(0.5f,isRelative);
    float strokeResult = (strokeDimension * strokeThickness) * relativeIndex + strokeThickness * (1.f - relativeIndex);

    float keepAspectIndex = step(0.5f,keepAspectRatio);
    float aspectValue = keepAspectIndex * widthHeight + (1.0f - keepAspectIndex) * float2(1.0f,1.0f);
    
    //找到描边中间值
    float lerpA = size - strokeResult;
    float lerpB = size + strokeResult;
    float lerpResultA = lerp(lerpA,lerpB,float2(0.5f,0.5f));
    //是否需要保持比率 + 四个角角度
    float cornerValue = 0.f; 
    RoundedCorners(uv,CornerRadius,cornerValue);
    float2 tmp = (remapUV - lerpResultA) * aspectValue + cornerValue;
    float toZeroLength = length(max(tmp,float2(0.f,0.f)));
    float fromZeroValue = min(max(tmp.x,tmp.y),0.f);
    // 获取sdf
    sdf = toZeroLength + fromZeroValue - cornerValue;
}

void RectangleSDF_float(float2 uv,float2 size,float edgeMin,float edgeMax,
float4 cornerRadius,
float strokeThickness,float isRelative,
float strokeDimensionMode,float2 widthHeight,
float keepAspectRatio,
out float fill,out float stroke,out float sdf,out float sdfStroke)
{
    float index = step(0.5f,strokeDimensionMode);
    float dimension = index * size.x + (1.f - index) * size.y;

    RectangleSDF(uv,size,edgeMin,edgeMax,cornerRadius,
    strokeThickness,isRelative,dimension,widthHeight,keepAspectRatio,
    fill,stroke,sdf,sdfStroke);
}

#endif