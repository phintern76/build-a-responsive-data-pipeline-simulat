import Foundation

// Simulator Configuration
struct SimulatorConfig {
    let dataSize: Int // Data size in MB
    let processingTime: TimeInterval // Time in seconds
    let errorRate: Double // Error rate percentage
}

// Data Pipeline Simulator
class DataPipelineSimulator {
    let config: SimulatorConfig
    var data: [Int] = [] // Simulated data
    var processedData: [Int] = [] // Processed data
    var errors: [Error] = [] // Errors occurred during processing
    
    init(config: SimulatorConfig) {
        self.config = config
    }
    
    func generateData() {
        for _ in 0...config.dataSize * 1024 * 1024 {
            data.append(Int.random(in: 0...100))
        }
    }
    
    func processData() {
        for _ in 0...data.count {
            let startTime = Date()
            let randomError = Double.random(in: 0...100)
            if randomError <= config.errorRate {
                errors.append(SimulatorError.dataProcessingError)
            } else {
                processedData.append(data.randomElement()!)
            }
            let endTime = Date()
            let processingTime = endTime.timeIntervalSince(startTime)
            if processingTime < config.processingTime {
                usleep(useconds_t(config.processingTime - processingTime))
            }
        }
    }
    
    func printResults() {
        print("Data Size: \(config.dataSize) MB")
        print("Processed Data Size: \(processedData.count) elements")
        print("Error Rate: \(config.errorRate)%")
        print("Errors: \(errors.count)")
    }
}

// Simulator Error
enum SimulatorError: Error {
    case dataProcessingError
}

// Run Simulation
let config = SimulatorConfig(dataSize: 10, processingTime: 0.5, errorRate: 20.0)
let simulator = DataPipelineSimulator(config: config)
simulator.generateData()
simulator.processData()
simulator.printResults()