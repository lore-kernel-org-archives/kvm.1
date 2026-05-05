Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D922D3B6C16;
	Tue,  5 May 2026 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777963491; cv=none; b=tdK67Pe1wqQjFf2mU4OhvjwDCimp1LqkMK5CZFKRm1KIANpO0d6sDWp7E2UE0ZHc+v2155VxR8PBFkrftcUiGosxDnXU/7oBMDxXeaG2ZDEe03/pBxP+B3nJtfFyPOc/aB/25mFRrKOHsb80HOBZSVLp0oWguwGlHpAY7RriLFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777963491; c=relaxed/simple;
	bh=DOyzyYjdrzuGT4pNBaPgsnEOvH3BTwhOsnnPqZ3KjGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alZbDX7QlCOB+Lkqpae+ADjM/TGwIdIRjc6N0okATLsA1AABvqZtla1mGGd+dokFC9lwtWrS7AXZQGc4t+WjsFb8BTfl6NWYJG4oN/ySVDYWsusUC0xiPwX5GY5mt3lCx6OuBMqwYF2+BTApxv3xX/6YuR/R5FPFNuw0fa63yF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GPftc1tR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GPftc1tR"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644JthrQ1356523;
	Tue, 5 May 2026 06:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UsdRCX
	XsnjgLFgNt6EMqjtMpVNDMxPDznWpwvLiUaQ4=; b=GPftc1tRsELDFWqzvWsmmZ
	/GdL6RGldmS+RSTaUzcFx8qRK5TWOhAedgtTwven6uglr8ZFG5PjLbRLbLJqurTb
	HzHnCI7jLYmWZiiFnLY+oeCZuKeT/UBIZC6+prnNFNtJgW/XF/KC5NnpV++0Urh5
	QHxI8ianVrP9eQbQ0k+EZGE5dxNBXWnjwCFOsbcOoQLekbYLgnG6Jw5i1Rny3M3M
	XenRwewQTE6vt8j8oV0H7w0eDDLxt+/MXKwHz6tU/Eo0AaVjF0L/7iIVLagGDSRp
	O9EBQLnbRaL+wmZwgASoavUgPdiYzBStErd70Oh6Isyk5Tg8celEwCYL46S/trPA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7aac3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 06:44:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6456dSUw001998;
	Tue, 5 May 2026 06:44:36 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtg87s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 06:44:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6456iYNT35783398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 06:44:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DA7A5805A;
	Tue,  5 May 2026 06:44:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B55D58051;
	Tue,  5 May 2026 06:44:30 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 06:44:29 +0000 (GMT)
Message-ID: <0ca0e84a-ec56-428f-ac6a-22dd52ad4a1a@linux.ibm.com>
Date: Tue, 5 May 2026 12:14:28 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
Content-Language: en-GB
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
 <20260430054906.94431-2-amachhiw@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260430054906.94431-2-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA1OSBTYWx0ZWRfXy6aiYLGfef+p
 aCesTAyGB2gYp6iuY4gPx79D89AsuxPzSA04y/mhRb1fj8q2H5HseoR9qf1HjZKxpVP+TCWpQu/
 iAezXourTgm8+OiIwVo3DWyCupC1u43XDlu1HjB5/n06HRXTi1ph+xQaIo1U3Ixqw3rGcQNcpCd
 C6KgypbkOydymIPiHY1DTAT/Ar3v8CfDaqcOJo52zyQ0FYCALVDa4DCWRl+oobMYs+0Gjse0Ynl
 29sFma5QmwtCdDuhPafub932ed7XUfk3ZKi/MD6EBDzrnzVIWRBVmDi6QRT6rHPXJ2YdLYLipW4
 qbuSxri67gc9znabyyVaLt0WLsk6lZ8qpmuINlusnXs+l6gNpOJccBADlw6mO7WEGA4L6vJ13B9
 LVtlshRZ/cgFhL2LNAuLZc8h6PX1RdnO6YG9J0j4qIFGl6bjfRCUa9vDpwH+ZQEg2Jj8OYtUCQy
 JSyR4lEToVrKrHt2ztA==
X-Proofpoint-GUID: mT_UAeRqjB9VpM9PKugoM9XjbFYTVnhX
X-Proofpoint-ORIG-GUID: tLslHPtKow73aKNrMZ39cBUoHdJQcsrz
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f991d5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=VnNF1IyMAAAA:8 a=f1vRVuFlCkgBq9oUj50A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050059



On 30/04/26 11:19 am, Amit Machhiwal wrote:
> On IBM POWER systems, newer processor generations can operate in
> compatibility modes corresponding to earlier generations. This becomes
> relevant for nested virtualization, where nested KVM guests may need to
> run with a specific processor compatibility level.
> 
> Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> logical partition (L1) booted in Power10 compatibility mode, the guest
> fails to boot while setting 'arch_compat'. This happens because the CPU
> class is derived from the hardware PVR (via mfspr()), which reflects the
> physical processor generation (Power11), rather than the effective
> compatibility mode (Power10).
> 
> As a result, userspace may request a Power11 arch_compat for the L2
> guest. However, the L1 partition, running in Power10 compatibility, has
> only negotiated support up to Power10 with the Power Hypervisor (L0).
> When H_SET_STATE is invoked with a Power11 Logical PVR, the hypervisor
> rejects the request, leading to a late guest boot failure:
> 
>    KVM-NESTEDv2: couldn't set guest wide elements
>    [..KVM reg dump..]
> 
> This situation should be detected earlier. Rejecting unsupported
> 'arch_compat' values in 'kvmppc_set_arch_compat()' avoids issuing an
> invalid H_SET_STATE hcall and provides a clearer failure mode.
> 
> Add a check to reject Power11 'arch_compat' requests when the host is
> running in Power10 compatibility mode, returning -EINVAL early instead
> of deferring the failure to the hypervisor.
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   arch/powerpc/kvm/book3s_hv.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..948c6b099a29 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -446,7 +446,13 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
>   			guest_pcr_bit = PCR_ARCH_300;
>   			break;
>   		case PVR_ARCH_31:
> +			guest_pcr_bit = PCR_ARCH_31;
> +			break;
>   		case PVR_ARCH_31_P11:
> +			if ((PVR_ARCH_31 & cur_cpu_spec->pvr_mask) ==
> +				cur_cpu_spec->pvr_value) {
> +				return -EINVAL;
> +			}

Is it possible to keep the check generic for applicable ISA versions 
(ISA 3.1 onwards?) instead of keeping it specific for P11 ?
Also need to add a comment, why it's not applicable for older ISAs.

>   			guest_pcr_bit = PCR_ARCH_31;
>   			break;
>   		default:

