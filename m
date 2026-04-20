Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602EC2ED843
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667567; cv=none; b=RXlTKrNOLYxWzBVAeaT2E7cdveYmlRWSoi8E4pKHwAieRdDAv1bS7+8XwXOadAN3MRJ2qmoXI0V+DojAjJP1vueGHJjUW63cMhA84bak/ke/PTLyFxE4bvfuoC8uKGpXfReq1twSrxyUGPfspo6UdCRje/2PydcAAdrfNI1bmXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667567; c=relaxed/simple;
	bh=Ke1Qf1ESZsYb4HQpmNmb85IY4nqlhvEJooQlnMCS7ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEMCEGrVFBHuMJI7zhfi8x5dZqUvLSan3eXhqW0yAv7XlB20H+OH84Lpg+KkUeNRjjvIDSY3k1/Pc5SkvBBTZ/vNJPxYYHsrwfMni3iBE8r4DpDJlRnRSehs//kyO55ph8gA+RaegeZDPK/+aiR8qnVkgDn89OoCRTZ8PLdbWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EK00B4DI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EK00B4DI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JMaQGi3550653;
	Mon, 20 Apr 2026 06:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lOVKSN
	WQAub57EocY0WVyHyNZHIQKlvW4675SlHv+CU=; b=EK00B4DIzm/Ueim4xgjysP
	H3qmR/ujY5TcCs5Eq4i+FQXT8UCLcZ2+RqPIoKbAkZwleNHvXx9JPR3fi5Sneqef
	W1/VtXnmbyCkN2IKIheVwOw3LkxWbR7JEkgJOv2gvkO7ZJ9ehT34R3/mj3H147Zp
	62X1DFY+j3XvrUkZlBbMQGlkcW0yAgZGPwF0wS+KkJVSUp7KAPZ77SmXOm6hYnVK
	xEHC3sSUT/9LrxK6lkR9wVwJW3cMaFBE15Sos3Zx5T78s5Zaa0dPEi/J9Z2kXqSv
	vY5wwpF11Z3QqmZQoVjxel5vTM1zC1KqOT6oqWeFh1MuxJ42RS3kyekBeigM0isw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2nexjw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 06:45:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63K6ZFqk003329;
	Mon, 20 Apr 2026 06:45:42 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpyxuf50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 06:45:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63K6jfiO14942766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 06:45:41 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3060258052;
	Mon, 20 Apr 2026 06:45:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A251758045;
	Mon, 20 Apr 2026 06:45:37 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 06:45:37 +0000 (GMT)
Message-ID: <ea4afcb6-6603-472e-92ed-7761a15d1ae3@linux.ibm.com>
Date: Mon, 20 Apr 2026 12:15:36 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/ppc/spapr: Un-inline rtas_load/store() helpers
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
 <20260319111936.68041-2-philmd@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260319111936.68041-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: p-YCUuje672pLu5AB-fTADie0FMqcfZY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA1OSBTYWx0ZWRfX4L5zRHq9uLsj
 5YbpnMkJ3VfAhD4IiJFD50oWt053RBz0TGO0eweVSlPZA2imk+xF9NxT/vwUvg4cAtHw8Umfmsr
 f4rJwIUrk6SxIBFhfNhdT9Y4E+hw+UAC3ma59xSqSTJ3c94XoyMABKXUSh8xNv/in8s6EQn37Mv
 JMYtCC/J5VzXHdY5Zw/EiDrf9MUVGNIMgCAEXU2+bneVMUCcwUblc40oQ5Ka0PuwCdnTtlpWWM9
 5kIBeJmaWwJeivMyqofPy1RtoAT5K3BBjQlMCXuM2SM+HfrEA/86i7KxV2fbfMWrfnovG30Afa2
 tzxo4gDy0AKU5w5q+2kSA9p0hqbIsV20aAxOXyEssGAiFkcE35/LjGz63p0prj4/77ADrF3DsBm
 AsHu6dwgPjNWivwyKB94W/xmNyjpvRj9yOWVkiPdvthk11iay194XpjNjbrGCEIyzIB7AlSB72s
 YVIY92I2jWgFJfdtmcQ==
X-Proofpoint-GUID: q5K-yI5bxp0JBWfmKuHLTzRVRaCcrX3l
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=69e5cb98 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=ALTUr-PPrISsu7shrVwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200059



On 19/03/26 4:49 pm, Philippe Mathieu-Daudé wrote:
> The 32-bit binary doesn't use these helpers, so don't need to
> compile them. Rather than using 64-bit target #ifdef'ry in a
> global header, un-inline the calls since the helpers are called
> from I/O (cold) path.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks for this cleanup.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   include/hw/ppc/spapr.h | 18 +++---------------
>   hw/ppc/spapr_rtas.c    | 15 +++++++++++++++
>   2 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index b022f8dd25d..9acda15d4f6 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -796,21 +796,9 @@ static inline uint64_t ppc64_phys_to_real(uint64_t addr)
>       return addr & ~0xF000000000000000ULL;
>   }
>   
> -static inline uint32_t rtas_ld(target_ulong phys, int n)
> -{
> -    return ldl_be_phys(&address_space_memory,
> -                       ppc64_phys_to_real(phys + 4 * n));
> -}
> -
> -static inline uint64_t rtas_ldq(target_ulong phys, int n)
> -{
> -    return (uint64_t)rtas_ld(phys, n) << 32 | rtas_ld(phys, n + 1);
> -}
> -
> -static inline void rtas_st(target_ulong phys, int n, uint32_t val)
> -{
> -    stl_be_phys(&address_space_memory, ppc64_phys_to_real(phys + 4 * n), val);
> -}
> +uint32_t rtas_ld(target_ulong phys, int n);
> +uint64_t rtas_ldq(target_ulong phys, int n);
> +void rtas_st(target_ulong phys, int n, uint32_t val);
>   
>   typedef void (*spapr_rtas_fn)(PowerPCCPU *cpu, SpaprMachineState *sm,
>                                 uint32_t token,
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index cb79ad34053..0871425237e 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -52,6 +52,21 @@
>   #include "migration/blocker.h"
>   #include "helper_regs.h"
>   
> +uint32_t rtas_ld(target_ulong phys, int n)
> +{
> +    return ldl_be_phys(&address_space_memory, ppc64_phys_to_real(phys + 4 * n));
> +}
> +
> +uint64_t rtas_ldq(target_ulong phys, int n)
> +{
> +    return (uint64_t)rtas_ld(phys, n) << 32 | rtas_ld(phys, n + 1);
> +}
> +
> +void rtas_st(target_ulong phys, int n, uint32_t val)
> +{
> +    stl_be_phys(&address_space_memory, ppc64_phys_to_real(phys + 4 * n), val);
> +}
> +
>   static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                                      uint32_t token, uint32_t nargs,
>                                      target_ulong args,

