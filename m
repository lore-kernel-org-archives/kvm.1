Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E63A17C211
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200329; cv=none; b=CXydTHMI4snN/aaOBOy7vE/Ph2+6cOf60XKTIKNB5/J9jpuRVMiC+aPTzrKjbFo+4l5Ng+mNJfsqnfvzzuC61o4J1wlR+zsr6sGyQWI0HdCpQUtMim9juZSzkh3YHV/m8kWSUbrZl3gA5fA6CbEgtU+EPSroHeP8Liybnvl+zgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200329; c=relaxed/simple;
	bh=ECKzjizYM06QgW/WZbWmMUhs9saqdcs2JPfQMQg8wFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q9otbYDvmdWz4hyJ7ubT+nq5SO3SF4uIKNoGinxpPH9ja4QCMlgpy1kdxtc02gbZk/wGBz2TK9BrWUkm70xzdeq2AG6lRGtlnbCngNEp351TUpd/apNTTy9r30jIROfI4X/GJRqUuGmerfez+zQ08QqG3XveAGQPhSGkX8BQvQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5lmEx5W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5lmEx5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF2F1F000E9;
	Tue, 28 Jul 2026 00:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200327;
	bh=F6gQhNCie/3+qzF4Q53yPag3PljtiKmV1pNIFiJ0M+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B5lmEx5WdJKeyThcxf0N0j6KZhEXE7ZaokeZkysZami94znRZIaTvVse2t/GJuE8i
	 brM9KWL+amdXRvWdpPlJGIOqh5Dn5vhEOjviaU3OYFOUfWwh5U5CBgqRmm4vVV2/T0
	 TkzoG/fB+2XTkQ6hHt5iGonzN6f9Hl5/Ln7agsWGaKqoGy0qLiyeKwbU7qIy4uTDU8
	 JJxBlUV0GarpLKhGt+Ny1eQC2O8alsLdVYX/pgJQ04EV/I6+F6OTQULtY30fvxsR/8
	 a/LyF/ehNatqO8xLFh6+LAx7Pr6Ox8Qt0zW1C71xvBQXScyXoPHtJKvZPQcUOKJ0cY
	 Sdo+iZO6O6I6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] KVM: x86: Extract VMX's unhandleable emulation
 check to common x86
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728004351.887076-2-seanjc@google.com>
References: <20260728004351.887076-1-seanjc@google.com>
 <20260728004351.887076-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 00:58:46 +0000
Message-Id: <20260728005847.6EF2F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The mandatory `.vcpu_pre_run` hook is conditionally assigned `NULL=
` for VMX on non-TDX builds, causing a WARN on module load and breaking vCP=
U execution.
--

--- Patch [1]: [PATCH v4 1/6] KVM: x86: Extract VMX's unhandleable emulatio=
n check to common x86 ---
commit 1ae0061cc0844907be897cd2b6f318482c190f81
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Extract VMX's unhandleable emulation check to common x86

Expose VMX's check for unhandleable emulation as its own kvm_x86_ops hook,
and move the actual pre-KVM_RUN check into common x86.  This will allow
sharing the core logic with KVM's RSM emulation without needed to add a
post-RSM hook, and is a step towards removing the .vcpu_pre_run() hook
entirely.

> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index 04f986e3d439a..924a629c21e2f 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
[ ... ]
> @@ -939,11 +949,12 @@ struct kvm_x86_ops vt_x86_ops __initdata =3D {
>  	.flush_tlb_gva =3D vt_op(flush_tlb_gva),
>  	.flush_tlb_guest =3D vt_op(flush_tlb_guest),
> =20
> -	.vcpu_pre_run =3D vt_op(vcpu_pre_run),
> +	.vcpu_pre_run =3D vt_op_tdx_only(vcpu_pre_run),

[Severity: High]
Does this conditionally assigned NULL pointer cause a module load warning on
systems without CONFIG_KVM_INTEL_TDX enabled?

Since vcpu_pre_run is declared as a mandatory hook (KVM_X86_OP(vcpu_pre_run=
))
in arch/x86/include/asm/kvm-x86-ops.h, setting it to NULL when TDX is
disabled will trigger a WARN in kvm_ops_update().

[ ... ]

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 960ff7fcd8dba..8c3efc1be1fa4 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8867,6 +8867,11 @@ static int kvm_x86_vcpu_pre_run(struct kvm_vcpu *v=
cpu)
>  	    !kvm_apic_init_sipi_allowed(vcpu))
>  		return -EINVAL;
> =20
> +	if (kvm_x86_call(unhandleable_emulation_required)(vcpu)) {
> +		kvm_prepare_emulation_failure_exit(vcpu);
> +		return 0;
> +	}
> +
>  	return kvm_x86_call(vcpu_pre_run)(vcpu);

[Severity: High]
Could this break KVM_RUN by returning an uninitialized register value when =
TDX
is disabled?

When kvm_x86_vcpu_pre_run() calls this static call with a NULL target, the
static call machinery will patch the call site with a NOP or RET. The CPU w=
ill
execute the NOP and fall through, leaving the return value in the RAX regis=
ter
unmodified.

Since the preceding call to unhandleable_emulation_required() is a boolean
function that typically returns false (setting AL=3D0), the uninitialized R=
AX
will evaluate as <=3D 0. This would cause kvm_arch_vcpu_ioctl_run() to
immediately exit to userspace instead of entering the guest.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728004351.8870=
76-1-seanjc@google.com?part=3D1
