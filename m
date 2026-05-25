Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336914ABE
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719102; cv=none; b=nOfVTjLutv4i2t1GZ+SQU+gi5nOkTJtBudXs3wP5ohK7InikPe/yVt+SiHPg4Y++g/XL5pwIztcHPwkkqny5mVmAch/cy3x0H/kR60XLeiIqF/PwmiV1BceygS05xaGt7NvPY9I9McnSf+cd6SmvS+OKYID0gEBZwpy6tS62anI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719102; c=relaxed/simple;
	bh=Ik4gChE5nzM+/DFp5tR/uk91Fjprza5YX5/VXS+5G80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guGPLVQYvUL4TCJz5+xr5tiA8YxXUcR/wGX6BwR/28C50h5HZDRAXGzCZM0/VqVzQDYQ+gROlu+USZm0sZMBpZ8l4BWpCJZQT7NHfxvjmujymtRRe/ZPeQQruuRbMYdf/7J/ff1yLqraRWphWzsptzXqz1SnlViSBiUo5UkDrpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SpvBpIyk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h+2zmMuf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SpvBpIyk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h+2zmMuf"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PA4ri82146351
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 14:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CimRH9tWSXyiYROIt/pqx3jW
	xGGINVTH7plufiWPUGI=; b=SpvBpIykoluXKkwoVd19Xfm29xS1/IiNWs0Sf0rp
	o7yqitoLvyqnRWiaPyPCGw5mlhPPcpsl3Dzw4NRu4Yw8MK6umJ06AzvdXZ55zMyW
	G0K1WAONJQgkeRHD3TN9AS9CcUucZBN4EkCB6tBWmaiRMZUNTd90cooob3AEZgjN
	0Dk4fy+6U3bCsyc49yOnL8xoil2j6SufoPySKKjbjhThHuANQVEErvb+J5LQXWoe
	NNed/9gC4bdAFN3ls2KtvOAsDWfFXeVAyPlxIK9gT8qQQLhG+/co25lpeSbeLsg3
	9griLae0lbmatS6y0kU2m9fjr2Dkc2i1fE7vlbz0H/xOIw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecmbv0ud7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 14:25:00 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1353bfdbf99so4779880c88.0
        for <kvm@vger.kernel.org>; Mon, 25 May 2026 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779719100; x=1780323900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CimRH9tWSXyiYROIt/pqx3jWxGGINVTH7plufiWPUGI=;
        b=h+2zmMuf0tbE9Bl1Uve2UYbMxQzMijf3OKKKMfMhfml0QlUmLwaxS2pxZaffLZeBVZ
         1oDvy8NX19O/HVyGSIyefHD+1LwIbaDpd6MleOHOAlVoVe+KTi+Opq0qRv2pMvGrNnod
         BilSzhGtsj495ls0X/KQv4SLxt5IDYP9vMTPGI11RydBuJI0kaeUsNxLNScbSNu3EBtU
         2+RZe8IoYpsVc31cAkhZ8cGZUrnkFNgqDaQiCYzZgzuX+I+dcyxPQoFJnrHniXqD3QsR
         ABPOlk7ZCoI6gHM0YVjiUEnwYnTg5Zz3RqOmq/qcBoj0hEGmUDvYWNUVHuVyytXoHanE
         fsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779719100; x=1780323900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CimRH9tWSXyiYROIt/pqx3jWxGGINVTH7plufiWPUGI=;
        b=DFtHVFQW8pI3aO1iouvXu/mHfvzY+AbolXfubqv//sPjik9wmYcqZWnf6vV3gIY8dx
         4AUDRLz1c1HdnNGcttAtFaOdcercorS5UB4XModTbMZkFN2ls9XnRDYlq2o/cXcZ5oj1
         +5Db0WMmOGkBs3P2beWMxU//q01ExU5aqi8yph2FqDz4cqZbWRRm3V0zwP8EAKX3deHA
         am+5jYjDIoTog5jS4BAbYDIkCxEI/KRopUfTAW7LqZ3QT445Bk3XMokQt75wRKTSWzaA
         I1mjbkRxQQCBN92uqbP0/rUlHuwiEnwpK6zO7QGm6tF3XJIztxBru3WbwLMDdIK7N/e5
         WEFg==
X-Forwarded-Encrypted: i=1; AFNElJ+9QBvMvwh29kCG8BGanrH5HBZLKUAEovaqayhmWvRMZ7L+qjG5pXNEF49ZAw5Z2wbQ9iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8uN0lCX2mpNmwDcEARVIAJ11U0UhQMr4KoD9qy1Ht9+byy++e
	dOv5UXc0W9HTWqgbuAXkjiKoPb1RZyxmXqzk+sLGNb/42102r6q9snQBpBFVXhBYis4VNR5giQP
	GG1CuY+vU5UDm3KpqZfK5QexER4oEUP4+Dx1FFvpTjK+9UQUkuPwRHvWFLduBUJA=
X-Gm-Gg: Acq92OHmTWU+H1op3P4iFKlwRsuPbrM+8fox0YAsqLWHZV1yPtzTfkNbNPwrz46wYDI
	zEOFGs1yiKpQPfLWW5ld1phIHxau8AiuRELcv1WmMyJVI6EkaFQwOlvkiT5yx0yVQcygYs+DzZl
	H/E/C+mAs5RhhuodfRig3RgKQkdMBDQoJHoo0qskVC2W7wbvCw8Dp9CDgjiVHrPr04mkGJyHClj
	SAa8H+QeCJfMugY5gEs0c1eCdTcVqT7JdG5CQMS061E8imBEZ0r+kWvQC8i8IsYH+Kt4rLp9vyI
	HkXmy7D99xSkqjqtXWMsK/sbfKA4ED+zhDCFavhgzH1efxdQgH2JpKcvzngkctuTWNBvjKw99GQ
	IG3sCWSi65jYa5Tc5xTnyKxS5OVjCFEo=
X-Received: by 2002:a05:7300:640c:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-30449128923mr6707557eec.23.1779719100262;
        Mon, 25 May 2026 07:25:00 -0700 (PDT)
X-Received: by 2002:a05:7300:640c:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-30449128923mr6707536eec.23.1779719099671;
        Mon, 25 May 2026 07:24:59 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452230b25sm10085541eec.15.2026.05.25.07.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 07:24:58 -0700 (PDT)
Date: Mon, 25 May 2026 09:24:57 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: Document a TOCTOU race in SBI system
 suspend handler
Message-ID: <las73pw6yo3judqw2355p3vjecbneglvam7tqwluak7uag5mew@ck5foo5g6a2u>
References: <20260525013642.999187-1-xujiakai2025@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525013642.999187-1-xujiakai2025@iscas.ac.cn>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE0NyBTYWx0ZWRfX1ypvR6a50lic
 f1Hs9oG7DQCaLQlmb1nnfjuKKImoPjhenczVspvsSxztmfAjYpa/TNruxu34dYb+xY3h/LYz+wO
 cc070IJpzze3ksKmnKGA1wGnzaAjP4Y9wTyNon0bykdx9mSZoYSyHnGvBfoZ6nH+dd48/HX3ZtA
 jIytcEn2VXV4ViXFMPAC1P+dRrgriK1aRrIwxlzPNrdeARleAH04Y9AjZmfyNNOvOanrZRcXtCb
 9SfFRrW9ViBS2SFCaGmyuP9gC17vwhZ2Md6v7r1gPa6cjFKmNjNg1h6PsBOmnNqE8KsG3eSKGG4
 sUeSHOgcY7xthS70uxHVvjHzbKvQfdTM76S/avDUJFVg0V+Rjag2Owt/SCC6TUBfObuIz2vptsn
 ZH+cSObEqcn6EzbGhtWVRqVumXX38P8TMh6v1XYim190d5DLC8buQLGHbi3VSOzOKoCZlkd6CSP
 3Y4O582cbO6C4ArdAjw==
X-Proofpoint-GUID: 1oeSFetoF4zcY6lV-IkCAXGv7356y2TH
X-Proofpoint-ORIG-GUID: 1oeSFetoF4zcY6lV-IkCAXGv7356y2TH
X-Authority-Analysis: v=2.4 cv=XqTK/1F9 c=1 sm=1 tr=0 ts=6a145bbc cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=EP6mWf-phXB2IQ1a4JYA:9
 a=CjuIK1q_8ugA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250147

On Mon, May 25, 2026 at 01:36:42AM +0000, Jiakai Xu wrote:
> The SUSP handler checks that all other vCPUs are stopped before
> entering system suspend, but a concurrent HSM HART_START can start
> a vCPU after it has already passed the check.
> 
> This is a known TOCTOU race. We do not fix it because:
> 1. Triggering it requires a pathological guest.
> 2. Only guest state is at risk, not host integrity.
> 3. Userspace can double-check vCPU states before suspend.
> 
> Add a comment documenting the race and the rationale for not fixing it.
> 
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> Assisted-by: YuanSheng:DeepSeek-V3.2
> ---
> V1 -> V2:
> - Replaced the fix with a comment.
> Link: https://lore.kernel.org/linux-riscv/20260521142030.1560861-1-xujiakai2025@iscas.ac.cn/t/#u
> ---
>  arch/riscv/kvm/vcpu_sbi_system.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/riscv/kvm/vcpu_sbi_system.c b/arch/riscv/kvm/vcpu_sbi_system.c
> index c6f7e609ac794..6f64a59e5d3c4 100644
> --- a/arch/riscv/kvm/vcpu_sbi_system.c
> +++ b/arch/riscv/kvm/vcpu_sbi_system.c
> @@ -35,6 +35,20 @@ static int kvm_sbi_ext_susp_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  			return 0;
>  		}
>  
> +		/*
> +		 * Check that all other vCPUs are stopped before entering
> +		 * system suspend.
> +		 *
> +		 * There is a known TOCTOU race here: a concurrent HSM
> +		 * HART_START on another vCPU can start a vCPU after it
> +		 * has already passed this check, violating the invariant.
> +		 *
> +		 * We do not fix this because:
> +		 * 1. Triggering the race requires a pathological guest.
> +		 * 2. Only guest state is at risk, not host integrity.
> +		 * 3. Userspace can double-check vCPU states before
> +		 *    proceeding with suspend.
> +		 */
>  		kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
>  			if (tmp == vcpu)
>  				continue;
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
