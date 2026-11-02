Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644326;
	b=zUc/Q54Hde5u3v38KQfUOAes2l5d5D5VJvqbZ7mtSVMKzP4hVGqBPVIptqKrtIQz+OYu
	 ajfE3WosSw8MafHM2aGpG6FqDOMooGgaECvU1l0boPmvMizbMrP6nOWbyGBLm4o/++7nG
	 oeksAKmpnv1l+vVW0plmECGdF+cVkDoEQ+ETCm7VG6ceL6SLR9kOztl8+xi+kaK6oQnyZ
	 31JlW/3QNlort1UCQNq7XHDnTeHNRKGKVc9jcs0TLIf2WR+uS27aFQsQ0WWv+mP7FRlQD
	 DKWcnK6ofPSXgE5dJnECdUkSea+fvS8r8KbDTMbmeiWCjER7ti4aj89uWWQzMftvEdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644326;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jBJmHmWKxRqF6xO8dQ3eNfMDzo+YOVaLqI3tbdiQkTg=;
	b=Tz81onpdq0MGMnU/Xu+pI0GtkvEWLIXXzuLAB89SgzNeamkkcULesfe3ka6pTVOdKtkK
	 sAjiZvNXx1SFtpQBBQIr5XNNljDfs0BQsCRb1lPdD1MU7+eEAhjwQvbb5kiRAUtEVb5oP
	 Wyyi786GcvsM39ScHzsXukIprHlxlcUau99tRhaFNrPLyF8L8v2D/tXhTFao9x9Q7qOTc
	 vQp8z7efUEzT0pzv1Tr9zgEo/X1NOVpLjpth+/GGrwYphT2rFIPicXNdDPj8apP/iiezH
	 sgV/j52R2unPXFcUOLvHzydWlCjmrCz/6ApGShb3MbRMIuaDSshCNRebP54p31QiBBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JNAUgWCw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2176606A326
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JNAUgWCw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5911F00A1A;
	Mon,  2 Nov 2026 18:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793644325;
	bh=jBJmHmWKxRqF6xO8dQ3eNfMDzo+YOVaLqI3tbdiQkTg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=JNAUgWCwEnSYvdEE5kys/Iu3SccIV2KIRVD0/jGNosq7a4QcqOHNI4j2QHIhI7dtR
	 VYlmXu9BnfmBEf69sriGnOrJ2zgWsFt5QobgLY00mBNbgqMKdNgZa7xfYCYUyMHPEE
	 izNCvERKFIhJJJu6h8w2VAAHQRKKQ5925+LBea20HHfX5BfqF8xhYVx36ztLLftjym
	 PzHXLHQkRLwV6jQhkWC4YkYT6XUwJDhTeWeBryY2MJ8ASJe7ttOuahD3c2CShpdejZ
	 LP+G9/HGS6V3qRFjcwx/kQ8s4dkGg7EVoHMa9CS/vLb5dNUwJqSwvC2x55Ga4qBxqH
	 Wl0Z0hjdFq4wg==
Message-ID: <sashiko-outbox-193946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 37/45] KVM: x86/mmu: Issue memory fault exit if walk
 failed due to memory attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174512.8903-21-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174512.8903-21-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:32:04 +0000
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
- [High] KVM: x86/svm: spurious memory fault exit in nested_svm_get_tdp_pdp=
tr()
- [High] KVM: x86: missing PDPTR error propagation in kvm_pdptr_get() kills=
 SVM VM
--

commit 47564fc6c68d998cb57e74371e6dfb0d76a0b22c
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/mmu: Issue memory fault exit if walk failed due to memory attribute

This commit updates the guest page table walker to check memory attributes =
on
page table pages and return -EFAULT with a KVM_EXIT_MEMORY_FAULT exit when a
walk fails due to unreadable memory attributes, while treating read-only
attributes on guest PTEs by suppressing A/D bit writes. It also updates
struct kvm_pagewalk's get_pdptr callback to return an error code so PAE PDP=
TR
reads can propagate faults.

Link: https://patch.msgid.link/20260918135030.171564-27-pbonzini@redhat.com

> diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
> index 97c17b120a57b..31f4d3f6ea42e 100644
> --- a/arch/x86/kvm/regs.h
> +++ b/arch/x86/kvm/regs.h
> @@ -319,6 +319,12 @@ static inline u64 kvm_pdptr_read(struct kvm_vcpu *vc=
pu, int index)
>  	return vcpu->arch.pdptrs[index];
>  }
> =20
> +static inline int kvm_pdptr_get(struct kvm_vcpu *vcpu, int index, u64 *p=
dptr)
> +{
> +	*pdptr =3D kvm_pdptr_read(vcpu, index);
> +	return 0;
> +}

[Severity: High]
Can a 32-bit PAE guest on AMD SVM with NPT enabled terminate the VM via
kvm_pdptr_get() instead of propagating -EFAULT to the page table walker?

In init_kvm_page_walk(), w->get_pdptr is wired to kvm_pdptr_get(), which
calls kvm_pdptr_read() and unconditionally returns 0:

  FNAME(walk_addr_generic)() / mmu_alloc_shadow_roots()
    -> kvm_pdptr_get()
      -> kvm_pdptr_read()
        -> svm_cache_reg(vcpu, VCPU_REG_PDPTR)

On SVM with npt_enabled, VCPU_REG_PDPTR is lazily loaded on demand in
svm_cache_reg():

arch/x86/kvm/svm/svm.c:svm_cache_reg() {
	...
	case VCPU_REG_PDPTR:
		/*
		 * When !npt_enabled, vcpu->pdptrs[] is already available since
		 * it is always updated per SDM when moving to CRs.
		 */
		if (npt_enabled && load_pdptrs(vcpu, kvm_read_cr3(vcpu)) < 0)
			kvm_vm_dead(vcpu->kvm);
		break;
}

And load_pdptrs() returns -EFAULT when translating CR3 or reading the guest
page fails:

arch/x86/kvm/regs.c:load_pdptrs() {
	...
	ret =3D kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(real_gpa), pdpte,
				       cr3 & GENMASK(11, 5), sizeof(pdpte));
	if (ret =3D=3D -EFAULT) {
		kvm_prepare_memory_fault_exit(vcpu, real_gpa & PAGE_MASK, PAGE_SIZE,
					      false, false, false);
		return ret;
	}
}

If the guest's CR3 points to a GPA with KVM_MEMORY_ATTRIBUTE_NR (or an
unmapped GPA outside any visible memslot) when KVM walks its page tables,
load_pdptrs() returns -EFAULT, causing svm_cache_reg() to call kvm_vm_dead()
while kvm_pdptr_get() returns 0 with a stale vcpu->arch.pdptrs[index] value.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index a512e0e8dd930..4d76e8880d994 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -71,22 +71,22 @@ static void nested_svm_inject_npf_exit(struct kvm_vcp=
u *vcpu,
>  	nested_svm_vmexit(svm);
>  }
> =20
> -static u64 nested_svm_get_tdp_pdptr(struct kvm_vcpu *vcpu, int index)
> +static int nested_svm_get_tdp_pdptr(struct kvm_vcpu *vcpu, int index, u6=
4 *pdptr)
>  {
>  	struct vcpu_svm *svm =3D to_svm(vcpu);
>  	u64 cr3 =3D svm->nested.ctl.nested_cr3;
> -	u64 pdpte;
> -	int ret;
> +	int r;
> =20
>  	/*
>  	 * Note, nCR3 is "assumed" to be 32-byte aligned, i.e. the CPU ignores
>  	 * nCR3[4:0] when loading PDPTEs from memory.
>  	 */
> -	ret =3D kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(cr3), &pdpte,
> -				       (cr3 & GENMASK(11, 5)) + index * 8, 8);
> -	if (ret)
> -		return 0;
> -	return pdpte;
> +	r =3D kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(cr3), pdptr,
> +				     (cr3 & GENMASK(11, 5)) + index * 8, 8);
> +	if (r =3D=3D -EFAULT)
> +		kvm_prepare_memory_fault_exit(vcpu, cr3 & PAGE_MASK, PAGE_SIZE,
> +					      false, false, false);
> +	return r;
>  }

[Severity: High]
Won't nested_svm_get_tdp_pdptr() cause a spurious KVM_EXIT_MEMORY_FAULT exit
to host userspace instead of injecting an SVM_EXIT_NPF into L1 when L1 sets
nested_cr3 to an unmapped GPA in 32-bit PAE NPT mode?

kvm_vcpu_read_guest_page() calls __kvm_read_guest_page(), which returns
-EFAULT for all failure modes, including missing or invalid memslots and
__copy_from_user() failures, not only memory attribute violations:

virt/kvm/kvm_main.c:__kvm_read_guest_page() {
	int r;
	unsigned long addr;
	unsigned long attrs;

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

When L1 configures 32-bit PAE NPT with nested_cr3 pointing outside any
visible memslot, mmu_alloc_shadow_roots() sees !kvm_vcpu_is_visible_gfn()
and installs kvm_mmu_get_dummy_root(). When L2 subsequently faults on the
dummy root (or KVM translates an L2 GPA via ngpa_walk.gva_to_gpa),
FNAME(walk_addr_generic) calls w->get_pdptr():

arch/x86/kvm/mmu/paging_tmpl.h:FNAME(walk_addr_generic)() {
	...
	if (walker->level =3D=3D PT32E_ROOT_LEVEL) {
		walker->error =3D w->get_pdptr(vcpu, (addr >> 30) & 3, &pte);
		if (walker->error)
			goto error;
		trace_kvm_mmu_paging_element(pte, walker->level);
		if (!FNAME(is_present_gpte)(w, pte))
			goto error;
		--walker->level;
	}
}

Previously, nested_svm_get_tdp_pdptr() returned 0 on a failed read, which
walk_addr_generic() treated as a non-present PDPTE with walker->error =3D=
=3D 0,
injecting SVM_EXIT_NPF into L1 (matching how walk_addr_generic() handles
!kvm_is_visible_memslot(slot) and kvm_is_error_hva(host_addr) at all other
page table levels).

With this change, nested_svm_get_tdp_pdptr() returns -EFAULT for any read
failure (and load_pdptrs() in arch/x86/kvm/regs.c has the same issue), which
sets walker->error =3D -EFAULT and causes FNAME(page_fault) and
FNAME(gva_to_gpa) to exit to host userspace with KVM_EXIT_MEMORY_FAULT.
Should nested_svm_get_tdp_pdptr() only prepare a memory fault exit and retu=
rn
-EFAULT when !kvm_mem_attributes_may_read_gfn(vcpu->kvm, gpa_to_gfn(cr3)),
and otherwise set *pdptr =3D 0 and return 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D37
