Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0FE4D90D9
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535684; cv=none; b=PbNuj1HUMfm1dJxAIGyjkb9/hNxrR+eQV0K+2qFKmvSG4hpfRDO8bZKiefsEUFKSYMKu2DDcfj1rsz8HwzQEfUBjAvv1Z9G4ARTK6q1W1QYqrhG5/ysEnuFgQx/LpNTNPzQGzRyQsjSUoRwbyIi6Od+UC5bxooC+fTfVp8nuhME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535684; c=relaxed/simple;
	bh=/e3f6zy8+2O3SOV431n7I0SZEJjZUbJQmkF91G952Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9xIFzenbSjii5+RJPHjfqO2wBJExZe4X9aDd3X/8uPW04sIwCmAr6oVQqwdWVnhGj53fMB+gGIqYiAxkREdD2ypLqFHHP4hbPIYUOJ3v4lnteabqNSHxXU9huUG47Gydc5Cz3orkXiZLiTUl1qzXyITpcDkjwaS98BRpzf5hKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rzmbnNSm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rzmbnNSm"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so2775ad.0
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 14:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778535683; x=1779140483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s41dmpYUKpt1K9Yzx8SN6t8VShmt2QtfJ1wxqCwyx+E=;
        b=rzmbnNSmOWwpbUSedN3yPzv3qEczuKqa5r2SYB1KOFaRbI5XwacF/E4N6iFJ//2Lm1
         51TpwIrlIgWRQZZz0AfPzvFeKPP3depppG/ykQxWQZVyh3q2tN14C+kwt9zYzvgLO//I
         ldSl3yFSI5OEuVs+i+DhJ/C08Vqx8I2rXGKWI6QZKR16fQLShsKNyCQ7scaWa6j8X8E2
         tAGbjxrx2hQnFDraK+kg3wK7u+MVUB5uSaAiMm696DYtqlQZQ7kAw6ViqxkXnmm9fj/A
         qcHYD2tjaMU0CKkw4GWjQsCEjhsx5FrwPNsMwW4P+vodIzbbUVbyutDP0BKMBbpUMnZV
         vZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778535683; x=1779140483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s41dmpYUKpt1K9Yzx8SN6t8VShmt2QtfJ1wxqCwyx+E=;
        b=aypgsHwE4lr67SKYETcoTKEbMewo0Rrh5LsT+OGcpP4kQmBjVDf/tpSEQ2MgrefdZJ
         iNSR4DzDx7mvv9sQ6wOFD5FFjoN96ghRh46NrCRf7IA2x+ujRs3JX2/pGcqvh6xeTqfM
         kc6zNYXFII1zIPWpKo8oIfbmmFlkaVGgwlENGgh40l2ad6PbbXDt55TiZ5Rio/LXfh02
         R63A+lK/hv1mxen1pjs6YLA1A7PFlmYb7H2P9nWmV3XKDYIbOIW6v6GSK1GC0121Rd0d
         vo5DjdJM4rYfpDeWEiWJi+IMWOM5+PB7Wwc8/CQDizGBbykT6A192OlkbmM6OMt25XMA
         ycnA==
X-Forwarded-Encrypted: i=1; AFNElJ/OAmyiv971Tw0a8K1chkwKeORAEK/FvQBizrWz0eqWSXw5oVdh9ERk+V5WK1zPbRfaaUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUEQ5Q2Mjxu2EezaoNorSfNswCIJDSm+8ap2nZrs9qPYSNBDB8
	zNx5qG2kvJHlgB1y4sq0NYJp8QzLLXjWDNNBTQe78ZaAohzuwoq6Fxte7uLFhVwzog==
X-Gm-Gg: Acq92OFqJClnXevdjyBVjvpEAY6ctaziw4gPbPLTPpkUGsRpWK+IQwo6QOdWCRF3ApE
	ZwoAlgbptE0Aldulm537phvsfSjpPUQ4xTGhUEbunK3otNhmYNX4SEorVIWUG8WiCZiYUaLRNim
	OZfBDsNHD+uwqjHIrmPC9jdadOIlwr+4jpPM/fAPV3yEQgJa4Ytzza3igiIvW5gVzIwGCf8npTZ
	D8OI6tylfJ2j385hGiJqNf0gM0wbinXe2lKZr/6awe2pvUXyZC1ZYige4FHtBa+vS+bAh7FdFsz
	OzMF8r2kYGkH4dfLLob6AYSnLLnoocHdKkOmbAW7EB5ICvzyu6MvD/D6eUTroU08VBY8USwK4cF
	Yw4s0PF+QzrvE+l8XqcXuaiotq07dgd7vgFZSrLMCxvSKQ37mbOPclVdLWNDXVo2kwxShHYrXYB
	hXLGITig3MoEre+LQIp0sZV4p1ueVVtY0IbawyA8C7yiKq+NJZ4BQVERtQthx+ZHCBWcJ1rQ==
X-Received: by 2002:a17:903:190:b0:2ba:dfa:328d with SMTP id d9443c01a7336-2bd01294a6bmr914625ad.1.1778535682176;
        Mon, 11 May 2026 14:41:22 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d63b952bsm8644567a91.9.2026.05.11.14.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:41:21 -0700 (PDT)
Date: Mon, 11 May 2026 21:41:18 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Aex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	Alex Mastro <amastro@fb.com>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vfio: selftests: Add support of creating multiple
 iommus from iommufd
Message-ID: <agJKOnHZdsQ71KLw@google.com>
References: <20260505221518.619123-1-skhawaja@google.com>
 <20260505221518.619123-2-skhawaja@google.com>
 <af4or28EA6PGEd12@google.com>
 <agI2EFvBwKUHaHVi@google.com>
 <agJDSaAmZYv_5byL@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agJDSaAmZYv_5byL@google.com>

On Mon, May 11, 2026 at 08:59:53PM +0000, David Matlack wrote:
>On 2026-05-11 08:21 PM, Samiullah Khawaja wrote:
>> On Fri, May 08, 2026 at 06:17:19PM +0000, David Matlack wrote:
>> > On 2026-05-05 10:14 PM, Samiullah Khawaja wrote:
>
>> > @@ -478,11 +483,7 @@ struct iommu *iommufd_iommu_init(int iommufd, u32 dev_id, u32 flags)
>> >        struct iommu *iommu;
>> >
>> >        iommu = iommu_alloc("iommufd");
>> > -
>> > -       iommu->iommufd = dup(iommufd);
>> > -       VFIO_ASSERT_GT(iommu->iommufd, 0);
>> > -
>> > -       iommu->ioas_id = iommufd_ioas_alloc(iommu->iommufd);
>> > +       iommufd_init(iommu, dup(iommufd));
>> >
>> >        if (flags & IOMMUFD_IOMMU_INIT_CREATE_PT)
>> >                iommu->hwpt_id = iommufd_hwpt_alloc(iommu, dev_id);
>> >
>> > > +
>> > > +	if (flags & IOMMUFD_IOMMU_INIT_CREATE_PT)
>> > > +		iommu->hwpt_id = iommufd_hwpt_alloc(iommu, dev_id);
>> >
>> > Does this need to be part of iommufd_iommu_init()? Maybe it would be
>> > better to expose a separate helper to allocate a HWPT for a given struct
>> > iommu *.
>>
>> Hmm.. that is interesting.. I think we can have following immediate
>> possibilities when creating a struct iommu (there will be more down the
>> road, but can be handled in similar way):
>>
>> - create using struct iommu with a new IOAS.
>> - create using struct iommu with existing IOAS but new HWPT.
>> - create using struct iommu with new IOAS and new HWPT.
>>
>> I think I should probably add following flags:
>>
>> IOMMUFD_IOMMU_INIT_CREATE_IOPT (IO Page Table) or _PT
>> IOMMUFD_IOMMU_INIT_CREATE_IOAS (IO address Space) or _AS
>>
>> At least one of those should be required when creating new struct iommu
>> from an existing one. WDYT?
>
>I don't love the idea of passing in flags to control the logic,
>especially since not every combination of flags is valid. And also tests
>would be required to pass in dev_id even if it's not needed (first
>possibility in your list).

Agreed.
>
>Maybe add explicit helpers for each case?
>
>/*** static (private) helpers ***/
>
>static u32 iommufd_hwpt_alloc(struct iommu *iommu, u32 dev_id)
>{
>	struct iommu_hwpt_alloc args = {
>		.size = sizeof(args),
>		.pt_id = iommu->ioas_id,
>		.dev_id = dev_id,
>	};
>
>	VFIO_ASSERT_EQ(iommu->hwpt_id, 0);
>	ioctl_assert(iommu->iommufd, IOMMU_HWPT_ALLOC, &args);
>
>	iommu->hwpt_id = args.out_hwpt_id;
>}
>
>static struct iommu *iommufd_new(int iommufd, u32 ioas_id)
>{
>	struct iommu *new;
>
>	new = iommu_alloc("iommufd");
>
>	new->iommufd = dup(iommufd);
>	VFIO_ASSERT_GT(new->iommufd, 0);
>
>	new->ioas_id = ioas_id;
>
>	return new;
>}
>
>/*** Public API for tests ***/
>
>struct iommu *iommufd_new_ioas(struct iommu *cur)
>{
>	return iommufd_new(cur->iommufd, iommufd_ioas_alloc(cur->iommufd));
>}
>
>struct iommu *iommufd_new_hwpt(struct iommu *cur, u32 dev_id)
>{
>	struct iommu *new = iommufd_new(cur->iommufd, cur->ioas_id);
>
>	iommufd_hwpt_alloc(new, dev_id);
>	return new;
>}
>
>struct iommu *iommufd_new_ioas_hwpt(struct iommu *cur, u32 dev_id)
>{
>	struct iommu *new = iommufd_new_ioas(cur);
>
>	iommufd_hwpt_alloc(new, dev_id);
>	return new;
>}

This looks great. I will update in next revision.
