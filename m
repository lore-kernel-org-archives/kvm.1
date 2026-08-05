Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6B93DE453
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916929; cv=none; b=XeoBLIdPSioyXctjROyNR/RuPyzw9rve3oTweuWMSRkegMPwSt59kZe4kjUknvX1mcAnRBluqFqtPmjP4st3IxnK0i+Gw4WE2eFVoCifXJ6ugqz41IU3twcnjs0IIfqkKH+8s7SDmTuY5Ku+UXc22JzWWfrtrj7Hfj3gkg+96vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916929; c=relaxed/simple;
	bh=Wfwi2tb7uuSJ+kY+YguXvc2iCX+gynPhnN7zJehm99Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CcN5obyN7agfeVrRWOTDUYQgMlAmi/Gr0676CYADgDHH5VpgcTA80ZPdy30JEhW+RK6aMQQ8p3awq7uO/IODk3eau5Omdbk1eVng7m9dsBWBr0d96naiF2LYeZq21etwm1YWJSA7a2IbsoBHmo7s8rYgZ/ZSVlg6PYjY2pcngwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovwfUZdQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovwfUZdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EF61F000E9;
	Wed,  5 Aug 2026 08:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785916928;
	bh=5gqG2VGJGryiZmCkxl4fktlbbTGK0RUix/2nenwp6mw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ovwfUZdQLOuhk7o/YkjlTnfMzyxhRIOLVyA9UHUlMDc/PqrXK1+kFG7Dny9hDybhE
	 x/3pdMBsM4pZWYWu0XmE+VSyqLDplXkGpPVf3N41XUpT/Pb/JqlcFPeR5FRzNmlsjT
	 Qbd+5LLj+bsksiwkGDIN3PIvaNsAB1djvP+DJDJKZ74y4/1MayxUgRfA3FnziME1fv
	 hhemJFEPH4z3pf4UbsP4JJtL5r5+TETbTryuIitXSb1jc9ACtlsJym7EH+WY9EZ9fI
	 Vr5SL7+7wQbRA2CGRTqNsgqA9hZwqD4pBeXS2GqQ1lWYoayAa3GEjor9lfONVo+qWe
	 NQ3ZxOBSgcylQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] tools/virtio: add --features-array switch
Reply-To: sashiko-reviews@lists.linux.dev
To: rom.wang <r4o5m6e8o@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804080125.79403-4-r4o5m6e8o@163.com>
References: <CAJaqyWfP7j5_PvOP0JiHuAQ8appGnoJDS3OB-qK7riBpZ_d_tQ@mail.gmail.com>
 <20260804080125.79403-1-r4o5m6e8o@163.com>
 <20260804080125.79403-4-r4o5m6e8o@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 08:02:07 +0000
Message-Id: <20260805080207.E3EF61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The kernel implementation of VHOST_GET_FEATURES_ARRAY zeroes out t=
he returned features instead of the tail, causing incorrect ioctl behavior =
and causing the newly added test to fail.
--

--- Patch [3]: [PATCH 3/3] tools/virtio: add --features-array switch ---
commit 62c148ff31dfbcede0d6da6c8873dc84602618f3
Author: Yufeng Wang <wangyufeng@kylinos.cn>

tools/virtio: add --features-array switch

This patch adds a --features-array switch to vhost_net_test to exercise the
VHOST_SET_FEATURES_ARRAY and VHOST_GET_FEATURES_ARRAY ioctls. The test veri=
fies
that the kernel correctly copies the features and clears the trailing space=
 when
the requested count exceeds the kernel's defined feature entries.

> diff --git a/tools/virtio/vhost_net_test.c b/tools/virtio/vhost_net_test.c
> index 389d99a6d7c76..77191e60a7a35 100644
> --- a/tools/virtio/vhost_net_test.c
> +++ b/tools/virtio/vhost_net_test.c
[ ... ]
> @@ -467,11 +491,43 @@ static void help(int status)
[ ... ]
> +static void verify_get_features_array(struct vdev_info *dev)
> +{
> +	struct vhost_features_array *clean, *dirty;
> +	int r, i;
> +
> +	clean =3D calloc(1, struct_size(clean, features, GET_FEATURES_ARRAY_COU=
NT));
> +	assert(clean);
> +	clean->count =3D GET_FEATURES_ARRAY_COUNT;
> +	r =3D ioctl(dev->control, VHOST_GET_FEATURES_ARRAY, clean);
> +	assert(r >=3D 0);
> +
> +	/* Sentinel-fill so the kernel's clear_user() of the tail is visible. */
> +	dirty =3D calloc(1, struct_size(dirty, features, GET_FEATURES_ARRAY_COU=
NT));
> +	assert(dirty);
> +	dirty->count =3D GET_FEATURES_ARRAY_COUNT;
> +	memset(dirty->features, 0xa5, GET_FEATURES_ARRAY_COUNT * sizeof(dirty->=
features[0]));
> +	r =3D ioctl(dev->control, VHOST_GET_FEATURES_ARRAY, dirty);
> +	assert(r >=3D 0);
> +
> +	/* Must match; a wrong clear_user() start would leave them unequal. */
> +	for (i =3D 0; i < GET_FEATURES_ARRAY_COUNT; i++)
> +		assert(clean->features[i] =3D=3D dirty->features[i]);

[Severity: High]
This is a pre-existing issue, but will this assert consistently fail agains=
t the
current kernel implementation of VHOST_GET_FEATURES_ARRAY?

Looking at vhost_net_ioctl() in drivers/vhost/net.c, when handling the array
features and zeroing the trailing space, it appears to start at argp:

        /* Zero the trailing space provided by user-space, if any */
        if (clear_user(argp, size_mul(count - copied, sizeof(u64))))
                return -EFAULT;

Because argp is not advanced by copied * sizeof(u64), clear_user() zeroes o=
ut
the newly copied features at the beginning of the array instead of the tail.

Since the kernel implementation leaves the actual trailing space uninitiali=
zed,
will this cause the test introduced here to always crash via the assertion?

> +
> +	printf("GET_FEATURES_ARRAY: 0x%llx 0x%llx (tail zeroed) OK\n",
> +	       (unsigned long long)clean->features[0],
> +	       (unsigned long long)clean->features[1]);
> +
> +	free(clean);
> +	free(dirty);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804080125.7940=
3-1-r4o5m6e8o@163.com?part=3D3
