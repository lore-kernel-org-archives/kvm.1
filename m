Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069298;
	b=Q7ZJWEOmUzMhJcg6Xe09uqn5ummXFE28s+vtdrVd5bFSOxiaWFmMRu37iFXOOiDxfSpO
	 qNVLlWlPKoi4m/H9J6tpbYr5LVC0MQFgHEaGw7zXh02gm7S0ce16BJBRvlXUNKfsYtFY7
	 xIO831mfug6/702r5F4mUKOdJUineEmHxIyrvOxjlOPbhL3SYjtA8TBExqGlS7Q6OgeRK
	 kskY+AG/oIvqJqXsYKkKUYX07GUs82LRnrIGt0EztJNWIEJbWLks7GG15ty/LjLHtlaWl
	 jzRH2wjDx2a1LgCYDPRy9mkN4WykRYkPAMySCF1XZrVRtF73UJ1Ck0PfUhXGPl+DiMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069298;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d5V7Rieq2NNhaZfYLI5iX2cWop0GoiKomqH5pxfTh2c=;
	b=Q2YN138HbrnTxgtYVUtdx7lW4EQfTVqrp3OUxDPuD6tNcEf0UEUdqkJaJI7EYF6I0wPW
	 T3CKv9tEH2f9D7Q4BQGsZEBt10QQzJvXInACl8IIYDj8v8QE9+TkhgwJC4GIuRlWTYIhS
	 h4DRh86jD2AHTiD2m62nD1+slzx1tdo0j4ykrMTJKDGoBEXDShEpseJHiPu1J8h7MSSJU
	 yh1HsBMJBHtyPQBsehfEbt2xi6+TNoH5Owta08SCMa6HLyf04XLLs4qRPqMT7Tpgf674/
	 LXwNqwadLCq5fRyZTvoCvOezp2HSWPkEBfFEHrLledFlX+xRuoCs4sBgZJ2DxFbQ2Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BCK//JTq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3C0606A333
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCK//JTq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30761F000C4;
	Thu, 19 Nov 2026 06:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795069298;
	bh=d5V7Rieq2NNhaZfYLI5iX2cWop0GoiKomqH5pxfTh2c=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BCK//JTqYcoY1HSUSkOu+5scdvk1Ms/rTU6djj1fJ2/9ladrVqhBzkw4yY3+xY6Jq
	 y/4A9dzyF9cIaCWXB8GxOLwPTdIa+wYPnXVMTZ8w37jpPb7Vh/vKXiOVM32iK6ljVQ
	 FEGAXKvPpbfinGEk+hyxowB9xR2LXML90MaLtYoJI68Y+Wi6pSnPQAaGKyTwS2LEyD
	 ASiNJBQrgnw8apFuyo4DsPRUo7m3Pke4MCM64lXbBvzsgJ0B+njn3x9gEdLGU0hkoC
	 49ZwxXt6qkwiw1LeK1v1SDLn0NnWQD0St9DBalsDsX6gdpsgrqRcg0UDyOcPcGXZrx
	 oi4CILTY63pnA==
Message-ID: <sashiko-outbox-222518@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: x86: Fix stalled descriptor table accesses to
 MMIO
Reply-To: sashiko-reviews@lists.linux.dev
To: weichenchen <weichen.chen@linux.alibaba.com>, kvm@vger.kernel.org
In-Reply-To: <20261119055747.23819-1-weichen.chen@linux.alibaba.com>
References: <20261119055747.23819-1-weichen.chen@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 06:21:37 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: x86: unmasked addr.ea increment in em_lgdt_lidt() breaks
  32-bit wrap
--

commit 14df3ccaae0dc59c054ba57d9b0335ad6207effb
Author: weichenchen <weichen.chen@linux.alibaba.com>

KVM: x86: Fix stalled descriptor table accesses to MMIO

This commit switches LGDT, LIDT, SGDT, and SIDT operand accesses from
standard memory accessors to emulated memory accessors and common writeback
so MMIO operands do not stall emulation.

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c1b21282187f3..3a9a67f4b0d7c 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c

[ ... ]

> @@ -3465,14 +3447,27 @@ static int em_sidt(struct x86_emulate_ctxt *ctxt)
> =20
>  static int em_lgdt_lidt(struct x86_emulate_ctxt *ctxt, bool lgdt)
>  {
> -	struct desc_ptr desc_ptr;
> +	struct segmented_address addr =3D ctxt->src.addr.mem;
> +	struct desc_ptr desc_ptr =3D {};
> +	unsigned long limit_addr, base_addr;
> +	unsigned int base_bytes, desc_bytes;
>  	int rc;
> =20
>  	if (ctxt->mode =3D=3D X86EMUL_MODE_PROT64)
>  		ctxt->op_bytes =3D 8;
> -	rc =3D read_descriptor(ctxt, ctxt->src.addr.mem,
> -			     &desc_ptr.size, &desc_ptr.address,
> -			     ctxt->op_bytes);
> +	base_bytes =3D ctxt->op_bytes =3D=3D 2 ? 3 : ctxt->op_bytes;
> +	desc_bytes =3D sizeof(desc_ptr.size) + base_bytes;
> +
> +	/* Check both fields before an MMIO read can have side effects. */
> +	rc =3D linearize(ctxt, addr, sizeof(desc_ptr.size), false, &limit_addr);
> +	if (rc !=3D X86EMUL_CONTINUE)
> +		return rc;
> +	addr.ea +=3D sizeof(desc_ptr.size);
> +	rc =3D linearize(ctxt, addr, base_bytes, false, &base_addr);
> +	if (rc !=3D X86EMUL_CONTINUE)
> +		return rc;
> +
> +	rc =3D read_emulated(ctxt, limit_addr, &desc_ptr, desc_bytes);

[Severity: Medium]
Does incrementing addr.ea without 32-bit masking break 32-bit address
wraparound for LGDT/LIDT at the top of a 4GB segment?

Because addr.ea is a 64-bit unsigned long, an operand at 0xfffffffe or
0xffffffff in 16-bit or 32-bit mode overflows addr.ea to 0x100000000 or
0x100000001, causing the second linearize() call to fail the addr.ea > lim
check and inject a spurious #GP(0) or #SS(0) when lim =3D=3D 0xffffffff.

A single linearize(ctxt, addr, desc_bytes, false, &limit_addr) call (or
segmented_read(ctxt, ctxt->src.addr.mem, &desc_ptr, desc_bytes)) already
checks that the full descriptor fits within the segment limit when
lim !=3D 0xffffffff while preserving 32-bit wraparound when lim =3D=3D 0xff=
ffffff,
and avoids the unused base_addr variable.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119055747.2381=
9-1-weichen.chen@linux.alibaba.com?part=3D1
