Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277E030B50F
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329785; cv=none; b=bR3kT4fQ7h7LzOByri+0yYf7kvsbclEWLnT74Q3ZWOUs583HypctS/R8QaHtDyu6EN9Mg++zAFF0CjqFkgBx0b0XRWpqcHkBErYvEK3TDTagCfn1S9ZDXHQNW2a0XYr7lEHZck6e0iwsfsSwJr5OcRzTJhWOLT5Fw55sK7roXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329785; c=relaxed/simple;
	bh=JBMusOAvhQq9/AdFF7EY+l0lSk+p+80U8c5h7s1EBnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTX0fnbHltbdBMSxMap1AdItUouWxkNN/ZbgVa5oI40CtCbFWwnD8XTuiXSeTcn7AmieshYKChkVkO2II3mxvNBtgYSJ4a546M8Np/MBzqlO2STYkrz4kJniQTpO8vJWbsteR6MlFFTBtTHg2bDAjyaME7izL+9oeHzQBa2Gt2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NbxAPdKo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SbpCrb8Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NbxAPdKo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SbpCrb8Q"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G6ok1f218928
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 08:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7PJKkSl8igezGMSjj7lPVu8P
	ECVNUlUo2WNQqgBP0H4=; b=NbxAPdKoDsZzWMXdXMrFQoUQxjz31jjjxA/6ZbLe
	RevTpxrcJ5W3ZfKhvZXzz59whcSQ/ePhzXVzjs1ci0f9z1Rst7ygLV8ft+RaWocI
	ATrwYD5ULhHpxIDwxu9VayTd3UZp1idaxB4KMM/mBmH7UlfYMLAmGUGMqiz0lVAE
	EphmRqC63AJzfBcl8I5yrQ6sMjM9zxR1e7a/sc5i/xnXOaXL+aBvXiavsjzugbDV
	giCzqIh2ZcMQQIDeubrBvG8d1yM1UmzGYfGOfEGV/DCrx+LpAYqpOqstytoHZqMR
	dFFf1sbGIoMUDzEho72lSHF9uDLZ/O+KBHFIicULn8pSLg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djtuygg7a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 08:56:21 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12c20a91932so17871878c88.1
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 01:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776329781; x=1776934581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7PJKkSl8igezGMSjj7lPVu8PECVNUlUo2WNQqgBP0H4=;
        b=SbpCrb8QpnXUwhJZQP7Vhw4N3kJyJ9GuxG+jU67exT+sI4LfKYjD271Zr/sbgR7h3L
         gQ4sqAeqd1xLDGMFzyVGPkp0eFvNPqANRJ/lqs0zaQxmzPQFXbyuNLU0IVjEG14ijmN6
         XA/jQm6iys+ylntpsP3Vf5ZVU+cX9CuWP1eXsO3gXOuWTUzqZJV+XqtphabbCUrMPdl0
         g5T9auLWyk0UTdMmtZuO6sy+5TRlADoVdDDnJhy5l5jdAmHJAQQ8QKwGc7Lpl3MU/3RM
         Zkf4Lb/j41K3c5Wyq2OJINPx8jL5Z9vNGBmCZhKgksmNUvfCuv6ilGP5MA6lRFhQdVTp
         igpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776329781; x=1776934581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PJKkSl8igezGMSjj7lPVu8PECVNUlUo2WNQqgBP0H4=;
        b=C2P6NqZcgEtCktrj2ZftOvX6BERq0YbiwLTEjduEVBSQEMo8pu/r8PCfjP3RkeLJKo
         xiNRrS1a70twQazxBkpXYIWMklikXgBLyTTRarpxoqmez4YRQ2EHvbDM+t03W9nn4NML
         0k0XP3JAgcWxUBdiCdK3OJxE9a+81yuMDBNvGRy8CZkHgiHxkP8wCi0sw5RTyb3Vgmxn
         8tclmVwtl5zdhyNKKzbfnsUu+uwSpYEUjrxpbcB3zBnUQttqAGlqPUZfdfJZRJoIBN+6
         54WnsjaO1qjpW7Hj/DWm0AuCUl030gYiuryGeixdoJGxQIuNbvyIolrQ0Oa/BIjigcV/
         9HmQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QpGuuoNJenwQCVQvi5Mg5wW4AVO2Rus+Hl+jEtusPJ49vh0ZkSbW6l7G8IkgphGfxk5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FR1q8I4ljnSLuQjXS0TBXQ6n/A/awzt+dyDoKrmUXUn2jwkP
	F+Ut9eWASIUVbhCn7fJmw3XNMCiB5PKTf+8nQAo69RK36PdYb8uV6mXYMEyEuWUXzcK/Ri78UrK
	1SJC3YlNuiRbTnF+ph+mLg1iY1blh5Xd+RCpp6pXODBFw+O9AStB4Ekc=
X-Gm-Gg: AeBDievX6ZrKG7MXmdzuAjdCI7uz4rQk0PMTwdrRL9ywiiMW+hRy+gICafCc/WHzLoy
	QST0HNBrFxFe3+XjB9REjB4Ty2zATO7uzQBsnv7ehIunG7XuySgoMRmaqR6BcpQNaJUcEhHux45
	Rpkdbm487lrQGXkPMISa4KzJh40W28ABCGDimVgh/+boqHXooQYxRINAYrSLm4mQ7vX0d2JOfsR
	+5FKWfoqa6aYUc9wOk8MCNIKD/vDGlCgNyp6vJamrSIFXvr6k4NGn7SH5otLuMj0AshHDmEyhQA
	vjZQYWHV9e00UTqWDnb8TRbI6Wz74do1fjUoWP0njAk49t09sVF1ejJ2/y/o6g9gXKN90fwBu9Q
	7AZwYmedEepOyqL0cheETywcgiWO5F4BrK6E9QJxhpsAx34p/iwp7WFq7S3yr
X-Received: by 2002:a05:7022:ec6:b0:11d:f89d:85a0 with SMTP id a92af1059eb24-12c34edf982mr14938554c88.27.1776329780581;
        Thu, 16 Apr 2026 01:56:20 -0700 (PDT)
X-Received: by 2002:a05:7022:ec6:b0:11d:f89d:85a0 with SMTP id a92af1059eb24-12c34edf982mr14938542c88.27.1776329780065;
        Thu, 16 Apr 2026 01:56:20 -0700 (PDT)
Received: from localhost (ip-86-49-249-15.bb.vodafone.cz. [86.49.249.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e6b6a05sm5919161c88.14.2026.04.16.01.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 01:56:19 -0700 (PDT)
Date: Thu, 16 Apr 2026 10:56:17 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix invalid HVA warning in steal-time
 recording
Message-ID: <ddka3tcpcus5od4hmzauxyyqzwodqdeyzj4ttq4op5iusfugve@yacboe7mg5e2>
References: <20260415075216.2757427-1-xujiakai2025@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415075216.2757427-1-xujiakai2025@iscas.ac.cn>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA4MyBTYWx0ZWRfXzbof9c8Wf7be
 b8O2AY9lYu7n3RcrOVsEy39csTcSBwwe74HDuhKu5ZC8YTLSAL4Jb4WW3il69O4Y6CiJEBicE8Y
 Hd+OST5NFVIq+H4iHWN1CAjwYLCKAkRYXHov1l28+aLufVxFAi1IDIUZVP9QpD/BE6Jw2EG04G7
 v2lLFO0KzQyRUCTdA9em6CnCUMXJFTa5yMJSaN3ud93L81pDbaZGCyzstsJWpgqAVlbW0SIj8P/
 ca82aHoeAlNf7d+nctyv4NREZDEeKBPSkyQBgFlqx7vX7mFAN88cMqF8XgqeAKXsyyY3x/4NNGx
 yFdxZe/anI+z58sgz8p1dg/YN1HNL3/abWEM6OxumlZf4nTuGwg8Xmu30mhMaCaV2O/5yQRWazD
 rMhlmLNQQ3NPVhDyQywuKnRupY0M3+/eWe7ll+J9Is3aLLinjsiHsWK8K+bdpnGV+IC2RcXpAX/
 amqju37ysMhkOI8o0lQ==
X-Proofpoint-ORIG-GUID: rFmhxFXrpQSHbdQMqxh0Mrz4qLDsyBzL
X-Authority-Analysis: v=2.4 cv=Ipgutr/g c=1 sm=1 tr=0 ts=69e0a435 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=fuErIE+P63Icv3tqjtEZBw==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KdkbrdStzu5tqnZBQrIA:9 a=CjuIK1q_8ugA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: rFmhxFXrpQSHbdQMqxh0Mrz4qLDsyBzL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160083

On Wed, Apr 15, 2026 at 07:52:16AM +0000, Jiakai Xu wrote:
> kvm_riscv_vcpu_record_steal_time() assumes that the steal-time shared
> memory GPA (vcpu->arch.sta.shmem) is always backed by a valid guest
> memory slot. However, this assumption is not guaranteed by the KVM
> userspace ABI.
> 
> A malicious or buggy userspace can set the STA shared memory GPA via
> KVM_SET_ONE_REG without establishing a corresponding memory region via
> KVM_SET_USER_MEMORY_REGION. In such cases, the GPA cannot be translated
> to a valid HVA and kvm_vcpu_gfn_to_hva() returns an error address.
> 
> The current implementation incorrectly treats this as a kernel warning
> using WARN_ON(), which may escalate to a kernel panic when panic_on_warn
> is enabled.
> 
> This is not a kernel bug condition but a normal invalid configuration
> from userspace, and should be handled gracefully.
> 
> Fix it by removing WARN_ON() and treating invalid HVA as a normal
> failure case, resetting the STA shared memory state.
> 
> Fixes: e9f12b5fff8ad0 ("RISC-V: KVM: Implement SBI STA extension")
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Assisted-by: OpenClaw:DeepSeek-V3.2
> ---
>  arch/riscv/kvm/vcpu_sbi_sta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
> index 3b834709b429f..60e50296a0085 100644
> --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> @@ -46,7 +46,7 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
>  	gfn = shmem >> PAGE_SHIFT;
>  	hva = kvm_vcpu_gfn_to_hva(vcpu, gfn);
>  
> -	if (WARN_ON(kvm_is_error_hva(hva))) {
> +	if (kvm_is_error_hva(hva)) {
>  		vcpu->arch.sta.shmem = INVALID_GPA;
>  		return;
>  	}
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
