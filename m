Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E600C1A262A;
	Wed, 29 Apr 2026 02:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777430254; cv=none; b=Go8CrxaY7+sgGqX3DkTZiuJz415y52aMZEUdRKBpaTzGivmLAMlU0LiNNz73iJC0nR3is8JQYJphacyl1n5k3GerhzXBazYMzvJEZvObRha7IJAAd6C7iv56kGA+54iAgnJN5Fu7em6UCH5/g2kqHn0qGTN0aVc3LxkF2WHkRFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777430254; c=relaxed/simple;
	bh=Bog/7E6jfRp6BmN5HcKhuNdt+u2al342vA9vTtIK/c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UEuhAZ/Kq3VGR9z+2Z6/7xObUWpjDU96iz0jC9fM5JUZYZF9XTeZbtr0P+QEpGEbAzhu6Szey43DsuwzeY2f6Pxz5m92JWTvD5yUu2Ju86Kl+QCUyzZ7dEI0+1CTtW+vHYy9Xbh1v5F8wa7ynASwvEDRGTVD5Qo0BSL2JXWMI20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ukYvubN9; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ukYvubN9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777430251; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9vgeJGi4fIz8c1PAExsDJNL3htFpFy8K6PCAfkBpC84=;
	b=ukYvubN9bfsiw+hCgFct0Rh8DuUuGppw2MYGZLHRo52sLLZ7e0G7YQR01oyZygXbd5GwOsawUjU5A3dXju2PAapB8CYKM1JI+pPsNrmhNxS3n8/f4uGOMy0jFUNxleG63RCQ+b9eJGc5ZSNAr8Anqx5jBTDncHjVWQry52PSgP0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0X1vzVVG_1777430247;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X1vzVVG_1777430247 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Apr 2026 10:37:29 +0800
From: fangyu.yu@linux.alibaba.com
To: jgg@ziepe.ca
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
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
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: Re: [RFC PATCH 11/11] iommu/riscv: support nested iommu for getting iommu hardware information 
Date: Wed, 29 Apr 2026 10:37:22 +0800
Message-Id: <20260429023722.79615-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260428133942.GI849557@ziepe.ca>
References: <20260428133942.GI849557@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> From: Zong Li <zong.li@sifive.com>
>> 
>> This patch implements .hw_info operation and the related data
>> structures for passing the IOMMU hardware capabilities for iommufd.
>> 
>> Signed-off-by: Zong Li <zong.li@sifive.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> ---
>>  drivers/iommu/riscv/iommu.c  | 19 +++++++++++++++++++
>>  include/uapi/linux/iommufd.h | 18 ++++++++++++++++++
>>  2 files changed, 37 insertions(+)
>
>This has nothing to do with dirty tracking. It should go with a series
>introducing viommu.
>

Thanks for pointing that out.

I added the .hw_info-related patch because, during passthrough testing with a
VM, I observed that QEMU calls iommufd_get_hw_info, so I initially thought it
was required. However, it appears that the .hw_info implementation is not
necessary for this series. I will remove the .hw_info-related patch from my
dirty-tracking series in a follow-up revision.

Thanks,
Fangyu

>Jason
