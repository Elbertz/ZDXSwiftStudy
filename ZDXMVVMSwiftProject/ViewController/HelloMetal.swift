//
//  HelloMetal.swift
//  ZDXMVVMSwiftProject
//
//  Created by Elbert on 17/4/19.
//  Copyright © 2017年 Elbert. All rights reserved.
//

import Foundation
import UIKit
import Metal
import QuartzCore

class HelloMetal: UIViewController {
    //
    var device :MTLDevice! = nil
    var metalLayer :CAMetalLayer! = nil
    
    let vertexData :[Float] = [0.0,1.0,0.0,
                            -1.0,-1.0,0.0,
                            1.0,-1.0,0.0]
    var vertexBuffer :MTLBuffer! = nil
    
    let vertexColorData :[Float] = [0.0,1.0,0.0,
                               -1.0,-1.0,0.0,
                               1.0,-1.0,0.0]
    var vertexColorBuffer :MTLBuffer! = nil
    
    var pipelineState :MTLRenderPipelineState! = nil //一个render pipeline 配置,在它被编译后进行跟踪。
    
    var commandQueue :MTLCommandQueue! = nil
    
    var timer :CADisplayLink! = nil
    
    
    
    override func viewDidLoad() {
        //
        super.viewDidLoad()
        
        device = MTLCreateSystemDefaultDevice()
        guard device != nil else {
            print("不支持Metal,可以在这里使用OpenGL ES 代替Metal")
            return
        }
        
        metalLayer = CAMetalLayer()
        metalLayer.device = device
        metalLayer.pixelFormat = .bgra8Unorm
        metalLayer.framebufferOnly = true
        metalLayer.frame = view.layer.frame
        view.layer.addSublayer(metalLayer)
        
        
        //创建缓冲区(顶点和颜色)
        //获取vertex data的字节大小。你通过把第一个元素的大小和数组元素个数相乘来得到
        let dataSize = vertexData.count * MemoryLayout.size(ofValue: vertexData[0])
        //在GPU创建一个新的buffer，从CPU里输送data
        vertexBuffer = device.makeBuffer(bytes: vertexData, length: dataSize, options:[])
        //
        let colorLength = vertexColorData.count * MemoryLayout<Float>.size
        vertexColorBuffer = device.makeBuffer(bytes: vertexColorData, length: colorLength, options: [])
        
        
        let defaultLibrary = device.newDefaultLibrary()
        let fragmentprogram = defaultLibrary?.makeFunction(name: "basic_fragment")
        let vertexProgram = defaultLibrary?.makeFunction(name: "basic_vertex")
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram // 指定顶点处理程序
        pipelineStateDescriptor.fragmentFunction = fragmentprogram // 指定片段程序
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm // 指定颜色格式
        pipelineStateDescriptor.sampleCount = 1 // 设置采样数量
        
        
        //throws -> XXX 类型函数的使用方法
        do {
            try pipelineState = device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        } catch let error {
            print("Failed to create pipeline state, error \(error)")
        }
        /*
         * line53~~line68
         a.你可以通过调用device.newDefaultLibrary方法获得的MTLibrary对象访问到你项目中的预编译shaders。然后你能够通过名字检索每个shader。
         b.你在这里设置你的render pipeline。它包含你想要使用的shaders、颜色附件（color attachment）的像素格式(pixel format)。（例如：你渲染到的输入缓冲区，也就是CAMetalLayer）。
         c.最后，你把这个pipeline 配置编译到一个pipeline 状态(state)中，让它使用起来有效率。
         *
         */
        
        
        //7）创建一个Command Queue
        //一个--装载着你告诉GPU一次要执行的命令的--列表
        commandQueue = device.makeCommandQueue()
        
        //8）渲染图形
        /*现在，是时候学习每帧执行的代码，来渲染这个图形！
        
        它将在五个步骤中被完成：
        1.创建一个Display link。
        2.创建一个Render Pass Descriptor
        3.创建一个Command Buffer
        4.创建一个Render Command Encoder
        5.提交你Command Buffer的内容。
        */
        timer = CADisplayLink(target: self, selector: #selector(HelloMetal.drawloop))
        timer.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
        
        
        
    }
    
    func render() -> Void {
        //
        let drawable = metalLayer.nextDrawable()
        
        let renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].texture = drawable?.texture
        renderPassDescriptor.colorAttachments[0].loadAction = .clear
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 0.0/255, green: 104.0/255, blue: 5.0/255, alpha: 1.0)
        /*
         首先你在之前的metal layer上调用nextDrawable() ，它会返回你需要绘制到屏幕上的纹理(texture)。
         接下来，你配置你的render pass descriptor 来使用它。你设置load action为clear，也就是说在绘制之前，把纹理清空。然后你把绘制的背景颜色设置为绿色。
         */

        
        let commandBuffer = commandQueue.makeCommandBuffer()
        //创建一个渲染命令编码器(Render Command Encoder)
        let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderEncoder.setRenderPipelineState(pipelineState)// 指定渲染管线对象
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, at: 0)// 设置顶点缓冲区
        // 设置颜色缓冲区
        renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1)
        renderEncoder.endEncoding()
        /*
         创建一个command encoder，并指定你之前创建的pipeline和顶点;
         调用drawPrimitives(vertexStart:vertexCount:instanceCount:)告诉GPU，让它基于vertex buffer画一系列的三角形。每个三角形由三个顶点组成，从vertex buffer 下标为0的顶点开始，总共有一个三角形
         */
        
        
        commandBuffer.present(drawable!)// 让绘制对象绑定到当前绘制帧
        commandBuffer.commit()
        //第一行需要保证新纹理会在绘制完成后立即出现。然后你把事务(transaction)提交，把任务交给GPU
        
        
    }
    
    func drawloop() -> Void {
        //
        autoreleasepool {
            render()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
