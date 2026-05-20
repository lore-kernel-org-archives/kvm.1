Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8501B270EDF
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238671; cv=none; b=so7yfuYBGKzHYe+XJQW750cKZRg6GJpARUSxmEOPspCQEoqVQBw7lZHQJosz01i32u4Ui1hZWYladxKVeZyHBK8do29RGo1YRA4bkqVVsbmwPdEHzvQ5KwxxilZbcx4+plqiXAbi0LVN+z21+um68RdXDoJFaH8gi51KR+7nQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238671; c=relaxed/simple;
	bh=rceh66Pponv1tSes2XewX1UpKl2PvawtpHJAfW8PCk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wv1nNWXDjjveBH+fkZJOQI4lfFcK5CEewn9mHD1V/2ZdyOdLwWFOjVH65zg2rnGyt1FEoDteLQuHIyOat4LDQHKB+ef2SP/sXKE4p/tSB/9h9ujuieUExyqEEqPFPw/anlTlwhMt2ln6ws0kv9G0b9qUnBe5oS4QuwZ3aCki7IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+vIKcCQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+vIKcCQ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b46da8c48eso1635ad.1
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 17:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779238670; x=1779843470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kDjXGwvUV0o1PWjFjzRXgYRcX8kLOq1Q/1XsDjbDTWQ=;
        b=J+vIKcCQ0di8fOobS9Uc/H+OJbmV0QVJoPHQOoGyR6u/LqC6zKEzG7hK2tAI0pxKBB
         Rf3s0oWsYuMA6bJ5nnxkwbEICUYX7Ayceg0KyENeeS73675pVw7QxSbZ43ePtv6k9xf7
         PVpKCM4CKllDv6vIvamryWFxvGc3Y0i0He6o9NCURTaooe21QsGV3L0Sg3ZBBJVAQ2/z
         Q74+6A4fzga6elOOVE2oJMV1uMHer/LlC6HzRMYEvGEJe8L9FMkquamYZXw7O1HzbmMK
         jegCfNEh32HLyvB5J5F4idtSxEdJ5an5q3FJOUbPR74ugUYLnVBr2lEDcCSGOvutpzIP
         pcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779238670; x=1779843470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDjXGwvUV0o1PWjFjzRXgYRcX8kLOq1Q/1XsDjbDTWQ=;
        b=sLYhorGYc30LiAHiVPgiaYn1ZuzysCqsQ+J22kd3Y5BnZphikJ9u+XtoZJuRb8S7tT
         4Whpx7/GxtLb5GmwYOw4S9yHWBPkWWSHFH+DtpsScVLlDdbCIsVN/ggZhSuQwi+Zqb0e
         gmA1Aiy6m9as1TCyvIvcHbUqo47y3hs+f37wQWx7cNFaqN8wc2m95TFA6+bB4uRTFlC2
         j3B16dccwzTZOJvR9IsJSo2pxZClMsr9XeH5KGAp+axp5cxISlHPRku5wsrACg/P4mW4
         Ss1X0Yac1yxE5EOKQjXIVIpwFpLgOBy2ozrm/G8NvoxCIkuL5zoCIkmTGqLqC2aTl/2W
         +cxw==
X-Forwarded-Encrypted: i=1; AFNElJ+XyTwINbEqPjELmnDQo7Wzqm1MuXlxOleGvUn//ZraPR+0zHhMVB7CyIP9WlzAx/A1lvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeLxO6LvNuUQ5Z9WiOgpBriAY//fT354gRKaFF5HBbsTMzGzZ8
	f5SsX8/L9KO6EOnagE9sSghEveuWXZrzclHL21eVj4n4blc46aiNqJGQpaGEP/k8uA==
X-Gm-Gg: Acq92OEijxWLaw/TX0ysHJ8JIhZDd+xwErWKj6kGKnZuoCEzp8av3f/K6Bu6yT2maiF
	0k0JyP7Lme+O2W/NjBbEOUJR6pgWdHDPe6hvXzYiLUM21Ow9KCR6WiZguBinoW3JJfjdPy3mmmJ
	a1swwfupoMCnqxResprvLG7GtwecNLACIvEwMH3DPFntLD1f1jCmnZJQ9GG15BlAz7eneebv1ML
	f/6my8IxyL33bsNjvvv/r7kzA4O1+vZ2KCfaeZ/58G3TmLg7qCVp8SMQ3V1DdAvT3QsoQ+/26Ct
	FhpAhJeLEiH7Mc9eZu07BP380OkEOaLtLwpp6ET8ckm69MS6aEutAxlrSj0AnSc2LILpwHbDL68
	lsvMpyNnMaGNEZ9XuwXPfKWRJoXP7F75g1iaiGttv8BYnB6kKCB/wrzf7l/LU7QCIUvEKmGOtEj
	S5hUjlLAaR+QKg1tYZSwYUlRQjR7ZR2vyasiOCZvyfkLtA5UUFcxcc7hfLIBmegd7UJgv3
X-Received: by 2002:a17:903:1b67:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2bdb03a2d5dmr7879775ad.2.1779238669067;
        Tue, 19 May 2026 17:57:49 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fb17sm194753605ad.1.2026.05.19.17.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:57:48 -0700 (PDT)
Date: Wed, 20 May 2026 00:57:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 15/16] vfio/pci: Preserve the iommufd state of the
 vfio cdev
Message-ID: <ag0HBChHOn_czixb@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-16-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-16-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:32PM +0000, Samiullah Khawaja wrote:
> If the vfio cdev is attached to an iommufd, preserve the state of the
> attached iommufd also. Basically preserve the iommu specific state of
> the device and also the attach iommu HW unit.
> 
> Once the device and its iommufd attachment is preserved, it cannot be
> detached or attached to another IOAS until it is unpreserved.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/vfio/device_cdev.c             | 10 ++++++++
>  drivers/vfio/pci/vfio_pci_liveupdate.c | 33 +++++++++++++++++++++++++-
>  2 files changed, 42 insertions(+), 1 deletion(-)
> 

[...]

> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> index 976ef17e6103..b56d80379ffc 100644
> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -108,10 +108,13 @@
>  #include <linux/kho/abi/vfio_pci.h>
>  #include <linux/liveupdate.h>
>  #include <linux/errno.h>
> +#include <linux/iommufd.h>
>  #include <linux/vfio.h>
>  
>  #include "vfio_pci_priv.h"
>  
> +MODULE_IMPORT_NS("IOMMUFD");
> +
>  static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
>  					     struct file *file)
>  {
> @@ -153,9 +156,26 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>  	pdev = vdev->pdev;
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	/* If iommufd is attached, preserve the underlying domain */
> +	mutex_lock(&device->dev_set->lock);
> +	if (device->iommufd_attached) {
> +		u64 token, preserved_state;
> +
> +		ret = iommufd_device_preserve(args->session,
> +					      device->iommufd_device,
> +					      &token, &preserved_state);
> +		if (ret) {
> +			mutex_unlock(&device->dev_set->lock);
> +			return ret;
> +		}
> +	}
> +	mutex_unlock(&device->dev_set->lock);
> +#endif
> +
>  	ret = pci_liveupdate_preserve(pdev);
>  	if (ret)
> -		return ret;
> +		goto err_iommufd_unpreserve;

Nit: Would we hit the WARN in patch 14 if (device->iommufd_attached) was
false here? Should we check if (device->iommufd_attached) below before
calling unpreserve?

>  
>  	ser = kho_alloc_preserve(sizeof(*ser));
>  	if (IS_ERR(ser)) {
> @@ -170,6 +190,9 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  	args->serialized_data = virt_to_phys(ser);
>  	return 0;
>  
> +err_iommufd_unpreserve:
> +	iommufd_device_unpreserve(args->session, device->iommufd_device);
> +
>  err_unpreserve:
>  	pci_liveupdate_unpreserve(pdev);
>  	return ret;

With that nit:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
