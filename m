Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86659384CEC
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174991; cv=none; b=pexy6myZYW66D3WLBhS2DsNEQrUKQJOsGEnJ/UOE6LHp4mn0HuSYuTWgqwrkqbsH1fpaVbUj1nE25/+aSdk/iEDU1sYElUrRjy1eYBwpm7hSGlO6wgZaXH8FzRG5odjGOpLeYcM9bfTtERwPa8E3VJsxiij2Dwjip1diOuzj9H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174991; c=relaxed/simple;
	bh=PUnUxYHmCp3aaAbqKD/kYlXYduXizBmSoeU75lfmYqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDhBhnFrnfpMUn2Lzluw/H4WrXPzH7fCfe7V6Z7UBJCfBfnQLiDBDRXhogiVCYDTHp0JCWoL/ESGj0mHeShX112wwjuL2xfDlwRMCcnWQyTltZnDZt/yL/XSXVNdQPyVEvPe7O4W8uAnwFaR1t2Fy5wJ0zB3k1uxM6uP/KOaUDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aD1fXXrv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aD1fXXrv"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso20055ad.0
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 17:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782174990; x=1782779790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q1m/UZ+tyAY37uB0UHTmcmll3+MuVllAAR/s1gutk68=;
        b=aD1fXXrv6YWwrx6gT2Xo4MV0/Or0kTjQTarQmFCFNk0xnQapWQN9bjWNbKPTlnIOj+
         B38buIl1hVGY9sbObfYvN1rqun1Q7XlvCoaFlk/OAXgmZBkJg74s5zQzDo6MuqWHrI0w
         OndDq+gog3lNUClMIb/WpEc2PfWR5Gc73ssw3+mjt29962FFSXsXsTvANj7rFEHfUv8D
         Nhv93ceYdEY6rShxsmAs5OrZsiOPNzCTOHsulycCsYFxRPUoUHp9VRKPOJV7B6ZAnjqC
         8ZNNddommjZULGs1IRBnBsk66NIqLQEn/VzJrBnLy/diOM0jGsrqHy6zEV7aAWiD3qRE
         wA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782174990; x=1782779790;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q1m/UZ+tyAY37uB0UHTmcmll3+MuVllAAR/s1gutk68=;
        b=LkxrETXmjh6EvImaMWpTN4dgValicTlu7Auh9uO70MMdzPuN/TuWtdqONCHOs/Y4jg
         QcZ/nLFzDXnNV0Bi2ATCqGjSVzVnTz4OdwCs4atKISJZWA/Q5BIpBgi6CvdAHCr2rNSs
         wdw5fsm2au3ubPiUltkkUMzU6/QruL0eR78zZlxvcTR2VUqWis/fj8mk5Za/wy/GzezW
         FPqDpG6aAe513tM8999W+uWWHRmNhQDV4YiO43j2KFeyHvmic3pVrZzqpHmuWCXs9ztz
         ZRRt2BteksJqu1GzSJtXUbVzCVpi233KgzfNfzWvQJhOKqv3F73vYzGAis9+MK5bmi12
         7iDg==
X-Forwarded-Encrypted: i=1; AHgh+RrBziwVGU+iYzqVeTiwlQDSOfKcxcEVl9BnUKzD24yfxFhhCEWk2MMJZZjNBFPf62V1PpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA3lqwPrTDe/GgNMxhNgMGM6IX5f80IwBfeVhqRDtAgNMqDnqH
	yGorWDkKaX63GQfVcLSanMRu4ERwgkyHpZoX+P4rnP5EStNMBf9xDyk1k/7JXW+6rQ==
X-Gm-Gg: AfdE7cnYCJ9vaeR6hcf58TaVy6AUH4hQUxNJNfMCbCCtUHI4gGKXwkV2oW0/tzKfzUI
	BXeM73M3GX7/4Z1eT1bjDzQgQ49rDv1UizsYBO4UcR3V2Kyof68LZy/gJBs9bF5qLD/Ujq1Lf2M
	ocFHkOySWUD0o3SMpJdy5TRXqmteCA46fiH9nrmUJns1lQPtFPw9yCuNqcsAHo+XZrGWz/kUSMK
	EBTdp7MEFyqNgtBlOGoJEk/LBCwNn1kQi8+oCFz3XrD0Z1SzSxBhdRnUh/AeIvm3gLGxIC3Iwpa
	XwZrFXljCT918kCoztdiDIbjp2eqqxtLH6ZjPfURsd3KgSmelxhkoQ+2cxvtZ72zGbkGcxvMyYC
	p6t+54dN3kY3SmcHqdcTUFqfokhSK2JYnTogKsdN7cqmcvaiCizjEPmxusxdVY3zR0xd4N4T0es
	/u3HnA1ouBv8NaCV2BmimaU23H/S6rQ7Mqk/q9HHQwOvd3r6d257ByLVtMfubQaEXDu/yNkg8V3
	+udkzTb
X-Received: by 2002:a17:902:f710:b0:2bf:749:551 with SMTP id d9443c01a7336-2c7c528b0f1mr1135025ad.22.1782174989106;
        Mon, 22 Jun 2026 17:36:29 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e9dab2sm8963719b3a.41.2026.06.22.17.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 17:36:28 -0700 (PDT)
Date: Tue, 23 Jun 2026 00:36:25 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 13/18] iommu/vt-d: preserve PASID table of preserved
 device
Message-ID: <ajnS4Pjb1Sld1jrn@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-14-skhawaja@google.com>
 <8b1076ea-022c-42f2-8fbb-f55cd30b4b3d@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8b1076ea-022c-42f2-8fbb-f55cd30b4b3d@linux.intel.com>

On Mon, Jun 22, 2026 at 02:01:09PM +0800, Baolu Lu wrote:
>On 6/15/26 07:37, Samiullah Khawaja wrote:
>>diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>>index 89541b74ab8c..5cac8e95f73b 100644
>>--- a/drivers/iommu/intel/pasid.c
>>+++ b/drivers/iommu/intel/pasid.c
>>@@ -60,8 +60,11 @@ int intel_pasid_alloc_table(struct device *dev)
>>  	size = max_pasid >> (PASID_PDE_SHIFT - 3);
>>  	order = size ? get_order(size) : 0;
>>-	dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
>>-					1 << (order + PAGE_SHIFT));
>>+
>>+	dir = intel_pasid_try_restore_table(dev, 1 << (order + PAGE_SHIFT + 3));
>>+	if (!dir)
>>+		dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
>>+						1 << (order + PAGE_SHIFT));
>>  	if (!dir) {
>>  		kfree(pasid_table);
>>  		return -ENOMEM;
>
>This reads as if PASID table restoration fails, it tries to allocate a
>native PASID table instead. This doesn't match my understanding. It
>would be a disaster, and the system should panic if the table
>restoration fails. Or is there something I'm overlooking?

Your understanding is correct, and that is exactly what
intel_pasid_try_restore_table() does if the device state was preserved.
If the restoration fails, it fails hard with a panic.

The reason I have _try_ in the name is to account for devices that
simply have no preserved state to begin with. In that case, a new PASID
table needs to be allocated.

I agree the naming makes it sound like we ignore restoration failures. I
will rename the function to make this less confusing in v4.
>
>Thanks,
>baolu
