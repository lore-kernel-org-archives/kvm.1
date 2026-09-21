Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E808E3559C9;
	Mon, 21 Sep 2026 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981801; cv=none; b=edEAfWh957TOg4JGCMLwCMFEGDKF20SRX+/A0wnYTFUY8XNBQYmd1vTkn2OsMVCRdWKbE2+yR9RxwkD2Y14mya71xQZ+fiUJ0Zaw/JNtPJDbW2yt6GiEyKj4b4jlUBh87OSWMuWkwckLM8R7Uez0PEwbcv1x7zXsUD0wgL0MR54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981801; c=relaxed/simple;
	bh=n3Mo9TeIFsgwHNEP+kJC2LgC9Uyase1+EIg+A84StfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOVN1A9EaYKlNLBbwmn+9NtapOjzvand3Uo1CFTQAs5UCY7oaiGWtWwCaWgjZEFH+9ITrr1UNh84XmryeYY8VyP92CYuE2dzH+7a6B8e5vOr53xzl4ObGgKpDXu9IXLGBr50XZKBZAWYtN6v9dwDN/DtHB1ZqEqiTbgVWPe9DIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lDpJ5m46; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lDpJ5m46"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZZmB3856783;
	Mon, 21 Sep 2026 09:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4ZIsYW
	UVn7guBQOBOTbKiEq7QO0teNhYsfMnJtt9g80=; b=lDpJ5m46AV/NUrV8otXfLy
	IVe0gEViJQF82mSfydssR1fcRXPZTkh0V2d5sqRX4gBqRArkYXDxuQr62Hc9FYp1
	qa0bGiuIxmHxFaOpl2u1sa5m8vGcCM1QPpx/TsWYxNZz/U/ovsM1uwkRu82XDSRf
	LqK9kW6SzxXLieTnRhvn1h+iSJdR0BulWIdIAEWef7L+wzadaB6ytts2cFnW6exc
	c0msvcZmr8UCLLwcQxfLNRgGnJFL9BKqPXIa5ZbyyEhuwC0TEMvH8OpK34uP0FK2
	cpB/yjlrtYP2xDOz1NqhzfP47Tip4FZHA0J25jAJU3n5vugeLX893alrC7SR2Xfg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgq7fv6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:09:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HUsR924413;
	Mon, 21 Sep 2026 09:09:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq4r54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:09:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L99c6329426126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 09:09:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8709520040;
	Mon, 21 Sep 2026 09:09:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E07382004B;
	Mon, 21 Sep 2026 09:09:35 +0000 (GMT)
Received: from [9.124.208.199] (unknown [9.124.208.199])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 09:09:35 +0000 (GMT)
Message-ID: <aed4e6a7-1678-4e27-9091-d621d3fe1535@linux.ibm.com>
Date: Mon, 21 Sep 2026 14:39:34 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: PPC: use assign_bit() where applicable
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <20260920022618.3145649-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260920022618.3145649-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab0f455 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=8AirrxEcAAAA:8
 a=VnNF1IyMAAAA:8 a=Nid3tJT5lt5-er1BLS4A:9 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzMCBTYWx0ZWRfXw9Z+eF+SZmPD
 +Qoaa60PKvIkNklTODfHdllh5WfKewFYmCLfylfWncUtePFdB8b5akdHv5pu/cE3/K2QipcdMNL
 C2B9s8FXFlb4T1zFZYXX/zsxUJ91OJFk7CeEOJ1S1kc0uTVJUBrjgw52vLhjTD9AX4kCfBnc1S2
 6PO86dtSWTu2IZsrj25XHK43cynoVKt81mbBjlGSzgohCo44bY1mPI9v7dFDRRzHU9lTkLxm2+p
 Us4NSJyfKodPMJHDe7yXtNZdBeEFWvM9uW14bZh/O1EgTe9csU+dUGwdF2Dhsv+3qXNK/iM/H/P
 x+vXk12Fnpii0cUwfSqfhOz8y6DLvzzYAJ+4m6NKC/YTw6OCohxi5ftQaQkmpqAsJQQDGhA2Y8R
 tlbwRgRXhZ9ahAN+bPbJWWvMywAVhjcbkQoJYKM5WNJWtVIIjvzicV+BDBIUSJMkpTu7rdLx2ZT
 932rfYPYwLkfDLzb/Tw==
X-Proofpoint-ORIG-GUID: 26wd-gAuxDGHB4yJx885WrLhHeVZ4hEv
X-Proofpoint-GUID: vVT54iSS5N2yMyLnpAkFyrMWLjO-j_IU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzMCBTYWx0ZWRfX0NbGaXikVMbw
 yfvcadrd2EEx9jtjqCqWhhbKD0FPcPn0T/iAJr16KfRCrwWxZmNj/pWBFlrTg7K8vy6255Idkb3
 KNkBDKLC85yvaQVePk91/dG30rZIjjI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210130

Hi Peng.

On 9/20/26 7:56 AM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.
> 

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   arch/powerpc/kvm/powerpc.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 9194cf492d1c..a567b63a5f1f 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -2210,10 +2210,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>   			break;
>   		if (!kvmppc_book3s_hcall_implemented(kvm, hcall))
>   			break;
> -		if (cap->args[1])
> -			set_bit(hcall / 4, kvm->arch.enabled_hcalls);
> -		else
> -			clear_bit(hcall / 4, kvm->arch.enabled_hcalls);
> +		assign_bit(hcall / 4, kvm->arch.enabled_hcalls, cap->args[1]);
>   		r = 0;
>   		break;
>   	}


Just ensure you have covered all such possible open coding where applicable
in arch/powerpc/.
