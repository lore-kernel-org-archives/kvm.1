Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA221D5CC9
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374146; cv=none; b=cjWi5fS43OCNaSGhlCy5x61GJ/F5xz6HBPp3k1U1toFOfuHYBo8sngKJe5aert0xCVe9Lw0J3HqyDk0BtG2Xe212zCLNgQPQS3IT7laAroOA1tMPSAz5QElsAKZ4DiBz9ik6uB+ajvWjloFeiiQ/t4u1OiIgN4sD9U0IujivJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374146; c=relaxed/simple;
	bh=21YXXl4g7xkXrtVH+pmicGwcqTDCqjJIKk5ILvWQBBg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RxrY3ierznCdLrqVJO2qysVgZCkTzWv9lnUI9jrnWXSDlHgPRHi72qNifteoA9k/VCP4GamL2YfbdmCr02h61RwsThKteK/2kSbVRlRB67CGeeRNGuz92uQuOU3AT512O/yq+WSKB87IvY9zhONDx5O1R0q47ataXjyleEqfpxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlXER7ks; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlXER7ks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA071F000E9;
	Wed,  2 Sep 2026 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788374139;
	bh=fh0lQNS2UqC/WrDJijSllWjqxWybDilOoek1oYftMdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TlXER7ksIBa0vlurRZzjBZODOq/MRSFl8WQgnFUV/2hwUThjXro1YUj2ZkrAetub3
	 btIsPNX3lqSS9xfkFf3uOhoTa2K/UOIk+jfF7JdJL0odwtGzoqzYp8bDkFYQm/5ack
	 0fW5A2imeubMjtdrkSguT2t+RKgbsjyHtlsJdaH0G8pwAbHfIIn5Kk4PZs+AjDfuKt
	 jQ9SZ07Fi1P2vZ67jnrOYb0M4GnODqq1yOovcstGHOdNaI29MKju71+Z5r/d9YQ1a3
	 cAJDALXldwd9WicRdBHUkmTlSmdFv4oEipqZQWm7erbt4P9Np4McOz9qjx3Tv1IjPh
	 /C7l+mIqNp4Ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] KVM: guest_memfd: Establish
 memslot<=>guest_memfd bindings *after* memslot is ready
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902182020.2615443-4-seanjc@google.com>
References: <20260902182020.2615443-1-seanjc@google.com>
 <20260902182020.2615443-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 18:35:38 +0000
Message-Id: <20260902183538.EFA071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] kvm_gmem_bind drops filemap_invalidate_lock before rolling bac=
k a failed xa_store_range, exposing a partially bound, not-yet-active memsl=
ot to concurrent PUNCH_HOLE operations and leading to a severe Use-After-Fr=
ee on the error path.
--

commit cf9b1c6186b61c3381316f5121f13c09601e0b01
Author: Sean Christopherson <seanjc@google.com>
KVM: guest_memfd: Establish memslot<=3D>guest_memfd bindings *after* memslo=
t is ready

This commit defers binding a memslot to a guest_memfd instance until the me=
mslot
is fully prepared. It prevents exposing the memslot to readers prematurely,
which could break various memslot assumptions and rules.

Closes: https://lore.kernel.org/all/20260826170551.BEF801F000E9@smtp.kernel=
.org

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 3c0dbe60a5b4f..21c10cbbac661 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -1934,6 +1935,15 @@ static int kvm_set_memslot(struct kvm *kvm,
>  	if (r)
>  		goto err;
> =20
> +	if (new && new->flags & KVM_MEM_GUEST_MEMFD) {
> +		if (WARN_ON_ONCE(change !=3D KVM_MR_CREATE))
> +			goto err_bind;
> +
> +		r =3D kvm_gmem_bind(kvm, new, gmem_fd, gmem_offset);
> +		if (r)
> +			goto err_bind;
> +	}
> +
>  	/*
>  	 * For DELETE and MOVE, the working slot is now active as the INVALID
[ ... ]
> @@ -1965,6 +1975,13 @@ static int kvm_set_memslot(struct kvm *kvm,
> =20
>  	return 0;
> =20
> +err_bind:
> +	if (new) {
> +		kvm_arch_free_memslot(kvm, new);
> +
> +		if (new->dirty_bitmap && (!old || !old->dirty_bitmap))
> +			kvm_destroy_dirty_bitmap(new);
> +	}

[Severity: Critical]
This is a pre-existing issue, but does moving kvm_gmem_bind() into this
sequence create an exploitable use-after-free on the error path?

Looking at kvm_gmem_bind(), if xa_store_range() fails, the lock is released
before rolling back the partial entry:

virt/kvm/guest_memfd.c:kvm_gmem_bind() {
    ...
	xar =3D xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
	filemap_invalidate_unlock(inode->i_mapping);

	r =3D xa_is_err(xar) ? xa_err(xar) : 0;
	if (r) {
		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
    ...
}

If a concurrent PUNCH_HOLE operation acquires the lock right after
filemap_invalidate_unlock(), could it extract the partially bound slot and
proceed to kvm_mmu_unmap_gfn_range()?

If so, while the concurrent thread is accessing the slot, this error path
executes kvm_arch_free_memslot(), and then the caller, kvm_set_memory_regio=
n(),
executes kfree(). Could this result in the PUNCH_HOLE thread operating on
completely freed memory?

>  err:
>  	/*
>  	 * For DELETE/MOVE, revert the above INVALID change.  No modifications

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902182020.2615=
443-1-seanjc@google.com?part=3D3
