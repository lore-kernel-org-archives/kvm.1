Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7967A95E
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782432037; cv=none; b=GD8LsfrWHoHre6blxIRA7fQc+Lp7Gkej2pslQU9CGawDeEP5rAnHFk/pgewT+qJPSOPHphAMB9AwTAiYsw/be7/cLQo40GJ9drR7SRwT/YT5siQS7tRztDU5Zanweyj3k3/7cbXpJtkibCA5XfwRm8k0knpjBbyAUS601i5pnYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782432037; c=relaxed/simple;
	bh=1QAO8dTnmD8PutoNjR6HRmwP0rR0aF3vFuK08gIO27Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EJadtlcYsKetDFf2Vvy5cyRcHueZon5vlM7iUMsgmUdLgi1njGX8ioQ2Sl9OKYXRq0MIFnFb5kv/iPUQCbLn0SkCKvDgWeW27O0fYsCYV8zIWpCOlrlim5fkBFziZEJJlSqGF/mpSVrVX45aBdXY564GGAwt80FDuCGG91xiRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9xo09P8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9xo09P8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324E51F000E9;
	Fri, 26 Jun 2026 00:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782432036;
	bh=EPsHI3oy8FhRmvHes56PGAft9ROUedI+pmWySOFpvCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I9xo09P8CVpz2wLhK7Y9SL5/Ma+DMftB57keSrN2fdEYbgaZ3YP/ekYNXP/dfy/7Q
	 scVSEBpwvEAOLGOHZgE+0FLHbvDecNZFL8bMHmCXmYGkrks8dY8sJB/fWp5VpqunDD
	 hSHFu7R23dChcJtUYYFD8hdMpfmeHOFncqmYwxP0scY20FXpV9aX3VX7te+PkS07Zr
	 wKsY+zU/1VuArEPnuswcNILd/4kHVrE7fOAHk8XJZFmTjhqphZoHpE8wOcWgP6RAqW
	 89mMfueQaweaf0sLEQM07yNh2mVKFmqrg045xpbcLLv9drNRNZoNKYB/CzR8JwkBKt
	 6lt1C4j44ORzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] KVM: x86: Add static calls for nested
 virtualization ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260625233846.3407303-3-seanjc@google.com>
References: <20260625233846.3407303-1-seanjc@google.com>
 <20260625233846.3407303-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 00:00:35 +0000
Message-Id: <20260626000036.324E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Information Leak / Uninitialized Return Value when calling NULL =
static call `get_evmcs_version` on SVM.
--

commit a3db248f6082141a0dcdf9674e27160ae5feddb5
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Add static calls for nested virtualization ops

This commit introduces static calls for nested virtualization operations in
KVM x86 to optimize hot paths when L2 is active. It replaces indirect
function calls with static calls using newly defined KVM_X86_NESTED_OP
macros.

> diff --git a/arch/x86/include/asm/kvm-x86-nested-ops.h b/arch/x86/include=
/asm/kvm-x86-nested-ops.h
> new file mode 100644
> --- /dev/null
> +++ b/arch/x86/include/asm/kvm-x86-nested-ops.h
> @@ -0,0 +1,36 @@
[ ... ]
> +#ifdef CONFIG_KVM_HYPERV
> +KVM_X86_NESTED_OP_OPTIONAL(enable_evmcs)
> +KVM_X86_NESTED_OP_OPTIONAL(get_evmcs_version)

[Severity: Medium]
Since get_evmcs_version can be NULL (for example, on AMD SVM where
Enlightened VMCS is not supported), should this be declared using
KVM_X86_NESTED_OP_OPTIONAL_RET0 instead of KVM_X86_NESTED_OP_OPTIONAL?

When a static call is defined as OPTIONAL and updated with a NULL pointer,
the infrastructure patches it to a NOP or a RET trampoline. This does not
safely zero the return register.

> +KVM_X86_NESTED_OP(hv_inject_synthetic_vmexit_post_tlb_flush)
> +#endif
> +#endif
> +
> +#undef KVM_X86_NESTED_OP
> +#undef KVM_X86_NESTED_OP_OPTIONAL
> +#undef KVM_X86_NESTED_OP_OPTIONAL_RET0

> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
[ ... ]
> @@ -2788,7 +2788,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct =
kvm_cpuid2 *cpuid,
>  	int i, nent =3D ARRAY_SIZE(cpuid_entries);
> =20
>  	if (kvm_x86_ops.nested_ops->enabled)
> -		evmcs_ver =3D kvm_x86_ops.nested_ops->get_evmcs_version(vcpu);
> +		evmcs_ver =3D kvm_nested_call(get_evmcs_version)(vcpu);

[Severity: Medium]
Could this lead to an information leak on platforms like AMD SVM?

In kvm_get_hv_cpuid(), the condition checks if nested operations are enable=
d.
On SVM with nested virtualization enabled, this check passes, but
get_evmcs_version is NULL.

Because the static call was defined with OPTIONAL rather than OPTIONAL_RET0,
calling it when NULL leaves the return register unmodified. This uninitiali=
zed
kernel register state is then assigned to evmcs_ver, which is subsequently
written into ent->eax and copied to userspace via copy_to_user().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625233846.3407=
303-1-seanjc@google.com?part=3D2
