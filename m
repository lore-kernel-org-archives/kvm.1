Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.139.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588056;
	b=j6THDUYA2nMEEoxKBGqkaXGOTSZyIblerpQ3eOQmwG/PW2nUaPwwGsZiBGnqP3BEuHRK
	 cP1eY1/kXYFmGt06xO3u5Islv98vKoC9bsg9kuP4zTSBrgvxEiBMqHhyw+cY4mR0jBA/W
	 ykmbtx6TNON3YlA4KFyoTeuELT0xi/XbNcc0j/bBkX+J59a/mmCxZSMSs/IdZPRF4Ttc9
	 gwohsvnqc/ziLnK6wp6Am+mAuOP9yD7rxaMi7MTBn6EErHWGT5+2zkLst6TT3VGzRfnvA
	 j+1cK4UdV6+Tg3YDtH7lCYXzEUvLYs4dKR4NpR03HuyMYl1WyOHjBPs4mj2ewnpcm4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588056;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=eptm0nTE5XWF6wwWhwC1vVdEa1trOJQC7h6Lca2PiP4=;
	b=HgRp/ICa98k9P9VoWNjw5+1MgD7WESi6AjjstczZULYjtlQ3CsFJqc8wqOprzOwCupz4
	 0SH95AEnkwy7G+m163Z/jtyeeRwub6dFQyodBTv86xCU2qeaOJw2x7evKO09YhPr6KJH6
	 pF5nIAQaOHd5b4zZRARGaj4PrSsf+SOT3NdpF/jqtfYK/nT053tzq3qtJFlGmcdl3VHAl
	 za7YnG+Z28IRwXlJ+G4l0ycFSYUPeG+7IaT/FNijO08V/OP8Sm5HeWjqJ/T5K+3mclxTL
	 rvfL8QeX2WxF9Gv3rv2n9ElSRmXXHhKoKMqRTQEQoA5Gps0JgFeEo8Wjcd6olORMItw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=CHxHAxec;
	arc=none smtp.remote-ip=68.232.139.117
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77CB606A31B;
	Wed, 21 Oct 2026 13:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B77CB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=CHxHAxec
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1792588061; x=1824124061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4XdfwgpkFvzFS14XCzmyfcy7TRjNNYg4aRwWFx3svRg=;
  b=CHxHAxec5PzKnUkzqYvpbL0x9p6SJvRg7ZZMBUi+p5aJQnhnrGb4cZI3
   QXoEmQL5zvsFTTF4jBYIQ+azKRemKWwuSTrHATA1c6QzpcIG86B/xE+qo
   YB4dcg6CFgd4nOYFCY4pFDbAQQLXn9a64bv0YnqGGXJf7yhWgqOOg2rRo
   4tJFY4CNTa53lFMOy+6x31IBhqfTdqPKGi7MUVqzGkSD2Pdpc3MUBkBOy
   fJWfZICQtJ/fuOz2cd/9zVAH3NGU4f5HHVAU8219uro22JtY49N+TBp25
   tFCe/fUUKTli8LZ3w/bP+p/ttzv1b6u0dKb3tX4SpGp56sCGpPHvscp4/
   w==;
X-CSE-ConnectionGUID: UEbCj8z2SmaBAWVwoExMhA==
X-CSE-MsgGUID: izDv34mSSRGZN0goKvw6cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="258508896"
X-IronPort-AV: E=Sophos;i="6.27,170,1786978800"; 
   d="scan'208";a="258508896"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 22:07:33 +0900
Received: from az2uksmgm1.o.css.fujitsu.com (unknown [10.151.22.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id C42841002807;
	Wed, 21 Oct 2026 13:07:26 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (unknown [10.151.22.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 765C98D65F7;
	Wed, 21 Oct 2026 13:07:26 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.62.79])
	by az2uksmom2.o.css.fujitsu.com (Postfix) with SMTP id 2F17214000EC;
	Wed, 21 Oct 2026 13:07:17 +0000 (UTC)
Date: Wed, 21 Oct 2026 22:07:16 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org, 
	gshan@redhat.com, joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com, 
	linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com
Subject: Re: [PATCH v22 06/10] firmware: arm_rmm: Ensure the RMM has GPT
 entries for memory
Message-ID: <atiyZ7_S7aBxowIQ@FCCLS0092175.localdomain>
References: <20261002061507.1600269-1-suzuki.poulose@arm.com>
 <20261002061507.1600269-7-suzuki.poulose@arm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002061507.1600269-7-suzuki.poulose@arm.com>

Hi Suzuki,

I've tested this series and found a possible TF-RMM issue.
Please  below.

On 10/02 07:15, Suzuki K Poulose wrote:
> From: Steven Price <steven.price@arm.com>
> 
> The RMM maintains the state of all the granules in the system to make
> sure that the host is abiding by the rules. This state can be maintained
> at different granularity, per page (TRACKING_FINE) or per region
> (TRACKING_COARSE or TRACKING_INTERMEDIATE). The region size depends on the
> underlying "RMI_GRANULE_SIZE". For a "coarse"/"intermediate" region,
> all pages in the region must be of the same state, this implies we need to
> have "fine" tracking for DRAM, so that we can delegate individual pages.
> 
> For now we only support a statically carved out memory for tracking
> granules for the "fine" regions. This can be extended in the future to
> allow modifying the tracking granularity and remove the need for a
> static allocation by the firmware.
> 
> Similarly, the firmware may create L0 GPT entries describing the total
> address space. But if we change the "PAS" (Physical Address Space) of a
> granule, then the firmware may need to create L1 tables to track the PAS
> at a finer granularity. Linux therefore checks if the platform firmware
> manages the PAR region. i.e., the firmware is in charge of managing the
> L1 GPTs (creation and the required memory for the GPT tables - via static
> carveouts) without host intervention. Support for dynamic GPT creation by
> the host will be added later.
> 
> If the firmware requires us to manage the tracking or GPT memory,
> deactivate the RMM and reclaim any memory donated at RMM activation.
> 
> Apply the same checks when hotplugged memory is brought online.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
[...]
> +/*
> + * We do not support creating L1 GPTs yet. So, make sure that all the regions
> + * are managed by the firmware.
> + */
> +static int rmi_verify_gpt_firmware_managed(phys_addr_t start, phys_addr_t end)
> +{
> +	unsigned long l0gpt_sz;
> +	unsigned long next, par_state;
> +
> +	l0gpt_sz = 1UL << (30 + FIELD_GET(RMI_FEATURE_REGISTER_1_L0GPTSZ,
> +					  rmi_feat_reg(1)));
> +	start = ALIGN_DOWN(start, l0gpt_sz);
> +	end = ALIGN(end, l0gpt_sz);
> +
> +	while (start < end) {
> +		long ret = rmi_gpt_info(start, end, &next, &par_state);
> +
> +		if (ret != RMI_SUCCESS) {
> +			pr_err("RMI_GPT_INFO failed for %llx-%llx: (%ld)\n",
> +				start, end, ret);
> +			return -ENXIO;
> +		}
> +
> +		if (WARN_ON(next <= start))
> +			return -ENXIO;
> +
> +		if (par_state != RMI_GPT_PAR_PLAT) {
> +			pr_err("GPT for the region is not managed by firmware %llx-%lx\n",
> +				start, next);
> +			return -ENODEV;

When system RAM starts at a non-L0GPTSZ-aligned address, the alignment
in rmi_verify_gpt_firmware_managed() may cause the queried L0GPT range
to include a memory hole.

On out platform, the relevant memory layout is:

    800c0000000-800dc3fffff : memory hole
    800dc400000-82fffffffff : System RAM

Consequently, Linux queries the following L0GPT range:

    800c0000000-80100000000

The query fails with RMI_GPT_PAR_RESERVED:

    [    8.551855] GPT for the region is not managed by firmware 800c0000000-80100000000

and arm64_init_rmi() subsequently fails.

As I understand it, smc_gpt_info() in TF-RMM checks only the beginning
of the aligned L0GPT range. Since that address is in the hole, the whole
range is reported as RMI_GPT_PAR_RESERVED, even though it contains
platform-managed System RAM.

I believe this should be addressed in TF-RMM. Do you have any thoughts
on the expected RMI_GPT_INFO behavior in this case?

As a side note, we tested this series and the v23 integration branch
with a Linux-side workaround to avoid the problem above, and we have not
observed any other major issues. Sorry for the delay in testing this
series.

Thanks,
Kohei

> +		}
> +		start = next;
> +	}
> +
> +	return 0;
> +}
