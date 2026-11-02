Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643537;
	b=2uijZBByTK7X71rustxO9/dt5iGmU3Uc28tvv6Mwgu4lks9Znf50RigkdwYNCtvpYEcV
	 hSZJ+64cbKhSZ6mzTVUjgsoA2BH/2lNMTaQNOa7/s7A4onsccPu7x5lJuyM8/Y2835BH6
	 z8MULPIAwopkNuemOz0Q1e7uYlZ4ohsMwFF2RD2yWnt4BY0E9C3CO5LFZ6crc2ewp50GQ
	 qzubNRloT3ZsSibsmk+iF1oui00ufq3nTKQAdA+9+WgoCTBmu5VebmzvSBOKt0Xad6a8H
	 Vpl13bztcj/spHH/yLtSHXhgDWB2I09nWpkflqdLLOn+5DEfnHqIhfwgZXxMGRxqH7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643537;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f7zbsWkaqW+a0SziUgDx6s6qgKwzaAVqMVt4sik8qmU=;
	b=nNInpSCEI0lV3SAEOkchJlgfzLM6sVsvHXhigZqD6srB9xicFxuPzhTN/dY2pkrCzpci
	 IyXc+mbGni1sdXaNVVO25LaOj4eSwg9eZj0ut/th9LiAIOuC5r1ImhToF2wnF2b44izUo
	 qVdXYEP6G+Xmgxk2Ka7uhyFM1EZPwPZy9FBfFR0yHeRGJwazdESDkcjUidZ6b4dAq6idD
	 sw/16Wxoa0Zi+2LxX0YFo7+D8dbL9/LwxiHOAKW4oB6CWIpCQpytayuonFyn58I2Eii68
	 4UT5/XyNUedv6sPXkpP8Nc2omtNtLNeGizXDpc/koxMm57X32y66GCQcKnUsP0wAg4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Crvygeom;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924E9606A327
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Crvygeom
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40B31F00A1C;
	Mon,  2 Nov 2026 18:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793643537;
	bh=f7zbsWkaqW+a0SziUgDx6s6qgKwzaAVqMVt4sik8qmU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Crvygeomm/UDnIg/0GMgh7vSzzhBXXFcTEscbpvI29BvE3gx58eDmUPPYnBfDn2vn
	 icv0Qwj+gdrEGIg5R96mdnifL8piT7RzUMRLCbStLZxFGYAsHdwp2zx9pp/QqMbhr0
	 tUSLqsq1YT/Gqk4xQcZlHkmmsC4rTw61Vzn79V7vHvRJnxo0bCM7SyogJ+tEiiHAi7
	 9p95staH5S474LCzEUpyRgbTfYRH30e4UfFBxhiMsWOVBjoEzTtBQV8iIc0FLwFC8e
	 9dfF45yNtc8WsfbBLHxW9o9gyDiJISkT530D+H17lpO9EGEMdjIEr7w97TTX5RN89C
	 +0UbCSHUJUU9w==
Message-ID: <sashiko-outbox-193922@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 31/45] KVM: x86: "Handle" failed decode when skipping
 instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174512.8903-15-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174512.8903-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:18:56 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KVM: x86: skip_emulated_instruction() returns 0 with KVM_EXIT_MEMO=
RY_FAULT
- [Medium] KVM: SVM: __svm_skip_emulated_instruction() kills VM on soft int=
 RIP update
--

commit 7e42aaabee05dd2baa14946c524ae1b2af0f0bd1
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86: "Handle" failed decode when skipping instructions

This commit marks the VM dead when kvm_emulate_instruction() returns a
negative error code while skipping an emulated instruction in SVM and VMX,
and updates kvm_skip_emulated_instruction() and ICEBP handlers to check
for failure.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ece8d13c18a70..669bf8b36bb63 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -304,6 +304,7 @@ static int __svm_skip_emulated_instruction(struct kvm=
_vcpu *vcpu,
>  {
>  	struct vcpu_svm *svm =3D to_svm(vcpu);
>  	unsigned long old_rflags;
> +	int r;
> =20
>  	/*
>  	 * SEV-ES does not expose the next RIP. The RIP update is controlled by
> @@ -321,7 +322,10 @@ static int __svm_skip_emulated_instruction(struct kv=
m_vcpu *vcpu,
>  		if (unlikely(!commit_side_effects))
>  			old_rflags =3D svm->vmcb->save.rflags;
> =20
> -		if (!kvm_emulate_instruction(vcpu, emul_type))
> +		r =3D kvm_emulate_instruction(vcpu, emul_type);
> +		if (r < 0)
> +			kvm_vm_dead(vcpu->kvm);
> +		if (r <=3D 0)
>  			return 0;
> =20
>  		if (unlikely(!commit_side_effects))

[Severity: Medium]
Should __svm_skip_emulated_instruction() really mark the VM dead when called
from svm_update_soft_interrupt_rip()?

Prior to VM-Entry, kvm_check_and_inject_events() invokes
svm_inject_exception() or svm_inject_irq() -> svm_update_soft_interrupt_rip=
()
to compute NextRIP before injecting a software exception or software
interrupt:

arch/x86/kvm/svm/svm.c:svm_update_soft_interrupt_rip() {
	const int emul_type =3D EMULTYPE_SKIP | EMULTYPE_SKIP_SOFT_INT |
			      EMULTYPE_SET_SOFT_INT_VECTOR(vector);
	...
	if (!__svm_skip_emulated_instruction(vcpu, emul_type, !nrips))
		return -EIO;

In that path, no instruction side effects have been performed yet (and when
nrips is enabled, commit_side_effects is false). As noted in the comment in
svm_update_soft_interrupt_rip(), decoding is not guaranteed to succeed, and=
 a
failure returns -EIO so the caller drops the event injection and lets the
guest retry the instruction.

If the guest page at CS:RIP has restrictive memory attributes (such as
KVM_MEMORY_ATTRIBUTE_NX), kvm_emulate_instruction() returns -EFAULT and
__svm_skip_emulated_instruction() now calls kvm_vm_dead(vcpu->kvm),
terminating the VM instead of aborting the injection.

[ ... ]

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b4a42785ff727..57be93198d335 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1809,6 +1809,7 @@ static int skip_emulated_instruction(struct kvm_vcp=
u *vcpu)
>  	union vmx_exit_reason exit_reason =3D vt_get_exit_reason(vcpu);
>  	unsigned long rip, orig_rip;
>  	u32 instr_len;
> +	int r;
> =20
>  	/*
>  	 * Using VMCS.VM_EXIT_INSTRUCTION_LEN on EPT misconfig depends on
> @@ -1857,7 +1858,10 @@ static int skip_emulated_instruction(struct kvm_vc=
pu *vcpu)
>  #endif
>  		kvm_rip_write(vcpu, rip);
>  	} else {
> -		if (!kvm_emulate_instruction(vcpu, EMULTYPE_SKIP))
> +		r =3D kvm_emulate_instruction(vcpu, EMULTYPE_SKIP);
> +		if (r < 0)
> +			kvm_vm_dead(vcpu->kvm);
> +		if (r <=3D 0)
>  			return 0;
>  	}
> =20

[ ... ]

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5f7f87ff4d17c..5818101d1d8ae 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6235,8 +6235,8 @@ int kvm_skip_emulated_instruction(struct kvm_vcpu *=
vcpu)
>  	int r;
> =20
>  	r =3D kvm_x86_call(skip_emulated_instruction)(vcpu);
> -	if (unlikely(!r))
> -		return 0;
> +	if (unlikely(r <=3D 0))
> +		return r;
> =20
>  	kvm_pmu_instruction_retired(vcpu);
> =20

[Severity: High]
Won't clamping r < 0 to 0 in __svm_skip_emulated_instruction() and VMX's
skip_emulated_instruction() cause KVM_RUN to return 0 with exit_reason set =
to
KVM_EXIT_MEMORY_FAULT, while also making the r < 0 case in
kvm_skip_emulated_instruction() unreachable?

When an instruction fetch hits a guest page with non-executable or
non-readable memory attributes during kvm_emulate_instruction() ->
x86_emulate_instruction() -> x86_decode_emulated_instruction() ->
x86_decode_insn() -> kvm_fetch_guest_virt(), kvm_prepare_memory_fault_exit()
sets vcpu->run->exit_reason =3D KVM_EXIT_MEMORY_FAULT, and
x86_emulate_instruction() returns -EFAULT before reaching
handle_emulation_failure():

arch/x86/kvm/x86.c:x86_emulate_instruction() {
		r =3D x86_decode_emulated_instruction(vcpu, emulation_type,
						    insn, insn_len);
		if (r =3D=3D EMULATION_MEMORY_FAULT)
			return -EFAULT;

In both __svm_skip_emulated_instruction() and VMX's
skip_emulated_instruction(), the check:

		if (r < 0)
			kvm_vm_dead(vcpu->kvm);
		if (r <=3D 0)
			return 0;

returns 0 when r is negative, so kvm_x86_call(skip_emulated_instruction)(vc=
pu)
never returns a negative value to kvm_skip_emulated_instruction().

When 0 is propagated back to vcpu_enter_guest() -> vcpu_run() (or through
vcpu->arch.complete_userspace_io in kvm_arch_vcpu_ioctl_run()), the run loop
exits to userspace immediately on r <=3D 0 without re-entering
vcpu_enter_guest() where KVM_REQ_VM_DEAD is checked and converted into -EIO.
As a result, ioctl(KVM_RUN) returns 0 to userspace with vcpu->run->exit_rea=
son
left as KVM_EXIT_MEMORY_FAULT, violating the KVM_EXIT_MEMORY_FAULT UAPI
contract (which requires a -1 return with errno set to EFAULT or EHWPOISON).
In addition, in callers such as kvm_emulate_halt() and
kvm_emulate_ap_reset_hold() with a userspace irqchip, __kvm_emulate_halt()
overwrites exit_reason with KVM_EXIT_HLT or KVM_EXIT_AP_RESET_HOLD before
returning 0.

Note that if the vendor callbacks are changed to return a negative error co=
de
(such as -EIO) when r < 0, callers that test the return value as a boolean =
--
such as !svm_skip_emulated_instruction(vcpu) in icebp_interception(),
task_switch_interception(), nested_svm_vmrun(), and
svm_update_soft_interrupt_rip(); !skip_emulated_instruction(vcpu) in
handle_exception_nmi() and handle_task_switch();
!kvm_skip_emulated_instruction(vcpu) in kvm_emulate_wrmsr(); and
ret && kvm_skip_emulated_instruction(vcpu) in kvm_fast_pio(),
kvm_emulate_halt(), and kvm_emulate_ap_reset_hold() -- would also need to
check <=3D 0 so they do not treat a negative errno as success.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D31
