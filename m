Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99A3E958B
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937690; cv=none; b=PrOUMJKlHynHGuruQiQ8L715K79Nb+vDaPvQXgB0Wp3G3CyTybj0b6btHPQO+XW7WZC02ctG4XwC/uqPztnq7UcjeC4rMG9ME2xkz9ajysVKKOR+EDg8+vFenpxqfAKPMsTtaV2LN+sxj/QBJQCCQ2XO+Ab5PdwvItiUvt9DQxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937690; c=relaxed/simple;
	bh=Ci8R0RcgT3R07Pso4NtY3exaPjxumuK/t2Ur7NUnLVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is8HZovtpDVe/Y6TLvLLUiRnX4LJE0LQUoAyYRg+7lL7KXv3SXNX9V5b6hiV3JYT6HGIMx46uvR7o+81EYgI50oTY5GF+z1wR89uybdmavq79Y6Qp3TFumsK1j/Cz6FFZuNpL5pbQ73t2FJqzvoN/Q+6YqrwSICs9oSVcdB7/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JUYoEJV2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUYoEJV2"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aeab6ff148so89525ad.1
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773937681; x=1774542481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8zoqnsuMjvOgf8bCpxiEMnB3Rfs/RX4TqY+c0PAvBo=;
        b=JUYoEJV2I23Pb7HDhu9gporUfMxEnK05ZUN/YHAL/eesTH9I8P/YP0cFgmIaw13WRK
         nPHKxetblPJBSg+REqN42YHOIXu+IfZGfF59AtAkduLG0Jb0kkYrNnVNR+fDUXB9eJze
         HPp3BySkKS62ZXwKci8izzIMvByLPvg6/VBmeqUWRl0sAPXL86OmRC59DKXEYjK62vin
         Us8xhWdCHa5T1I741ZUAkG+3f/5AmaxHZ3Eij2JfWwhewqTiUcPij0ZmBrNsm+bAKbGv
         o6GvJE07rDT+7s803Ev4skdFCEy/aaSAW5N31FLFMD+BpMzlgax+MfznkMQzBN+uptpJ
         YLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773937681; x=1774542481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8zoqnsuMjvOgf8bCpxiEMnB3Rfs/RX4TqY+c0PAvBo=;
        b=mGatnaAC5sMKjFK2cIZopLYEJ9SQMyLMai2lrVdFH2HJcC4S4Jok5PQAYOwNyIwDeU
         UdAMceyNJIND3avqXDrM8z6C8sMEJ7jDMXd4wYmtSblOJoI+1/EpOgqwvmmEp3iFaRkY
         JhZiEX63YcEdqsGHp5QVRLm+Ftt4Vl6pYmFASEvHp+Zu81cJR6DE3vNmZf5Bf/xOx0v5
         nXhdC1D/kZdg6qWUqzT1ANAWXVxMKKvsimGIat0U+cmwqmoHvobmx6xYyyzhfnONinS/
         vdn03XagyKxNkSiHqFUo2xJNO9w/JWcXpOShODr4lY0wlwF1KgZRbePMxbzeu45Fmm8D
         HMQw==
X-Forwarded-Encrypted: i=1; AJvYcCWxlPAg2RSorvl2+aFEmtGswjAw5qXIEt8ouJ2qTFWwltNPHQYxf/pRMcoxA6+HkhM+IKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMVI2Wz37xVXbC+L1uRRY4iMIXWb43nimlP+ciLNPvi2lqpeBp
	/l4Q6z/Hdkj2Cd7RyyR+3Vw2w+Ih5g4nPRTerzPEZtoWBAW0ckg6LGTM2B5bJbYkSA==
X-Gm-Gg: ATEYQzzf7p1s9PNRhApRHL2ViS0Eq5qX8pmEJQXgSXvh8ye1b48mOpN/VBuJDe7SFP4
	sf5wyPD0PF3DSLxnIA4NkZwFyB9p5ZYBVWaxKqggHe44uNdIvOvF3fIFsqJngMmP6ubydIMuod3
	9ovMFGFmP55kNHU4Todqr0FHLLFv2fNoI773MEAaytOXgWE/haTdEqg2P88qIizuDcHx02uKao4
	wyDNEgRivs5WSHMeSqDf0WZmdqRJmW7SlSUufKhF0r/N1TCGNbCYsY55tOTQ88ci3npoX0z3CEx
	VQMpHQJsgplAuL+ST+Wh1KYOoXnFbrEzCr0IVsESg54MMJwNyajEMDqb9NASjFyNGIjTMZLR7TP
	rK7IW0NDR0uULSmr2xBkki/U4gZRELQuPujogeMK9tzCax+LuO1s7/jcIEQRx6Rrlx/uou23F6I
	gannKbr2S0kW9Y3xQd1a6oQrOHGqkGEjzPMJDBrjHfCbqaFHxkzrtS71JI70Ufug==
X-Received: by 2002:a17:902:ccc4:b0:2a7:d266:d84a with SMTP id d9443c01a7336-2b079fbb39emr2323775ad.17.1773937680332;
        Thu, 19 Mar 2026 09:28:00 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e5691b8sm5635536a12.25.2026.03.19.09.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:27:59 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:27:55 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
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
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 06/14] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <abwg_tuERUKIsdfH@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-7-skhawaja@google.com>
 <20260317221907.GD2582517.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260317221907.GD2582517.vipinsh@google.com>

On Thu, Mar 19, 2026 at 09:04:31AM -0700, Vipin Sharma wrote:
>On Tue, Feb 03, 2026 at 10:09:40PM +0000, Samiullah Khawaja wrote:
>>  /*
>>   * Take a root_entry and return the Lower Context Table Pointer (LCTP)
>>   * if marked present.
>> @@ -2378,8 +2379,10 @@ void intel_iommu_shutdown(void)
>>  		/* Disable PMRs explicitly here. */
>>  		iommu_disable_protect_mem_regions(iommu);
>>
>> -		/* Make sure the IOMMUs are switched off */
>> -		iommu_disable_translation(iommu);
>> +		if (!__maybe_clean_unpreserved_context_entries(iommu)) {
>> +			/* Make sure the IOMMUs are switched off */
>> +			iommu_disable_translation(iommu);
>> +		}
>
>I think instead of having a "maybe" function where it might or might not
>clear the context entry, it will be simpler to just make if-else
>explicit here.
>
>@@ -2375,8 +2375,11 @@ void intel_iommu_shutdown(void)
>                /* Disable PMRs explicitly here. */
>                iommu_disable_protect_mem_regions(iommu);
>
>-               /* Make sure the IOMMUs are switched off */
>-               iommu_disable_translation(iommu);
>+               if (iommu->iommu.outgoing_preserved_state)

This is only defined when CONFIG_LIVEUPDATE is enabled and would need
the #ifdefs :(.

But I can add a function, iommu_outgoing_preserved_state() or
iommu_is_outgoing_preserved() that would return NULL or false
respectively when liveupdate is disabled, in the skeleton patch to check
this.

I will update this in the next revision.
>+                       clear_unpreserved_context_entries();
>+               else
>+                       /* Make sure the IOMMUs are switched off */
>+                       iommu_disable_translation(iommu);
>        }
> }
>
>clear_unpreserved_context_entries() will explicitly do what
>__maybe_clean_unpreserved_context_entries() is doing.
>
>>  	}
>>  }
>>
>> @@ -2902,6 +2905,38 @@ static const struct iommu_dirty_ops intel_second_stage_dirty_ops = {
>>  	.set_dirty_tracking = intel_iommu_set_dirty_tracking,
>>  };
>>
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +static bool __maybe_clean_unpreserved_context_entries(struct intel_iommu *iommu)
>
>Nit: s/clean/clear, this matches domain_context_clear().

Agreed.
>
>> +{
>> +	struct device_domain_info *info;
>> +	struct pci_dev *pdev = NULL;
>> +
>> +	if (!iommu->iommu.outgoing_preserved_state)
>> +		return false;
>> +
>> +	for_each_pci_dev(pdev) {
>> +		info = dev_iommu_priv_get(&pdev->dev);
>> +		if (!info)
>> +			continue;
>> +
>> +		if (info->iommu != iommu)
>> +			continue;
>> +
>> +		if (dev_iommu_preserved_state(&pdev->dev))
>> +			continue;
>> +
>> +		domain_context_clear(info);
>> +	}
>> +
>> +	return true;
>> +}
>> +++ b/drivers/iommu/intel/liveupdate.c
>> @@ -0,0 +1,134 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/*
>> + * Copyright (C) 2025, Google LLC
>> + * Author: Samiullah Khawaja <skhawaja@google.com>
>> + */
>> +
>> +#define pr_fmt(fmt)    "iommu: liveupdate: " fmt

>Should this be 'DMAR: liveupdate' to be consistent with other files in
>intel iommu?

Agreed. Will change.
>
>> +
>> +#include <linux/kexec_handover.h>
>> +#include <linux/liveupdate.h>
>> +#include <linux/iommu-lu.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +
>> +#include "iommu.h"
>> +#include "../iommu-pages.h"
>> +
>> +static void unpreserve_iommu_context(struct intel_iommu *iommu, int end)
>
>Nit: Can this be unpreserve_iommu_context_table(), similar to existing
>free_context_table()? Same for corresponding preserve function

Agreed. I will change this.
>
>> +{
>> +	struct context_entry *context;
>> +	int i;
>> +
>> +	if (end < 0)
>> +		end = ROOT_ENTRY_NR;
>
>Can't we just pass ROOT_ENTRY_NR as end value instead of -1?

Yes, we can do that. Will update.
>

Thanks,
Sami
