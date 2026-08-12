Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6237A83F
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522988; cv=none; b=TBcHmaxtNbGahUZ8aq1/BYjswifgS/xMj2NHGLUhtr+kS86IMG3p03nqvJ5dsn/IcPK1zd7s31kOmo9nmB5IbTHxNfafQtUuGFMc/z3l7Jnx40E8Jn32l6VfoNNaRd8Y+sZfoveKymn3uu5T0o/2QfoIkK/INFJo2tItblxa+yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522988; c=relaxed/simple;
	bh=OtOZyGakKa6tD83HQXNc8Z42QhkOwVATdTB1dnz7bjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yj7bfOgKXcARUHbX9KZ1gaDSlDQWRzOpsiEpkpI6hjaVNL8JXPSItoo6KWK77J67Ej2ChIPkDvdjz2DvRRPxLxaGRC9u7graL4aeEWQLGbku4i1+JTnT6sQEFoPxdeisXmEj25KAmGkwcFE/s+HDm0I+873BSRHrq5YdHgxDDe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIWP5eOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIWP5eOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E8B1F000E9;
	Wed, 12 Aug 2026 08:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786522986;
	bh=0d+JohWNWPunFpf8K4AjvVKb1G+DRBcF2Oi6nXi/j3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gIWP5eOt7Ho17NGMFOHRenFsdMuzWNVhykHV4CrxtjeAxNkHC8ywQY2TdDgRJPpFp
	 vmxvPGe7hmyikVKyR0erfIde+0LICjbONWIXvY6vmRmwlJ4jV5f3yaaWRda5RLg7UQ
	 MElY3/c+YMNPieUI6jlnMCeh8Abmo/jWbaA4LQKx3kDxbg7bBdu6GZD+L4g63m0pGr
	 Mt5V+56mnZPBBYtSrO/t8nTkikfa7eivhpL/W8VR07EyXSUcMP3wglirCUjKH4pH0q
	 myl+RSRnppLlhu2pz/ZKlRmA1oMMRtZZq+ttysioTmbAps3zUHqcWVHkda7W+KK19m
	 WOAouauzgV8Ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] KVM: TDX: Don't assume exit_reason[31:16] as
 all-0 in tdx_to_vmx_exit_reason()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiaoyao Li" <xiaoyao.li@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260812080229.2481439-4-xiaoyao.li@intel.com>
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-4-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 08:23:05 +0000
Message-Id: <20260812082306.11E8B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] `tdx_get_exit_info()` incorrectly compares the full 32-bit exit =
reason against the 16-bit `TDX_INVALID_EXIT_REASON`, exposing meaningless/i=
nconsistent exit qualification and interrupt info.

Pre-existing issues:
- [High] Strict equality checks against `vp_enter_ret` in `tdx_handle_exit(=
)` and `tdx_vcpu_run()` fail to mask the basic exit reason, bypassing criti=
cal bug checks when upper exit reason bits are set.
--

--- Patch [3]: [PATCH v3 3/4] KVM: TDX: Don't assume exit_reason[31:16] as =
all-0 in tdx_to_vmx_exit_reason() ---
commit 129e5cab6b9416a1d4e5f1f8c42f24dc1a44940c
Author: Xiaoyao Li <xiaoyao.li@intel.com>

KVM: TDX: Don't assume exit_reason[31:16] as all-0 in tdx_to_vmx_exit_reaso=
n()
   =20
When handling the real Exit Reason, don't assume the upper 16 bits as
all-0 in tdx_to_vmx_exit_reason(), in preparation for enabling Bus Lock
VM exit. Also preserve the bit 31:16 when changing the (basic) Exit
Reason, to not lose the information in bit[31:16].

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index df23db9430f06..598b85d772e37 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
[ ... ]
> @@ -942,23 +942,27 @@ static __always_inline u32 tdx_to_vmx_exit_reason(s=
truct kvm_vcpu *vcpu)
>  		 * module never attempted to run the vCPU, i.e. the Exit
>  		 * Reason is undefined, but this is NOT a failed VM-Enter
>  		 */
> -		return TDX_INVALID_EXIT_REASON;
> +		return (union vmx_exit_reason) {
> +			.basic =3D TDX_INVALID_EXIT_REASON,
> +		};
>  	}
> =20
> -	exit_reason =3D tdx->vp_enter_ret;
> +	exit_reason.full =3D (u32)tdx->vp_enter_ret;
> =20
> -	switch (exit_reason) {
> +	switch (exit_reason.basic) {
>  	case EXIT_REASON_TDCALL:
>  		if (tdvmcall_exit_type(vcpu))
> -			return EXIT_REASON_VMCALL;
> -
> -		return tdcall_to_vmx_exit_reason(vcpu);
> +			exit_reason.basic =3D EXIT_REASON_VMCALL;
> +		else
> +			exit_reason.basic =3D tdcall_to_vmx_exit_reason(vcpu);
> +		break;
>  	case EXIT_REASON_EPT_MISCONFIG:
>  		/*
>  		 * Defer KVM_BUG_ON() until tdx_handle_exit() because this is in
>  		 * non-instrumentable code with interrupts disabled.
>  		 */
> -		return TDX_INVALID_EXIT_REASON;
> +		exit_reason.basic =3D TDX_INVALID_EXIT_REASON;
> +		break;

[Severity: Medium]
When the basic exit reason is set to TDX_INVALID_EXIT_REASON here, but uppe=
r=20
bits like Bus Lock are preserved in exit_reason.full, does this break=20
tdx_get_exit_info()?

In tdx_get_exit_info(), it evaluates against the full 32-bit exit reason:

    *reason =3D tdx->vt.exit_reason.full;
    if (*reason !=3D TDX_INVALID_EXIT_REASON) {
        *info1 =3D vmx_get_exit_qual(vcpu);
        ...

Since TDX_INVALID_EXIT_REASON is the 16-bit 0xFFFF, this check will pass if=
=20
any upper bits are set, even if the basic reason was marked invalid,=20
incorrectly exposing meaningless hardware state.

[Severity: High]
This isn't a bug introduced by this patch, but by highlighting that=20
vp_enter_ret can contain upper exit reason bits (like bit 26), does this=20
expose a flaw in the strict equality checks for EPT misconfigurations?

In tdx_vcpu_run(), the check is strictly against the 64-bit value:

    if (unlikely(tdx->vp_enter_ret =3D=3D EXIT_REASON_EPT_MISCONFIG))
        return EXIT_FASTPATH_NONE;

Similarly, in tdx_handle_exit(), the bug check is also a strict comparison:

    if (unlikely(vp_enter_ret =3D=3D EXIT_REASON_EPT_MISCONFIG)) {
        KVM_BUG_ON(1, vcpu->kvm);
        return -EIO;
    }

If a hardware EPT misconfig occurs while upper bits are set in the raw=20
vp_enter_ret, won't these checks fail to identify the misconfig, bypassing=
=20
the KVM_BUG_ON() entirely?

>  	default:
>  		break;
>  	}
>
>  	return exit_reason;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812080229.2481=
439-1-xiaoyao.li@intel.com?part=3D3
