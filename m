Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90AF3E6DD2
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357093; cv=none; b=rbUn4KF13S2CdLGi5z0BrPnhN9jIjwkRcTwxYgkvtfD73/7c0Gqi0zThpHA7sgmpYWfClWuYsel9/hNaFivZ28dfsAlUZCh315r0do7kCw2IHyaHBXQc1BeVHgEexVsWtQeQTqWVP+J+T0e0E0TnEXfTss1fM9g+n56Q9TyduoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357093; c=relaxed/simple;
	bh=w/bz/QktbQzmt/DCOx9v/kCkAfPfXM3IW2KX2M+wCJM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SKPdAC8iQi1XZLGjIynGJ1pL8wj71E+Gn4wAisgCX5FmS5UO9H1J+aZa6YSUXjn8eAo3vECXufarl53fhv2XzY/zWtqFzicW8hd3nJVBAzlOS8TvPyRAlLVQXJGw2/2PliNk7Gg5qrIoz28t7g7xEcZOkLTWGqbg69nPgrFf+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAMxkY8t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAMxkY8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9FA1F000E9;
	Wed, 29 Jul 2026 20:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785357085;
	bh=IzxKTwPOTTO4gtnztx5DBAp61IbSoIatsGp49SPVBng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oAMxkY8t/wASfIDTMorDbsvGBXPfUWGhMZRWiMAreUjk/YZGKqBXxXK3q3u12Q7qy
	 khGPvLOkH6ls4xC8DnGh8aLyLnipjVozXk8vobTV7KjCrMQOdC18iT+lx9O46ClZLS
	 94eUTunaC/XzaRNhFJg5Yq63qXJzXOH+rzRIDCHaUjsgwDlOXJjYEiEduuDNkNTWNB
	 YbQPluZj/TZtrJOrgqcgpbuasdTlbBAa+8aoSSqrfnXsOkpwY/L7SimjjbacFCMV2T
	 +Gdd3+v1llrOp1gCBNtp8rFcWrcElOY1eCJKeU2Ip64NouWfxPO2qUoxK7YqnbwmRT
	 aCafQOz6q6aBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/20] KVM: x86: Support APX state for XSAVE ABI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729191656.598771-4-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
 <20260729191656.598771-4-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 20:31:24 +0000
Message-Id: <20260729203125.2D9FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] State Leak / Incomplete Reset for APX EGPRs
- [High] APX Support is Dead Code / Broken via XCR0 Masking

Pre-existing issues:
- [High] ABI Breakage of KVM_GET_XSAVE on CPUs with APX
--

--- Patch [3]: [PATCH v6 03/20] KVM: x86: Support APX state for XSAVE ABI -=
--
commit 4bbfbdc2e52df0cb9917db88fdc15027d1a8a890
Author: Chang S. Bae <chang.seok.bae@intel.com>
KVM: x86: Support APX state for XSAVE ABI

This commit introduces a facility to copy APX state between the VCPU cache =
and
the userspace buffer. It handles the APX EGPRs specifically, copying them
to and from vcpu->arch.regs when the APX feature bit is set.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0626e835e9eb7..5578df10179ae 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -3124,6 +3124,49 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(stru=
ct kvm_vcpu *vcpu,
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_KVM_APX
> +static void kvm_copy_vcpu_regs_to_uabi(struct kvm_vcpu *vcpu, void *buf,=
 u64 supported_xcr0)
> +{
> +	union fpregs_state *xstate =3D (union fpregs_state *)buf;
> +
> +	BUILD_BUG_ON(NR_VCPU_GENERAL_PURPOSE_REGS <=3D VCPU_REGS_R31);
> +
> +	if (!(supported_xcr0 & XFEATURE_MASK_APX))
> +		return;
> +
> +	memcpy(buf + xstate_offset(XFEATURE_APX),
> +	       &vcpu->arch.regs[VCPU_REGS_R16],
> +	       xstate_size(XFEATURE_APX));
> +
> +	xstate->xsave.header.xfeatures |=3D XFEATURE_MASK_APX;
> +}
> +
> +static int kvm_copy_uabi_to_vcpu_regs(struct kvm_vcpu *vcpu, void *buf, =
u64 supported_xcr0)
> +{
> +	union fpregs_state *xstate =3D (union fpregs_state *)buf;
> +
> +	if (!(xstate->xsave.header.xfeatures & XFEATURE_MASK_APX))
> +		return 0;

[Severity: High]
Does this early return inadvertently leak the values of APX extended GPRs
across VM resets or migrations?

If userspace calls KVM_SET_XSAVE with XFEATURE_MASK_APX cleared in the
XSAVE header, the XSAVE INIT state semantics dictate that the corresponding
state should be reset. By returning 0 early here, KVM fails to zero out
vcpu->arch.regs[VCPU_REGS_R16] through vcpu->arch.regs[VCPU_REGS_R31]. KVM
will then manually load these stale register values into the CPU during
VM-entry.

> +
> +	if (!(supported_xcr0 & XFEATURE_MASK_APX))
> +		return -EINVAL;

[Severity: High]
Does this code inadvertently make APX support dead code by failing to add
XFEATURE_MASK_APX to KVM_SUPPORTED_XCR0?

Because XFEATURE_MASK_APX is omitted from KVM_SUPPORTED_XCR0, it is stripped
from KVM's capabilities. This means supported_xcr0 will never contain the A=
PX
bit, causing KVM_SET_XSAVE to unconditionally fail with -EINVAL here, and
preventing APX state from being exported during KVM_GET_XSAVE2.

> +
> +	BUILD_BUG_ON(NR_VCPU_GENERAL_PURPOSE_REGS <=3D VCPU_REGS_R31);
> +
> +	memcpy(&vcpu->arch.regs[VCPU_REGS_R16],
> +	       buf + xstate_offset(XFEATURE_APX),
> +	       xstate_size(XFEATURE_APX));
> +
> +	return 0;
> +}
[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but there is an ABI breakage with
KVM_GET_XSAVE on CPUs with APX that affects this feature area.

Because APX is not defined as an XFD dynamic feature, it is unconditionally
included in fpu_user_cfg.default_features. On CPUs supporting both AMX and =
APX,
the uncompacted offset of APX pushes fpu_user_cfg.default_size over 4096 by=
tes.

During VCPU creation in fpu_alloc_guest_fpstate():

	gfpu->uabi_size		=3D sizeof(struct kvm_xsave);
	if (WARN_ON_ONCE(fpu_user_cfg.default_size > gfpu->uabi_size))
		gfpu->uabi_size =3D fpu_user_cfg.default_size;

This inflates gfpu->uabi_size to match default_size. Later, calls to the
legacy KVM_GET_XSAVE ioctl unconditionally fail with -EINVAL because they
enforce uabi_size <=3D sizeof(struct kvm_xsave) (4096 bytes), breaking back=
wards
compatibility for older VMMs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729191656.5987=
71-1-chang.seok.bae@intel.com?part=3D3
