Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379013;
	b=XA9sjgqJlzRqmH3+p0kZnb7w5CjjDCaQCJxM8ISuWDLqbHnlB865v59T8KCjfZvkjMzg
	 El6bMJoyfF25SQ+o/ESVYzqEuYbQ24dIF0fxABjYD5u1AS/jjyt2jP7q+vqpFG9mKVu3k
	 BGEdtRKArgaLaattPszvRq6efYfel4t4piLfhFdidKxN9MOFgIrszBDJ8lDU+Bbb6KXTj
	 QArukW911LEnb6gHUfzZ0zeIlPtib9BM1ky0dm5ydNil/L2ajXXY4qAhPt2c4ijNv5tXM
	 8K3Yy5OLkgYfi+UXIRbiJ6jbXO4etvjJ/G/cPlKr86fem2aiHfkcBLTfD1bNHtYrU2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379013;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=McH6AeIL65GsxoJHWP5gRjiU20cMoDx/jzFU0pTy1+4=;
	b=UIo+nbGvOdeYHT8juAnGCbVa2SRpszKUUJk5rxsZ1QSeUa1b/9I4ZAt+bpceyCucKi46
	 3JX0Zeg7zbYfvemgUVaJFjDQahD6Wu22EWDub5XM8KGTO+ZE8OEtZYfwMczSKGLUGmizd
	 dLqadoHlnGIx9ymGUIqJuu3ZiZsahzTznzqKhrPj/3neW0Exrryj6YVXHuGBwoiAyaoJW
	 AgFu3s5Hz9POAyF6f5AQvO02af5oWNX49cJw8doIlhzTubLjGWWHM8E7Tzv6ibuo8cJ3k
	 YTlKphbpcCi4zkjSW23wPeDjMgzCiH1F+xJfWsvv44sxZLninZQy6ltxFOXooJc5yIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZjUt+aO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0064606A31C
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZjUt+aO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB7B1F00A06;
	Wed, 11 Nov 2026 06:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794379013;
	bh=McH6AeIL65GsxoJHWP5gRjiU20cMoDx/jzFU0pTy1+4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gZjUt+aO7oKIfhlnQvcphuoEIPS2wKrJThC8QoD7q+lHeyGVzRbuMVQUCrwBqRzBF
	 WgJOqKpKIbAOYgxpXHg2/pqgArciVEkB08A0PN1g8yPnW5fF2GsSdAjtLIv4OXVvhN
	 m0rd8Q725G6/IdKub+VkYvdg2LKH/GM6l0aw0bpvbfRKZUl+mBecWo1+9Ts4vTDYca
	 m22TOsfy0XB+T9b/xK/ekLvks464LaoC6gUZxxxQedTvUypl4vubPTtJnBkDmoF6Nn
	 b4l2J6jJI6YdxdZFfmRo1dRAADhApDqPJr0/mIm59viCPQRNrMN4fts8XAPzMcIXRD
	 UN0LaakesregA==
Message-ID: <sashiko-outbox-208452@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/12] KVM: x86: Route nested VMware backdoors to KVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>, kvm@vger.kernel.org
In-Reply-To: <e03558351edde6ccd508fb38d9c2fd63e85370db.1794374897.git.zack.rusin@broadcom.com>
References: <cover.1794374897.git.zack.rusin@broadcom.com>
 <e03558351edde6ccd508fb38d9c2fd63e85370db.1794374897.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:36:52 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] KVM: VMX: nested backdoor #GP emulation checks L1 I/O
  intercepts
- [Medium] KVM: VMX: handle_exception_nmi() misses nested backdoor check
  for L2
- [Medium] KVM: x86: nested backdoor #GP filter allows RDPMC and imm8
  I/O opcodes
- [Medium] KVM: x86: nested backdoor #GP check ignores vectoring and
  error code
--

commit 4e4e8d804a5f44b6aaf5283d27ac3c5b02f0876c
Author: Zack Rusin <zack.rusin@broadcom.com>

KVM: x86: Route nested VMware backdoors to KVM

This commit adds KVM_VMWARE_ENABLE_NESTED_BACKDOOR so KVM can handle #GP
exceptions from CPL3 VMware backdoor I/O accesses in L2 guests even when
L1 intercepts #GP.

Link: https://lore.kernel.org/r/CADH9ctAGt_VriKA7Ch1L9U+xud-6M54GzaPOM_2sSA=
780TpAYw@mail.gmail.com
Link: https://lore.kernel.org/r/CABgObfb3Ttfg6H+_RpNQGSYKw9BLEwx3+EysXdL-wb=
pd1pkGHQ@mail.gmail.com
Link: https://lore.kernel.org/r/aAjrOgsooR4RYIJr@google.com
Link: https://lore.kernel.org/r/aIEnm7Y1VN-PCfF8@google.com

> diff --git a/arch/x86/kvm/vmware.c b/arch/x86/kvm/vmware.c
> index 8407dccf81fd9..066f033e7ea3b 100644
> --- a/arch/x86/kvm/vmware.c
> +++ b/arch/x86/kvm/vmware.c
> @@ -117,6 +117,14 @@ int kvm_vmware_hypercall(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
> =20
> +bool kvm_is_vmware_nested_backdoor(struct kvm_vcpu *vcpu, u32 cpl)
> +{
> +	return kvm_is_vmware_nested_backdoor_enabled(vcpu->kvm) && cpl =3D=3D 3=
 &&
> +	       lower_32_bits(kvm_rax_read_raw(vcpu)) =3D=3D VMWARE_HYPERVISOR_M=
AGIC &&
> +	       kvm_is_vmware_io_port(vcpu, kvm_rdx_read_raw(vcpu));
> +}
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_is_vmware_nested_backdoor);

[Severity: Medium]
Can an L2 CPL3 guest use kvm_is_vmware_nested_backdoor() to execute RDPMC
or immediate-port IN/OUT instructions in L0 instead of delivering #GP or a
nested intercept to L1?

kvm_is_vmware_nested_backdoor() checks only CPL, EAX, and DX, while
EMULTYPE_VMWARE_GP validates the instruction with
kvm_is_vmware_backdoor_opcode(), which also accepts RDPMC (0x0f 0x33) and
8-bit immediate IN/OUT (opcodes 0xe4..0xe7).  If L2 at CPL3 executes RDPMC
with ECX set to a VMware pseudo-PMC (0x10000..0x10002) while EAX holds
VMWARE_HYPERVISOR_MAGIC and DX holds 0x5658 or 0x5659, SVM emulates the
pseudo-PMC RDPMC in L0 (because gp_interception() passes
EMULTYPE_NO_DECODE and check_rdpmc() does not check is_guest_mode()) and
VMX fails emulation in vmx_check_intercept() with X86EMUL_UNHANDLEABLE;
similarly, an IN/OUT imm8 on SVM for a port permitted by L2's IOPL/TSS
bitmap bypasses L1's VMCB12 IOPM intercept.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 1a98f28651f70..2d12970365649 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
[ ... ]
> @@ -6490,6 +6491,10 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vc=
pu *vcpu,
>  			return true;
>  		else if (is_ve_fault(intr_info))
>  			return true;
> +		else if (is_gp_fault(intr_info) &&
> +			 kvm_is_vmware_nested_backdoor(vcpu,
> +						       vmx_get_cpl(vcpu)))
> +			return true;
>  		return false;

[Severity: High]
Does claiming the #GP here cause KVM to synthesize a nested
EXIT_REASON_IO_INSTRUCTION VM-Exit to L1 instead of emulating the backdoor
in L0 when L1 intercepts the I/O port?

After nested_vmx_l0_wants_exit() returns true, handle_exception_nmi()
calls kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE_GP) without
EMULTYPE_NO_DECODE:

arch/x86/kvm/x86.c:x86_emulate_instruction() {
    ...
	r =3D x86_emulate_insn(ctxt, is_guest_mode(vcpu) &&
				   !(emulation_type & EMULTYPE_NO_DECODE));
    ...
}

Because check_intercepts is true, x86_emulate_insn() calls
vmx_check_intercept() at X86_ICPT_PRE_EXCEPT (before check_perm_in() /
check_perm_out()) and X86_ICPT_POST_EXCEPT.  When vmcs12 intercepts I/O
ports via CPU_BASED_UNCOND_IO_EXITING or CPU_BASED_USE_IO_BITMAPS,
vmx_check_intercept() reflects EXIT_REASON_IO_INSTRUCTION to L1 instead of
handling the backdoor in L0, and also allows L2 CPL3 code to force a
synthetic I/O exit to L1 on any intercepted port 0x00..0xff via IN/OUT
imm8.

[Severity: Medium]
What happens on VMX when L1 does not intercept #GP in
vmcs12->exception_bitmap?

vmx_update_exception_bitmap() intercepts GP_VECTOR in vmcs02 whenever
kvm_is_vmware_backdoor_enabled() is true, and when
nested_vmx_l1_wants_exit() returns false, nested_vmx_reflect_vmexit()
routes the L2 #GP to handle_exception_nmi():

arch/x86/kvm/vmx/vmx.c:handle_exception_nmi() {
    ...
	if (!vmx->rmode.vm86_active && is_gp_fault(intr_info)) {
		WARN_ON_ONCE(!kvm_is_vmware_backdoor_enabled(vcpu));
		if (error_code) {
			kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
			return 1;
		}
		return kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE_GP);
	}
    ...
}

Unlike SVM's gp_interception(), handle_exception_nmi() does not check
is_guest_mode(vcpu) or kvm_is_vmware_nested_backdoor(), so L0 emulates
EMULTYPE_VMWARE_GP for L2 even when KVM_VMWARE_ENABLE_NESTED_BACKDOOR is
disabled and without the CPL3/EAX/DX filter.

[Severity: Medium]
Can nested_vmx_l0_wants_exit() and SVM's gp_interception() claim a #GP
that occurred during L2 event vectoring (or with a non-zero error code on
VMX)?

Neither check verifies that the #GP came from instruction execution rather
than IDT event delivery (IDT_VECTORING_INFO_FIELD valid on VMX or
exit_int_info valid on SVM).  If an interrupt or exception vectors in L2
at CPL3 while EAX =3D=3D VMWARE_HYPERVISOR_MAGIC and DX is a backdoor port =
and
IDT vectoring raises #GP(0), L0 claims the exit and emulates the
instruction at RIP instead of reflecting the vectoring #GP to L1; on VMX,
handle_exception_nmi() runs before the VECTORING_INFO_VALID_MASK check and
x86_emulate_instruction() calls kvm_clear_exception_queue(), dropping any
vectored exception queued from IDT_VECTORING_INFO_FIELD.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794374897.gi=
t.zack.rusin@broadcom.com?part=3D7
