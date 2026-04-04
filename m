Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1C2327C0D
	for <kvm@vger.kernel.org>; Sat,  4 Apr 2026 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775327419; cv=none; b=GVNWinO2+meJxYkLwYbZEkP0CPwf7mpYQZYRYi1jNZMTdiKIkWtKKzS2RVqg1xcBxsoaNzrzF/KpJqwYWuU2d9xnhA4ITGNiN59EHXAWxG8d0TJtTwlHOVl8dEplDvdtOWs1qurryEeDJ4ke+3TtdJwW8QwIcVvWoTBwdlzJujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775327419; c=relaxed/simple;
	bh=g6+w/wwpCszeJvKPSgncbDQEiDvEx1KZXxQw0Gkkm3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHTtM8CdFv9YGpj9CDg27mSmnWaeXeuzoI5rp7hfDIB6IP3Oa0YxA7tr1gC7Wdq2x/jXhNkhI6kjL/QAoUQ5wYHepTWoHggMAPyXqZg/NdRqySC9sx7YnS1xTV4oa8ylrkXui9K3p7Wkboybt+/RD6xeuqRigd21P26X/VwS4TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AaTvDD/A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FC8sysp0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AaTvDD/A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FC8sysp0"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6344emHn2974021
	for <kvm@vger.kernel.org>; Sat, 4 Apr 2026 18:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xZAhnUMRLmcuKZOyI5wbt1Fs
	LKvLY6ymjIDrFpm94Vo=; b=AaTvDD/AaECxzOw+j83T3cVf42tZqXUnRXqztmtq
	wJaY6vJ2KBjBvOfLbJHaF1Ae24UmRJ1iSIqm+WJioy+YNJEJqlE9AXJRHCw5GjmL
	bfaOSkfQscEj3GtG2r/PZt6iLu5PymAMA1ip4zTDuQKxqHNSq/sxFXrMLIWghFLf
	daEtT1D8GYSiezX/btwQaUC6nzgB2CtEpTH3CthxUWZ+34YFUomghvBQVdO7bM7C
	+GhSvcl4n3uX4w0W/hBLE6W0aCzSEZSgi+Y7Yq/MpbOl1qujcZckGAzynKsDC1jy
	C/UkMC4375wTZLDfOrzqyGJG15avBFTt6U8m50jaA0ZUsg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dauth970r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Sat, 04 Apr 2026 18:30:17 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7dbb97a2b6eso4145041a34.3
        for <kvm@vger.kernel.org>; Sat, 04 Apr 2026 11:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775327416; x=1775932216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZAhnUMRLmcuKZOyI5wbt1FsLKvLY6ymjIDrFpm94Vo=;
        b=FC8sysp0wu1aMjan5eS2agifl4sdZ5XWkpXqSlLzFwEwqC8JwI/4xNB0DRRWPG57oD
         c8moNu09HDuywy2rkJOwogaVV3cB/+6+cVMeqaFPwu3LieLPNRTCpv3OGbBOYMN8Foaf
         XKkcsh3eADwng13FzOhH2PY/kFUZqCeroRi2fpr1hEsbxIH6GehGTZ4g/xLB594o3Svn
         XeLln6C31WmxpXHq1gOyb4qR5MR17eF+ybGG4Pxy1SOVccptmox5ysGsqq96+3vULKFv
         sLYi5zgC87RO2cuPz/931QRDC1+VFMjWHCTPd1IhEbTq/PA6Gr0N5Sk1x2JlWyQwY9iu
         dBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775327416; x=1775932216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZAhnUMRLmcuKZOyI5wbt1FsLKvLY6ymjIDrFpm94Vo=;
        b=DgfOjVko3J8zNnpl0SLgx2UzWUGLH+ZY1VmrsP5djUmCgvvi+qHykdp6bg17FphdaY
         XtMYS6tH9GdQQKvcjVq/SOaTTIugwJA0N+P5+N8ygjmzGTRlI53soJ0XA3iDxAuxRBse
         Mjia1novnQUI9aFqqxcwZyLjeg1zTQTiEt25otS50aPMFnafTcAhdEWjC5uC/daGae5x
         gP05JwjBkwGfqrmeD3JdwX6+WspVtIbQZWP9t1+YaSfEpk8askjG2fnQijHp7ybnNGYn
         r4OPFTtQrWaGndAVJDdB6PFMq73SZpieQczyiikmbesEqhvpImsPWNO2G8jdijCYrYhN
         Kwcw==
X-Forwarded-Encrypted: i=1; AJvYcCUneTKPuL67JsxFTRLTeGOueVX5X+tDO/AYwhWMPnXTICNeYalfXVcSeM15QgYA/hJx5Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAaIIbWMcl+9eVo78JHBB48fEjY8jdekjbJHeg8EFfCW2D0UlF
	znwHzJI/MYNhhzSPW2l+gD9iKp4t7DvyuqkJ9x+T+O/XDy9OHNnyRnZSMrN4kONYOt7QHbakvup
	UBivK1hbJrYsm6MlUGmLUHzOOTvJdVwjN27xHugrGhzKUHqpvEUVjWVI=
X-Gm-Gg: AeBDiev16v5vlofW+4x1XQCrcByWIem8SY5ra3bMP9X5e0/cd0KzeRjw3NUsEOc764S
	FCOb6LcyEcOKi3MYxOjFrBHKh+8zhSr/nY52xUPLW7IEMwMlQNTc8d6fEaiF6p3EInCA9SsGqFj
	j3CWPBiPer3iC2GX5Q3m1MbKpMBDky4ZnDn9liVqzJoNZ4fTVFFzirNUjyj9JfUuWJAWNazyLQw
	fdezkqYDh8TdBAEJ9OZ4X42JmjmpZT2WoXJjgZevawxMRYTveXu1SYiesDb5NCYvgQUa22ykO3C
	Gc+hXOhrYyBZ+74XpK6uSgZNwi0OE8GHS27jqCVRRqWwFNLzHxRxIc+ceT4s1jFcZeXVZ2S48bR
	yy3MyM+WQIIuCY2Jk7/kgfwFs0u3by4M=
X-Received: by 2002:a05:6830:34a3:b0:7d7:fba1:f950 with SMTP id 46e09a7af769-7dbb7177bd4mr4168295a34.26.1775327416478;
        Sat, 04 Apr 2026 11:30:16 -0700 (PDT)
X-Received: by 2002:a05:6830:34a3:b0:7d7:fba1:f950 with SMTP id 46e09a7af769-7dbb7177bd4mr4168287a34.26.1775327416085;
        Sat, 04 Apr 2026 11:30:16 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbd663a4a5sm420968a34.25.2026.04.04.11.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 11:30:15 -0700 (PDT)
Date: Sat, 4 Apr 2026 13:30:15 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: Fix shift-out-of-bounds in
 make_xfence_request()
Message-ID: <uqj5bh45tsakyjwswvjb6mv3esvui4eq5tic65o3b7ljoev45e@s5rlgtdi5dlf>
References: <20260403232011.2394966-1-xujiakai2025@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403232011.2394966-1-xujiakai2025@iscas.ac.cn>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDE3NSBTYWx0ZWRfXwocKIiC95d+y
 5oDGOwuoCnDCi8yyH5wH39pikgypOiEn5M/icGyaE1Wq/FqzI3+Pdtbx0s5kKaESQ9ihR0tYd7x
 y5tB+fgNpmSTretvfVQMEl90ZOvkK6+sa1MEhEnEbFE9KVw+Ny7dubl435ilJ9Yuc+fGzikqlui
 AK3jGpV6scgAIDZ95crrx/ZOj96UQdVKvNBxrMXwRZtF4seB/XiejvJPGFjnFgyE+0m6pQiczLd
 OFkcODTipA0xGucyWxR3aAcnYmakQu00Rir4g7XZouaYe3y+92yvhkMM855agOzIlyjp9Qsi8XY
 HSWwJhW8BPmAQoCQkMZxUFuXdA6I97InAZissZ0ctASoni6Jvmf3Ci6Q6L4HY+c+o+W2lNpguuV
 7T66mRXlaMzePu0mV/uYkLZ4bo2DW7stq0fQM9Yk9tlIWD2AfO+VT0e4SzlfuNnrB0qM8KJ29om
 hXnr0LMrd48MCp0aJdg==
X-Proofpoint-GUID: 1dVJLKKMgqRZLcietH25l8Kf0SZUfCCz
X-Authority-Analysis: v=2.4 cv=MIptWcZl c=1 sm=1 tr=0 ts=69d158b9 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=xswxI8Vr1sjf9FmkDDsA:9 a=CjuIK1q_8ugA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: 1dVJLKKMgqRZLcietH25l8Kf0SZUfCCz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040175

On Fri, Apr 03, 2026 at 11:20:11PM +0000, Jiakai Xu wrote:
> The make_xfence_request() function uses a shift operation to check if a
> vCPU is in the hart mask:
> 
>   if (!(hmask & (1UL << (vcpu->vcpu_id - hbase))))
> 
> However, when the difference between vcpu_id and hbase
> is >= BITS_PER_LONG, the shift operation causes undefined behavior.
> 
> This was detected by UBSAN:
>   UBSAN: shift-out-of-bounds in arch/riscv/kvm/tlb.c:343:23
>   shift exponent 256 is too large for 64-bit type 'long unsigned int'
> 
> Fix this by adding a bounds check before the shift operation.
> 
> This bug was found by fuzzing the KVM RISC-V interface.
> 
> Fixes: 13acfec2dbcc ("RISC-V: KVM: Add remote HFENCE functions based on VCPU requests")
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> ---
> V1 -> V2:
> - Dropped 'idx' variable and compared vcpu_id against hbase directly,
>   as suggested by Andrew Jones.
> ---
>  arch/riscv/kvm/tlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index ff1aeac4eb8eb..439c20c2775ab 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c
> @@ -338,7 +338,8 @@ static void make_xfence_request(struct kvm *kvm,
>  	bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		if (hbase != -1UL) {
> -			if (vcpu->vcpu_id < hbase)
> +			if (vcpu->vcpu_id < hbase ||
> +				vcpu->vcpu_id >= hbase + BITS_PER_LONG)
>  				continue;
>  			if (!(hmask & (1UL << (vcpu->vcpu_id - hbase))))
>  				continue;
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
