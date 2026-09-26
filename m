Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9525315D53
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790385182; cv=none; b=OY99aTbvtn3WPH7xPvP3g4IeYgdFQ88nFuhArblmKAbtqXBQDuKltZCwuSU9pNAJbsKiMpWDNZ+D/zCg8aUhaTyvmKwWQeW8qe+cy9sIz079yYhBVdmaJRpEI0YCpkJGSEWOSc5y9AsQNqHoPT8df23A08RUC92PVclBVoZEoe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790385182; c=relaxed/simple;
	bh=c9bpLgu00gOk9pAxplJ20nmXT9vmwO2r3tDJ58lTkQA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bpnqC8FyKeBfyRg7xYcnM3DeMrniC4utE96M3+v0E0uuCeu8FEORT/GSsE/OhHucS3WO/Ie8vMZJYkpZp8P87n+iXgl2daG7GI16lXHnd6RLshHV6s89v/vFsJapWSM0B1Vb6CbVmlEB0y4qv1s9nmYp4uV43qyxes42fTdv8ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rdx62VyW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rdx62VyW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EA61F000FF;
	Sat, 26 Sep 2026 01:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790385181;
	bh=l6kTkbmNaQvqWoODU1iNaeAtxZ6xS3ueuancD1QBxyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rdx62VyWbTxeO1t45njlnuRCGsns7EOJaK8RxLH73u6rsVGK/yDKy46dreWIOXDwz
	 mgP4Qv4Pmzhb78FBtabUCZv2cXDFjXZEnA5HA6ouHLh8s0HnLFYgpKqT3RPi/WaA95
	 qd7YV5JvKnbBmjZACFL+l/cCZw1Hz2LGuz+p4/7nZnv5ZVlJeMcNEuG54rQgkbACPH
	 k0J3jYApJ19aOJ/senpRaYdaZavgCaRO4r+bqg3KH1wkuLKYPQwaFwO/2Yr1DQe4Iq
	 bQm60ruRI5rX+HL2juuRF87gYJR92gT+Zs3ggz4Jlgokq9FXH+DAd5VVhSZQqerK1P
	 u6lDLrwHiGLBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/17] KVM: guest_memfd: Add helper to attach
 resource provider file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260925-gmem-tmpfs-backend-v1-4-d36159822d18@google.com>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
 <20260925-gmem-tmpfs-backend-v1-4-d36159822d18@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 01:13:00 +0000
Message-Id: <20260926011301.22EA61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] kvm: Missing .release_folio in guest_memfd causes host-to-gues=
t UAF
- [High] kvm: ABI regression due to conditionally enforcing uninitialized r=
esource_fd
--

commit dd40066faee48c23e279dbcc865f3d9effd7f680
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Add helper to attach resource provider file

This commit adds a helper to attach a resource provider file to a guest_mem=
fd
inode. It takes a refcount on the resource_fd to maintain the reference for
guest_memfd and introduces a release callback on inode destruction to allow
provider cleanup.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 00f3bd0cf21e6..0e0d7e93f4148 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c

[ ... ]

> @@ -1057,7 +1099,10 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_cr=
eate_guest_memfd *args)
>  	if (size <=3D 0 || !PAGE_ALIGNED(size))
>  		return -EINVAL;
> =20
> -	return __kvm_gmem_create(kvm, size, flags);
> +	if (!(flags & GUEST_MEMFD_FLAG_USE_RESOURCE) && args->resource_fd)
> +		return -EINVAL;

[Severity: High]
Does this introduce a backwards-compatibility issue with the ABI?

Older userspace applications compiled against older kernel headers might ca=
ll
KVM_CREATE_GUEST_MEMFD with an uninitialized stack structure. Previously,
KVM did not check the reserved fields, so stack garbage was ignored.

By enforcing args->resource_fd to be 0 when GUEST_MEMFD_FLAG_USE_RESOURCE is
not set, won't this cause unexpected -EINVAL failures for old applications
passing uninitialized stack garbage?

Also, this patch does not validate the remaining pad and reserved[5] fields,
which could lead to this exact problem repeating when those fields are
repurposed in the future.

> +
> +	return __kvm_gmem_create(kvm, size, flags, args->resource_fd);
>  }

[ ... ]

> @@ -1401,6 +1446,8 @@ static void kvm_gmem_destroy_inode(struct inode *in=
ode)
>  {
>  	struct gmem_inode *gi =3D GMEM_I(inode);
> =20
> +	gmem_provider_release(gi);
> +

[Severity: Critical]
Is there a missing .release_folio callback in kvm_gmem_aops?

An earlier patch in this series set
mapping_set_release_always(inode->i_mapping) in kvm_gmem_init_inode(), but
kvm_gmem_aops does not implement the .release_folio callback:

static const struct address_space_operations kvm_gmem_aops =3D {
	.dirty_folio =3D noop_dirty_folio,
	.migrate_folio	=3D kvm_gmem_migrate_folio,
	.error_remove_folio =3D kvm_gmem_error_folio,
	.invalidate_folio =3D kvm_gmem_invalidate_folio,
#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
	.free_folio =3D kvm_gmem_free_folio,
#endif
};

If userspace calls fadvise(POSIX_FADV_DONTNEED) on the guest_memfd file
(or if root triggers drop_caches), this will trigger mapping_evict_folio()
which then calls filemap_release_folio().

Without .release_folio, VFS falls back to try_to_free_buffers(). This
successfully evicts the folio and frees the physical page, but completely
bypasses KVM SPTE invalidation. Can this lead to a host-to-guest
use-after-free, where a guest retains read/write access to host physical
pages after they are freed and reallocated to other processes?

>  	mpol_free_shared_policy(&gi->policy);
> =20
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-gmem-tmpfs=
-backend-v1-0-d36159822d18@google.com?part=3D4
