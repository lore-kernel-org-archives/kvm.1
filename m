Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240384A8FC3
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373936; cv=none; b=o//CmKUafZr4lu8TYijoa0iac1oWdk5CHrppocjQhwARRREXzEnnlEmJLUpnYoMwrpXKecSkTyv4+kf1T253hXINWSJtAfqyUwaZhnnNlWSwkp4tc0XoXXrXsHMBS3u9b5qrX3Id+lTMS4cddR+G6cpivoXBjE6dC8HgygX2QfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373936; c=relaxed/simple;
	bh=N4PBoD89J4mIqIedlz8JtYEKMTzRVUv+zaYYw/DIiRw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oofHhOeFG6ZzegdocKuSehr7cegvwgx1Zi+xKG2zQLq0zxLZmLkICT9Efiv1WsLk48dkkebrHxsZ/R44l8JwOQI4zLq3Yt36CmgNM7okbqCWm+F9w/ZqP3d0HPjI+szDHV4CZfUafZ/aytltQs9BDwjTJv9hf0IHaBUdYmvxAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNkOYmfT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNkOYmfT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D889F1F000E9;
	Wed,  2 Sep 2026 18:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788373931;
	bh=/TfQmScVU3NN0mzkyHGTYSjcSLMusrva4ld0AKhwvNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aNkOYmfT7a6g7MkMcIdJEMoiko4ABp+NAf+RwAQJhp/boc8ClWm5dwqHQYjs/CRI+
	 ea2WPCPENcZ65Rz8Ipd0SlwT7k18lLvoacwSIsOZQgfekVb/f8qYtsAAcXbRk9E3iL
	 Nz0as/kfxqR7fK8iRTGRhn8CnT7lkW8gj1SvrFAlkgGSeMi9ZzHEz7IEeD3M29mQ+K
	 BrCgETR+Yd/8VrddZwXeFpB9veGBdtW78aJLsqHdiR90hNWpqZkStvxhiR3n6fU5Gn
	 2MEnB6M5ZiEMLcY2PiLfRXvs+uLNxyDdlK4Xc31giz6QcSMJdDPsdg64ux0JYnAxkT
	 fbrLcHx7ADzEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] KVM: guest_memfd: Gracefully handle xarray
 errors when binding a memslot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902182020.2615443-2-seanjc@google.com>
References: <20260902182020.2615443-1-seanjc@google.com>
 <20260902182020.2615443-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 18:32:10 +0000
Message-Id: <20260902183210.D889F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-after-free and race condition in error path of kvm_gmem_bind()
--

commit 750801b0d7bf80e6bf0cad3be58657ec4af30b90
Author: Sean Christopherson <seanjc@google.com>

KVM: guest_memfd: Gracefully handle xarray errors when binding a memslot

This commit propagates errors from inserting a memslot into a guest_memfd's
bindings xarray back to the caller to prevent a use-after-free when the file
is released. It also opportunistically rejects bindings if
KVM_MEMSLOT_GMEM_ONLY is already set.

Link: https://lore.kernel.org/all/20260823135031.4F6DC1F000E9%40smtp.kernel=
.org

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b596486d184ca..2c8d8735de5fe 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -654,7 +658,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_=
slot *slot,
>  	if (kvm_gmem_supports_mmap(inode))
>  		slot->flags |=3D KVM_MEMSLOT_GMEM_ONLY;
> =20
> -	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
> +	xar =3D xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
>  	filemap_invalidate_unlock(inode->i_mapping);
> =20
>  	/*
> @@ -662,7 +666,13 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory=
_slot *slot,
>  	 * not the other way 'round.  Active bindings are invalidated if the
>  	 * file is closed before memslots are destroyed.
>  	 */
> -	r =3D 0;
> +	r =3D xa_is_err(xar) ? xa_err(xar) : 0;
> +	if (r) {
> +		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);

[Severity: High]
Does this error path modify the bindings XArray without holding the
filemap_invalidate_lock?

If the initial xa_store_range() fails (for example, returning -ENOMEM),
filemap_invalidate_unlock() has already been called just above.

Concurrently, if a thread calls fallocate(PUNCH_HOLE) on the guest_memfd,
it could acquire filemap_invalidate_lock, iterate the XArray, and observe
the partially inserted slot.

While fallocate() is passing the slot to kvm_mmu_unmap_gfn_range(), this
error path clears the binding locklessly and returns the error to
userspace (e.g. from KVM_SET_USER_MEMORY_REGION). This causes the slot to
be freed immediately by kvm_set_memory_region(). Can this result in a
use-after-free since fallocate() is concurrently dereferencing it?

> +		slot->gmem.file =3D NULL;
> +		slot->gmem.pgoff =3D 0;
> +		slot->flags &=3D ~KVM_MEMSLOT_GMEM_ONLY;
> +	}
>  err:
>  	fput(file);
>  	return r;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902182020.2615=
443-1-seanjc@google.com?part=3D1
