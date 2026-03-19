Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07E3ED5DF
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936278; cv=none; b=YQoKU4zVj6w9hHDESKY89hOwue1rU62w/oEgV/sjia065X5cflKsMUE1ubrvKFkHKq3HUCxNVS1/UVUlR9SIUk/2kykPITovFaTIIZn1V+LGPIHwfvJcaBDNt/frxR8LZgprpS+4Vv+CtudqLoe0fylgKqzbItu/KC6jqjmT5oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936278; c=relaxed/simple;
	bh=dfS2Q8fq6arO/G/n+oqxc0mTgErVibxYeHUwv2jGQuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8Dd2NiRYkCOIyOURnWHrF/QAgpq+elXXKI0A4N9wGle14tjHJ3GtSfZZuMMeJxW9dvkaWgzfmz1hbN285u1tmIjnCoYzTmDTasj52gDStgsRHwpF0NONZn4W02H4G0qo5k2XeMXwakHtJE5Lcy1vODxdlOYKMHAC7cg4QK1Rng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+yIEz4p; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+yIEz4p"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aeab6ff148so86245ad.1
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 09:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773936277; x=1774541077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NSymXHBx0EVLNRB8aixQ7qsvbdQ8KkgdXax/b9Pc2mw=;
        b=N+yIEz4pWSeRTgSzyCk3qQKxPomVvtNJGofGvDbDRK9Li9UjLLajkj1vd3lS0L09sS
         dxBvGFbINs5Ln9iLC9nypeoItu0ie2y889J3nacO3yt2qXjiHwhJZpmxkm8V6CVVPisW
         Byr8cwI+eUlyJJ6HmZTl1CiAkjMQU6joLDXYJBjmSPk3L8ICLoYTBglGRIsFA2enXAVV
         qTXLtzDV+ybd45vCNdhRkZUoqrEb8mgjbsjU53QQqfyB82SL9RT4fWkLmJiotandMA64
         VOx66eEoJ+Fw1e4sElFkgtPtiz4Jn4BNYPEt63ZjP4IOHKMOg1ypObSrEQPDqfiq33Ug
         Z0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773936277; x=1774541077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSymXHBx0EVLNRB8aixQ7qsvbdQ8KkgdXax/b9Pc2mw=;
        b=j09W77iGmGcqbXM3DUROUINdU/kGSgTgPXhtCpHlCTsD1Ddl/cIbUhQ1MEG/kwsltU
         qub2mpHw3r7x8ux8++inTnyfjI+oKdNLE/XqcAlqBdOdC8d/n2KcDn0UK77mCcxmbnMS
         3wpQuYe/7RNIHpbgaDkVfDYyoXrIz/Uej5UE9uSdyoHt/y98lgbN1CmCh2MQLIQ6Ks75
         w1wALU23pRTIO28Q6upv7BUA3Va7HKSOW+6CflmSeUQHarjsklnNOZQcN0yEaNjDWTjk
         lw0VDrmPyPsBBiZXZwEgTe/XOZyYiP/EWp/o7LLVgLChsKzfcsGYDSu7y+1l0qs8NE7i
         cibg==
X-Forwarded-Encrypted: i=1; AJvYcCVvtaJCqYeX4ZIvjYln0Nwywsm83nakKOI4M8d8sUkLL+jm9j826pnIBRk76RL0JN/xEAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE+ScabjcKTL5s+AC+pHNhv2jfbWWT4/pVPo5oi4SZec9AxCNR
	apTwJEDcKwalbdQ0zrvxP1CsRhrrchLJP5Hp3T814XGtyHhE3cJVd/kpfasNgiYZ8A==
X-Gm-Gg: ATEYQzzR6FLtwNfM694YeRerUT2h3pV18EkuHBbq75pK18uFMPCDKbYPs2cXlOyQrql
	9J18L83JSI6rwBE5r5ehrPRKzCTB3GzNTgclhncm75TNSgkRXpDuEsAtC6Q5RmyJnXlmMGP7vbJ
	5JvckeydUFEkWCOyCgkSs938u27QtbksFZHai9fdEPFR5VigoQo4pEOELvDyt2FwainFLDGOkvO
	sZaDRziPssZh5MiMw6MtJ5Ld2SuOvlwIXBSE+R56jDb7FQEpOO3sTdV/so6SexnS/l4zRx6a4Mw
	ewGUNP4SSQ1BaezirzXPA8hFmabTSahZ75IS8Zhb0eYCzRtvwzwxGJMoElg5aCEypeLBC4JkxmP
	7vZWHqfWf0b9QMQR1tpwwQxipTcioi3lp/ELjapDsS8PgofV1XMDUDe3YstZX7iwew2lSsgzcYn
	F8siOLT4WtD3LSZBNfXiRaD2BP6Xh1sdgOMj92LpX1uOueQ6L8jzjxh6Y8SaD/5bGGrDMZXj8=
X-Received: by 2002:a17:902:da8a:b0:2a1:3cda:8e99 with SMTP id d9443c01a7336-2b079fd1340mr2824065ad.21.1773936276089;
        Thu, 19 Mar 2026 09:04:36 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e0b2015sm5917787a12.6.2026.03.19.09.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:04:35 -0700 (PDT)
Date: Thu, 19 Mar 2026 09:04:31 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
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
Message-ID: <20260317221907.GD2582517.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-7-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-7-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:40PM +0000, Samiullah Khawaja wrote:
>  /*
>   * Take a root_entry and return the Lower Context Table Pointer (LCTP)
>   * if marked present.
> @@ -2378,8 +2379,10 @@ void intel_iommu_shutdown(void)
>  		/* Disable PMRs explicitly here. */
>  		iommu_disable_protect_mem_regions(iommu);
>  
> -		/* Make sure the IOMMUs are switched off */
> -		iommu_disable_translation(iommu);
> +		if (!__maybe_clean_unpreserved_context_entries(iommu)) {
> +			/* Make sure the IOMMUs are switched off */
> +			iommu_disable_translation(iommu);
> +		}

I think instead of having a "maybe" function where it might or might not
clear the context entry, it will be simpler to just make if-else
explicit here.

@@ -2375,8 +2375,11 @@ void intel_iommu_shutdown(void)
                /* Disable PMRs explicitly here. */
                iommu_disable_protect_mem_regions(iommu);

-               /* Make sure the IOMMUs are switched off */
-               iommu_disable_translation(iommu);
+               if (iommu->iommu.outgoing_preserved_state)
+                       clear_unpreserved_context_entries();
+               else
+                       /* Make sure the IOMMUs are switched off */
+                       iommu_disable_translation(iommu);
        }
 }

clear_unpreserved_context_entries() will explicitly do what
__maybe_clean_unpreserved_context_entries() is doing.

>  	}
>  }
>  
> @@ -2902,6 +2905,38 @@ static const struct iommu_dirty_ops intel_second_stage_dirty_ops = {
>  	.set_dirty_tracking = intel_iommu_set_dirty_tracking,
>  };
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +static bool __maybe_clean_unpreserved_context_entries(struct intel_iommu *iommu)

Nit: s/clean/clear, this matches domain_context_clear().

> +{
> +	struct device_domain_info *info;
> +	struct pci_dev *pdev = NULL;
> +
> +	if (!iommu->iommu.outgoing_preserved_state)
> +		return false;
> +
> +	for_each_pci_dev(pdev) {
> +		info = dev_iommu_priv_get(&pdev->dev);
> +		if (!info)
> +			continue;
> +
> +		if (info->iommu != iommu)
> +			continue;
> +
> +		if (dev_iommu_preserved_state(&pdev->dev))
> +			continue;
> +
> +		domain_context_clear(info);
> +	}
> +
> +	return true;
> +}
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (C) 2025, Google LLC
> + * Author: Samiullah Khawaja <skhawaja@google.com>
> + */
> +
> +#define pr_fmt(fmt)    "iommu: liveupdate: " fmt

Should this be 'DMAR: liveupdate' to be consistent with other files in
intel iommu?

> +
> +#include <linux/kexec_handover.h>
> +#include <linux/liveupdate.h>
> +#include <linux/iommu-lu.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +#include "iommu.h"
> +#include "../iommu-pages.h"
> +
> +static void unpreserve_iommu_context(struct intel_iommu *iommu, int end)

Nit: Can this be unpreserve_iommu_context_table(), similar to existing
free_context_table()? Same for corresponding preserve function

> +{
> +	struct context_entry *context;
> +	int i;
> +
> +	if (end < 0)
> +		end = ROOT_ENTRY_NR;

Can't we just pass ROOT_ENTRY_NR as end value instead of -1?

