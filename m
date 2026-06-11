Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7F3D1706
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173924; cv=none; b=fBFmKPF3VR3w+y5ObMXi9SjlQSOFBHNLCySymjYczzlKO4U6R2yt+QadCbWisO1anI3u1gx6JdypSVk9eV6SMmCpoqJWhSZ2E5Z9pW77wz1XCvQp5APHEF+ESOfo1g2Y+jRHbipK0K56t9omB/zCod+E1afoAsL8EOvb1wUY/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173924; c=relaxed/simple;
	bh=u24yf8mMQQMEfSquoYFdKLuO27MOwBaZHYkwm3uc1V8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZU5y94UYnusiu/8rlXW17tv/PgSf9fBo0u1guHNSI+/RKsdaTputj+TAAUqWIaJMB+xdYEQ8NQjOEp1e99wV/179GNZWJZ3Yh10A7wekIEOsAwE3PWbR/cK9NCcL/hFcIpHCjvgr43OCR9Y09GQw0ZHv3IgYfTM6c0oohjeYVUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSExhhry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSExhhry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71701F00893;
	Thu, 11 Jun 2026 10:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781173921;
	bh=WNcybXuhwhGe+Z86egLPCqcV47JbIB4EmH4fVsggP5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OSExhhrymgNtQfUtnL7AwJO17Zzo40IWfi6bpXazZZpqeecM8AI0FrbBDsfBjOJmZ
	 SOWc1ywIf1+wcB2GvOTdWhquwKPkQPRUhopmIWKuqljsLYNy0fQJf66kr2mB6P4KrE
	 G55DDZMS8lN47V+j77G6YAlqtzCIBtVxogJCG52H0o56zBJqSfj397t/iUbHf1ZF6G
	 EvdCDD17LY+vl/9tL15Wpjs4NfkrJl31xU0Qkd8RPpP6dg+Lzu4qntks3ei910ZZ/3
	 Q/iOMcBK0LKw18/JzAK//4feKPlPLshgsZrTresffh+s8D+jpm6s3OKiVECAD5hANR
	 64Y3x8RgQkCeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: guest_memfd: Fix ABBA deadlock in
 error_remove_folio
Reply-To: sashiko-reviews@lists.linux.dev
To: zhanghao <76824143@qq.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <tencent_4B051B84CDCC0D1964EC00337AA32E40DC07@qq.com>
References: <tencent_4B051B84CDCC0D1964EC00337AA32E40DC07@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 10:32:00 +0000
Message-Id: <20260611103200.E71701F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] kvm_gmem_error_folio incorrectly returns the internal enum MF_DELA=
YED instead of 0 on success, causing memory_failure() to treat successful r=
ecovery as a failure.
- [High] Leaving the poisoned folio in the page cache causes memory_failure=
() to fail due to an unexpected extra reference during me_pagecache_clean().
--

commit f0c468f1d22ef5955d11ed4dde621b8eef0c2808
Author: Hao Zhang <zhanghao1@kylinos.cn>

KVM: guest_memfd: Fix ABBA deadlock in error_remove_folio

This commit modifies kvm_gmem_error_folio() to use a trylock when acquiring
the mapping's invalidate_lock. This prevents an ABBA deadlock with guest_me=
mfd
punch-hole operations, returning -EBUSY instead if the lock is contended.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 69c9d6d546b28..9417be3049cf0 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -499,7 +499,16 @@ static int kvm_gmem_error_folio(struct address_space=
 *mapping, struct folio *fol
>  {
>  	pgoff_t start, end;
> =20
> -	filemap_invalidate_lock_shared(mapping);
> +	/*
> +	 * memory_failure() holds mf_mutex globally.  We must not block
> +	 * on filemap_invalidate_lock here, as it can be held exclusive
> +	 * by kvm_gmem_fallocate() (MADV_REMOVE/FALLOC_FL_PUNCH_HOLE
> +	 * path), creating an ABBA deadlock with the poisoned folio lock.
> +	 * If the invalidation lock is contended, fail the recovery instead
> +	 * of reporting MF_DELAYED without zapping KVM mappings.
> +	 */
> +	if (!filemap_invalidate_trylock_shared(mapping))
> +		return -EBUSY;
> =20
>  	start =3D folio->index;
>  	end =3D start + folio_nr_pages(folio);

[Severity: High]
This is a pre-existing issue, but does leaving the poisoned folio in the pa=
ge
cache cause memory_failure() to fail?

In kvm_gmem_error_folio(), guest_memfd intentionally does not truncate the
poisoned folio from the page cache so that KVM can gracefully handle guest
access to the poisoned page. However, in
mm/memory-failure.c:me_pagecache_clean(), the code checks for extra referen=
ces
after truncate_error_folio():

	extra_pins =3D shmem_mapping(mapping);
	...
	if (has_extra_refcount(ps, p, extra_pins))
		ret =3D MF_FAILED;

Because guest_memfd is not shmem, extra_pins is false. has_extra_refcount()
then sees the lingering page cache reference on the folio as an unexpected
user and returns true. Does this guarantee that me_pagecache_clean() will
always return MF_FAILED for guest_memfd, leading to the VM being hard-killed
by the MCE handler instead of KVM gracefully recovering?

[Severity: High]
This isn't a bug introduced by this patch, but should this callback return 0
on success instead of MF_DELAYED?

The VFS address_space_operations->error_remove_folio callback contract
requires returning 0 on success or a standard negative error code on failur=
e.
However, kvm_gmem_error_folio() returns the internal memory-failure enum
MF_DELAYED (2).

The caller truncate_error_folio() in mm/memory-failure.c checks this:

	if (err !=3D 0)
		pr_info("%#lx: Failed to punch page: %d\n", pfn, err);

Since it mistakenly treats the positive enum value as an error, will this
log "Failed to punch page: 2" and return MF_FAILED, entirely defeating the
graceful recovery feature?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_4B051B84CDC=
C0D1964EC00337AA32E40DC07@qq.com?part=3D1
