Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98073423A8E
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383308; cv=none; b=dSXytaXbr+a2cU1SDQYQBh8VLKVSVyW8Kpj9rePH0AveeQdU9tFcmCM6eUmLwpAIBzcjeW65yB63ykFR4+FwTW4xd1O+RIjzPBLmHUTItzWR3LQFrAeibpg6VuKozhlj7xL6WGOmmmE5g/+odsdVVE8n/laUcAQEVYxU/+emhfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383308; c=relaxed/simple;
	bh=7CVl5H1qQOxXhKG1WU+PIkycGiH7wufAZU+PlQ2NAB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLiVPlG9cbPOEUcosSGxxOvMd/R/xS3b1isInIo1Q8pvyTDK0aya8PGyhiJJizCA8cIO3x5mCibiY9a7SMtf/Fu4+fMR1Tgqz1NjWtNM9HQPo9RnDV09P/m8UTnXGVvbkzKxcqFcoMa7R95JyAAAlS/mfLocXcu/m/EyvQIJki0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ETLGGWWC; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ETLGGWWC"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8ea8563c693so1028093385a.2
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 06:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777383304; x=1777988104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/TU/HoOrpr0P9zaYPr2HqTTv+c29GatSHy85DT1kBg=;
        b=ETLGGWWCegFTT0MrBsj/DDnkWSsb+pascrVjHQNe0yjKa1YHc+7NWCwT8DSrUXdoRC
         HtnEqsa1mPipw51EnFr87ul0bbmy4Q6eTcVhEp3EpscwDJDS1qgMjBYar1tqvLChJ9fz
         943ALraBVItP2eK2ytack/7Lx2fCQcmUf9hF9r55rHyDNcQXJmwSUPImliWTMSOez9J7
         xllD1x01/YrAlWHyVPS8qLY+UbNsJD8ydpEvJIB1KZQzzPcM+Yy0jXzX1xGHy/lraqEP
         ekdOR/FMEqEmNm1kcvMKl1c9yDpBmHDNBFPv2u2ZCDCFSH1L37LIJgSFgi6FeFgZVLtM
         I6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383304; x=1777988104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/TU/HoOrpr0P9zaYPr2HqTTv+c29GatSHy85DT1kBg=;
        b=H6DRfMuzS2eUi8d5iSUtY2hTazSSplZ7AgIo/BD/pRMK5TycHEDhdyDQEDdHzZ59/e
         aI4HaC675Tlrj3GKWzG4iP77cZaxl0/FSy3D4dvGvGSVa0pkZIH0+83yT/6ufxOZ4Xbf
         UePD4UKedgC+u1/oPtMtUM9VnZduG8lQhpZSyX29j21jy7ADmozFuCEr3p4cp/TzXKYk
         LXOlED79H6vAYrr2tYLlLjWOcUVvzMQBXPbpIkVv22Ip4OSaNqhlD3nXwxIMY3o0HB+2
         /2a1/kUyN5iktOTljG1CIP336GYStWenkuFabhMatVj2BGthMO/sash3Pr9qam2Kp84l
         2pQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SB7qV+Khs8gGnf1Ddw2WaOswxCE3psLJAvoUeEDX1FI9KhGM3Tgovfo3lAsmHlc+s+Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv24vvWBjbdikfCrvc7kX9s4zLjJOaHxsG+O5wgMGwiaGdp/V9
	cPu6+8WzlpIje+m2C7EC+Covy02qvjGt4TO0c0/zQ2k6tm89RSFyKrYSqlAY+k/u4tI=
X-Gm-Gg: AeBDietms9HyajL8lW7PhmjqW5OHHN5j9PQWRaX4LnpGZ4WMQ7W7CZLZBa5h+9Tv22D
	5kBaex8Mco9MSi1i+/6XHPsx6fctk98MWeLWsNf4xOZbN9hjTXVwEl3d52aWWv8j18GlJtADRMs
	ThGUAlAGZsiQO6+EluO3RpLWsAfXl/+YnWOuhB0B1FdhG3pi18x17IPWsbuwhhpbUiUjMEDjLVF
	xNd0zsFWOVtYkPyDYpQSZCgU4aFHj9Bh/9BBsgVcPAFQz6pW11a7sLG74tH4US8sTLsKgklbS+O
	PB+08GbXkrqUWfohRActiV/DxrA8zaZfn3JAaBLE9LRjua0+UJ9XeKj1bXPRxB162utP+80rAr2
	+T51o5j76v/PXoUZqWl1NyaC3JpgfuPHng6I+mceoUlp+fQ0/9e4dcyZKvRjwtqjL3NBepl8Idq
	JXd3e5U6xA6mGII4UvceZAHPyBKevJzvI5Vd2ofvepPRQ+aHFUD+xnmJT7wzZdrangwcAUQNZRd
	wrRouKJ3OFeBl+9
X-Received: by 2002:a05:622a:311:b0:50f:bd79:2643 with SMTP id d75a77b69052e-5100e1b5b9cmr36699661cf.34.1777383304257;
        Tue, 28 Apr 2026 06:35:04 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5100da647d9sm18237481cf.9.2026.04.28.06.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:35:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHiab-0000000AiFH-3nWV;
	Tue, 28 Apr 2026 10:35:01 -0300
Date: Tue, 28 Apr 2026 10:35:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tjeznach@rivosinc.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
	atish.patra@linux.dev, skhawaja@google.com, guoren@kernel.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 06/11] iommu/riscv: Add domain_alloc_paging_flags for
 second-stage domain
Message-ID: <20260428133501.GE849557@ziepe.ca>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
 <20260428131359.34872-7-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428131359.34872-7-fangyu.yu@linux.alibaba.com>

On Tue, Apr 28, 2026 at 09:13:54PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> Replace .domain_alloc_paging with .domain_alloc_paging_flags so callers
> can pass allocation flags to select the appropriate page-table type.
> 
> When IOMMU_HWPT_ALLOC_NEST_PARENT or IOMMU_HWPT_ALLOC_DIRTY_TRACKING is
> set in @flags, allocate a second-stage (iohgatp) domain.
> 
> When @flags is 0 the behaviour is identical to the previous
> domain_alloc_paging: first-stage (iosatp) domain.
> 
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/riscv/iommu.c | 66 ++++++++++++++++++++++++++++---------
>  1 file changed, 51 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 5dadf6d09139..0c13430ecc7f 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1255,23 +1255,50 @@ static const struct iommu_domain_ops riscv_iommu_paging_domain_ops = {
>  	.flush_iotlb_all = riscv_iommu_iotlb_flush_all,
>  };
>  
> -static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
> +static struct iommu_domain *riscv_iommu_domain_alloc_paging_flags(
> +		struct device *dev, u32 flags,
> +		const struct iommu_user_data *user_data)
>  {
> +	const bool second_stage = flags &
> +		(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING);

This isn't the right logic, you should follow the switch/case design
from other drivers.

>  	struct pt_iommu_riscv_64_cfg cfg = {};
>  	struct riscv_iommu_domain *domain;
>  	struct riscv_iommu_device *iommu;
>  	int ret;
>  
> +	if (user_data)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	iommu = dev_to_iommu(dev);
> -	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
> -		cfg.common.hw_max_vasz_lg2 = 57;
> -	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48) {
> -		cfg.common.hw_max_vasz_lg2 = 48;
> -	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39) {
> -		cfg.common.hw_max_vasz_lg2 = 39;
> +
> +	if (second_stage) {
> +		/*
> +		 * Second-stage (iohgatp) page table for KVM VFIO device
> +		 * pass-through and dirty tracking. The GPA space is 2 bits
> +		 * wider than the corresponding first-stage VA space (x4 root
> +		 * page table), so hw_max_vasz_lg2 values are 41/50/59.
> +		 */
> +		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57X4) {
> +			cfg.common.hw_max_vasz_lg2 = 59;
> +		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48X4) {
> +			cfg.common.hw_max_vasz_lg2 = 50;
> +		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39X4) {
> +			cfg.common.hw_max_vasz_lg2 = 41;
> +		} else {
> +			dev_err(dev, "cannot find supported second-stage page table mode\n");
> +			return ERR_PTR(-ENODEV);

Do not make log messages for failing system calls.

Jason
