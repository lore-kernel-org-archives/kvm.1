Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C9A41A540
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230896; cv=none; b=oaQcl+iLluP6QtNvnWaHNdbuk9PQgJ/ThwgFqwa+4TOcPpQK9sQvn/+NU4cqnGGiXGfRJ/LpzcUPEIiIw1i7Juoydu/FNmV7lI9UHIqx+nyAImg40LDYWKCY75v/2c1C3mlKbci0T17aewq8yNO0m4Wc1gn2Ch9ZFYma3X9Q6CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230896; c=relaxed/simple;
	bh=3cHCsmkDriw4q35Ms8S0Q7FoqP0LXycZ+lYHYQ7IEOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AvjRps3AsWkccgw/EgOoOKShaSYCbavgZDd1OP+6pkqj0ybNzLrKd2nolJ2ewklj/rruGG+szbbhOn2XKp55oFH4smKuzgnZigkXYw31xqZCACNbk50+S1pZc7/0McNq0pwdjy8Fb8O/REseTSp6cBpgRaLB7JQ54iSvcdWcmZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojzGZwdz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojzGZwdz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372C11F00A3A;
	Tue, 28 Jul 2026 09:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785230894;
	bh=UCO00/7MmyiBCOgvM/GD0aHXMFIWaZDfSIGKbVKr4Xc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ojzGZwdzIrNHPihUIwiqBTZLIB6+oqRKIc8h+sDb/T/nNzohwvicLHPdhbV7uGgV8
	 UUm7/z+iSGM+k8wm+q4fZTE/fLapuCV+G1grpDm+YQsuU6ek1v5wuVgRRsIR/gOoO/
	 kIQcFIrpKWXNcLPV8szYhOrucceu3GOQ4V9loS/4JNHOGRxp0TVG0oa1M9PBUFvUYY
	 aOtxxRRK0GjG5/00Wi4J1GvPFzb79vkeWjUYjiVmfuxJZv0c6QXKTVQdo20znUpJp3
	 iPnUnoaHDl87pqx6OOpI2HGlmHatQubCQymZZa34kd6ABUhrmHX7ozLOjs6Zg/zKHa
	 xV9d8Voq+6keg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 3/4] KVM: guest_memfd: add
 GUEST_MEMFD_FLAG_MIGRATABLE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728-shivank-gmem-migrate-v2-3-269ac1f84e2b@amd.com>
References: <20260728-shivank-gmem-migrate-v2-0-269ac1f84e2b@amd.com>
 <20260728-shivank-gmem-migrate-v2-3-269ac1f84e2b@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 09:28:13 +0000
Message-Id: <20260728092814.372C11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Accessing memslots in `__kvm_gmem_invalidate_start` without ho=
lding `kvm->srcu` allows a use-after-free if the memslot is concurrently de=
leted while the guest_memfd is being closed.
- [High] Concurrent execution of `kvm_gmem_unbind` on a dying file and `kvm=
_gmem_migrate_folio` causes asymmetric `kvm_mmu_invalidate_begin`/`end` pai=
ring, permanently hanging the VM in page faults.
--

--- Patch [3]: [PATCH RFC v2 3/4] KVM: guest_memfd: add GUEST_MEMFD_FLAG_MI=
GRATABLE ---
commit 5a71d0799db0fa4a13e00aa0d626b30f60552d46
Author: Shivank Garg <shivankg@amd.com>

KVM: guest_memfd: add GUEST_MEMFD_FLAG_MIGRATABLE

This commit introduces GUEST_MEMFD_FLAG_MIGRATABLE and
kvm_arch_supports_gmem_migration() to control migration support. It allocat=
es
opted-in guest_memfds with GFP_HIGHUSER_MOVABLE, allowing folios to be
migrated by the memory manager in non-confidential VMs.

[ ... ]

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index ec881cabe8e3e..8ae455a6b38df 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c

[ ... ]

> @@ -623,11 +628,16 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_=
t size, u64 flags)
>  	inode->i_mapping->a_ops =3D &kvm_gmem_aops;
>  	inode->i_mode |=3D S_IFREG;
>  	inode->i_size =3D size;
> -	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>  	mapping_set_inaccessible(inode->i_mapping);
> -	mapping_set_unmovable(inode->i_mapping);
> -	/* Unmovable mappings are supposed to be marked unevictable as well. */
> -	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> +	/* guest_memfd mappings should be marked unevictable. */
> +	mapping_set_unevictable(inode->i_mapping);
> +
> +	if (flags & GUEST_MEMFD_FLAG_MIGRATABLE) {

[Severity: Critical]
This isn't a bug introduced by this patch, but enabling migration here
exposes a pre-existing use-after-free risk in __kvm_gmem_invalidate_start().

If an unprivileged user creates a migratable guest_memfd and binds it, then
concurrently closes the file descriptor and deletes the KVM memslot, memory
compaction can invoke kvm_gmem_migrate_folio() which calls
__kvm_gmem_invalidate_start().

Because kvm_gmem_unbind() bypasses filemap_invalidate_lock when the file
is dying, it does not wait for migration. __kvm_gmem_invalidate_start() then
dereferences the memslot without holding kvm->srcu:

virt/kvm/guest_memfd.c:__kvm_gmem_invalidate_start() {
    xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
        pgoff_t pgoff =3D slot->gmem.pgoff;
        struct kvm_gfn_range gfn_range =3D {
            .start =3D slot->base_gfn + max(pgoff, start) - pgoff,
        ...
}

Is there a risk that the memslot deletion path completes synchronize_srcu()
and calls kfree(slot) while __kvm_gmem_invalidate_start() is still accessing
it?


[Severity: High]
This is also a pre-existing issue, but exposing the migratable flag makes it
reachable. Could this lead to asymmetric kvm_mmu_invalidate_begin/end pairi=
ng
and a permanent VM hang?

When kvm_gmem_unbind() executes concurrently with kvm_gmem_migrate_folio()
on a dying file, it bypasses the lock and removes the binding from the
xarray between migration's invalidate_start and invalidate_end:

virt/kvm/guest_memfd.c:kvm_gmem_unbind() {
    if (!file) {
        __kvm_gmem_unbind(slot, slot->gmem.file->private_data);
        return;
    }
}

When the migration finishes, __kvm_gmem_invalidate_end() conditionally
checks xa_find():

virt/kvm/guest_memfd.c:__kvm_gmem_invalidate_end() {
    if (xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
        KVM_MMU_LOCK(kvm);
        kvm_mmu_invalidate_end(kvm);
        KVM_MMU_UNLOCK(kvm);
    }
}

Since the binding disappeared, doesn't this skip the _end notification,
permanently leaking KVM's mmu_invalidate_in_progress counter and causing
subsequent page faults to infinitely loop in mmu_invalidate_retry_gfn()?

> +		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER_MOVABLE);
> +	} else {
> +		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
> +		mapping_set_unmovable(inode->i_mapping);
> +	}
> =20
>  	GMEM_I(inode)->flags =3D flags;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-shivank-gm=
em-migrate-v2-0-269ac1f84e2b@amd.com?part=3D3
