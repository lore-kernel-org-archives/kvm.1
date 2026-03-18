Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F924503F
	for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871423; cv=none; b=D1bmg6ZdQ3Y22JDTEuLJGeWeRLNqDl5o5XhFHmPwg6m6LtftMxoYC2WK2ExS+43EG4xPDVcTKemCCPm7sSZdkF5G+DY2mq2lD7F9j19lQvKpCRa/Xrtp6ORbbrfxZAkjUTB+FlDPYoJr6Cfn2A+TyI9YFmHDShpajGnvHr3gKN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871423; c=relaxed/simple;
	bh=QO4CLlWEkYJftceDg2ByBg3c8ml0CW81bU5uzvYPTUU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLL5bLD62ZQGqEsSXJuDaSe9vAhwxfFcYuZ4EBOKf/SdIytFcao9QXuhABBfqSvI9wsw8PPHTh81RDn2J4LzR882/ex/fsdeFyNVz+hFp1jTxc9LH9NupzQYkV4EVN5e7VRI9oNV2DSTfxzXLJzx5wSjU6IGnrs+2B7/xX4a6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=N14XxRJU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1fHot1oL; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="N14XxRJU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1fHot1oL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2272D1400066;
	Wed, 18 Mar 2026 18:03:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 18 Mar 2026 18:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773871420;
	 x=1773957820; bh=7sUgt6OCcErc8cc8mhH+GJeeaUIWCvnayj190e/jYQA=; b=
	N14XxRJUPEc5Y2nBfUVe3DA/9+VUtss2VOtwAgrXeegLLyU8+xg9FNfc32eZgMb6
	wDavzQulAo2Ge2HeHOilnPyj5gSCZtdnHELFkRlbrrwzzOiWnI0WlUEtdPhI6rXb
	RURK99Gc/NQknztf5fxzwvaWhx2VszpPQKmKvRKCdsP9Q7wtq1ix2WuKELzeKbzg
	vXPnQmhdyAAyuzYIkLEgh/iXG4oaCNxtG8LANKS736ATP8YncGRYFG8LnZZyLNdk
	y2ZCJaI3dSlpgIDXmGFS1Ku46ypy5G1mUpZMdgHEn3IF3SCrXmIwr6OysfsSOSLa
	4AI0NLTVTPD0jtO37u0YnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773871420; x=
	1773957820; bh=7sUgt6OCcErc8cc8mhH+GJeeaUIWCvnayj190e/jYQA=; b=1
	fHot1oLvgcQAVs9ZjliRATLO2HphaZxfkL0kFic9yUB2rzyNI8Eao1wWho3nOZVY
	y23MUqUFp+83y29DWeDGEqndfL6ApPP5BasNiy4lTV1lPIfhAb96MALkaF26yTH2
	rC3qJDHTRPw7v/7+Yif71r4nmTJgmoVZQSCT1viI14vGjOit+pwcJJqfT+XM/tCC
	r3uQHQ9VEDWPKe+NikWkM0IQJxWzDuKeP3//Vmdn7AH6B+KgJwsuaQemF5kubacc
	VqzTtMbuzCfjE4sJAlZivnMjywMgC5FO48YHSVRScoyR6Pbbn9sLrQxSw5XzIr2O
	FQVBfTlf3yEDZU0huPN8w==
X-ME-Sender: <xms:OyG7afBIGK46n2BkaHpUTiK4BRYMMbmeSkKRLVT8LKq-nysJtkqdiw>
    <xme:OyG7aZOh5OwR2MF_FXYKr6qpYG6D3NBSNX_EZAJ2huO-2P0R5y7_bTjE1p6MA7Xb-
    Hb7yYZO7jZFVZkNrqM_9kPrc3mKQ7nWgj7tBxuHNaERkm1wER3ce1M>
X-ME-Received: <xmr:OyG7aTMrfnvmvn0sXSxqxcAfhe7DMHfRMG0oBAwENAf7b80rtdHV7FsEoQM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehvdekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:OyG7aTJ-DC1pqaF1CVhI7Lh_Elg4M-LUMJUOIK0KbhcNYu10-h9u_g>
    <xmx:OyG7aVovNTl3kkM86pOyDIdgYcnzqEJZYWD9aPmqUHeoBhq8NqqHvg>
    <xmx:OyG7aXNERnUHAmTPwrhECVJP5BHIZxsa0JJ-kEKsSjKDuEuVSXbMFQ>
    <xmx:OyG7aWgK6sbr4lj9IeLmgAd-XapeXl3_lPVQFqj-LJFnV80GOJ5SDg>
    <xmx:PCG7aXJBm69tjjNvjp8N5uKSgpJw7z_1mPW1sWGe2WTVOblcR1uWc3vx>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 18:03:38 -0400 (EDT)
Date: Wed, 18 Mar 2026 16:03:37 -0600
From: Alex Williamson <alex@shazbot.org>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: <jgg@nvidia.com>, <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
 <joao.m.martins@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>,
 <avihaih@nvidia.com>, <clg@redhat.com>, <peterx@redhat.com>,
 <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
 <kwankhede@nvidia.com>, alex@shazbot.org
Subject: Re: [PATCH V2 vfio 2/6] vfio: Add support for
 VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2
Message-ID: <20260318160337.1fa2b3d8@shazbot.org>
In-Reply-To: <20260317161753.18964-3-yishaih@nvidia.com>
References: <20260317161753.18964-1-yishaih@nvidia.com>
	<20260317161753.18964-3-yishaih@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 18:17:49 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> Currently, existing VFIO_MIG_GET_PRECOPY_INFO implementations don't
> assign info.flags before copy_to_user().
> 
> Because they copy the struct in from userspace first, this effectively
> echoes userspace-provided flags back as output, preventing the field
> from being used to report new reliable data from the drivers.
> 
> Add support for a new device feature named
> VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2.
> 
> On SET, enables the v2 pre_copy_info behaviour, where the
> vfio_precopy_info.flags is a valid output field.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c |  1 +
>  drivers/vfio/vfio_main.c         | 20 ++++++++++++++++++++
>  include/linux/vfio.h             |  1 +
>  3 files changed, 22 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index d43745fe4c84..1daaceb5b2c8 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -736,6 +736,7 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
>  #endif
>  	vfio_pci_core_disable(vdev);
>  
> +	core_vdev->precopy_info_v2 = 0;
>  	vfio_pci_dma_buf_cleanup(vdev);

There's a minor discrepancy here, enabling precopy_info_v2 is a core
vfio feature, but clearing the previous user's opt-in is only
implemented in the core helper for vfio-pci and associated variant
drivers.  This should be moved to vfio_df_device_last_close() to be
common.  A follow-up fix rather than a v3 is fine if you agree.  Thanks,

Alex

>  
>  	mutex_lock(&vdev->igate);
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 742477546b15..dcb879018f27 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -964,6 +964,23 @@ vfio_ioctl_device_feature_migration_data_size(struct vfio_device *device,
>  	return 0;
>  }
>  
> +static int
> +vfio_ioctl_device_feature_migration_precopy_info_v2(struct vfio_device *device,
> +						    u32 flags, size_t argsz)
> +{
> +	int ret;
> +
> +	if (!(device->migration_flags & VFIO_MIGRATION_PRE_COPY))
> +		return -EINVAL;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, 0);
> +	if (ret != 1)
> +		return ret;
> +
> +	device->precopy_info_v2 = 1;
> +	return 0;
> +}
> +
>  static int vfio_ioctl_device_feature_migration(struct vfio_device *device,
>  					       u32 flags, void __user *arg,
>  					       size_t argsz)
> @@ -1251,6 +1268,9 @@ static int vfio_ioctl_device_feature(struct vfio_device *device,
>  		return vfio_ioctl_device_feature_migration_data_size(
>  			device, feature.flags, arg->data,
>  			feature.argsz - minsz);
> +	case VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2:
> +		return vfio_ioctl_device_feature_migration_precopy_info_v2(
> +			device, feature.flags, feature.argsz - minsz);
>  	default:
>  		if (unlikely(!device->ops->device_feature))
>  			return -ENOTTY;
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index e90859956514..7c1d33283e04 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -52,6 +52,7 @@ struct vfio_device {
>  	struct vfio_device_set *dev_set;
>  	struct list_head dev_set_list;
>  	unsigned int migration_flags;
> +	u8 precopy_info_v2;
>  	struct kvm *kvm;
>  
>  	/* Members below here are private, not for driver use */

