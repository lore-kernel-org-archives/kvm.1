Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532402F28FC
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773944944; cv=none; b=Wx9nq15L2BmtcESES+GXlaTNfhq2zzQIakPgA8Rgeuu6SDUpXpeSanENaTDIIUHEJgGbKWZx0AprF6SxSraCr79QDHpCplSotnRZvXEiKYKpbcjuEcPcJTXt8/7tSjyi112MbxgVKvkKCDcbDKI4iQyyJOccbM40ftqKlT4R0wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773944944; c=relaxed/simple;
	bh=CGKzb9Gh4AW7zglTzC5/qjXVnSJq3P0/ZPjPnqbkjEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEFbVxipofmz2fEcDZZaptNs7MXRlxwUQXlP3FgG84fqcocujZZFvLnmCO9uPPYIGMzi9zcVqvPh4MWV4XXeMJTD57tBQkZb3ICvcL11whPXNJMREiBFAtnvcnFHPeqh9RHEesKJo84fZ+cGR4bJ+jKz1I3oZG0+v1KU/AGdAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=u2gucpTY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OpOMa7dh; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="u2gucpTY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OpOMa7dh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 158197A0049;
	Thu, 19 Mar 2026 14:29:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 14:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773944939;
	 x=1774031339; bh=rQn898NdKeyvPzy5cBb82rMWyAFOYMyM8Ok82awi2LE=; b=
	u2gucpTY3K8U6Y93lRqHrqoBIs+xZRu8E6Cia8xqwIczLrBA8HBL10XkgLbko2AT
	Cbj8a13h75uYrie8Gl71e4UVWutRYkYwotnOKYVxSIQ6DRjI5RnM/ho80s8dprAS
	BdJtnfn9QThCVAUSVAasbNc2noVyRyLwhVH103Rj3Ly5eOO3kIMfoxtNwfYQDw+S
	K41G2LhCxNUI0mG+U0PfjI8yzT16Hcxd3kGxn3lik2tGB1eo79N0zthCZH+4Ky18
	M94MQbOb+eJ/2KKP8gaftMgM9+/yK78Pq/gqev+FDh/+ylvCd4e4yUvXGf6FfnhF
	Q2Z5KqkSpdkIsVbg4noe/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773944939; x=
	1774031339; bh=rQn898NdKeyvPzy5cBb82rMWyAFOYMyM8Ok82awi2LE=; b=O
	pOMa7dhS/w60PBgsNI4t9JEES2izPPZ+8WnnTrPECpV+TICK8SuwEBkJvmCCHXaa
	44lVjcy0R5UUJhABJT9/K3ugp6hSZFMP0kPye0f212vsneEt9U2fUffWan0ELAuJ
	ent/T/9+bwvd83mjS4KuyDs+3XwrdXcsgPyO15SLNZk27JfTrTgxCiZ0fpP0KX0R
	e7n4Iu4c3+x8GZ3Izv4i8HqC0U6AXCXjNfj1ATLErV0ADRb6RKcqGFCP1roOezMk
	aPyXB8QvmNLt3pPxeOBXYaLgNxAzdUbv+wooEuHGEqfeO9UM1YJQPTkobaPaHNlz
	HSkw3Rq4wMGP+PmOku2lw==
X-ME-Sender: <xms:a0C8aTYd-8kibk3jcK63Ae0srfwgLWajuYOY9qM_sRR0Ll-2GA1dBw>
    <xme:a0C8aWHnt_sHmtrrcr2V4YoLAQL_TYCOGd-C6Df1f3w3he8OHPfWD3HIZX5fZqwrU
    gYh0GPIXhg4xrU5o4SSwU7cZTaKLDvFkoKS2n4IPGJdO2iVaAenqu4>
X-ME-Received: <xmr:a0C8aen3EZoigxawnfxhSyBIk0hk0MvTuU05mQX0jJgdd21A0mkpZX6bS-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeihihhshhgrihhhsehnvhhiughirgdrtghomhdprh
    gtphhtthhopehjghhgsehnvhhiughirgdrtghomhdprhgtphhtthhopehkvhhmsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvhhinhdrthhirghnsehinhhtvg
    hlrdgtohhmpdhrtghpthhtohepjhhorghordhmrdhmrghrthhinhhssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlvghonhhrohesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
    epmhgrohhrghesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprghvihhhrghihhesnhhv
    ihguihgrrdgtohhmpdhrtghpthhtoheptghlghesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:a0C8abArroc_XtyvM9nZ3hl32CSlA8lARF3z2ZYlI3lZLCy6XGofbA>
    <xmx:a0C8aQBCE0ZXCJIkIY_EtplLv4oKv5diDGNH-v2kH5KFZeZUHaWAyw>
    <xmx:a0C8aSFZnZmQCXk2dmj7x5GHf_yS-fpepieyAf2DdOfoOppmaAsEmA>
    <xmx:a0C8aX4s-nAe86gvS4uj1_OOuOZ7o3UlATaWzIxykF9ZJQlwjok_aw>
    <xmx:a0C8aVDxzniIwDixt1ugOp4qyqBtwB_vG3b9YVDBj9d-JstyolEI9gOg>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 14:28:58 -0400 (EDT)
Date: Thu, 19 Mar 2026 12:28:56 -0600
From: Alex Williamson <alex@shazbot.org>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: <jgg@nvidia.com>, <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
 <joao.m.martins@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>,
 <avihaih@nvidia.com>, <clg@redhat.com>, <peterx@redhat.com>,
 <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
 <kwankhede@nvidia.com>, alex@shazbot.org
Subject: Re: [PATCH V2 vfio 2/6] vfio: Add support for
 VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2
Message-ID: <20260319122856.59c001e0@shazbot.org>
In-Reply-To: <f5188d47-b787-4382-b0cf-1fdf38781a30@nvidia.com>
References: <20260317161753.18964-1-yishaih@nvidia.com>
	<20260317161753.18964-3-yishaih@nvidia.com>
	<20260318160337.1fa2b3d8@shazbot.org>
	<f5188d47-b787-4382-b0cf-1fdf38781a30@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Mar 2026 17:26:46 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> On 19/03/2026 0:03, Alex Williamson wrote:
> > On Tue, 17 Mar 2026 18:17:49 +0200
> > Yishai Hadas <yishaih@nvidia.com> wrote:
> >   
> >> Currently, existing VFIO_MIG_GET_PRECOPY_INFO implementations don't
> >> assign info.flags before copy_to_user().
> >>
> >> Because they copy the struct in from userspace first, this effectively
> >> echoes userspace-provided flags back as output, preventing the field
> >> from being used to report new reliable data from the drivers.
> >>
> >> Add support for a new device feature named
> >> VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2.
> >>
> >> On SET, enables the v2 pre_copy_info behaviour, where the
> >> vfio_precopy_info.flags is a valid output field.
> >>
> >> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> >> ---
> >>   drivers/vfio/pci/vfio_pci_core.c |  1 +
> >>   drivers/vfio/vfio_main.c         | 20 ++++++++++++++++++++
> >>   include/linux/vfio.h             |  1 +
> >>   3 files changed, 22 insertions(+)
> >>
> >> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> >> index d43745fe4c84..1daaceb5b2c8 100644
> >> --- a/drivers/vfio/pci/vfio_pci_core.c
> >> +++ b/drivers/vfio/pci/vfio_pci_core.c
> >> @@ -736,6 +736,7 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
> >>   #endif
> >>   	vfio_pci_core_disable(vdev);
> >>   
> >> +	core_vdev->precopy_info_v2 = 0;
> >>   	vfio_pci_dma_buf_cleanup(vdev);  
> > 
> > There's a minor discrepancy here, enabling precopy_info_v2 is a core
> > vfio feature, but clearing the previous user's opt-in is only
> > implemented in the core helper for vfio-pci and associated variant
> > drivers.  This should be moved to vfio_df_device_last_close() to be
> > common.  A follow-up fix rather than a v3 is fine if you agree.  Thanks,
> >   
> 
> Sure, up to you.
> 
> We can consider also using the below fix-up chunk as part of merging V2.

I'll fold it in.  Thanks,

Alex
 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c 
> b/drivers/vfio/pci/vfio_pci_core.c
> index 1daaceb5b2c8..d43745fe4c84 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -736,7 +736,6 @@ void vfio_pci_core_close_device(struct vfio_device 
> *core_vdev)
>   #endif
>          vfio_pci_core_disable(vdev);
> 
> -       core_vdev->precopy_info_v2 = 0;
>          vfio_pci_dma_buf_cleanup(vdev);
> 
>          mutex_lock(&vdev->igate);
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index dcb879018f27..8666f35fb3f0 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -553,6 +553,7 @@ static void vfio_df_device_last_close(struct 
> vfio_device_file *df)
>                  vfio_df_iommufd_unbind(df);
>          else
>                  vfio_device_group_unuse_iommu(device);
> +       device->precopy_info_v2 = 0;
>          module_put(device->dev->driver->owner);
>   }
> 
> Yishai
> 
> 
> > Alex
> >   
> >>   
> >>   	mutex_lock(&vdev->igate);
> >> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> >> index 742477546b15..dcb879018f27 100644
> >> --- a/drivers/vfio/vfio_main.c
> >> +++ b/drivers/vfio/vfio_main.c
> >> @@ -964,6 +964,23 @@ vfio_ioctl_device_feature_migration_data_size(struct vfio_device *device,
> >>   	return 0;
> >>   }
> >>   
> >> +static int
> >> +vfio_ioctl_device_feature_migration_precopy_info_v2(struct vfio_device *device,
> >> +						    u32 flags, size_t argsz)
> >> +{
> >> +	int ret;
> >> +
> >> +	if (!(device->migration_flags & VFIO_MIGRATION_PRE_COPY))
> >> +		return -EINVAL;
> >> +
> >> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, 0);
> >> +	if (ret != 1)
> >> +		return ret;
> >> +
> >> +	device->precopy_info_v2 = 1;
> >> +	return 0;
> >> +}
> >> +
> >>   static int vfio_ioctl_device_feature_migration(struct vfio_device *device,
> >>   					       u32 flags, void __user *arg,
> >>   					       size_t argsz)
> >> @@ -1251,6 +1268,9 @@ static int vfio_ioctl_device_feature(struct vfio_device *device,
> >>   		return vfio_ioctl_device_feature_migration_data_size(
> >>   			device, feature.flags, arg->data,
> >>   			feature.argsz - minsz);
> >> +	case VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2:
> >> +		return vfio_ioctl_device_feature_migration_precopy_info_v2(
> >> +			device, feature.flags, feature.argsz - minsz);
> >>   	default:
> >>   		if (unlikely(!device->ops->device_feature))
> >>   			return -ENOTTY;
> >> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> >> index e90859956514..7c1d33283e04 100644
> >> --- a/include/linux/vfio.h
> >> +++ b/include/linux/vfio.h
> >> @@ -52,6 +52,7 @@ struct vfio_device {
> >>   	struct vfio_device_set *dev_set;
> >>   	struct list_head dev_set_list;
> >>   	unsigned int migration_flags;
> >> +	u8 precopy_info_v2;
> >>   	struct kvm *kvm;
> >>   
> >>   	/* Members below here are private, not for driver use */  
> >   
> 

