Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6C141D10F
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230428; cv=none; b=PuSD50zgAsbmWq48XnBv/HI/eLLDMYHD22jDFS4wbFbKZr5hd/7hYxua9JqbfVCrSY/ax4ryQlp5uliG49qZ4LEdUW0hYrFoZfisY/8QFy/QlRzyWZ7lA1owgPtYESDHaUkKI/bjfhQ17MjdkkZZda9BUjgD9DYEB+uGjNi/cJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230428; c=relaxed/simple;
	bh=zG5m2ZGom9F8PX0KJJwvZrsmb4JHrFSRpQ5g+xLIlow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pDNs6iYr1JbKPi6z1LM5NUXZtAVvrDdzVQ8HvFRouiVgZk1sEJe8MPe3J9sYkvbjoyWmdrY4GDMNiG4oE6kIdAmN0f5sTk8wa6Mwp6HEq3Nf67Tb/+LtkGRGLlsjeLEGTuVbPI7+GCB8HHgMybWTIxWunVJ0C7Xsaig053Rhv2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVN2dAjp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVN2dAjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225CF1F000E9;
	Tue, 28 Jul 2026 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785230427;
	bh=0pGqHyFDaUDQB/XmorfOlmi+21/tddzBdINKtb5OJB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nVN2dAjpYexoP2ewsWsTT3YWCdTyZSb1YSMhBcMXgtAFc0Shtsb4iU3Tt+cPMiy9m
	 uwkpDiYrryPl+6ohx1MQHBcNqTVHhdtPXS7bNhTaZm54LFS3CoTGaHKwYDrQMZfA5B
	 f7AFCTPuCgODw5iMKeq3Sb8pxMrqewT8Ms2Qv9CtJgpmXNNxFIyvUv794ZgDQIM01l
	 +2i1RBRPHKjJS0gikhp6XoYnM0O1iZSTnDFMw/X1kJA0T9qV3rpukunBHs+AJ/ymK5
	 S3vnfngPCC54himdJ8ioz5H1yV8PK5cS+uiZB69dXIVYiqezLmqtWfKEqK1SUSp8ux
	 Z5CcZnCEICItA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 2/4] KVM: guest_memfd: implement folio migration
 for non-confidential VMs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728-shivank-gmem-migrate-v2-2-269ac1f84e2b@amd.com>
References: <20260728-shivank-gmem-migrate-v2-0-269ac1f84e2b@amd.com>
 <20260728-shivank-gmem-migrate-v2-2-269ac1f84e2b@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 09:20:26 +0000
Message-Id: <20260728092027.225CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing ABBA deadlock between `mapping->invalidate_lock` and =
`folio_lock` via `kvm_gmem_error_folio`.
- [High] Unpaired `kvm_mmu_invalidate_start` due to lockless `f->bindings` =
xarray modification during `kvm_gmem_unbind`.
--

--- Patch [2]: [PATCH RFC v2 2/4] KVM: guest_memfd: implement folio migrati=
on for non-confidential VMs ---
commit cb30b8cd0e73b5e7ad80d0285306810cbf4d963e
Author: Shivank Garg <shivankg@amd.com>
KVM: guest_memfd: implement folio migration for non-confidential VMs

Implement kvm_gmem_migrate_folio using filemap_migrate_folio for
non-confidential VMs but don't enable it yet. Guest_memfd mappings are still
marked unmovable, so MM never calls it.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index d3b1186b03b3a..ec881cabe8e3e 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> +	start =3D src->index;
> +	end =3D start + folio_nr_pages(src);
> +
> +	kvm_gmem_invalidate_start(inode, start, end);
> +
> +	/*
> +	 * For non-confidential guests the folio is host-readable, so
> +	 * filemap_migrate_folio() can copy the contents itself via
> +	 * folio_mc_copy().
> +	 * For confidential guests, this would need firmware assistance.
> +	 */
> +	ret =3D filemap_migrate_folio(mapping, dst, src, mode);
> +
> +	kvm_gmem_invalidate_end(inode, start, end);

[Severity: High]
This is a pre-existing issue, but does the iteration over bindings here race
with kvm_gmem_unbind?

If a guest_memfd file is being closed and its refcount reaches zero
concurrently, kvm_gmem_unbind takes the !file branch and removes the memslot
from f->bindings without taking filemap_invalidate_lock.

Could this lockless modification happen between the calls to
kvm_gmem_invalidate_start and kvm_gmem_invalidate_end?

If f->bindings is modified during this window, __kvm_gmem_invalidate_end
might fail to find the binding and skip the slot, resulting in an unpaired
start call. This would permanently leak the mmu_invalidate_in_progress
counter and cause guest page faults to hang indefinitely.

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
This isn't a bug introduced by this patch, but does kvm_gmem_error_folio
have the exact same ABBA deadlock that you correctly avoided above in
kvm_gmem_migrate_folio?

In kvm_gmem_error_folio, it unconditionally calls
filemap_invalidate_lock_shared while the caller (memory_failure) already
holds the folio lock.

Meanwhile, the opposing truncation path in kvm_gmem_punch_hole establishes
the strict lock ordering of acquiring mapping->invalidate_lock followed by
locking the folio.

Could a concurrent fallocate PUNCH_HOLE and a memory failure on the same
guest_memfd file deadlock the kernel here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-shivank-gm=
em-migrate-v2-0-269ac1f84e2b@amd.com?part=3D2
