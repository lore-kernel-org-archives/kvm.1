Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B31D410D0F
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179223; cv=none; b=eHrC4WdtfSQJvni/tKKapECEMnLIWP0rCdId2IjnRt4WVdBMkCRtWZwL2VUkfjYzoE5S9p4+TEhsJ84F88H5hQX+gv7WLzZ3D04FhEeJcy6UUN3twDS4V2nanxLvLo06T6cE/flV5zlr/balNw17JwT65fyXBY/cz+YFF2/oqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179223; c=relaxed/simple;
	bh=ln5AjyNWfzYrFxuevowteUP8a6ELykKUVDzygksz2jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ae2QShXxJZHWngSHnN9SNdgQv5Wae2MeqjqKZbHNwc35+cEOXXmvOjpf0RIoRDIs8Zw6ozxdyVIL6jL5+4pSzEmT+Mlmr+QS4o1mfHCyprtnDJZeaE30biBXGAkFqkOHpD4rpuv4mu/voqJDr02IDvyLiRKcPRWPSqaMpSVPn/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOsvQoeC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOsvQoeC"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso17125ad.0
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 11:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778179221; x=1778784021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NhP+n7DxEFBfq4ANgD7pXobqb+7/slgfnCpBlFNfz/U=;
        b=hOsvQoeCn3CnpDmRI6Plgx/Z66A1+NsQegAuRkT/ObJTzfmdv67gDdWmE3m3nVAwvo
         nfgiwDpG8v6QDvRHix+QeAJmqVKQgbt6O/rXg8Aiz7JSthorXs/MO4oyimwo2UA/OB9t
         LizuP63SAAMtNW3nmIaR7hKWrmw4wJAnTZgwHs0b1Ukz3B7ar8F68dGCLwvRNVAzbdzh
         JwfgI76EeFVh58rpZjs5pSOMZIjycE5ieY5vpxnXgGvzimhwyt55hqk0sqsiYSUXn1x8
         XayGTwUFkgMUzlJFfEm5grDTCYpvajcDJPq6achSuY8e6Tj6hvBSgVYI10PICPoe7XxO
         px9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179221; x=1778784021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhP+n7DxEFBfq4ANgD7pXobqb+7/slgfnCpBlFNfz/U=;
        b=ZdTSGCNtgGNDMU7Hnzew6OiVnUSWBdYfp3/o/eO1l34IKsDfSeU08q+NtmRatFtGgz
         4JWq4Plb4zuHmRAGSROGRlNwacQ4TjsC67WErCvqnjFLKd2E8eGZrxdk4NNkh+e8/cHW
         6bXxjq/F7gQ0J/JrLUOVFgSqrljG19ZFhEDPQXgFH7MVlms711fIqLDrgoWXkdadFfGG
         jGgkM3K6j8Up1AG3KpkJOiE1zyRO+QuN9Bg3HGrE1RwTJuIBg1Y/5AhkqXVZ6IsDF5sG
         o3l1JhTk+CN6WaNWKI0IGogJKsBwIjF2y8iMW42Dkf8cr0exFwHJAfND8anbsXw8OpHj
         DJkw==
X-Forwarded-Encrypted: i=1; AFNElJ+1iOIjZuoVOBRI3KQNc02ivqqAxV+U4Bt5j/J4lAS2tpm+4PtRIegP9JQushH64csDYP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuxLl8lBBPXIpU/UnmDmHhfB7HUs+CXZBb3/Iwf1mbfFwauVBQ
	eTDSyeSp52QXJkAIeMVCgtY3sYFfyVD/PZvoNfK4IVgLyJrqWRcNb4z2aB/HAzxJVw==
X-Gm-Gg: Acq92OEMZnYaidtrNBYar7mxQJV6ojCO0sYlEJjFmpg0BsCf6YcxKI6j9j0g4sWmJ2A
	0P7rvITYlCRljCaxpkquEJV1xGYQP7fZUrAbFp/1jinoKKN5ZmZb+FuTNzX1Caiw7bhOVRpAiaU
	/iaDtn41wTuCOrkDmyin6S/KAWddcsth+x3YapQhYs9NdB0tKKp6WyODN0xS3A5uMZQoIUIFnL4
	T9hlinDgbMiMcGRwNpsA3L6Y1isFBJn9Ogi58iGByaRHXU1sXHVzBe1sWVHQYwD7ozUJBVR4nRo
	bZlof1GBo2/2NgkUgakcRvEKog5zX5qtDK7Dmv080oodmp6tgfcQaAzJkjG2s2g6IZe0R2VHMa/
	CUK94jI2IIVdnqupictYXirjaiOjhV6Uf4rDU8ASioifnjL1r+iJYO6tOsRpbH2DhRQj8ZBk4tQ
	1ZBBpeopGPcnO3EYike7TCAm259ONkSGUx/1s8zeTUTNvZtoC7i1/wT5dPsBQKqprXdpo7sQ==
X-Received: by 2002:a17:902:fc87:b0:2b0:5c88:51e1 with SMTP id d9443c01a7336-2bae9e67750mr620315ad.14.1778179220958;
        Thu, 07 May 2026 11:40:20 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d314f7sm10033887b3a.23.2026.05.07.11.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:40:20 -0700 (PDT)
Date: Thu, 7 May 2026 18:40:17 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 06/16] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <afzXJtIW6vUYplev@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-7-skhawaja@google.com>
 <39a010b4-7099-434a-b8de-5d03a75f2a9f@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <39a010b4-7099-434a-b8de-5d03a75f2a9f@linux.intel.com>

On Thu, May 07, 2026 at 10:55:42AM +0800, Baolu Lu wrote:
>On 4/28/26 01:56, Samiullah Khawaja wrote:
>>Implement the iommu domain ops for presevation, unpresevation and
>>restoration of iommu domains for liveupdate. Use the existing page
>>walker to preserve the ioptdesc of the top_table and the lower tables.
>>
>>Preserve top_level, VASZ and FEAT Sign Extended to restore the domain in
>>the next kernel. On restore the domain has only the preserved features
>>enabled and all the other features are zeroed. This is ok since the
>>restored domain is made immutable and can only be freed. A kunit test is
>>added to verify that the IOMMU domain free can be done with trimmed
>>features.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>@@ -251,6 +252,12 @@ struct pt_iommu_cfg {
>>  #define IOMMU_PROTOTYPES(fmt)                                                  \
>>  	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
>>  						  dma_addr_t iova);            \
>>+	int pt_iommu_##fmt##_preserve(struct iommu_domain *domain,             \
>>+				      struct iommu_domain_ser *ser);           \
>>+	void pt_iommu_##fmt##_unpreserve(struct iommu_domain *domain,          \
>>+					 struct iommu_domain_ser *ser);        \
>>+	int pt_iommu_##fmt##_restore(struct iommu_domain *domain,              \
>>+				     struct iommu_domain_ser *ser);            \
>>  	int pt_iommu_##fmt##_read_and_clear_dirty(                             \
>>  		struct iommu_domain *domain, unsigned long iova, size_t size,  \
>>  		unsigned long flags, struct iommu_dirty_bitmap *dirty);        \
>>@@ -266,12 +273,22 @@ struct pt_iommu_cfg {
>>  	};                              \
>>  	IOMMU_PROTOTYPES(fmt)
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+#define IOMMU_PT_LIVEUPDATE_OPS(fmt)			\
>>+	, .preserve = &pt_iommu_##fmt##_preserve,	\
>>+	.unpreserve = &pt_iommu_##fmt##_unpreserve,	\
>>+	.restore = &pt_iommu_##fmt##_restore
>
>Nit: would it look better if we put it like this?
>
>#define IOMMU_PT_LIVEUPDATE_OPS(fmt)			\
>	, .preserve = &pt_iommu_##fmt##_preserve	\
>	, .unpreserve = &pt_iommu_##fmt##_unpreserve	\
>	, .restore = &pt_iommu_##fmt##_restore

Agreed. I will change this.
>
>>+#else
>>+#define IOMMU_PT_LIVEUPDATE_OPS(fmt)
>>+#endif
>
>Thanks,
>baolu
>
