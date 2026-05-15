Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93DD466B6A;
	Fri, 15 May 2026 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842259; cv=none; b=RYngDyL/MjXQ3iOC4vfxk0V9eKBa0cM0UzI2unGRekzX4lHRyMWegFz7XTBTTMWMnhGCT1emGed/5k9jb8iv8vZwapvgKwf1i5gkMyWjS3PLGFZz8trkbfbc5kFerpgiJ8icg+7bLbcZ/rws99vfom23hal9aXMfdiNT5UtrIM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842259; c=relaxed/simple;
	bh=NtvMesUxqlNNHZ8ndYoXtuMTs0d9BDGEuYmP97a5uW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPjpRm4rSrdqLRPtdeYUDNY3u4iTZhD6gbaLrrgKj/bKUVs7DdBjbxg63KoEG2dXfFKMaEY1DTaU4ls7UtLD8I/4Y+VUdvhQXD0LX2uNNl4RMpQWQwCwZNyCSxn8tcvkD5qgO2xNmxRrtVJfice/z9YZyz7N9Ao7kuLHbYbfF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BeJQJ+yM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BeJQJ+yM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FAieuT3950738;
	Fri, 15 May 2026 10:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fogqdz
	UuIj5eY+AIUvnt4DvIbdEheTIUjQ0nCw8l21U=; b=BeJQJ+yMe66CTP7Xtaa5qe
	rdTrcicRvCkYAuLlnwz6kPU4OJl9be4uJxCSi4UwsrOGXUsUKsxRYnPbW++br8Po
	0utajN274QBaiH5YPNWy8iGze7Q6H4uUeDKgwSrT/oRgT8EUep2xgzfpl+AWMv/U
	efyikx2NU8suK2R9HdRlWi28f98TXnOxwYAokYoR9kiNuq0pZAcj1FENCsC6LzLo
	ZInEcw00OMsKiCiDnHB98WnM9v4H2AwMjIFt1l5+W29J5JtugPxa0B9LAQ+DxtUC
	I0qkcgBBUgWbAXfrZ3UiiYRbG72xsiwtxGXAGSRlW4L9vx4U8Kbzhj/ZmVXWcKiA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m8yau06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 10:50:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64FAd7Hk030252;
	Fri, 15 May 2026 10:50:30 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5kvck4r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 10:50:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64FAoTRb23331328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 10:50:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44F8E58063;
	Fri, 15 May 2026 10:50:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A3B458065;
	Fri, 15 May 2026 10:50:25 +0000 (GMT)
Received: from [9.61.251.54] (unknown [9.61.251.54])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 May 2026 10:50:24 +0000 (GMT)
Message-ID: <105cc1ee-d0a9-4d6e-9faa-4f91ef2c519e@linux.ibm.com>
Date: Fri, 15 May 2026 16:20:23 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] KVM: PPC: Handle CPU compatibility mode for nested
 guests
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        anushree.mathur@linux.ibm.com
References: <20260513100755.83215-1-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260513100755.83215-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: HQCrUiHB_zaICgpUBS1Fdg6AB4tFz0xk
X-Authority-Analysis: v=2.4 cv=Os5/DS/t c=1 sm=1 tr=0 ts=6a06fa78 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=q7P96uELB6eWBjni9OYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kUehQ2Yelhc546v-_PeubJuHf9A4tRgp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEwNyBTYWx0ZWRfX5jsdZ5LBzpxT
 /F3YnSEqya5TvqMdjw0nzNCSPkwTBGIzJjdNZczOy6AOgG1Js+u/OAkpGxFs6vcOeIL3/Gcc5RK
 mfTtZnjRRaioRo5ez++LLJ+dYkgZVkbzM1HrghEPmWHkK1UmmyEu3xF4TEfzYGPBox7TOIK5HFm
 0nhR9IhD2sEu/eMbx4SAyFfMr3+6kGA8asrMBGhun7Zo6e3sbmfmGFWq46tTbROT4orPlQGUBGt
 XF/Qi9JIZhhXTPpsNCjFxtkknJ8VtanOIGL0hRQ12UgzKzU/ciD16PIcnr+cLrhVhOCrfNF24qA
 sYglwvAQ+cQVZLnEcL8bbJWA7rrODb99DuvtMeIO2MvEh/f0NDVJ4MJHtsL0uLSLHtJ+NRIanwK
 8WeyQFzksSl+rbQMGd4792fWsoVhd2Ct4yjCMDUJKUedDhcZQ1Bn4Uz/GQYr7aPYLYS1bwzaBa2
 oYMYflaSW055uo5gK/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150107



On 13/05/26 3:37 PM, Amit Machhiwal wrote:
> On POWER systems, newer processor generations can operate in compatibility
> modes corresponding to earlier generations (e.g., a Power11 system running
> in Power10 compatibility mode). In such cases, the effective CPU level
> exposed to guests differs from the physical processor generation.
>
> This creates a problem for nested virtualization. When booting a nested KVM
> guest (L2) inside a host KVM guest (L1) running in a compatibility mode,
> userspace (e.g., QEMU) may derive the CPU model from the raw hardware PVR
> and attempt to configure the nested guest accordingly. However, the L1
> partition is constrained by the compatibility level negotiated with the
> hypervisor (L0), and requests exceeding that level are rejected, leading to
> guest boot failures such as:
>
>    KVM-NESTEDv2: couldn't set guest wide elements
>
> This series addresses the issue in two steps:
>
> 1. Detect and reject invalid compatibility requests early in KVM to avoid
>     late failures.
>
> 2. Provide a mechanism for userspace to query the effective CPU
>     compatibility modes supported by the host, so it can select an
>     appropriate CPU model for nested guests.
>
> To achieve this, the series introduces a new KVM capability and ioctl
> (KVM_CAP_PPC_COMPAT_CAPS / KVM_PPC_GET_COMPAT_CAPS) that expose the
> compatibility modes supported by the host.
>
> The implementation supports both:
>
>    - PowerVM (nested API v2), where compatibility information is obtained
>      via the H_GUEST_GET_CAPABILITIES hypercall.
>    - PowerNV (nested API v1), where compatibility is derived from the device
>      tree ("cpu-version") representing the effective processor compatibility
>      level.
>
> This allows userspace (e.g., QEMU) to select a CPU model consistent with
> the host compatibility mode, avoiding mismatches and enabling successful
> nested guest boot.
>
> Changes in v2:
>    - Squashed patches 2 and 3 from v1 (capability introduction and ioctl
>      wiring) into a single patch for better logical grouping
>    - Changed kvm_ppc_compat_caps.flags from __u32 to __u64 for consistency
>      and future extensibility
>    - Addressed other review comments
>    - Improved commit messages with clearer explanations of the changes
>
> Patch summary:
>    [1/5] Validate arch_compat against host compatibility mode
>    [2/5] Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
>    [3/5] Implement capability retrieval for PowerVM (API v2)
>    [4/5] Add PowerNV support (API v1)
>    [5/5] Document the new ioctl
>
> Tested on:
>    - Power11 pSeries LPAR in Power10 compatibility mode (nested API v2)
>    - Power10 PowerNV system (and QEMU TCG PowerNV 11) with nested
>      virtualization (API v1) with various combinations of KVM L1/L2 guests
>      in various supported compatibility modes.
>
> With this series, nested guests boot successfully in configurations where
> they previously failed due to compatibility mismatches.
>
> Related QEMU series:
>    A corresponding QEMU series adds support for querying and using these
>    compatibility capabilities when configuring nested KVM guests:
>    https://lore.kernel.org/all/20260502140021.69712-1-amachhiw@linux.ibm.com/
>
> v1: https://lore.kernel.org/linuxppc-dev/20260430054906.94431-1-amachhiw@linux.ibm.com/
>
> Amit Machhiwal (5):
>    KVM: PPC: Book3S HV: Validate arch_compat against host compatibility
>      mode
>    KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
>    KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM
>      on PowerVM
>    KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM
>      on PowerNV
>    KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
>
>   Documentation/virt/kvm/api.rst      | 35 ++++++++++++++++
>   arch/powerpc/include/asm/kvm_ppc.h  |  1 +
>   arch/powerpc/include/uapi/asm/kvm.h |  6 +++
>   arch/powerpc/kvm/book3s_hv.c        | 63 +++++++++++++++++++++++++++++
>   arch/powerpc/kvm/powerpc.c          | 21 ++++++++++
>   include/uapi/linux/kvm.h            |  4 ++
>   6 files changed, 130 insertions(+)
>
>
> base-commit: 1d5dcaa3bd65f2e8c9baa14a393d3a2dc5db7524

Hi Amit,
I tried booting up a guest on P11 lpar booted with P10 compat mode 
applying your patch along with the qemu patch series and it has been 
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
