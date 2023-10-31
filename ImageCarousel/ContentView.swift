//
//  ContentView.swift
//  ImageCarousel
//
//  Created by shiyanjun on 2023/10/31.
//
// 导入SwiftUI框架
import SwiftUI

struct ContentView: View {
    
    // 定义一个状态属性来跟踪当前显示的颜色索引
    @State private var currentIndex: Int = 0
    
    // 定义一个手势状态属性来跟踪拖动的偏移量
    @GestureState private var dragOffset: CGFloat = 0
    
    // 定义一个颜色数组，用5种颜色充当5张图片
    private let colors: [Color] = [.red, .orange, .green, .blue, .purple]
    
    // 定义body属性，表示视图的内容
    var body: some View {
        
        // 使用NavigationStack包装内容
        NavigationStack {
            
            // 使用垂直堆栈组织内容
            VStack {
                
                // 使用ZStack使所有颜色重叠
                ZStack {
                    
                    // 遍历颜色数组
                    ForEach(0..<colors.count, id: \.self) { index in
                        
                        // 为每种颜色创建一个圆角矩形
                        RoundedRectangle(cornerRadius: 25.0)
                        // 使用渐变填充
                            .fill(colors[index].gradient)
                        // 定义框架大小
                            .frame(width: 300, height: 500)
                        // 当前索引的颜色完全不透明，其他颜色半透明
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                        // 当前索引的颜色放大，其他颜色缩小
                            .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                        // 根据索引和拖动偏移量设置偏移
                            .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y: 0)
                    }
                }
                // 添加拖动手势
                .gesture(
                    DragGesture()
                    // 拖动结束后的操作
                        .onEnded({ value in
                            // 设置阈值
                            let threshold: CGFloat = 50
                            
                            if value.translation.width > threshold {
                                // 如果拖动距离超过阈值
                                // 使用动画
                                withAnimation {
                                    // 显示上一个颜色
                                    currentIndex = max(0, currentIndex - 1)
                                }
                            } else if value.translation.width < -threshold {
                                // 如果拖动距离小于阈值的负数
                                // 使用动画
                                withAnimation {
                                    // 显示下一个颜色
                                    currentIndex = min(colors.count - 1, currentIndex + 1)
                                }
                            }
                            
                        })
                )
            }
            // 添加内边距
            .padding()
            // 设置导航标题
            .navigationTitle("Image Carousel")
            // 定义工具栏
            .toolbar {
                // 在底部放置工具栏
                ToolbarItem(placement: .bottomBar) {
                    // 使用水平堆栈组织按钮
                    HStack {
                        // 定义左箭头按钮
                        Button {
                            withAnimation {
                                // 显示上一个颜色
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } label: {
                            // 使用左箭头图标
                            Image(systemName: "arrow.left")
                            // 设置字体大小
                                .font(.title)
                        }
                        // 分隔器，使按钮分散到两边
                        Spacer()
                        // 定义右箭头按钮
                        Button {
                            withAnimation {
                                // 显示下一个颜色
                                currentIndex = min(colors.count - 1, currentIndex + 1)
                            }
                        } label: {
                            // 使用右箭头图标
                            Image(systemName: "arrow.right")
                            // 设置字体大小
                                .font(.title)
                        }
                    }
                    // 添加内边距
                    .padding()
                }
            }
        }
    }
}

// 预览
struct ImageCarousel_prevews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
