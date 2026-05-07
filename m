Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60275330D2F
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179634; cv=none; b=mSdnCjk5rfnZz8GNIqA2poXzYV4ffsD1Y5bt0kE9I7MP2dWRrL6hO+VEPWdm9vesKGWbIVqnuriFgCmxxtUDMymaS1sR9eX7tRCbuPDQLTRapwAwwtVOYPCj2C4T5Oafi4UceIYLYso7+s+sVpbcD693SowWn5d0ljrwBWNLbrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179634; c=relaxed/simple;
	bh=h1JkDde0JEpeHExaAaLcI/3EDWHEcgua5TaSpojYG5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGWykOeifmSEmpopUeZ1MUbVAXFZZgQDdJOYrrUrMJaogqUPNATeDivfEdX/wv+/EbLlkay70Vh/QQChgXuAsRlNY+4j7WkdZmWMR544zM9JGDevX3tHC9be75x/Tj9HdC1WlJ66ckIdHXxBMnsKqiUAEnibtp5kCprqPebsVgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvN4gAr1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvN4gAr1"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso17645ad.0
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778179632; x=1778784432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CukuR4C0VokxuACh8W7BiMV3ykO5i2dF/8Jc99UlNZw=;
        b=TvN4gAr12UOEDzR+1X/JXjdaXNGbMwc7p2aOK8dRMmVZ+EIQAD1d/H55LoTAMCSvAM
         av4D3P2ujK8g9MhUSqABXDbWWvDQdzltWe9fsUyCyUrYpdwpHdJ3Ztr/iVGb0ZjZlWTM
         T9lRhEQBkAcNIN0UbmEV2n73qI7+DAlsolqlnMfRBWJ5UAjqExugtVgCldQUV0ReGyKz
         QOpJM+7PVafrMBvaPmAUrvJQhOMYAHrFKoPx83uTyG44smCeeB9qwtzJjtjEspzunfV5
         ZIB4uNxGHrbyYe9n+NuximOLiRGSdqQYfHIPn0mx2jnSOxsYFWtHj27eDL9waLfUOilH
         4OIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179632; x=1778784432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CukuR4C0VokxuACh8W7BiMV3ykO5i2dF/8Jc99UlNZw=;
        b=A752gmusxXstPhd9xSICKK1H3xL8yVMUTjQDwMVcKig3OO4AwCQXzNjQDhKs5v0MUe
         8XK8AgkKVV2xxsFDIilFihxo+ZEcYz0GFvyrbo2vF5Q4uXXSydheeVxwFgAtIWkI8Ln7
         cX6Y+KwiKLJKpG4UzeN9dIW7oNjNvFI4yoYbBInhlcPuqYnUXZy3hBn7PvA1YKfrE6Fv
         HplmQM+SHFdMzwVnMlewbrp7NG7MtqkCXGXcwSbCsZD7xDksQc0/e3qectTl1hbamaZD
         WV4bFZX3agyDAmrrhSkfkA0LITXIggdMpEt/8yo1rlC4eo6/mZOZx8k6bkChRBBbWjdu
         bePg==
X-Forwarded-Encrypted: i=1; AFNElJ9ATq0BkFlIG6ZKM/6mu23TilNXQ27eGgxVcaxSnKWFrzdsPeoEzElXbI+5h/HB0WzxHzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwesCjUcDRSbAClixqczEsE5o9a6NcjER50WODKtfM1rgFgpVmX
	cdN2Okt81QN+TI9nnqa6SfBMMu01KTXOlls4LL8y3DpUay2ukb2PwOI7YCikJhxTzbAJJz/VOOL
	+4E6lPbpF
X-Gm-Gg: Acq92OEe0xg5amqauAugTuV3AAr5Zv2EBAKgM+gFfErhRzYPrCVufwIoHJgQdvowjQS
	YZ9tRaEu/+tx1ER6ORGKO/bST395bpYos6u82xhpozmHxyAvK2iaap7GJFSzsYw0MLncW/hYnbl
	qYjrsFBEwmFWYLIOlYijISfTWLiWL6lkR80JYRCsappwrTbYT7IVoN6m6IFKrGZAVBPagJHvYv6
	ai15Xs3LN5lda5XRAz0GZasa/k7eJyQDyp5vXheOh/DispRFfA8IZwBJpTVhO5T5eo818dYSK8C
	1CiY/vuKQO1k1ZGyfNYP2f/d8LxUcptezPr9r/W35fFmuS9ToE3QY06xp65/cRMzlrPSF2r/GVa
	T/FIbM9CqNGVSiuLNb5xZdPECFSQ92UJjjcimP1HNQDmL83WJchFNe3yiAkIt+AfZvLY9O14lMz
	4tR/b/hLrGdI1vYBwPSF3EOTUir8yoI3m0t5xz/q5TjJt54DiLUvi+D2x9LDfwVt/yNljVgA==
X-Received: by 2002:a17:902:d50d:b0:2b2:5931:5950 with SMTP id d9443c01a7336-2bae9e68566mr558665ad.16.1778179631231;
        Thu, 07 May 2026 11:47:11 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82640ca287sm278224a12.23.2026.05.07.11.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:47:10 -0700 (PDT)
Date: Thu, 7 May 2026 18:47:07 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 04/16] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <afzcqWa8iVqrhJLs@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-5-skhawaja@google.com>
 <3874a086-98ae-4b94-8c1b-20e13f5a92fb@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3874a086-98ae-4b94-8c1b-20e13f5a92fb@linux.intel.com>

On Thu, May 07, 2026 at 10:07:43AM +0800, Baolu Lu wrote:
>On 4/28/26 01:56, Samiullah Khawaja wrote:
>>Add IOMMU ops to preserve/unpreserve a device. These can be implemented
>>by the IOMMU drivers that support preservation of devices that have
>>their IOMMU domains preserved. During device preservation the state of
>>the associated IOMMU is also preserved as dependency.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/liveupdate.c       | 162 +++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h |  33 +++++++
>>  include/linux/iommu.h            |  20 ++++
>>  3 files changed, 215 insertions(+)
>>

[snip]
>>+
>>+int iommu_preserve_device(struct iommu_domain *domain,
>>+			  struct device *dev, u64 *preserved_state)
>>+{
>>+	struct iommu_flb_obj *flb_obj;
>>+	struct iommu_device_ser *device_ser;
>>+	struct dev_iommu *iommu;
>>+	struct pci_dev *pdev;
>>+	int ret;
>>+
>>+	if (!dev_is_pci(dev))
>>+		return -EOPNOTSUPP;
>>+
>>+	if (!domain->preserved_state)
>>+		return -EINVAL;
>>+
>>+	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
>>+		return -EINVAL;
>>+
>>+	pdev = to_pci_dev(dev);
>>+	iommu = dev->iommu;
>>+	if (!iommu->iommu_dev->ops->preserve_device ||
>>+	    !iommu->iommu_dev->ops->preserve)
>>+		return -EOPNOTSUPP;

I will check for unpreserve ops here also.
>>+
>>+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
>>+	if (ret)
>>+		return ret;
>>+

[snip]
>>+}
>>+
>>+void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
>>+{
>>+	struct iommu_flb_obj *flb_obj;
>>+	struct iommu_device_ser *iommu_device_ser;
>>+	struct dev_iommu *iommu;
>>+	struct pci_dev *pdev;
>>+	int ret;
>>+
>>+	if (!dev_is_pci(dev))
>>+		return;
>>+
>>+	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
>>+		return;
>>+
>>+	pdev = to_pci_dev(dev);
>>+	iommu = dev->iommu;
>>+	if (!iommu->iommu_dev->ops->unpreserve_device ||
>>+	    !iommu->iommu_dev->ops->unpreserve)
>>+		return;
>
>Is it considered a driver bug if it implements the preserve hooks but
>not unpreserve ones? This would at least cause a silent memory leak. How
>about adding a WARN like this?

I think the preservation should not be done if the unpreserve ops are
not implemented by the driver. I will add these checks in the _preserve
functions and return EOPNOTSUPP if it is not implemented by the driver.
>
>    if (WARN_ON_ONCE(!iommu->iommu_dev->ops->unpreserve_device ||
>                     !iommu->iommu_dev->ops->unpreserve))
>        return;

We can add this warning here also.
>
>?
>
>Thanks,
>baolu
>

Thanks,
Sami
