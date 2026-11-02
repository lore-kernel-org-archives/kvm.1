Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644351;
	b=SC8rrg4vaA074mbNltZoFyDqxx/zTnSz5ky1c97ESEbXF+OHQfUrLMBO6eyLUVDf41Bf
	 SgMExZkV71TYJLQ71Ctru6bZ7bGws7M4cLT/iy2k0lzk901v+M9kp4lM+Qx66DYN6EaZ4
	 IsuZpieU4dm6gjfABHRxFamPQETByXaw20hux+ZPaVP3FojEEOgjO+Qa+tRjvtHJuAhBz
	 6xoXP51zYUvX+bX+yCe5Qznh7Di4IpfS50BVo7d31mu7RQyjm+djocOagbEf0kJF4AGAx
	 7opwBfKTkYzviIxBuPY+luPKL5ldiKwz5pT8EkcEGAU0XvDkfaZEhPO13M2R2TZtGZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644351;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hnvhsCnFUfY5g4nBFrUfzwuVb+JP7T/ybxkBZk1UUcA=;
	b=wOSdAwSiKZxxlAZqDczgiPV/AoBAcNNMmXcRl+TuoUlgb3yLwdHe6EgLwUwsVzTWiyvO
	 RHNVEOQh6ImKCWb8/QoAKWpu4Is4c2W6KP0Jr/Z4fa6e9A2AtTSnfAfsLSE5yj4u2Uwp9
	 x7k7E7ex4/qQptRM0Ze4QZvfRMixHBWAO7rRG17Oygy3Ciq10rQCRWj9Fm4DgQl5j44mY
	 COpnXdvA59X4IlEbtnxvIL7fYHUa9cca+K7+qnqD9/UHqtKirDE7ecuG+1S6Ce02sQD4U
	 OCUnrHFFvx/TLQkM4PJwFbEmoSTP9CuFgl3EnEGopX7PXnnW4DkCeZi+pzU6UFN00KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QQ/GKYRk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBE9606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQ/GKYRk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1220D1F00A16;
	Mon,  2 Nov 2026 18:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793644351;
	bh=hnvhsCnFUfY5g4nBFrUfzwuVb+JP7T/ybxkBZk1UUcA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QQ/GKYRknsmJ/LFLSE6zdaGdwqrjoFD1xVyl9qSw2ro9HmUwSA16t7TYPgftbQXO/
	 9j8u2e5oR2kso46xYAbPNOkBRa76z+ysEb4p5xS3oy85oWnvXuUMhb0WR2vRsdHP9i
	 Z2XgZXCvZmsZ/9Ks9bkGJX/OBk9kFKTAPeZrC+MT3vHc6oYoRonWLvjlCPysVgBLo2
	 daL1n9bWCyNwKDo2nisnB7XLtm9NYY0jo8ztLhCyRUXQcWNBsM4qD1/uM9EDYCFZYm
	 8Kn7KgWmhkwfjeeOq6MOCVD29xSzbX4FcDvMGp9PiU8vPPnYyjHmJXH9oZIWAtERaq
	 vnyNXzKkPMkZg==
Message-ID: <sashiko-outbox-193947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 30/45] KVM: x86/emulate: Propagate memory faults to
 userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174512.8903-14-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174512.8903-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:32:30 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] KVM: x86: x86_emulate_instruction() fails to exit on EMULATION_MEM=
ORY_FAULT
- [Medium] KVM: x86: handle X86EMUL_MEMORY_FAULT in kvm_handle_memory_failu=
re()
- [Medium] KVM: x86: emulator_read_write_onepage() faults on MMIO with mem =
attributes
--

commit bb98c6118897ded1d558925a185b73b85f254506
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/emulate: Propagate memory faults to userspace

This commit introduces X86EMUL_MEMORY_FAULT and EMULATION_MEMORY_FAULT to
propagate guest memory attribute faults through the x86 instruction emulator
and out to userspace as -EFAULT or an emulation failure.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index caff8534267db..5f7f87ff4d17c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4865,7 +4865,6 @@ static int kvm_read_guest_virt_helper(gva_t addr, v=
oid *val, unsigned int bytes,
>  {
>  	struct kvm_pagewalk *gva_walk =3D &vcpu->arch.gva_walk;
>  	void *data =3D val;
> -	int r =3D X86EMUL_CONTINUE;
> =20
>  	while (bytes) {
>  		gpa_t gpa =3D gva_walk->gva_to_gpa(vcpu, gva_walk, addr, access, excep=
tion);
> @@ -4878,16 +4877,16 @@ static int kvm_read_guest_virt_helper(gva_t addr,=
 void *val, unsigned int bytes,
>  		ret =3D kvm_vcpu_read_guest_page(vcpu, gpa >> PAGE_SHIFT, data,
>  					       offset, toread);
>  		if (ret < 0) {
> -			r =3D X86EMUL_IO_NEEDED;
> -			goto out;
> +			if (kvm_prepare_memory_fault_exit_for_range(vcpu, gpa, toread, false))
> +				return X86EMUL_MEMORY_FAULT;
> +			return X86EMUL_IO_NEEDED;
>  		}
> =20
>  		bytes -=3D toread;
>  		data +=3D toread;
>  		addr +=3D toread;
>  	}
> -out:
> -	return r;
> +	return X86EMUL_CONTINUE;
>  }
[ ... ]
> @@ -4969,16 +4975,16 @@ static int kvm_write_guest_virt_helper(gva_t addr=
, void *val, unsigned int bytes
>  			return X86EMUL_PROPAGATE_FAULT;
>  		ret =3D kvm_vcpu_write_guest(vcpu, gpa, data, towrite);
>  		if (ret < 0) {
> -			r =3D X86EMUL_IO_NEEDED;
> -			goto out;
> +			if (kvm_prepare_memory_fault_exit_for_range(vcpu, gpa, towrite, true))
> +				return X86EMUL_MEMORY_FAULT;
> +			return X86EMUL_IO_NEEDED;
>  		}

[Severity: Medium]
Should kvm_handle_memory_failure() in arch/x86/kvm/x86.c also check for
X86EMUL_MEMORY_FAULT and return -EFAULT?

When a guest executes INVPCID, VMXON, VMCLEAR, VMPTRLD, VMREAD, VMWRITE,
VMPTRST, INVEPT, or INVVPID with a memory operand backed by a page that has
KVM_MEMORY_ATTRIBUTE_NR or KVM_MEMORY_ATTRIBUTE_NW set,
kvm_read_guest_virt() or kvm_write_guest_virt_system() calls
kvm_prepare_memory_fault_exit_for_range() (setting vcpu->run->exit_reason to
KVM_EXIT_MEMORY_FAULT) and returns X86EMUL_MEMORY_FAULT.

Callers such as kvm_handle_invpcid() in arch/x86/kvm/x86.c and
nested_vmx_get_vmptr(), handle_vmread(), handle_vmwrite(), handle_vmptrst(),
handle_invept(), and handle_invvpid() in arch/x86/kvm/vmx/nested.c pass that
return value to kvm_handle_memory_failure():

arch/x86/kvm/x86.c:kvm_handle_memory_failure() {
	if (r =3D=3D X86EMUL_PROPAGATE_FAULT) {
		if (KVM_BUG_ON(!e, vcpu->kvm))
			return -EIO;

		kvm_inject_emulated_page_fault(vcpu, e);
		return 1;
	}

	kvm_prepare_emulation_failure_exit(vcpu);

	return 0;
}

Because kvm_handle_memory_failure() does not handle X86EMUL_MEMORY_FAULT, it
calls kvm_prepare_emulation_failure_exit(), overwriting the prepared
KVM_EXIT_MEMORY_FAULT in vcpu->run with KVM_EXIT_INTERNAL_ERROR and returni=
ng
0 instead of -EFAULT.

Similarly, in handle_ud() in arch/x86/kvm/x86.c, if force_emulation_prefix =
is
enabled and reading the 5-byte prefix via kvm_read_guest_virt() hits a
KVM_MEMORY_ATTRIBUTE_NR page and returns X86EMUL_MEMORY_FAULT, won't
handle_ud() ignore the prepared memory fault exit and fall through to inject
a #UD into the guest instead of returning -EFAULT?

[ ... ]
> @@ -5151,8 +5159,14 @@ static int emulator_read_write_onepage(unsigned lo=
ng addr, void *val,
>  	 * i.e. if accessing host user memory failed, but this has been KVM's
>  	 * historical ABI for decades.
>  	 */
> -	if (!ret && ops->read_write_guest(vcpu, gpa, val, bytes))
> -		return X86EMUL_CONTINUE;
> +	if (!ret) {
> +		ret =3D ops->read_write_guest(vcpu, gpa, val, bytes);
> +		if (!ret)
> +			return X86EMUL_CONTINUE;
> +	}
> +
> +	if (kvm_prepare_memory_fault_exit_for_range(vcpu, gpa, bytes, write))
> +		return X86EMUL_MEMORY_FAULT;

[Severity: Medium]
What happens here in emulator_read_write_onepage() when a guest accesses an
emulated MMIO region (such as the local APIC at APIC_DEFAULT_PHYS_BASE or a
GPA with no memslot) while KVM_MEMORY_ATTRIBUTE_NR or KVM_MEMORY_ATTRIBUTE_=
NW
is set on that GPA range?

In arch/x86/kvm/mmu/mmu.c, both kvm_mmu_faultin_pfn() and
kvm_faultin_memory_protections() skip memory attribute checks when !slot,
allowing MMIO SPTE creation and returning RET_PF_EMULATE.

However, in emulator_read_write_onepage(),
kvm_prepare_memory_fault_exit_for_range() is called both when ret =3D=3D 1 =
(the
GPA was already identified as MMIO by vcpu_is_mmio_gpa() or
vcpu_mmio_gva_to_gpa()) and when ops->read_write_guest() fails due to a
missing memslot.

Because kvm_prepare_memory_fault_exit_for_range() in virt/kvm/kvm_main.c
checks kvm_mem_attributes_may_read_gfn() and
kvm_mem_attributes_may_write_gfn() without checking whether a memslot exists
for the GFN, won't it return X86EMUL_MEMORY_FAULT and abort MMIO emulation
before reaching ops->read_write_mmio()?

[ ... ]
> @@ -6528,7 +6546,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, =
gpa_t cr2_or_gpa,
>  	if (r =3D=3D EMULATION_INTERCEPTED)
>  		return 1;
> =20
> -	if (r =3D=3D EMULATION_FAILED) {
> +	if (r =3D=3D EMULATION_MEMORY_FAULT || r =3D=3D EMULATION_FAILED) {
>  		if (kvm_unprotect_and_retry_on_failure(vcpu, cr2_or_gpa,
>  						       emulation_type))
>  			return 1;

[Severity: High]
When x86_emulate_insn() returns EMULATION_MEMORY_FAULT in
x86_emulate_instruction(), routing it through
kvm_unprotect_and_retry_on_failure() and handle_emulation_failure() seems to
prevent the memory fault from reaching userspace in several cases:

arch/x86/kvm/x86.c:handle_emulation_failure() {
	...
	if (emulation_type & EMULTYPE_VMWARE_GP) {
		kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
		return 1;
	}

	if (kvm->arch.exit_on_emulation_error ||
	    (emulation_type & EMULTYPE_SKIP)) {
		prepare_emulation_ctxt_failure_exit(vcpu);
		return 0;
	}

	kvm_queue_exception(vcpu, UD_VECTOR);

	if (!is_guest_mode(vcpu) && kvm_x86_call(get_cpl)(vcpu) =3D=3D 0) {
		prepare_emulation_ctxt_failure_exit(vcpu);
		return 0;
	}

	return 1;
}

1. If EMULTYPE_ALLOW_RETRY_PF is set, kvm_unprotect_and_retry_on_failure()
   will unprotect the shadow page and return true, causing
   x86_emulate_instruction() to return 1 and re-enter the guest instead of
   exiting to userspace.

2. If kvm->arch.exit_on_emulation_error is false (the default) and
   !(emulation_type & EMULTYPE_SKIP), handle_emulation_failure() queues a #=
UD
   into the guest and, whenever is_guest_mode(vcpu) is true or
   get_cpl(vcpu) !=3D 0, returns 1 to resume the guest without exiting to
   userspace. In particular, emulator_io_port_access_allowed() in
   arch/x86/kvm/emulate.c is only called when emulator_bad_iopl(ctxt) is tr=
ue
   (which requires CPL > 0), so returning X86EMUL_MEMORY_FAULT from
   emulator_io_port_access_allowed() will always have get_cpl(vcpu) > 0 and
   inject #UD (or #GP for EMULTYPE_VMWARE_GP) into the guest instead of
   exiting to userspace.

3. Even when handle_emulation_failure() does exit to userspace by returning
   0, prepare_emulation_ctxt_failure_exit() overwrites the
   KVM_EXIT_MEMORY_FAULT prepared by kvm_prepare_memory_fault_exit_for_rang=
e()
   with KVM_EXIT_INTERNAL_ERROR, and still queues #UD if
   !kvm->arch.exit_on_emulation_error.

Should EMULATION_MEMORY_FAULT be handled separately from EMULATION_FAILED so
that it always exits to userspace (for example by returning -EFAULT when no
partial state changes have occurred, or preparing the failure exit without
retrying or injecting #UD/#GP into the guest)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D30
