Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C2E31AABC
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156283; cv=none; b=TnZudULHXa+QZzUSfD3qwxFIpdwQhGYSb6u8m+emM+DPlbTQGvHgu4kykQHQwyVt1Az/i2V5LoQOOmBBn3kUaF87S1cu8hx8oyrvT2oeXpZ25v8g81HjWdhRGucFegQ9IdpYnncS86nod7u8HPvllrCUJ4kUIqYyYSW49TslVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156283; c=relaxed/simple;
	bh=yy9KYO3WfAu42aqR4kwhL9S1z10fN8BxMXNkSzlVq0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMIQFIcOXyio0qrRBrpwBnfiWVRs0ILJ46m+W3TXxB2TVtQo2OKu9/Yh+/8DtlXgizrrKzBoTIlUlvS/K/+zUlF86sUPs/yEkVVa+yhE0QT8g2PQU1ilKsOKBhCnn/wnG7YNXm6XRQ2RhLQaTQhjj1h0I2RqMVFFLIZIY6hS0qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q5gd7ZPT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5gd7ZPT"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cab97c86bdso28105ad.1
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 19:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156280; x=1786761080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c7tczrAN0Z+XQOnKNy/6C+IzTrIYOyRvANTeANoTkDc=;
        b=Q5gd7ZPTgIQoZ0Z5SIc3Ob+alyf9ijiA+WlxsGaxZ2cK4LH6IeE5Kq+FA9wJwbh/st
         d8cQZV456zhjawQlD4u5ZWnNTxuomW1u/oothWbZe5gNSPN/HaQoVTxMicNVPYAdXQgr
         0ch3iRxrnZFZHtOUt99WaciXwCkd8bujiCb12N3bDV8OyQK3yyPPzcJrKZcg8DyR7rIg
         HNtfVOuG1QIq2w+v8juV4A53r3FqbIeWAcE0quiHO9jecwhKWHuJn1PHeWLAQ6jzGCsF
         GMql2IuRtWX0is7MVEiXkADFgCPIokBhobaf+pDLd+8ZsbiXr57+XghfUdqdCBA8Vyi0
         9OYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156280; x=1786761080;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c7tczrAN0Z+XQOnKNy/6C+IzTrIYOyRvANTeANoTkDc=;
        b=V7bX/FcT07rfD7aWI55rEcAnjb4KIv5wYChdkg2oHQtOD0cX7c42/T8GzsQ9PL8SEY
         +Jz5dSl+GOdLeslBzDugvCUHFnHSNGi6PIKwTeMOybUZCmWtjSu3v57p1U2/+9vOLkGB
         iabiOQrF2UeqkO70Q+n44nFVMCvSsHACtzsxk/aImPpbJGn2UQpMv0c4N+0Cskca8hB9
         wnGARswkH8XHPIlDxK06h9y2oIhjsx7z3gLxTAe0YZeN2e6vXgdnuAehtTb6cch4DHov
         RVL3iNdk4oMiFp4ppWtWMz7k8mS4zjD7a1nt7Df2rgq0hIIpBjMvLcWPXD/yEGXzoLHF
         znYw==
X-Forwarded-Encrypted: i=1; AHgh+RowphKPCR323e1BTN0ebFCJrktyiYsHQjo68iJP7jFKQx7eMrNZ6sZ50RDkxD48z3rUKvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywjTEk0Fjy84Go8N1zkGXV5siK7+JPh4/zXvh/4jM6b8Mye4kn
	FnAGZ3GMUMO5GUDBBePOK3ORy7F0czNtCqk56tsYyM2syzclQC4f5CQOgrUPC+craw==
X-Gm-Gg: AR+sD100FzUrQO1yrk5/qibpLMewnbA1UlFgzhLlsYZUoGkfU18EqNLYlTCaX6KW8f0
	6d58dE0VNVB3i2hJ4TxmGn9WRLkmAEzWIKFb8zu3RUjTxiEh1syaP38InKcm4bB6++jekwO+DGZ
	Su0QgFtJGKIEJudkx6whA4EyDIaB29hA1BatsULUe9OrKI826KvP8VGg5oWfYiRu3z9hvln+hY3
	8sl8PGaX9tcDSBD5HlBa0xNW2imWisGq/7AIoMcnCp8P734F0aKAEUJ36rrQ1Rr2zO+hPQRSEcZ
	VCjAkP6mCkr24Lv4VnZdkRtWz1r4wxXBIvkdVM8TZeqIvNow/rhOJ8R/pw0X7n5t1+loDZ5mz5S
	B8VT+V7eFgju4ZndxVwX8p+ALR+5WMlaQYnRw2fa3JdweLnBFRET63WAwkh1wVCK5TVUzDzlMPZ
	kU9t37gqHk5JTiTgvk8qLgbK52TuInjwQvU1xyHtMQcnnTo6wT0EsdjkOL2xDrq1Gv6ZebzM7B7
	TVEM5D65tMzOr0NtkWyvbf8x1E2FpO8hzwc75XsKu2DMFRqldFoB7+Rjcs=
X-Received: by 2002:a17:902:c994:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2d2b30c1498mr2941465ad.2.1786156279321;
        Fri, 07 Aug 2026 19:31:19 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b30d465csm2252994a91.2.2026.08.07.19.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 19:31:18 -0700 (PDT)
Date: Sat, 8 Aug 2026 02:31:14 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 02/18] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <anaUhv1pcnMoTEip@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-3-skhawaja@google.com>
 <fjma5ub62ia4pbcvs4yek52r6jlhut4fidutow3g5uhf6iel3o@iqx3a6bm4q2e>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fjma5ub62ia4pbcvs4yek52r6jlhut4fidutow3g5uhf6iel3o@iqx3a6bm4q2e>

On Fri, Jul 31, 2026 at 05:58:20AM +0000, Ankit Soni wrote:
>On Sun, Jun 14, 2026 at 11:37:12PM +0000, Samiullah Khawaja wrote:
>> Add liveupdate FLB for IOMMU state preservation. Use KHO preserve memory
>> alloc/free helper functions to allocate memory for the IOMMU Live update
>> FLB object and the serialization structs for device, domain and iommu.
>>
>> During retrieve, walk through the preserved obj array headers and
>> restore each folio. Also recreate the FLB obj.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  MAINTAINERS                      |   9 ++
>>  drivers/iommu/Kconfig            |  12 ++
>>  drivers/iommu/Makefile           |   1 +
>>  drivers/iommu/liveupdate.c       | 212 +++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h |  18 +++
>>  include/linux/kho/abi/iommu.h    | 207 ++++++++++++++++++++++++++++++
>>  6 files changed, 459 insertions(+)
>>  create mode 100644 drivers/iommu/liveupdate.c
>>  create mode 100644 include/linux/iommu-liveupdate.h
>>  create mode 100644 include/linux/kho/abi/iommu.h
>>
>
>../..
>

[snip]

>
>Hi,
>
>nit, The v3 changelog has "Replace bitfields with u32 flags", but sign_extend:1
>looks like it was missed. this is 37 bytes, the only arrayed record in this
>header that isn't a multiple of 8 (iommu_device_ser is 56, iommu_hw_ser 112).
>The arrays are strided with pointer arithmetic, so the skew accumulates: from
>objects[1] onwards none of the u64s are naturally aligned.
>
>Looks like a leftover from the bitfield cleanup.

Yes, missed this one in v3. Just sent out v4, it should be cleaned up now.

Thanks,
Sami
>
>-Ankit
>

