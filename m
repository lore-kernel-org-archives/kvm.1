Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FD22032D
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779498369; cv=none; b=LC9QzLiBQ7l0s5+HtNSvbstckeEwm4ueVJXH8F4v+8Y3s66yVmPPy+jxoaNZrPFQwL/YeFvvCX2235aLEv0pN+8seU3kgJSRZn5JrRmljFgatCbFgrV70aRZonL0fw9X30vhjZ0PwMII+fBKGIJpd3OdXhAh8UFeRQ/wjatVErA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779498369; c=relaxed/simple;
	bh=GOBn8BDR1rms/oxnWACBhkRZEDXqaF6a4DDx63+nb2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OTwUv0lzXGVDEYLy/Tzo88c/trmbouRQFDzBmUTpxzB8/ym4jW5HGT2AeK0/Fr2VHPCqz4UsD8HPhfu4HEkwx2IsvhrLVNxKUVwdFZf8wc3sgWyunR7sT8Xfv+zGIqotcH6rDijKPvQzG7LTfZRgOn/T6locXjASWxexalQn5Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7dmpEDD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7dmpEDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCABC1F000E9;
	Sat, 23 May 2026 01:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779498368;
	bh=LkMqg/mXFSk1pv3vlJV1nHAVqxbk4rv0yT4X05C6mJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W7dmpEDDUM9yWoJfl11oJa9zPyGAeqKC+86PMVcRyw04ubjhxQs5Mn/EOhFfxyu3W
	 QTq1VXMcPmQ1JlFo+wyAwELOnzV2DGk+Dw5SpPVRH0Omj8iiFDGpXUYWPTeO0TLFgC
	 ghx5oj6XrU08uD205vW9J9VlQDbKKVOsTP6TIpYEPFSG6WvvNaqEr8qDWlSkE0AUPe
	 bs4y6p0v0YwaIxKHVeRr5ifpztTPbSEwx8gbt2PSBd9NhOfWE+4ognqzRTQBgfRQzq
	 jkIOcnNrlMccLElbLpv6yECgRl2zMRdcn248LD1Bjfin1tKLtZaFgzNmEC6Lt447f4
	 KLEbgDqhP3rCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/42] KVM: guest_memfd: Determine invalidation
 filter from memory attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522-gmem-inplace-conversion-v7-16-2f0fae496530@google.com>
References: <20260522-gmem-inplace-conversion-v7-16-2f0fae496530@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 01:06:07 +0000
Message-Id: <20260523010607.CCABC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free of KVM memory slots during guest_memfd invalidation=
 due to missing SRCU read lock.
--

commit 405f31b1513a8790de48221d335a28b8c5c7bf77
Author: Ackerley Tng <ackerleytng@google.com>
KVM: guest_memfd: Determine invalidation filter from memory attributes

This commit updates kvm_gmem_get_invalidate_filter to inspect the memory
attributes maple tree for a given range. This allows KVM to identify if
the range contains private pages, shared pages, or both, and set the filter
bits accordingly.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index a361b3f672516..4570e90f8c042 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -244,7 +256,7 @@ static void kvm_gmem_invalidate_begin(struct inode *i=
node, pgoff_t start,
>  	enum kvm_gfn_range_filter attr_filter;
>  	struct gmem_file *f;
> =20
> -	attr_filter =3D kvm_gmem_get_invalidate_filter(inode);
> +	attr_filter =3D kvm_gmem_get_invalidate_filter(inode, start, end);
> =20
>  	kvm_gmem_for_each_file(f, inode)
>  		__kvm_gmem_invalidate_begin(f, start, end, attr_filter);

[Severity: High]
This is a pre-existing issue, but does __kvm_gmem_invalidate_begin() safely
access the memory slots when iterating over f->bindings?

In __kvm_gmem_invalidate_begin(), the code iterates over f->bindings using
xa_for_each_range(). The retrieved slot pointers are protected by the kvm
srcu, but the read lock doesn't appear to be held during the iteration:

static void __kvm_gmem_invalidate_begin(...)
{
	...
	xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
		pgoff_t pgoff =3D slot->gmem.pgoff;
	...

When a memory slot is deleted, the code calls kvm_gmem_unbind() and
kfree(slot) after synchronize_srcu(&kvm->srcu). If the read lock isn't held,
could a concurrent memslot deletion free the slot while it is still being
accessed in this loop?

This race might occur when __kvm_gmem_invalidate_begin() is invoked without
holding a file descriptor reference, such as from kvm_gmem_error_folio()
after a memory failure. If the file descriptor is closed (refcount is 0),
kvm_gmem_unbind() observes a dead file and skips acquiring the
filemap_invalidate_lock. This allows concurrent xarray modifications,
potentially leading to a use-after-free when dereferencing slot->gmem.pgoff.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inpla=
ce-conversion-v7-0-2f0fae496530@google.com?part=3D16
