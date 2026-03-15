using FFTW
using Plots

# constantes
ħ = 1.0
m = 1.0

# grade espacial
Nx = 512
L = 100
dx = L/Nx
x = (-Nx/2:Nx/2-1) .* dx

# grade de momento
dk = 2π/L
k = (-Nx/2:Nx/2-1) .* dk

# tempo
dt = 0.05
steps = 200

# potencial (livre)
V = zeros(Nx)

# pacote gaussiano inicial
x0 = -20
k0 = 2
sigma = 2

ψ = exp.(-(x .- x0).^2 ./ (2*sigma^2)) .* exp.(im*k0*x)

ψ = ψ ./ sqrt(sum(abs2.(ψ))*dx)

anim = @animate for n in 1:steps
    
    # passo cinético (Fourier)
    ψk = fftshift(fft(ψ))
    ψk .= ψk .* exp.(-im*(ħ*k.^2/(2m))*dt)
    ψ = ifft(ifftshift(ψk))
    
    # densidade de probabilidade
    prob = abs2.(ψ)

    plot(
        x,
        prob,
        ylim=(0,0.5),
        xlabel="x",
        ylabel="|ψ|²",
        title="Quantum Wave Packet",
        legend=false
    )

end

gif(anim,"wave_packet.gif",fps=30)