Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237C3DAADE
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913750; cv=none; b=EhoNyFpNaJfO2jMv9Bin4xELZGiIGoX7Bxk7pSiQRfpubusKa6HAsKe24cqUaouSBWbTt/dmSAnxtknDzlmtyKLZDI9Px5nWCPFo9RjHA3jMMxAHWIqrMH+R+MWQhzPtvZVFOwzq6eaxeZVNfVq95OXPUpaNjS/1CoYKKWkdNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913750; c=relaxed/simple;
	bh=jkwV9vSISx8O5ed4uwBzgwGyRYEISyfEMkVJ9dPA5PU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YCFgaEBYbKVtWaefUYttr0tnjhQNUPQTOE3V9djSbdgLA9LewszAGJXj3H9F5sWK6fy62n4CjWI9G9/wjbvCvuJZvexv3PvQtGZKzBFfFu3NABhh6NK1x93IGvPNECkuN+Pj2iUn8isfVIRUPoSl7+1S7UJaNeL026TWpuGfAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAnhL+RL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAnhL+RL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6351F000E9;
	Wed,  5 Aug 2026 07:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785913748;
	bh=duos10TZThguuAPELw1BglZX13jefJlzsFEk2q0W9kE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TAnhL+RLOUtbCPmCLym7Sf1SlVOkqXX+axez8zQgX2+NHw74Z85v29gTIzwAD/87u
	 B77r5mVeh2ZLBLxj/fKiPr5hDtGpE6/s7Q/Xj/VLS5IAIsEXwnYxyaRlhFmhjrBGy8
	 uG4/HbFW+QQWULY97+yf+S576uI7G+7J1DoRiYDwi4MZUk2n+Ehy2BFBaY7P15idjM
	 wYAeomPXLeONGTMx18uG5c3q+q59eyLLfpOYC2sOr6NQFsvLu3sSW9nGQHJXYk3te5
	 uWHr+PyptG2r0b/LFaAJPgPwnJWUqmlpwVf2/qXwXEbRnMYRhy7rgNBoFThbld4lUC
	 buRu0gXP4d1Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/9] KVM: guest_memfd: implement folio migration for
 non-confidential VMs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260805-shivank-gmem-migrate-v3-3-00d8bdec4e1d@amd.com>
References: <20260805-shivank-gmem-migrate-v3-0-00d8bdec4e1d@amd.com>
 <20260805-shivank-gmem-migrate-v3-3-00d8bdec4e1d@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 07:09:07 +0000
Message-Id: <20260805070908.0B6351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing ABBA deadlock between folio lock and filemap_invalida=
te_lock in kvm_gmem_error_folio
--

--- Patch [3]: [PATCH v3 3/9] KVM: guest_memfd: implement folio migration f=
or non-confidential VMs ---
commit 7a6778b9d1b7f5633978063ee1c7ee906f8f31c4
Author: Shivank Garg <shivankg@amd.com>

KVM: guest_memfd: implement folio migration for non-confidential VMs

This commit implements the folio migration callback for guest_memfd using
filemap_migrate_folio(). It explicitly uses a trylock for the invalidate lo=
ck
to avoid an ABBA deadlock with the truncation path.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 169f75f954337..583341d593c93 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -488,13 +488,45 @@ static struct file_operations kvm_gmem_fops =3D {
[ ... ]
> +	/*
> +	 * Migration invokes ->migrate_folio() while holding the folio lock.
> +	 * Use a non-blocking trylock to avoid inverting the lock order with
> +	 * truncation, which takes the invalidate lock before locking the
> +	 * folios.
> +	 */
> +	if (!filemap_invalidate_trylock_shared(mapping))
> +		return -EAGAIN;
[ ... ]
>  static int kvm_gmem_error_folio(struct address_space *mapping, struct fo=
lio *folio)
>  {
>  	pgoff_t start, end;
> =20
>  	filemap_invalidate_lock_shared(mapping);

[Severity: High]
This is a pre-existing issue, but does kvm_gmem_error_folio() suffer from t=
he
same ABBA deadlock that you correctly avoided in the new migration path?

The truncation path in kvm_gmem_punch_hole() acquires the invalidate_lock f=
or=20
write, and then acquires folio locks during truncate_inode_pages_range().

Concurrently, if a hardware memory error occurs, memory_failure() acquires =
the
folio lock before calling the error_remove_folio callback (which is routed =
to
kvm_gmem_error_folio()). This callback then unconditionally calls=20
filemap_invalidate_lock_shared(), resulting in an inversion:

Thread 1 (Truncation):
  kvm_gmem_punch_hole()
    filemap_invalidate_lock(inode->i_mapping);
    truncate_inode_pages_range(...)
      folio_lock(folio);

Thread 2 (Memory Failure):
  memory_failure()
    folio_lock(folio);
    kvm_gmem_error_folio(...)
      filemap_invalidate_lock_shared(mapping);

Should this error path also use filemap_invalidate_trylock_shared() or anot=
her
mechanism to avoid the deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-shivank-gm=
em-migrate-v3-0-00d8bdec4e1d@amd.com?part=3D3
