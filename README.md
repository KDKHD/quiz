### Example Queries

```
mutation registerNewUser {
  registerNewUser(
    input: {email: "kenneth@blue3.dch", firstName: "Kenneth", lastName: "K", password: "SecureForFun123"}
  ) {
    newUser {
      token
      user {
        userId
        firstName
        email
        lastName
      }
    }
  }
}

mutation authenticate {
  authenticate(input: {email: "kenneth@blue3.dch", password: "SecureForFun123"}) {
    jwt
  }
}

mutation createQuiz {
  createQuiz(input: {quiz: {name: "first"}}) {
    quiz {
      name
      createdAt
      quizId
    }
  }
}

mutation createQuestion {
  question1: createQuestion(
    input: {question: {type: MULTIPLE_CHOICE, quizId: 1, question: "What is a duck", order: 1}}
  ) {
    question {
      answerDurationSeconds
      createdAt
      img
      nodeId
      order
      promptDurationSeconds
      question
      questionId
      quizId
      type
    }
  }
  
  question2: createQuestion(
    input: {question: {type: MULTIPLE_CHOICE, quizId: 1, question: "What is a dog", order: 2}}
  ) {
    question {
      answerDurationSeconds
      createdAt
      img
      nodeId
      order
      promptDurationSeconds
      question
      questionId
      quizId
      type
    }
  }
}

mutation createAnswer {
  answer11: createAnswer(input: {answer: {questionId: 1, value: "A bird"}}) {
    answer {
      value
      answerId
      createdAt
      img
    }
  }
  
  answer12: createAnswer(input: {answer: {questionId: 1, value: "A fish"}}) {
    answer {
      value
      answerId
      createdAt
      img
    }
  }
  
  answer13: createAnswer(input: {answer: {questionId: 1, value: "A dog"}}) {
    answer {
      value
      answerId
      createdAt
      img
    }
  }
  
  answer14: createAnswer(input: {answer: {questionId: 1, value: "A human"}}) {
    answer {
      value
      answerId
      createdAt
      img
    }
  }
  
  answer21: createAnswer(input: {answer: {questionId: 2, value: "A bird"}}) {
    answer {
      value
      answerId
      createdAt
      img
    }
  }
  
  answer22: createAnswer(input: {answer: {questionId: 2, value: "A fish"}}) {
    answer {
      value
      answerId
      createdAt
      img
    }
  }
  
  answer23: createAnswer(input: {answer: {questionId: 2, value: "A dog"}}) {
    answer {
      value
      answerId
      createdAt
      img
    }
  }
  
  answer24: createAnswer(input: {answer: {questionId: 2, value: "A human"}}) {
    answer {
      value
      answerId
      createdAt
      img
    }
  }
}

mutation createSolution {
  solution1: createSolution(input: {solution: {questionId: 1, answerId: 1}}) {
    answer{
      value
    }
  }
  
  solution2: createSolution(input: {solution: {questionId: 2, answerId: 7}}) {
    answer{
      value
    }
  }
}

mutation newQuizRun {
  quizRun1: newQuizRun(input: {quizId: 1}) {
    quizRun {
      quizRunId
    }
  }
}


mutation startQuizRun {
	nextQuestion(input:{quizRunId:1}) {
    question{
      question
      answers{
        nodes{
          value
        }
      }
    }
  } 
}

mutation newPlayer {
  registerNewPlayer(input: {name: "sam", quizRunId: 1}) {
    newPlayer {
      token
      player {
        name
        playerId
      }
    }
  }
}

mutation addPlayerAnswer {
  createPlayerAnswer(
    input: {playerAnswer: {answerId: 1, questionId: 1, playerId: 1}}
  ) {
    playerAnswer {
      answerId
    }
  }
}

query playerAnswer {
  playerAnswers {
    nodes {
      answerId
    }
  }
}

query playerScore {
  player(playerId: 1) {
    score
  }
}

mutation nextQuestion {
	nextQuestion(input:{quizRunId:1}) {
    question{
      question
      answers{
        nodes{
          value
        }
      }
    }
  } 
}

mutation addPlayerAnswer2 {
  createPlayerAnswer(
    input: {playerAnswer: {answerId: 7, questionId: 2, playerId: 1}}
  ) {
    playerAnswer {
      answerId
    }
  }
}

query playerScore2 {
  player(playerId: 1) {
    score
  }
}

query users {
  users {
    totalCount
    nodes {
      userId
      email
      quizzes {
        nodes {
          quizId
          name
          questions {
            nodes {
              type
              question
              solutions {
                nodes {
                  answer {
                    answerId
                  }
                  value
                }
              }
              answers {
                nodes {
                  answerId
                  value
                }
              }
            }
          }
        }
      }
    }
  }
}
```