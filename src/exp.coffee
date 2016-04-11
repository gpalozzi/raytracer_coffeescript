scene = window.scene
vmath = window.vmath

t1 = new scene.Material({n: 100})
console.log t1
t2 = t1.clone()
console.log t2
t3 = t1
t3.n = 99
console.log t1, t2, t3
