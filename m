Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793243905;
	b=p3VDdxVfWJ+J399Us6XvacK9v4NebPJFohRR64ORqX4aQBbO8sU915MUu3a5rn1owUxb
	 7Daj+ff+Y2gQsuvTcqqKqr5D/14Z5T0UfUw/hcRmcFxksP97BcH49ZqdZfFGq+paE1W18
	 hYfW8ChqdpQ49DrxhTmGAhFfAiIBS3NVIjezgJqrxdlbxs4jbE8GQlg2XAQsc1B4RvtlN
	 LeEUJk5tfVxvzu1wMKEEgqbqOktlP3BzyO82eKc4GLqDuVwjInEcRfh9oDTCy6d6BQJqz
	 uZNCpFimfCIFAdcKuNC65fzwWaAkZ55Yv3u7hjHTS9iaXjKkoWMtc5atXiNdYbJfDXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793243905;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=38WyXjlueJWRKQRqp8cQGmxITcnnsrYGBn4p3Z8ZZLQ=;
	b=LjmaOk/V00NYNtJ3+rfGqvLXx3+NxzH2rbvz6heZW8HSMuON1EBjPKrZIGVAR+3mI0pg
	 dwt4jYyVDT4cM23h7EiNHubn3g3nWcz9v6/gt/NHJ5nZsAAAt+yDOc8fWIf5ktonsxF+3
	 x0dcAFixcq0o7QQzIKyxhaCtpDGaRzynfE6gTl75UNg/zfBq1/mXlginu6kqxzxzPMhZY
	 ZhyAQouHc7EhSKZdwLellA8EafIDY/Z9mbSXq4sk55iJ4V9rabqkY4d56T8WK0JO42jNV
	 R/g+DeD8GqBTDXqXi8c/DLz1YQcKaahy9ujl1iR1mP7QFb1q5tkQnMn/oECO7wk8NAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SsQixV7X;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D86606A31C;
	Thu, 29 Oct 2026 03:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82D86606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SsQixV7X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793243905; x=1824779905;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Cj6kU2ZX/RnCd+sPFtuaaUioURVI3NEzsDjWKzasycg=;
  b=SsQixV7X3WmcmKFp4vPr81c/hKzJ9mAVtEOyiL61rajlWa9RA+p3zo+i
   dgE3VreVqFz091oitB3u6jGwAqvaVwjdDsBY8qjL5o9q3DhLIq6alIXhm
   KuJKVFj2fH82GAVtpcAhbOWG+yjxxLCsKrj4Lda5ZVz73Ygc53a51emA2
   l8EwVROzKcaBT4OcO1/puaFZ401X3QruVU/1gk701L04/eZib7NyJAcKH
   S020k+l+NTJh28UJx2BUWJCJHzlNW3YZns2ew6NNQASX/AS9UWgJH09ub
   mD1EPan9wAkn1bqd+wyrDujnUhMkJpJt5//VLH2JavVlw8devLLTg2kQB
   A==;
X-CSE-ConnectionGUID: 69fRZQDsTr6OMZn6J8Z94Q==
X-CSE-MsgGUID: VEdb6YvgTn2wtmUyJxNQwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1994286"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1994286"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 20:18:24 -0700
X-CSE-ConnectionGUID: bBNs7urBRHuRBA/6fWPWfA==
X-CSE-MsgGUID: 5m/zZIfTTF2dLS/e6nMaig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="4946425"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 20:18:20 -0700
Message-ID: <5e0be0cd-c2ae-4488-b95f-b04b8315a1ed@linux.intel.com>
Date: Thu, 29 Oct 2026 11:18:02 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
 John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 07/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-8-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-8-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
> During normal shutdown the iommu translation is disabled. Since the root
> table is preserved during live update, it needs to be cleaned up and the
> context entries of the unpreserved devices and root entries for the
> unpreserved context tables need to be cleared.
> 
> This is required because during kexec reboot and shutdown the devices do
> not go through the release flow, so there might be stale entries in the
> root table and context tables. Also note that new unpreserved context
> tables for unpreserved devices might have been added after preservation,
> so the root table entries for unpreserved context tables also need to
> removed.
> 
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      |  15 +++-
>   drivers/iommu/intel/iommu.h      |   5 ++
>   drivers/iommu/intel/liveupdate.c | 134 +++++++++++++++++++++++++++++++
>   3 files changed, 152 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 14bd1ca4fbd5..23a1da351ddf 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1967,6 +1967,14 @@ static int iommu_suspend(void *data)
>   
>   	iommu_flush_all();
>   
> +	/*
> +	 * Note that IOMMU suspend doesn't affect live update. The state
> +	 * preserved during live update is not released and remains valid during
> +	 * suspend and reused during IOMMU resume.
> +	 *
> +	 * Also note deployment of suspend/resume and live updated use case
> +	 * should be mostly mutually exclusive.
> +	 */
>   	for_each_active_iommu(iommu, drhd) {
>   		iommu_disable_translation(iommu);
>   
> @@ -2512,8 +2520,11 @@ void intel_iommu_shutdown(void)
>   		/* Disable PMRs explicitly here. */
>   		iommu_disable_protect_mem_regions(iommu);
>   
> -		/* Make sure the IOMMUs are switched off */
> -		iommu_disable_translation(iommu);
> +		/* Make sure the IOMMUs are switched off if not preserved. */
> +		if (iommu_preserved_state(&iommu->iommu))
> +			clear_unpreserved_context_entries(iommu);
> +		else
> +			iommu_disable_translation(iommu);
>   	}
>   }

When I revisit this, perhaps we have overlooked something.

After intel_iommu_shutdown() in the previous kernel, the memory for the
Invalidation Queue, the memory for the PRQ, and the interrupt vector for
the DMAR fault are all freed. However, the hardware is still configured
with those resources. This potentially results in use-after-free bugs.
So my understanding is that while we can preserve the translation state
in intel_iommu_shutdown(), QI, PRQ, and fault handling should be
disabled and their resources should be released.

In a normal kexec, DMA translation is disabled, thus all resources
configured to the hardware are released. However, this is not the case
for the live update scenario.

Thanks,
baolu
