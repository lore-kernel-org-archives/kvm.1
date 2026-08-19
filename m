Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9133AE6FA
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119847; cv=none; b=ngYqGBySF7+bgNRQPLBZafaLxLptDVfxI2/s2E8b9mDlL+rChw3gtUCY6CRHt3CN85MA7UPHKtF6phCOt9KZZiYhQcl34NSiB2ka0IRT+eecUb2jJV4sdBJbFsssYwRV8heQIbp46uMmDeobd8L6oPg7MgLgOCrSyQoz0fW1Ghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119847; c=relaxed/simple;
	bh=VR3C+h3LfRA59pXyGCDHoYEl3OKEDLa7WT+DGxtG6M4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rsodhl3WuupdBWfuX3PrUS44rum4e45XKtJnWD5ztVGP12ZDJIln51FqFsof3vyoY6hqErrMLB3YLq0Np9u/0eDNf3TgdG93Qe8U9f5d6ZSBxrNLkUdO+oI5HOqO4wRhL2mskt+4RSels7yrazUS9wjcF2H3xfdmq7U7jE1Y2hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPfPfiQx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPfPfiQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47861F00A3A;
	Wed, 19 Aug 2026 06:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787119846;
	bh=oVXNCrACooGpYQo5sgNp22QK9tb4LRzHiHNXl90ROqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LPfPfiQxPh0xzQzFhXC4H4EGHdxqk+HHgrGcyBJtYReroUrvZJUoYLpneVnjyOsfL
	 oiRacr6v9sT1XHAB0nyr51PuVZE7UGaBfiUoOp6ilhhd2GaJ68NdpcArR1keftICoD
	 ctcZg0s1U3tN5DqfGBi0wkSGhNnemxcP/tGq6mq2TPFsgAGEvTG+nKfGwE457aj2ns
	 1yxV9WXDq5Ab5WiDODdAQykcdGACTnRaTkFprlj5e5F+yLK3Kc6rX93Li3vuua3Q3s
	 leKKtyt/t7u2mXq2RElpWkLLXriYI7xweMGFMygtXrzoefvF4Kn3tWFNU3eQIZrc/O
	 Kt6fZMRnpUyWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/9] KVM: x86: Add helper to provide intercept linear
 addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <3e4406c2c7507e6a34433438271decd47dca22e6.1787116250.git.zhang_wei@open-hieco.net>
References: <cover.1787116250.git.zhang_wei@open-hieco.net>
 <3e4406c2c7507e6a34433438271decd47dca22e6.1787116250.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 06:10:45 +0000
Message-Id: <20260819061045.D47861F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The newly added `intercept_linear_addr` field is calculated but =
never consumed by architecture-specific intercept handlers, rendering the l=
ogic dead code.
- [Medium] The calculated linear address in `get_intercept_linear_addr()` i=
s not untagged, violating architectural specifications when LAM/UAI is acti=
ve.
--

--- Patch [1]: [PATCH v4 1/9] KVM: x86: Add helper to provide intercept lin=
ear addresses ---
commit bde7560cfe988f666acaf2bb0b4fbe6285414375
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: x86: Add helper to provide intercept linear addresses

This commit adds a helper get_intercept_linear_addr() to compute the linear
address for intercepts like INVLPG, and passes this address through
x86_instruction_info so intercept handlers can use it directly.

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 8071b372d233e..a0e57b64cadd4 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
[ ... ]
> @@ -410,6 +410,26 @@ static int em_salc(struct x86_emulate_ctxt *ctxt)
[ ... ]
> +static u64 get_intercept_linear_addr(struct x86_emulate_ctxt *ctxt,
> +				     enum x86_intercept intercept)
> +{
> +	u64 la;
> +
> +	if (intercept !=3D x86_intercept_invlpg)
> +		return 0;
> +
> +	la =3D seg_base(ctxt, ctxt->src.addr.mem.seg) + ctxt->src.addr.mem.ea;
> +	return ctxt->mode =3D=3D X86EMUL_MODE_PROT64 ? la : (u32)la;

[Severity: Medium]
Should this address be untagged before being returned in 64-bit mode?

According to the Intel SDM and AMD APM, VM exits reporting a linear address
like INVLPG must report the address after masking tag bits if Linear Address
Masking (LAM) or Upper Address Ignore (UAI) is active.

Would it be necessary to pass this through ctxt->ops->get_untagged_addr()
here to ensure the resulting address is architecturally compliant?

> +}
> +
>  static int emulator_check_intercept(struct x86_emulate_ctxt *ctxt,
>  				    enum x86_intercept intercept,
>  				    enum x86_intercept_stage stage)
> @@ -427,6 +447,7 @@ static int emulator_check_intercept(struct x86_emulat=
e_ctxt *ctxt,
>  		.src_type   =3D ctxt->src.type,
>  		.dst_type   =3D ctxt->dst.type,
>  		.ad_bytes   =3D ctxt->ad_bytes,
> +		.intercept_linear_addr =3D get_intercept_linear_addr(ctxt, intercept),

[Severity: Medium]
Is this new field actually consumed by the architecture-specific handlers?

Looking at svm_check_intercept() and vmx_check_intercept(), it doesn't
appear that either handler reads the intercept_linear_addr field from
x86_instruction_info.

If this field remains unused, does the original issue with nested
hypervisors receiving an incorrect INVLPG address remain unfixed?

>  		.rip	    =3D ctxt->eip,
>  		.next_rip   =3D ctxt->_eip,
>  	};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787116250.gi=
t.zhang_wei@open-hieco.net?part=3D1
