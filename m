Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B5A3B9DAB
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325332; cv=none; b=CyEjZ3tk7wpDKKrDzO+hCn5WVOXkqUuTerdl445BAfcT903+pyvFiRfOfyUVkqxscdrKf003jxQMOU/BgP70lFzAa4g/6Lc45e2XDeZKNvmX73ROzuOzL4JrlcTXk+EP0tXQkebndW27d84E6y0TB+i1J+6/9qqUlr4xkhZ9QXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325332; c=relaxed/simple;
	bh=0ldCdxEnkZoD7gS/g+cWx5VH49GnBCV4ffxYDKc37aE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m2HAc1u3Jvqn2MlaNo93G1zrYrg/PuJ0rYXdpMlb1GKgXuQyqgnahlcf7AmqyH9H1oVUykoFXQAVPJWxJj3dbKnq8gchGfuI4DkDHqxd41Kcq6H0j19awQoy76gX81SR1bdDOp5JTCxSFmpvWGiA1sRbPZKigt5oE7GG4YAZX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOQkcHDM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOQkcHDM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C261F000E9;
	Fri, 17 Jul 2026 21:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784325320;
	bh=PbvhkeEZw6vkaQsnvLlFzI3K5X+68z3Ffru/nmqfppk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UOQkcHDMCMdEKZ/OYMu1643T2GsIz/XKyJQAGmj9y0xYhVRjN73R7J4XyW5+GWp+x
	 om6hseK6t6tmEkuJ+lfAaaFgZl6pCIy6tL5Nfmf/NPBKrUu+N2jBo9vo9Rm//8d1c6
	 DEErg/JF5NDK8clEfIXY2TeEMQJ5hgpXpueyO4LwEafCs7Y0HhVDkLnDwB74Hvqoa/
	 R7NXKBcRpNqQePa54bEyF/nlyguC0j0XQY8BQPlpjsQ4vgECCeV8kus5th0bu0k7FD
	 xtwe6pHqHbMfv1kMUIYUlUtCHfAXO0pxRuiiFNMJF46Awg9L5YKaoZ5byx8SXMhF/5
	 hbUUaOEEX5jbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] virt: tdx-guest: Allocate Quote buffer
 dynamically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Fang" <peter.fang@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260717214349.4075994-3-peter.fang@intel.com>
References: <20260717214349.4075994-1-peter.fang@intel.com>
 <20260717214349.4075994-3-peter.fang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 21:55:19 +0000
Message-Id: <20260717215520.76C261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Premature exposure of the misc device allows a Use-After-Free (UAF=
) on the module initialization error path if `alloc_quote_buf()` fails.
--

--- Patch [2]: [PATCH v2 2/2] virt: tdx-guest: Allocate Quote buffer dynami=
cally ---
commit e37e54ca6bcf9f24fca7285847baa3251ff5dfba
Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.=
com>

virt: tdx-guest: Allocate Quote buffer dynamically

This modifies the TDX attestation driver to dynamically allocate the Quote
buffer based on the size reported by the TDX module. It uses alloc_pages_ex=
act()
to allocate up to a 4MB contiguous buffer and fails quietly if the allocati=
on
cannot be satisfied.

> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/=
tdx-guest/tdx-guest.c
> index d0303e31e8161..ce2c2ef746762 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c

[ ... ]

> @@ -417,7 +442,7 @@ static int __init tdx_guest_init(void)
>  	if (ret)
>  		goto deinit_mr;
> =20
> -	quote_data =3D alloc_quote_buf();
> +	quote_data =3D alloc_quote_buf(&quote_data_len);

[Severity: High]
This is a pre-existing issue, but this patch makes it significantly more
likely to trigger by introducing a large contiguous memory allocation (up to
4MB) that can easily fail on fragmented systems.

Can this lead to a Use-After-Free on the initialization error path?

If misc_register(&tdx_misc_dev) (called just before this hunk) succeeds,=20
the /dev/tdx_guest device is immediately exposed to userspace. A userspace=
=20
process can open it and call ioctl(TDX_CMD_GET_REPORT0), entering
tdx_do_report() which uses tdx_report_buf.

If alloc_quote_buf() then fails, the error path calls misc_deregister() and=
=20
tdx_mr_deinit().=20
   =20
tdx_mr_deinit() executes:

    kfree(tdx_report_buf);
   =20
This freeing happens without acquiring mr_lock, meaning it can race with th=
e=20
ongoing ioctl. Could the concurrent ioctl in tdx_do_report() then access th=
e=20
freed tdx_report_buf?

Should misc_register() be moved to the end of tdx_guest_init() after all
resource allocations succeed?

>  	if (!quote_data) {
>  		pr_err("Failed to allocate Quote buffer\n");
>  		ret =3D -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717214349.4075=
994-1-peter.fang@intel.com?part=3D2
