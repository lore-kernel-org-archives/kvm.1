Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA54A8FCA
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374199; cv=none; b=lBvuMeVaXpb7stPO8tX78WAaIrvh9nrunAwy1lI4CBOee5T7eVlDKVIuYxQqJTCEMhMiaa7dc56JfkPMntrrPgN/369Wv8gdrrxHxLKKnJM4PtpaIbgthSgbfuWLzAG0ecfHDCr11b79i/J6SrwVYBSziKiJt7RAjLaJAPdh9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374199; c=relaxed/simple;
	bh=V9/6wBJz/7oFdPLrjPO3SGEjP/49kpxiloWlF4gh3Cs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sdUCzFKEiCaytv1jVGeaTHnfnpBHbPo6dcq2UJTAqqGfkDqd5n+pyblr3gECi5AUv9U9Y5S8hqw5pd/23AO+A3aZdRtINjzbgJQnGBiylq09M9N7u/RVm24YyYa08aQHtn1xXid3I7g7wDA1uxXbtmcFi9LTxbSz0q4kBIVLv5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5h+130T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5h+130T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9711F000E9;
	Wed,  2 Sep 2026 18:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788374194;
	bh=PZnhtNh7LgcDTHWwc0sH7651YjynHaHgrXqYoyh8Zsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y5h+130T+6293s//uvjuc3Qrng3USeKOWx2D/uyW0r8xGGe5ZBPbcFnFg3aZcnMU2
	 PUO1S0oKwbNRV1RgVaOsHuZRyKTRIdmdB+TvJacG7CNEKRra0ihkVPM/4w/QR8N6gV
	 EVVcI9/orGTxktmMkO61tYOp136nbNziAbRi3dNnnd3ZtY62MauQYEpnVM8j205Q6Z
	 WEtWn9ZHDNs7fL0LCpI9cRIXJ1uS/DPx41H3LCPtyVZ1doG4hLHCXp0AKmll57VRF5
	 kPnrp1x0ejRp5ylIAN+x3VWUyTmVSUJMS2HM9s35T99qDMcHua5/Kdk2ZxOBRGQgbC
	 2Y+JvMpZhPnlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] KVM: guest_memfd: Drop superfluous WRITE_ONCE()
 when binding a memslot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902182020.2615443-5-seanjc@google.com>
References: <20260902182020.2615443-1-seanjc@google.com>
 <20260902182020.2615443-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 18:36:34 +0000
Message-Id: <20260902183634.9E9711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Modifying the guest_memfd xarray outside of filemap_invalidate=
_lock on the error path causes a Use-After-Free and permanent MMU invalidat=
ion lockup.
--

commit c377e9963148427885842d70319259945c649a8a
Author: Sean Christopherson <seanjc@google.com>

KVM: guest_memfd: Drop superfluous WRITE_ONCE() when binding a memslot

Drop the superfluous WRITE_ONCE() when setting a memslot's guest_memfd file
during initial binding, as the memslot *must* be inactive and unreachable.
The superfluous WRITE_ONCE() was added by commit 67b43038ce14 to
maintain rough "parity" with the existing rcu_assign_pointer().

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 2c8d8735de5fe..323159c9b5f34 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -653,7 +653,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_=
slot *slot,
>  	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
>  	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
>  	 */
> -	WRITE_ONCE(slot->gmem.file, file);
> +	slot->gmem.file =3D file;
>  	slot->gmem.pgoff =3D start;
>  	if (kvm_gmem_supports_mmap(inode))
>  		slot->flags |=3D KVM_MEMSLOT_GMEM_ONLY;

[Severity: High]
This isn't a bug introduced by this patch, but modifying the xarray outside
the filemap_invalidate_lock on the error path further down in this function
appears to cause a use-after-free and a permanent MMU invalidation lockup.

If xa_store_range() encounters -ENOMEM during the store, it can abort and
leave the slot partially inserted in the tree. kvm_gmem_bind() then explici=
tly
drops filemap_invalidate_lock before executing its error path.=20

On the error path, it attempts to clean up by calling xa_store_range() with
NULL outside the lock:

    xar =3D xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
    filemap_invalidate_unlock(inode->i_mapping);

    r =3D xa_is_err(xar) ? xa_err(xar) : 0;
    if (r) {
        xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);

Concurrently, a PUNCH_HOLE operation runs __kvm_gmem_invalidate_start()
which takes filemap_invalidate_lock and iterates over the XArray.

Because the error path doesn't hold the lock, it can race with the iteratio=
n:

CPU1 (kvm_gmem_bind error path)
    if (r) {
        xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
        ...

CPU2 (__kvm_gmem_invalidate_start)
    xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
        ...

xa_for_each_range() does not establish an RCU read-side critical section for
the loop body. The error path removes the partially inserted slot and retur=
ns,
causing kvm_set_memory_region() to immediately kfree() the slot. The
PUNCH_HOLE iteration then dereferences the freed slot, causing a
use-after-free.

Additionally, the PUNCH_HOLE operation successfully called
kvm_mmu_invalidate_start(), but because the slot is removed by the racing
error path before __kvm_gmem_invalidate_end() executes, the closing
xa_find() check fails and kvm_mmu_invalidate_end() is permanently skipped.

Does the error path need to execute with filemap_invalidate_lock() held?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902182020.2615=
443-1-seanjc@google.com?part=3D4
