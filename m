Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE25546D0B4;
	Tue, 18 Aug 2026 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061831; cv=none; b=jyQsMEO7Pk42E89L18wd977bAZzm5nNCe7AKvW3PtpNCN6axYKJwcZZSYua0W0w3u0fcbmBKYMHS83tvHvtux3PKPwOeLd0jFoFI3xV5f9z6Q2JBhkydyHfVf5be8ErE+w5VplZsBuxCXa2QFR/Hb8KXWhXNIaVHwS9K9XSEW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061831; c=relaxed/simple;
	bh=Id8JXoQAMD8MYXmg4kZZnB02NF+iNEURWVvRlx4Yjuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UukTj70gSXBXI9TfLoPiLqGUugxpLv1zR0rzSDD5s6GR0yow+/N68iTM3uXvHU4PhAEMdOXQD94j+abZU/Rlk8EcMehEc2eU3PXikexeDCULk1s7a0QZwFCZMIZ8NSdDQO9MiqgkiYxndeIcFbFJkILiMsWEDkC2wp5WxM58Ias=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vM/PZjLR; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vM/PZjLR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787061824; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3+dGJ9oJ4HyGceZTjzfr3Zv2QrruNTe35bavzWX5RY8=;
	b=vM/PZjLRk+G86Cm3UqEJRrULiS3D0UNkhw+suxKR5mUTOfeWkIkav0cAbID18tJ9fCfdrtKLQ+hYJfbArL1IuEaCmxL+RzEwp1kAnheqTHDwpln7DtLEnmbNsrEfFbFO/u+WkIIRlzeT0HQ5mkol/H3noSsRAphUn6wY8A21LcI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X9DdTDT_1787061820;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X9DdTDT_1787061820 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Aug 2026 22:03:42 +0800
From: fangyu.yu@linux.alibaba.com
To: andrew.jones@oss.qualcomm.com
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	tjeznach@rivosinc.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: Re: [RFC PATCH v2 07/10] iommu/riscv: Add domain_alloc_paging_flags for second-stage domain 
Date: Tue, 18 Aug 2026 22:03:40 +0800
Message-Id: <20260818140340.48333-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <rzvdgmjkk5rzn4qehsoajmbak7jpssqancyn3mfvpnzf6wyvsc@alyg5a4c2scx>
References: <rzvdgmjkk5rzn4qehsoajmbak7jpssqancyn3mfvpnzf6wyvsc@alyg5a4c2scx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>On Thu, May 07, 2026 at 07:37:03PM +0800, fangyu.yu@linux.alibaba.com wrote:
>...
>> +	case IOMMU_HWPT_ALLOC_NEST_PARENT:
>> +	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
>> +	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
>> +		/*
>> +		 * Second-stage (iohgatp) page table for KVM VFIO device
>> +		 * pass-through and dirty tracking. The GPA space is 2 bits
>> +		 * wider than the corresponding first-stage VA space (x4 root
>> +		 * page table), so hw_max_vasz_lg2 values are 41/50/59.
>> +		 */
>> +		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57X4) {
>> +			cfg.common.hw_max_vasz_lg2 = 59;
>> +		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48X4) {
>> +			cfg.common.hw_max_vasz_lg2 = 50;
>> +		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39X4) {
>> +			cfg.common.hw_max_vasz_lg2 = 41;
>> +		} else {
>> +			ret = -ENODEV;
>> +			goto err_free;
>> +		}
>> +		domain->gscid = ida_alloc_range(&riscv_iommu_gscids, 1,
>> +						RISCV_IOMMU_MAX_GSCID, GFP_KERNEL);
>> +		if (domain->gscid < 0) {
>> +			ret = -ENOMEM;
>> +			goto err_free;
>> +		}
>> +		cfg.common.features |= BIT(PT_FEAT_RISCV_S2);
>
>cfg.common.features currently has PT_FEAT_SIGN_EXTEND which isn't correct
>for the second stage. So it needs to removed and then added back in for
>the first stage. riscv_64_kunit_fmt_cfgs[] in the kunit test will then
>need to also be updated.

Thanks, agreed. PT_FEAT_SIGN_EXTEND is only valid for first-stage
VA translation and should not be inherited by iohgatp domains. I'll move
PT_FEAT_SIGN_EXTEND into the first-stage allocation path, leave second-stage
domains with PT_FEAT_RISCV_S2 only, and update the RISC-V KUnit configs
accordingly in next version.

>
>Thanks,
>drew
