Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119FF23EAB7
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383165; cv=none; b=QgdgF1kV08aTGJHA9D+cE0fKWrnLNdx59Xu4Ig+z8P6/J3HJsItMhsQPhGPJuvEhBu0vu/jivJ9ENlkAWdVuREyA5KAc2kgo4i1o++Ikwjbn6x4v+HAZxXwfSSOtG4pvGSMeri8SYy+AxRxguZ1V9WFIeWHIblt5r3J65oLUSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383165; c=relaxed/simple;
	bh=OBtHITb7VyAfG65rc3vNJZbZRx2OGMc+kiXQarGPOUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLlh+mXofzO+Cqk0z+W52qDh4W8OmXWG8N60of5QmYe0UFnMUOCRUwx4ou/xheVV41wxqSOOBsum6MgAn6nu9yfF+aO3nwZ71UcwDgDQzrhMxiVzWQ9DoiwufKXmVzqHY5BAzQioH/NZAzTDHAx9KW0kZguwUvUzJHYMuXtHV3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NeMpC+xo; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NeMpC+xo"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-68244d317e5so6662237eaf.0
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 06:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777383162; x=1777987962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qPdjCZsKcHNqWuo5+pnokV+zhe1DyX7GyGi+9Un3LHM=;
        b=NeMpC+xoKV3v7+8TAPcyBWb+COaRaInejWu+sp7LshYTjMvgUCwyBXiCbt+p7eUJm8
         vbVNKfVYwBigwVcgoFpoMsniMKYbb2P+7CPX9jMfzLZZtTTiIdcroXL/xR7cJTM8N1Jw
         doSckzV5VqTxzhBPrJbc7x0JI+KljWf0Y8FMEB6UW3EpGtFg0vMsrCqYkzoltiORwBXu
         3cm+Z2J1CjWjBg3NCLiZ2DOliGxug/CmTeplnQ10n4fLI7e2j60OgVL1iWGKqox/7D10
         MTbFjMGo2r8X/VcejPUnoDKzGzClEoC6EIGi6RRJ+psNdq89L8CElTPUyjyCVpFnKbcg
         368Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383162; x=1777987962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPdjCZsKcHNqWuo5+pnokV+zhe1DyX7GyGi+9Un3LHM=;
        b=LOv5ab7MUOXIj7XS1ZRGdwGrjz7m1F8NiAehTh/W5zNkMtDzINKppny4AkaJmMqT1v
         wu18g1k4XBZOQJwPng34L1pTgUj1xUexV9QPoIdzc5DmlhFyj8H/cwcMsceTgVUmhBVD
         fiabK3R+HXk3gBu1NQTn8dmyBZdKP0WmdYkOzG5zogFIeA/knw0vB4rHNdDSO5RKKZlS
         u8dEDkLRI7A8yMtM4HzxawqMAMjHR3c2p7GDDj9gqjyUKuV/skQfu2SWJYes3CdPEl6B
         zXZRB2qBBVTxvkSkzP/jYaXurUn0m/MCQ6bTnc7yBiwAwxXLPn3bmavhv2eVyCZQ13j5
         mJYA==
X-Forwarded-Encrypted: i=1; AFNElJ/XQHaw0yOmL1zP/KLcxvUKadE+ti1C5UFDdwbU9pUbasAoKSdjB8K9Ez9zp9MurUDKzBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3OOfOP8YIITTCPOaVTQcT0WsFI+2pEGtwgqa3JGYt1DkO68bF
	uxbgpIwgkLhVmiy4LYycxHk6W5Th7T6RSK8LZ6P1FRNudsv0Xtxn03Eqdzm73tgjWUw=
X-Gm-Gg: AeBDievqlsCAZkIEL82zBIKtz32IkN0mpXuhnbviWqFqu3Frryr9d5MalGFNa2NRoAs
	+l8kR2FdYwuUtvrCXhAmt57puEHdXmkFtOHVPLoGm42R6VihmDdUo69ZQNqsQI3nSnsvxK1FdHo
	LNcz4byg5j1773ReZf5AGognlgUuviaBGK9Xpj99ZQHZZ45K6DZWyhe25yGyZEsfAkOWYMgorSM
	XZmJ7hQO82dx11ZtjLVujiovAoWjeJjv8HaXAVNK9xSf7THuRoTcILROhQOwcELyzj5Fq+Unxp8
	YYRCaZT3sjDaQFMMIaDWDEjtIx/O2c95A7SQ3LQX7NCWf392GbBZN3OVvVd3WG2UGve9by131dt
	3bNSEO7aZmH4RZCgKVry8BKIRVDzLqMImqAWY129+VB1KJ1NVe3DtnJ5st3lEMgLei41NiswSwy
	r+BK03KanoszVtxEaBJBm2pBg+NgSjmpfwyyj3PrmVRNVQ55UQ27qKQc1OgXDJA0MDIEwE81B7y
	3cMYL1+h3728AwL
X-Received: by 2002:a05:6820:f008:b0:694:8683:3867 with SMTP id 006d021491bc7-6965cbbc6e8mr1334311eaf.46.1777383161926;
        Tue, 28 Apr 2026 06:32:41 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c48c71f3sm197040285a.7.2026.04.28.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:32:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHiYJ-0000000AhcL-1zNy;
	Tue, 28 Apr 2026 10:32:39 -0300
Date: Tue, 28 Apr 2026 10:32:39 -0300
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
Subject: Re: [RFC PATCH 01/11] iommupt: Add RISC-V Second-stage (iohgatp)
 page table support
Message-ID: <20260428133239.GC849557@ziepe.ca>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
 <20260428131359.34872-2-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428131359.34872-2-fangyu.yu@linux.alibaba.com>

On Tue, Apr 28, 2026 at 09:13:49PM +0800, fangyu.yu@linux.alibaba.com wrote:
> @@ -263,6 +281,22 @@ riscvpt_iommu_fmt_init(struct pt_iommu_riscv_64 *iommu_table,
>  	case 57:
>  		pt_top_set_level(&table->common, 4);
>  		break;
> +	/*
> +	 * Second-stage (iohgatp): Sv39x4 / Sv48x4 / Sv57x4.
> +	 * The top level is the same as for the first-stage counterpart.
> +	 */
> +	case 41:
> +		pt_top_set_level(&table->common, 2);
> +		table->second_stage = true;
> +		break;

Second stage needs to be an explicit PT_FEAT not implicitly deduced
based on the vasz.

Jason
