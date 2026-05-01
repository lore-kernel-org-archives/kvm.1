Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670263290D2
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777673333; cv=none; b=UkdQqFG4jtDUgfgxSKerHX9ukiXgoc37NGmRCl0ICANFjyEoHGBMtehcuwPeGgXaaHmvRlv7LaX7ztYF+DhMtuLgX6QCGGxuq/6zH2SxrCYRmGhgs6hsqC8ry9T5o8MiEj2vcqs2OEFO3a7YgwFmjC9LhLxKmD7J7hl2vTckb4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777673333; c=relaxed/simple;
	bh=Gg8XwvR2iye8ftuUb9NqbqgTU1BVsr9N0mr1rcUra+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlT7j0XBNUZacBcY4ezdhDSgBxcSjrC2tx1lkQ/OwYsDsBHUb1z2yAbK3E/3bx59WzzbBZkdbMcu5fniYWyuBlZnqjIOi5bkbUEhF4ZQBHAJSwxIB6OGqBDutzFzzqGBaFSEQW7e8CaXdXn2mFR38/f+DZN6GFwLKwmczvCzZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FB/UTE6y; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FB/UTE6y"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso19995885ad.2
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 15:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777673332; x=1778278132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rIaBOF6T3Igmnhw7WxYJufQz1JELLjrBCUgq2t+SNoU=;
        b=FB/UTE6yrxnLOfl/SWHG/JOdIUkdte5z/Va9gzKPiVkf+Yw/OwzoTopbUuIYGs5WGf
         0ULgy3tiaZJdN1ExKkpvKOsCRE1fhdVrsBPayKfaZ7e63Sw5sulgKTxf1O6Nwfmso8xa
         Rg+jPPhHjpoyBnIj2gFilMZC1WRjQuwM+NlHTFr0n5biDIjKnbpE2CF/EMxWUeVTJUk3
         Id+bVufmLLA22suG1BE/dOTWp2agYba/jD39teCzZsOENf5AiSNRbciImLmNFIoWdCN9
         fArB2NI5pk1jqXZepvlozBNHfx6bH9pTbUu7wSHTESH/X8ds/evxf2kBzJ09SWFulZyN
         iSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777673332; x=1778278132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIaBOF6T3Igmnhw7WxYJufQz1JELLjrBCUgq2t+SNoU=;
        b=XUV9kqzmRJ7ndr/tBmrBa4Ha8ugopzTA1rfTCCd/JEcpZwT6ynRBra/nTm+TkLCNrw
         y7SphbQE1OoWRoSi2U3ai8xlcqUc7YhpQZFgXWf3ficYHejktAxhfERhTkfBuBZ9hhn+
         sOfj8ag42iuoO27mDWSMeEQIpCht3DqHlAZ1Acv5cSmUucm5pmLGhrA8KBCjuzXymoop
         eW+pzU6K/QHeoBJiLSBqYvKr5gGYVwuks7UApJgT1vIG5+3xAoBRxeWSS431f/zG4zxn
         a4tL52hdLaQJrt4XG+qinaWJ1ycSGAIJotDsIhkkxDzuAJTkraM8qwt7Eo8Eb39V6WvX
         ZZdg==
X-Forwarded-Encrypted: i=1; AFNElJ+TzvQOCN/krQvMI6aUIftAFg+jV60P4wZGpuD+OSCOcBFp/YDbn0dDQMWtHKHjzhPO0xY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmpCFcuCkjFxNZwy8oFne5SRFAYfDsRnGSlMVB659SnqRjdiY8
	rniVmHlmZ4r+3F1hRf3pgVZgtX6wfUM1uSK1aFSPgi1C+imu+eRtAK+8Q6y9BM43xQ==
X-Gm-Gg: AeBDiesBfqR1THj0qq0+cvtJR4cpRRIsJdIgiXS1dRnnKHhIEMKaW/Svs5c1+DLA0cu
	3RWsI+ayX5bSxvZZ5RA0Y+B9Y935FQe73eWhJdzG+ykfmarBqqY7HHPwnkqdmOUm52EosqoBCy3
	GI0SduTSGwYrRlG/t3pSk13Xzh9J6HQpvlK0mwtREfedqKL43/aAHvUkTzgdVE6C1ILuygELEhk
	wGMsTjehJmnlbXT1s/s83A303JM8FEbvHEks+nPI9vZf7Ki8PnIRvZFo+Jnk46UAe2+3QjjERwk
	nooZ32SyzU13T4+fi1EPXLs/7JDSyVQgxNSnIoVRtBshP47P9ZWIB+acsJZnERWcHWNaLWOEpxz
	k82Tbeka0NXkFzhWYNsam8ru/m05BMT3b5YxaN1eAPdwBcdfHgfebaW7iT5X1NHRSBlucllRgmC
	DZhFMtYbOeeTbBr4UsxFZBjgOwkodpNWb1Iy4HzKs3vHPmZhH59zF1vEaIKmfpUlDeaJkRo324q
	TLUpQ==
X-Received: by 2002:a17:903:3c23:b0:2b2:41a9:8e10 with SMTP id d9443c01a7336-2b9f25e5495mr9622995ad.23.1777673331344;
        Fri, 01 May 2026 15:08:51 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae6d123sm33770635ad.84.2026.05.01.15.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 15:08:50 -0700 (PDT)
Date: Fri, 1 May 2026 22:08:47 +0000
From: David Matlack <dmatlack@google.com>
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
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 03/16] iommu: Implement IOMMU domain preservation
Message-ID: <afUkbz0IQh98siYn@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-4-skhawaja@google.com>

On 2026-04-27 05:56 PM, Samiullah Khawaja wrote:
> Add IOMMU domain ops that can be implemented by the IOMMU drivers if
> they support IOMMU domain preservation across liveupdate. The new IOMMU
> domain preserve, unpreserve and restore APIs call these ops to perform
> respective live update operations.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

> +static int alloc_object_ser(struct iommu_array_hdr_ser **curr_array_ptr, u64 max_objs)
> +{
> +	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
> +	struct iommu_array_hdr_ser *next_array;
> +

There's a trade-off being made in this function to leak deleted array
elements instead of trying to reuse them that warrants a comment.

> +	if (curr_array->nr_objects >= max_objs) {
> +		next_array = kho_alloc_preserve(PAGE_SIZE);
> +		if (IS_ERR(next_array))
> +			return PTR_ERR(next_array);
> +
> +		curr_array->next_array_phys = virt_to_phys(next_array);
> +		*curr_array_ptr = next_array;
> +		curr_array = next_array;
> +	}
> +
> +	return curr_array->nr_objects++;
> +}
