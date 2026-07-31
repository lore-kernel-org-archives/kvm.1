Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C63859EC
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490826; cv=none; b=kaSM4Jqhc0TkKmnHPFoncJxbz+4yJBRrgOwP1bndflcAb0ocw2itC383xV9UGUwWngY/qpIYCcohw6eDc0+oetc5Yec8TcDLo7v4rwVYlUO7ukFRKK+XqnQefcy6nsa2iC4XCVmubYgRjstFUEfsWakiBWj4HduG8QSHjKO7OGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490826; c=relaxed/simple;
	bh=datgWe2O+DqwnlEP/uQD/FSh8QzsZOXsO8rr25FkPpQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GNynQJFjpcBScERo42pZQ07d6JvyBlLonvwIGE9cFPpje2bqC3mDb9M4RoNTEni9lK5Fs9PoCPLNEvdi5Cu8yDSuO0CHF95ysD6rrL5H/pMhMpI+XS5MGnGngcFUgMwf3D7nupkn8V5TfYv9KTAQx/+lBgAGbIl/kO//01wf7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8x81o7A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8x81o7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7A11F000E9;
	Fri, 31 Jul 2026 09:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785490824;
	bh=VJjef17J6Gnl0e/Bp2QRB0LIxZrVzjEQR94wPZW6B4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N8x81o7Ay3Jm/6SWUpQV1j8FPKGEiok1y/7aXZW9X9vaBYJmrWKhI224n5gxzISJw
	 Bi4pjJfP0k/CNn6zY8kJcNKfPKVHk/oIH8WdhKtdrNFf2814QFp1pRTK32QsI0zY8o
	 bNB0jET5bfU7ucnRng5+csNmcSP9e/M4HC/vz8rZIwPbKmf0IrdWdV7P7F2eU3O3G6
	 uSMEjpCjCSynBPB+7u+TSSHKccX6tdFhKK/0H1ZwZgbucAf+OnVEeRZK1hCsKBm1g1
	 OsR1Q8lF2QwuLta50F72KQVCDFK2TAQrggq0H2jMogasE8LN349gn5czTwVoOJZWnC
	 MZwIkyt1WJXEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] RISC-V: KVM: Add the split page cache for ioctl
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260731091215.1549430-2-wang.yechao255@zte.com.cn>
References: <20260731091215.1549430-1-wang.yechao255@zte.com.cn>
 <20260731091215.1549430-2-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 09:40:24 +0000
Message-Id: <20260731094024.8D7A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] Incomplete Implementation / Dead Code: `pgd_split_page_cache` is ne=
ver used.

Pre-existing issues:
- [Critical] Use-After-Free of PGD in `kvm_riscv_mmu_map` concurrent with `=
kvm_mmu_notifier_release`.
- [High] NULL Pointer Dereference when ioctls are invoked after `kvm_mmu_no=
tifier_release` clears the PGD.
- [Medium] Memory leak of Guest Stage PGD on VM creation failure path.
--

--- Patch [1]: [PATCH v5 1/5] RISC-V: KVM: Add the split page cache for ioc=
tl context ---
commit 721380c0ab0188aeba8fad4993d1a8094c00948b
Author: Wang Yechao <wang.yechao255@zte.com.cn>
Subject: RISC-V: KVM: Add the split page cache for ioctl context

This patch adds a split page cache for dirty logging enablement and the
KVM_CLEAR_DIRTY_LOG ioctl. It introduces and initializes a new
pgd_split_page_cache in the kvm_arch structure.

> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index e2d5808169e44..71e455d166905 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -86,6 +86,7 @@ struct kvm_arch {
>  	pgd_t *pgd;
>  	phys_addr_t pgd_phys;
>  	unsigned long pgd_levels;
> +	struct kvm_mmu_memory_cache pgd_split_page_cache;

[Severity: Low]
Is this pgd_split_page_cache actually utilized anywhere? I see it initializ=
ed
in kvm_riscv_mmu_alloc_pgd() and freed in kvm_riscv_mmu_free_pgd(), but the=
re
do not seem to be any calls to populate or use this cache in the KVM RISC-V
code. Does this result in dead code?

> =20
>  	/* Guest Timer */
>  	struct kvm_guest_timer timer;
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 8a0aa5e0e216e..2017d292f4ca7 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
[ ... ]
> @@ -704,6 +705,8 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
> =20
>  	if (pgd)
>  		free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage_pgd_size));
> +
> +	kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
>  }

[Severity: Critical]
This is a pre-existing issue, but can we hit a use-after-free of the PGD me=
mory
here during concurrent execution?

If one process exits, it triggers kvm_mmu_notifier_release() which frees
kvm->arch.pgd via this path. However, kvm_mmu_notifier_release() does not
increment kvm->mmu_invalidate_seq:

virt/kvm/kvm_main.c:kvm_mmu_notifier_release() {
    idx =3D srcu_read_lock(&kvm->srcu);
    kvm_flush_shadow_all(kvm);
    srcu_read_unlock(&kvm->srcu, idx);
}

Simultaneously, if another process sharing the KVM fd triggers a page fault,
kvm_riscv_mmu_map() caches kvm->arch.pgd locklessly before checking the MMU
sequence number:

arch/riscv/kvm/mmu.c:kvm_riscv_mmu_map() {
    kvm_riscv_gstage_init(&gstage, kvm);
    ...
    mmu_seq =3D kvm->mmu_invalidate_seq;
    ...
    write_lock(&kvm->mmu_lock);
    if (mmu_invalidate_retry(kvm, mmu_seq))
        goto out_unlock;
    ...
    ret =3D kvm_riscv_gstage_map_page(&gstage, pcache, gpa, hfn << PAGE_SHI=
FT, ...);
}

Since the sequence number isn't incremented, would the retry check pass and
allow the freed PGD to be accessed by the page table walker?

[Severity: High]
This isn't a bug introduced by this patch, but does clearing the PGD here
expose us to a NULL pointer dereference?

If kvm_mmu_notifier_release() runs when the mm_struct exits, it sets
kvm->arch.pgd =3D NULL. If a concurrent or subsequent ioctl like
KVM_CLEAR_DIRTY_LOG is invoked, kvm_arch_mmu_enable_log_dirty_pt_masked()
caches the potentially NULL kvm->arch.pgd:

arch/riscv/kvm/mmu.c:kvm_arch_mmu_enable_log_dirty_pt_masked() {
    kvm_riscv_gstage_init(&gstage, kvm);
    flush =3D kvm_riscv_gstage_wp_range(&gstage, start, end);
}

Then kvm_riscv_gstage_get_leaf() calculates a PTE pointer offset relative to
the NULL PGD:

arch/riscv/kvm/gstage.c:kvm_riscv_gstage_get_leaf() {
    ptep =3D (pte_t *)gstage->pgd;
    ptep =3D &ptep[gstage_pte_index(gstage, addr, current_level)];
    while (ptep && pte_val(ptep_get(ptep))) {
}

Could this sequence trigger a kernel panic upon dereferencing ptep_get(ptep=
)?

[Severity: Medium]
This is a pre-existing issue, but does the PGD memory leak on the VM creati=
on
failure path?

If kvm_create_vm() fails after calling kvm_arch_init_vm() but before
registering the MMU notifier (for example, if kvm_init_mmu_notifier() fails=
):

virt/kvm/kvm_main.c:kvm_create_vm() {
    r =3D kvm_init_mmu_notifier(kvm);
    if (r)
        goto out_err_no_mmu_notifier;
}

The error path calls kvm_arch_destroy_vm(), but KVM RISC-V's implementation
does not free the PGD:

arch/riscv/kvm/vm.c:kvm_arch_destroy_vm() {
    kvm_destroy_vcpus(kvm);
    kvm_riscv_aia_destroy_vm(kvm);
}

Because the MMU notifier was never registered, the release callback is not
invoked either. Does this lead to a persistent memory leak of the PGD?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731091215.1549=
430-1-wang.yechao255@zte.com.cn?part=3D1
