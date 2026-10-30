Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389315;
	b=o/8IYitZfU69L1TS1rb0vUHUxSjb6Fd3UC369d15jws+OMzT/sAzNCPVUKp2yUtRomba
	 HypuS/1DTmngSOmfBNNIT3D9EGyVyKPWbUV9CRPJBaEcm985BpHLfcnUfWlmCslV4jrkD
	 R0Gi3fwpCaYaAwdBVJiBhtQhMmPs05tjbwXnALkLVhO9U43B9YNLoF0QgvkNQ5t78WhIM
	 lJuZFZgwM1eS7bHWfh24QON6cs31xDsbKY1Z2ZjYLYzMe0M01WpCd5jGd4EZWrulsJ/i/
	 EBvqVkxaIc0wc97ugTEtCYH1dNps3iEpC8KOZSPFv6o0X2K865XhsOICZ9+RAyhOHBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=dTiMgOnQWSO1fXm1V5etvmBssPqHNLO/3CtDNAXggW4=;
	b=h3klaVT9H/soKCzzYwKuDvyrbpSLmr9+XnuQFHFzfomnIWupIEGR6rZnZ2Tg7gTlHgNh
	 ZsmgrFWetZXXv7FfT7xdj2igeitW8a6C2YiskOLIncrkr+T4ktaDJSJ7l/4YoDR8sJhpX
	 mEQObQO5e1XWtnvKhsmT2PbmhnD3dycMT979mpmDk7GmKvN+oEsGGkzWus+MM73Fr9xy7
	 S9w5IsoVDh27Nw+O9PGNcmyIxSi8OYOZsl+N8VecSxqlJDmyRlE5vqM94mmQDI0379J1D
	 c1WvvvzEoeYrLWmmsmpeH2CG43znlywmkkZeGAXdo8y2Iwl6Cu2gSXlIBOpIkskX3XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WxXzGHkz;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A02606A31A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 19:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40A02606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WxXzGHkz
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so11855ad.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 12:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793389315; x=1793994115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dTiMgOnQWSO1fXm1V5etvmBssPqHNLO/3CtDNAXggW4=;
        b=WxXzGHkzvWE4vrXsD7NvdxRYE9kGtHF7duKGC17xUlBFZsNLXQaRokvRERbQ+5XriH
         bKXbxpcikRbPD8xFQMaHwJ8q1fyPod8a4eiMz5jbvz2SrjkRWVzjmr0u3lx+tjn0Nevv
         buGBA9VSrIVTLdkqFglyCrktFfM4N0Dv3WCZF4MKtGJv7l8PmfVheZnwZMru91QADvox
         4HqWUCKOt2llEWcmx98vxQ/Nz3sx9x/GFLt9bM+uBhWM1CbwdxuMOMokSDs4wVzC3SBq
         HTWI9Z8G5IEb4pSwI839LNV6VIbvSNpF0i7TuRyN3cetGr58WBkMhgY6DfandYO9p8Km
         MLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793389315; x=1793994115;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dTiMgOnQWSO1fXm1V5etvmBssPqHNLO/3CtDNAXggW4=;
        b=QGMhjGnvYhdYxJar3Y7pRVAWO73VUhYm03MPWhw4K5boIO2xP8z36AW+MLuPeN7k14
         Kc4TyF5tNrOq6iV+A53u3vBy2a9K6R6q3timJpK6O92ZZtk2pioFdpIB+DqWkw2wf3dZ
         EvYra0+kBrGgTXHsuz5LcBVnxpZBQ2ASUT3gz4evlDZ3f6lJvUbaMeRrEzqu6Jrvz8rz
         9ONaWAyVsKjI2UerAcZeWBoj0BTXwZbWXVqbF48rPc9UpIObyXiMUJcOP8z+poRaB/oL
         wFvS+tOIy1nkKVJ7d02OnqRM7ogX4rVn/+e+Z0q8tEWy6OYJqZV2q5QFhHSJvlGYEsyN
         32Xw==
X-Forwarded-Encrypted: i=1; AKwUvBygrcjcJRqAMbKreEOhYghEyjHbyN29gTnx0yaKEk5lUaYv3bYIp3tvxT6064d7zaUYcfA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGveBIvNCYQTgxtK3FOakfiKJe1oxovmAHi/DBu0Uu7oLoMZ3W
	J3AM3BRrXV5u5mlijIL2FmD8eVJ8YjtAChi4gPSHZL0REN+kYrVxR6Dfrin7KTBmtQ==
X-Gm-Gg: AYBFou1TKIKMkvsAP9IqBIwum1wQuwi/6Ob0LpPEs3qWMefQxAjo4We+XQWDfXZPsSK
	5Ft4cIpPyIIzPwwldWo5c3DEtPGmsoaoTWUe1Jim0moK2fILfgXGHykwHMERzz1vs3PxqGaplai
	BQywJ6P3uLaUO8SP5ea6uV31jLFoH5xYxLEqkbnWXQxsQ6WaFjn6yz1D2iXyqS/9skNNh7TFanL
	3swXdmJd1xgoDzrzmwlP5a9I2vWtHWucULNvjAiuu1IWOgK3BoHvWIV2TjR5hxl7JLEtlHKwB36
	2YrK4kJCQu//0l372KDk0olMHElsW36sV33cigeKVjWHHtzXmdBeRAIugLjDb1qxWoFg0F0wXio
	U40g1mWWZ6JK3aNRWwjOw3fssB+SZcTTxmpqdK6zB+qE4bvEfLXDEaAL6SXXctBJlTBH+dfbEdZ
	MRAvJMsmuo2GXTnhEImOGThAmsFiBOhCH+SE2lymG/Vwutriid9+Dq5InlkUecLj8fOXUK0wXoT
	VzMHNiNgqMOckmBBrvdloRXsMdnobuY6mIruMo3Km7LeEFI+7Qw605uvYx5NcR/5ZMuFwQgI3LD
	mLQBfihVaPl87EIDeHnK62vDA2oeB5XEcQDvb1mSHgUCyqeYRekufQgDSFT+I4Qe+YdjcI/0/yi
	vpsvlK2O5JZEdH/nOMMuRdok=
X-Received: by 2002:a17:903:2acc:b0:2e9:73e0:2a6e with SMTP id d9443c01a7336-2eb019ace41mr19649005ad.17.1793389314108;
        Fri, 30 Oct 2026 12:41:54 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096b7483sm1191940a12.9.2026.10.30.12.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:41:53 -0700 (PDT)
Date: Fri, 30 Oct 2026 19:41:50 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Pranjal Shrivastava <praan@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 02/18] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <auTy6JtTflLq09eD@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-3-skhawaja@google.com>
 <d6e6abad-c3c7-4f99-996a-0030bf6ef166@linux.intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d6e6abad-c3c7-4f99-996a-0030bf6ef166@linux.intel.com>

On Fri, Oct 30, 2026 at 09:26:45AM +0800, Baolu Lu wrote:
>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
>>the proper preservation and restoration of ioptdesc add helper
>>functions.
>>
>>Reviewed-by: Pranjal Shrivastava<praan@google.com>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/iommu-pages.c | 109 ++++++++++++++++++++++++++++++++++--
>>  drivers/iommu/iommu-pages.h |  30 ++++++++++
>>  2 files changed, 135 insertions(+), 4 deletions(-)
>>
>
>[...]
>
>>+
>>+/**
>>+ * iommu_restore_pages - Restore pages that were preserved in KHO
>>+ * @phys: Physical address of page to restore
>>+ */
>>+void iommu_restore_pages(u64 phys)
>>+{
>>+	struct ioptdesc *iopt;
>>+	struct folio *folio;
>>+	unsigned long pgcnt;
>>+	unsigned int order;
>>+
>>+	folio = kho_restore_folio(phys);
>>+	if (!folio)
>>+		panic("Failed to restore preserved IOMMU page %llx\n", phys);
>>+
>>+	iopt = folio_ioptdesc(folio);
>>+
>>+	/*
>>+	 * For the restored pages incoherent is set to false as these are not
>>+	 * mapped using the DMA_API. The remapping of these pages using DMA_API
>>+	 * is not needed as these are not going to be written to by the new
>>+	 * kernel.
>>+	 */
>>+	iopt->incoherent = false;
>>+
>>+	order = folio_order(folio);
>>+	pgcnt = 1UL << order;
>>+	iommu_folio_update_stats(folio, pgcnt);
>>+}
>>+EXPORT_SYMBOL_GPL(iommu_restore_pages);
>
>The pages were charged to the VMM's memcg in the old kernel (iommufd
>maps with GFP_KERNEL_ACCOUNT), but after the live update they are no
>longer charged to any memcg. I think that's fine, because the restored
>tables are immutable and will be replaced by ordinary ones after boot.
>
>This patch looks good to me,
>
>Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks for the review,
Sami
