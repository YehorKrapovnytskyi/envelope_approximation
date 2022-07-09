# __Envelope_approximation__


In some applications such as FFT, image processing, or automatic gain control (AGC) of an incoherent receiver that uses complex data of the type ${x + jy}$, a fast approximation of the magnitude ${r = \sqrt{x^2 + y^2}}$ is needed. In AGC application
the magnitude estimation is used to adjust the gain of the incoming signals in such a way that they are neither so small that large quantization noise occurs nor large that the arithmetic will overflow.\
Envelope approximation module consists of two parts: 
* Magnitude approximation(Abs)
* Lowpass filter

Magnitude approximation module detects an envelope of a complex IQ signal using a simple formula that approximates a true envelope calculation expression to reduce resource usage and get rid of squaring and square root extraction procedures. It uses a simple expression:

$${r ≈ \alpha*max({|x|}, {|y|}) + \beta*min({|x|}, {|y|}) }$$

where $\alpha$ and $\beta$ represent some coefficient and are chosen as $1$ and  $\frac{3}{8}$ resprectively. 


