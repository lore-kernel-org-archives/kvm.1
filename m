Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6B4381AE3
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162854; cv=none; b=l3HoTjb+77HE9ce4iexoCLEL++qchFJg4PnsEarkWo2dflmP7OkEjbZZuHT1b4O/opbKJ7PCDriy6IqERwHvmcOutrAoRYMqoRfZkNdJ9vEQSTBX/EbidDsIQ8dzHjZUmIacp39intAgfkRGynPvEhdK9olJAYOdSGoZq8mw52Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162854; c=relaxed/simple;
	bh=X82haFxsdgKx1jjnaKgCGlknhRGQInX8s7YpCkTIPnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trlgTDNZ00mLZ+On5ROMwjbFJCBLKjxPaLanFCjbEruxQ3Z/rRkYwWKaqas/4yysGSqPxsHSUPw+LsNMci1qYvbAaEB96suc+VSRKv2DKdOm4WSCprRuDuBZbIvtN/RkTJEX1n//HHNFRJO9n+yxt455ltV1i0qd1n/fQcezUbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NhjLXRzh; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NhjLXRzh"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93cc1ab5f6cso4586985a.0
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792162852; x=1792767652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qAdHy+XfZaVWAHH+k3kEYHLQsWiJDDa9Am4rmLNBNPw=;
        b=NhjLXRzhLV4Mw3/IIY7KSa+yogOWqwD77ounn2r61fuSD3eugTgZ5D+v7Y53D1Cc90
         CEJStPx7qou9+2Lt7NYh3/zx8J41AHLOW7Y7eWUrMBNPXY2303fzPQ1/cKSXesHoOhVH
         yI2bz+bR0AjD14lz+xoI7AC9V/e961mTzfQEnK3uQB2ywfQhrYyznf9JzWja5U+d8/jw
         fHGVoz/oC56ejsg4VKDNjcd0//KRcTU+7V/TgNMRnWkTkQTYxnWFjeq7YH1zrum/ru1d
         MGkhtxi25MFzzjwSEt018Ks4vJ7u2vrIKnbj8dTLRmLbc5zQi3vJPmbz/m+g/C7hRU5P
         597A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792162852; x=1792767652;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qAdHy+XfZaVWAHH+k3kEYHLQsWiJDDa9Am4rmLNBNPw=;
        b=lZDXTY3P76je27uz5CWkL2ae0hmsot5vgBX74WqFQ+/mb58gxNrJK623qaSWSOYtZB
         6BK/k4JQR3orb2uCv2Z+nBF2LxiDzYb1yOjb3fTIHR/1piY2wSfFf/0Iq/vd8jr2vdIT
         K1RllyhX//AnABozkDyKPe7YWzlcAeiOPp2KQ3mH0KWOp52/sSztq0+AH+j7mQjvG3ta
         4jao1Da3tUIyeYN+EP1258itC+YiZBp7q0rNKookAMPn0zBd3qlNNBKZioLc9rkV+ZhW
         MjYDeHD9W3XQ1JQMITEriz72BSawo8KgSI1AtANxS04SaGxl9CAu1Uvy6zH7xoFi/CLO
         gOXw==
X-Forwarded-Encrypted: i=1; AKwUvBzj3bKzXnQ3LnVT4XjCtlEwXtdEBOR+4mdCrvzzME+ZeSVarxLCwbGA7mPm0P3SISdavUU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2Zo8B66dRzom7m6SSZlaReC4ovNYJEffIo7FbglQtgVeN3SJ8
	Qt5E4hq7Bl+yvFMqtfsmBaMX1IMFgKK1jGzMwmDAp1jCFf92XQW+qXaUfru3S9TQ5js=
X-Gm-Gg: AYBFou2L8lOoz+2xYxeiop2jWhlr7WNM3lJkGvkWCYMQkvOIFEjAGwhZSNbP65NuOyC
	yOUVEPfPMHTKNclfN5u8/de0aDW4D+ysy4fL4tIUCOOTZ2fhlfhiyynjF6eKooiQDQ3bhnjwr/A
	y+BpJYBR3vexwzPrXj8xu7z/Wo+YlLU0GBu9zFSgoV6TUjpHcm5PwGyZ6fuTBtjXilhshBlDqFD
	CAjx99lSbOoYdzVOudDrP/ui5tzroTTs26wr9WNDNvFvrhQHG8CzeXjxlJ9BqWr01MwQGsvoE3z
	9AIWg5DRPIbrzMypWFCZut+fzKj3PrfQLvRYkInZ3ojENiJpg84f4o6CkMMedd0CWRL0Nrx5nqC
	ot4RT5cktop6N2Cy0I7sxQkhIpS6MkAx8vxCq2k85s8t4e1F+j4ZZSH0YHm+nzrYmrmnPZu+p6z
	AkTH+spYNULaRZZ8WeYFyz4QGXNznExoePH6yvty8DjxNe8bBFtMiWHUvnHz8zgGRJRpAgYS6t4
	z6ES0tKno7vDkhJMGQyhd2+CR5JTXZLC+RYKoV8N0g6ASVy/p1g58BV
X-Received: by 2002:a05:620a:40c3:b0:93e:646c:9133 with SMTP id af79cd13be357-93f29da5d84mr10749685a.64.1792162851675;
        Fri, 16 Oct 2026 08:00:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a0d0718sm232558985a.5.2026.10.16.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:00:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHjQP-00000001teG-31SO;
	Fri, 16 Oct 2026 12:00:49 -0300
Date: Fri, 16 Oct 2026 12:00:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: alex@ghiti.fr, andrew.jones@oss.qualcomm.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atish.patra@linux.dev,
	fangyu.yu@linux.alibaba.com, gsh517025@gmail.com,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, pbonzini@redhat.com, pjw@kernel.org,
	robin.murphy@arm.com, seanjc@google.com, tomasz.jeznach@linux.dev,
	will@kernel.org, wu.fei9@sanechips.com.cn,
	zhao.qingye@sanechips.com.cn
Subject: Re: [RFC PATCH 02/12] iommufd: Add RISC-V IOMMU hwpt and vIOMMU types
Message-ID: <20261016150049.GG14213@ziepe.ca>
References: <20261015235400.GZ14213@ziepe.ca>
 <20261016073020.10119-1-gong.shuai@sanechips.com.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016073020.10119-1-gong.shuai@sanechips.com.cn>

On Fri, Oct 16, 2026 at 03:30:20PM +0800, Gong Shuai wrote:
> Hi Jason,
> 
> Thank you for your review.
> 
> > > +/**
> > > + * struct iommu_hwpt_riscv - RISC-V IOMMU stage-1 page table data
> > > + *			     (IOMMU_HWPT_DATA_RISCV_S1)
> > > + * @tc: Guest device context translation control
> > > + * @iosatp: Guest device context stage-1 root page table pointer
> > > + */
> > > +struct iommu_hwpt_riscv {
> > > +	__aligned_u64 tc;
> > > +	__aligned_u64 iosatp;
> > > +};
> >
> > Like the others you need a spec reference explaining exactly what
> > these fields are.
> 
> I'll add references to the device-context sections of the RISC-V IOMMU
> specification ("Leaf DDT entry", "Device-context fields", "Translation
> control (tc)", and "First-Stage context (fsc)"), and I'll also include
> detailed field information, as ARM does.
> 
> Also, I'll rename the field from iosatp to fsc. It holds iosatp when
> PDTV=0 and process-directory-table pointer (pdtp) when PDTV=1, and the
> two share the same layout, so the name should cover both interpretations
> and the uAPI won't need to change when Process-Directory-Table (PDT)
> support is added.

You might be better off just to have a data[] array of the device
context. I prefer the fields are not parsed out in userspace..

Future specs may add more guest controlled bits and in other places?

Jason
