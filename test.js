// Online Javascript Editor for free
// Write, Edit and Run your Javascript code using JS Online Compiler

console.log("Try programiz.pro");
const fncx = async (promises) => {
    return Promise.all(
        promises.map(prmx =>
            Promise.resolve(prmx).then(value => {
                status: 'fulfilled',
                    value
            }).catch(reason => {
                status: 'rejected',
                    reason
            })
        )
    )

}
const prm = [
    Promise.resolve(10),
    Promise.reject("bad"),
    Promise.resolve(20)
]
const fnc = await fncx(prm);
console.log(fnc);