Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D7382F09
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667887; cv=none; b=C+3167QiyXIeO4v7/oXMJh4iNXwXww++5EJM+gUnrHoQqdKxet8+2VQYJY00I3vBWl2m0m27uWPJhgUSqRqOWmsLvghGApNqmpCwMJH5fGqAmqlY9ChCS6RReb/37NXTPIzmXMrmhXHlOLja71rAAdtYBsGnlkirn5Bj6Z6uQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667887; c=relaxed/simple;
	bh=llwJjiCgBxJd+cucr/3f/aUEVTh3dPKVoAMzUJ2VBsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNKsiSdZcgVJRLivh7DlOp6Rw6kfOguWtTG5dYu/5BiEW9IwvS9mu6UXTN1Sw9+c+DXKuWqo5iRQdBqZ2eo9FAin9TOypXFSouzqNDeqNnq6DE38+WjEpETlMtuFZ/FTYQArNMNtRjxxxuueXFijQBEPo28Hv93jb4JMW2AcSos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rd0/EMC2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rd0/EMC2"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JEKAef3005237;
	Mon, 20 Apr 2026 06:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yrwrRl
	oUQvxdy73dK469srdsEkz4ekTcA54T0Bl00no=; b=rd0/EMC2TiRpiUeX9YNagB
	fmXSWnSYuonrkrLZR5mNao4u+9IxEvoC3WdubZuKuICAv4yX95V7UAykaNpabNGJ
	Fsfa+5JnzXNkvq8Hqrhy/wAgMprGmwL6FEH7XXjHCmi1jXVNAc9VumYGs0MgtzgE
	NY66snjsAOo5FkF7fsQW1WAwheBEnNT0ae0wlkIScorFx4OkesluL7/M57EhygHh
	C22WSm3uMLB2jt6PirdQdnalNjxU65bLMX0WgYTmu8kMwu2cIyO/2bSuRLWRWvut
	d7L3Qd8a85CCOTQ3yb5ocOeBoZ7gS7+q1UhfVPGM6WEKgQQAfuZJVXEMpgoOHYCA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k0nvwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 06:51:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63K6oIvj002807;
	Mon, 20 Apr 2026 06:51:11 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmn9jupua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 06:51:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63K6pADG33096368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 06:51:10 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6075D58056;
	Mon, 20 Apr 2026 06:51:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9B2E58054;
	Mon, 20 Apr 2026 06:51:06 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 06:51:06 +0000 (GMT)
Message-ID: <c2ec1441-3642-400f-89d9-4911d38ef32a@linux.ibm.com>
Date: Mon, 20 Apr 2026 12:21:05 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] target/ppc/mmu: Remove unused hash32_store_hpte()
 helpers
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
 <20260319111936.68041-4-philmd@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260319111936.68041-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: O7eADQSpcVBhQZ0Mpr1hrJFW6ZI_ej39
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA2NCBTYWx0ZWRfXxlEZBZsTycQz
 bQgPOg3NsWx5kYKz8zaStjKKwsNIysHGQK7r69GgM5kyPHkvkxSaqvusSe7THq75cTbof2ed1/O
 qSn9QUAOHYsPsxrvR3XjVRCtWxyFmwtRiLdi9+1QgmVS0ZQS7Isu+iMFaWHxkP/mfHhLnjbXKu5
 5t5dJv5UaCESjEpmP9eQBjSAKMKbQenxD+swrdJlNtuyAl5jsVl1dvuzM2dD//spcKwUYNGXNhT
 mZHqRy6Bqo2MA5ix3BW15vNdqIfzjwtK27MhOYUE7LbvX7xcLYWLPLfelCAJphQ2o/WLJJkVMDa
 uRJbug9zG/eSkBdXMDx0nFfSW3aafeYlfkwCilXo2WmxwfnB86++gkwWqMJtKDhV+bN45QAe2Ia
 EByZuOlS79Vq6oAl8Z4/JpLChHOjkw3sFi2Wx7/lCExldpLlYecI7iZFRxYTKIAylbr8FlbcPCW
 KPRXcK77PYUYp1599hg==
X-Authority-Analysis: v=2.4 cv=PtujqQM3 c=1 sm=1 tr=0 ts=69e5cce0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=atRULg6ZfARtJvCPKT4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: lO-_8kodI4H4_i4SjL66g7Sm6EZAIRKr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200064



On 19/03/26 4:49 pm, Philippe Mathieu-Daudé wrote:
> The hash32_store_hpte() helpers are unused since commit
> 6e8a65abbbd ("ppc/hash32: Rework R and C bit updates"),
> 7 years ago. Remove them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   target/ppc/mmu-hash32.h | 16 ----------------
>   1 file changed, 16 deletions(-)
> 
> diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
> index 04c23ea75ed..5705f57935b 100644
> --- a/target/ppc/mmu-hash32.h
> +++ b/target/ppc/mmu-hash32.h
> @@ -87,22 +87,6 @@ static inline target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu,
>       return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
>   }
>   
> -static inline void ppc_hash32_store_hpte0(PowerPCCPU *cpu,
> -                                          hwaddr pte_offset, target_ulong pte0)
> -{
> -    target_ulong base = ppc_hash32_hpt_base(cpu);
> -
> -    stl_phys(CPU(cpu)->as, base + pte_offset, pte0);
> -}
> -
> -static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
> -                                          hwaddr pte_offset, target_ulong pte1)
> -{
> -    target_ulong base = ppc_hash32_hpt_base(cpu);
> -
> -    stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte1);
> -}
> -
>   static inline hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
>   {
>       return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(cpu);

