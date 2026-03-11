Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0BF3DDDB5
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247928; cv=none; b=m1Rzk4MGaC1m9kIXa1d+ifgRri25x6BbqJUDTo1SmhfTgyaFiUriSU1pbjj9ROpQO7saI8s0pu6EJ5ixwS2xb+dXY+dPImpDolffNAXagc9jSOk3M3lfiQGN5ENpHqd31q/nbgrI9JPUNonI79ZqojeRLTETue0baMTMTYK92Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247928; c=relaxed/simple;
	bh=Q2RGr/uHujuBOsGY5DfP3vDJmdkb7/tC/cwQuB6iGc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBukXmFh/VUbKjdED/4UP5ZrwTNesxIVS+1szJEKONUHRDRdzi8O8/vusGCG9OQnKrBMlIhAmiNCk+jr9V0dssYgVi55ZZJGYIopEiX0epqlGivdFAtunmPloUla21No16clR1lQlci/8DIYv4Za/NH3WOxqfPo1i8BXgXd7tKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nbSFXa8z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y3aqWP5N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nbSFXa8z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y3aqWP5N"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BD7vUt4032622
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=y3/JAW+oGfTE3BgR575SvjKP
	t61kz+8CmpWiBiOLuUw=; b=nbSFXa8zbVW04UR3iGjV/y2nQU0cIJB5fIuIpNrB
	dB/eJOcWljGTnFzeLjAeI0ABRqyBIyUKFJ1wdq7yzWKgNsTeQKuigY1qdb5PmnaJ
	oZ3fcgf6bTe+BeXglfvEQDBY1CRAfnhkoX6n+HEfwXzGR2D3iK05JY5xHpIC1IHZ
	3v+uF8Ga++9meEkPQ1pIXuyMVfOnbBc1KGT8w9hbKrzbzG0mObW6re0Cpv+mo4yY
	W0bZ6qbz2x0yWT7eMpMpSlcKGYRCCx/0sIyYJuTFLmw8ndJnBHJ8P26gQVeHXLR+
	VD9KYFwPYSnusa3S81pVF341iRDPIVoGioWuqdadGkoP/g==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu90t8wbb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:52:06 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d748bc34cfso1141818a34.1
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773247926; x=1773852726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y3/JAW+oGfTE3BgR575SvjKPt61kz+8CmpWiBiOLuUw=;
        b=Y3aqWP5N0AFRw84C+vC1UvisLrhbLHqGeBsNFzYO3lZ3ybbnQC7Vmyn8uF2CW68tMj
         3HaYXeq7y+Lv2NO1Ao8OyaEuU7M6iaqFGJJRl/4P6biEmNna5FCPDyvGoMdon/qYEn3I
         aZyHoJf6KFd6C7yS6/rGDnfnJdI5R4IzAK7dAH588BjPf5dR/heJ2datowiueSN+mRtD
         3UfeAH0ZF9Q6KTkbQ+PTXaqtIcP5Q3SbyGJ1tMOGdhSl1quAJ2b9TYRWbrZ/Nvqee4Qu
         5hxE2xsT2arM0LEQg70fyu7jqRWmKCmx4f8RtUso4J4YSxzTQ5I1Q1KSowbXE2GXR6Zq
         WiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773247926; x=1773852726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3/JAW+oGfTE3BgR575SvjKPt61kz+8CmpWiBiOLuUw=;
        b=hBq4QdQZYeNIXlclsMzrAZ5vStXvEaGmKe9Uc1nF3qVzZFtAwXVr121hyEPmGbAsyy
         ptO07gVB9bqEis1Nv6oCq0sGV+0ansAPmWMZLaYNxA9YdsVWHRVgBNaOQUnmWeBiXHgM
         oTs2sa9JczEFC61/LnTx77Ud38ruSuhcbZc7iNgE5j0jxG47otCBaISXlPrWL7d62CiT
         17khmsrY2CS9kI62wlGaCWa5WI9wPVZhRs8RbaW5d4OT1OXg6kyFLxJN2+YyQ/hyHXl1
         oj63PuWYKg08qTOPB7xt9wHJau7SKfm6WNpVbMeeOx7NEsWNEXoWG4hsI1fIaGtmuBMM
         EvyA==
X-Forwarded-Encrypted: i=1; AJvYcCWVSMbSbgnB0ngMyulDcV5/d3YOVRXRrHH/WUVLzlBn9bLiKm7r/ryAAUWqUqFvKh8Vv9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8lq4fvWFdEWN3n6+C0iPhOuj3kaDUv1hiwNcn2d8JtvWntl3F
	XY7FVk41eVheRxkDu00BXJj8QlyNa4c9KZxUwBzeMWAcOszMALjwYUl9QsW1LbNJpibbeJR+r5+
	o93M+N/xRuuaC31XqV2Ky+30bAeTXUiOzclYyfT0kdusiWR3E0PdjUzU=
X-Gm-Gg: ATEYQzwNvelpJYyt1cBF76a8xgcT6v6op29O4pT+wVPiinVZXz8QWMWtxVKq3tpmZ6R
	JeKbMr/FqjSA4x9FK0115l6/Bx+4rFKuXs+ykNX1B7JDA9AMdwhzfWmRa5Bfwln/+mw2D5coba1
	3haml/LJkNA4VQ3j+TozBn8yy42geejH9ug0AKMWnvYm9fj3CaZwFSkt8pzWFO6+K0AS9ZxBkYO
	iihkCymkpUDC8v7whxvTHmz6QwPx8LXuECUEPED6DHlf6KnAZ/J1lCFekPK9lkXYWymqqy3ZLat
	axSFSJfqoArvKLu2sF7GkIly48CnSBUp/f9ObgKtTF/KSzuyMJ6tCg2+eI9uXsOSJCbsam56RO+
	09qaZStkYrMKWEfbB/o1ACcTz7d1AELQ=
X-Received: by 2002:a05:6830:6c17:b0:7ca:c7a2:c935 with SMTP id 46e09a7af769-7d76a79e74emr2127320a34.35.1773247926100;
        Wed, 11 Mar 2026 09:52:06 -0700 (PDT)
X-Received: by 2002:a05:6830:6c17:b0:7ca:c7a2:c935 with SMTP id 46e09a7af769-7d76a79e74emr2127304a34.35.1773247925706;
        Wed, 11 Mar 2026 09:52:05 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7749f1f5csm389205a34.6.2026.03.11.09.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 09:52:04 -0700 (PDT)
Date: Wed, 11 Mar 2026 11:52:03 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <pjw@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: Re: [PATCH v3 1/2] RISC-V: KVM: Fix array out-of-bounds in
 pmu_ctr_read() and pmu_fw_ctr_read_hi()
Message-ID: <2apicvahmomu57i7gjd2cgc5cakq4pxsbphz5xnl4cr2sqvp72@hqud4u6bo53b>
References: <20260310055557.835531-1-xujiakai2025@iscas.ac.cn>
 <20260310055557.835531-2-xujiakai2025@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310055557.835531-2-xujiakai2025@iscas.ac.cn>
X-Proofpoint-ORIG-GUID: 8dI4v5TXEvCn3ca72DmewZrN2Ix71qlP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE0MiBTYWx0ZWRfX7yNyjNOjmMvQ
 EbxeFL4kwcs6vKirD3rmyweJqLjbLcog0Es/FRuGVxPUccNF24U+3QPxdjHyu3W9hi4XXG13Op7
 9X2zltXo4xxEF+2g0+zjZdhy8/cZAO7pdUvS07f+At2t+27R9A0agMU68IXAHvasvIRt7o8ul+2
 3q3I0QD3s4Ov5BjTabTqVNnL1nIyRHa8NwQW9Rw+Tuw5C/Iak61EJeh2shN1lraMzJJr09Wac6Z
 q4PCyJGbwHIzTJ7AY0Y6mjRtEY8OkTYX4gjOzTA1sYT7OpDy+4K/brROgA60QW8bqV54PlGzKFL
 TvEwZp0GyPy7U2F8FduEsm+2c1kssdBTe/J4FVKwquzdHC+CTPUQGj+LB3KcLMrL0sh8N2Xyehk
 M5LHgXY3WutMOJknEK1d79eVEPrlUtRWjkgwMDoVpZzauUwVJGRd7Ho5PJgUlH77y5RGglIWFDR
 qd0gOJct2Afp19hMwbw==
X-Authority-Analysis: v=2.4 cv=DfEaa/tW c=1 sm=1 tr=0 ts=69b19db6 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=RS4Nko6ylG0vjQzhQroA:9 a=CjuIK1q_8ugA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-GUID: 8dI4v5TXEvCn3ca72DmewZrN2Ix71qlP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110142

On Tue, Mar 10, 2026 at 05:55:56AM +0000, Jiakai Xu wrote:
> When a guest invokes SBI_EXT_PMU_COUNTER_FW_READ or
> SBI_EXT_PMU_COUNTER_FW_READ_HI on a firmware counter that has not been
> configured via SBI_EXT_PMU_COUNTER_CFG_MATCH, the pmc->event_idx remains
> SBI_PMU_EVENT_IDX_INVALID (0xFFFFFFFF). get_event_code() extracts the
> lower 16 bits, yielding 0xFFFF (65535), which is then used to index into
> kvpmu->fw_event[]. Since fw_event is only RISCV_KVM_MAX_FW_CTRS (32)
> entries, this triggers an array-index-out-of-bounds:
> 
>   UBSAN: array-index-out-of-bounds in arch/riscv/kvm/vcpu_pmu.c:255:37
>   index 65535 is out of range for type 'kvm_fw_event [32]'
> 
> Add a check for the known unconfigured case (SBI_PMU_EVENT_IDX_INVALID)
> and a WARN_ONCE guard for any unexpected out-of-bounds event codes,
> returning -EINVAL in both cases.
> 
> Fixes: badc386869e2c ("RISC-V: KVM: Support firmware events")
> Fixes: 08fb07d6dcf71 ("RISC-V: KVM: Support 64 bit firmware counters on RV32")
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> ---
> V2 -> V3:
> - Added check for SBI_PMU_EVENT_IDX_INVALID.
> - Added WARN_ONCE for unexpected out-of-bounds event codes.
> V1 -> V2:
> - Merged the fixes for pmu_ctr_read() and pmu_fw_ctr_read_hi() into a single
> commit.
> - Removed the pr_warn, simply returning -EINVAL instead.
> ---
>  arch/riscv/kvm/vcpu_pmu.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index e873430e596b..c87a7b0037cf 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -226,7 +226,14 @@ static int pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
>  	if (pmc->cinfo.type != SBI_PMU_CTR_TYPE_FW)
>  		return -EINVAL;
>  
> +	if (pmc->event_idx == SBI_PMU_EVENT_IDX_INVALID)
> +		return -EINVAL;
> +
>  	fevent_code = get_event_code(pmc->event_idx);
> +	if (WARN_ONCE(fevent_code >= SBI_PMU_FW_MAX,
> +				  "Invalid firmware event code: %d\n", fevent_code))

Align under previous parameter, not the >= operator

 if (WARN_ONCE(fevent_code >= SBI_PMU_FW_MAX,
     "Invalid firmware event code: %d\n", fevent_code))

> +		return -EINVAL;
> +
>  	pmc->counter_val = kvpmu->fw_event[fevent_code].value;
>  
>  	*out_val = pmc->counter_val >> 32;
> @@ -251,7 +258,14 @@ static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
>  	pmc = &kvpmu->pmc[cidx];
>  
>  	if (pmc->cinfo.type == SBI_PMU_CTR_TYPE_FW) {
> +		if (pmc->event_idx == SBI_PMU_EVENT_IDX_INVALID)
> +			return -EINVAL;
> +
>  		fevent_code = get_event_code(pmc->event_idx);
> +		if (WARN_ONCE(fevent_code >= SBI_PMU_FW_MAX,
> +					  "Invalid firmware event code: %d\n", fevent_code))
> +			return -EINVAL;
> +
>  		pmc->counter_val = kvpmu->fw_event[fevent_code].value;
>  	} else if (pmc->perf_event) {
>  		pmc->counter_val += perf_event_read_value(pmc->perf_event, &enabled, &running);
> -- 
> 2.34.1
>

Otherwise,

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
