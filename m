Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4DD4BFE94
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277247; cv=none; b=gU2j33D0D37CcBhDFP3BKAClArT3BQv74Id0cGBxR8frNRp09xRtYAHLhID+fd50p5TxFwv5qEH/P7Rpl2vnb8+o3t8iqvPj3IILUwOVIDj73NuHAmNBTjiQgYNeHg2PAbQTsX9EQGzVLzBtyrvZg/hNtPTVvbyX+BTlyggjCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277247; c=relaxed/simple;
	bh=EwBJUIoyp9JY6RVbxRaq5HHhHm5yl1iuR6dtegQ7JlA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9nppJwkHAd3Hhr4Hhp7JlGxE3fcVGiQUM95VDbq2M2jv4f7zJRUzmL7h3Kq9mtDFRXpYRbYEAU+g+x8phTYftgDPuefJUr8vP6/icHoB3iM6X+nz4ZsjT6E62PM3xnPvOnv2M4oXPjKMYNEYSid3Bd+45uBxFBmFB7H38+G3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=grAZx5ct; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gKx8iCpL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="grAZx5ct";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gKx8iCpL"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OIdjHM2996412
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 19:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7v7mwV3kL+pNqZlpuPeN3iMHS9Dj14zbCE44HBuwDdc=; b=grAZx5ctnOkhdTlJ
	Tbx3UTtNyuHD/sr5o5S9iAosrcwL9vTgFX5n+qgkBa8eJlCDluGlJmxRGLzQFDp9
	DNTotWQ7bej5dT0xfn70EAehqKhfhEvCn3M9xVQrr3bE6g8+ythywAZx/OeJitpd
	N58VTQPEmBCKldJPszmeAMbxozdDm3HfnGTEFFMBUwRnLZP+l9asNVg8vEV0aBhS
	B47EBSt9mP94NZbIGO1X1Y/YrRm6XrQwu8J4zQDrIgiYlXT/tP86H8pL55G7Lf8f
	e22DjROzCJFkF16UcHQcoqsBhj2kMOts7bn6k0M/hwe6kJItxVTabXAQga7Wyqm6
	eidmPg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw4651pph-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 19:14:03 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33310847fcaso134351eec.1
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790277243; x=1790882043; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7v7mwV3kL+pNqZlpuPeN3iMHS9Dj14zbCE44HBuwDdc=;
        b=gKx8iCpLaqaDHYJch1uMV0ie2JMS9GwP5CFYg5MPCGxXOAQXv5G2vL5ZmnQ867aHHK
         1dEJQPNL5L9B6tbkjcOteJmfNLOXmVFxHa2vIHkcnMjcESdrAo/DoOJ+msril4aM3MuA
         pvMJppisaeaVobX99i2drwwsje33kazNfYs/fY4o+3esxQP9dN6GPPvS5XkZRZbMbFiw
         1+TtGoDQCq3yKkigzHBTWMfGKO2b1hBnwvFLQb9rJhOJTN1+gGGYKUQJHD28xjeeoDOL
         wdAWXOIPI7SSG5TVFHgJS8LlmowOAtj2bK2t/4egu11Q+68SkIZMzgle+oOMTbSQAkC8
         CC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790277243; x=1790882043;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7v7mwV3kL+pNqZlpuPeN3iMHS9Dj14zbCE44HBuwDdc=;
        b=LE0LIaiSTktZWL2UTyHtFQdu4DRwj4Psbgq3w8XgX5NCJ3uf5v++BNfVlznrY+mg1f
         S5K0JGhZzQvxJewsQr8X64DfGDiL/GW/YQd2hivVr5aJCscFt0O0Rh/QvAWiUzduFAtX
         XZEVyK2DIKBpGa1JQ1tcu61+VLsz/vngDum0lyydcbvckDYGsKPWjQr3YO/Gutkg+Rct
         5AcVGCq3qyGlyieYzkt3sjGCXFpnh8UNLK4AjT2yhA6J6G37lx3JXaLrJObEKgIj+UZo
         glLIl1LYRvIa7bVn3fkAME7T3h7GYziaHxXgBps0mEO45xbj4kloNWFjlHh1MFma3Zwp
         1wXg==
X-Gm-Message-State: AFuF++nf3wJ961NvJGc+wsry7WalFGqEzcQrYbS2LTs6AM+1eiREc9B2
	EE2P6JaXagwATPaXj8KkIlx9KstA6kSmsB2mvXfughHv540cxn60aao9vr1CFMWpY9yIVEuAF3F
	CGBNmur1mVhhJQdec8n4Bf0Dgz6ZYVxj/J1+9Kx3KQLFLycxuM0p5zdI=
X-Gm-Gg: AYBFou1C7CWiJr7xUVdrMTCsaKpbL+gQKjD4VcvZJcKZcgubgGhjycJ7M8czAeIrQ+U
	c6tXU9bxUZk4MORVHPmf3Y9w79giH5/7dpJBwKH9PZ1ZF/MlV+fZ2qmv+l8UaMJgoQldgJR1nvb
	O8Q8tTudp6TL9qLpIU3QCCJTDEIuw5U5X6oWaTyqwaWXaRgnp3t7XEs7L0Wi07qBmr7+0PF2B2X
	sV7LqHI1l9BDwPbc5BJX+GCLfE37C/Vak/xjpAQ1qckyJ3x/XQn83DSbohBFOQvSq8WsEy8zT8m
	3eWOseB+B4UyOpdn5X7t9l+6Bs0urx1+yXyou+6pfR+dWDJCaB9MEK/RcGocHAPVcM0UQr3D2sZ
	4WVjP4b/YepwIMVjU5vz+EVA6EL/nU9e8a9kKkxaex/M7sDc22D/KoQ==
X-Received: by 2002:a05:7300:1905:b0:33b:fc17:e786 with SMTP id 5a478bee46e88-33fff65015fmr3559964eec.16.1790277242520;
        Thu, 24 Sep 2026 12:14:02 -0700 (PDT)
X-Received: by 2002:a05:7300:1905:b0:33b:fc17:e786 with SMTP id 5a478bee46e88-33fff65015fmr3559927eec.16.1790277241676;
        Thu, 24 Sep 2026 12:14:01 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341447576b9sm641843eec.15.2026.09.24.12.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:14:01 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:13:56 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
        will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
        aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com,
        joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
        linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
        sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
        WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
        sudeep.holla@arm.com
Subject: Re: [PATCH v19 4/7] firmware: arm_rmm: Add support for SRO
Message-ID: <20260924121356.00000d4d@oss.qualcomm.com>
In-Reply-To: <20260924135201.850038-5-suzuki.poulose@arm.com>
References: <20260924135201.850038-1-suzuki.poulose@arm.com>
	<20260924135201.850038-5-suzuki.poulose@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Wrq+otfv c=1 sm=1 tr=0 ts=6ab5767b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=g7tT_HrEe4iQpSKoiZcA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: LbhBf7KeZL_Io1EkAVuMKwmw9xqYhDPx
X-Proofpoint-GUID: LbhBf7KeZL_Io1EkAVuMKwmw9xqYhDPx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA3OCBTYWx0ZWRfX+H+8BUJFZ8Yh
 O9EU3xbjQjC28sQCDyFoX4bZZrOXXk01tEcEqlkBCaxeV+2csI5bFACjwoNjm+3Zy8P8+JGNbLl
 d4pqFPbcYVaHha5lKI5cUIryuZ8GA+JYrrLj3xhwZLNa2UM3Yems7Y0S8dmbyC2eWnSop8QNqvh
 Od7y5mpBwcooEob1K/sgujOg9IREPUgNAj0GazpVWW6zIyQPc1iEhcUVCcQtwpdmKJchrGg99G1
 RsyAnDoSh40U19Kt3qw94VvG+Z2593mNVGvjFCVJ/q7Pxz56dco8Ql5n9MeRY0nVQuSGWGjoXEn
 kCXJ5Mb1gtXknk5uAUeMNypMJfvEAVjYh1oDG7ds+NOGChEKDnvsNKvTcvomRZG1ff8Efft6kJ9
 Zu07dYrmGe29mLVu++3cgtMQ/WaO0mgOnDB1thxD9qUv/1DTkYc9lf8SxqPN13m4r5SfMIfysIQ
 IGtsKIZNLT/+tQ7qfqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA3OCBTYWx0ZWRfX5KcykbB3U+iv
 oc01k17nTd8TRRgWQwadOrDQf5Fyf03RZmwN8kEFNH0Z+TDZlLooNwM2FFr4T/ajcp6OsCFmLpN
 FpK3FhGXc+BO6KolfFzwdftPAw26AtA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240078

On Thu, 24 Sep 2026 14:51:58 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> From: Steven Price <steven.price@arm.com>
> 
> RMM v2.0 introduces the concept of "Stateful RMI Operations" (SRO). This
> means that an SMC can return with an operation still in progress. The
> host is expected to continue the operation until it reaches a conclusion
> (either success or failure). During this process the RMM can request
> additional memory ('donate') or hand memory back to the host
> ('reclaim'). The host can request an in progress operation is cancelled,
> but still continue the operation until it has completed (otherwise the
> incomplete operation may cause future RMM operations to fail).
> 
> The SRO is tracked using a struct rmi_sro_state object which keeps track
> of any memory which has been allocated but not yet consumed by the RMM
> or reclaimed from the RMM. This allows the memory to be reused in a
> future request within the same operation. It will also permit an
> operation to be done in a context where memory allocation may be
> difficult (e.g. atomic context) with the option to abort the operation
> and retry the memory allocation outside of the atomic context. The
> memory stored in the struct rmi_sro_state object can then be reused on
> the subsequent attempt.
> 
> Wrappers for SRO RMI commands are also provided here because they depend
> on the rmi_sro_execute() implementation added by this patch.
> Delegate/undelegate handles are also added here because they now use the
> SRO/stateful command infrastructure and are also used for the memory
> DONATE/RECLAIM flows.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Nice.  Everything I spotted this time around is pretty trivial.
So assuming you'll clean up and bits that make sense to you for v20

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


> ---
>  drivers/firmware/arm_rmm/rmi.c | 666 +++++++++++++++++++++++++++++++++
>  include/linux/arm-rmi-cmds.h   |  41 ++
>  2 files changed, 707 insertions(+)
> 
> diff --git a/drivers/firmware/arm_rmm/rmi.c b/drivers/firmware/arm_rmm/rmi.c
> index c9ea964fd9081..035f21d3f26b6 100644
> --- a/drivers/firmware/arm_rmm/rmi.c
> +++ b/drivers/firmware/arm_rmm/rmi.c

> +
> +int rmi_undelegate_range(phys_addr_t phys,
> +			 unsigned long size)
> +{
> +	long ret = 0;
> +	unsigned long top = phys + size;
> +	unsigned long out_top;
> +
> +	while (phys < top) {
> +		ret = rmi_granule_range_undelegate(phys, top, &out_top);
> +
> +		if (ret == RMI_SUCCESS) {
> +			/* Buggy RMM ? Let the caller leak the pages */
> +			if (WARN_ON(out_top <= phys))
> +				return -ENXIO;
> +			phys = out_top;
> +		} else {

Similar to below, why not deal with error case first and reduce indent of
the good path.

> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rmi_undelegate_range);

> +/*
> + * rmi_delegate_range: Delegate a physically contiguous range.
> + * We iterate over the range until we hit an error. So we may
> + * return an error, but with a partially delegated range. The
> + * caller must always look at the @out_phys to figure out, how
> + * much progress was made.
> + *
> + * @phys:	Base of the physical address range
> + * @size:	Size of the physical address range
> + * @out_phys:	Top of the range that was completed. This is always
> + *		valid, irrespective of the result.
> + *
> + * Returns RMI_SUCCESS on successful completion. Otherwise, returns
> + * the Linux error number or the RMI status code as described
> + * by the RMM spec for RMI_GRANULE_DELEGATE_RANGE or RMI_BLOCKED.
> + */
> +int rmi_delegate_range(phys_addr_t phys,
> +		       unsigned long size,
> +		       phys_addr_t *out_phys)
> +{
> +	long ret = 0;
> +	unsigned long top = phys + size;
> +	unsigned long out_top;
> +
> +	while (phys < top) {
> +		ret = rmi_granule_range_delegate(phys, top, &out_top);
> +
> +		if (ret == RMI_SUCCESS) {

My instinct here would be to flip this and have the error out of line given
it breaks anyway and that gives you smaller indent for that ocmment block.

		if (ret != RMI_SUCCESS)
			break;

		/*
		 * Buggy RMM ? Let the caller handle the failure. We can't know
		 * how far the RMM delegated in this iteration, so we return 
 		 * the best known good limit. RMM can deal with granules 
		 * already in "undelegated" in a given range. So, it is fine
		 * for the caller to try the range we return.
		 */
		if (WARN_ON...

> +			/*
> +			 * Buggy RMM ? Let the caller handle the failure.
> +			 * We can't know how far the RMM delegated in this
> +			 * iteration, so we return the best known good limit.
> +			 * RMM can deal with granules already in "undelegated"
> +			 * in a given range. So, it is fine for the caller to
> +			 * try the range we return.
> +			 */
> +			if (WARN_ON(out_top <= phys)) {
> +				ret = -ENXIO;
> +				break;
> +			}
> +			phys = out_top;
> +		} else {
> +			break;
> +		}
> +	}
> +
> +	if (out_phys)
> +		*out_phys = phys;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rmi_delegate_range);

...

> +
> +static int rmi_sro_donate_noncontig(struct rmi_sro_state *sro,
> +				    unsigned long sro_handle,
> +				    unsigned long donatereq,
> +				    struct arm_smccc_1_2_regs *out_regs,
> +				    gfp_t gfp)
> +{

...

> +
> +	/* Gather the suitable entries to the end of the list */
> +	i = 0;
> +	while (i <  addr_list_start && found < count) {
> +		unsigned long entry = sro->addr_list[i];
> +
> +		if (RMI_ADDR_RANGE_BLOCK_SIZE(entry) == block_size_fld &&
> +		    RMI_ADDR_RANGE_COUNT(entry) == 1 &&
> +		    RMI_ADDR_RANGE_STATE(entry) == state) {
> +			addr_list_start--;
> +			swap(sro->addr_list[addr_list_start],
> +			     sro->addr_list[i]);
> +			found++;
> +			/* Continue from the swapped in entry */
> +			continue;
> +		}
> +		/* skip past the entry */

Bit random on comment capitalization.  Have a quick final look through.
For instance I think this one is Skip to match Continue above.

> +		i++;
> +	}

...


> +
> +static int rmi_sro_reclaim(struct rmi_sro_state *sro,
> +			   unsigned long sro_handle,
> +			   struct arm_smccc_1_2_regs *out_regs)
> +{
> +	unsigned long capacity;
> +
> +	/*
> +	 * We don't do a partial free of the entries. So for
> +	 * now free the entire address list as we prepare
> +	 * to reclaim more from the RMM.

Rewrap to use all that nice space up to 80 chars!  I guess a refactoring
side effect.

> +	 */
> +	if (rmi_sro_ensure_capacity(sro, 1))
> +		rmi_sro_free(sro);
> +
> +	capacity = RMI_MAX_ADDR_LIST - sro->addr_count;
> +
> +	rmi_op_mem_reclaim(sro_handle,
> +			   virt_to_phys(&sro->addr_list[sro->addr_count]),
> +			   capacity, out_regs);
> +
> +	/*
> +	 * RMI_OP_MEM_RECLAIM always return RMI_INCOMPLETE, except when the
> +	 * input parameters were invalid.
> +	 */
> +	if (WARN_ON_ONCE(RMI_RESULT_STATUS(out_regs->a0) != RMI_INCOMPLETE))
> +		return -EINVAL;
> +	if (WARN_ON_ONCE(out_regs->a1 > capacity))
> +		out_regs->a1 = capacity;
> +
> +	sro->addr_count += out_regs->a1;
> +
> +	return 0;
> +}

> +
> +long rmi_sro_memxfer_execute(struct rmi_sro_state *sro, gfp_t gfp)
> +{
> +	struct arm_smccc_1_2_regs *regs = &sro->regs;
> +	bool cancelled = false;
> +	unsigned long sro_handle;
> +
> +	rmi_smccc_invoke(regs);
> +
> +	sro_handle = regs->a1;
> +	while (RMI_RESULT_STATUS(regs->a0) == RMI_INCOMPLETE) {
> +		bool can_cancel = RMI_RESULT_CAN_CANCEL(regs->a0) == RMI_OP_CAN_CANCEL;

For a flag that is "can" or "cannot", do we need the RMI_OP_CAN_CANCEL (1) / RMI_OP_CANNOT_CANCEL (0)
defines?  Doesn't feel like we'll ever get RMI_OP_UNKNOWN_IF_IT_CAN_CANCEL and I can't think
of any other more reasonable options that would justify needing the explicit field value
match.

To me

		bool can_cancel = RMI_RESULT_CAN_CANCEL(regs->a0);

is obvious enough.  I don't care that much though so up to you.


> +		int ret = 0;
> +
> +		switch (RMI_RESULT_MEMREQ(regs->a0)) {
> +		case RMI_OP_MEM_REQ_NONE:
> +			rmi_op_continue(sro_handle, RMI_CONTINUE_KEEP_GOING,
> +					regs);
> +			break;
> +		case RMI_OP_MEM_REQ_DONATE:
> +			ret = rmi_sro_donate(sro, sro_handle, regs->a2, regs,
> +					     gfp);
> +			break;
> +		case RMI_OP_MEM_REQ_RECLAIM:
> +			ret = rmi_sro_reclaim(sro, sro_handle, regs);
> +			break;
> +		default:
> +			WARN_ON_ONCE(1);
> +			ret = -ENXIO;
> +			break;
> +		}
> +
> +		if (ret) {
> +			/*
> +			 * All memory donating SROs must be cancellable. So a
> +			 * failure in memory allocation shouldn't be an issue.
> +			 * However, if we encounter a random failure (e.g.,
> +			 * buggy RMM), don't loop forever, just give up.
> +			 */
> +			if (WARN_ON_ONCE(!can_cancel))
> +				return ret;
> +			/*
> +			 * If we have already cancelled, and came back here due
> +			 * to an error in MEMREQ, then there is no point
> +			 * in going in loops.
> +			 */
> +			if (WARN_ON_ONCE(cancelled))
> +				break;
> +			rmi_op_cancel(sro_handle, regs);
> +			cancelled = true;
> +
> +			if (WARN_ON_ONCE(RMI_RESULT_STATUS(regs->a0) != RMI_INCOMPLETE))
> +				return ret;
> +		}
> +	}
> +
> +	if (cancelled)
> +		return -ECANCELED;
> +
> +	return regs->a0;
> +}
> +EXPORT_SYMBOL_GPL(rmi_sro_memxfer_execute);
> +
> +/*
> + * rmi_sro_execute: Execute an RMI command that is Stateful but not memory
> + * tranfserring. Takes regs, filled with the FIDs and the arguments in place.

Spell check. Transferring.  Also why does Stateful get a capital letter and
Memory Transferring does not.  They seem to both be properties of the comman
so I'd expect some consistency.

> + *
> + * Returns :
> + *  -ECANCELLED - If the operation had to be aborted and SRO was cancellable.
> + *  Otherwise, returns the result of the RMI command.
> + */
> +long rmi_sro_execute(struct arm_smccc_1_2_regs *regs)
> +{
> +	bool cancelled = false;
> +	unsigned long sro_handle = regs->a1;
> +
> +	rmi_smccc_invoke(regs);
> +
> +	sro_handle = regs->a1;
> +	while (RMI_RESULT_STATUS(regs->a0) == RMI_INCOMPLETE) {
> +		bool can_cancel = RMI_RESULT_CAN_CANCEL(regs->a0) == RMI_OP_CAN_CANCEL;
> +
> +		switch (RMI_RESULT_MEMREQ(regs->a0)) {
> +		case RMI_OP_MEM_REQ_NONE:
> +			rmi_op_continue(sro_handle, RMI_CONTINUE_KEEP_GOING,
> +					regs);
> +			break;
> +		default:
> +			WARN_ON_ONCE(1);
> +			if (!can_cancel)
> +				return regs->a0;
> +			/*
> +			 * We can't get here normally, but handle this anyway
> +			 * for a buggy RMM implementation.
> +			 */
> +			if (cancelled)
> +				return -ECANCELED;
> +			rmi_op_cancel(sro_handle, regs);
> +			cancelled = true;
> +		}
> +	}
> +
> +	if (cancelled)
> +		return -ECANCELED;
> +
> +	return regs->a0;
> +}
> +EXPORT_SYMBOL_GPL(rmi_sro_execute);

