Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713312;
	b=xcQCm9JXCkdUZ844wuVs3qvALeZBZuETazpJuNw8sdo68BImQnPxIglPcHWsykljfsC+
	 dPTcGoAXW5K4PMAuNH8ojBWxAAD0gZ3iWw7Bv362vpbUFpAd97Ns6uSxpIUU8KuYpQm9C
	 kck64dXQ9c877OcMm8RwzEU4T2Yg8SGjBuzjaZJy2uz7qVOIQ0EFuRpjVTmO7MhpNK5sa
	 ytQ4UDvcEpwtDssgR0Alsfojba4ATqA8lW0iKvZcuWZCcC1a2n+JrEjP3yQT1h7TJ3HhB
	 GGaEjofUsHc3vLcFAbzz/ANB6UTCXYYKxYh7z5j8rwmP5AF5VlG8mjEhnBXOZ9fcQBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713312;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8TIQAJSleGSB4UW8hwVTuGZ3l5+7AlOWhuYCLdkdQkk=;
	b=H6XylUBK9g6yv99vfjlP7UXeepyZjowaG+WKQmfXnapIusHLaIJO31+REb9O+X9c5FfV
	 S/1zKmDVwhQhwgbCfUxUBI26vHABqNnWlPZ1Um0qjJVjfAQOcPyGqYlSB4PmZ2pPuJqRT
	 oQwk36+Lzz45Xqssb6bfDA5cautWeK3oicz2pwGhmzyVcbu4nyGvbBj+x8jNYQNbUtILH
	 2wpwbbPqaxRV93GGr+yrlc0RvzL/tNa15/7LZB5M7cx+4XduAZNkHIOxPSWwZqsCDVoae
	 z0te0g0sBNmXf8AL3hdeAzEDZdpL0Pt/M16Yrgns3iDLVm3Iv2Llhxa9h032mvJXJUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFQXg3x9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC71606A32A
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFQXg3x9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E54F1F000C6;
	Thu, 26 Nov 2026 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713311;
	bh=8TIQAJSleGSB4UW8hwVTuGZ3l5+7AlOWhuYCLdkdQkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dFQXg3x96UaGclQr53bNYMCJjC73aSGnVzr3iSNm0gEFGqs2xQP4Gtj7G3vE91U92
	 eM/1cSSnF7uaVJ8Gl+BGW6uLWr0NEif4ma2hhvi3tLQQdEkmg5wAYybYunvnXKCOFF
	 NflRaFLvwajzEjOypb/Sv9PqziKjM48qni6yFh1xdTVsaZp02iOtRgCsUD7IRO5b0k
	 aYMf0XS+IT17GSLNv4Fxfw7l/8YyLP/Gka1B1lucYaQTZvFWdx3HoGLAHZ9eR5l6Cs
	 GLZvGklosrKSYFLHIzjoC3kfJnvNwGmd/sxU2PSjNGk630dwLg/qJeqGnpTEA9qTSJ
	 wSO9+iBXpgEIg==
From: Will Deacon <will@kernel.org>
To: Julien Thierry <julien.thierry.kdev@gmail.com>,
	Mika Tammi <mikatammi@gmail.com>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	kvm@vger.kernel.org
Subject: Re: [PATCH kvmtool] x86: Declare the BIOS image as arrays of unknown size
Date: Thu, 26 Nov 2026 17:14:38 +0000
Message-ID: <179571061136.2958179.685817679277630832.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030142643.89313-1-mikatammi@gmail.com>
References: <20261030142643.89313-1-mikatammi@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 30 Oct 2026 15:26:43 +0100, Mika Tammi wrote:
> bios-export.h declares bios_rom and bios_rom_end, the start and the end
> of the BIOS image in bios-rom.S, as zero-length arrays. To the compiler,
> bios_rom is then an object of size 0. fortify-headers, a
> _FORTIFY_SOURCE implementation for musl, checks the size of memcpy()'s
> source as well as its destination [1], so the memcpy() in setup_bios()
> that copies the image out of bios_rom traps, and lkvm on x86 built with
> musl and _FORTIFY_SOURCE, as nixpkgs builds it by default, dies at
> start:
> 
> [...]

Applied to kvmtool (master), thanks!

[1/1] x86: Declare the BIOS image as arrays of unknown size
      https://git.kernel.org/will/kvmtool/c/5f5df66b1f26

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
