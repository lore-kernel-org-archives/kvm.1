Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61622571B8
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490775; cv=none; b=Pa3pp2BDyVzxTzuuIA2/RX6jtGj4y03M4mGlH5YbmuSS2sBS+7CHVeU0zGj4Vnkx7HsJCGrvYIJzeqJeBrImLYJgytlUUQJtxfsP6aw3jpkv0oC+veChTNZ5YmGkGhE2zKaUZtWN/kg7TiJENFPSncOMfDqdc+uAL9Au5ZAp9DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490775; c=relaxed/simple;
	bh=x9/j9XFGRBEc1YJ9ag/xOuE681QJULLJ+Z9kJwfjNtc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a97N3c/Qy/BIyE/EJgmn55MH7PRijkRP2JGUKk9bNqZ0Ou7AYuh7SeWyTdQ30AZrBZg4tzQJuOd4qflSGdNPoFbnNfOxRnBCzzMP3HFCzHa6/dDFID5GyQMIh49fsHiW+M4Ya97tAFvBZl0crvWfEF2KdTu0hXsrfu55dn+UtKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omVm2eFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omVm2eFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631CE1F000E9;
	Fri, 31 Jul 2026 09:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785490773;
	bh=CJSQkd0VBYa6YAfkXH832hdXi08s0p7Hag63L0kvqWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=omVm2eFjy+3JgCmd5CvpbURogGJS3PNxc8Vesh1CnJZP0vLOzmQNT7hPNOST5ws6x
	 +SoJobGQomuDGC/Ksz6/xjwDbGztZCSOsyBq/H1YRNJ+ip6eb/IJj0fMzU+zje+SM8
	 psMY+CGRFm25JLz8ViZho2BErbb5SO2ggiNpG+NNhybKvo6228IabQJlVk33qCQ2yE
	 Ja7oaFWYgmCX9J9uiiro1l3n2WvfDqcnFbf6fG2tbS0NV/hZge0dOWH7Sgna/7KTNX
	 Ke30B3RFSbS7dnNbH7JW1llIa63UhwVNC0xF4ZaITn5XunjubDre2niWA+ahza+t+V
	 oLK2vxcbISvOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] RISC-V: KVM: Remove redundant TLB flush
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260731091215.1549430-4-wang.yechao255@zte.com.cn>
References: <20260731091215.1549430-1-wang.yechao255@zte.com.cn>
 <20260731091215.1549430-4-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 09:39:32 +0000
Message-Id: <20260731093933.631CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Removing the local TLB flush exposes a race window where KVM M=
MU lock is dropped while hardware TLBs contain stale writable entries, lead=
ing to silently lost guest writes.

Pre-existing issues:
- [High] `kvm_riscv_gstage_op_pte` uses non-atomic operations to modify lea=
f PTEs, which clobbers concurrent hardware A/D bit updates.
--

--- Patch [3]: [PATCH v5 3/5] RISC-V: KVM: Remove redundant TLB flush opera=
tions ---
commit ab801407dda8f4868b984976c778a3125e138920
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Remove redundant TLB flush operations

This commit removes a TLB flush from kvm_arch_mmu_enable_log_dirty_pt_maske=
d()
during dirty logging initialization. It relies on the callers to perform the
remote TLB flush later.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 2362eeb6c08a5..5a93cffa9ad7f 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -163,14 +163,15 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct=
 kvm *kvm,
>  	phys_addr_t start =3D (base_gfn +  __ffs(mask)) << PAGE_SHIFT;
>  	phys_addr_t end =3D (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
>  	struct kvm_gstage gstage;
> -	bool flush;
> =20
>  	kvm_riscv_gstage_init(&gstage, kvm);
> =20
> -	flush =3D kvm_riscv_gstage_wp_range(&gstage, start, end);

[Severity: High]
This is a pre-existing issue, but does kvm_riscv_gstage_op_pte() clobber
concurrent hardware A/D bit updates when write-protecting these pages?

Looking at kvm_riscv_gstage_op_pte() called by kvm_riscv_gstage_wp_range(),
it uses a non-atomic read-modify-write sequence for leaf PTEs:

arch/riscv/kvm/gstage.c:kvm_riscv_gstage_op_pte() {
    ...
    else if (op =3D=3D GSTAGE_OP_WP)
        set_pte(ptep, __pte(pte_val(ptep_get(ptep)) & ~_PAGE_WRITE));
    ...
}

If the RISC-V hardware page-table walker concurrently sets Access or Dirty
bits on the same PTE while KVM is write-protecting it, could this non-atomic
update silently overwrite and lose those hardware updates?

> -	if (flush)
> -		kvm_flush_remote_tlbs_range(kvm, start >> PAGE_SHIFT,
> -					    (end - start) >> PAGE_SHIFT);
> +	kvm_riscv_gstage_wp_range(&gstage, start, end);
> +
> +	/*
> +	 * remote TLB flush is not needed here since callers of
> +	 * kvm_arch_mmu_enable_log_dirty_pt_masked() already do it.
> +	 */

[Severity: Critical]
Is it safe to delay the remote TLB flush until the callers execute it?

When kvm_arch_mmu_enable_log_dirty_pt_masked() returns, some callers drop
the KVM MMU lock before the remote TLB flush happens. For example, in the
dirty ring reset path:

virt/kvm/dirty_ring.c:kvm_reset_dirty_gfn() {
    ...
    KVM_MMU_LOCK(kvm);
    kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot, offset, mask);
    KVM_MMU_UNLOCK(kvm);
    ...
}

Could this expose a window where vCPUs can use stale writable TLB entries
to write to pages without triggering a page fault, silently losing those
guest writes before the TLB is eventually flushed by the caller?

>  }
> =20
>  void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *me=
mslot)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731091215.1549=
430-1-wang.yechao255@zte.com.cn?part=3D3
