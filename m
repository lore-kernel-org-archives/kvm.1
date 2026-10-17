Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35374CF474
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 03:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792207651; cv=none; b=DJvVrDO7B8xPyGdy2MW9B2sS7+4WLirz1ynQiPkyLt15FRlQyifok5KSRlE8m6E/iUOj3FS5ntDKbRqcnwxO7ekpuIWZ4yiVqxkTvscdmG70jtajzaSvthDHD9jOcaMizkJ6cIlkzknlnczYSbXoXH1RbZyYGSGVsvVoSYPqGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792207651; c=relaxed/simple;
	bh=se2r3Fv9k0MzHtqcfSjo0Hf6nwmZDajF+GEzQLZ5dxM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DFQa7icKXaOlbL/CQO6punF87udiAcpdYm/2o7E4boNSJQfNoZxYl+a5LjsqMgNHWU3roZ5PbR7MJHT7nVmaDInPmqbBZxxNSM+IV8AL/v6xT+p3/uVFRhywXlseRsbboxX+3pCSU6DqATR3emnK2M4lPLAPAr76XSU91zI93JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxsC3Mnr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxsC3Mnr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1B21F000C4;
	Sat, 17 Oct 2026 03:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792207649;
	bh=zjRj/LRmO+CiP3Hdb+V+y89DzaRI2HDRySJVNaBxuH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JxsC3MnrN+UpD9s0DcELXWXsAN2yEM+dt63L3YoqcHDvGoqrdHmG0xCpB4WcfX+Ws
	 nQ6Nyt/GjLM811CXjUSxgBTHGd+BCMnNOwb03cK0hZ5B5/t0LBrFImtYvzyPdXdCey
	 2/GyKCHuo5VnIoHS8GHQHkCQYzNAjarvztdbNSEbd3jSkLFwJZPyD1vcs4xt4zRxvM
	 H2tIPBd88AZYTS+wVn4S7xc1bCGoO+MfOtnKfAuPgieAVt0ZOqOnxG9sq6wbNxaodu
	 zo3fkjCIinouUr+ErkQDkAAZS1GZ+/g3LoA6g0h7IRUeFMByvcNNX0opF01xMlZ+Y3
	 5D5Q69YApDabA==
Message-ID: <sashiko-outbox-175245@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: riscv: Only fast-path dirty-log write faults on
 host-writable leaves
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeungJu Cheon" <suunj1331@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261017030927.345454-1-suunj1331@gmail.com>
References: <20261017030927.345454-1-suunj1331@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 03:27:29 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] KVM: riscv: missing host page dirtying in kvm_riscv_mmu_map() =
on read fault
--

commit 62242a1df73a6632040ee4bbfc1be21570c1f2af
Author: SeungJu Cheon <suunj1331@gmail.com>

KVM: riscv: Only fast-path dirty-log write faults on host-writable leaves

This commit records host writability in RSW bit 9 (KVM_GSTAGE_PTE_HOST_WRIT=
ABLE)
on G-stage leaf PTEs before dirty logging forces the mapping read-only, and
checks this bit in kvm_riscv_mmu_dirty_log_write_fault_fast() so that
read-only host mappings fall back to the slow path.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 371fccaf9df08..bbc8ab632c8a1 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -586,6 +586,12 @@ static bool kvm_riscv_mmu_dirty_log_write_fault_fast=
(struct kvm *kvm,
>  			break;
>  		}
> =20
> +		/* Let the slow path handle host-side write protection and CoW. */
> +		if (!(pte_val(old_pte) & KVM_GSTAGE_PTE_HOST_WRITABLE)) {
> +			ret =3D false;
> +			break;
> +		}
> +
>  		if (!dirty_marked) {
>  			mark_page_dirty_in_slot(kvm, memslot, gfn);
>  			dirty_marked =3D true;
> @@ -629,6 +635,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>  	bool is_hugetlb;
>  	bool unused =3D false;
>  	bool writable;
> +	bool host_writable;
>  	unsigned int vma_pageshift;
>  	gfn_t gfn =3D gpa >> PAGE_SHIFT;
>  	struct vm_area_struct *vma;
> @@ -713,6 +720,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>  	if (is_error_noslot_pfn(hfn))
>  		return -EFAULT;
> =20
> +	host_writable =3D writable;
> +
>  	/*
>  	 * If logging is active then we allow writable pages only
>  	 * for write faults.
> @@ -738,10 +747,12 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct=
 kvm_memory_slot *memslot,
>  	if (writable) {
>  		mark_page_dirty_in_slot(kvm, memslot, gfn);
>  		ret =3D kvm_riscv_gstage_map_page(&gstage, pcache, gpa, hfn << PAGE_SH=
IFT,
> -						vma_pagesize, false, true, out_map);
> +						vma_pagesize, false, true, host_writable,
> +						out_map);
>  	} else {
>  		ret =3D kvm_riscv_gstage_map_page(&gstage, pcache, gpa, hfn << PAGE_SH=
IFT,
> -						vma_pagesize, true, true, out_map);
> +						vma_pagesize, true, true, host_writable,
> +						out_map);
>  	}
> =20
>  	if (ret)

[Severity: Critical]
Should the out_unlock path in kvm_riscv_mmu_map() also be updated to pass
host_writable instead of writable to kvm_release_faultin_page()?

Currently, the end of kvm_riscv_mmu_map() does:

out_unlock:
	kvm_release_faultin_page(kvm, page,
				 unused || (ret && ret !=3D -EEXIST), writable);

When dirty logging is enabled on a writable memslot (logging =3D=3D true) a=
nd the
guest triggers a read fault (is_write =3D=3D false) on a page whose primary=
 MMU
PTE already has write permission (such as a clean MAP_SHARED shmem/memfd fo=
lio
faulted in for read, or an anonymous folio after MADV_FREE),
__kvm_faultin_pfn() sees pte_write() via get_user_page_fast_only() and sets
writable =3D true without marking the host PTE or folio dirty.

kvm_riscv_mmu_map() then records host_writable =3D true, sets writable =3D =
false
because (logging && !is_write), and installs a read-only G-stage PTE with
KVM_GSTAGE_PTE_HOST_WRITABLE set. Because writable is false at out_unlock,
kvm_release_faultin_page() calls kvm_release_page_clean(page) instead of
kvm_release_page_dirty(page).

If the guest subsequently writes to that GPA,
kvm_riscv_mmu_dirty_log_write_fault_fast() sees KVM_GSTAGE_PTE_HOST_WRITABLE
and makes the G-stage PTE writable under read_lock(&kvm->mmu_lock) without
marking the backing host folio dirty:

include/linux/kvm_host.h:kvm_release_faultin_page()
	/*
	 * If the page that KVM got from the *primary MMU* is writable, and KVM
	 * installed or reused a SPTE, mark the page/folio dirty.  Note, this
	 * may mark a folio dirty even if KVM created a read-only SPTE, e.g. if
	 * the GFN is write-protected.  Folios can't be safely marked dirty
	 * outside of mmu_lock as doing so could race with writeback on the
	 * folio.  As a result, KVM can't mark folios dirty in the fast page
	 * fault handler, and so KVM must (somewhat) speculatively mark the
	 * folio dirty if KVM could locklessly make the SPTE writable.
	 */

Since G-stage unmapping only clears the PTE without propagating dirty state=
 to
the host struct page, can host page reclaim later evict the guest-modified
folio as clean without writeback or swap-out, losing the guest's written da=
ta?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017030927.3454=
54-1-suunj1331@gmail.com?part=3D1
