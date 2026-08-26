Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E611B412BEB
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 22:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787782124; cv=none; b=OPboqAi4pbXWK5pDmCMD9yC1VJ+ZVrRSS5Pw8ZJSRDhglRYl19fy6NmXr+ghEYLQDxFhtlWe0lchJyo9gwumjNqMVox2/pGs/VOc8uys8ng7urRyoG2USgil2zSAP4Z8twOpLz/2HsWYhNMPJyFif21zU4jByJozFCsYgaTuzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787782124; c=relaxed/simple;
	bh=McvncYbVi3AhI2Sgs5SnzG/ctrnzrLbgtJqn/UppU+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DYFn+dMy/sApQ4RBH54Y0+3WlcL0sTut2XCQMRa77TmXbRGmws+2i8ZepHtA8dFF6biSwAhlaN0PBRXzPkPdef6ljh1Dx1itRas9LFl25RrjMsgHda8lgyjp+FgyC7qo6maumJaZ2AJdUxcwK5T5bBzEDqLNGNIaPKE8s7rMOBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieAzxwW/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieAzxwW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685D41F000E9;
	Wed, 26 Aug 2026 22:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787782122;
	bh=g5/RURq+ME0EH9s4jqamgb4E0ar0NU6EyE/3bXT174k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ieAzxwW/sDG6gJhaPRNHz5+q5n31plYa9NwWfFu3v0slEzRCue6fOSXWN643SidhR
	 7uZGoxo7qvI47vofl1Sofm+p8g2kB5EdS0qVHzS86rqUIJhQVCxPvmBarOofqG3/aW
	 cWsEF5qVh5HqS5hyeVwKPFkZbUKKBU6uH0aYX2uu94fVynhhvAPvxUFD14LNiypBdX
	 O/QB6n/hJmjmbDkK1k55JZIf6W+/nR3X2+JR0nHxT/JGxUgrnVp45QP7GYJA/P6qrZ
	 avEyUbyC5w0meqBipJE9U+SUU+9VqFXMCKgZYRUf7J3OFcOd5sKHA2Dn2JlQRppuH1
	 3asLLP2faojuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] KVM: VMX: Explicitly track TDX VMs' root level
 instead of guessing it from CPUID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826215258.937210-2-seanjc@google.com>
References: <20260826215258.937210-1-seanjc@google.com>
 <20260826215258.937210-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 22:08:41 +0000
Message-Id: <20260826220842.685D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A malicious or buggy userspace can trigger a host-side WARN_ON_ONC=
E by attempting to create a vCPU for a TDX VM before successfully completin=
g KVM_TDX_INIT_VM.
--

commit d9de404aca15fbfe936c1e65aa00fb63755a135e
Author: Sean Christopherson <seanjc@google.com>

KVM: VMX: Explicitly track TDX VMs' root level instead of guessing it from =
CPUID

This commit replaces guessing the root level from CPUID with explicit track=
ing
for TDX VMs. It sets the mirror root level based on the configuration provi=
ded
during KVM_TDX_INIT_VM.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 064ecc33b9267..611c78be8b411 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
[ ... ]
> @@ -5953,19 +5953,22 @@ void __kvm_mmu_refresh_passthrough_bits(struct kv=
m_vcpu *vcpu,
> =20
>  static inline int kvm_mmu_get_tdp_level(struct kvm_vcpu *vcpu)
>  {
[ ... ]
>  	/* tdp_root_level is architecture forced level, use it if nonzero */
>  	if (tdp_root_level)
>  		return tdp_root_level;
> =20
> +	/*
> +	 * If the VM has mirror roots, then the root level is predefined as the
> +	 * mirror root (and by extension the normal root) needs to match the
> +	 * root level that was configured for the external page tables that are
> +	 * being mirrored by KVM.
> +	 */
> +	if (kvm_has_mirrored_tdp(vcpu->kvm) &&
> +	    !WARN_ON_ONCE(!vcpu->kvm->arch.mirror_root_level))
> +		return vcpu->kvm->arch.mirror_root_level;

[Severity: High]
Does this regression allow a malicious or buggy userspace to trigger this
WARN_ON_ONCE and cause a host denial of service (especially with
panic_on_warn=3D1)?

If userspace creates a TDX VM via KVM_CREATE_VM (setting the VM type to
KVM_X86_TDX_VM) and then directly calls KVM_CREATE_VCPU without executing
KVM_TDX_INIT_VM first, it appears this warning will be reached.

During vCPU creation, the MMU context is initialized unconditionally before
the architecture-specific vCPU creation callback:

kvm_arch_vcpu_create()->kvm_mmu_create()->kvm_mmu_get_tdp_level()

Because KVM_TDX_INIT_VM was skipped, mirror_root_level remains 0, satisfying
the condition and triggering the kernel warning.

The architecture-specific callback that enforces the TD_STATE_INITIALIZED
requirement is invoked too late in the process to prevent this:

kvm_arch_vcpu_create()->kvm_x86_call(vcpu_create)()

Would it be safer to return an error or handle the uninitialized state rath=
er
than triggering a host-side warning on user-controllable input?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826215258.9372=
10-1-seanjc@google.com?part=3D1
