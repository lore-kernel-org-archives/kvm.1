Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1416118A6DB
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790294867; cv=none; b=PT0ScmLhLu4GMz+apKjqE8OmHiOz+rsxeZQMbYrUhmzbG/mwPpkABOfic0UbofzRcf7VwViX+7DZ75rvp0/uRWgUhZezMbVR3X49pimjagsDNVqqDKTt4CZumXHMe+saMZeYexKE/FlCOglE7PjVBmgm375tvTtFKKgS72C8vC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790294867; c=relaxed/simple;
	bh=MfzCj5n/qzaDRiZjBdIWIPdLsqB/Z8mKb7SNpeiywnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACQRfGahsH92fruQyQsMfRqD5zVoNq0aG4szz3sm3OCAMOdrvDHeFHEQpx7gRo0c54Y8aF1TSmPG8odlzMcM/NI2t4MHW99WRON7wU9G5RKcxhz9iUl/b8seKCgppiF1OI+204u8BAPpR1TIUU4sB5TmZZVxtgFchR6Ase0T7qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3awLiiB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uCnwzKKz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3awLiiB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uCnwzKKz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790294865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QtjK9f50/jK8SHecvHOqY5pCCQhpN2otdhXEwvLzMjs=;
	b=F3awLiiBniggHGjUD8BAJfzOzOFE9VrPiYefLhSvcIuJ5/TMVOWNqTfsueWn1c3PqhQ8oa
	3B3rdmOMeMonmuVcvPHG9hf+67XUp/DAr/f58F7s+2tHnrlCovmGH6hCNDXW47zBcUWmJY
	SOEjdJ6UqEFUlU+C5zalai+n5LPreqA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-2caPXOIOPmCaJMC64R-keA-1; Thu, 24 Sep 2026 20:07:43 -0400
X-MC-Unique: 2caPXOIOPmCaJMC64R-keA-1
X-Mimecast-MFC-AGG-ID: 2caPXOIOPmCaJMC64R-keA_1790294863
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a0bce9739bso141287a91.0
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 17:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790294863; x=1790899663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QtjK9f50/jK8SHecvHOqY5pCCQhpN2otdhXEwvLzMjs=;
        b=uCnwzKKzMCBHXiiBLLNX+yNnO6gvlgiCuzc5hGYC2dwS8jhXCyIUlPrmDUYd7U6KyS
         Q/pF5Esuj2Ki3A/n+J75Yj5XRsXh6O3ybe0K+GLzr/5QxCbFYJjnsWT8RUv/le32NDR/
         f0WqB5dTBYGEybDrDexQTvdvDJvL+hX3/ls/+dh6ygSuOud2ca+/Qvc8c0fRDRptX/jw
         zpUfPkI5W9NglK15L1VWZEVZ38s9uQmmocXZm6+1iEN7Rgfm1mRDNQd6yLoTmh1p4lB4
         tNc3m6mGx2cXMlfL4lRMSVZNVlXRkOuM6J9z6UizPU147+JVtnOR6EZpJpCnlWeyRb9k
         rb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790294863; x=1790899663;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QtjK9f50/jK8SHecvHOqY5pCCQhpN2otdhXEwvLzMjs=;
        b=vPgRm1GQLvA0LX9ORrtq82DCnl4Crmnh8491HbJNtcmkkExPEA/9yrz19tizcP7bfF
         gLhvrrPc1Rr4AbnXMgF99LOYx1MOIjPHcMdBsI/TC+7N2+3m2UbT7ubDdwd4fVN5+nCa
         NcajypoG8ISwblgHZMT9wecNRbGZRD6VCoDGMmeHfdn8NgD4++scEQCdiBIqYLGmURN7
         J+BO5yiBcg76EMfRp67UmfIG5vnHRA6QlSJtGbasV/NiVrgGIVjMkfmUA+nGmAIKFDBe
         FAQENPMj3QUlWRELGHHFs+DSAJJpk+jwHC5h+jgk5zVr2XQrZcsNoKmSZ/Kh8aGK7uGE
         gNRw==
X-Forwarded-Encrypted: i=1; AKwUvBy3k44SHu8x3PRyhVVpxyS+aNwJsZm+MXq1s5s7sB9SW1V5RNhHF+vPc3MyktHRvTVMY6I=@vger.kernel.org
X-Gm-Message-State: AFuF++moJCCU/8FmJlcj8HLx4NBHWF7XYBlpTlV5i6vbWf+Kwqh9grYr
	7g3XqjhbHTjt4z3C6uZ9yjVBUgpfBWPefSyk1FGToioh+98y/n663ZObrS8XKYL0+qh7yh8J5Ou
	Iq/f6QWIQ4MaV3X7jSe65rDYEiLgQ4gfJ5/bkLrGxC1iZVETYQ6W8Jw==
X-Gm-Gg: AYBFou2IXNlcAbaJEBodqvScXCSMsHaS6m555KUd9iIYrMbyUTThUHLXI4Cntf6oeiP
	VSIgFOCwBF7kDoizj6yAlB5OsmGB15db7RXn09kIJkimF1BGGiivI/k9ysSHYD3+HsJRydx5W9N
	RHLtssPqCwXBnS6ZYfGUkwugIWoJ55xsZNNKHyevCCSFpsJ+IVoa7b7ZssARVYuFWoFS5bDzZR4
	HJPSiMj5b1bq2/arYn0sVJwHOE5EzXpBSqOheLwPL0qrLqWy7QVlOdKnsfm6UpVbA2pgYaoo49X
	ON35Ay/2ffYgVgTdrUSsjzAKg54Oz9msk7D/efDxxULzWl5zgx0/tsZK0khiox5BCOuTjy6B5sl
	HgHBxkmyLZzilSCb/gK+mTHJtH84PRueDOsCl0AxWlA==
X-Received: by 2002:a17:90b:49:b0:3a0:9ed5:5420 with SMTP id 98e67ed59e1d1-3a0bb6139bdmr380667a91.44.1790294862482;
        Thu, 24 Sep 2026 17:07:42 -0700 (PDT)
X-Received: by 2002:a17:90b:49:b0:3a0:9ed5:5420 with SMTP id 98e67ed59e1d1-3a0bb6139bdmr380627a91.44.1790294861906;
        Thu, 24 Sep 2026 17:07:41 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9355e49sm997611a91.4.2026.09.24.17.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 17:07:41 -0700 (PDT)
Message-ID: <a3984ac2-ca04-4e46-87e9-6277491acf7c@redhat.com>
Date: Fri, 25 Sep 2026 10:07:34 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 6/7] firmware: arm_rmm: Ensure the RMM has GPT entries
 for memory
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
 sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com
References: <20260924135201.850038-1-suzuki.poulose@arm.com>
 <20260924135201.850038-7-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260924135201.850038-7-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 11:52 PM, Suzuki K Poulose wrote:
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
> Signed-off-by: Steven Price <steven.price@arm.com>
> [ Switch to RMI_GPT_L1_INFO for checking GPTs and deactivate RMM ]
> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   Changes since v19:
>       * Avoid mixing gotos with __free cleanups for arm64_init_rmi()
>   Changes since v18:
>       * Handle buggy RMM to make forward progress for RMI_GPT_INFO and
>         RMI_GRANULE_TRACKING_GET
>       * Make sure the memory ranges are not inverted and reject such ranges.
>       * Move granule_tracking_get/gpt_info wrappers closer to the callers
>         Drop "inline", let the compiler do its job
>   Changes since v17:
>       * Move wrappers that may not be used elsewhere, out of arm-rmi-cmds.h
>   Changes since v16:
>       * Check fine tracking and create L1 GPTs for hotplug-added memory.
>       * Clarify the L1 GPT setup and move the explanatory comment.
>       * Switch to using RMI_GPT_INFO command for checking the GPTs.
>       * Deactivate the RMM and reclaim the memory if we can't proceed.
>   Changes since v15:
>       * Skip firmware-reserved NOMAP memory in rmi_init_metadata()
>       * Handle negative error codes from wrappers.
>   Changes since v14:
>       * Move the implementation into drivers/firmware/arm_rmm.
>   Changes since v13:
>       * Moved out of KVM
> ---
>   drivers/firmware/arm_rmm/rmi.c | 218 ++++++++++++++++++++++++++++++++-
>   include/linux/arm-rmi-cmds.h   |   2 +
>   2 files changed, 219 insertions(+), 1 deletion(-)
> 

With Jonathan's comments addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

Thanks,
Gavin

