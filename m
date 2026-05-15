Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3F43C048
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842390; cv=none; b=Bvg53EyCY5Lo0sfbVRyU9FaAuZddY9ePu+tTQ1SW7bE1g9OaAtDT/dT3oYlHnteOjhL7SJSlKg9glWYlPmlAe2z/6zakmPDQ87Ifm8VjE59Yj7xN17BOcPJz658Vm5WqpHcMkpy+3CQj3Vdx0Hl4XLYpVWsp+H33WkFUHe7/WXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842390; c=relaxed/simple;
	bh=quPDGzrbLYzLownX7ZLQLyGqi7RUWenlCORduXbioI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSzaeEeDVV+wn3yD7xXR0Yiaj9uTIrnisV1JmfZM0WddM3V43oxFrtuxexUx9sNSvHCPedIaaLrTvjXlINyHurB/AmHPeCddH30uzBAThniOAG9kkcnin6mz8VYGf9mtU4/6NMuwUiFTJv4EzL+WGoJ9m7oYH503ivnwyWIJDuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N71OAUuC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N71OAUuC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EJ6phQ3950769;
	Fri, 15 May 2026 10:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EpNOIa
	DSZkfUevBZzGPbc+oDJItvPlY7qzfxOj12tBU=; b=N71OAUuCeOj4WEPZNOFHpu
	m3CfAcdJKf2apaIq54aGRsm7AjWsOME9X6FoYWU+QPDtBYfx264ggJcyXm5wlNp4
	wEDUFnJrrxDgobA2CGroexZyQ7DIFY0D9zfSctLu7QOAo+Ju4lpH2vbr41oztXQx
	nB1cSjQSMmzaNA79MIinWF5tK6IPgGiyuuAIptIOwbQzI4tpL1PFSFS/qLdg/fHm
	9uBLPuwF8yZQMmjNI4pBbmNOq1wcIj6usqRANsyGdxPaB6D/a29XU9puFjqNt9L0
	jP44jcHVLebN5o7Pmj5ghCOJuoUs7GC3r4cCbfwJBZRMKe1ivz0+CwImeqCSGOmg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m8yau6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 10:53:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64FAd4IM014408;
	Fri, 15 May 2026 10:53:02 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5m3ak2sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 10:53:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64FAr14J64618778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 10:53:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CAC558055;
	Fri, 15 May 2026 10:53:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9993E58063;
	Fri, 15 May 2026 10:52:57 +0000 (GMT)
Received: from [9.61.251.54] (unknown [9.61.251.54])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 May 2026 10:52:57 +0000 (GMT)
Message-ID: <ace856fe-bd1e-46b1-b587-6cae408efd5e@linux.ibm.com>
Date: Fri, 15 May 2026 16:22:56 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] ppc/kvm: Handle CPU compatibility mode correctly
 for nested guests
To: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
        kvm@vger.kernel.org, anushree.mathur@linux.ibm.com
References: <20260502140021.69712-1-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260502140021.69712-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: suvxzwxmtVpdEgUC1H4eEFLCx2eYlHql
X-Authority-Analysis: v=2.4 cv=Os5/DS/t c=1 sm=1 tr=0 ts=6a06fb0f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=UQ17OVVmNpHQdldK9y0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AuwB3Fjyd_FDd8AxZh2qiwbggz8C0nzW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEwNyBTYWx0ZWRfXxjHNUNNiNp0a
 g5X8D3JFLGgWlQDXGNl76k2XtZw3i50GmpbE9wMG2gI1N4CNF6Q8nGxNVZpVPvunH0NeJt75wIo
 1puMvnODMdzSeAj/doHldlM5EwQhxEz8S9OjiDCctM2YAUBoOwnpkbfAQtDORNsnkeAWRqtz7WE
 grDZ7lHXrZP9USp46o6Q4/r6VipIUIXR5CBz2I+TFVcLBjuu0oqWXITmNMyir0t9vTNhAWy6P3+
 nIKQ0/iaDkcuuclva9hPt27Taf1wglyQob9AO3DdfPclz1/tXR290lbAitnPUXEoO7sal7RE0Z3
 nfb7OYfe4v9MIeo71mUH3gErQRyj2+ny6zlJ56XWW6/SFixaYOFLG/1jgZW0YoQBZhJB6rEJc++
 JTCqadv/sy3zjDff+wwkXApCy+m1llYb3CGEw+2TReeE1nndPA1Xygr/4b+Xr6eKAdmjtYYcMm1
 7oUUnHZx+I96FQYnTIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150107



On 02/05/26 7:30 PM, Amit Machhiwal wrote:
> On POWER systems, newer processor generations can operate in compatibility
> modes corresponding to earlier generations (e.g., a Power11 system running
> in Power10 compatibility mode). In such cases, the effective CPU level
> exposed to guests differs from the physical processor generation.
>
> This creates issues for nested virtualization. When booting a nested KVM
> guest, QEMU may derive the CPU model from the raw hardware PVR and attempt
> to configure the guest accordingly. However, the host is constrained by the
> compatibility level negotiated with the hypervisor, and requests exceeding
> that level are rejected by KVM, leading to guest boot failures such as:
>
>    KVM-NESTEDv2: couldn't set guest wide elements
>
> This series addresses the issue in two ways:
>
> 1. Do not silently fall back to raw mode when KVM rejects a requested
>     compatibility level during CAS. Instead, propagate the error so invalid
>     configurations are visible and fail early.
>
> 2. Query the effective CPU compatibility modes supported by the host via
>     KVM and use this information to select an appropriate CPU model for
>     nested guests.
>
> With these changes, QEMU avoids masking KVM errors and ensures that nested
> guests are configured with CPU models consistent with the host
> compatibility mode, allowing them to boot correctly.
>
> Patch summary:
>    [1/3] hw/ppc/spapr: Do not fallback to raw mode when KVM rejects compat
>    [2/3] [DO_NOT_MERGE] linux-headers: Add uapi header changes
>    [3/3] target/ppc/kvm: Use host compatibility mode for nested guests
>
> Changes in v2:
> - Patch 3: Guard compatibility mode code with #if defined(TARGET_PPC64)
>    to fix compilation for ppc32 targets. The POWER9/10/11 PVR constants
>    are only defined for 64-bit builds, and compatibility modes are only
>    relevant for 64-bit systems.
>
> Tested on:
>    - Power11 pSeries LPAR in Power10 compatibility mode
>    - Power10 PowerNV and QEMU PowerNV 11 TCG L0 host
>
> CI test results: https://gitlab.com/amachhiw/qemu/-/pipelines/2494987253
>
> Note: Patch 2 is marked DO_NOT_MERGE as it contains linux-headers updates
> that will be synced separately once the corresponding kernel patches are
> merged.
>
> The corresponding Linux patches have been posted [1]
>
> [1] https://lore.kernel.org/all/20260430054906.94431-1-amachhiw@linux.ibm.com/
>
> Amit Machhiwal (3):
>    hw/ppc/spapr: Do not fallback to raw mode when KVM rejects compat
>    [DO_NOT_MERGE] linux-headers: Add uapi header changes
>    target/ppc/kvm: Use host compatibility mode for nested guests
>
>   hw/ppc/spapr_hcall.c            |  9 ++++++
>   linux-headers/asm-powerpc/kvm.h |  7 ++++
>   linux-headers/linux/kvm.h       |  3 ++
>   target/ppc/kvm.c                | 57 +++++++++++++++++++++++++++++++++
>   4 files changed, 76 insertions(+)
>
>
> base-commit: 3d626609ccae61a2e552bccd59c7a0931bab8261



Hi Amit,
I tried booting up a guest on P11 lpar booted with P10 compat mode 
applying your patch along with the linux patch series and it has been 
working perfectly fine.

Host lscpu:

lscpu
Architecture:                ppc64le
   Byte Order:                Little Endian
CPU(s):                      80
   On-line CPU(s) list:       0-79
Model name:                  POWER10 (architected), altivec supported


Guest lscpu:

lscpu
Architecture:                ppc64le
   Byte Order:                Little Endian
CPU(s):                      10
   On-line CPU(s) list:       0-9
Model name:                  POWER10 (architected), altivec supported

Feel free to add :

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>

Thank you!
Anushree Mathur

