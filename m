Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E7515982
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027202; cv=none; b=MG1FP9SJIEMs3plWC4Rg6m7xHxw9FGleYCF7msNYHATUVXnzwDFuX5Isb7MTJuX57l6W/oDO3lkJvcT8rVacUdv9alx7QbJLsE/CLyb8T3Vp0WHDr/m17nTy+2ZvQf2qpoUfe9fabshkWXesUnlCV2Psc4YnBqW/LUhUBE/ORYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027202; c=relaxed/simple;
	bh=QShqD0mzsgr5KsP5VmTpDyoWzdUjfsO4sL+xZPZ8Kno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8cXK6IhD2EppvoDIuFXwN2+y4q/sSIQZMHfjzyxaDxASQXCkwLaekPtU4kqvYfeSuQz7wBpokPMj9AlaKN5qFjNEXKKDWtullilB9E1Jyj8a+vEDl64Q6H1eMTH+snOh9SOW1+ZLZoIIWoOoTf0lh1fv4IC8swL7tnsNRRE2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EFoJNMx1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gZsFX//Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EFoJNMx1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gZsFX//Q"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LKemLb2741031
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZfOg9XYdQ5/vxidE+9pPRR6RYjJCbLCLOIt2gCT+9Gg=; b=EFoJNMx1X6Pv4FDS
	tMUSGAa9LvqoGHZBedDqvdBcDA7Cvae9SnITto4f09jRtlbuekCrbMc/2MAKvf6x
	gy2p3mZ2bhW8HdOSvKsdo/MKLNoMpVqXD90eb3NjmicVlbPWXm3gn48rxPFjxWVd
	ccE3FYDFyB3GFotA+QlERyQZ16B85/XCfZXm5v3vSsXF7AER0i7zlTvSQHCun1zu
	nfalxcV7idp0hPZlhBnqfZke+HLmsbX2Sc7DCOy8jejO2OtTqVCkLWdLV1vBiXSp
	9DeQc19R9BUJCDEQgouChdIxMP4QiqIcIk83GTs5CpiOtWouC/iXLzm7qBgeMsWJ
	YRLYVw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu01d3fda-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:46:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso6080753a91.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790027198; x=1790631998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZfOg9XYdQ5/vxidE+9pPRR6RYjJCbLCLOIt2gCT+9Gg=;
        b=gZsFX//QG9D6bwbjzukJJyUpL8+3eeG4XWZOeVez/SqYo+ydZPf0gJn//KwuBSrYiq
         OnArKanj18OJm3BJUZyqMTDldBcoBpvDSAxLqvF/9uB9YcvfK6WNL/zIOB/tOFZKzmuu
         /Q0JXfQboH9T/b+L+jKjupwg8rnWACVGZmJ8k6rl6xzndw+aUNJKNpq4a31TMGz+2QZ6
         WrUaDs5nhUruEvQb0OivxyyYvn8ZbBYDB1CSd7RshCGjtYcaSM7pfvLhzTcOeeaRMS4g
         +rJ/J83jxkLS3PXNGOSYunXWUBgfUPMVAf/KPqZ3OHYiUkTk3gLtOVDS32LWPPFo73cc
         DPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790027198; x=1790631998;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZfOg9XYdQ5/vxidE+9pPRR6RYjJCbLCLOIt2gCT+9Gg=;
        b=P+oLrSi55DJmcnKGUJo5PJ674lJfu3tvIJbJmsnMc5plZrFk3SrBE6aMzg5Su2bjhM
         iw4Zd9HQDZFHTiBygYZ3z8KtgQXO3+YLg5PCgxNxN3kZdrqVjFHpDyMmcu/g+lJDrxX/
         t2f57Ntv4CsgoZ/oiof+aQhoCAQDSn8koNtEM7QZ61laSpuoq+61zCn7j0pA1H+IdlJ4
         M75tmfRomLnxXmuV0dGyzfGYkY7TQfHMJeX9X2y62dgPajnSU9EemioZtxZE2F0xqeKw
         gJ6ooKBSGSMxNr1r64PIUgFl/0DBqbI1V28D8CKZ1lmpRxeLxna9Ji11gB9/mAFp36IQ
         2PCw==
X-Gm-Message-State: AFuF++nlsb0Xzz1VEfav4iOc6BEsDP3ncqR+VWwBD4shgaCJ9VEIob36
	c5rBLFhg7iLkqlVlH/poK6uwB5KNrX5pEaaUt6tPcfgcmhjcp9cKJLVKZlpOOrjsk5qIlIZzchA
	wG92evxRiiOg2UUco3aCBYHC/lhuAjtGtM8Ihe//Bwa6gVCFhcmwQhVk=
X-Gm-Gg: AYBFou1QrhvTvDa995nCNBRIn2sUcL1Fv6mRWa3pxTEqOLkKB20Wn7fUBYk31h8zuuq
	71nGCCEPsWDAWzHRIk9z5u+sBIrHA2aXWdzTMcBGJa9RMy7FycCM6zWtFWSs0lYY9LUr8on5QcZ
	esuN1ilrYJ4f/MKocsvlPgJui+vQqOq9w3j7uSfR7oWiSdK1XYaqWHAub7mmhc0I0jHqI5vthiH
	XNFv9l/cwohAhrQRvv7sdV+UKuOYapMhpiV+3xV4H3k+QKex5Z6Ggp5qcYggQC8r6/olusQOLDb
	xq6Ds1d/P3ojTHSprMTSHcY7JCnDO9aLv2AeokUZPYQjLqjMFpqM4gpV2zga9D72JeLyRsRYsRR
	VlbOgGva8Jn7wxTKSdc/MssFj7g==
X-Received: by 2002:a17:90b:2dc3:b0:39e:3ce1:d22f with SMTP id 98e67ed59e1d1-39e54d3674bmr17165978a91.16.1790027197609;
        Mon, 21 Sep 2026 14:46:37 -0700 (PDT)
X-Received: by 2002:a17:90b:2dc3:b0:39e:3ce1:d22f with SMTP id 98e67ed59e1d1-39e54d3674bmr17165954a91.16.1790027197022;
        Mon, 21 Sep 2026 14:46:37 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f0c7e0d1sm439586c88.10.2026.09.21.14.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:46:35 -0700 (PDT)
Date: Mon, 21 Sep 2026 14:46:31 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
        will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
        aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com,
        joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
        linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
        sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
        WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
Subject: Re: [PATCH v18 4/7] firmware: arm_rmm: Add support for SRO
Message-ID: <20260921144631.00007440@oss.qualcomm.com>
In-Reply-To: <bbb2f1db-5d42-495f-b34e-184a6cd894ce@arm.com>
References: <20260912083611.2513845-1-suzuki.poulose@arm.com>
	<20260912083611.2513845-5-suzuki.poulose@arm.com>
	<178978126542.2352296.15676256806777454164.b4-review@b4>
	<bbb2f1db-5d42-495f-b34e-184a6cd894ce@arm.com>
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
X-Proofpoint-ORIG-GUID: ksnXm12NJyZtWAn8UgxSf6xWQSxdeU9C
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDMxOCBTYWx0ZWRfX2oZjY5BnMR4Z
 XH7ucbdM3h/BhY5yV3evINe7KMoMIto1mEzriLpc+PoKeKbmL0qdzUKwsTPczOh+FFgseJrMLKV
 ChJPs+T7k/we6fapqTieiPcUEUY7E/M=
X-Proofpoint-GUID: ksnXm12NJyZtWAn8UgxSf6xWQSxdeU9C
X-Authority-Analysis: v=2.4 cv=Ht7jiETS c=1 sm=1 tr=0 ts=6ab1a5be cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=yke8hGA7Qea92797WwgA:9 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDMxOCBTYWx0ZWRfX6YNTGg8bCT/H
 AaUxbbnz7klnLCxayHPU0z3rIxV5s9ETSHjR654Jylv2DNXvuw4us0cCX+nXTihvO7/ZnTFX1m1
 8ogf5XA1cVBriAvWwvLAEXRQ8tZrG6Gir51S0lxFmrXAXugclFBpsfbiWCw5AZC7tQ349y5QTmQ
 Yl5TfjXqLElVqGB8QBiq6gT4Hbpfxa2Uf5tpaYwKgOqKhX7fLJBj2/7rQjCwv6qbhQXyAIOkblH
 rYStK95NjdkSDIbmF/T/F2Yw+DY+gGU0H5WaPUZwD1nBOOl6SiCnWD8Fmc3T4HMbkafUxcmSmvi
 bZyE9hnciUuy6QCeX/RNxdr8xbFkA7Fxf4sqmynL2vG7q1uUTRtdLet7K9Ch+bhj2BPMDMSaFeF
 dnnl0TVDrH4+lEmN6iRiPTZRtLYRrl6H4/bvmc6OW/FohRydUffU9GYUG6CFE1raU740pjB/Jwy
 RcPuRhbFLVGcQ8VPg2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210318


> >> diff --git a/drivers/firmware/arm_rmm/rmi.c b/drivers/firmware/arm_rmm/rmi.c
> >> index 5b0e342ce3d5..4f9898ece754 100644
> >> --- a/drivers/firmware/arm_rmm/rmi.c
> >> +++ b/drivers/firmware/arm_rmm/rmi.c
> >> @@ -15,6 +15,59 @@
> >>   #define RMI_FEAT_REG_COUNT	2
> >>   static unsigned long rmi_feat_reg_cache[RMI_FEAT_REG_COUNT] __ro_after_init;  
> >   
> 
> Was there a question here you missed ? FWIW:

I think inaccurate cropping only!  Have been using b4 review tui
(which is excellent btw!) Not sure I've gotten the hang of it fully yet.

> 
> I have expanded this to cover all 5 RmiFeatureRegisters exposed by RMM, 
> and it looks something like this now, with the use of ARRAY_SIZE() to
> limit accesses.
...


> 
> >> +
> >> +	/* Keep just the blocks the RMM didn't use in addr_list */
> >> +	for (int i = consumed_blocks; i < count; i++)
> >> +		sro->addr_list[addr_list_start + i - consumed_blocks] =
> >> +			sro->addr_list[addr_list_start + i];  
> > 
> > Maybe memmove to make it clear you are shifting a chunk of the array
> > down.  This might be worth some asci art showing each step in brief.
> > Anyhow, something along these lines:
> > 
> >        memmove(&sro->addr_list[addr_list_start],
> > 	      &sro->addr_list[addr_list_start + consumed_blocks],
> > 	      (count - consumed_blocks) * sizeof(*sro->addr_list));
> > 
> > Obviously doesn't save code, but maybe simpler to understand than
> > the loop.
> > 		  
> 
> Does the following hunk look better with the comment ?
> 
>          /*
>           * Keep just the blocks the RMM didn't use in addr_list.
>           * RMM claimed consumed_blocks entries from addr_list_start.
>           * Move the entries left out at the end i.e.
>           * [ addr_list_start + consumed_blocks, addr_list_start + found)
>           * to the rest of the valid entries and adjust the addr_count to
>           * reflect the available entries.
>           */
>          for (int i = 0, src = addr_list_start + consumed_blocks;
>                  i < found - consumed_blocks; i++)
>                  sro->addr_list[addr_list_start + i] = 
> sro->addr_list[src + i];
> 
>          sro->addr_count -= consumed_blocks;

Good enough.  Not sure there is a perfect answer for this one!

> 
> >   
> >> +}
> >> +
> >> +static int rmi_sro_reclaim(struct rmi_sro_state *sro,
> >> +			   unsigned long sro_handle,
> >> +			   struct arm_smccc_1_2_regs *out_regs)
> >> +{
> >> +	unsigned long capacity;
> >> +
> >> +	if (rmi_sro_ensure_capacity(sro, 1))
> >> +		rmi_sro_free(sro);  
> > 
> > Maybe a comment on why you free the whole lot rather than a smaller
> > amount to make some room.  
> 
> We don't do partial free of the list today, and having that is
> unnecssarily complicating the logic/code. We are going to do a reclaim 
> anyways. Sure, I could add a comment.

Might be useful as a breadcrumb in future but indeed not vital.
That was what I was assuming was the case.

> 
> 
> >   
> >> +
> >> +	capacity = RMI_MAX_ADDR_LIST - sro->addr_count;
> >> +
> >> +	rmi_op_mem_reclaim(sro_handle,
> >> +			   virt_to_phys(&sro->addr_list[sro->addr_count]),
> >> +			   capacity, out_regs);
> >> +
> >> +	/*
> >> +	  * RMI_OP_MEM_RECLAIM always return RMI_INCOMPLETE, except when the
> >> +	  * input parameters were invalid.
> >> +	  */
> >> +	if (WARN_ON_ONCE(RMI_RETURN_STATUS(out_regs->a0) != RMI_INCOMPLETE))
> >> +		return -EINVAL;
> >> +	if (WARN_ON_ONCE(out_regs->a1 > capacity))
> >> +		out_regs->a1 = capacity;  
> > I guess this should never happen, but bit ugly to fixup the register
> > return rather than perhaps using a local variable instead.  
> 
> We pass/get the out_regs, so local variable doesn't work, unless
> I missed what you were hinting at..

Ahh. Indeed, I wasn't thinking ahead to it being visible after. 

> >   
> >> +long rmi_sro_execute(struct arm_smccc_1_2_regs *regs)
> >> +{
> >> +	bool cancelled = false;
> >> +	unsigned long sro_handle = regs->a1;
> >> +
> >> +	rmi_smccc_invoke(regs);
> >> +
> >> +	sro_handle = regs->a1;
> >> +	while (RMI_RETURN_STATUS(regs->a0) == RMI_INCOMPLETE) {
> >> +		bool can_cancel = RMI_RETURN_CAN_CANCEL(regs->a0) == RMI_OP_CAN_CANCEL;
> >> +
> >> +		switch (RMI_RETURN_MEMREQ(regs->a0)) {
> >> +		case RMI_OP_MEM_REQ_NONE:
> >> +			rmi_op_continue(sro_handle, RMI_CONTINUE_KEEP_GOING,
> >> +					regs);
> >> +			break;
> >> +		default:
> >> +			WARN_ON_ONCE(1);
> >> +			if (!can_cancel)
> >> +				return regs->a0;
> >> +			/* If we have already cancelled, don't retry this */  
> > 
> > Maybe expand that comment a little to say if we can get here under a
> > valid sequence and if so are we guaranteed that cancel is complete
> > given that is what caller will probably expect if it gets -ECANCELED.
> > 
> > My reading of spec would suggest we can't hit this path for the
> > calls that are not memory tranferring. Then again we can't hit the
> > first cancel either so all bets are off.  So maybe this is the
> > bet we can do.  Also can_cancel shouldn't be true after
> > rmi_op_cancel() as I assume you can't cancel a cancel.  
> 
> Ack.  This was to handle a buggy RMM (and soothing an LLM bot)

Modern job titles: LLM Soother!

I aggressively cropped previous email. For avoidance of doubt
the rest all looked good to me.

> 
> Thank you for the review.
You are welcome. Thanks for pushing this forwards

Jonathan

> 
> Cheers
> Suzuki
> 
> 
> >   
> 

