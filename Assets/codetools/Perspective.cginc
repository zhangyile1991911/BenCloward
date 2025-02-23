#ifndef PERSPECTIVE_CGINC
#define PERSPECTIVE_CGINC
#include "Common.cginc"
void Perspective(float2 uv,float skewRotation,float skew,float alphaThreshold,float alphaFeather,out float2 result,out float alpha)
{
    float2 afterRotated = Rotate2D(uv,float2(0.5f,0.5f),0.f-skewRotation);
    //将范围限制在-1~1
    //1 * 2 - 1 = 1
    //0 * 2 - 1 = -1
    //lerp(1,(1,-1)，0.9) 更接近那个边界
    afterRotated = afterRotated * 2.f - 1.f;
    float scaleValue = lerp(1.f, afterRotated.x, skew);
    //缩放
    ScaleUV(uv,float2(scaleValue,scaleValue),float2(0.5f,0.5f),result);
    float m1 = min(result.x,result.y);

    float2 invertVal = float2(1.f,1.f) - result;
    float m2 = min(invertVal.x,invertVal.y);
    //取最小值
    float m3 = min(m1,m2);

    float inlerpb = alphaThreshold + alphaFeather;
    alpha = inverseLerp(alphaThreshold,inlerpb,m3);
}

void Perspective_float(float2 uv,float skewRotation,float skew,float alphaThreshold,float alphaFeather,out float2 result,out float alpha)
{
    Perspective(uv,skewRotation,skew,alphaThreshold,alphaFeather,result,alpha);
}
#endif