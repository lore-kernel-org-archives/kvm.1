Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46063B059C
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787777221; cv=none; b=nV1thO2bPI3dQoQjWv0JaO6seX48pnkefoGR9y3b2gzvZrO8LggOcqKnWfK/1UDlmBJzvp6A4gZaxf3r6do7WhXnfk38b+E7b+dpCgWwaMj0HZLZqtIyOuO+x4v2ovxyKi2ZEw0XGzUx+Mi6jvirScFYNK0WJmQ/q2ZPFiR2pQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787777221; c=relaxed/simple;
	bh=8W+6nm1p92cnpBRrsTxdlV28jcWT30IBrjF2fyWBd6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDLgU5ktCilvcuTw4zpnfbzXVq+1acmvcjAW+3puZDPDS9vCPjDCznFvk04Wbo7BV0NF51jxCMaFnRMqRec886rCiPXywBN7YZYWrgqkJO4cpJDJN9HdEMplOlTt5ANY1lQOY4GXEE2/t9nNhWLs/tfuoDELIGnuQeSaVmcu5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h1IwEy9K; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1IwEy9K"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cede6375caso32605ad.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 13:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787777219; x=1788382019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tVpNY9AYqp69vRQbsKPPtkBeX+dXdwmZPC7oJAGryqk=;
        b=h1IwEy9KHj2ttf2q59WCQjTF7hPp2fdzzlfDqr2QUzdy8oRMiZhRi+FNjYNkuD/Viu
         v9tTCACVz8+QAldAvAEk8Z64K2Pwnl/3XV1NDgpzD2W2TcQPAQazhSLSeMD5KtH+4ZCb
         Ql2toE9tL9pEM/CA3Qmbp59nBWfMGKaFtSpOQhaUkqc0WZP2LXNd5t0+vU2oINVGsRFG
         tX61YjdR9Sd5ISQ7vBQlnGSmHY2E8v2YlwuLoFwCFSKmARML9Y1DELaVJh+quYdOZ2R4
         GosCaS9nJtzvquAX+/rDBNqizdl0dV3BaqzCN64GyFOdpO5kHniTArpSP9z7H352uymL
         lvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777219; x=1788382019;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tVpNY9AYqp69vRQbsKPPtkBeX+dXdwmZPC7oJAGryqk=;
        b=QOPJha6EYpN0muYRsuj7LIivY6xBGTyBginNyZyWDBaG1Ael0DcGDTdw9Vux/VSqm3
         xt0Y94zB4FbXiYTEv51sOSyXvvGAlbomtn90FyWFey8TCCbgXvjDzUAO+vbqAV6i1srh
         sbqQxRyZqtjcPnXQt2amcrG3o7WNTOpolRNrFwQgwROZ6Uc32kZRKL4CEejuv/hMtlTw
         kxWH8dVHg1EWFb55OLmD21Q62tmXXXolwFkt+7q2hsTSX5RJCj2J8F05SvsEiyyvWSnR
         wqG09ooFfI/JqTn3fAfj9/d3824rGVdryHC2T3KH5zGG13s1O5SRgW5ZCtIEzAQAuU5V
         Vkcg==
X-Forwarded-Encrypted: i=1; AHgh+RpBbQrMnOqihhIqjjqNUuqnmzNWh3mfM0G89apVdhhb4PAz+8tbhNzw/pxe+zRwSReJ0bk=@vger.kernel.org
X-Gm-Message-State: AFuF++kURDQdwSXKqhQr8PbBi8AEQsVwEQZALnkCXcBK7BsFPgVq6XPa
	7Gxq8mcoZbmbWvwLU/I2rWjnLz9WPNAwv+0UM5DKz7O9lETRbxxZWFqmRvAokCMGYw==
X-Gm-Gg: AR+sD12BnmSxhY5qtNJ83UeT6NXlPvC0PtYTkW1xtfNMyxjp5Vn4nGRPj1qbY7zGEqe
	fnlk+ygtbtEESkGDwbo9vW4NeNZ5gVur+qRG1/h9AY+Zqri44dHFKa4Zekc4amRGPsG4vH/IQFQ
	SfkQq1Lk0rMI/Fgr8XJJMPEipG07Y0ot7XkRPpZGhMnvH1+YJDDNtyXlN4DBLzycR1MOOKQ3E8n
	HionvPNqgkj5YPUN/1DrvQM+/5OdfqRMVXK0oPjZzMs3SgQ45sGWC+GqMb7CxwsC4EasZ8G5MZB
	zhDFerKCx/z0vBamuRoWpm31VGOndk+p80XaQ3k4WppQT7I0LSBHYu18nH9md8MaVmgmLSMn0Fe
	HC2axDeMc6Yu6gjIeyOXfqYRjtGEswDnjrR7O9DPX8A9IRHprC7Pd+YpcWjwgdeCxtdTRhrOGHn
	oVDgI9H59D3t2FTvy/zAccfBHFn9098cs7fvINwNDnqQtFkrKic9DuGGeNyU4Lo5b4uT615FJTv
	YESnfMu+pwXhwPk1rMpVPqQErZOpemlDx03uMQQabn2QJH9mo4CPHsS1tlyTmL13nq3iA==
X-Received: by 2002:a17:902:e94f:b0:2d5:db3d:1a44 with SMTP id d9443c01a7336-2d73365a24amr151945ad.17.1787777213391;
        Wed, 26 Aug 2026 13:46:53 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1befce3b8sm1396240a12.5.2026.08.26.13.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:46:51 -0700 (PDT)
Date: Wed, 26 Aug 2026 20:46:47 +0000
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
Subject: Re: [PATCH v4 07/18] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <ao9PE9gdOh3DXNvP@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-8-skhawaja@google.com>
 <065b2be2-2ff1-42a0-99b1-ed81e783dca1@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <065b2be2-2ff1-42a0-99b1-ed81e783dca1@linux.intel.com>

On Wed, Aug 26, 2026 at 03:10:31PM +0800, Baolu Lu wrote:
>On 8/8/26 10:27, Samiullah Khawaja wrote:
>>Add implementation of the device and iommu presevation in a separate
>>file. Also set the device and iommu preserve/unpreserve ops in the
>>struct iommu_ops.
>
>This patch, on its own, does not fully implement the preserve operation.
>At this point, the callback preserves all root/context entries used for
>live update, but it does not yet clear non-preserved entries and
>invalidate the related caches; that cleanup is supposed to be done in
>the next patch.
>
>So I think we should either:
>
>- add a brief note here to make this dependency explicit, or
>- merge these two patches into a single patch for completeness.
>
>?

That is a good point. I kept the cleanup patch separate as it has to do
with shutdown and basically getting ready to go into kexec. This patch
mostly focuses on the "preservation of the memory" being used by various
IOMMU data structures.

But I agree, we should add a note about the cleanup here. I will do that
in the next revision.
>
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---

[snip]

>>+#else
>>+static inline int intel_iommu_preserve_device(struct device *dev,
>>+					      struct iommu_device_ser *device_ser)
>>+{
>>+	return -EOPNOTSUPP;
>>+}
>>+
>>+static inline void intel_iommu_unpreserve_device(struct device *dev,
>>+						 struct iommu_device_ser *device_ser)
>>+{
>>+}
>>+
>>+static inline int intel_iommu_preserve(struct iommu_device *iommu,
>>+				       struct iommu_hw_ser *iommu_ser)
>>+{
>>+	return -EOPNOTSUPP;
>>+}
>>+
>>+static inline void intel_iommu_unpreserve(struct iommu_device *iommu,
>>+					  struct iommu_hw_ser *iommu_ser)
>>+{
>>+}
>>+#endif
>
>I believe the #else ... #endif stubs are unnecessary and can be removed.
>
>Specially iommu core checks driver support via callback pointer
>presence:
>
>        if (!iommu->iommu_dev->ops->preserve_device ||
>            !iommu->iommu_dev->ops->unpreserve_device ||
>            !iommu->iommu_dev->ops->preserve ||
>            !iommu->iommu_dev->ops->unpreserve)
>                return -EOPNOTSUPP
>
>So when CONFIG_IOMMU_LIVEUPDATE is disabled, simply not wiring these
>callbacks is sufficient.

Agreed. Will remove these.
>
>>+
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>  void intel_svm_check(struct intel_iommu *iommu);
>>  struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
>>+

[snip]

>>+/**
>>+ * intel_iommu_unpreserve_device() - Intel IOMMU callback to unpreserve device state
>>+ * @dev: Target device
>>+ * @device_ser: Struct containing serialized device state
>>+ */
>>+void intel_iommu_unpreserve_device(struct device *dev,
>>+				   struct iommu_device_ser *device_ser)
>>+{
>>+}
>
>Please add a comment explaining why this callback is intentionally
>empty.

Agreed. Will add in the next revision.
>
>>+
>>+/**
>>+ * intel_iommu_preserve() - Intel IOMMU callback to preserve hardware state
>>+ * @iommu_dev: Generic IOMMU device handle
>>+ * @ser: Struct to populate with serialized hardware state
>>+ *
>>+ * Return: 0 on success, or negative error code.
>>+ */
>>+int intel_iommu_preserve(struct iommu_device *iommu_dev,
>>+			 struct iommu_hw_ser *ser)
>>+{
>>+	struct intel_iommu *iommu;
>>+	int ret;
>>+

[snip]

>>  /**
>>   * struct iommu_hw_ser - Serialized state of an IOMMU instance
>>   * @hdr: Common object header
>>   * @token: Unique token for the IOMMU
>>   * @type: IOMMU type serialized state belongs to
>>+ * @intel: Intel specific serialization data
>>   */
>>  struct iommu_hw_ser {
>>  	struct iommu_hdr_ser hdr;
>>  	u64 token;
>>  	u64 type;
>>+	union {
>>+		struct iommu_intel_ser intel;
>>+	};
>>  } __packed;
>>  /**
>
>Thanks,
>baolu

Thanks,
Sami
