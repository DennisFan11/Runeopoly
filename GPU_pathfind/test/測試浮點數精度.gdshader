shader_type canvas_item;
void fragment() {
    float base = 1.0;
    float increment = 0.0000001; // 測試 HDR 紋理支援的最小增量
    float result = base + increment;

    if (result == base) {
        // 無法區分增量時，顯示結果
        COLOR = vec4(1.0, 0.0, 0.0, 1.0);
    } else {
        // 增量有效
        COLOR = vec4(0.0, 1.0, 0.0, 1.0);
    }
}
