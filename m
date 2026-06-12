Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025F23CFF51;
	Fri, 12 Jun 2026 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245531; cv=none; b=eS8JzB9v7mDmd026u4TWu/vQZBZgaTskNZYdWTXifcIHqBXyUHiRE/I6IzYJ3shqnMGPXWoKWrTIYKf27Jyb1Haf626hkEbGnyzSkzDwAy4T24+F4OwRUpymDvw22NCNHb9IkctK/lUCn/ePyx4fLAj5FJZKv1nDSuP2Uz6B8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245531; c=relaxed/simple;
	bh=KJrpe5variJauzUvAiSp1Xl7CRP8fQ4ZNdPjejc7H0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHHuJF5q4VYcOFHdgPjysINP1qxEQV7Taafax17LKuE1iyTPdb7zZdvctqQlUB9ws40bf47Zi3FtuWek+Rwgh+CCTgDXuVDCqN4Ye+WHIlVxndR/OflgF2ZhoGuTqUPjsdPMN8Q44+cg3sjt8myjX9csEuFxYaT/5CEFiImegY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JflxzjpX; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JflxzjpX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781245518; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7hM7ZOjBdBygnqZJzPlimjtCHOES1wSzElDhatvFoOc=;
	b=JflxzjpXNCc9nQTuE6pFd+a9vAVsqxA51yScS7XBt0kz8zBE7dFRz3hkwo7GmrFxli1dZUKzE50zrT5c9rc/FL+BcQu2BSlR0jCD1+dj9SM4FsrHEooCgTFcAswk1RRWgJM9hp36iGYMZAeN8TI3NIjNodIK0i4uPsQ7VNNT9dQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X4gk6dp_1781245517;
Received: from 30.178.80.217(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X4gk6dp_1781245517 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Jun 2026 14:25:18 +0800
Message-ID: <6d737961-1276-42e2-bb74-510d0f041040@linux.alibaba.com>
Date: Fri, 12 Jun 2026 14:25:16 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] vfio/pci: Latch all module parameters per device
To: Alex Williamson <alex.williamson@nvidia.com>, kvm <kvm@vger.kernel.org>,
 Alex Williamson <alex@shazbot.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
References: <20260611213539.4100590-1-alex.williamson@nvidia.com>
 <20260611213539.4100590-6-alex.williamson@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260611213539.4100590-6-alex.williamson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alex,

In many cases, when users modify a module parameter, they expect
the change to take effect immediately, but that's not at all what
happens here. So I think on the one hand, we should make the module
parameter read-only; on the other hand, we could also expose this
information in the PCI core device's sysfs directory — read-only as well 
for now,
or perhaps there's an even better approach?

Best Regards,
Guixin Liu



在 2026/6/12 05:35, Alex Williamson 写道:
> The vfio-pci module parameters of disable_idle_d3, nointxmask, and
> disable_vga latch vfio-pci policy into vfio-pci-core globals each time
> the vfio-pci module is initialized.  The disable_idle_d3 parameter has
> already migrated to a per-device flag in order to provide consistency
> for refcounted PM operations for the lifetime of the device
> registration.
>
> Pull the remaining vfio-pci module-parameter policy out of vfio-pci-core
> into per-device flags set at device initialization.
>
> This also restores the mutable aspect of the disable_idle_d3 and
> nointxmask module parameters for vfio-pci, with the caveat that the
> parameters are latched into the device at probe.
>
> A notable change for variant drivers is that their devices are no longer
> affected by vfio-pci module parameters and those drivers may need to
> adopt similar module parameters if any devices have a hidden dependency
> on vfio-pci setting non-default policy.
>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
> ---
>   drivers/vfio/pci/vfio_pci.c      | 30 ++++++++++++++++++++++--------
>   drivers/vfio/pci/vfio_pci_core.c | 26 ++++++--------------------
>   include/linux/vfio_pci_core.h    |  4 ++--
>   3 files changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 0c771064c0b8..830369ff878d 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -125,9 +125,30 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
>   	return 0;
>   }
>   
> +static int vfio_pci_init_dev(struct vfio_device *core_vdev)
> +{
> +	struct vfio_pci_core_device *vdev =
> +		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> +
> +	/*
> +	 * These behaviors originated in vfio-pci and moved into
> +	 * vfio-pci-core when the driver was split; vfio-pci remains the
> +	 * only driver that toggles them.  Latch our module parameters per
> +	 * device at init time so that later parameter changes do not
> +	 * affect already-initialized devices.
> +	 */
> +	vdev->nointxmask = nointxmask;
> +	vdev->disable_idle_d3 = disable_idle_d3;
> +#ifdef CONFIG_VFIO_PCI_VGA
> +	vdev->disable_vga = disable_vga;
> +#endif
> +
> +	return vfio_pci_core_init_dev(core_vdev);
> +}
> +
>   static const struct vfio_device_ops vfio_pci_ops = {
>   	.name		= "vfio-pci",
> -	.init		= vfio_pci_core_init_dev,
> +	.init		= vfio_pci_init_dev,
>   	.release	= vfio_pci_core_release_dev,
>   	.open_device	= vfio_pci_open_device,
>   	.close_device	= vfio_pci_core_close_device,
> @@ -256,13 +277,6 @@ static void __init vfio_pci_fill_ids(void)
>   static int __init vfio_pci_init(void)
>   {
>   	int ret;
> -	bool is_disable_vga = true;
> -
> -#ifdef CONFIG_VFIO_PCI_VGA
> -	is_disable_vga = disable_vga;
> -#endif
> -
> -	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3);
>   
>   	/* Register and scan for devices */
>   	ret = pci_register_driver(&vfio_pci_driver);
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index d2d3fddec610..76725c0e7dda 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -38,10 +38,6 @@
>   #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
>   #define DRIVER_DESC "core driver for VFIO based PCI devices"
>   
> -static bool nointxmask;
> -static bool disable_vga;
> -static bool disable_idle_d3;
> -
>   static void vfio_pci_eventfd_rcu_free(struct rcu_head *rcu)
>   {
>   	struct vfio_pci_eventfd *eventfd =
> @@ -92,10 +88,10 @@ struct vfio_pci_vf_token {
>   	int			users;
>   };
>   
> -static inline bool vfio_vga_disabled(void)
> +static inline bool vfio_vga_disabled(struct vfio_pci_core_device *vdev)
>   {
>   #ifdef CONFIG_VFIO_PCI_VGA
> -	return disable_vga;
> +	return vdev->disable_vga;
>   #else
>   	return true;
>   #endif
> @@ -111,11 +107,12 @@ static inline bool vfio_vga_disabled(void)
>    */
>   static unsigned int vfio_pci_set_decode(struct pci_dev *pdev, bool single_vga)
>   {
> +	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
>   	struct pci_dev *tmp = NULL;
>   	unsigned char max_busnr;
>   	unsigned int decodes;
>   
> -	if (single_vga || !vfio_vga_disabled() || pci_is_root_bus(pdev->bus))
> +	if (single_vga || !vfio_vga_disabled(vdev) || pci_is_root_bus(pdev->bus))
>   		return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM |
>   		       VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM;
>   
> @@ -562,7 +559,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>   	if (!vdev->pci_saved_state)
>   		pci_dbg(pdev, "%s: Couldn't store saved state\n", __func__);
>   
> -	if (likely(!nointxmask)) {
> +	if (likely(!vdev->nointxmask)) {
>   		if (vfio_pci_nointx(pdev)) {
>   			pci_info(pdev, "Masking broken INTx support\n");
>   			vdev->nointx = true;
> @@ -602,7 +599,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>   		vdev->has_dyn_msix = false;
>   	}
>   
> -	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
> +	if (!vfio_vga_disabled(vdev) && vfio_pci_is_vga(pdev))
>   		vdev->has_vga = true;
>   
>   	vfio_pci_core_map_bars(vdev);
> @@ -2144,8 +2141,6 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>   	init_rwsem(&vdev->memory_lock);
>   	xa_init(&vdev->ctx);
>   
> -	vdev->disable_idle_d3 = disable_idle_d3;
> -
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
> @@ -2625,15 +2620,6 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
>   	}
>   }
>   
> -void vfio_pci_core_set_params(bool is_nointxmask, bool is_disable_vga,
> -			      bool is_disable_idle_d3)
> -{
> -	nointxmask = is_nointxmask;
> -	disable_vga = is_disable_vga;
> -	disable_idle_d3 = is_disable_idle_d3;
> -}
> -EXPORT_SYMBOL_GPL(vfio_pci_core_set_params);
> -
>   static void vfio_pci_core_cleanup(void)
>   {
>   	vfio_pci_uninit_perm_bits();
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 985b8af5a04b..9a1674c152aa 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -127,6 +127,8 @@ struct vfio_pci_core_device {
>   	bool			nointx:1;
>   	bool			needs_pm_restore:1;
>   	bool			disable_idle_d3:1;
> +	bool			nointxmask:1;
> +	bool			disable_vga:1;
>   	/* Flags modified at runtime - dedicated storage unit */
>   	bool			needs_reset;
>   	bool			pm_intx_masked;
> @@ -161,8 +163,6 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
>   				      unsigned int type, unsigned int subtype,
>   				      const struct vfio_pci_regops *ops,
>   				      size_t size, u32 flags, void *data);
> -void vfio_pci_core_set_params(bool nointxmask, bool is_disable_vga,
> -			      bool is_disable_idle_d3);
>   void vfio_pci_core_close_device(struct vfio_device *core_vdev);
>   int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
>   void vfio_pci_core_release_dev(struct vfio_device *core_vdev);

