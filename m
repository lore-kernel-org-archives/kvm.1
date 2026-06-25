Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D0730EF63
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782427162; cv=none; b=CGHGC+MoTxQbjZ63sVfHAKHHn8iSRhjGjEt+2jM/yuRTPwXn9DfqP0b6u8RXOGXgBSv2SOwbfWMXpAtA+1nqm8eQ2QUhqQ41Xw5dRGhg5qcxWcltlrB2dQx0hixxJdKZbTWUDWPMBUi6V8jzTfhgATk+1SzPE2oGiaEdsn0wOR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782427162; c=relaxed/simple;
	bh=9+hj/5TWchWH3+Ittt3J3cXWOkEZ3vhktEA/U8RXdcs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XakJsrlN3h2savByAf5LfraWcQsIruog0bJ3IzQBuH6x/dV8oFp+b6s64F/tDcbC5Ij4WRz1POcluTVfsDjaKqg/r2W9E+2q9rytP7orwUu4w481aHa0++XAZulb57kwLI82cmJ3xVlXH+yhIo5L5FiLyBqlPePwHOCsMF0ky0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYKEMLdS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYKEMLdS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7511F000E9;
	Thu, 25 Jun 2026 22:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782427160;
	bh=14XYD6IibAntOOcL0Q8vpdvbq5cQpREwFLzurnpmTTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PYKEMLdSkWbq16MM43KfK8BJVYGD+I3FczpV8iuzkpbCeCx/5tZMplXxuCCT6m8vn
	 mPAlrpVqGKEFs/Bp7ovccHK8a+a7vbjxU0ujzJJQfdZ1v7HGWk8JQ7fQRxYHRtTpRq
	 /vyf2yvkvQnNz/XXohB9C2jjhwRiz61VM1F1FWLbp7kmSqlh8jgmpurmtl8QDZkrS4
	 gQOqGWk6Avj5whOZrq8cHEn6e/X4l2Mu2uGCNM1c29nUj2EVasmIf3ktV2o2unBptN
	 mQzUxCsibCano1upkQMIr5QOToDG9+mUgD7tTXel4ZSRLDtcnPM1TU/KRukLvIfFmh
	 ni2ZmtJiP5Y9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] KVM: Rework .gmem_invalidate() into
 .gmem_free_folio()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260625222229.3367197-5-seanjc@google.com>
References: <20260625222229.3367197-1-seanjc@google.com>
 <20260625222229.3367197-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 22:39:19 +0000
Message-Id: <20260625223920.6C7511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] KVM module can be unloaded while guest_memfd folios are being evic=
ted, causing a Use-After-Free crash when calling a_ops->free_folio().
--

commit dd2a52e3b94932f45c23fd6812c93b476a753c85
Author: Sean Christopherson <seanjc@google.com>

KVM: Rework .gmem_invalidate() into .gmem_free_folio()

Rename .gmem_invalidate() to .gmem_free_folio() as the hook is called when
a folio is freed. Drop guest_memfd's trampoline and wire up .free_folio()
directly to the arch callback.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 86690683b2fe3..1618acc3ca647 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -523,23 +523,12 @@ static int kvm_gmem_error_folio(struct address_spac=
e *mapping, struct folio *fol
>  	return MF_DELAYED;
>  }
> =20
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -static void kvm_gmem_free_folio(struct folio *folio)
> -{
> -	struct page *page =3D folio_page(folio, 0);
> -	kvm_pfn_t pfn =3D page_to_pfn(page);
> -	int order =3D folio_order(folio);
> -
> -	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
> -}
> -#endif
> -
>  static const struct address_space_operations kvm_gmem_aops =3D {
>  	.dirty_folio =3D noop_dirty_folio,
>  	.migrate_folio	=3D kvm_gmem_migrate_folio,
>  	.error_remove_folio =3D kvm_gmem_error_folio,
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -	.free_folio =3D kvm_gmem_free_folio,
> +	.free_folio =3D kvm_arch_gmem_free_folio,

[Severity: High]
This is a pre-existing issue, but can this lead to an execution-after-free
crash during module unload?

When a user closes all KVM-related file descriptors, __fput() drops the
module reference via fops_put(file->f_op) before it calls dput(). The
dput() call subsequently drops the inode reference and triggers page cache
eviction.=20

Because kvm_gmem_fs lacks .owner =3D THIS_MODULE, the superblock and
inodes do not independently pin the KVM module in memory.

If an administrator unloads the KVM module after fops_put() but before
eviction completes, does the mapping->a_ops->free_folio() call in the page
cache eviction path attempt to execute unmapped memory?

>  #endif
>  };
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625222229.3367=
197-1-seanjc@google.com?part=3D4
