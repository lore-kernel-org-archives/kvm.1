Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916272FFDCC
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 03:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937259; cv=none; b=b09baLJljD8yqxD36OJBASs2PwNOIiUpr4BfQ0Bi0Il0slgCBwvxsz6e/sCJmg8gRwzhdUsdx5prE6+VQ+Qqldi6AxH4E0bWOFasP2Nm66j9rMrw4CucbaCrncAcSeJByPyYrySaugfN2OHLgkz9IcVNdS6wunoDdI4Azv3n3Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937259; c=relaxed/simple;
	bh=yx1GtHjHc8M7bUwnbYFm5Z/fR3ykoU5h3SkUmgV2DyA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FTsC0LSdHcZhqmJgr6l/aor148D9cfXJwLAW1Xx4OGm+WevESTd52aXF5Pqj6gP84zvj8HNaI9bqgeLMCpgmYx/6EJEsmHCU0j7oPCqIPmpcdmErbw9sbLSw+IjTSlDhnx3SbmAgx/hYJ3HydbpfKYDYePxP3xZ/Y7ZgQcxH1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HK5hCSg/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HK5hCSg/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F9C1F000E9;
	Thu, 28 May 2026 03:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779937258;
	bh=lhkuD763ZXihyJp12jd10lC4dAFu5L+pP3GQcw7JSfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HK5hCSg/LBvGA42hgRBUP12yM0Y2KDFW0LbfuRzvCbCp5YFcO7ZjMW504Ps0dvs/9
	 ANGy5WRf3N8FBqfJ1A5QW/OLiMnhrf6chM6fuoMxQQydxhBrk8nIdwlMrkV7DKeIdm
	 XIgyICFserMkUp81FSoULFtD6HDXRo1YxjKqYSlFGpGPm+9/m2EOl1AMrvikXh66Oe
	 pZAAnsDvKBB+yptoADtogFkiWT01ALQ/A9Coy5MCudhEbpi4i+5Wr8Ov0gyghgmxzT
	 5jb7pMYYjspWwiF9g3UO2I/gFPjFY5b1fLBiOsLXfgM2wvL9yVWEpyaiYKqqGj1xwN
	 zQdDfnh8zdXqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] KVM: guest_memfd: Treat memslot binding
 offset+size as unsigned values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528021117.107984-2-seanjc@google.com>
References: <20260528021117.107984-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 03:00:57 +0000
Message-Id: <20260528030058.12F9C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The return value of `xa_store_range()` is ignored in `kvm_gmem=
_bind()`, leading to a silent failure to record the memslot binding and cau=
sing a potential Use-After-Free.
--

commit 501192c5cb0ca04a3b338baa0236457046c2b566
Author: Sean Christopherson <seanjc@google.com>

KVM: guest_memfd: Treat memslot binding offset+size as unsigned values

This commit changes the offset and size values when binding a memslot to a
guest_memfd file to be unsigned. This fixes an overflow bug that could
result in a false negative when checking the bounds against the file size.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -664,8 +665,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_=
slot *slot,
> =20
>  	inode =3D file_inode(file);
> =20
> -	if (offset < 0 || !PAGE_ALIGNED(offset) ||
> -	    offset + size > i_size_read(inode))
> +	if (!PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
>  		goto err;
> =20
>  	filemap_invalidate_lock(inode->i_mapping);
[ ... ]
>  	WRITE_ONCE(slot->gmem.file, file);
>  	slot->gmem.pgoff =3D start;
>  	if (kvm_gmem_supports_mmap(inode))
>  		slot->flags |=3D KVM_MEMSLOT_GMEM_ONLY;
> =20
>  	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);

[Severity: Critical]
This isn't a bug introduced by this patch, but does this ignore the return
value of xa_store_range()?

If memory allocation fails internally within xa_store_range(), it returns an
error pointer instead of storing the node. Because the error is ignored,
kvm_gmem_bind() proceeds to return success.

At this point, slot->gmem.file has already been set via WRITE_ONCE(), but t=
he
memslot is missing from the f->bindings array.

If the user later closes the guest_memfd file descriptor, kvm_gmem_release()
runs and iterates over f->bindings to nullify all slot->gmem.file pointers.
Since the failed memslot is not in the array, its pointer is never cleared.

When the VM is subsequently destroyed or the memslot is unbound,
kvm_gmem_unbind() will try to dereference this dangling slot->gmem.file
pointer, potentially triggering a use-after-free on a file that has already
been freed.

Could we check the return value here and handle the error appropriately?

>  	filemap_invalidate_unlock(inode->i_mapping);
> =20
>  	/*
>  	 * Drop the reference to the file, even on success.  The file pins KVM,
>  	 * not the other way 'round.  Active bindings are invalidated if the
>  	 * file is closed before memslots are destroyed.
>  	 */
>  	r =3D 0;
> err:
>  	fput(file);
>  	return r;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528021117.1079=
84-1-seanjc@google.com?part=3D1
