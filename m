Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080DB29B79B
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779407258; cv=none; b=tqhCDnqShPXXWKp8pwyYEVW5fFQ0N50E7vSMaUr4MwqITn1fyxTeFHXZk6m9bFUAhNncFow717L9bTgOaYQWwvwx1+y1+4vnG61eX/JTehNcD0wElX4UrlFtbYJ1g/orY0zu75hVvnwGnw5kw8Z6lA/kSNXxtBvgVBgyWX54pC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779407258; c=relaxed/simple;
	bh=ZzdaOmxmRwNVrON/gjEdMZTpzUiU/FME7Sgm7fpOUmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2JRCKVkNYOSPFq24gpmSG6ek+7m9X2S0DLHAUE04V4QBJB3qfT1sg7x7Gh/IQzB2F1KcPxq2uURMW2+QxDvu4dYFKxYTSpBOVzFAbIQoUI5yYXBWFxnp6eDgRr5si2BwGhTry15GO8lK5k4o2SAEfX1yV8Yx5HuAwBNc19GE1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cX9pPedh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=htpIfp/A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cX9pPedh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="htpIfp/A"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LGk05S3532135
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PUdFWIPa89vxzsAnhQHf6L+y
	G3KEiIca8aXD5VqPxII=; b=cX9pPedhuNT9q9JgbfnLFEWj14pBZkTiG8W88p/t
	eh989MdqtnNnHooQoUpC5tGonbAixDq0F38xCcO1zTVQQuSSCiNff1t8LeVbxuGf
	8zLt2lSI9ZBrsHjDJvqJV5HehTzkZYXYq1jaKy3N4eyQJfeP5LHcz37WqMZQBphR
	LAF5UYmXYt1Bw8xTgqbtlhQyCzORQ3b0lP/B7cVrmf8oegUoOtz8BhiSEM0xDfE/
	glhq3wzuxLHszw/Rpxs8L2T5UGaflaXFpRJyGD+1nKDSSdpQ2XdG2FkQXDaa8cqU
	H0G1vBfljHdX8zXvsQTGPXCmZ1w9gfR5oYyw9QJCsUpGVw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea39gtc9q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:47:29 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bdd327d970so3610693eec.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779407249; x=1780012049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUdFWIPa89vxzsAnhQHf6L+yG3KEiIca8aXD5VqPxII=;
        b=htpIfp/AMO8j+kkc5JJu/1jvvXp0kgBffQjB5YcKazJHL2KFvrQVHvO6BzvGcUi5s4
         x3sm0JUZEym8X6BiaecRSeB5+0fXgiErC37F86+uPFETivw3366GCiHnY8//2QnZEZMJ
         l6ItQcVAqYK9i5sI5cYpCi0bHlY6jC1gSIO12m67wQsb2JTNSYnZDv6je/DWZI7Dzdz5
         oUze+KTx17YRHae2jDNBJJLl/OVOxj7/jdRMo8+8qWfbJUI10RDk+9cWcDhKsK5SXXcq
         hrL6wrYrZQuYt1brGPAbV5oU03L5bqpB4opG5rlL8MwUiKHoMCeZiqk/e0uLR8SXydRk
         hqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779407249; x=1780012049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUdFWIPa89vxzsAnhQHf6L+yG3KEiIca8aXD5VqPxII=;
        b=sSyGChQY0BqXv9J0N0bZihhAhCLkye5X2Y+ErH3EFWHxdrmDXcyonMt/v9RtzccdIY
         bjjioxJYDzt24Bw4PpFkP8YDHaibUHYJgxRh4f6Llg39DythbWOTMh/ZAVsEKa2kQoyB
         gKb7mdvr9j1YYS7OByBsT609ZLhb1letc7lfhb+wjGa703JerWdI+Bn8blmuofDwTj8A
         wryR6RHfhK56tien/T7voaN+WTtvu0/qSU5+gb2haD620IW9FHBaRxC330zKaR+JBcce
         bXi9UF777eF5e1P8P4jAbsUFV3ADpBeAfbQXBBI1G5U2c/mL/ns0A7UCnwhSKoZqKsV3
         UvLg==
X-Forwarded-Encrypted: i=1; AFNElJ9wpgHDhu6nXx7N3Mz2tEd2hTtlRKT6zMR2vmwlM9DIXNv2L5NE29lwetC9fU8kkBedZfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq7pCTk2/EDIB8kH+KyUC/dvCjXEk9tK+WMWkmBP7IKQzjfG8v
	nOix5ercp7+l1mFH/hQ/ngmdYPx2jIHjMkfP3YBy92IgZWJojW5Qn+vrhPvtHlIDV+CmFQBzIe9
	7SvfwsKl/qQ+u+e9deWnAAdoMsr0PI5nhBEGMCphkn4OlBAKz/2BwpwQ=
X-Gm-Gg: Acq92OHo/N3ZvqO8+bVz/xkqregjLbtcyB+9Zfy8KgqEPQa5qZfxLyvaB/BNk0xerD1
	zChy0UNi9QtYrSVfxve/0HV81871QLQN55e77zRPrIswrUtprV6UjhpIKz+ZgZ44Im9Z1+XD8Sh
	mCbhb/BcRFwJCp5f2pUbwb0LLRSEc6k6lOyo3924XiWdvbi1iVnjk7q4OLE029jM5o3ZNO1DjKY
	kRwHOHKy4XGDgOoHmtBo2NVnzi63AjpXF009EzCYl7EE2od64HehjD+GeawFapJILCnkgvGWEe3
	x6Qo+/Ez+WQahiBhk74O1isUPCBiK9uhBs31PhQkEKmZCEyPTvl9vH8RvUbRUrdtiYil78Bvs5g
	VRAr/OryByIcfC+2aZC0lP+eXb27jaVs=
X-Received: by 2002:a05:7300:23d3:b0:2c5:c532:1fe1 with SMTP id 5a478bee46e88-304304f8840mr2709611eec.3.1779407248798;
        Thu, 21 May 2026 16:47:28 -0700 (PDT)
X-Received: by 2002:a05:7300:23d3:b0:2c5:c532:1fe1 with SMTP id 5a478bee46e88-304304f8840mr2709570eec.3.1779407248205;
        Thu, 21 May 2026 16:47:28 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3044b9121c8sm625990eec.14.2026.05.21.16.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 16:47:27 -0700 (PDT)
Date: Thu, 21 May 2026 18:47:26 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix TOCTOU race in SBI system suspend
 handler
Message-ID: <zfvysxe5eqyogy3cesmp53omigq6a7cjajs3ffbrfyqq7huph4@bbfw7ro5zz7l>
References: <20260521142030.1560861-1-xujiakai2025@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521142030.1560861-1-xujiakai2025@iscas.ac.cn>
X-Authority-Analysis: v=2.4 cv=Yr8/gYYX c=1 sm=1 tr=0 ts=6a0f9991 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=c92rfblmAAAA:8 a=pGLkceISAAAA:8 a=19519zxkop7UJ02bGBcA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 5KtLy_IQmnGG7vBMZqq63LaMFrEn0Up1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDIzOSBTYWx0ZWRfX1meGkTs//HDN
 l2OkVBvx3eVPahuvwhO1ycNz31fOluIU5gE6E7xTQgMmEnWnTghobLyyPYmtu5HLUwgeu24bqiB
 +4CPgH6C7xosOZSYveF3oL5qkT8iexKnXKDpDDdqKgjPlaQpYn9OKo9W8FgasXDmlpc0yb6jsCD
 PKei3sLKZg4EDs5bIF3GyR3T6TPEBSjhpKWedGdUpgIWTq77D6uNTWE8hRL/mQDTUmHHRn/vjgz
 pLeeoKexdPJpSXGzvWJPMieVPxuVs8sC7T6QLS01lKt0eyDjQjS/5jOpEe1FYLIWemey6NEkc+P
 tvCooR2JSLtiyUTkkV42rDPlSHLOLiAcjYzNWvFo/RLsnJtDNxW6WhgsjlZgHVWGRAV36nbgTj0
 p0xQAk/hdLf4QcOMO2UmLEhQg0ZaM6yu+0ynu12LrN/dGsurKQiPXYtYNm3gaMlmzIzpDpjBDji
 LLFWicwWkRrZcaGbVwQ==
X-Proofpoint-GUID: 5KtLy_IQmnGG7vBMZqq63LaMFrEn0Up1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210239

On Thu, May 21, 2026 at 02:20:30PM +0000, Jiakai Xu wrote:
> The SBI SUSP handler kvm_sbi_ext_susp_handler() checks that all other
> vCPUs are stopped before entering system suspend, but it does not hold
> mp_state_lock during the iteration. A concurrent HSM HART_START from
> another vCPU can start a target vCPU after the SUSP handler has already
> checked it, violating the invariant that all vCPUs must be stopped
> before suspend.
> 
> Fix this with a two-phase approach:
> 1. Set a VM-wide suspend_in_progress flag before the iteration to block
>    concurrent HSM HART_START. The HSM start handler checks this flag
>    under its existing mp_state_lock, closing the race.
> 2. Hold mp_state_lock during each per-vCPU stopped check so that
>    mp_state reads are ordered against concurrent power_on/power_off
>    writes on the other side of the lock.
> 
> The flag is self-clearing: it resets when any vCPU re-enters
> kvm_arch_vcpu_ioctl_run after the suspend-resume cycle completes.
> 
> Fixes: 023c15151fbb ("RISC-V: KVM: Add SBI system suspend support")
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> Assisted-by: YuanSheng:DeepSeek-V3.2
> ---
>  arch/riscv/include/asm/kvm_host.h |  3 +++
>  arch/riscv/kvm/vcpu.c             |  8 ++++++++
>  arch/riscv/kvm/vcpu_sbi_hsm.c     | 11 +++++++++++
>  arch/riscv/kvm/vcpu_sbi_system.c  | 10 ++++++++++
>  4 files changed, 32 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index 75b0a951c1bc6..c4e710ec40f90 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -93,6 +93,9 @@ struct kvm_arch {
>  
>  	/* KVM_CAP_RISCV_MP_STATE_RESET */
>  	bool mp_state_reset;
> +
> +	/* Set by SBI SUSP to block concurrent HSM HART_START during system suspend */
> +	bool suspend_in_progress;
>  };
>  
>  struct kvm_cpu_trap {
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index a73690eda84b5..ea6f14244addb 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -838,6 +838,14 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  	/* Mark this VCPU ran at least once */
>  	vcpu->arch.ran_atleast_once = true;
>  
> +	/*
> +	 * Clear stale suspend flag from a previous suspend-resume cycle.
> +	 * The flag was set by kvm_sbi_ext_susp_handler() and persists
> +	 * across the userspace exit; clearing it here ensures subsequent
> +	 * HSM HART_START operations are not blocked after resume.
> +	 */
> +	WRITE_ONCE(vcpu->kvm->arch.suspend_in_progress, false);
> +
>  	kvm_vcpu_srcu_read_lock(vcpu);
>  
>  	switch (run->exit_reason) {
> diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.c
> index f26207f84bab6..2f88d93768bc8 100644
> --- a/arch/riscv/kvm/vcpu_sbi_hsm.c
> +++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
> @@ -31,6 +31,17 @@ static int kvm_sbi_hsm_vcpu_start(struct kvm_vcpu *vcpu)
>  		goto out;
>  	}
>  
> +	/*
> +	 * Reject HART_START while a system suspend is in progress.
> +	 * kvm_sbi_ext_susp_handler() sets this flag before checking
> +	 * that all vCPUs are stopped; checking it here under
> +	 * mp_state_lock closes the race.
> +	 */
> +	if (READ_ONCE(target_vcpu->kvm->arch.suspend_in_progress)) {
> +		ret = SBI_ERR_DENIED;
> +		goto out;
> +	}
> +
>  	kvm_riscv_vcpu_sbi_request_reset(target_vcpu, cp->a1, cp->a2);
>  
>  	__kvm_riscv_vcpu_power_on(target_vcpu);
> diff --git a/arch/riscv/kvm/vcpu_sbi_system.c b/arch/riscv/kvm/vcpu_sbi_system.c
> index c6f7e609ac794..b79c1cff7a996 100644
> --- a/arch/riscv/kvm/vcpu_sbi_system.c
> +++ b/arch/riscv/kvm/vcpu_sbi_system.c
> @@ -35,13 +35,23 @@ static int kvm_sbi_ext_susp_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  			return 0;
>  		}
>  
> +		/*
> +		 * Set the VM-wide flag to block concurrent HSM HART_START
> +		 * from racing with the per-vCPU stopped checks below.
> +		 */
> +		WRITE_ONCE(vcpu->kvm->arch.suspend_in_progress, true);
> +
>  		kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
>  			if (tmp == vcpu)
>  				continue;
> +			spin_lock(&tmp->arch.mp_state_lock);
>  			if (!kvm_riscv_vcpu_stopped(tmp)) {
> +				spin_unlock(&tmp->arch.mp_state_lock);
> +				WRITE_ONCE(vcpu->kvm->arch.suspend_in_progress, false);
>  				retdata->err_val = SBI_ERR_DENIED;
>  				return 0;
>  			}
> +			spin_unlock(&tmp->arch.mp_state_lock);
>  		}
>  
>  		kvm_riscv_vcpu_sbi_request_reset(vcpu, cp->a1, cp->a2);
> -- 
> 2.34.1
>

I'm not a big fan of this approach and I see sashiko found it has gaps[1].
I'd rather we introduce a mutex to kvm_arch to serialize cross-vcpu
mp-state operations. So it'd be taken in SUSP, HART_START, and also SRST
(anywhere that reads or modifies another vcpu's mp-state). Operations that
only modify the calling vcpu's own state would still only use the per-vcpu
mp_state_lock.

[1] https://sashiko.dev/#/patchset/20260521142030.1560861-1-xujiakai2025%40iscas.ac.cn

Thanks,
drew
