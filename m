Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644177;
	b=36jJkm1IZaw9kkJHmPIEwVZtYnnMGcKoKpbZsCIMciX1XOjDk7H3ijRs5QZDyQRJGYh3
	 G8OAPAzGGJRzg58jJBt5H4RveJbez9AA21Ioz6A4ut/LMO4GAttCwk0dP2kdQ+uIoz016
	 5SWzq3ep7Z7/lITF8FZy3RSxgvNvY8oDa8RhL7naLoJrzOKBNuxJUnrmEAva/WPhHVzS7
	 UHDtHxA66IH8qw+OGeWLJvV3JdleAuXfRod8u71+UWqgpFjl/0t4mhHtrhAsBHNwbrpqt
	 E7HxWvi8YIZAm8JXXZpmtyKuh3N7/oH2LlIhl2IaATHoir+Q+CXYDLCAdtrRQiYUkww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644177;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UDYIO87UKVrFoYY3GWQky86wVsWlWg6yqnn1TXBjTxo=;
	b=nR7hKn8R8ZEoMq7IMg5sDwy/MBH/MmC3PnHW8vPq208x9rams9LKpqvNbjN2C+K+ZRUw
	 xtRPEH5aW7Hmmu5zVmyFLqe6EShBP66mV+0rAKGZ2GcFEGBAo5ID8JhRvZMBPbpvy6nJ4
	 l/FI9/Tlc/csvLYDBqog9EASohY3bjp84J6CT56Pm6j2HEVVw74ytFjN0OXv0QxWKqZO5
	 ISsK0jcaSNJBLi/+xj6LR+xbMPu69TnC0z/aHVyg5bvFXGdYYosW8YMPpLWDdpNgnBCmt
	 qLBNZK3PbCtXuySnjGUt2LrB1PLDPOl+BF1edTmwvYA6sWhPKguQfuGdcGOI5RItvpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpb0MU3S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B790D606A327
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpb0MU3S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE301F00A17;
	Mon,  2 Nov 2026 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793644176;
	bh=UDYIO87UKVrFoYY3GWQky86wVsWlWg6yqnn1TXBjTxo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cpb0MU3SSM7pudaaOqXxpJWswtkQgcmuIQaxKjh6kwiwKCBdHAs2TqWEuelqfyAwH
	 Icf/CMhNYM8Cubl39+qQmBirdRjEaWm0TFn5iF/alnCJyaFMke0FXkNzPZpjx1jJ69
	 87cxvBiDXfDzxDI+HGInbiQBhM5P5Kb25qirGSgvwJplQZEVbXahQqIh+bWVp69V6b
	 Sfac80iukh/0tE1GODOQOuQrEeIxra6nY3TtxMzs9u8YSQFwpQiutBWntBI/C7Cq1E
	 MCgL9kJKKdFkEoPfb48vJTopmX7zgQGA45ONg3zPGtwWObgf8YOvkbwGt/BAo7AtQh
	 y0qCS59FVIMyw==
Message-ID: <sashiko-outbox-193941@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 36/45] KVM: x86: Propagate memory faults through
 load_pdptrs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174512.8903-20-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174512.8903-20-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:29:36 +0000
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
- [High] KVM: x86: unconditional memory fault exit on read failure in load_=
pdptrs()
- [High] KVM: SVM: svm_cache_reg() kills VM when load_pdptrs() returns nega=
tive errno
--

commit 780e6889d183774ef90a40deaa0094e70e71d6a2
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86: Propagate memory faults through load_pdptrs()

This commit changes load_pdptrs() and its callers to propagate negative
errno values so memory attribute faults can be distinguished from other
PDPTR load failures.

> diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
> index 3969b769f1c19..b7c25b16ffcaf 100644
> --- a/arch/x86/kvm/regs.c
> +++ b/arch/x86/kvm/regs.c
> @@ -176,7 +176,12 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long=
 cr3)
>  	/* Note the offset, PDPTRs are 32 byte aligned when using PAE paging. */
>  	ret =3D kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(real_gpa), pdpte,
>  				       cr3 & GENMASK(11, 5), sizeof(pdpte));
> -	if (ret < 0)
> +	if (ret =3D=3D -EFAULT) {
> +		kvm_prepare_memory_fault_exit(vcpu, real_gpa & PAGE_MASK, PAGE_SIZE,
> +					      false, false, false);
> +		return ret;
> +	}
> +	if (ret)
>  		return 0;

[Severity: High]
Does load_pdptrs() misclassify every read failure from
kvm_vcpu_read_guest_page() as a memory attribute fault?

Looking at virt/kvm/kvm_main.c, kvm_vcpu_read_guest_page() calls
__kvm_read_guest_page(), which only ever returns 0 or -EFAULT:

virt/kvm/kvm_main.c:__kvm_read_guest_page() {
	addr =3D gfn_to_hva_memslot_prot(slot, gfn, NULL);
	if (kvm_is_error_hva(addr))
		return -EFAULT;

	attrs =3D kvm_get_vm_memory_attributes(kvm, gfn);
	if (attrs & attr)
		return -EFAULT;

	r =3D __copy_from_user(data, (void __user *)addr + offset, len);
	if (r)
		return -EFAULT;
	return 0;
}

Because __kvm_read_guest_page() returns -EFAULT for all failure cases
(including when real_gpa is unmapped and has no backing memslot), the
following check in load_pdptrs():

	if (ret)
		return 0;

becomes unreachable dead code, and any unmapped PAE CR3 GPA prepares a
KVM_EXIT_MEMORY_FAULT and returns -EFAULT instead of 0.

Doesn't this cause kvm_set_cr0(), kvm_set_cr3(), and kvm_set_cr4() to exit
to userspace with KVM_EXIT_MEMORY_FAULT instead of returning 1 to inject
#GP(0) when a PAE guest loads an unmapped GPA into CR3, and cause
__set_sregs_common() (via KVM_SET_SREGS or KVM_SET_SREGS2 without
KVM_SREGS2_FLAGS_PDPTRS_VALID) to fail with -EFAULT when CR3 is not backed
by a memslot?

Should load_pdptrs() check kvm_prepare_memory_fault_exit_for_range() (or
!kvm_mem_attributes_may_read_gfn()) before preparing KVM_EXIT_MEMORY_FAULT
and returning -EFAULT, similar to kvm_read_guest_virt_helper() and
emulator_read_write_onepage()?

[ ... ]

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 669bf8b36bb63..fd4df88576c28 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1591,8 +1591,8 @@ static void svm_cache_reg(struct kvm_vcpu *vcpu, en=
um kvm_reg reg)
>  		 * When !npt_enabled, vcpu->pdptrs[] is already available since
>  		 * it is always updated per SDM when moving to CRs.
>  		 */
> -		if (npt_enabled)
> -			load_pdptrs(vcpu, kvm_read_cr3(vcpu));
> +		if (npt_enabled && load_pdptrs(vcpu, kvm_read_cr3(vcpu)) < 0)
> +			kvm_vm_dead(vcpu->kvm);
>  		break;
>  	default:
>  		KVM_BUG_ON(1, vcpu->kvm);

[Severity: High]
Can an L1 or L2 guest in PAE paging mode trigger kvm_vm_dead() here on AMD
SVM with NPT enabled?

When npt_enabled is true, init_vmcb() clears INTERCEPT_CR3_WRITE, so guest
writes to CR3 are not intercepted. On VM-exit, svm_vcpu_run() copies
svm->vmcb->save.cr3 to vcpu->arch.cr3 and clears VCPU_REG_PDPTR from
vcpu->arch.regs_avail (and on nested VMRUN with nested NPT enabled,
nested_svm_load_cr3() sets vcpu->arch.cr3 and calls
kvm_register_mark_for_reload(vcpu, VCPU_REG_PDPTR)).

If the guest sets CR3 in PAE mode to an unmapped GPA or a GPA with
KVM_MEMORY_ATTRIBUTE_NR (or if a nested GPA walk in kvm_translate_gpa()
hits a page with KVM_MEMORY_ATTRIBUTE_NR) and then triggers a KVM page walk
or userspace calls KVM_GET_SREGS2:

kvm_vcpu_ioctl_x86_get_sregs2() / walk_addr_generic()
  -> kvm_pdptr_read()
    -> svm_cache_reg(vcpu, VCPU_REG_PDPTR)
      -> load_pdptrs()

won't load_pdptrs() return -EFAULT and cause svm_cache_reg() to terminate
the VM via kvm_vm_dead() instead of treating an unmapped GPA as invalid
PDPTRs or propagating KVM_EXIT_MEMORY_FAULT to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D36
