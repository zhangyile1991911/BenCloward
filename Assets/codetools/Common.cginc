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
#endif