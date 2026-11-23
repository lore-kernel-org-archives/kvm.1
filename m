Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795411115;
	b=QDTMp27hXcptmLQ6RvpTNezpUeaGhBLaQilDIGbbzl1g9yX+PUXRGLlXVT9yAgltq3tU
	 nAv3Q3yK8VzffGqHJ6nVLUX6OJrgeLdpxUwUuZtoeaEAH1X4tAh7txjoeZfGqo4ItHne8
	 FLG/kUCepJjzfMHvctNp11HpnMSy7DIEwTEfYGWRO/t+k275mBq3eknr7aJaX9YUJtzEM
	 U8s5/kTOyeYfsUMnQgZ/RNlEZ7ajveae039roca1AmIevx/Qs99xh0TxMMVmhpvXrSUuR
	 mISz0CWe4+tJLlZ9Hb5xQfrEK3fPRUFNm15ZH5tNcTrKBSmj47kz9MhO5HFrTnNK19A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795411115;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2Fd1bewDRM5COgCTPv5zWnHpuIrnbmaMOnAaFIsgWLU=;
	b=1FCsWD9TTZ/w5Jie3SRbFg7Kgd9vR1y8u25PREdik31xnROnILq3rkj1aLPaq2inPQvC
	 YgY72J8mKvNPWkCB8o4UB1qyGlA9Oo98zCNYDIM3u3xx3FoqVtLGdMjYfAQ8guSMawwyT
	 qgHyV7xS1X2xk8PtiFMuxoNp3U79ZBb8fEnvl+1ZH/giz6IqBK2wdR601jYOphKElhWDl
	 cKKFDdbq4pAAanWhvHGP4ktjCmCdjryEwYA7ITx6j9rg1gN/GR9BT3OyBe7OaoB5oGxf1
	 H9zCCXQjM2pSGFBq+VKPvhjqvrH7F98hZApF8v6irHPgMXLR2l4Z20b5xGccv5+W0lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRpLbpUl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392B606A31A
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 05:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRpLbpUl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1C61F000C6;
	Mon, 23 Nov 2026 05:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795411114;
	bh=2Fd1bewDRM5COgCTPv5zWnHpuIrnbmaMOnAaFIsgWLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GRpLbpUliQ7xyDvmwc+sIe5n1SKl5UK4KImyK8vUS/z9zalERbt4TmYDT9vvfp9SP
	 sEdF9IKkSUYAbN3PwkxuUN9/GiDqZJrnGGLddRAKozlzscv3pu+RPvFvFNCrq88mxg
	 hS4rT+7QctHvkhu4CJcLG5fT5S04zOQoU4lPPZP+wQUicOPwyuXDpT+zOuYNaSys/z
	 qI85UFP9DWYeZGopvV2rMZAQpgIDZv6F1C46uaptTSljCO0zUBCF3Ne5uffZgm9kCw
	 jlX70URxi8K+yockJEVB62CN2LHg/RslPrxU8K/9acpVAE+9X0TjpywzDZ5PCXmpMO
	 TQCXU2sCfYutQ==
Message-ID: <sashiko-outbox-228711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/18] iommu: Restore and reattach preserved domains
 to devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samiullah Khawaja" <skhawaja@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261123044949.3610702-14-skhawaja@google.com>
References: <20261123044949.3610702-1-skhawaja@google.com>
 <20261123044949.3610702-14-skhawaja@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 05:18:33 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] iommu: inconsistent group domain state in
  iommu_setup_default_domain()
--

commit c2881b6423bf649bce482244af7dd51d680e43e3
Author: Samiullah Khawaja <skhawaja@google.com>

iommu: Restore and reattach preserved domains to devices

This commit restores preserved IOMMU domains via the iommupt restore()
operation during default domain setup and reattaches them to preserved
devices and their IOMMU groups.

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f8837ab1b526d..c60af471ec32f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c

[ ... ]

> @@ -3161,6 +3223,66 @@ int iommu_fwspec_add_ids(struct device *dev, const=
 u32 *ids, int num_ids)
>  }
>  EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
> =20
> +static struct device *__iommu_group_restored_device(struct iommu_group *=
group)
> +{
> +	struct group_device *gdev;
> +
> +	for_each_group_device(group, gdev) {
> +		if (dev_is_pci(gdev->dev) && dev_iommu_restored_state(gdev->dev))
> +			return gdev->dev;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int __iommu_device_restore_domain(struct device *dev)
> +{
> +	struct iommu_group *group =3D dev->iommu_group;
> +	struct iommu_device_ser *device_ser;
> +	struct iommu_domain *domain;
> +	int ret;
> +
> +	lockdep_assert_held(&group->mutex);
> +	if (group->domain)
> +		return -EBUSY;
> +
> +	device_ser =3D dev_iommu_restored_state(dev);
> +	if (!device_ser)
> +		return -ENOENT;
> +
> +	/*
> +	 * Ownership of groups with preserved devices is set during boot. These
> +	 * will be reclaimed later by the entity (iommufd) that preserved them.
> +	 * Claim ownership first so that even if the reservation or the domain
> +	 * restoration fails, no driver can bind to the device using
> +	 * default_domain.
> +	 */
> +	WARN_ON(group->owner);
> +	group->owner =3D device_ser;
> +	group->owner_cnt =3D 1;
> +
> +	/* A restored device must be the only device in its group */
> +	ret =3D __iommu_group_reserve_liveupdate(group);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D __iommu_group_alloc_blocking_domain(group);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * If attaching the restored domain fails below, the domain is not
> +	 * leaked; it remains cached in domain_ser->restored_domain and will be
> +	 * reused if the device is rescanned.
> +	 */
> +	domain =3D iommu_restore_domain(dev, device_ser);
> +	if (IS_ERR(domain))
> +		return PTR_ERR(domain);
> +
> +	/* The restored domain is attached with the restored device. */
> +	return __iommu_group_set_domain(group, domain);
> +}

[ ... ]

> @@ -3219,6 +3342,18 @@ static int iommu_setup_default_domain(struct iommu=
_group *group,
> =20
>  	/* We must set default_domain early for __iommu_device_set_domain */
>  	group->default_domain =3D dom;
> +
> +	/*
> +	 * Preserved devices need to be attached to the restored domain. If the
> +	 * restore fails, the group stays owned, so the default_domain is never
> +	 * attached or used.
> +	 */
> +	dev =3D __iommu_group_restored_device(group);
> +	if (dev) {
> +		WARN_ON(__iommu_device_restore_domain(dev));
> +		goto out_free_old;
> +	}

[Severity: Medium]
Can iommu_setup_default_domain() leave group->default_domain set while
group->domain is NULL when __iommu_device_restore_domain() fails?

If __iommu_device_restore_domain() fails (for example, when
__iommu_group_reserve_liveupdate() returns -EOPNOTSUPP because a sibling
device was added to group->devices during bus_iommu_probe(), or when
blocking domain allocation, domain restoration, or domain attachment
fails), iommu_setup_default_domain() jumps to out_free_old and returns 0
with group->default_domain =3D dom and group->domain =3D NULL.

That breaks the invariant checked in __iommu_probe_device():

drivers/iommu/iommu.c:__iommu_probe_device() {
	...
	list_add_tail(&gdev->list, &group->devices);
	WARN_ON(group->default_domain && !group->domain);
	...
}

If the group contains another device (or one is added while
liveupdate_reserved is false) and the restored device is then removed,
__iommu_group_remove_restored_device() clears group->owner and
group->owner_cnt without attaching group->default_domain, and
iommu_deinit_device() keeps group->default_domain because group->devices
is non-empty.  A driver can then bind to the remaining device via
iommu_device_use_default_domain() while group->domain is still NULL and
default_domain was never attached in hardware, and rescanning the removed
device hits WARN_ON(group->default_domain && !group->domain) in
__iommu_probe_device() without setting up a domain.

Also, if a non-restored sibling device in the same group is probed first
with group_list =3D=3D NULL (setting group->default_domain and group->domai=
n)
and the restored device is probed second, __iommu_probe_device() takes the
if (group->domain) branch and attaches group->default_domain to the
restored device instead of restoring its preserved domain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123044949.3610=
702-1-skhawaja@google.com?part=3D13
