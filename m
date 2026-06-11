Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D4E221721
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184302; cv=none; b=Q7+a/ef4XMWBDAuxboER7Eqrc7OzvG6++WOTxwG0xuR1CMe+H6veHZn1D08rJGbOh7W3SAxztlArEy8HEM62JKdJHNIwWL+O+Xi9DW/PxDWMXj/FUaVOJiH3QQXMT3d7pplu5m/K4zDs+PZH/cK/snpFPC/E4/1pv66NPMcO104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184302; c=relaxed/simple;
	bh=y6EgzJnc2EK/SPlbhjC3+3YBSjLg/oahvUQ+YbI8rIk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ivspsWuAi3MGNI4kmVJJk/0WIVWqGgDfJ+rUtOaI0Owl55vudEaBC2x2qEP1wJXY8gEqPxvlzNafv1FPZb0HYTLH1pTx0+PCiZqjEq0YpZj30eK4txjlQg1TjaAD4y5mUk14chjergZHryBtCuSX5Nnv4WjjoH2N9+bj3VGx7kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9wP2YBG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9wP2YBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2661F00893;
	Thu, 11 Jun 2026 13:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781184301;
	bh=1xsrPXD1UcDYw3A6NdySXPzCdLrjCT2iHgiHuEhql7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J9wP2YBG1vIm1uyHQVFnqMqhEu5APbCeJDqgBlwFtVxO7tDLcTLh9Og5dBvKGnwMB
	 cvieZrBMwALJxt6C3iXbzHaRcoVb+iBZpCpjlNIrnUvhZDhnZlr1IsUp0u8Mk2qiB0
	 EsPELuVOqmbPdyQneu3FstPPcV3uzzbfaiyeXaNACPbkDu50BklwgdTLPXTWQbUkrg
	 JxabYNSH+p15iGlLmW+M56ubUOi4Ovr+uHkWPWTANHnESo8/2BLMovKdZNbG7jGdGm
	 XnyS6Z9H+FtQ5WTxnitaCk5ghi8/7/qivv8h+uojVSLoVtm4aHv7sUi37zIgtBPHIv
	 L7BLjHlmfVK+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/3] KVM: guest_memfd: support folio migration for
 non-confidential VMs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260611-shivank-gmem-migrate-v1-2-2d266bfc6f95@amd.com>
References: <20260611-shivank-gmem-migrate-v1-2-2d266bfc6f95@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 13:25:00 +0000
Message-Id: <20260611132501.2A2661F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Conditionally skipping `mapping_set_unmovable()` for non-confi=
dential VMs inadvertently removes the `AS_UNEVICTABLE` flag, allowing silen=
t eviction of guest memory and leading to host use-after-free and privilege=
 escalation.
- [High] `kvm_gmem_migrate_folio` can use-after-free a `kvm_memory_slot` an=
d permanently leak `mmu_invalidate_in_progress` if it races with memslot de=
letion after the file descriptor is closed.

Pre-existing issues:
- [High] `kvm_gmem_error_folio` acquires `filemap_invalidate_lock_shared` w=
hile holding `folio_lock`, creating a permanent AB-BA deadlock with truncat=
e operations.
--

commit 91a9697e1cf39521338cfd839599e2eeea129a1e
Author: Shivank Garg <shivankg@amd.com>
Date:   Thu Jun 11 13:05:09 2026 +0000

    KVM: guest_memfd: support folio migration for non-confidential VMs
   =20
    guest_memfd folios are currently marked unmmovable, so the kernel
    cannot perform NUMA-balancing, memory compaction, etc.
    This is unavoidable for confidential VMs (SEV-SNP, TDX),
    since memory is encrypted and copying it need firmware assistance.
    However, for non-cofidential VMs (like firecracker), we can migrate
    the folios.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 806a42f0e031a..e4470106fc779 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -487,13 +487,45 @@ static struct file_operations kvm_gmem_fops =3D {
>  	.fallocate	=3D kvm_gmem_fallocate,
>  };
> =20
> +#ifdef CONFIG_MIGRATION
>  static int kvm_gmem_migrate_folio(struct address_space *mapping,
>  				  struct folio *dst, struct folio *src,
>  				  enum migrate_mode mode)
>  {
> -	WARN_ON_ONCE(1);
> -	return -EINVAL;
> +	struct inode *inode =3D mapping->host;
> +	pgoff_t start, end;
> +	int ret;
> +
> +	if (!filemap_invalidate_trylock_shared(mapping))
> +		return -EAGAIN;
> +
> +	start =3D src->index;
> +	end =3D start + folio_nr_pages(src);
> +
> +	kvm_gmem_invalidate_begin(inode, start, end);

[Severity: High]
Does this lockless XArray iteration risk a use-after-free and invalidate
leakage if it races with kvm_gmem_unbind() during file close?

If the file descriptor is closed (f_count =3D=3D 0), kvm_gmem_unbind() bypa=
sses
filemap_invalidate_lock because it assumes reliance on kvm->slots_lock. Sin=
ce
migration via compaction can occur before evict_inode() tears down the page
cache, kvm_gmem_migrate_folio() can run concurrently with kvm_gmem_unbind()
and memslot deletion without holding kvm->slots_lock or
srcu_read_lock(&kvm->srcu).

The yielded slot could be freed concurrently by KVM memslot deletion, causi=
ng
a use-after-free. Additionally, if the slot is removed before
kvm_gmem_invalidate_end(), xa_find() would return false and
kvm_mmu_invalidate_end() is skipped, permanently leaking
mmu_invalidate_in_progress and hanging future VM page faults.

> +
> +	/*
> +	 * For non-confidential guest_memfd the folio is host-readable,
> +	 * so filemap_migrate_folio() can copy the contents itself via
> +	 * folio_mc_copy().
> +	 *
> +	 * This is also the hook point for confidential VMs (SEV-SNP, TDX) once
> +	 * they are made movable: the host cannot copy encrypted/private memory,
> +	 * so a firmware-assisted copy would run here.
> +	 * Idea: https://lore.kernel.org/r/20260428155043.39251-8-shivankg@amd.=
com
> +	 * Mark the @dst->migrate_info field with FOLIO_CONTENT_COPIED, so
> +	 * __migrate_folio() skip folio_mc_copy() for confidential VMs.
> +	 */
> +	ret =3D filemap_migrate_folio(mapping, dst, src, mode);
> +
> +	kvm_gmem_invalidate_end(inode, start, end);
> +
> +	filemap_invalidate_unlock_shared(mapping);
> +	return ret;
>  }
> +#else
> +#define kvm_gmem_migrate_folio NULL
> +#endif
> =20
>  static int kvm_gmem_error_folio(struct address_space *mapping, struct fo=
lio *folio)
>  {

[Severity: High]
This is a pre-existing issue, but does kvm_gmem_error_folio() acquire
filemap_invalidate_lock_shared() while holding the folio lock, creating a
permanent AB-BA deadlock with truncate operations?

Truncate operations (like fallocate(PUNCH_HOLE) via kvm_gmem_punch_hole())
establish a lock ordering by acquiring filemap_invalidate_lock in write mode
first, and then locking individual folios via truncate_inode_pages_range().

However, the memory failure (HWPOISON) path (me_pagecache_clean() ->
truncate_error_folio()) locks the affected folio first and then invokes the
mapping's error_remove_folio callback. kvm_gmem_error_folio() unconditional=
ly
acquires filemap_invalidate_lock_shared(mapping) while the folio lock is
already held. If a hardware memory failure races with a hole punch on the
same guest_memfd file, this reverse lock ordering could result in an AB-BA
deadlock that hangs the kernel.

[ ... ]

> @@ -592,9 +624,17 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t=
 size, u64 flags)
>  	inode->i_size =3D size;
>  	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>  	mapping_set_inaccessible(inode->i_mapping);
> -	mapping_set_unmovable(inode->i_mapping);
> -	/* Unmovable mappings are supposed to be marked unevictable as well. */
> -	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> +
> +	/*
> +	 * Confidential VMs (SEV-SNP, TDX) bind encryption to the physical
> +	 * address and require firmware assisted copy, so their folios cannot
> +	 * be migrated yet.
> +	 */
> +	if (kvm_arch_has_private_mem(kvm)) {
> +		mapping_set_unmovable(inode->i_mapping);
> +		/* Unmovable mappings are supposed to be marked unevictable as well. */
> +		WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> +	}

[Severity: Critical]
By conditionally skipping mapping_set_unmovable() for non-confidential VMs,
do we inadvertently leave the mapping without the AS_UNEVICTABLE flag?

mapping_set_unmovable() is the only function that sets both AS_UNMOVABLE and
AS_UNEVICTABLE. guest_memfd folios lack a backing store and a writepage
callback (noop_dirty_folio). To the MM reclaimer (shrink_folio_list()), the=
se
folios appear clean and unmapped since there are no userspace PTEs.

Under memory pressure, the reclaimer will silently evict them and free their
physical pages to the host buddy allocator. Since eviction does not invoke =
KVM
MMU notifiers, KVM SPTEs remain valid and point to the freed pages. When the
host reallocates these pages, the guest could read or write arbitrary host
memory. Should mapping_set_unevictable() be called explicitly for
non-confidential VMs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-shivank-gm=
em-migrate-v1-0-2d266bfc6f95@amd.com?part=3D2
