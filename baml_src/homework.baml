client<llm> Groq {
  provider openai-generic
  options {
    base_url "https://api.groq.com/openai/v1"
    api_key env.GROQ_API_KEY
    model "llama-3.2-11b-vision-preview"
  }
}

// Defining a data model.
class StudentResponse {
    subparts Subpart[]
}

class Subpart {
    subpartId string
    finalAnswer string
}

class GradedSubpart {
    subpart Subpart
    correct bool
}

class GradedQuestion {
  answers GradedSubpart[]
}

// Creating a function to extract the resume from a string.
function ExtractAnswer(img: image, question: string) -> StudentResponse {
  client GPT4oMini // Set OPENAI_API_KEY to use this client.
  prompt #"
    {{ _.role('user') }}
    Parse the handwritten responses from the image for question {{question}}:

    {{ img }}

    {{ ctx.output_format }}
  "#
}

function GradeQuestion(img: image, question: string, solution: string) -> GradedQuestion {
  client GPT4o // Set OPENAI_API_KEY to use this client.
  prompt #"
    {{ _.role('user') }}
    Check if each subpart of the student's final answer to question is correct{{question}},
    the correct solution is below:

    {{ solution }}

    {{ img }}

    {{ ctx.output_format }}
  "#
}

// Testing the function with a sample resume.
test test0 {
  functions [GradeQuestion]
  args {
    img {
        file "../data/0.png"
    }
    question "2.3.30"
    solution "$2. 3. \textbf{30 a See Figure }2. 44.$ Figure 2.44: for Problem 2.4.30.  The vectors $\vec{x}$ and $T(\vec{x})$ have the same length (since reflections leave the length unchanged), and they enclose an angle of $2(\alpha+\beta)=2\cdot30^\circ=60^\circ$ b Based on the answer in part (a), we conclude that $T$ is a rotation through $60^\circ.$ c The matrix of $T$ is $\begin{bmatrix}\cos(60^\circ)&-\sin(60^\circ)\\\sin(60^\circ)&\cos(60^\circ)\end{bmatrix}=\begin{bmatrix}\frac{1}{2}&-\frac{\sqrt{3}}{2}\\\frac{\sqrt{3}}{2}&\frac{1}{2}\end{bmatrix}.$"
  }
}

test test1 {
  functions [GradeQuestion]
  args {
    img {
        file "../data/1.png"
    }
    question "2.3.30"
    solution "$2. 3. \textbf{30 a See Figure }2. 44.$ Figure 2.44: for Problem 2.4.30.  The vectors $\vec{x}$ and $T(\vec{x})$ have the same length (since reflections leave the length unchanged), and they enclose an angle of $2(\alpha+\beta)=2\cdot30^\circ=60^\circ$ b Based on the answer in part (a), we conclude that $T$ is a rotation through $60^\circ.$ c The matrix of $T$ is $\begin{bmatrix}\cos(60^\circ)&-\sin(60^\circ)\\\sin(60^\circ)&\cos(60^\circ)\end{bmatrix}=\begin{bmatrix}\frac{1}{2}&-\frac{\sqrt{3}}{2}\\\frac{\sqrt{3}}{2}&\frac{1}{2}\end{bmatrix}.$"
  }
}

test test2 {
  functions [GradeQuestion]
  args {
    img {
        file "../data/2.png"
    }
    question "2.3.30"
    solution "$2. 3. \textbf{30 a See Figure }2. 44.$ Figure 2.44: for Problem 2.4.30.  The vectors $\vec{x}$ and $T(\vec{x})$ have the same length (since reflections leave the length unchanged), and they enclose an angle of $2(\alpha+\beta)=2\cdot30^\circ=60^\circ$ b Based on the answer in part (a), we conclude that $T$ is a rotation through $60^\circ.$ c The matrix of $T$ is $\begin{bmatrix}\cos(60^\circ)&-\sin(60^\circ)\\\sin(60^\circ)&\cos(60^\circ)\end{bmatrix}=\begin{bmatrix}\frac{1}{2}&-\frac{\sqrt{3}}{2}\\\frac{\sqrt{3}}{2}&\frac{1}{2}\end{bmatrix}.$"
  }
}

test test3 {
  functions [GradeQuestion]
  args {
    img {
        file "../data/3.png"
    }
    question "2.3.30"
    solution "$2. 3. \textbf{30 a See Figure }2. 44.$ Figure 2.44: for Problem 2.4.30.  The vectors $\vec{x}$ and $T(\vec{x})$ have the same length (since reflections leave the length unchanged), and they enclose an angle of $2(\alpha+\beta)=2\cdot30^\circ=60^\circ$ b Based on the answer in part (a), we conclude that $T$ is a rotation through $60^\circ.$ c The matrix of $T$ is $\begin{bmatrix}\cos(60^\circ)&-\sin(60^\circ)\\\sin(60^\circ)&\cos(60^\circ)\end{bmatrix}=\begin{bmatrix}\frac{1}{2}&-\frac{\sqrt{3}}{2}\\\frac{\sqrt{3}}{2}&\frac{1}{2}\end{bmatrix}.$"
  }
}

test real1 {
  functions [GradeQuestion]
  args {
    img {
        url "https://production-gradescope-uploads.s3-us-west-2.amazonaws.com/uploads/page/file/1173535910/page_2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAV45MPIOWVXAIDXRC%2F20240929%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240929T035436Z&X-Amz-Expires=10800&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEAsaCXVzLXdlc3QtMiJIMEYCIQDlaqamFhLaN2%2FVe5sizqmvSaYMuA4kVi%2BIbeEM82GkggIhAOjwgzWSXnMX1Eq%2BbEfgfB4DelefeBC9FFBkRMct30YpKroFCFQQABoMNDA1Njk5MjQ5MDY5Igyu6PrrQrTsMlCYsXAqlwVo9QU1VrbN9gvdveBSmtyuxUFQeOugP8vDOOpHbWOfGMnAZCrsgH%2FR2GeBwrYRYGrJiS6ZqhB3b3ud6hReoro4iY%2BPdmnVB4lPparQ6LYZ0AJIwYNTgU8ZBr3PXQgD3W7RNFjELvmR0IetoCy67UGUH0nuCkphoRzQziQhoMegeXG0kfTqizMaqYuFGdK9DAzGBZ%2BemSVggV7eP72RmZ6itl3e8vc4ttdiJ3aNCnVV3AFTdL0QaM8dmCAFFrLS63xeIPf%2FZuk6EUYDnFQS%2FEZBov2Qis0tAXZgjXK2j13tXkxYsCpyGyPw1syD99I%2BBZBNUaCqiRV282ZQpvdRGo4AL76YggdCGWNuIv%2Bomf2yGp5Qjn7QrJBpFQOTCbivWKZ0pDRv5QadVJeeO6pmI2LgO3Wo1Cx7hDx1bgm4qDQAdMHbDRnGCo8nO1Nfp6%2BwSiNIKWbMNWmiAF5Ox1q5%2BlOqhnSHNNZwNqcaYvrlbaet49Vgtl9o%2FNEAeLZP81S%2BbSVTQJ9W4Vf5L9jOMK4QADhRFs9ARsF60%2BNU0uX1DoIhOtbbgpZnLPy7TwEGqKVn%2BxPcuJH5vwpA9JFYjmR9G2Ob8qFotAueMiwdjahDz4L7xC%2F8aeVER%2FZX%2FMwKC9bubHtWcb1jinKy7rbPwgvZdcdVdQrYejWEUCuFb%2BeUYDbF3bR7Cr6TNLfMTlpLHKQw13zrJAziE2ZCz1srR%2F2o9wVHAwotNxH%2BgkEysvOU34eqPHS2%2Br7mAzUHgemiI9UWSCkUd%2Fj9TvlQn4HTn6B0j6ibozvE9bmYy%2F2JtxfbTFx1cu5bb7ycs7ee4ghaFqB6K3eaMq2QMx5qSzoShvlpfEBFA6C69nDNBl0hLEVXIA2JZfQkfSUr4S8w%2FPXitwY6sAGovHltyWUT09qZnVZxWxqUIEXGZIAPC9fUCHWD7W7Lm%2FrH6VUYfdY9TR1iv594PlOQ8W8jWIB7uq%2BqlMwvSuz3y5KAQl4JHqvthRGZ1a4swMyBEfF2bgfnss3H69sHTEgfaIjRLFGuRxuFtWo4CcT9zqBjeSInC7oaJXXkHfQH6%2BQVE%2BMGSot4j2rpmJIzD2PmJGWtbraAJ%2BQdT3pgeNe9j%2BkwafWSL%2BO2y27XHOMsGQ%3D%3D&X-Amz-SignedHeaders=host&X-Amz-Signature=0f02ec7a01666532c7895849de2330056d81556343211bbdb3daa286b35f9690"
    }
    question "2.3.30"
    solution "$2. 3. \textbf{30 a See Figure }2. 44.$ Figure 2.44: for Problem 2.4.30.  The vectors $\vec{x}$ and $T(\vec{x})$ have the same length (since reflections leave the length unchanged), and they enclose an angle of $2(\alpha+\beta)=2\cdot30^\circ=60^\circ$ b Based on the answer in part (a), we conclude that $T$ is a rotation through $60^\circ.$ c The matrix of $T$ is $\begin{bmatrix}\cos(60^\circ)&-\sin(60^\circ)\\\sin(60^\circ)&\cos(60^\circ)\end{bmatrix}=\begin{bmatrix}\frac{1}{2}&-\frac{\sqrt{3}}{2}\\\frac{\sqrt{3}}{2}&\frac{1}{2}\end{bmatrix}.$"
  }
}