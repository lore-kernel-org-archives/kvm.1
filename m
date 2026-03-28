Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B8313272
	for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774688604; cv=none; b=NLkRkMA02iiS2SLHIYQxJ4xSwGlJ6sBwm7QPXSI715IHL/1wkqmN2XAJ5D7yUcVQKL71HNymeJzAyjH5HxFH3y8/s+0DM9YsFagosVwa8kv0rRw20ZdUynaehpVr7X0NTLf78wGEV1tO7SyPAJLH3sS2iSKvkVUfZms40x/L6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774688604; c=relaxed/simple;
	bh=aStE8InAy8iA9j3tgh9S2p9HDAktGo+tefIqvikCwK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fvSIRKPnwY9I40NwO1MRXId7qAT949iXVzMr8uJxIwAR3aPx7ZAow6yvzOFkUAHlT+TCZgH76NdQDAyT+/yOgdxC3gX74ekT1enSdDhNXsbTuZ245ZZjiAswGWY65vwKeMExhQLiaaSVKYf1HyQyRYXbud4k6DReS554lZTNPI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=b/cncAwM; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="b/cncAwM"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JZyKGpntx3Qsug6tYRFmWKnkqwxS9x5bemdwabfaXVc=;
	b=b/cncAwMDSJvs47jtlwinW5Sc2uzB+unU7MIcmNzHI+rjKAKk6vT466y6UhnOEl8jUht80HaA
	pDZzqgOoW3v6Z9e+5laGNIceiVPnm6bJR4pwijrCPxzeMP9CuRneDOsXNQEm0Cldvph1rWXd8Zs
	O2UBaalqvaiGzpwpUN+odYs=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fjWbp4L5Kz1cyT2;
	Sat, 28 Mar 2026 16:57:10 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B93840562;
	Sat, 28 Mar 2026 17:03:17 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Mar 2026 17:03:16 +0800
Message-ID: <bd3ff619-5f43-472d-b4dd-68dc0f3498b2@huawei.com>
Date: Sat, 28 Mar 2026 17:03:16 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/1] vfio/pci: add PCIe TPH device ioctl
To: Wathsala Vithanage <wathsala.vithanage@arm.com>, <jgg@ziepe.ca>,
	<alex.williamson@redhat.com>, <pstanner@redhat.com>, <jeremy.linton@arm.com>
CC: <kvm@vger.kernel.org>
References: <20250916175626.698384-1-wathsala.vithanage@arm.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250916175626.698384-1-wathsala.vithanage@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Hi Wathsala,

I don't know if you will continue this feature, as I previously replied to you on the
DPDK mailing list and also on this patch v1, but I didn't receive any response from you.

If I don't get a reply, I will proceed according to my own ideas.

Thanks

PS: below has some of my opinions of this commit.

On 9/17/2025 1:56 AM, Wathsala Vithanage wrote:
> This patch introduces VFIO_DEVICE_PCI_TPH IOCTL to enable configuring of
> TPH from the user space. It provides an interface to user space drivers
> and VMMs to enable/disable TPH capability on PCIe devices and set
> steering tags in MSI-X or steering-tag table entries or read steering
> tags from the kernel to use them in device-specific mode.
> 
> Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 153 +++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h        |  83 +++++++++++++++++
>  2 files changed, 236 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 7dcf5439dedc..cc9ba6760862 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -28,6 +28,7 @@
>  #include <linux/nospec.h>
>  #include <linux/sched/mm.h>
>  #include <linux/iommufd.h>
> +#include <linux/pci-tph.h>
>  #if IS_ENABLED(CONFIG_EEH)
>  #include <asm/eeh.h>
>  #endif
> @@ -1443,6 +1444,156 @@ static int vfio_pci_ioctl_ioeventfd(struct vfio_pci_core_device *vdev,
>  				  ioeventfd.fd);
>  }
>  
> +static struct vfio_pci_tph_entry *vfio_pci_tph_get_ents(struct vfio_pci_tph *tph,
> +							void __user *tph_ents,
> +							size_t *ents_size)
> +{
> +	unsigned long minsz;
> +	size_t size;
> +
> +	if (!ents_size)
> +		return ERR_PTR(-EINVAL);
> +
> +	minsz = offsetofend(struct vfio_pci_tph, count);
> +
> +	size = tph->count * sizeof(struct vfio_pci_tph_entry);
> +
> +	if (tph->argsz - minsz < size)
> +		return ERR_PTR(-EINVAL);
> +
> +	*ents_size = size;
> +
> +	return memdup_user(tph_ents, size);

This is no need for set ops

> +}
> +
> +static int vfio_pci_tph_set_st(struct vfio_pci_core_device *vdev,
> +			       struct vfio_pci_tph_entry *ents, int count)
> +{
> +	int i, err = 0;
> +
> +	for (i = 0; i < count && !err; i++)
> +		err = pcie_tph_set_st_entry(vdev->pdev, ents[i].index,
> +					    ents[i].st);
> +
> +	return err;
> +}
> +
> +static int vfio_pci_tph_get_st(struct vfio_pci_core_device *vdev,
> +			       struct vfio_pci_tph_entry *ents, int count)
> +{
> +	int i, mtype, err = 0;
> +	u32 cpu_uid;
> +
> +	for (i = 0; i < count && !err; i++) {
> +		if (ents[i].cpu_id >= nr_cpu_ids || !cpu_present(ents[i].cpu_id)) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		cpu_uid = topology_core_id(ents[i].cpu_id);

There is no need to translate the cpu_id according [1]

[1] https://lore.kernel.org/all/20260320031737.35048-1-fengchengwen@huawei.com/

> +		mtype = (ents[i].flags & VFIO_TPH_MEM_TYPE_MASK) >>
> +			VFIO_TPH_MEM_TYPE_SHIFT;
> +
> +		/*
> +		 * ph_ignore is always set.
> +		 * TPH implementation of the PCI subsystem forces processing
> +		 * hint to bi-directional by setting PH bits to 0 when
> +		 * acquiring Steering Tags from the platform firmware. It also
> +		 * discards the ph_ignore bit returned by firmware.
> +		 */
> +		ents[i].ph_ignore = 1;
> +
> +		err = pcie_tph_get_cpu_st(vdev->pdev, mtype, cpu_uid,
> +					  &ents[i].st);
> +	}
> +
> +	return err;
> +}
> +
> +static int vfio_pci_tph_st_op(struct vfio_pci_core_device *vdev,
> +			      struct vfio_pci_tph *tph, void __user *tph_ents)
> +{
> +	int err = 0;
> +	struct vfio_pci_tph_entry *ents;
> +	size_t ents_size;
> +
> +	if (!tph->count || tph->count > VFIO_TPH_INFO_MAX) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	ents = vfio_pci_tph_get_ents(tph, tph_ents, &ents_size);
> +	if (IS_ERR(ents)) {
> +		err = PTR_ERR(ents);
> +		goto out;
> +	}
> +
> +	err = vfio_pci_tph_get_st(vdev, ents, tph->count);
> +	if (err)
> +		goto out_free_ents;
> +
> +	/*
> +	 * Set Steering tags. TPH will be disabled on the device by the PCI
> +	 * subsystem if there is an error.
> +	 */
> +	if (tph->flags & VFIO_DEVICE_TPH_SET_ST) {
> +		err = vfio_pci_tph_set_st(vdev, ents, tph->count);
> +		if (err)
> +			goto out_free_ents;
> +	}
> +
> +	if (copy_to_user(tph_ents, ents, ents_size))
> +		err = -EFAULT;
> +
> +out_free_ents:
> +	kfree(ents);
> +out:
> +	return err;
> +}
> +
> +static int vfio_pci_tph_enable(struct vfio_pci_core_device *vdev,
> +			       struct vfio_pci_tph *arg)
> +{
> +	return pcie_enable_tph(vdev->pdev, arg->flags & VFIO_TPH_ST_MODE_MASK);

How do we know the device capabilities of TPH_ST_MODE ?
How about add one ops to query device capability of TPH, including: ST mode, ST table size

> +}
> +
> +static int vfio_pci_tph_disable(struct vfio_pci_core_device *vdev)
> +{
> +	pcie_disable_tph(vdev->pdev);
> +	return 0;
> +}
> +
> +static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
> +			      void __user *uarg)
> +{
> +	u32 op;
> +	struct vfio_pci_tph tph;
> +	size_t minsz = offsetofend(struct vfio_pci_tph, count);
> +
> +	if (copy_from_user(&tph, uarg, minsz))
> +		return -EFAULT;
> +
> +	if (tph.argsz < minsz)
> +		return -EINVAL;
> +
> +	op = tph.flags & VFIO_DEVICE_TPH_OP_MASK;
> +
> +	switch (op) {
> +	case VFIO_DEVICE_TPH_ENABLE:
> +		return vfio_pci_tph_enable(vdev, &tph);
> +
> +	case VFIO_DEVICE_TPH_DISABLE:
> +		return vfio_pci_tph_disable(vdev);
> +
> +	case VFIO_DEVICE_TPH_GET_ST:
> +	case VFIO_DEVICE_TPH_SET_ST:
> +		return vfio_pci_tph_st_op(vdev, &tph, (u8 *)(uarg) + minsz);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
>  			 unsigned long arg)
>  {
> @@ -1467,6 +1618,8 @@ long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
>  		return vfio_pci_ioctl_reset(vdev, uarg);
>  	case VFIO_DEVICE_SET_IRQS:
>  		return vfio_pci_ioctl_set_irqs(vdev, uarg);
> +	case VFIO_DEVICE_PCI_TPH:
> +		return vfio_pci_ioctl_tph(vdev, uarg);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 75100bf009ba..a642a2ff21a6 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -873,6 +873,88 @@ struct vfio_device_ioeventfd {
>  
>  #define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
>  
> +/**
> + * VFIO_DEVICE_PCI_TPH	- _IO(VFIO_TYPE, VFIO_BASE + 22)
> + *
> + * This command is used to control PCIe TLP Processing Hints (TPH)
> + * capability in a PCIe device.
> + * It supports following operations on a PCIe device with respect to TPH
> + * capability.
> + *
> + * - Enabling/disabling TPH capability in a PCIe device.
> + *
> + *   Setting VFIO_DEVICE_TPH_ENABLE flag enables TPH in no-steering-tag,
> + *   interrupt-vector, or device-specific mode defined in the PCIe specficiation
> + *   when feature flags TPH_ST_NS_MODE, TPH_ST_IV_MODE, and TPH_ST_DS_MODE are
> + *   set respectively. TPH_ST_xx_MODE macros are defined in
> + *   uapi/linux/pci_regs.h.
> + *
> + *   VFIO_DEVICE_TPH_DISABLE disables PCIe TPH on the device.
> + *
> + * - Writing STs to MSI-X or ST table in a PCIe device.
> + *
> + *   VFIO_DEVICE_TPH_SET_ST flag set steering tags on a device at an index in
> + *   MSI-X or ST-table depending on the VFIO_TPH_ST_x_MODE flag used and
> + *   returns the programmed steering tag values. The caller can set one or more
> + *   steering tags by passing an array of vfio_pci_tph_entry objects containing
> + *   cpu_id, cache_level, and MSI-X/ST-table index. The caller can also set the
> + *   intended memory type and the processing hint by setting VFIO_TPH_MEM_TYPE_x
> + *   and VFIO_TPH_HINT_x flags, respectively.
> + *
> + * - Reading Steering Tags (ST) from the host platform.
> + *
> + *   VFIO_DEVICE_TPH_GET_ST flags returns steering tags to the caller. Caller
> + *   can request one or more steering tags by passing an array of
> + *   vfio_pci_tph_entry objects. Steering Tag for each request is returned via
> + *   the st field in vfio_pci_tph_entry.
> + */
> +struct vfio_pci_tph_entry {
> +	/* in */
> +	__u32 cpu_id;			/* CPU logical ID */
> +	__u32 cache_level;		/* Cache level. L1 D= 0, L2D = 2, ...*/

No need to this

> +	__u8  flags;
> +#define VFIO_TPH_MEM_TYPE_MASK		0x1
> +#define VFIO_TPH_MEM_TYPE_SHIFT		0
> +#define VFIO_TPH_MEM_TYPE_VMEM		0   /* Request volatile memory ST */
> +#define VFIO_TPH_MEM_TYPE_PMEM		1   /* Request persistent memory ST */
> +
> +#define VFIO_TPH_HINT_SHIFT		1
> +#define VFIO_TPH_HINT_MASK		(0x3 << VFIO_TPH_HINT_SHIFT)
> +#define VFIO_TPH_HINT_BIDIR		0
> +#define VFIO_TPH_HINT_REQSTR		(1 << VFIO_TPH_HINT_SHIFT)
> +#define VFIO_TPH_HINT_TARGET		(2 << VFIO_TPH_HINT_SHIFT)
> +#define VFIO_TPH_HINT_TARGET_PRIO	(3 << VFIO_TPH_HINT_SHIFT)

No need to define TPH hint

> +	__u8  pad0;
> +	__u16 index;			/* MSI-X/ST-table index to set ST */
> +	/* out */
> +	__u16 st;			/* Steering-Tag */
> +	__u8  ph_ignore;		/* Platform ignored the Processing */

This ignore is always one, why not add one U32 reserved for future extend

> +	__u8  pad1;
> +};

This struct is used when get and set ops, suggest split them to two struct.

> +
> +struct vfio_pci_tph {
> +	__u32 argsz;			/* Size of vfio_pci_tph and ents[] */
> +	__u32 flags;
> +#define VFIO_TPH_ST_MODE_MASK		0x7
> +
> +#define VFIO_DEVICE_TPH_OP_SHIFT	3
> +#define VFIO_DEVICE_TPH_OP_MASK		(0x7 << VFIO_DEVICE_TPH_OP_SHIFT)
> +/* Enable TPH on device */
> +#define VFIO_DEVICE_TPH_ENABLE		0
> +/* Disable TPH on device */
> +#define VFIO_DEVICE_TPH_DISABLE		(1 << VFIO_DEVICE_TPH_OP_SHIFT)
> +/* Get steering-tags */
> +#define VFIO_DEVICE_TPH_GET_ST		(2 << VFIO_DEVICE_TPH_OP_SHIFT)
> +/* Set steering-tags */
> +#define VFIO_DEVICE_TPH_SET_ST		(4 << VFIO_DEVICE_TPH_OP_SHIFT)
> +	__u32 count;			/* Number of entries in ents[] */
> +	struct vfio_pci_tph_entry ents[];
> +#define VFIO_TPH_INFO_MAX	2048	/* Max entries in ents[] */
> +};
> +
> +#define VFIO_DEVICE_PCI_TPH	_IO(VFIO_TYPE, VFIO_BASE + 22)
> +
> +
>  /**
>   * VFIO_DEVICE_FEATURE - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
>   *			       struct vfio_device_feature)
> @@ -1478,6 +1560,7 @@ struct vfio_device_feature_bus_master {
>  };
>  #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
>  
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**

