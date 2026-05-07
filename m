Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A69344E044
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175316; cv=none; b=uG+28YBuRTNNPfMsN9YErZloWwosBI3zZU/fyttLKt235B6mgAezOHhICIN7sSzGbskgCX0vNfzFyxsdmi1NfQakf8/S4ttOfx4k3ZjKLszQX/w1itHeiwWNr5vLxQhwPp0yNT8w0fI+1NKlrXBO3ffthxL7KAEYCCodycVVecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175316; c=relaxed/simple;
	bh=EFNgio5JOWMY7NVPUg55HwK19tquNLhBfax7Cr3cf4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icfpnUtEsOelaDpuilXNbdzNMfDMVafrdxVhk1HC3rsTfJz9eXuhgvA8YJUoX2MpHQL5Iw/6hv6+FBm2vvRoKFwzDE1mJIOmYPxXGwNmbtrTKa2eq8pg/JSwxCKgCEdr33z+wgUiw3ILYGFJCH3cSx8NO9DXg4SwuwawAF+DVjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SOmgsOT5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SOmgsOT5"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so9865ad.0
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 10:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778175312; x=1778780112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qijXZWUS9BjAUoaFT2HJ56UCiXmU4uzgefuSiduaZ1U=;
        b=SOmgsOT5crlJN5q8PadpITlsgOBvF74R0m2bn1/Gr9hof85F7KNyg0hg6matpiP0Ov
         2nl62Ye+T8OdpmTocVXW/kBFP8v1qJQETdEHqeIgWPCUNiWdtFzJFs8Z8xpRFC80NGAW
         hVRDTzFgBlgSdAFVicY7E1IqiPuLrR+NDkG67bsjWv1exKpxBVLvb+pHb21A1V+k4Q2t
         T8U9tdles8d6L7vSBWfKDguXrHbYGMjtjEdXQ8pWF5VN+s5qFWMj3E23vG1vBvL03l6o
         c7f6U9NLUWRw7cGk6OvNgNKskkvzI5XaNZTpUpEE0cSmTg6dmfOuQEvRePno3PVB255a
         x+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778175312; x=1778780112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qijXZWUS9BjAUoaFT2HJ56UCiXmU4uzgefuSiduaZ1U=;
        b=JTqy4V90PmnPLaSe1oWMpI7vwEoismsOLSp2vqRCh15RYUIARvIyj3kYglQTvnpwbr
         Kt3I9XueRK8XVupSPTw7WB37s38edk1JVxb6CKKZunvjPgb5MlWSowNU5DsG2iZ+V+33
         kc+OL6gnBCH7FTRHlFyL/smzXKR8zZ4kwtebpbR/r8EP2GKyn7KExTnrm/Uhaa7jm0MC
         gm3ze/3XCAsrDTRXZLefoTNfaqkeQ5Y2jTniu6fl6h4rDxQSUjHpvy4b+zFNqu+UsXbE
         d+pCnqpBkDU3pmqts3kFFgMZDUmocRfnw7TXWsZWV75rC+MmQGciTga5KtSNlvmSgkM2
         PG1Q==
X-Forwarded-Encrypted: i=1; AFNElJ8pdvez7GQJlKWRRxjUANNdS4tMJxm9Jh7k2RaGjKHAEAPdk6XHFhWCoEeLcGdROS546kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUr70oYVuFzKpvXzkHs4uQd+oPve1am+VC2X1xtPlCMbkmCqnT
	Pic9eT7B73WVHy4s7JNq+iI8VV7VNAdMwZSSyHG6VUt1ZOK5ou0KhZFZHB4lpxserw==
X-Gm-Gg: Acq92OFz0uN0/CIy5OmqinMfI9cORMRvqDExOvTIz2bzaTES30hqzh44i8PaqnKz3Ke
	86jV3V4FIKVfa/kTgvl5n82sypY63K3hohtHsdj3HCnWEfKzg1QztVjtqT2P0owAAr3W1Tba1hW
	tKr+ZQapOTLfHkGjZpGGkXjCdG31C6bGqTYaDrMzMNJ6rZwsiaZ4iF7R8z9q8Nz02DCoVBftnMF
	idk3X4qTqQJUc+6SA7mi8Anw7r1EhoB/qezydLuSj3QXzFfrOShEbI+yqMxFzcUWvhzJMcuKG25
	czYRT0b4pD6V/hHyqTUQOup3OT4lgUBy66uhg4v4D/2LeB96mQn/gwUlPalm5YFGGqDiLsxhzMY
	SvSWNo+MeFVydQ2Tew+AmRGntyLIdG/0ZgltHEYj4kzh+EWB248q8Qd8LZQ2azG2w5MHa7iiUXg
	kwIFWDLdB4to758B3sJhq+1Ml7nCmlFYxgsLzFhk5EFx8PGS50FGTxl8novU444sVX9qbztJCpu
	LXARTfm
X-Received: by 2002:a17:903:a45:b0:2b0:b925:da98 with SMTP id d9443c01a7336-2baea433256mr102005ad.19.1778175311724;
        Thu, 07 May 2026 10:35:11 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf7d2sm12708841b3a.49.2026.05.07.10.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:35:10 -0700 (PDT)
Date: Thu, 7 May 2026 17:35:06 +0000
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
Subject: Re: [PATCH v2 09/16] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <afzFJmpYQ35vJ-dI@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-10-skhawaja@google.com>
 <ad4f1b2c-a79a-4dce-b891-c0df92664a56@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ad4f1b2c-a79a-4dce-b891-c0df92664a56@linux.intel.com>

On Thu, May 07, 2026 at 05:05:07PM +0800, Baolu Lu wrote:
>On 4/28/2026 1:56 AM, Samiullah Khawaja wrote:
>>During boot fetch the preserved state of IOMMU unit and if found then
>>restore the state.
>>
>>- Reuse the root_table that was preserved in the previous kernel.
>>- Reclaim the domain ids of the preserved domains for each preserved
>>   devices so these are not acquired by another domain.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      | 55 ++++++++++++++++++++++--------
>>  drivers/iommu/intel/iommu.h      |  7 ++++
>>  drivers/iommu/intel/liveupdate.c | 57 ++++++++++++++++++++++++++++++++
>>  3 files changed, 105 insertions(+), 14 deletions(-)
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index 68fecd4e57fa..4118a0861f38 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -670,10 +670,17 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>>  #endif
>>  /* iommu handling */
>>-static int iommu_alloc_root_entry(struct intel_iommu *iommu)
>>+static int iommu_alloc_root_entry(struct intel_iommu *iommu,
>>+				  struct iommu_hw_ser *iommu_ser)
>>  {
>>  	struct root_entry *root;
>>+	if (iommu_ser) {
>>+		intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
>>+		__iommu_flush_cache(iommu, iommu->root_entry, ROOT_SIZE);
>
>The root table is already active and being used by the hardware at this
>point, correct? Since the CPU should not be modifying an active table,
>the __iommu_flush_cache() call seems unnecessary and potentially risky.
>
>Furthermore, if the iommu state has been restored, is it necessary to
>call iommu_set_root_entry()? Calling it would essentially replace an
>active, in-use root table with an identical one, which appears
>redundant.

Agreed to both points. I will remove the redundant flush here.

The set_root_entry() is done outside this function in a separate loop
after setup of all iommus, I will check whether the iommu was preserved
there and skip set_root_entry().
>
>>+		return 0;
>>+	}
>>+
>>  	root = iommu_alloc_pages_node_sz(iommu->node, GFP_ATOMIC, SZ_4K);
>>  	if (!root) {
>>  		pr_err("Allocating root entry for %s failed\n",
>
>Thanks,
>baolu
