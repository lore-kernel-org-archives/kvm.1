Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6942347FCD
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764317; cv=none; b=utZF+/ghKSKuKPaj/d7mVL2qMf6M5F57oTU8x8EcCFd9eGc+eMy/9+n8gJHzb91O0NkCgAWYcGXpA3D/J8P4MCHTqkVbp5LxjGYt/V7tAkz84VYKKzJXBNaRmHP3A6XjikKui1sTpHDc7eROrU5OH/ia3k9rEiedWTXuvlyb+nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764317; c=relaxed/simple;
	bh=jdEnz3zzOUmmvye/Q1i2qI5er294xxvN7TitmIFPu2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MeZWDOeq0XlW2Ym3I3lorwrb2mw6hXWT9iFDO2JwfJNnWEe8mQS+5L6xoAGDYcrtmaeS2yU/RJjvswxMVUDiFI2X0AW/qndlgCopYXDjsGXhCqr0MGxjvnKGFIufaI5O+elif48+PCIplI9akHzFVgXNgZi9BIQA9b982AH1UVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCApEwZY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCApEwZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959AC1F000E9;
	Wed, 26 Aug 2026 17:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787764311;
	bh=PyBoCBkiRYt9crCkRF55sbVWqcHDPdSFh3+GJ7f3gp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UCApEwZYWxm88S8VNA0Ou3ArdNPkvtmSdg4qhzOXsNBLE0gfNzRo7etbeZHK9CKlA
	 fZIWggwUf7ar/33pFxK5ZtgPwP9HKAtdg3EKwAb6lViD7csOyCHJ9C3pbw537TU42+
	 tTRB4C0DgDRflsVNZwvJ79dTarifSjRmt/ehHxDsIwkLiCXWU4PY8fVnPTgcAsrsv8
	 ih4d5GFqIKoFo3a5K/pyh26V1MWFwgrQPRjdqL8BqKIMFvwab2QrifvrGc52T86Xlp
	 NPnHTqCLWPK+9KENPsvGBNi9LDM3zE1EtjWiWXQgDbg9E3X1Hpu2rWu+f/xS1yetpg
	 JF0Nzu43LT1IQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826165647.769231-1-seanjc@google.com>
References: <20260826165647.769231-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 17:11:51 +0000
Message-Id: <20260826171151.959AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Bypassing filemap_invalidate_lock in kvm_gmem_unbind when the =
file is dying allows concurrent xarray modifications, causing Use-After-Fre=
e and leaked mmu_invalidate_in_progress.
--

commit 22b749f62017c828a40c33364eefe3474406907f
Author: Sean Christopherson <seanjc@google.com>

KVM: guest_memfd: Elaborate on how release() vs. get_pfn() is safe against =
UAF

This commit updates the comment in kvm_gmem_release() to elaborate on the
synchronization between release() and get_pfn(). It explains why neither
RCU nor kvm->srcu synchronization is necessary when nullifying memslot
bindings, detailing the barriers used to prevent a use-after-free.

Link: https://lore.kernel.org/all/CAEvNRgGmyd1yqQXsnz5hWRZpBZUs%3DpiEWbEaqP=
9%2Bcz9ZqEMQ6g@mail.gmail.com [*]

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b596486d184ca..7f1c6a0f8039d 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -300,17 +300,55 @@ static int kvm_gmem_release(struct inode *inode, st=
ruct file *file)
>  	 * dereferencing the slot for existing bindings needs to be protected
>  	 * against memslot updates, specifically so that unbind doesn't race
>  	 * and free the memslot (kvm_gmem_get_file() will return NULL).
>  	 */
>  	mutex_lock(&kvm->slots_lock);
> =20
>  	filemap_invalidate_lock(inode->i_mapping);
> =20
> +	/*
> +	 * Note!  synchronize_srcu() is _not_ needed after nullifying memslot
[ ... ]
> +	 * Obviously KVM would be broken in many places if the synchronization
> +	 * were omitted, but it's important to note that get_file_active() does
> +	 * NOT guarantee a reference to the correct file was obtained, only
> +	 * that the file doesn't point at a reallocated object.
> +	 */
>  	xa_for_each(&f->bindings, index, slot)
>  		WRITE_ONCE(slot->gmem.file, NULL);
> =20

[Severity: Critical]
This is a pre-existing issue, but could bypassing filemap_invalidate_lock in
kvm_gmem_unbind() when the file is dying allow concurrent xarray modificati=
ons
that result in a use-after-free?

In kvm_gmem_unbind(), when the file is dying:

	if (!file) {
		__kvm_gmem_unbind(slot, slot->gmem.file->private_data);
		return;
	}

Because kvm_gmem_error_folio() handles memory failure on guest_memfd pages =
by
holding filemap_invalidate_lock_shared(mapping) and iterates f->bindings
without holding kvm->srcu or kvm->slots_lock, it relies entirely on
filemap_invalidate_lock.

If kvm_gmem_unbind() bypasses filemap_invalidate_lock when the underlying
file is dying, it can run concurrently with kvm_gmem_error_folio() and
remove a slot from f->bindings. This allows kvm_set_memory_region() to free
the memslot while kvm_gmem_error_folio() is still holding a pointer to it.

Could this cause a use-after-free during the iteration:

virt/kvm/guest_memfd.c:__kvm_gmem_invalidate_start() {
	xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
		pgoff_t pgoff =3D slot->gmem.pgoff;
		...
}

Additionally, if the slot is removed before __kvm_gmem_invalidate_end(),
xa_find() returns false, which skips kvm_mmu_invalidate_end() and
permanently leaks mmu_invalidate_in_progress:

virt/kvm/guest_memfd.c:__kvm_gmem_invalidate_end() {
	if (xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
		KVM_MMU_LOCK(kvm);
		kvm_mmu_invalidate_end(kvm);
		KVM_MMU_UNLOCK(kvm);
	}
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826165647.7692=
31-1-seanjc@google.com?part=3D1
