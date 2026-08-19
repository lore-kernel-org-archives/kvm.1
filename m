Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040B33CAA47
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134570; cv=none; b=Cvbl50SGsH7oP3EHxyzJ8X8GWtiD0YmYvXr0CaMaL+RpShOUyaXk/PR6RcDeaiR+qkp1xVT3zgoaF66MmDmP3SaKIcSGo2ZE5hBMG74XjzltrGt87cRmA3leaydV7I7kXo0V7lrYaanM5Tv5/s/8XfKaNPm6UhIe4MxLbZLAHyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134570; c=relaxed/simple;
	bh=8YQALuU+YI5p3q5Yk7ylB2IYOoM9NMv0HGrqxpH6mmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jUF1+icO5Q4Df0vPF0CjonBit1xHCaQV1+qB6FCFuA5vEIutQxbO75XhVh/jbB+JEohynuhLyhYgBCSnFaufuHTXqSyg9KUp8L61OfJGSOYU26+IuVW7RmUT0ZZDLGQAObxBlcbiLZtCmyiQ1EMi52H7qqacSLg63z+UeVCr7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDgFYCS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDgFYCS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733DC1F000E9;
	Wed, 19 Aug 2026 10:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787134568;
	bh=V40fQ4kKNWBKatNMslunLpfK51nG3aYbLJtEzDAtU0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hDgFYCS3BsAuN+WA7Uasuh7mIuX3zN05Idjpp2YpwMtN//ZpuFs00HZdSJxF6l367
	 VkcmUEYlYxKukJTybdQMp//lUrbQpHgXbnoVsqsmKU5zwl2gwfWYPAvoyjNiJK1fVP
	 a+jd38WrBK2O7qe0XaHn/xegDBGUkPOUVEUD12ja2ohvvFrXJLKIUGg17JZKw14CYM
	 klUvj0KdWhBgLdhgooujZOpYWJIQRtjRA9hoPOGA9RiMgFAkwr/sv0FqNL6l1PlBdQ
	 bK4LrT0vs9k9tMaSM3bTk42H9y0E0VKFWta6AZbOHTmFUqsB+s4uFfNZKoVC9YDmTQ
	 q9GZwqd89JlQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] KVM: TDX: Don't assume exit_reason[31:16] is
 all-0 in tdx_to_vmx_exit_reason()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiaoyao Li" <xiaoyao.li@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260819094903.3060020-5-xiaoyao.li@intel.com>
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
 <20260819094903.3060020-5-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:16:08 +0000
Message-Id: <20260819101608.733DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Strict equality checks on the raw 64-bit `vp_enter_ret` fail whe=
n Bus Lock VM exit sets bit 26, bypassing the intended `KVM_BUG_ON()` and f=
astpath logic.
--

--- Patch [4]: [PATCH v4 4/9] KVM: TDX: Don't assume exit_reason[31:16] is =
all-0 in tdx_to_vmx_exit_reason() ---
commit 48df7e5971adbfae6378e9f4d893dc4fe8eb125f
Author: Xiaoyao Li <xiaoyao.li@intel.com>

KVM: TDX: Don't assume exit_reason[31:16] is all-0 in tdx_to_vmx_exit_reaso=
n()

This commit changes tdx_to_vmx_exit_reason() to handle the upper 16 bits
of the exit reason instead of assuming they are all zero. It changes the
return type to union vmx_exit_reason to make manipulating the basic field
more convenient while preserving the upper bits for when Bus Lock VM exit
is enabled.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 4e275cb6927ad..9870922839552 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
[ ... ]
> @@ -949,22 +949,26 @@ static __always_inline u32 tdx_to_vmx_exit_reason(s=
truct kvm_vcpu *vcpu)
>  	 * but this is NOT a failed VM-Enter.
>  	 */
>  	if (!tdx_is_exit_reason_valid(tdx->vp_enter_ret))
> -		return TDX_INVALID_EXIT_REASON;
> +		return (union vmx_exit_reason) {
> +			.basic =3D TDX_INVALID_EXIT_REASON,
> +		};
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
This is a pre-existing issue, but since we are preparing for Bus Lock VM ex=
its
which can set bit 26 in the exit reason, will the deferred checks in other
functions still work correctly?

Looking at tdx_handle_exit() in arch/x86/kvm/vmx/tdx.c, it checks the raw
vp_enter_ret directly against EXIT_REASON_EPT_MISCONFIG:

	if (unlikely(vp_enter_ret =3D=3D EXIT_REASON_EPT_MISCONFIG)) {
		KVM_BUG_ON(1, vcpu->kvm);
		return -EIO;
	}

Similarly, tdx_vcpu_run() also performs a strict equality check:

	if (unlikely(tdx->vp_enter_ret =3D=3D EXIT_REASON_EPT_MISCONFIG))
		return EXIT_FASTPATH_NONE;

If a bus lock VM exit occurs concurrently with an EPT misconfig, setting bit
26 in vp_enter_ret, won't these strict equality checks fail and bypass the
intended bug-handling paths? Should these checks be updated to mask the upp=
er
bits or use the basic exit reason before enabling Bus Lock VM exit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819094903.3060=
020-1-xiaoyao.li@intel.com?part=3D4
