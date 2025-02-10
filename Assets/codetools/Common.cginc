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
#endif