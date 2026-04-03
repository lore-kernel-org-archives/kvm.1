Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255EE3CAE82
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230240; cv=none; b=c8dB93j6RrKz+jiqpjzyb6Y50XP7LMhDyYy2xrAjJkldykTVz3S3kvpla5528FDVIBeQ8/V7v0N9izycZp1U4LYybs3J2ZyKc2gezHBIWI2k9yGG171hCYK6uE+Us7+rM+FTabUA0g5Y05Z9+EEyt18OOhl8boo3UOkh9im9pHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230240; c=relaxed/simple;
	bh=wcZKSn4aqs8KeLrWSY6SD1Iprj+DhIxuobe+sFHFbdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWdPz244EmZfixFd/Q2cyzbCpWghK2Ad/SYXZGNJClueIRr/9qQBgsCL1V0o73bPCZUxtjJ3dklG+qDZg8jpIaBhbk745gWGHuoD36WgZpUtzUWcb+S7HH68PG0r5l0SU/jygD+TkiEyEqnjKdCdLTQsGpWPG2K2fPwfhi5ecPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L02kEkE9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zed0AJYR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L02kEkE9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zed0AJYR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633B7umJ1562153
	for <kvm@vger.kernel.org>; Fri, 3 Apr 2026 15:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=x057pD4qBgfPmH6mGQKhbfbL
	KZ/u2npmqoIAxD1CZvw=; b=L02kEkE9FOYWgfe2dQtakWR9UsPL3StLa56Iu0UF
	3res9c4iJA2e2FD9Rp+3DG+v7VSToZub/BnjJiCP+7K6tdIhwJ1EoEFcTOWR3jkZ
	SJEexQqo05ehKOtc5SCv+Ej0nOFkYW7MlsnqhA+rlnSns4uAo53KYfK1xapvjbCC
	qAGNFWR+KyQfTqUzt67Z5lEWqH8a23fCEj4LSxgQ5Vt4IiZF+GUDCNAQvXjvRIdh
	6pcmW612kZN07QsahOzFfotPhL3Ju3R7JoVzCjm+IwZRks+wioNpnxDPYKieR6uH
	/VO0v+QX5ArUi2IxNrU4eFCVEQQTxssoixyoqMRzAqb/PQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9um73vfd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 15:30:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bda35eab74so2105906eec.0
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 08:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775230237; x=1775835037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x057pD4qBgfPmH6mGQKhbfbLKZ/u2npmqoIAxD1CZvw=;
        b=Zed0AJYROGxXOjeDU8zl+ZoYKClm+godDMuJW4DoywFSDb8WoQSb/2yiTlbSXUKieT
         TFuTqqaz/zoKUQfmzbpew/6ZfQgHbaANBSUzk9ciXpTVzvllZggiOWt93MJ1ENlTg84+
         +QbTZrlynrnOj41igxW54a8cO6Qepd+CGjOceFesgELLd79UVfC5GPyQN15Vz6sfpCPo
         qbf3KY0TWJZt/r4OGHENKyaW9dsmn+MHCjFT7v03h2a4BuPJEztv67Jw9IFXRUQ8Wn+3
         3bUb2rvG7zpFDXrau8/U/7jo61F5cmwN1qIz1AVS1ffLRxazNgIEUeiLyBMEL3H6Rs0S
         RgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775230237; x=1775835037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x057pD4qBgfPmH6mGQKhbfbLKZ/u2npmqoIAxD1CZvw=;
        b=FlgEnMtrx6l/A9f3LbBZQx9Y49eHPJgIJgmVobbYTm52qawVb8oS7aZnLjqNsUFPit
         urrMC13TsAAYsjucWIZPmfE6RXkIZXWjP2FF0RV9Fh5t+czrS4idV9ZF2BiAiySlfgEQ
         G5yDzE5Ig+7pYeqIf6p/lt/BfQSkcDpg51dZdM85rjBp+ReGiPnCx2pwPsGtRifcsVnD
         AfFjGoTp98WVhbqbd9Zw90xSAc5Oi3alvaOLuq4o2O1vBJTDdL1RBXw797tpnRqcr9m9
         p5GD+BEFt6WkwLD7W7mO7pM6k7o+VexSKF97l+4NkxEYU6AJXXLRIZyxweT+EzFXyevb
         398Q==
X-Forwarded-Encrypted: i=1; AJvYcCUllg8zrUihjYurdGb8OjJ9L1oMBjyVm+x4+x6Z2RaIUoDUyaBrfJn5zCPj1HYmlVXh4r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzansLd4gid0Qq2C4k4ByIYWXNSOhggCK6ijuHlinUGVnZwhrdz
	w2hIV8usFKoB6zYznT7a9WdfA6+EwJCB84eTxoR4DN9zih1tTYzBbLQlupe+ZrLoX0RUvRQynGn
	5+ya1aN/mYdqrfgvyeNMcT1puRmt4pZO0JbdP6wLtFRCa2RuQAh4ANoE=
X-Gm-Gg: AeBDietQy74TgyVX4HfSBpLMIkcJTLbKPqw7krs1QXTyQdLTkpMEmhCslhlPzl5FSdh
	DeYVjuHjlGYfLpVlDewafxdgWWHKubuWq7kDOdxqsLie+RcXT0HHH90WjjZoZhd/TaM5ygsTM67
	KCzSdMVVhwF8IYozZH/Rx5NqyWfnkWkndwrTbe0xZbj60q/EIXcwRcpxOqxr8z/DmEiHNwHWnc+
	i+X7crQmKJEH2dZlT5mLjMfJEvgM+AsrnmK8IovyeAccySItmaZn2xi1spcWJ5IzVqxaq4BZEvE
	3/qub0KXPTmRe8Xj+hRFBhktih6dkP86eqrvfkumjzNsmEMO7pjTCVju2VHw0Jl0R5+CC1Xxg/B
	IwKFz8NVq58SX6BVXut8JqA7GJBuwaco=
X-Received: by 2002:a05:7300:6c1f:b0:2c1:517d:5e97 with SMTP id 5a478bee46e88-2cbf9ee8ce0mr1399193eec.7.1775230237340;
        Fri, 03 Apr 2026 08:30:37 -0700 (PDT)
X-Received: by 2002:a05:7300:6c1f:b0:2c1:517d:5e97 with SMTP id 5a478bee46e88-2cbf9ee8ce0mr1399167eec.7.1775230236741;
        Fri, 03 Apr 2026 08:30:36 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cc0c6ec215sm2627655eec.4.2026.04.03.08.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:30:36 -0700 (PDT)
Date: Fri, 3 Apr 2026 10:30:35 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix shift-out-of-bounds in
 make_xfence_request()
Message-ID: <hkbpiuquqvsseu7tkv5gtlfxlj7qvsjoj6rndntty2btpcmdpx@4dfgpwffld2k>
References: <20260403061302.2203179-1-xujiakai2025@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403061302.2203179-1-xujiakai2025@iscas.ac.cn>
X-Authority-Analysis: v=2.4 cv=U/WfzOru c=1 sm=1 tr=0 ts=69cfdd1e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=rTD6Z3Ji9OhdE_Ng1OYA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: z1Mi-X3qwJvXb-CLzVCS2ClaY74iGQjE
X-Proofpoint-ORIG-GUID: z1Mi-X3qwJvXb-CLzVCS2ClaY74iGQjE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEzNyBTYWx0ZWRfX+6HlJgyyz+8J
 TL69XMbmYSx+0wq5amA9t5RaEjFsrh4cSMci0YGMfUM7mz8UnAklzipu5Lp3eEpES4raEw/FNmK
 33bcNqpU0vv5scDCnj+hXcTjwx2MgtMYSoEQQls6B51zpFqoqayA+2xUnpdhgh8mI4OK/fYoH3f
 924MXF9+/iyFB9l+ZnfD+JH0DbzZY4/ovNl3Mm/kfgGgcXxIKBZQ8E/POIAKtGf2yB531R6f045
 Vba7uncf/+ad1zcAH7nXUnSJm2nGSeGPGWtNR2r4TnQHJfl98tGVitN3+An3d3pbR4fzl8/TGvQ
 QOj6VjzEFJiP8N54TvF1n9APdIDTCjRLvtayKAHyVMOcrbUDNvepqk1nVmh0ARE12GvnlWPVjRG
 CB1RaIhir19Junr8wrImwNRFWyddYUPg8ijE4YaDlffVTSIxQGeeldeH43xgU6Qxcm+r8Q0ktY+
 DxKFGGBs4fDbqS9PzQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030137

On Fri, Apr 03, 2026 at 06:13:02AM +0000, Jiakai Xu wrote:
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
>  arch/riscv/kvm/tlb.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index ff1aeac4eb8eb..500e001513a11 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c
> @@ -333,14 +333,17 @@ static void make_xfence_request(struct kvm *kvm,
>  	unsigned long i;
>  	struct kvm_vcpu *vcpu;
>  	unsigned int actual_req = req;
> +	unsigned int idx;
>  	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
>  
>  	bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		if (hbase != -1UL) {
> -			if (vcpu->vcpu_id < hbase)
> +			idx = vcpu->vcpu_id - hbase;
> +
> +			if (idx < 0 || idx >= BITS_PER_LONG)

idx is unsigned, so I would expect this 'idx < 0' to produce a warning
that it's always false.

I wouldn't introduce idx and just change the current condition instead

  if (vcpu->vcpu_id < hbase || vcpu->vcpu_id >= hbase + BITS_PER_LONG)
     continue;

>  				continue;
> -			if (!(hmask & (1UL << (vcpu->vcpu_id - hbase))))
> +			if (!(hmask & (1UL << idx)))
>  				continue;
>  		}
>  
> -- 
> 2.34.1
> 

unsigned arithmetic makes my head hurt. It would hurt less if we
guaranteed the ranges of all the components. vcpu_ids are
guaranteed to be [ 0, min(KVM_MAX_VCPU_IDS, INT_MAX) ), see
kvm_vm_ioctl_create_vcpu(). We should also test and reject hbase
and hmask in all the SBI calls to ensure that hbase is in the
same range as vcpu_ids and hmask is in the [0, BITS_PER_LONG)
range.

Thanks,
drew
