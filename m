Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BEA35DA64
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898592; cv=none; b=Q5peSn/g4S54jnY63WvF0MhheHmTYyq7rIqD1ieJWBmxPH4CdFwhlCpOHrc8R53kJLdUn1aPX9nKwHLjYf5BqedQRtb5i8K6IakAIIfFnzlX6Q9YCvC7HlAOAVeFUr8+aDqyF0JwPc01uyE7oszlqT5ofxtCbYcGfVujWYucrXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898592; c=relaxed/simple;
	bh=uaJpYeECnpyuu+rbIob3khSPXZbV4OcmDcUdmnQyd0E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TQmU0lYAbKhPRBR9ClhqUS+UAM/CMgLzh0tPkzNVwHTiLuA7v/rGzLJ3nomyH2s9T+KrGrzqA74mJUWCGWfOpLDM2t9jXLWJAbk6iqNQUzMePNEKcuMfEAez6ckttrBFOaE/F+EYU3abvNXWBUMpNiiUa0MYGvFCowNKJuWuZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkyuU2+C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkyuU2+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4906E1F000E9;
	Wed,  5 Aug 2026 02:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785898591;
	bh=2CXdKmG6kiUkKcnMRTIgptwroLvDtFEKqA/yh5+wbjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YkyuU2+Ccz85C+uKcVnh87KboufjfYu3cE3CZbdM+ZunHRjXeN4P9Ki9Lg9ZT0PtF
	 0BBIUOIOGmtX17rLUgiyUw4p4qgGFGxGjyGjRh8pSsTE1nIST5O3ZYFWuKD//dRzNf
	 rKBuJ5ttMa4OPTRD0bURCo5Wcfi44oeUFGulC29W8d38SC1Kpch/kekUB0mTdz4Icb
	 dCYIJ3mJU+ycg7M7RP5mkYGRUg348CEICJzZxTMxxRmmc58xqjdIhI/bwFhScGjw3S
	 x1lhqTFZCi7PYKEZQPQSQhQ2ON8QQwaw74fdy9ycJqg9zeubwSID3qjtqToSlZdtV5
	 8v01Jn889EAbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vhost: reset the vring metadata cache on vring
 reconfiguration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Yang" <juny24602@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804025621.16580-1-juny24602@gmail.com>
References: <20260803014823.68623-1-juny24602@gmail.com>
 <20260804025621.16580-1-juny24602@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 02:56:30 +0000
Message-Id: <20260805025631.4906E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `vhost_put_user` falls back to `__vhost_get_user_slow` which hardc=
odes `VHOST_ACCESS_RO`, bypassing IOTLB write protections.
--

--- Patch [1]: [PATCH v2] vhost: reset the vring metadata cache on vring re=
configuration ---
commit 3ebd42f4cc1c99600e85fca94195264924a8cc97
Author: Jun Yang <junvyyang@tencent.com>
vhost: reset the vring metadata cache on vring reconfiguration

This commit ensures the vring metadata cache is reset whenever the vring is
reconfigured. This forces new addresses to be validated through the slower
access path instead of hitting stale cache entries.

> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 4c525b3e16ead..77c96993100b5 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
[ ... ]
> @@ -2126,6 +2126,14 @@ static long vhost_vring_set_num_addr(struct vhost_=
dev *d,
>  		BUG();
>  	}
> =20
> +	/*
> +	 * The metadata cache holds the IOTLB mapping that backed the previous
> +	 * desc/avail/used addresses and vring size, both of which are being
> +	 * replaced here.  iotlb_access_ok() takes a cache hit as proof that the
> +	 * region was validated, so the stale entries have to go.
> +	 */
> +	__vhost_vq_meta_reset(vq);
> +

[Severity: High]
This is a pre-existing issue, but does resetting the metadata cache here
expose a vulnerability where IOTLB write protections can be bypassed?

When the cache is reset, a subsequent backend configuration can trigger
vhost_update_used_flags(), which calls vhost_put_user() to write to the
used ring. Because the cache is empty, vhost_put_user() falls back to
__vhost_get_user_slow().

Looking at the fallback in __vhost_get_user_slow():

drivers/vhost/vhost.c:__vhost_get_user_slow() {
    ...
	ret =3D translate_desc(vq, (u64)(uintptr_t)addr, size, vq->iotlb_iov,
			     ARRAY_SIZE(vq->iotlb_iov),
			     VHOST_ACCESS_RO);
    ...
}

Since translate_desc() unconditionally requests VHOST_ACCESS_RO even for
write operations via vhost_put_user(), could a guest bypass vIOMMU
restrictions by mapping target memory as read-only and letting
vhost_put_user() overwrite it?

>  	mutex_unlock(&vq->mutex);
> =20
>  	return r;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804025621.1658=
0-1-juny24602@gmail.com?part=3D1
