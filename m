Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5CE3164B4
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668175; cv=none; b=Iu8VL8JOlE2c6YZl9llBnYEz888Etl2m5gKpDdzNRt9sHwmiKu+otimVEtZpcrmTFhnFwX+f+Elg07ilO6nq9DqQypn73tBwtxhr1oB+wU/dZ4L/Y95+Zmvkb2H9vXXvB1BA5vh+MsgjPz0+WUDFvsdTN+QqKGKE/L1Jv1VfmkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668175; c=relaxed/simple;
	bh=r1IjBkU3646lOwcvEXbhsToJlMhbKn0Olvzo3Ik8Sd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5WbGQh+y3Uh1SiMo1HaPR4cuTnM4TSGhO0WxMt491zu5IYM1lpFJBjoe8padjzT+JJRXB44I/X4lfq8CBVQy7IsEy1GfxL6dYmdHJM8VsSGu/Zcdpa1kWggtqSJFU0m6inoIaHcwsq29HU4KOqJQrynbcKdwh7POiN3RPV9XFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=avkXEZXv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="avkXEZXv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JNoiYZ3689187;
	Mon, 20 Apr 2026 06:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CwL52M
	GJ8c1IpPyE+ys9kqBvjYaxLRDWBHsBo71u48A=; b=avkXEZXvqPSEonvNW5uTJ9
	2KNBa31ORBOtlHFcVTXheLoDQ3whUVOP6V3+d8wq6WPBCjyX9RmfvcGa5PMZ0PmQ
	14nfQxcwI7yoC64WQgk04FRe0OmizPVJGnuTjgi7KFx6wm/9nOzx8IBVcGbHtR3l
	mxzcLZuEPvzke35GwgUs4szLK9bx5S9YLtXCu5cTLS3RRjteYuBdwBfSBUMhcXdS
	eOOxmNG4sZlLPDpy/WVBNqcdwOPhEv4HfL1oleNpuKhispOmtRbuKpwTE+JR9PJu
	8ooTm9+3CXX1sUKOvblPRrbmEZPoWIZjLi5uTVqflVENUX2fLpRXu0XuuhXaJxug
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2nexkx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 06:56:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63K6oJxw002815;
	Mon, 20 Apr 2026 06:55:59 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmn9juq7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 06:55:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63K6twHL24642074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 06:55:58 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E91AA58056;
	Mon, 20 Apr 2026 06:55:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2790858045;
	Mon, 20 Apr 2026 06:55:54 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 06:55:53 +0000 (GMT)
Message-ID: <41f8091f-78a5-4034-a235-8e8f55f93c21@linux.ibm.com>
Date: Mon, 20 Apr 2026 12:25:52 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] target/ppc/mmu: Restrict hash32_load_hpte() helpers
 scope
Content-Language: en-GB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
        BALATON Zoltan <balaton@eik.bme.hu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Glenn Miles <milesg@linux.ibm.com>, kvm@vger.kernel.org,
        qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
        Chinmay Rath <rathc@linux.ibm.com>
References: <20260319111936.68041-1-philmd@linaro.org>
 <20260319111936.68041-5-philmd@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260319111936.68041-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 4HGd4fSzItL7vDOHwM2YIj7eaxXwJBLV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA2NCBTYWx0ZWRfX8bV46rLsl4hX
 OLqbnDMjJ4Gi4yQng4HI3hyZP2Tz8B0lwgTD+eb8mcAznVqc+xpcsROM7TE8T82Ux1LpeuqtZhu
 zbdYSQQaUXVbuDftts6xbCZBwe6HJ3PKAOGFW1jArudZsjOv5PLcQLy3mBR7kXA/as80IEFDa9p
 UQpca/XVQLY7dBQtdsuNB8Ymv8f5h41fngvixZbojFK8WVa+4jXh9XuKQOmhhyXREZq2bgvQ92D
 pQKurNp+EUtOlwS76+oM8c7GRK+KOp74Ps9hMRd6PBeaXN7uP5Ngx+/q60oDYBGsLKHjlEr9a2/
 GoqPwDTg4ZN3SNeWTFcuz1wYIj0C/57NLanm37hocBkhBor+FwdZOUAXPo+eANYg/DusZExFTdd
 scEy2Kxnbow0NIk95PLCCfhJWOk1kj4wE2l62C71lyPPiAjuP+MpmwO3w1AXDqdiGdFdHDT0cuh
 iInOCXm43ZGobf23P+Q==
X-Proofpoint-GUID: Hwr7rD3K332NdYoR0_6StyByY8D9Vq0l
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=69e5ce01 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=0I839AAy7vvk_TsqX-0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200064



On 19/03/26 4:49 pm, Philippe Mathieu-Daudé wrote:
> hash32_load_hpte() helpers are only used within mmu-hash32.c,
> no need to have each file including "mmu-hash32.h" to compile
> them. Move their definition to this source file.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   target/ppc/mmu-hash32.h | 16 ----------------
>   target/ppc/mmu-hash32.c | 14 ++++++++++++++
>   2 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
> index 5705f57935b..bfea03ea872 100644
> --- a/target/ppc/mmu-hash32.h
> +++ b/target/ppc/mmu-hash32.h
> @@ -71,22 +71,6 @@ static inline hwaddr ppc_hash32_hpt_mask(PowerPCCPU *cpu)
>       return ((cpu->env.spr[SPR_SDR1] & SDR_32_HTABMASK) << 16) | 0xFFFF;
>   }
>   
> -static inline target_ulong ppc_hash32_load_hpte0(PowerPCCPU *cpu,
> -                                                 hwaddr pte_offset)
> -{
> -    target_ulong base = ppc_hash32_hpt_base(cpu);
> -
> -    return ldl_phys(CPU(cpu)->as, base + pte_offset);
> -}
> -
> -static inline target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu,
> -                                                 hwaddr pte_offset)
> -{
> -    target_ulong base = ppc_hash32_hpt_base(cpu);
> -
> -    return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
> -}
> -
>   static inline hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
>   {
>       return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(cpu);
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 8b980a5aa90..08c9f63a132 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -201,6 +201,20 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, target_ulong sr,
>       return false;
>   }
>   
> +static target_ulong ppc_hash32_load_hpte0(PowerPCCPU *cpu, hwaddr pte_offset)
> +{
> +    target_ulong base = ppc_hash32_hpt_base(cpu);
> +
> +    return ldl_phys(CPU(cpu)->as, base + pte_offset);
> +}
> +
> +static target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu, hwaddr pte_offset)
> +{
> +    target_ulong base = ppc_hash32_hpt_base(cpu);
> +
> +    return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
> +}
> +
>   static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu, hwaddr pteg_off,
>                                        bool secondary, target_ulong ptem,
>                                        ppc_hash_pte32_t *pte)

