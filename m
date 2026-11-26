Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713305;
	b=jDxs+pXpkwPt3QZQBEE2ZciXJDlTXJ8vUBhceAFF9Vxm9pCFUJjKWbS9LTwpPCr2UuDv
	 pfUgGdvqSBtvrFqEhSP4SvQ5gDGVIDACxSouKukQCOH8lcipknBFZF16iJ8KKYVgM9oSY
	 QfMzZfpMs4D5YbYQ55mYmqupxGxrwfG4VmgJe3zV0CiVtmOnift9o7K00mzw6IbLDEEa1
	 Ma67IItMr2+vgW57YIMCTwSzMlaVi5UntOs8fRo5+aRkGgrnlHDsP0ilSwVmF5+EkH5Pr
	 /31lf9dR1chjyzI7tmlTyzxnb9I7Mxp2pR05KtCCJMbgdCkz6cdLXwb2lEurINxIwlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713305;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EiLoT2+XihtvP8a1fRZACzkRyTdOi62eg+DTIlOUR/I=;
	b=AL4IGhgbfX/NCDLi2MAsZ8wSkpHk3m0Y2hQXclp88nf/lzWZkeXhsYpgh2ucnC9gfKT5
	 m/SUUUyJhXkaEZe79BayU+QX+XtsNEfcyWuslTqx44bZWr3POOQYfUHTMdRxsM6Q4xgUU
	 tl0CQ4h4fqBOVB6L7AHPitxmK+46rhWCYeJxj8NYK78YSWM4329joJ8FojE4fv7t1wdw5
	 Op/RdtS4h4PRVkZszQPRZG5khkSGmYh/Ge73tiRX5HPYvrb7cBkvjgdJtc7XhbxZoKsqI
	 5joxI2rYBXJ1s+LdHQTX7hJRd4QIRl19WfIOhPT/SDtqmbEZKjWS1C8jspCdNfdDixQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHazmPar;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C5606A331
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHazmPar
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255521F000C6;
	Thu, 26 Nov 2026 17:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713304;
	bh=EiLoT2+XihtvP8a1fRZACzkRyTdOi62eg+DTIlOUR/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RHazmParFAENXDjCLPbtwyu/qfFGGxE4XaDScCnUZ6dkcAYzK1UmuXC26wpIVUf5i
	 hK77W4hkbLMSSor1LPcl/q+Z8y/5rPUUguRqFKuKyIixHM6BhmY6ML37JfWA2Y9qzD
	 naH3TCqxGMTP6XAi77O4jWVSB9XbKcNMbZEhPSXxFRFiCAxWnyPm+18OKy/CqovAoa
	 nGAHbJZPC9wbgPv3LtGQiHKuKixjnsQePl96eOsB+6ffpRSTSDcMcmNRAjrD1E79gx
	 zDOuYnpQ+B0K61uieWMIN2D+6dpSyLrcRC80VjtHuwvn+8i0O/W3ya6vCEJys82bBs
	 z1HOx+ztEJtHA==
From: Will Deacon <will@kernel.org>
To: Julien Thierry <julien.thierry.kdev@gmail.com>,
	Mika Tammi <mikatammi@gmail.com>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	kvm@vger.kernel.org
Subject: Re: [PATCH kvmtool] Makefile: Use correct nm binary when cross-compiling for x86_64
Date: Thu, 26 Nov 2026 17:14:35 +0000
Message-ID: <179571043275.2956544.17429175591273937710.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030104018.71809-1-mikatammi@gmail.com>
References: <20261030104018.71809-1-mikatammi@gmail.com>
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

On Fri, 30 Oct 2026 11:40:18 +0100, Mika Tammi wrote:
> x86/bios/gen-offsets.sh generates x86/bios/bios-rom.h from the symbols
> of the BIOS image with plain nm, the build machine's rather than the
> cross toolchain's. Where there is no plain nm, as in nixpkgs' cross
> builds, bios-rom.h gets no offsets and the build fails:
> 
>   gen-offsets.sh: line 11: nm: command not found
>   x86/bios.c:18:50: error: 'BIOS_OFFSET__bios_int10' undeclared here (not in a function)
> 
> [...]

Applied to kvmtool (master), thanks!

[1/1] Makefile: Use correct nm binary when cross-compiling for x86_64
      https://git.kernel.org/will/kvmtool/c/b4d3a2d970e4

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
