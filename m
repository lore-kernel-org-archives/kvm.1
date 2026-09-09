Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AB43451A6;
	Wed,  9 Sep 2026 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922858; cv=none; b=qq6DS0dfVGJVbSJcnVtj1acs9pBGLovKsGlTNRO+Ua5XhFt0Q+fsIrjxyjKk4/09woLDqkOjBu4xFr90BY8xYGSXTrVYiS7+7K53iyu5oiR3/DpxkrWU7KiYuXeKFDRUyoreTyN1h5JyIV+a+rGtWly8rxUBs6ytzjPX223xc60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922858; c=relaxed/simple;
	bh=IniTHKgJF+PdPyvfkLSfxkdu74+9/FyzhUudHP9aLKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEKaHX8QUP+oWX15IkoRNcpn9bv8YEN2d4aTuKCotDcIM3enQhdH9+ARFeTZdcn+gM0sbUkg/U2JMhuHbYgel8sxmLTVq9X7y2mknb/Z51ofXVltRXN33UfldiZCJ1LHuPBB9aa1tAkPnK6By6zaO3CAuUDu2347oZ9ADqVo3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=efJYS7ww; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I9kMiBV9; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="efJYS7ww";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I9kMiBV9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 727D21D000BC;
	Tue,  8 Sep 2026 23:00:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 08 Sep 2026 23:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788922850;
	 x=1789009250; bh=D+BZO96VXQc4mcrTxfMW5zqyl9vnXNmoRoLNhpV9O5c=; b=
	efJYS7wwAg1yNQxXQ8MdMS32di16eljJdLQFnDRnXtudNcflnOMFK8KcwvZd6V2G
	drJDk/WYTDFQtKkmCS4FCcanWoV8w2CrIRQOkSrjbK7ok6c8at9La9MRQM0hG3Cq
	eSgeXXf2atBIN3/xUJNNdXZCFtgGzdguvfpbjEHWUmqlF4om6hYXE5cuPdN6C1Cl
	1Xk/CHWhjwDs/p5rZ8iZq9s0aPqzWvoEOnNGAVofkLQRYulhJ9P5rd/+jJ6mkMra
	Ep84g1qkMend3YpzFv20Px4raZxBcK5gf/bUBaflvlLxKvrTQCm5AfTBGrFbKzs5
	78/E6YEjFjwhwcxoMQ31qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788922850; x=
	1789009250; bh=D+BZO96VXQc4mcrTxfMW5zqyl9vnXNmoRoLNhpV9O5c=; b=I
	9kMiBV9FQelUk2cOi8osi32A1nWY2Vu71mWL+vBeKOyp15xvmDZtGT8BmDZ0KZTQ
	T+UMriOtsTX3hzcKmOVzEsLvlVctLF4X/osGc66NB8qeKwASidl9SdyFO7iPMecA
	RAnjuUPnr+em6jRDSRyDCAnUz4AvGuypvhJ1p0mcgzQbaWkC50Edc7LBhZNBunwP
	ujGoAxihMFFUvppqOnlYO9uGbA49XGJSJqsCU9Ka5ituAehWIGArchJiVNX9Ew3S
	7tdW4pY21k5qG/8xK19ih5T6VEKcGBYA9QR+aPw09aj74mSAPWGHHP943YWOkdn/
	lICCyblh78eo3IK1/NH1Q==
X-ME-Sender: <xms:4cugaiy9nW1Jzcewu8ugnSvVCmhvZG6rb9W0azVEMv_qtIgy5cBfyg>
    <xme:4cugagm4qI36cdI3FhIW1-uekj4oOhysSrzifzG7DVVLotuvlYJ0C-i88d6HuQqzH
    vrmr8VvYKEBtqS6aw001l5MCAghOmV93lBkQJKq-FCT6TJHzIQLJLBN>
X-ME-Received: <xmr:4cugajDPTXmfOJYPSHKn6YyyTntxNCyJN3O8RwDiagKXI1knb85RBeSiLnXzLA>
X-ME-Proxy-Cause: dmFkZTErtGPGJLJyrnX820yDvt5y2ctmG9Wx57Kw6pfWxLYjkRU3wVDuQ4EyBDyj1Lp7uU
    yt52n2RqmLt4dGwWqpPNASVm1cSeAR/qLBbDdl74WbmELHyCJovN7PK/qCcyIBjH2vFpuP
    Qt7M781wReerfBokqR7/U3GJBLr1w0wHs0oJ0PzPGjWPgsHBKtpyW0xiP9RPmOha0M8RN7
    hRMAPZ6J39WzlAU3T33+4DsDPPxEuFcK8SaI1P30Rys9Bc6HSzDhkKcNuDLaplKiYpkvzs
    sjPqPsYpYIhhdXVtBh/WVAgUCwDq9OmrzGKnOnJlyQi+SaDW+c27S6EYIKtFVlzkau3wKx
    2kxGnmgobePjupi81fm04GGexR/BhL6Y6z7lGIl2lmvDJ8BVPNeYonkzPPAWUFtzwR14p4
    ajaZ3x8YS1rJy27vNKMtUHReASlhWXOTGUA94oDlRWNRtGf4k2wWRQghA7qTVzzw8pXNnY
    AWHF+xoBUeCKx1DcIrCUc87ezOHdlCxADlvHUd8eYUfUtZls46X60jwGLU/3rJJGjfuGxH
    8YLasLM+aPU/1fPuSxnewygvEUurRbayI8OAKv21hwBqx7Vgis77zG05Aec/ETiPHd0VoE
    LiQpBUu5zmfQfk9vJbc5EMeXRHbg0V2QFuoq3S1TVrQWOv8148wl3y+3pkGg
X-ME-Proxy: <xmx:4cugaldts6ehyMsJ9vuSarWFFWuBrZFZ9ujaeoDVsz7-Lu6iOuRfRQ>
    <xmx:4cugahrVZnezkmRx7TwNJY9RiuXhtclxnjLlrLtR_vouvbCBiIUhAg>
    <xmx:4cugahLIBWrl525dQG6NwKTPJZ4ZiukuBxD-XTq0Tg1qAExwxduP1Q>
    <xmx:4cugaqRxQ23N57aRTi1eG87e-ctIkhxpfizfFromyfFB3wPWw-fL9Q>
    <xmx:4sugakpKNGfEvkLVsWBkyN7k8ibuSKbQ3z9rGUlbLkgBrJjjrYD2UPuW>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 23:00:47 -0400 (EDT)
Date: Tue, 8 Sep 2026 21:00:44 -0600
From: Alex Williamson <alex@shazbot.org>
To: Zhi Wang <zhiw@nvidia.com>
Cc: <dakr@kernel.org>, <acourbot@nvidia.com>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <zhiwang@kernel.org>, <kvm@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO
 variant driver
Message-ID: <20260908210044.6514a092@shazbot.org>
In-Reply-To: <20260905081116.106613-13-zhiw@nvidia.com>
References: <20260905081116.106613-1-zhiw@nvidia.com>
	<20260905081116.106613-13-zhiw@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Sep 2026 11:11:15 +0300
Zhi Wang <zhiw@nvidia.com> wrote:

> NVIDIA vGPU VFs require their open, reset, and close lifecycle to be
> coordinated with the PF-side nova-core driver.
> 
> Add a VFIO PCI variant driver that binds NVIDIA devices only through
> driver_override and rejects non-VFs. Delegate instance lifecycle
> operations to nova-core, present the firmware-selected device and
> subsystem IDs in configuration-space reads, and adjust the reported BAR1
> aperture to the assigned profile. Use vfio-pci-core for the remaining
> VFIO operations.
> 
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/vfio/pci/Kconfig              |   2 +
>  drivers/vfio/pci/Makefile             |   2 +
>  drivers/vfio/pci/nvidia-vgpu/Kconfig  |  16 ++
>  drivers/vfio/pci/nvidia-vgpu/Makefile |   2 +
>  drivers/vfio/pci/nvidia-vgpu/main.c   | 253 ++++++++++++++++++++++++++
>  5 files changed, 275 insertions(+)
>  create mode 100644 drivers/vfio/pci/nvidia-vgpu/Kconfig
>  create mode 100644 drivers/vfio/pci/nvidia-vgpu/Makefile
>  create mode 100644 drivers/vfio/pci/nvidia-vgpu/main.c
> 
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 296bf01e185e..b48d8d1af42a 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -74,4 +74,6 @@ source "drivers/vfio/pci/qat/Kconfig"
>  
>  source "drivers/vfio/pci/xe/Kconfig"
>  
> +source "drivers/vfio/pci/nvidia-vgpu/Kconfig"
> +
>  endmenu
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index 6138f1bf241d..f3498e541555 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -24,3 +24,5 @@ obj-$(CONFIG_NVGRACE_GPU_VFIO_PCI) += nvgrace-gpu/
>  obj-$(CONFIG_QAT_VFIO_PCI) += qat/
>  
>  obj-$(CONFIG_XE_VFIO_PCI) += xe/
> +
> +obj-$(CONFIG_NVIDIA_VGPU_VFIO_PCI) += nvidia-vgpu/
> diff --git a/drivers/vfio/pci/nvidia-vgpu/Kconfig b/drivers/vfio/pci/nvidia-vgpu/Kconfig
> new file mode 100644
> index 000000000000..098822d32380
> --- /dev/null
> +++ b/drivers/vfio/pci/nvidia-vgpu/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config NVIDIA_VGPU_VFIO_PCI
> +	tristate "VFIO support for the NVIDIA vGPU"
> +	depends on NOVA_CORE && PCI_IOV
> +	select VFIO_PCI_CORE
> +	help
> +	  This option enables VFIO (Virtual Function I/O) support for
> +	  NVIDIA virtual GPUs (vGPU). It allows the assignment of a virtual
> +	  GPU instance to userspace applications via VFIO, typically used
> +	  with hypervisors such as KVM and device emulators like QEMU.
> +
> +	  The NVIDIA vGPU allows a physical GPU to be partitioned into
> +	  multiple virtual GPUs, each of which can be passed to a virtual
> +	  machine as a PCI device using the standard VFIO infrastructure.
> +
> +	  If you don't know what to do here, say N.
> diff --git a/drivers/vfio/pci/nvidia-vgpu/Makefile b/drivers/vfio/pci/nvidia-vgpu/Makefile
> new file mode 100644
> index 000000000000..193cc801a081
> --- /dev/null
> +++ b/drivers/vfio/pci/nvidia-vgpu/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_NVIDIA_VGPU_VFIO_PCI) += nvidia-vgpu-vfio-pci.o
> +nvidia-vgpu-vfio-pci-y := main.o
> diff --git a/drivers/vfio/pci/nvidia-vgpu/main.c b/drivers/vfio/pci/nvidia-vgpu/main.c
> new file mode 100644
> index 000000000000..d8626644f952
> --- /dev/null
> +++ b/drivers/vfio/pci/nvidia-vgpu/main.c
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/module.h>
> +#include <linux/overflow.h>
> +#include <linux/pci.h>
> +#include <linux/pid.h>
> +#include <linux/vfio_pci_core.h>
> +#include <drm/nvidia_vgpu.h>
> +
> +static int nvidia_vgpu_fb_bar_index(struct pci_dev *pdev)
> +{
> +	if (pci_resource_flags(pdev, 0) & IORESOURCE_MEM_64)
> +		return 2;
> +	return 1;
> +}
> +
> +struct nvidia_vgpu_pci_core_device {
> +	struct vfio_pci_core_device core_device;
> +	struct nvidia_vgpu_type_info type_info;
> +	unsigned int gfid;
> +};
> +

This is more commonly called an "sbdf".  Also, consider some comments.

> +static inline unsigned int nvidia_vgpu_vf_dbdf(struct pci_dev *vf)
> +{
> +	return ((u32)pci_domain_nr(vf->bus) << 16) | pci_dev_id(vf);
> +}
> +
> +static int nvidia_vgpu_open_device(struct vfio_device *core_vdev)
> +{
> +	struct nvidia_vgpu_pci_core_device *nvdev = container_of(
> +		core_vdev, struct nvidia_vgpu_pci_core_device, core_device.vdev);
> +	struct pci_dev *vf = to_pci_dev(core_vdev->dev);
> +	struct nvidia_vgpu_type_info type_info;
> +	int ret;
> +
> +	if (!vf->is_virtfn)
> +		return -ENODEV;

This is redundant to the probe check.

> +
> +	ret = vfio_pci_core_enable(&nvdev->core_device);
> +	if (ret)
> +		return ret;
> +
> +	ret = nvidia_vgpu_open(pci_physfn(vf), nvdev->gfid,
> +			       nvidia_vgpu_vf_dbdf(vf), task_tgid_nr(current),
> +			       &type_info);
> +	if (ret) {
> +		vfio_pci_core_disable(&nvdev->core_device);
> +		return ret;
> +	}
> +
> +	nvdev->type_info = type_info;
> +	pci_dbg(vf, "vgpu open: dev_id=0x%x subsys_id=0x%x bar1_length=0x%llx\n",
> +		type_info.pci_dev_id, type_info.pci_subsys_id,
> +		type_info.bar1_length);
> +	vfio_pci_core_finish_enable(&nvdev->core_device);
> +	return 0;
> +}
> +
> +static void nvidia_vgpu_close_device(struct vfio_device *core_vdev)
> +{
> +	struct nvidia_vgpu_pci_core_device *nvdev = container_of(
> +		core_vdev, struct nvidia_vgpu_pci_core_device, core_device.vdev);
> +	struct pci_dev *vf = to_pci_dev(core_vdev->dev);
> +
> +	nvidia_vgpu_close(pci_physfn(vf), nvdev->gfid);
> +	vfio_pci_core_close_device(core_vdev);
> +}
> +
> +static ssize_t nvidia_vgpu_pci_read_config(struct vfio_device *core_vdev,
> +					   char __user *buf, size_t count,
> +					   loff_t *ppos)
> +{
> +	struct nvidia_vgpu_pci_core_device *nvdev = container_of(
> +		core_vdev, struct nvidia_vgpu_pci_core_device, core_device.vdev);
> +	struct nvidia_vgpu_type_info *ti = &nvdev->type_info;
> +	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
> +	size_t register_offset;
> +	loff_t copy_offset;
> +	size_t copy_count;
> +	__le16 val16;
> +	int ret;
> +
> +	ret = vfio_pci_core_read(core_vdev, buf, count, ppos);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (vfio_pci_core_range_intersect_range(pos, count, PCI_DEVICE_ID,
> +						sizeof(val16), &copy_offset,
> +						&copy_count, &register_offset)) {
> +		val16 = cpu_to_le16(ti->pci_dev_id);
> +		if (copy_to_user(buf + copy_offset,
> +				 (void *)&val16 + register_offset, copy_count))
> +			return -EFAULT;
> +	}

Just stuff the device ID into vconfig, it's already read from there.

> +
> +	if (vfio_pci_core_range_intersect_range(pos, count, PCI_SUBSYSTEM_ID,
> +						sizeof(val16), &copy_offset,
> +						&copy_count, &register_offset)) {
> +		val16 = cpu_to_le16(ti->pci_subsys_id);
> +		if (copy_to_user(buf + copy_offset,
> +				 (void *)&val16 + register_offset, copy_count))
> +			return -EFAULT;
> +	}

There's possibly an argument to be made that subsystem ID could be read
from vconfig by default too so it could be pre-filled after
vfio_config_init(), ie. after vfio_pci_core_enable().  The only reason
it might change would be if firmware was updated, but a firmware update
through vfio that changes the subsystem ID would be pretty sketchy
already.

> +
> +	return count;
> +}
> +
> +static ssize_t nvidia_vgpu_pci_read(struct vfio_device *core_vdev,
> +				    char __user *buf, size_t count,
> +				    loff_t *ppos)
> +{
> +	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
> +
> +	if (index == VFIO_PCI_CONFIG_REGION_INDEX)
> +		return nvidia_vgpu_pci_read_config(core_vdev, buf, count, ppos);
> +
> +	return vfio_pci_core_read(core_vdev, buf, count, ppos);
> +}
> +
> +static int nvidia_vgpu_bar1_size(struct nvidia_vgpu_pci_core_device *nvdev,
> +				 u64 *size)
> +{
> +	if (check_shl_overflow(nvdev->type_info.bar1_length, 20, size))
> +		return -EOVERFLOW;
> +
> +	return 0;
> +}
> +
> +static int nvidia_vgpu_get_region_info(struct vfio_device *core_vdev,
> +				       struct vfio_region_info *info,
> +				       struct vfio_info_cap *caps)
> +{
> +	int ret;
> +
> +	ret = vfio_pci_ioctl_get_region_info(core_vdev, info, caps);
> +	if (ret)
> +		return ret;
> +
> +	if (info->index == nvidia_vgpu_fb_bar_index(
> +		to_pci_dev(core_vdev->dev)) && info->size) {
> +		struct nvidia_vgpu_pci_core_device *nvdev = container_of(
> +			core_vdev, struct nvidia_vgpu_pci_core_device,
> +			core_device.vdev);
> +		u64 vgpu_bar1;
> +
> +		ret = nvidia_vgpu_bar1_size(nvdev, &vgpu_bar1);
> +		if (ret)
> +			return ret;
> +
> +		if (vgpu_bar1 && vgpu_bar1 < info->size)
> +			info->size = vgpu_bar1;
> +	}

So we're changing the reported BAR1 size, but just trusting that
userspace honors that size for read/write/mmap?  Again, consider some
comments.

> +
> +	return 0;
> +}
> +
> +static long nvidia_vgpu_pci_ioctl(struct vfio_device *core_vdev,
> +				  unsigned int cmd, unsigned long arg)
> +{
> +	if (cmd == VFIO_DEVICE_RESET) {
> +		struct nvidia_vgpu_pci_core_device *nvdev = container_of(
> +			core_vdev, struct nvidia_vgpu_pci_core_device,
> +			core_device.vdev);
> +		struct pci_dev *vf = to_pci_dev(core_vdev->dev);
> +		int ret;
> +
> +		ret = nvidia_vgpu_reset(pci_physfn(vf), nvdev->gfid);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return vfio_pci_core_ioctl(core_vdev, cmd, arg);

What about reset invoked through FLR?  Would this be better served
through .reset_prepare and .reset_done?

> +}
> +
> +static const struct vfio_device_ops nvidia_vgpu_pci_ops = {
> +	.name		= "nvidia-vgpu-vfio-pci",
> +	.init		= vfio_pci_core_init_dev,
> +	.release	= vfio_pci_core_release_dev,
> +	.open_device	= nvidia_vgpu_open_device,
> +	.close_device	= nvidia_vgpu_close_device,
> +	.ioctl		= nvidia_vgpu_pci_ioctl,
> +	.get_region_info_caps = nvidia_vgpu_get_region_info,
> +	.device_feature	= vfio_pci_core_ioctl_feature,
> +	.read		= nvidia_vgpu_pci_read,
> +	.write		= vfio_pci_core_write,
> +	.mmap		= vfio_pci_core_mmap,
> +	.request	= vfio_pci_core_request,
> +	.match		= vfio_pci_core_match,
> +	.match_token_uuid = vfio_pci_core_match_token_uuid,
> +	.bind_iommufd	= vfio_iommufd_physical_bind,
> +	.unbind_iommufd	= vfio_iommufd_physical_unbind,
> +	.attach_ioas	= vfio_iommufd_physical_attach_ioas,
> +	.detach_ioas	= vfio_iommufd_physical_detach_ioas,
> +};
> +
> +static int nvidia_vgpu_pci_probe(struct pci_dev *pdev,
> +				 const struct pci_device_id *id)
> +{
> +	struct nvidia_vgpu_pci_core_device *nvdev;
> +	int vf_id;
> +	int ret;
> +
> +	if (!pdev->is_virtfn)
> +		return -ENODEV;

This driver needs to bind to what it matches in the id table, we don't
have a policy for userspace to pick a 2nd best variant driver.
hisi_acc handles a similar situation where only the VFs are supported
for the migration feature of the variant driver.  The PF needs to be
supported here and bind to a vfio-pci-core passthrough ops structure.

We should probably define a PCI_DRIVER_OVERRIDE_DEVICE_VFIO variant
that allows a class code to be specified so we aren't using this for
all 10de: devices.  I'm hoping that class code is for a 3D accelerator
or the like rather than VGA class (a VF can't technically support a
legacy endpoint anyway), but we need to consider what existing devices
that currently use vfio-pci would now be bound to this driver and what
module option features they might use.  Thanks,

Alex

> +
> +	vf_id = pci_iov_vf_id(pdev);
> +	if (vf_id < 0)
> +		return vf_id;
> +
> +	nvdev = vfio_alloc_device(nvidia_vgpu_pci_core_device, core_device.vdev,
> +				  &pdev->dev, &nvidia_vgpu_pci_ops);
> +	if (IS_ERR(nvdev))
> +		return PTR_ERR(nvdev);
> +
> +	nvdev->gfid = vf_id + 1;
> +	dev_set_drvdata(&pdev->dev, &nvdev->core_device);
> +	ret = vfio_pci_core_register_device(&nvdev->core_device);
> +	if (ret)
> +		goto out_put_vdev;
> +
> +	return 0;
> +
> +out_put_vdev:
> +	vfio_put_device(&nvdev->core_device.vdev);
> +	return ret;
> +}
> +
> +static void nvidia_vgpu_pci_remove(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(&pdev->dev);
> +
> +	vfio_pci_core_unregister_device(core_device);
> +	vfio_put_device(&core_device->vdev);
> +}
> +
> +static const struct pci_device_id nvidia_vgpu_pci_table[] = {
> +	/* Placeholder: match all NVIDIA VFs (vendor 0x10de) */
> +	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(pci, nvidia_vgpu_pci_table);
> +
> +static struct pci_driver nvidia_vgpu_pci_driver = {
> +	.name		= "nvidia-vgpu-vfio-pci",
> +	.id_table	= nvidia_vgpu_pci_table,
> +	.probe		= nvidia_vgpu_pci_probe,
> +	.remove		= nvidia_vgpu_pci_remove,
> +	.driver_managed_dma = true,
> +};
> +module_pci_driver(nvidia_vgpu_pci_driver);
> +
> +MODULE_DESCRIPTION("NVIDIA vGPU vfio-pci driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("NOVA_CORE_VGPU");

