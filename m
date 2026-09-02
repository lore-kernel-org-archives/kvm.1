Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B091E98EF
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 03:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788318456; cv=none; b=BGGIomt10zPusOcTanZm+FUolFAPUnSKg9vLCFekvBfo0fW+eGqVsV8kbXpNJMidQLkuRYkzXPJ4f9bNYpCp9hkDnhr1oD+Mu7bDu0Umdxr8Q44P0DMZFrEZKWJMTKpIg4rzfZOMx196mUWtk7MkPPq26gd5212ukdgzOb5KVaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788318456; c=relaxed/simple;
	bh=kkDFKyptLGB8HxMylGHdHX5DAPbnRXgSGeuviPKLFKw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fZ2ltYJP4w8ayuhCA+A21hr4jeZFNTHHELLLgJMPo7IDYkDG8F/b90dFmBh59/2KALz+4H0mzvldFZyK7GKqPjaaFtk0TpcRUNh9C68SYHiWa0CuTiDRuGuK0mueb9BhOHLRwhcNlKuV3Ycgsbkhd6UTeAJ/XLMQmFv8h9YI/5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3679kWK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3679kWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019A31F000E9;
	Wed,  2 Sep 2026 03:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788318455;
	bh=Xai5il4OOFBqTAfait/fsGxo49XETB9Hv0OG+9MJI/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b3679kWKhwErIjUNNb5qEfQjpHEDCxQ96uYLaYjgfkKmXyD3D8kBJwrCOmfU2EGco
	 yOoJpYdsGxLpB9kbDF+gtl4K/C6YI9YXlVLZCo+NdXuu2Y9BK9lkvmITKcfIcbBr28
	 6qdjU9VN4q0RjufjvQGD3ix+/bHWS8Vr3L7oXpt2+pFiEe9t+qjuCewZdF4E77ptxU
	 LROitTMpf0GNkmwjK2OX05y7aqFyiDRkp4M3sILvdcci3wFnmBJfYgWc0NeYvYTjsr
	 T2Fyioo1jzTiBpXy/gXQFEdNkW782i8TvDvV+A/ofeIKw+R2YITY7lg74oPAusmJZ0
	 gC1bFKePveKug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 19/20] KVM: x86: selftests: Add APX state and ABI
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902021804.718676-20-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
 <20260902021804.718676-20-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 03:07:34 +0000
Message-Id: <20260902030735.019A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The inline assembly in `read_egpr()` lacks the `volatile` qualif=
ier, allowing the compiler to optimize or hoist the register reads incorrec=
tly.
--

commit 95fe69711afd71a902fad394278581f460dbab32
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: selftests: Add APX state and ABI test

This commit adds testing for APX-specific behavior and ABI interactions.
It verifies that EGPR state is correctly saved and retained across VM entry,
and tests its exposure via the XSAVE ABI.

> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/=
testing/selftests/kvm/include/x86/processor.h
> index 6e6f70035508a..6e3e7d96c571e 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h

[ ... ]

> @@ -917,6 +919,124 @@ static inline void write_sse_reg(int reg, const sse=
128_t *data)
>  	}
>  }
> =20
> +static inline unsigned long read_egpr(int reg)
> +{
> +	unsigned long data =3D 0;
> +
> +	/* mov %r16..%r31, %rax */
> +	switch (reg) {
> +	case 16:
> +		asm(".byte 0xd5, 0x48, 0x89, 0xc0" : "=3Da"(data));

[Severity: Medium]
Is it possible for the compiler to hoist these register reads outside of
their intended execution points?

According to GCC and Clang semantics, an asm statement with output operands
but no input operands and no volatile qualifier is treated as a pure
computation.=20

Could the optimizer move these reads to execute before the GUEST_SYNC()
calls, causing the test to validate stale register states (from before the
VM exit) instead of the intended restored states upon VM entry?=20

Adding the volatile qualifier would prevent the compiler from reordering
these hardware register reads.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902021804.7186=
76-1-chang.seok.bae@intel.com?part=3D19
