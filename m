Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D03438AB
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779488519; cv=none; b=k+80zZOuGCOaQqKNvyBcn1vJAM9dimRDuvwcS0G8oTU/v3KuIl8p0R5wYOkeApb1wvKkJJ3qePuD/QpF0xZl1KAOmqnEymNrDZavTKiQ9r25AUNmnD51l7OpdSTSx9Mn6065Vu+tWW1xaO+D3oWjAgFsCanX6gyCoV9WDPa0/3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779488519; c=relaxed/simple;
	bh=HY6HkAxdL8O1pP21J7iwWYB8GsIVtu1fEo7LCr9knRk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VAXSO5WpoP0pthSXyDphyEBWdStxiqmJo+m+7noCpBzqDC1/3JnOt05outANFD+Omo1UFGOKIw6imjzN9w3WRqQ9pvN5qJsPt+3a102w3IzRH+Z7FYPP4CqauGsMT+kiASwDiAHKVIGJSmnXvNB3FfmhUg5dbiJLTQB8BkFAd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoaTf8Qg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoaTf8Qg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4521F000E9;
	Fri, 22 May 2026 22:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779488517;
	bh=vdXf8KRuXLwPzF77zSfyC40Y/OlUh0xo71iC+lu0IcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QoaTf8Qg5hClhgVvDIJpMLrliHnw35bE2YjYE0/rS+T5pAKo9ftX1C8/Wu3z421FJ
	 0Iy/mlde06Q5fKcMQX7l6xY8v9k8YNoYwTZhzogJOs1zUbDMRRxjGzg/C0iPuXtgg7
	 AlSm/6E9Nym/FPKzSjmXRqVBhUg4+F+oZiBRGeUuI9Bf0FbgUxMFQDCxD/qavXWlmy
	 nJRucnv/YmuFGEfhOh9MyY+CqLYF3g6QcP2Y5FyTk5oMprpZvRnxyHgLR5N0KGuMA9
	 55ExwMf1ZODh94iS7pjFYqey5g1WtM7mbO+0GGJvjUgb7+7bB89h8p5qwjIMShU813
	 HSeNwnFiaY8dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] KVM: guest_memfd: Handle errors from
 xa_store_range() when binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522-fix-sev-gmem-post-populate-v1-3-9fc8d6437b65@google.com>
References: <20260522-fix-sev-gmem-post-populate-v1-3-9fc8d6437b65@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:21:56 +0000
Message-Id: <20260522222156.EE4521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Propagating `xa_store_range()` failure causes a Use-After-Free=
 due to a missing rollback of partially stored XArray entries.
--

commit cacb3f43fb3479e4984fbb068881df5efe05c882
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Handle errors from xa_store_range() when binding

This commit updates kvm_gmem_bind() to check the return value of
xa_store_range() and propagate any resulting errors back to userspace,
rather than falsely reporting success.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index d203135969d13..104f0f3d6a0b3 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -688,7 +689,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_=
slot *slot,
>  	if (kvm_gmem_supports_mmap(inode))
>  		slot->flags |=3D KVM_MEMSLOT_GMEM_ONLY;
> =20
> -	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
> +	result =3D xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNE=
L);
>  	filemap_invalidate_unlock(inode->i_mapping);
> =20
>  	/*
> @@ -696,7 +697,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_=
slot *slot,
>  	 * not the other way 'round.  Active bindings are invalidated if the
>  	 * file is closed before memslots are destroyed.
>  	 */
> -	r =3D 0;
> +	r =3D xa_is_err(result) ? xa_err(result) : 0;

[Severity: Critical]
If xa_store_range() fails midway through storing a large range (for example,
returning -ENOMEM), does it leave the already-processed entries in the
f->bindings XArray?

When this error is propagated back, the caller __kvm_set_memory_region()
will abort the operation and free the memslot without calling
kvm_gmem_unbind().

Since the partial XArray updates aren't rolled back here, could this leave
dangling pointers to the freed memslot in f->bindings? If so, when the file
is eventually closed, kvm_gmem_release() might iterate over these dangling
pointers and write to slot->gmem.file, resulting in a use-after-free.

>  err:
>  	fput(file);
>  	return r;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-fix-sev-gm=
em-post-populate-v1-0-9fc8d6437b65@google.com?part=3D3
