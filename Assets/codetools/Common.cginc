#ifndef COMMON_CGINC
#define COMMON_CGINC
// Inverse Lerp 函数
float inverseLerp(float A, float B, float T)
{
    return (T - A) / (B - A);
}

float2 inverseLerp(float2 A, float2 B, float2 T)
{
    return (T - A) / (B - A);
}

float3 inverseLerp(float3 A, float3 B, float3 T)
{
    return (T - A) / (B - A);
}

void LinearGradient(float2 uv,float isInvert,out float u,out float v)
{
    isInvert = step(0.5,isInvert);
    float2 flipUV = (1.0f - uv) * isInvert;
    uv = uv * (1.f - isInvert) + flipUV;
    u = uv.x;
    v = uv.y;
}

void RoundedCorners(float2 uv,float4 cornerRadius,out float corners)
{
    uv = uv * 2.0f - 1.0f;
    uv = ceil(uv);
    uv = saturate(uv);

    float2 result = lerp(
        float2(cornerRadius.x,cornerRadius.y),
        float2(cornerRadius.z,cornerRadius.w),
        uv.x);
    
    corners = lerp(result.x,result.y,uv.y);
}

void Move(float2 uv,float2 move,out float2 uvRaw,out float2 uvRepeat)
{
    //假设把uv往右移动,往反方向取值
    float2 negateMove = float2(-move.x,move.y);
    uvRaw = negateMove + uv;
    //只保留小数部分
    uvRepeat = frac(uvRaw);
}

float3 Reciprocal(float3 v)
{
    return 1.0 / v;
}

float2 Reciprocal(float2 v)
{
    return 1.0 / v;
}

float Reciprocal(float v)
{
    return 1.0 / v;
}

void ScaleUV(float2 uv,float2 scale,float2 pivot,out float2 result)
{
    scale = max(float2(0.001f,0.001f),scale);
    //偏移回原点
    uv -= pivot;
    result = uv / scale;
    //在偏移回去
    result += pivot;
}

void Tilt(float2 uv,float2 tilt,float2 result)
{
    //假设uv(0.5,0.5) ---> (0.55,0.55)
    //tilt(-0.25,-0.25)
    float2 inv = float2(tilt.y,tilt.x) * uv;
    //inv(-0.125,-0.125)
    //(0.5,0.5) + (-0.125,-0.125) = (0.475,0.475)
    //(0.475,0.475) - (-0.125,-0.125)
    result = uv + float2(inv.y,inv.x) - tilt / 2.0;
}

void Mirror(float2 value,float subdivisions,float height,out float2 result,out float2 inverse)
{
    //value(0.3,0.3) subdivisions 0.5
    //r1 = (0.15,0.15)
    float2 r1 = value * subdivisions;
    //去掉整数部分,保留小数
    //r2 (0.3,0.3) - (0,0)
    float2 r2 = value - floor(r1);
    //r3 min(0.3,1-0.3) * 2f = 0.6
    //result = 0.6 * 1f;
    float2 r3 = min(r2,(1-r2)) * float2(2.f,2.f);
    result = r3 * height;
    //invserse = (1 - 0.6) * 1 - 1 + 1 = 0.4 - 1 + 1 = -0.6f + 1= 0.4f
    inverse = (1.f - r3) * height - height + float2(1.f,1.f);
}


void AntiAliasing(float gradient,float cutoff,out float result)
{
    float r = cutoff - gradient;
    float len = length(float2(ddx(r),ddy(r)));
    result = saturate(0.5 - r/len);
}

float2 Rotate2D(float2 uv,float2 pivot, float angle)
{
    // 将角度转换为弧度
    float rad = radians(angle); 
    float sinTheta = sin(rad);
    float cosTheta = cos(rad);

    float2x2 rotationMatrix = float2x2(cosTheta, -sinTheta, sinTheta, cosTheta);
    return mul(rotationMatrix, uv - pivot) + pivot;
}
#endif