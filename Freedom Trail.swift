class Solution {
    struct State {
        var steps: Int
        var currentPosition: Int
    }
    func findRotateSteps(_ ring: String, _ key: String) -> Int {
        var charToIndices = [Character:Set<Int>]()
        let chars = Array<Character>(ring)
        let cycleSteps = ring.count
        for index in 0..<chars.count {
            if nil == charToIndices[chars[index]] {
                charToIndices[chars[index]] = []
            }
            charToIndices[chars[index]]?.insert(index)
        }
        var statues = [State]([State(steps: 0, currentPosition: 0)])
        for ch in key {
            var nextLevel = [State]()
            if let indices = charToIndices[ch] {
                for index in indices {
                    var steps = Int.max
                    for state in statues {
                        let temp = abs(state.currentPosition - index)
                        steps = min(steps, min(temp, cycleSteps - temp) + state.steps)
                    }
                    nextLevel.append(Solution.State(steps: steps, currentPosition: index))
                }
            }
            statues = nextLevel
        }
        var ans = Int.max
        for state in statues {
            ans = min(ans, state.steps)
        }
        return ans + key.count
    }
 }