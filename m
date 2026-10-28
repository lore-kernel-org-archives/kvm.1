Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157043;
	b=C7HvUPdExgS6jyBGpr7ssZkoOIAes1AgMsTVhTr66NgtderpnlZU4AWCbYPhcATfXK75
	 bx6RLc4aRUg+gnvJH8Ti55mx8+vdYFw0u7qvUpHt9MKLz+oCigwHlxGVu7LShq4KwMJUn
	 4gPWqyXl6upgcwTpqAZa0NkxA6M0o6yK3AsQOOBXafjj0I9p6Wi8CpUFMruRcKiFxEcni
	 dBsv0i+fslza4pXYkjpedaxsDRTf0kcRKrdwoWo8CuspmyIirmjAVsPPsf/iRBzzPegjb
	 1xJoviWhFNEV3LRLw5vhdeaSkug8oPdej4vMPB3sV5FP5B/5t54tPR9sq7ADhjs48ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fy0HfsUMOjewH2fDLKsY21nLEjTbk/eksQFYtRokMBQ=;
	b=RVXpr9YKNcKWJNQ8Mw/CrYIXS7TIUur9Gx1qUSnPrsd4SFn9IPPPbAO3ctaAcFWAa5R3
	 o1hBHeiHRpbwtQHtrCWlChsN/SsalkmMZE1dyqgJildCOWX9xk5BcHtN4rqfyfEVIhRGE
	 0d5Iy+LO1r2C7jpnkXO03u30kuet8zt25p0zrtkves37vwvRQPMuSyMekPOTK/iJEZXu6
	 x/nMXxm7s2pdMFL0mSSW7HLskYeM/fn5loEBkdbPhCwXTrT3G75CcIEMzDJg1mwwAphre
	 fUsqCMLqE1i2MZYr5GTf2cF91FZ4y1+WlEYhfdXSw2yQ3lJbvKKeBkM8qBlH3iifCUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="P9J5thH/";
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C2606A31D
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 03:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA0C2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P9J5thH/
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9f6a16afcso22145ad.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 20:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793157042; x=1793761842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fy0HfsUMOjewH2fDLKsY21nLEjTbk/eksQFYtRokMBQ=;
        b=P9J5thH/x8btNLogQ9fUEHV7LGlgAo+4lNsFc0wgkLBV5e0/UxT6eNdQGT3Im6vLKq
         0/2ZpWZ712obGuISp4ZItWb/7C71Xbmfn9wkWw+2vRd6JWtzn3xoIwu+VM0rBDapLO/t
         hX5pwznm6Vf6pawuVmIKWA15d2WCJ4Jxg3654tl7R5b7JwGcG3FQ0pVaokNFj0Q6Nhqb
         SBhzHUuMZ2zbWgGtmlYnt+U1aSeDYGFt+gZnevt4DYMmV3qjmidHreCfaTSrAV4DajJk
         acMx2xHoBWZqYvApfn/KVaEOynXFnFbmtyrF0kzyXvcmabmRtdJ0HzZqQltc4RHM4Rpr
         gcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793157042; x=1793761842;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fy0HfsUMOjewH2fDLKsY21nLEjTbk/eksQFYtRokMBQ=;
        b=swyyON8+fXTFeZF3FfV8Moqe6CKmED/qdutVQHqsNnvJcMBMK5Y/aSyNbOVtLpLwzJ
         sh84u907r0yszX86saA8nrMMtQBXL/NH8tLgsjmpLTM0hUl3QjCHXFIXMSjBzLm/IRE0
         iLgBHOPhc7V0jSoL7LAQV2EqlsZSN6zvnzfv7Fp+zdLX09a6Eit4SHj3KWqlD7VIyO2R
         4dDoDGgDJn1Uh02kTCLOfgmfsYi8JNfx9R4J2d0yDEhOgCF2uHrieD+8Qan0++VHci7p
         N10YU6FbKgtw3jgo376Jg3H+Twj2yRnOcvom0ehTUaSATmrb6+H645XGJsuwVcGUCLrq
         84uQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIFn+IjxXiiJev4xz/C4fcr3H9xXUP7uTuPNPQH7wkjz1vnCGpSEfVVSGf4Wa1f0K23s4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdS2pwm4mCqJ3mWL698AEJ5N2rAgFH+rHsQCr23ogQnXRfzr/5
	yJsMwWBwol0glZF7BQ53JvxJhFrrYyJbCv7k2imO18fXgQBY2PAmhelCXL555CxPfQ==
X-Gm-Gg: AYBFou1tkF5gyuZ6p3X2O7CwH58WUyYGlWCE/IrwEyeM+R5II6bWkiYkjfTLXofSd15
	RZzUuV53Klh+0cqhYGPlFlbFt21wVi2KW6E3qu7SuDQtQ/Rew0c2hFHAYUmGrbnj/FXgFmk0KBO
	PxK58UrOEZ7j3mUp0K+Db0uFziyWxQtXrNiOzQhXKaMIOD+yDczSstk8PZrKo24LoPQ3GVyqb3b
	m86MlPTv8ubvXe+ikDDfAXH4QiOukcl/xFENef13P9HqJPPi/9mMDPFuPvAdq8FhezZBAdlkgba
	7/Hl/Hvpsd/MKXc3mmIV4C342o0XCIaCTHlLhL9/aHq7+qmI/nXVCigY3d6X4XuYZhyNOIaBej/
	cULBKdgMxmU4O+mp9x0r95djDubPdHFqrGMF4dNyJgF24eVgE1R5zL+hrq9iI560Pi9Zv9+rKEb
	nwv18pN7ae0ABQWdHKZaKFbJ6TcUySX9NmHkbjAzU96t6Tyy+4AFku/7SsWdoJbHey5JC0LqK6Z
	Jnz+RaFbxwjUFK7dJPIsoJ2hfCToNRU4HjJooZrjqkCwC+9Ms5NuQx0HOIl3w7i8NDvO6P+nosO
	I2ohxKj5pFJ4REcMYq5TgF5bjPeQxqpqIlqOZ1zbCxQYoSRQHgRGX1RkFPbtY2Honum1O0jnPd1
	yKnhvOW458T38XeMYO+cVsQ==
X-Received: by 2002:a17:902:e74d:b0:2e6:1013:ad57 with SMTP id d9443c01a7336-2eb0191f658mr2455145ad.12.1793157041492;
        Tue, 27 Oct 2026 20:10:41 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c90be0sm15672355ad.62.2026.10.27.20.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 20:10:40 -0700 (PDT)
Date: Wed, 28 Oct 2026 03:10:36 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 06/18] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <auFnMRfOOZCmU944@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-7-skhawaja@google.com>
 <b35a10e9-e48a-4da5-84d6-caaad693bb3d@linux.intel.com>
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
In-Reply-To: <b35a10e9-e48a-4da5-84d6-caaad693bb3d@linux.intel.com>

On Wed, Oct 28, 2026 at 09:51:18AM +0800, Baolu Lu wrote:
>On 10/25/26 10:19, Samiullah Khawaja wrote:
>>Add implementation of the device and iommu preservation in a separate
>>file. Also set the device and iommu preserve/unpreserve ops in the
>>struct iommu_ops.
>>
>>Preservation is refused for devices where ATS is supported. Carrying an
>>active ATS configuration across kexec would require adopting the ATS
>>state in the PCI core and in the context entries, and handling the
>>disable-to-enable, enable-to-disable and STU mismatch cases for a live
>>device.
>>
>>Note that the preserved iommu root table, context table and device pasid
>>table will need cleanup as devices do not go through the release flow
>>during kexec. So the stale entries need to be removed during shutdown.
>>This is done in the next commit.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  MAINTAINERS                      |   8 +
>>  drivers/iommu/intel/Makefile     |   1 +
>>  drivers/iommu/intel/iommu.c      |   9 +-
>>  drivers/iommu/intel/iommu.h      |  13 ++
>>  drivers/iommu/intel/liveupdate.c | 246 +++++++++++++++++++++++++++++++
>>  include/linux/kho/abi/iommu.h    |  27 ++++
>>  6 files changed, 302 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/iommu/intel/liveupdate.c
>>

[snip]

>>+
>>+static int preserve_iommu_context_tables(struct device_domain_info *info)
>>+{
>>+	struct iommu_hw_ser *iommu_ser;
>>+	struct intel_iommu *iommu;
>>+	int ret;
>>+	int i;
>>+
>>+	/* IOMMU for this device should already preserved.*/
>
>... should already be preserved ...

I will fix this in the next revision.
>
>>+	iommu = info->iommu;
>>+	iommu_ser = iommu_preserved_state(&iommu->iommu);
>>+	if (!iommu_ser)
>>+		return -EINVAL;
>>+
>>+	/*
>>+	 * We could do preservation of context tables only for the bus of this
>>+	 * device, but these devices can have PCI aliases, so context tables for
>>+	 * those will also require preservation. Also unpreserve would require
>>+	 * some kind of refcounting where the context table will only be
>>+	 * unpreserved when the last device associated with it is unpreserved.
>>+	 *
>>+	 * This introduces unnecessary complication with minimum benefits as the
>>+	 * unpreserved context tables will probably be recreated by the next
>>+	 * kernel as these are all active devices. We follow simpler approach by
>>+	 * just preserving the currently active context tables.
>>+	 */
>>+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
>>+		ret = preserve_context_table(iommu, iommu_ser, i, 0);
>>+		if (ret)
>>+			return ret;
>>+
>>+		if (!sm_supported(iommu))
>>+			continue;
>>+
>>+		ret = preserve_context_table(iommu, iommu_ser, i, 0x80);
>>+		if (ret)
>>+			return ret;
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>+

[snip]

>>+/**
>>+ * struct iommu_intel_ser - Serialized state of an Intel IOMMU instance
>>+ * @features: Bitmask of Intel IOMMU specific features
>>+ * @sm_enabled: Whether the IOMMU was used in scalable mode
>>+ * @phys_addr: Physical address of the IOMMU register base
>>+ * @root_table: Physical address of the root entry table
>>+ * @context_tables_bitmap: Bitmap representing the context tables that are
>>+ * preserved.
>>+ */
>>+struct iommu_intel_ser {
>>+	u32 features;
>>+	u8 sm_enabled;
>>+	u8 padding[3];
>>+	u64 phys_addr;
>>+	u64 root_table;
>>+	u64 context_tables_bitmap[VTD_PRESERVED_BITMAP_LONGS];
>>+} __packed;
>>+
>>  /**
>>   * struct iommu_hw_ser - Serialized state of an IOMMU instance
>>   * @hdr: Common object header
>>   * @token: Unique token to identify the IOMMU instance
>>   * @type: IOMMU type serialized state belongs to
>>   * @reserved: Reserved for future common fields.
>>+ * @intel: Intel specific serialization data
>>   */
>>  struct iommu_hw_ser {
>>  	struct iommu_hdr_ser hdr;
>>  	u64 token;
>>  	u64 type;
>>  	u64 reserved[2];
>>+	union {
>>+		struct iommu_intel_ser intel;
>>+	};
>>  } __packed;
>>  /**
>
>This patch looks good to me,
>
>Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks for the review,
Sami
