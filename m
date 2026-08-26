Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3075A312807
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763923; cv=none; b=W4t8ucx7GWhNq7hexO41DxJAR/eC3WSk6hlsB2r8Jkp5x6UZCm7ufXNkZVbTKo5Qh1bA5BdeTAuOSaJZEicM+COlih/mw62Rt34nDALp70TRfHK2n4pttpGRUf6DQXk8ya+fNH0OZtV8XLrHa+Oivj1j/qqczv5buYm/NxFdPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763923; c=relaxed/simple;
	bh=0P/bHukgXc50ijfA/726V9i5lmC/J+7H7yujeQQUgyc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T+Wv61eEpq1JGSCntiMT9EwmXJqD3a/Z7K4FBZryXnoMBglWWK3Jfq2zRdZnTB1V4lXuOBrNrxUlgJiQ88f+AeZVCTpKAsqyibQMh6I8olA666ixx18m1ytOvOd1CUZqsRHibIA5dRPn4OeZHtI39cKyqCN2ygwFuP+mQfuNua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JongI0s+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JongI0s+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012231F000E9;
	Wed, 26 Aug 2026 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787763906;
	bh=xHcJfHfyWPtqr2lgJPCS4E0UlADTlFGCE5Xs1CCufJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JongI0s+JtLD3AQ39fkOyD+cb//IZyho+NBaYn/uXLojvqkWaa25v1Vqf9A/6J0dT
	 0Vecv1tpP7YUPJ5RyYUAjA/wpvIFXaczYqckbByqTW6qRRw9ZziivRxmKew3e2KZ16
	 02RTXdtpl7vSnjqbtndwUZ4WGow4LM36eYTadera5wz2TPKdmWoRDdDcFoqWGvMwWQ
	 iiprLAgbB418btXnOUwGgHrWyxw2+WqncTBAKzh0zVsu7thfYWNAcsZKZFkEV5XQJZ
	 7rB+bGZWq+B3KnH+71JFN3t9dgHBbdMwbHpzY9YJjQVDNkkZAemzJAJ78mNv+LYtnT
	 5Mzg2dALFNhBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: guest_memfd: Gracefully handle xarray errors
 when binding a memslot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826165154.766699-2-seanjc@google.com>
References: <20260826165154.766699-1-seanjc@google.com>
 <20260826165154.766699-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 17:05:05 +0000
Message-Id: <20260826170506.012231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Partial failure of xa_store_range() leaves dangling pointers to a =
freed memslot in the guest_memfd bindings xarray, leading to a Use-After-Fr=
ee when the file is released.
--

commit 31a2b2a91bb8b7043e1a087271db5def7eb591b8
Author: Sean Christopherson <seanjc@google.com>

KVM: guest_memfd: Gracefully handle xarray errors when binding a memslot

This commit updates kvm_gmem_bind() to handle errors returned by
xa_store_range(). If inserting a memslot into a guest_memfd bindings xarray
fails, the error is propagated to the caller to abort memslot creation.

Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/20260823135031.4F6DC1F000E9%40smtp.kern=
el.org

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
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
> @@ -662,7 +666,12 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory=
_slot *slot,
>  	 * not the other way 'round.  Active bindings are invalidated if the
>  	 * file is closed before memslots are destroyed.
>  	 */
> -	r =3D 0;
> +	r =3D xa_is_err(xar) ? xa_err(xar) : 0;
> +	if (r) {
> +		slot->gmem.file =3D NULL;
> +		slot->gmem.pgoff =3D 0;
> +		slot->flags &=3D ~KVM_MEMSLOT_GMEM_ONLY;
> +	}

[Severity: High]
If xa_store_range() encounters an error halfway through the range (for
example, -ENOMEM), can it partially succeed and leave some entries pointing
to the memslot in the f->bindings xarray?

If this happens, the error is propagated back to kvm_set_memory_region(),
which then aborts the operation and frees the memslot structure. Does this
leave dangling pointers in the f->bindings xarray?

Later, when the guest_memfd file is closed, kvm_gmem_release() iterates
over the xarray:

virt/kvm/guest_memfd.c:kvm_gmem_release() {
    ...
    xa_for_each(&f->bindings, index, slot)
        WRITE_ONCE(slot->gmem.file, NULL);
    ...
}

Could this trigger a use-after-free when kvm_gmem_release() writes NULL to
the already freed memslot? Should any partially inserted xarray elements be
erased from f->bindings before propagating the error?

>  err:
>  	fput(file);
>  	return r;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826165154.7666=
99-1-seanjc@google.com?part=3D1
