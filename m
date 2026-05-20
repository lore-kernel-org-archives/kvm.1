Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E4035CBD7
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306892; cv=none; b=t1aBVZ1hBSokXCFf+rH2YBXAWQmNgHxlVwmvNwVQyjBpmGgun5S6oVZfXQzHZ5TcfvcU3kIjmCvjWpfqYj2/5c/g1f9IUowFY7CkDJAkazd4IaHLaAsaXaGoY8XECi0341YydRjMlQWJoF2NyJsKmQzZA8SIKL9vsK3Qs8qe4ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306892; c=relaxed/simple;
	bh=DwoLvHtBsMr6cFX0X2XMLQenBS2lTQpE+ExMxyFn8EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga9rbQi3dnSyeu8xiCdVWkdDKnZKPOOxmFbDyk856Txy9YV8VM1yFO6gY3hmrVu28Yi213KDY0Vm+N6KAq4UdVUz+aaS9RV6OmgwjAs2ajsYgonXTdZXLIdaWUkaTwHnE3Rck+g0diAJcw+/QLJ/+dCG/sdkqPlbTx3k218f8+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ul3og3w4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ul3og3w4"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba180a022dso145ad.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 12:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779306890; x=1779911690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=odGUqTyiw+s+ktOv1sVN6kVyJPFqIH1UoIVnjwejXQY=;
        b=ul3og3w4DyuNVcwdZ6Xg7+9qhxBmAfKMk/pD3rSsz/BQ7F6KVhWuuuC45SETBwVf8M
         MhOrQVVXG3QV2fnVv0BNV8iCaqHYQ4/Y0VB/UedcUMqgK5xNJuSAmp3xVnquwZGSvmQN
         xpqQYsUHdEUThXo8p4pH645AahgKMl7TS456tOvDUJTPHlkp24nGMXNLROD7S9lPf2UL
         wCeBt/sQcnDPfDpVfFqSzzoQogonBpDDZn1PP7Gxh/NPNxL2KLpIjuPZDKziNBzS43XX
         DgMtaJXsArPjGP2k3jjkfpeTRQv/SiJs2t58M5nLzeApZQJrCvdRa05QWRxFj/v9qSYs
         VrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779306890; x=1779911690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odGUqTyiw+s+ktOv1sVN6kVyJPFqIH1UoIVnjwejXQY=;
        b=W5demQAIK8puIIf0TEv0KQsRCAnHKuQBxhy8h9KCKZJOFaFRMKGVBTUUBQQm9l4kNS
         KZw7WDpKg4nKElgDT9Sp/Q1D2AABhepaUJJluWWphSYk6gqJL86msuDYZgVf6p3xKT35
         ca1akNdrkW0cvJyNhXx09GUnLS513fIpRmvL5EtdAPvmz1OJvyUOGUfY8dtgX4oEvpBi
         GnsXOs2L2bK1o0Xhy3bynFTlM/hknDp4O321FZixQggwKKiHdM0WV9WOKLc3N1aGZSbI
         ggn9rbKiKoIGFPp66ETutevSi95zQ6GFfPz/tgw9EZ91TEwyf4RyKwHq79Zz7S3pdR4T
         sNDw==
X-Forwarded-Encrypted: i=1; AFNElJ8Wb+jnwn1f6rs2kMNN02aG+EA3atEfBPxfRqM4a/FmsuHtAsYYt+7Hrli2enGjbwamy5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/nMeJgZmGXmCaKSbj71+cX5Tbp3WePtN/s2oJvj/zF+//+mgV
	PzOP5wI7jLe4nGdZ89XH0lGdsVWxqHPQWXO9/Ua6Vh7kkA1iLg1IMEDG0rrhz3aM5Q==
X-Gm-Gg: Acq92OEgJc1ZWeLlN8wARpRq02B+beta2CT/X9fjV0tklWKD/fbiT1E81YXt4D+7JA6
	geVfBjXUnJXne8jXu5diFMRa7MO/4InCTspM0QlnNKt5IyQhlsOxosSql9P5KZ+Sr97RVxq9Ukv
	l51Tk3/HvTG4eX18CoNkht/oNlEtBd6TiiyCBo+GKfgWFDNa+fH5EndOUCDe7w3MYNMP/OncL3N
	VVD48EoCr0hnybNuQp2YZTvfSbq0Kcjb0D2Kp9KaASvvQkcmDhHdRoFme/XHPpdNIjPsjUc0GLJ
	HMDhYZYHfr2gEstpLAM7Eo5fkmD0sj/h4TezkkXbYs6sRqg9Tc+86oBOVd1txrNkbMLYWEbeHdl
	WOJKNpM/tnuWW6ehYLLYT8gCXRVpC9yadgjShBHteZEFDIqhP8qxB8rDwYRzKDLbnTDgeC3/S17
	i89HYmlxJ9X5ZvM/Kdk+lj/XyfMfmEnWjkZnJ+mYLKfkpVu41FRM5bLbgOp8rZparpLi+drr4oo
	fOMvH/v
X-Received: by 2002:a17:903:1a84:b0:2bd:6dad:7ccd with SMTP id d9443c01a7336-2be9f6f3fb7mr619555ad.25.1779306889241;
        Wed, 20 May 2026 12:54:49 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3f4ddc23sm206344a91.15.2026.05.20.12.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 12:54:48 -0700 (PDT)
Date: Wed, 20 May 2026 19:54:45 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 15/16] vfio/pci: Preserve the iommufd state of the
 vfio cdev
Message-ID: <ag4RchzcJkIlRbbR@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-16-skhawaja@google.com>
 <ag0HBChHOn_czixb@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ag0HBChHOn_czixb@google.com>

On Wed, May 20, 2026 at 12:57:40AM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:32PM +0000, Samiullah Khawaja wrote:
>> If the vfio cdev is attached to an iommufd, preserve the state of the
>> attached iommufd also. Basically preserve the iommu specific state of
>> the device and also the attach iommu HW unit.
>>
>> Once the device and its iommufd attachment is preserved, it cannot be
>> detached or attached to another IOAS until it is unpreserved.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/vfio/device_cdev.c             | 10 ++++++++
>>  drivers/vfio/pci/vfio_pci_liveupdate.c | 33 +++++++++++++++++++++++++-
>>  2 files changed, 42 insertions(+), 1 deletion(-)
>>
>
>[...]
>
>> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
>> index 976ef17e6103..b56d80379ffc 100644
>> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
>> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
>> @@ -108,10 +108,13 @@
>>  #include <linux/kho/abi/vfio_pci.h>
>>  #include <linux/liveupdate.h>
>>  #include <linux/errno.h>
>> +#include <linux/iommufd.h>
>>  #include <linux/vfio.h>
>>
>>  #include "vfio_pci_priv.h"
>>
>> +MODULE_IMPORT_NS("IOMMUFD");
>> +
>>  static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
>>  					     struct file *file)
>>  {
>> @@ -153,9 +156,26 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>>  	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>>  	pdev = vdev->pdev;
>>
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	/* If iommufd is attached, preserve the underlying domain */
>> +	mutex_lock(&device->dev_set->lock);
>> +	if (device->iommufd_attached) {
>> +		u64 token, preserved_state;
>> +
>> +		ret = iommufd_device_preserve(args->session,
>> +					      device->iommufd_device,
>> +					      &token, &preserved_state);
>> +		if (ret) {
>> +			mutex_unlock(&device->dev_set->lock);
>> +			return ret;
>> +		}
>> +	}
>> +	mutex_unlock(&device->dev_set->lock);
>> +#endif
>> +
>>  	ret = pci_liveupdate_preserve(pdev);
>>  	if (ret)
>> -		return ret;
>> +		goto err_iommufd_unpreserve;
>
>Nit: Would we hit the WARN in patch 14 if (device->iommufd_attached) was
>false here? Should we check if (device->iommufd_attached) below before
>calling unpreserve?

Agreed. I will update this.
>
>>
>>  	ser = kho_alloc_preserve(sizeof(*ser));
>>  	if (IS_ERR(ser)) {
>> @@ -170,6 +190,9 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>>  	args->serialized_data = virt_to_phys(ser);
>>  	return 0;
>>
>> +err_iommufd_unpreserve:
>> +	iommufd_device_unpreserve(args->session, device->iommufd_device);
>> +
>>  err_unpreserve:
>>  	pci_liveupdate_unpreserve(pdev);
>>  	return ret;
>
>With that nit:
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>
>Thanks,
>Praan

Thanks,
Sami
