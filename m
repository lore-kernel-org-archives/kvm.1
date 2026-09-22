Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7497E52F27D
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115331; cv=none; b=jDKgiidOyt+TO5vF828aDVWSjpg64Nh9c4GJlQtMKivEHM3aOCPasWSy+SnKixrqtWWkgPP54Z1GRmtcShD61ty7jkZysU9KU+2713Yq3J9gXsoHZIrPfBBiGI2KMj9iENTPujecoZ4aw4ZHKplcKjhM3kKxSMTceP3YZcx9gYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115331; c=relaxed/simple;
	bh=2I+RK594+7yvlbEyJzoCiZ3ZLN/AQWF6AlkeQkLTv14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MinEc4DqsNffswKPfRzFpmR3Sa4sh6zeT0S2fF3k/tGOQTgAxPzRJoTdkr1R80KyZWdFTPSrv22j5K7+UsPKLU7xvVo8hSE5AB7kEfKGj9cB2fyVC9T4OsPd1M7jkO6Riouxzc31quhFWvv1vOMUK+A+nI2pIdrgcRIl8xxSEwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LUIg3yqi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZScst4Lp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LUIg3yqi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZScst4Lp"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI7QPF900443
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3J+Y3qFDHro/ofj9RaFrKGahhFH3oBBHZcDF842RuqY=; b=LUIg3yqi9TH9y9gg
	F/mIr66JscemBMTu6ta06KCd3tUQmpN94F8XDNu2Egp5ULhY9mPCicRZtFxQgTPd
	HGWoa3EhlM3QVW+9XNz2U1tdp77dEZ64XmmdcwCnIPWNS8kMKkGmaS/Skqccsero
	ZInCQfVzqdZdF6ngjyH+Lsf4v/G0j7PHPaIMQIDuXKK+RYV3dTQ+QE3CsiYEa3b0
	BocityRN+JBLonLjGZKk7WPacf64e9IPfnE9NpzTgFwsb8D0R87Ii7AqmXA78xqy
	6qwoFni+9GOvuAsazk/Dr435tBhsXyyNAEHOW9B54SD34831GriuIr8E0HdmbVGo
	2zdD0w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gunjyv2gs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:15:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33bb08e80a8so252997eec.0
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 15:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790115316; x=1790720116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3J+Y3qFDHro/ofj9RaFrKGahhFH3oBBHZcDF842RuqY=;
        b=ZScst4Lpe97iX75gCsYgKPhRQduVizXLcG9KhP1KoGPylhFA1oN773svihE6I0DDY2
         +QGgZcPhfE2KiXEBliSNiIh0BVA423t4qcSSWr6piiV4n1WU7r49y+KDby3va1wr/it7
         7HfuxvgdU6zq29DAR/tpTyqbouPTFkPcXpwA87bMXmQBnKmWZQehy7jXSDa095UsnxRq
         wIsqbZIHuKBsu6ZMe5tex/vr0wDCdLXm7+clR/+grhaSNX7RrJA4sN2RkG7yIbOsOQay
         WbthgLujwgs36BTL3lyvFm4LYMt5VS+zlA2XRB0x9pqYQSrX79IMcruXDh8d+dGa/hyY
         PqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115316; x=1790720116;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3J+Y3qFDHro/ofj9RaFrKGahhFH3oBBHZcDF842RuqY=;
        b=gMJL58EF+5twFHMWepbadaxqvDbUrR6DirjmWrRLpLr1Iprat1MGMJmxQpRtay22u8
         tMSDKKZLM8RnDyhQKZKy+wHbU3Waawgha6RXc9HW7p5njLFtKb7VLJLZDrfF6iTIpbrq
         EOuzrC6C8wfG+Wi6jULLWPbBoIrMYecn8KJgjSfYB/Cam4SOqdmlpYpQQ/pzUoCz/lka
         MnnsYBszcpN5/hXe+8P1ngYSlIWmTW4rzd5eqWJwM/P4wQlN9pd33HMAZog90ky/6HGz
         3IfauGtkIjAH12yFFIq4YvlK6DxgYH6Skbgm3LTQZ/oEPZmqvFjBVWVmf0BNe9imByGo
         kgkw==
X-Gm-Message-State: AFuF++moBnKtQMvidQIR7Y+aJSxU8wR1ZI0VY7D4B/OBAZ4SaKQbJTpK
	ccJrJcYpn6yd/Uu/pnmClMbg5VZH9YYURX6qCXJ3w4xhyCaUZH4N9LTn3BvxLRUbmb5OO45swlm
	LUINwdibTHhlt4K2deGWkzAIJUFmY/4zdCN0yEVmEV129gd21k5//xY4=
X-Gm-Gg: AYBFou2AazCmhIuHLFmQ7wFNFGIjwsgJzNg+TRCvtJbLSLZsDYkfF+y5hP2bmDR/J6b
	FusdsJc24tD7ZL513KjImAZ4lwdjRPGPP6AcCmDFlUBT/r6tNA8wZCLMon/2+e7HmOqCAKFx1U9
	QgRd2iMKNqzjVVZor4iJG+5PbQ0KjW51DVLgGt81l6tRdMtJS40vsiWn0Hkii1KuSH9ReqKTScv
	9g/TZ4fZmn9x7dLd58PMDeJph8IzDZ4eo0NguTtiTYuQNxpzuYXeF2z8AFhxCqwNFeK8FMIad7b
	HsOE9qZvGz/ZQBakx6UFu2A/Xx5dQH6+ohcOjI8wLb04NgAHkU3k5JAQHqtLS0FEJSJVlOwc3ho
	cNpLdVOZcWDaEHOxow58C3R9AqkF4u7dfxREsBRikqKWf7Uii3kYMyw==
X-Received: by 2002:a05:7300:e9ce:10b0:33e:6c5a:37c3 with SMTP id 5a478bee46e88-33e6c5a3aeamr850800eec.1.1790115315788;
        Tue, 22 Sep 2026 15:15:15 -0700 (PDT)
X-Received: by 2002:a05:7300:e9ce:10b0:33e:6c5a:37c3 with SMTP id 5a478bee46e88-33e6c5a3aeamr850779eec.1.1790115315280;
        Tue, 22 Sep 2026 15:15:15 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9625825asm1072047eec.13.2026.09.22.15.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:15:14 -0700 (PDT)
Date: Tue, 22 Sep 2026 15:15:10 -0700
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
        Fuad
 Tabba <fuad.tabba@linux.dev>
Subject: Re: [PATCH v19 08/20] KVM: arm64: Reuse kvm_stage2_unmap_range in
 kvm_unmap_gfn_range
Message-ID: <20260922151510.00003c76@oss.qualcomm.com>
In-Reply-To: <20260920212845.707-9-suzuki.poulose@arm.com>
References: <20260920212845.707-1-suzuki.poulose@arm.com>
	<20260920212845.707-9-suzuki.poulose@arm.com>
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
X-Proofpoint-GUID: GakJR9JvHO2mTQJpZjDaIzVNidt8fV_I
X-Authority-Analysis: v=2.4 cv=KqHYSmWN c=1 sm=1 tr=0 ts=6ab2fdf5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=kMqVnm4xDtAkP_aMvZEA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDMwMSBTYWx0ZWRfX0wQzCDIvr+3o
 wWPvckAdLfSJY2mnRFfyLEjQkyL9Smw04wb6AeQuo4REJpWsYWcBY4UcN/n1VDBQWyaYdiYDiov
 drwGP+w6hganRRrU9Rl2bW2Mi266zJQDvnfyIHDFrR4xMSb9ej76pddGbYmwjSjK6YD5z2NVNIY
 ecq6EZ0N/RQowHCTusuKdMbOwoKXF2sJdUQ9bCzZWOMeR1NixicHJfncTW94RPL5unamXrETHGB
 p++/MJIr44vJd4Y6LfD3DtY4vYXvvvVHsfKdqQL2NYDxDpx87ZaMRcHHD21PgC8rTZOLD8BUZin
 PZqO8iTYDTDqkuCxAVYdO2+3U5b/R4T2vMLdIgYfSD+FbDqK577zkinkxQ9v9vGV1uIeSSNLfXl
 DBoBUE2tdI8PUfeRSsUYjlNrFxoeBCLEjdVCYZAuXLwCit30pGSSeBkMEYkXpsOcmFaLXSIZP8j
 Bld1hNpOLA1H5Or+pCA==
X-Proofpoint-ORIG-GUID: GakJR9JvHO2mTQJpZjDaIzVNidt8fV_I
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDMwMSBTYWx0ZWRfX60oWHcCm3r3a
 mTasJYbduI3nWgFlh1Ujdc05ePzr4r1b27AIrln4rMCgYiRVGJEmwH67oBpIJHUUb5zqriBraky
 sjQA95AM2sASLakj5nvf5uqvyHgY6/o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220301

On Sun, 20 Sep 2026 22:28:33 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> In preparation for adding VM specific backends for stage2 operation,
> switch to kvm_stage2_unmap_range() instead of __unmap_stage2_range()
> from the kvm_unmap_gfn_range(). Drop the bail out check for protected
> VMs and defer that to the one in kvm_stage2_unmap_range(). Later we
> would replace the logic in kvm_stage2_unmap_range() with VM specific
> backends.
> 
> No functional changes intended.
> 
> Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Trivial thing inline. Otherwise this is fine.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  arch/arm64/kvm/mmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 0f4e8b71fa85d..03f2017a7404a 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -2436,12 +2436,12 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>  
>  bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
>  {
> -	if (!kvm->arch.mmu.pgt || kvm_vm_is_protected(kvm))
> +	if (!kvm->arch.mmu.pgt)
>  		return false;
>  
> -	__unmap_stage2_range(&kvm->arch.mmu, range->start << PAGE_SHIFT,
> -			     (range->end - range->start) << PAGE_SHIFT,
> -			     range->may_block);
> +	kvm_stage2_unmap_range(&kvm->arch.mmu, range->start << PAGE_SHIFT,
> +				(range->end - range->start) << PAGE_SHIFT,

Looks like indent is 1 too many space.

> +				range->may_block);
>  
>  	kvm_nested_s2_unmap(kvm, range->may_block);
>  	return false;

