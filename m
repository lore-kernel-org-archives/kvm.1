Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C955362152;
	Fri, 12 Jun 2026 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253645; cv=none; b=T6LbTO9tHc4NhypC0tOkwJPvsxcpg3mCZ7Z1o9eBPTRkKp+orhEoXWww84M9EhUOGWTHNB+47WE2j456rrqD9VAYISaYNPs/X91xJyjKqpvljvBR7KRDKuTFRdIo+9Ny5ER8oWFyQU8Ok+HukjUDYfE+0wFrF7aQtOwNepSthCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253645; c=relaxed/simple;
	bh=GGFxRaAlZlmDb2XuxTgw3S5c7PclFQoAFHhuXgSJyr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PS9XCXSYR+tvQol+k1KzRLDklCN8gHwd9F41jF2ds8C1L6L+AwAt6xzsGFBbAb4caOB0PQ2D8ZXXt+OrFZY3FcT2kZtD+pcSQ9pFIUKaw1cWLPNt87C/TVCPQfSIC6P9M+GqHtXq6rRnlvYbXUXvYec9HBVwBnk+1+/8y8NoEOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=r/i1CPC1; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="r/i1CPC1"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5iD6C7r+BbWR0d8JbTr8VnyDvyTvcj/vZPYxuJjCJGE=;
	b=r/i1CPC1B0gN20tLEXy2dZ+mNCInmreHjnx5+t/RKJEpb2XKD4KyIkjbqtLPig0h6z2ANY0lR
	tkvWbB9Yc+epBj7VzyZYqY9A9z4wyq0Ul+zzghrwZu/0NiExCD1lBUcjgD7yvgyNCktOzCc6HCU
	L4OMiRDOkyfH4o0hq5WdNm0=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gcCSS3Tnvz1prQC;
	Fri, 12 Jun 2026 16:32:40 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C099201E9;
	Fri, 12 Jun 2026 16:40:38 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Jun 2026 16:40:37 +0800
Message-ID: <06ade652-fc43-451e-a3ef-a8b6051e5c9a@huawei.com>
Date: Fri, 12 Jun 2026 16:40:37 +0800
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
CC: linux-kernel <linux-kernel@vger.kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, <kanie@linux.alibaba.com>
References: <20260611213539.4100590-1-alex.williamson@nvidia.com>
 <20260611213539.4100590-6-alex.williamson@nvidia.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260611213539.4100590-6-alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 6/12/2026 5:35 AM, Alex Williamson wrote:
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
>  drivers/vfio/pci/vfio_pci.c      | 30 ++++++++++++++++++++++--------
>  drivers/vfio/pci/vfio_pci_core.c | 26 ++++++--------------------
>  include/linux/vfio_pci_core.h    |  4 ++--
>  3 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 0c771064c0b8..830369ff878d 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -125,9 +125,30 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
>  	return 0;
>  }
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

Since nointxmask and disable_idle_d3 already have S_IWUSR and share the same
"latch per device at init" behavior, it would be better to also add S_IWUSR
to disable_vga for permission and behavior consistency.

Runtime writes will only affect future devices, existing devices keep their
latched value, so no extra risk.

...
