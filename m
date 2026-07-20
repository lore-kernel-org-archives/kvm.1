Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9B43DCD83
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571745; cv=none; b=f3/Fh3iCG4u+2O0gE0hUy/xnfPvI+R61zVRx7d2N5RsKf8BFY93pq1GL7W9/Sg42zsieklDea75nnGPT4NvTsxs/eIYLV5nsi8ycK3/IXimLZgFDUr7G24Wtbd/SNFRYRaptoALnRbgLnRAiL+lWNDNI1N0AL+hdDXwQBDuKGsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571745; c=relaxed/simple;
	bh=tA3owFB508s/Z+b6JFpxfQZhiwFuUurUfwxWZZH9dgY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kaqrYx+Br+pPYjfWmagW67WW8iI5drNqfAVtwnWZfLogT/HrP9cC3ThgSEaIoKAryq92cs2pIXbvUf+ZvzzmaJref8/ukueCuROUgVr+O1EVHnYb26lDpgX35E7qQHSSsvoMLWsl+0T++xiix1wO4drdfH5+9dqUJI0kEmKCKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLnCjBVv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLnCjBVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0388A1F000E9;
	Mon, 20 Jul 2026 18:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784571744;
	bh=Z4d33wDPdI/JQZ4VAtjcOU4LXMRq2pgCxffc9c6biO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QLnCjBVvtgHkC8VLMxm9dlDHs9c4M2DcoO1MWu3oeRPAzSu+JXGeIM2Yf8Neyu3lA
	 5tKqD5z5wNtDCYvn/ARQ7QkaNimfN8p5LlXBXAu7CoppYLiaZydpHRSY+QPmy9DMuH
	 P9Pw0OJZYG/JzxB+IDIEIrIde7fKK1GO0WmENsQmoE4Y/puzxOGXgOoXUUFt8PZ3Ot
	 ncvHKQ0iRU/z76WT5L0TqV6tC8iIaJib2zpPjLoooJcqKJt7e9c7uoQuLvIL/FshOW
	 m17qPRMFO54Jq700eVxIHjhx01Djre0WGt9r39ku+ciI4CMdv5LrDhC0qnAyHCstJc
	 obvc90UoSulEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/20] KVM: x86: Support APX state for XSAVE ABI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260720171949.498680-4-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-4-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:22:23 +0000
Message-Id: <20260720182224.0388A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] KVM_SET_XSAVE fails to reset APX registers to their architectural =
INIT state (zero) when the APX bit is missing from the provided XSAVE heade=
r.
- [High] Adding APX as a static FPU feature inflates KVM's base uABI size b=
eyond 4096 bytes on AMX-capable hosts, unconditionally breaking legacy KVM_=
GET_XSAVE and causing out-of-bounds userspace memory reads in KVM_SET_XSAVE.
- [High] kvm_copy_uabi_to_vcpu_regs() modifies vcpu->arch.regs before the r=
est of the FPU state is validated, leading to a partial VCPU state update i=
f the ioctl fails.
--

--- Patch [3]: [PATCH v5 03/20] KVM: x86: Support APX state for XSAVE ABI -=
--
commit abf6cc0d5ca657b7c271fda294578cfed25f0046
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Support APX state for XSAVE ABI

Introduce a facility to copy APX state between the VCPU cache and the
userspace buffer as VCPU cache is the single source of truth.

[ ... ]

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0626e835e9eb7..5578df10179ae 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> +#ifdef CONFIG_KVM_APX
> +static void kvm_copy_vcpu_regs_to_uabi(struct kvm_vcpu *vcpu, void *buf,=
 u64 supported_xcr0)
> +{

[ ... ]

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
Does this early return fail to reset the APX registers to their architectur=
al
INIT state?

If a VMM restores a vCPU's state using KVM_SET_XSAVE and the
XFEATURE_MASK_APX bit is clear, the APX component should be initialized to
zero. Because this returns early without modifying vcpu->arch.regs, could
this leave stale data in the VCPU's APX registers and leak state across
resets or migrations?

> +
> +	if (!(supported_xcr0 & XFEATURE_MASK_APX))
> +		return -EINVAL;

[ ... ]

> @@ -3161,6 +3211,7 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_=
vcpu *vcpu,
>  					struct kvm_xsave *guest_xsave)
>  {
>  	union fpregs_state *xstate =3D (union fpregs_state *)guest_xsave->regio=
n;

[Severity: High]
Will adding APX as a static FPU feature inflate KVM's base uABI size beyond
4096 bytes on AMX-capable hosts, unconditionally breaking legacy KVM_GET_XS=
AVE?

Because APX (a static feature) is architecturally located after AMX (a
dynamic feature) in the uncompacted XSAVE format, its presence expands
fpu_user_cfg.default_size to > 10KB. KVM expands uabi_size to this value,
which can cause legacy VMMs passing a standard 4096-byte struct kvm_xsave
buffer to trigger an out-of-bounds read in KVM_SET_XSAVE:

arch/x86/kvm/x86.c:kvm_arch_vcpu_ioctl() {
    case KVM_SET_XSAVE: {
        int size =3D vcpu->arch.guest_fpu.uabi_size;
        u.xsave =3D memdup_user(argp, size);
        ...
}

It also appears KVM_GET_XSAVE unconditionally fails because it passes a size
of 4096 to kvm_vcpu_ioctl_x86_get_xsave2(), which rejects it if
size < uabi_size:

arch/x86/kvm/x86.c:kvm_vcpu_ioctl_x86_get_xsave() {
    return kvm_vcpu_ioctl_x86_get_xsave2(vcpu, (void *)guest_xsave->region,
                                         sizeof(guest_xsave->region));
}

Is there a way to handle the legacy 4096-byte buffer size gracefully here?

> +	int err;
> =20
>  	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
>  		return vcpu->kvm->arch.has_protected_state ? -EINVAL : 0;

[ ... ]

> @@ -3172,6 +3223,16 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm=
_vcpu *vcpu,
>  	 */
>  	xstate->xsave.header.xfeatures &=3D ~vcpu->arch.guest_fpu.fpstate->xfd;
> =20
> +	/*
> +	 * This and the following copy functions copy APX state into each
> +	 * storage. The VCPU cache is the single source of truth but avoiding
> +	 * this redundant copy tends to introduce special-case handling. Since
> +	 * this lies in a slow path, keep the implementation simple.
> +	 */
> +	err =3D kvm_copy_uabi_to_vcpu_regs(vcpu, guest_xsave->region, kvm_caps.=
supported_xcr0);
> +	if (err)
> +		return err;

[Severity: High]
Does modifying the APX state before validating the rest of the FPU state
lead to a corrupted vCPU state if the ioctl fails?

Looking at kvm_copy_uabi_to_vcpu_regs(), it copies the APX state directly
into vcpu->arch.regs. If fpu_copy_uabi_to_guest_fpstate() subsequently
fails validation (for example, due to malformed MXCSR reserved bits), the
ioctl aborts and returns an error.=20

Since the APX registers were already permanently modified, could this viola=
te
transactional ioctl semantics and leave the vCPU in an inconsistent state?

> +
>  	return fpu_copy_uabi_to_guest_fpstate(&vcpu->arch.guest_fpu,
>  					      guest_xsave->region,
>  					      kvm_caps.supported_xcr0,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720171949.4986=
80-1-chang.seok.bae@intel.com?part=3D3
