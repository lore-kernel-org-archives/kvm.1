Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1674B38237F
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667616; cv=none; b=u8kBl3awXDEwxvTR1lyecJCUiBo0VJL7dPz04DGtNqE4PIT3HPGGMP8EEL9hrj44mMIY1fJN4uuxYKGpRKRfpBECdbNeqKDnmYxRqKzGNo3DtUrNLdqSW93bCf/HCLodit+itglzv8AHi3gk0PplFwwKsRSG6uKB8YcaarCz5kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667616; c=relaxed/simple;
	bh=jyyxwyna3GLsL82b3CXNtnCcfT0805H9kGYsmaO8p/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUtl7W4BSQd8Q0DzYeY3Fn8B4IirXkgNYTo0r7T3YQDebJDLKaBdVo7WE2e1r6/VknTb++c2dIxTKNcmRIQI9HsJPdbDF+/5VYWpyQFlErZTRjbHBsRYoRO5ubecG70YacV2tfnnSP32gzSfqwMZonUNU/VLKIIpPSTxS80xmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qN7fE3YR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qN7fE3YR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JMxEb13987518;
	Mon, 20 Apr 2026 06:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wx3Ub5
	lvRpcKiudQnvj9T2ITXyP0gYhnoOcJpHR3rwA=; b=qN7fE3YRkZl+CZewlVmmj7
	/GWZSD2Q6mOY4YWWio59QT+gQtyK2zHI9a35H4P/WItgP9Ngz9bHoIPOcDEGlqGe
	K2sP0rrbmjn4OUjUcUpZ/48C3dEEXD8VkOX4fvf4BtlnundfuIbqu2xFYcSpRmRK
	G/+RNlqgUCvdac/udKL2nE8Pa/+GU8dnHPdsv3a+Wt/oNlAp8gWEqSf4zPDISa8f
	xflIgtfq7966bRIpw4TAB3TP6w0VqfhAr7S4lFbeTQzdonJDdEZbBApqEB5CshYS
	7kSmP9NEIXMSgoAkhILyQU8YZmm84W6Y2n4/mn7lhXBVmnFfHfZqQcDi7ZS/N1Vg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k0nvdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 06:46:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63K6ZOR3020695;
	Mon, 20 Apr 2026 06:46:38 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpgg3j1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 06:46:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63K6kbBJ29688402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 06:46:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4125B58054;
	Mon, 20 Apr 2026 06:46:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B425758050;
	Mon, 20 Apr 2026 06:46:33 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 06:46:33 +0000 (GMT)
Message-ID: <09352eea-3794-42c2-becc-b5c7dbd37732@linux.ibm.com>
Date: Mon, 20 Apr 2026 12:16:32 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] target/ppc: Factor common ppc_load_epr() helper out
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
 <20260319111936.68041-3-philmd@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260319111936.68041-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: D0aTPj8iCrIVmuZCumGDaI9z7ny-fqPR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA1OSBTYWx0ZWRfX/xYVP93Nl13O
 VxcqJrpGJ/eRQGa1zrSmNojt0DwdAnJt3k1WRNTyqulBkAFdJukguvXFWk6tybqlUt831fOgg1Z
 hMK4ykWZtLsbOsfWbUmHDPQlFSjzqdwxQ40yD52sJEmMwkqdVB1deH26JuOg8VJrNHQmLMOrGtx
 dtX/dURwuz/i1RbZ58R/smVC4wJvpwEU/btfTBQHo++LtL8Cx3UN7pcR0NL0mqvAts9PPWaxjJb
 c1iIhrqUZUqUUIziJ4ptU8xm/N73HEJGemYAgDz9/7lATCVJSmWHvLD/TLNMPMjxIQkY8oSFU6Q
 Epoi06ouGv90rPir1+QYfws2sdBvXls0ClwsghHnaG+I3qxIRBGO3keI/Di9Lq5jBYELR2NZP5l
 Ww3oUBAogjtdkEaS1yst3w0H8w0HPoeX0LqBV2uSpd129aedYG0pK7ZxsnQ1oIJhLnqOpIQAIDm
 Oj1baEg7PPRzJieEfYA==
X-Authority-Analysis: v=2.4 cv=PtujqQM3 c=1 sm=1 tr=0 ts=69e5cbcf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=LBd1l7Yb-2XZM44x8U0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: sBzfiEJnuLe6gGEQbkRdi8wRpRlLWOeA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200059



On 19/03/26 4:49 pm, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/cpu.h         | 2 ++
>   target/ppc/cpu.c         | 8 ++++++++
>   target/ppc/excp_helper.c | 3 +--
>   target/ppc/kvm.c         | 2 +-
>   4 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index d637a50798f..e3e4bce91b7 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2822,6 +2822,8 @@ enum {
>   target_ulong cpu_read_xer(const CPUPPCState *env);
>   void cpu_write_xer(CPUPPCState *env, target_ulong xer);
>   
> +uint64_t ppc_load_epr(CPUPPCState *env);
> +

This declaration is added unconditionally, although its implementation 
in target/ppc/cpu.c is placed inside #if !defined(CONFIG_USER_ONLY).
Should we guard the declaration also?

Otherwise, LTGM.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>   /*
>    * All 64-bit server processors compliant with arch 2.x, ie. 970 and newer,
>    * have PPC_SEGMENT_64B.
> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
> index 4d8faaddee2..f24801a9731 100644
> --- a/target/ppc/cpu.c
> +++ b/target/ppc/cpu.c
> @@ -26,6 +26,7 @@
>   #include "fpu/softfloat-helpers.h"
>   #include "mmu-hash64.h"
>   #include "helper_regs.h"
> +#include "system/memory.h"
>   #include "system/tcg.h"
>   
>   target_ulong cpu_read_xer(const CPUPPCState *env)
> @@ -105,6 +106,13 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
>       ppc_maybe_interrupt(env);
>   }
>   
> +uint64_t ppc_load_epr(CPUPPCState *env)
> +{
> +    CPUState *cs = env_cpu(env);
> +
> +    return ldl_phys(cs->as, env->mpic_iack);
> +}
> +
>   #if defined(TARGET_PPC64)
>   void ppc_update_ciabr(CPUPPCState *env)
>   {
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 6d05b865058..3b476c145ab 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1166,9 +1166,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
>           break;
>       case POWERPC_EXCP_EXTERNAL:  /* External input                           */
>           if (env->mpic_proxy) {
> -            CPUState *cs = env_cpu(env);
>               /* IACK the IRQ on delivery */
> -            env->spr[SPR_BOOKE_EPR] = ldl_phys(cs->as, env->mpic_iack);
> +            env->spr[SPR_BOOKE_EPR] = ppc_load_epr(env);
>           }
>           break;
>       case POWERPC_EXCP_ALIGN:     /* Alignment exception                      */
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 41bd03ec2a2..3bff75b7f54 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1692,7 +1692,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>   #endif
>       case KVM_EXIT_EPR:
>           trace_kvm_handle_epr();
> -        run->epr.epr = ldl_phys(cs->as, env->mpic_iack);
> +        run->epr.epr = ppc_load_epr(env);
>           ret = 0;
>           break;
>       case KVM_EXIT_WATCHDOG:

