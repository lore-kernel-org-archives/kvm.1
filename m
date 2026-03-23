Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87E13BF69D
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289974; cv=none; b=nP2EfhkVz+Z37Db0GHveCqtHoH9ARsQFKkP/VNA14jNOFTlbTT119+70qmHSTCEvFGr5X+4Ow1clCUd29br5kIS0SwSn+2PJ6JgpPZnp55MALTaqiBHPuLlttRLx7wWEiasZmZCUXpk99q778m3f6D6SLwjQ5QXU0gmq10Jztkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289974; c=relaxed/simple;
	bh=qlX+bWO08ddCn1BR5cpbuX6vERreoyttpS8p6xNG19A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwxAlxaQ43V/kaWX7E1sR9xh9wKSsyQEmXnetlIEuAqu+06EZMNDBYNQdxLCbgZYSv8DiH2VoIi5/tuo7PER1akZkQuHLio3HqRM0kEK3T4lcpcud34kI1LkmEvQebVNCympyfnZDccORESpLjseC0WZXUT9gPLQfWd/2P/rmck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=czdmNMu9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="czdmNMu9"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aeab6ff148so11065ad.1
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 11:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774289969; x=1774894769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYT4u0eCfcB6nC9W73YBETkpKyxkpheerY5gvezgwro=;
        b=czdmNMu96hQ+CpVpk9c0CE+QW1S0RHQ7MeVVMcXlhd0pnsDAKt86XRbMS2Du49ewVq
         4jOq+UjpvI0uAajPr0ZZUwejyzaGJyftpTWVyMa/QXwJv610qOb/5LzNjUN9UUmq2Mo1
         P43CWLabea/+M4tjJ1GOf4SgmwAWLtX6+nJd8S1m0ASvA9dxOYq1h1nbhh3x7mpNRXTZ
         Wj9amrToiqVSNZMniewaFNcRlvH191JuowEsaMAUf++7AO7JkKdD+X98SqQCrfyz+re9
         po8eBT+CFFC0OS/TqTmq9LmbHMcMxifi8esgT/iN4/kbI8pMBPO7n1/Z+YGwekwtkxtR
         xVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774289969; x=1774894769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYT4u0eCfcB6nC9W73YBETkpKyxkpheerY5gvezgwro=;
        b=N5abzW+2Wzk/4cnPj2G40Hk+RXg4R59orYmJZ+PzOUCcziy6p269c8HjN+zLVyFP+c
         aOozowHITAKt2LWJSiQN1n25z9UOfdyXvc480igs7xkdPP59Cg17J9Jsc2KP/6lzEZOM
         tDqri89Kh0X2BN1ZiAnBvxQ1B524UV0Y0koxnNHnAroYsPNsp1G//Ft+YInu53zqSkz1
         l9di7eehbs14d6G3uIvUtrFzGSuAEiEQuuOjT2DZZCRobSU3i5o4kIceZxpZLDJHynIq
         Vqzn+bc2hOQfKEBcyOHtIiD24DromvK/CKIomEaSX5ThnURg6W63QFyl+y209Ki++8QA
         oMjg==
X-Forwarded-Encrypted: i=1; AJvYcCWY19a9/s/ujxB2VL5owGfRO6+TL1Cn6fWA5EDMOL+vURCCJQI+M5x0Pbreh3Ve4yuKgXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws3l5P8Q2+tSPH3eHkje4TMyoyObSQdnYlrxYo2MoF5Kkk+Q5r
	bpDqQ1Py/FZY9A1iGvj/LNm8qlLZgLB+qruFhC/KpI8Ft0xOBmETVYmZZcEjRGmDDkmi5aqSYdZ
	CDYy5arwo
X-Gm-Gg: ATEYQzysc7/wVgbeze1kJp67RZTBvTT+98SeQk6r1F1DjR2+Ip5gUC5koa2XViGN4vS
	pFunXbE8/8sVLN7BAc3xs+ZX3ROZMXL/xuQQfToiBrGo7DE0NeiSZH5EOjbuzuKLrBLhsW0FMkX
	+iVPagjeDlIQj2Q6gIbW4mAycReTJ7+W9Eur4zpOKKayd/shUUBGr3tvrzTlgHwiAhgTMhcOF6V
	t4kqbd/6h45xMlhGBmTK5i3WZAvsnWD3yN4qka7cPUeqkZ1ZV7BYSqrVdo2J3EkIHKWxniKEgAK
	5Pf0+JY8qWHv82DCgF/Xpm3e8eay94e0SQlbb0ab+bdYzZpJg33q/9xxNuuL9hVlmImEm33STaD
	fv/lRzHhX2b6wqluG32IB/EQmpOqxZQXSlmMoKkZI3Y9+L8mB26cF6XWMWh1eRSXSt42PO7JDMB
	D6ikZwLub2A5qTttR8Lpu4HuDzFMp63NeNAGvGP+CYJETRO9r39nzfwgtZ6g==
X-Received: by 2002:a17:902:f68d:b0:2ae:4808:bd99 with SMTP id d9443c01a7336-2b0a53e730fmr373095ad.2.1774289968204;
        Mon, 23 Mar 2026 11:19:28 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040db2a6sm13581616b3a.50.2026.03.23.11.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:19:27 -0700 (PDT)
Date: Mon, 23 Mar 2026 18:19:18 +0000
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
Subject: Re: [PATCH 09/14] iommu/vt-d: preserve PASID table of preserved
 device
Message-ID: <acGEJhAQKKknC3n8@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-10-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-10-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:43PM +0000, Samiullah Khawaja wrote:
> In scalable mode the PASID table is used to fetch the io page tables.
> Preserve and restore the PASID table of the preserved devices.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/intel/iommu.c      |   4 +-
>  drivers/iommu/intel/iommu.h      |   5 ++
>  drivers/iommu/intel/liveupdate.c | 130 +++++++++++++++++++++++++++++++
>  drivers/iommu/intel/pasid.c      |   7 +-
>  drivers/iommu/intel/pasid.h      |   9 +++
>  include/linux/kho/abi/iommu.h    |   8 ++
>  6 files changed, 160 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 83faad53f247..2d0dae57f5a2 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2944,8 +2944,10 @@ static bool __maybe_clean_unpreserved_context_entries(struct intel_iommu *iommu)
>  		if (info->iommu != iommu)
>  			continue;
>  
> -		if (dev_iommu_preserved_state(&pdev->dev))
> +		if (dev_iommu_preserved_state(&pdev->dev)) {
> +			pasid_cleanup_preserved_table(&pdev->dev);
>  			continue;
> +		}
>  
>  		domain_context_clear(info);
>  	}
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 057bd6035d85..d24d6aeaacc0 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1286,6 +1286,7 @@ int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser
>  void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
>  void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>  					       struct iommu_ser *iommu_ser);
> +void pasid_cleanup_preserved_table(struct device *dev);
>  #else
>  static inline int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser)
>  {
> @@ -1309,6 +1310,10 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
>  							     struct iommu_ser *iommu_ser)
>  {
>  }
> +
> +static inline void pasid_cleanup_preserved_table(struct device *dev)
> +{
> +}
>  #endif
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> index 6dcb5783d1db..53bb5fe3a764 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -14,6 +14,7 @@
>  #include <linux/pci.h>
>  
>  #include "iommu.h"
> +#include "pasid.h"
>  #include "../iommu-pages.h"
>  
>  static void unpreserve_iommu_context(struct intel_iommu *iommu, int end)
> @@ -113,9 +114,89 @@ void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>  		iommu->reg_phys, iommu_ser->intel.root_table);
>  }
>  
> +enum pasid_lu_op {
> +	PASID_LU_OP_PRESERVE = 1,
> +	PASID_LU_OP_UNPRESERVE,
> +	PASID_LU_OP_RESTORE,
> +	PASID_LU_OP_FREE,
> +};
> +
> +static int pasid_lu_do_op(void *table, enum pasid_lu_op op)
> +{
> +	int ret = 0;
> +
> +	switch (op) {
> +	case PASID_LU_OP_PRESERVE:
> +		ret = iommu_preserve_page(table);
> +		break;
> +	case PASID_LU_OP_UNPRESERVE:
> +		iommu_unpreserve_page(table);
> +		break;
> +	case PASID_LU_OP_RESTORE:
> +		iommu_restore_page(virt_to_phys(table));
> +		break;
> +	case PASID_LU_OP_FREE:
> +		iommu_free_pages(table);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int pasid_lu_handle_pd(struct pasid_dir_entry *dir, enum pasid_lu_op op)
> +{
> +	struct pasid_entry *table;
> +	int ret;
> +
> +	/* Only preserve first table for NO_PASID. */
> +	table = get_pasid_table_from_pde(&dir[0]);
> +	if (!table)
> +		return -EINVAL;
> +
> +	ret = pasid_lu_do_op(table, op);
> +	if (ret)
> +		return ret;
> +
> +	ret = pasid_lu_do_op(dir, op);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +err:
> +	if (op == PASID_LU_OP_PRESERVE)
> +		pasid_lu_do_op(table, PASID_LU_OP_UNPRESERVE);
> +
> +	return ret;
> +}
> +
> +void pasid_cleanup_preserved_table(struct device *dev)
> +{
> +	struct pasid_table *pasid_table;
> +	struct pasid_dir_entry *dir;
> +	struct pasid_entry *table;
> +
> +	pasid_table = intel_pasid_get_table(dev);
> +	if (!pasid_table)
> +		return;
> +
> +	dir = pasid_table->table;
> +	table = get_pasid_table_from_pde(&dir[0]);
> +	if (!table)
> +		return;
> +
> +	/* Cleanup everything except the first entry. */
> +	memset(&table[1], 0, SZ_4K - sizeof(*table));
> +	memset(&dir[1], 0, SZ_4K - sizeof(struct pasid_dir_entry));

(Not too familiar with Intel IOMMU / VT-d)
We seem to hardcode SZ_4K when clearing the directory entries. But in
intel_pasid_alloc_table(), the allocation size seems to depend on
max_pasid which could be larger than one page (order > 0)?

If the directory is multi-page, won't we leave the trailing pages
and full of stale PDE pointers that the HW could still walk?

> +
> +	clflush_cache_range(&table[0], SZ_4K);
> +	clflush_cache_range(&dir[0], SZ_4K);
> +}
> +

[ ------ >8 ------ ]

Thanks,
Praan
