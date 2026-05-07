Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DAB2D5C7A;
	Thu,  7 May 2026 05:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778131468; cv=none; b=WZaK8vUra9bOtZH0fF6/Yw7fXa4OuozBItb2MyDGfsa3q9RzSrhFX+jpwv5DeXVMYVgVQZv6TMWBaM5dESdA7tlj2VHrFnukEj5Cl0oWg3DNrVtoCLLQvPsRBFE6FF6C6O7AHHRb1WwyJQW7g0MY8VCtfoGRLESFjJhQEd0xhos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778131468; c=relaxed/simple;
	bh=TtGByUFfgFVb/4oaOkU+3mTd5dlepSoS4j9QgvOdAcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTDkLX9/rpm/WcUtGqP9Inu8pCxjkZ8L/JVMRsqWD9rG0dVVG+pIBFyieoVG9Y5A9WMUFDzs7MW+NTMnqMbTD/bNabpI5xGGltf/jH/AEoZ9cbjW8odMmrObBq3A7B9h9ATvT7ssoaUQ2YjmtZ+mzM5SXZVdacQNnYMSsQ8FpxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YpxmtDkW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YpxmtDkW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646Mo7Dv2210426;
	Thu, 7 May 2026 05:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TucOZ0
	sBTZFdshtdPDyBxWcOC6Ft10rot4sd8h+52sg=; b=YpxmtDkWv7KWlAHeuJIO8w
	NqpcEj4tyZZhTrGjZw2q/AfoESH/i2qCJtwg8+M4fOt795pvOBn7pkivmJU4UpG0
	LPTBXI6OPE7zyaKqnmlJpuwIyiTmz7vX3XU3D1vP0DNJ3mmIxm0jrqZMFuxSv5fS
	Tqbxr3vaLJP6w78sQE4Qw9dYiN7b6+BHEzfJvc9MTHnC9huExunjQZQElwWga5LL
	58vdaZH9R6m46YwDu0TXDZLQ4dyB6UAtgHMM2kzAjcMkFgSuWHSmMbD0CNS8R+3k
	R3QV63bvccBFapddA1nmJAuUNpm5QoqP7LPFNPXWHoNqSaYLRGaE2w6ScH+KqW7w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1m9pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 05:24:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64759dwV013557;
	Thu, 7 May 2026 05:24:15 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk1jgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 05:24:15 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6475ODuj31326914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 05:24:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A646658053;
	Thu,  7 May 2026 05:24:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C02C58059;
	Thu,  7 May 2026 05:24:10 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 05:24:10 +0000 (GMT)
Message-ID: <7907d821-b2f0-4f55-9763-6d419f04d01b@linux.ibm.com>
Date: Thu, 7 May 2026 10:54:09 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Add H_FAC_UNAVAIL mapping for
 tracing exits
Content-Language: en-GB
To: Gautam Menghani <Gautam.Menghani@ibm.com>, maddy@linux.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260428084534.49781-1-Gautam.Menghani@ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260428084534.49781-1-Gautam.Menghani@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: lxxOA8XLE-8Wzx3m7j-fLuNrZphalmWy
X-Proofpoint-GUID: 4zUHY9eC3UmHz477yT1_bcYfE0X_wwCQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA0NyBTYWx0ZWRfX22owosNOeKce
 ROtBVmIOK2zgv5tfJEZyCt03DW0B6P2jT/TSB6I+Bxwz8bLzuKA5uyUgOqqDF8KVrVj3baZyaju
 9K2J4Yg08sYcCmGylqst4CI1LHaK7cbVpdpZJQ1ndSQppepeQBhEHLTTzhFuhIkrYfJ6sHDYWf5
 tjzUIWmr+4Z51HQms+JfR4M7Sk1eK7TLlJf01E3qqjp8jKFP5R8wa97/IOO/zSVmNgqh3aV8QiO
 fiJmRyJz8Tz7ou0o9PZwAw5f73ABH1jaNZ3O27c6v30rlHr2qCOcunTtWTP6BJLivhPgSj97eDz
 pPM2c+Lu8ghZgZFWuuoM7lte0bW8hlUxYTKt35L6EQAtoq4Gv8Fb2aRGquMGHzQUv01865MOuNt
 hf5S4QN+iaJIF/iHuka0MO2h1CLLsSR0Mu7rkG8qyJBkp6xGfOfmxgQdtn6M+GCzF85BY8+BQY3
 mw2AtK1CMPG1vcFGCpQ==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fc2200 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VnNF1IyMAAAA:8 a=sf-K9OUI_O-0kvPjvxEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070047



On 28/04/26 2:15 pm, Gautam Menghani wrote:
> From: Gautam Menghani <gautam@linux.ibm.com>
> 
> The macro kvm_trace_symbol_exit is used for providing the mappings
> for the trap vectors and their names. Add mapping for H_FAC_UNAVAIL so that
> trap reason is displayed as string instead of a vector number when using
> the kvm_guest_exit tracepoint.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v2:
> 1. Remove the trailing comma after last element
> 
>   arch/powerpc/kvm/trace_book3s.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/trace_book3s.h b/arch/powerpc/kvm/trace_book3s.h
> index 9260ddbd557f..5d272c115331 100644
> --- a/arch/powerpc/kvm/trace_book3s.h
> +++ b/arch/powerpc/kvm/trace_book3s.h
> @@ -28,6 +28,7 @@
>   	{0xea0, "H_VIRT"}, \
>   	{0xf00, "PERFMON"}, \
>   	{0xf20, "ALTIVEC"}, \
> -	{0xf40, "VSX"}
> +	{0xf40, "VSX"}, \
> +	{0xf80, "H_FAC_UNAVAIL"}

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>


>   
>   #endif

