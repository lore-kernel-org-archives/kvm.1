Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1390332ED3;
	Tue,  5 May 2026 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974972; cv=none; b=cDccRmTdhbQXsXKivySz0aC1vTMcFK8uioMd6sjZianhaUaZTQ5fp410VWGYo5G5jpAVEyDoRXMZx9ywiqHIYbzSCtQt1CaI+tuh49d13fdOL7nPKvtPGJntWVoT6DAKtNNIbZDadaRb3CcZOSQ43WLIUoX8zpBrndpDhUfFWCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974972; c=relaxed/simple;
	bh=Tnnc0uhz9Mu7PS1tGmgLDU7SYzMrL/iGu/Unqwhg6d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9R3k6K5s3RbGJY2XK4baECDYiVYUcbrdBB9OEblE1Hef0OwZV5qhLPUAUgZpMXA1fJtq2IAJXImw/FQ48M191mmvwCEJKC7ykbOwd7QGeupysI1noAfvj5p8r9T3P4NEBj0A9p+bMd/XPmb9vCU+N6ej+I7O19Rgk6EwVU2ayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fw4U0QrK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fw4U0QrK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644Kf6251494000;
	Tue, 5 May 2026 09:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fZg9BM
	P/RrkZZqiY4BkngS0ZULmxW98T0pWoSxe+/es=; b=Fw4U0QrKuYkB8wb7wezg/z
	oAN/p7X0qX+ZQ16yfc9O646xlBmjiuWQh5iJTQ71kv0hEjEb2GWU3NobBqdz4V6f
	NqUeMp2tyLrTM8Qce6bTzMT0VOsA1e/QLBXFptm4JjBXbEQufYwp7HZy1vuqrPTN
	GUMLd6904Wub3TptouAIGu4uRR0Kf5Lsw9tblZMigaHEae9vZY5umzQ1esg0b0BK
	CVJSo2MH1YDSxEOfybrxHA+7/llud9/KWArNpVE2eEL36rZlnhnxI49y6qulpAAH
	I4ds8wYMuha9JmKz5Ovz1Reh9L5z0t+GcQLzMKL8T47nhJ9rrkqz4L/LAmDjwThQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6aq4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 09:56:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6459sabA020043;
	Tue, 5 May 2026 09:56:01 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkjs0ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 09:56:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6459u0t923397018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 09:56:00 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29EF758067;
	Tue,  5 May 2026 09:56:00 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A19D58052;
	Tue,  5 May 2026 09:55:57 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 09:55:56 +0000 (GMT)
Message-ID: <81b9d00f-7568-4bcd-9b77-2f6de3162d65@linux.ibm.com>
Date: Tue, 5 May 2026 15:25:55 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Content-Language: en-GB
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
 <20260430054906.94431-7-amachhiw@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260430054906.94431-7-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f9beb2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VnNF1IyMAAAA:8 a=im9YsioV1Km6TWkjvh8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: j3A9_HHPdO1RHNoHCRpb_PK_rvzdIqyZ
X-Proofpoint-GUID: j3A9_HHPdO1RHNoHCRpb_PK_rvzdIqyZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA4OSBTYWx0ZWRfXwQxVQFGSk6RM
 KzX41sm6wp0PRaRd4yriVFc98N5Bw0cfDAkOuyKjAKGj5M7l6X5zrSM1poPVLKC+yGQM+Tm7/Zz
 0n4Sf95KHkvAUsIuMV3T9rPyhEme6rdBCkIp8iTe421yJcFLkJn9fAlYP7EEQQE6C9i1tZWOR17
 whuGvIJdG1YlHZPye3hpe5r0US6vmBjDTY5zeChxJ0PB5enBluvgNDRDZ5uYCYOT4f02kUK4QJx
 Rvfn+2k/gyo165XR725AeYfze0HOj3LQft+chqgXDRmoe32NOCNSwAtAfaxC1csGjRZT6tVwbzY
 HAW1DtO5uHsThtGZVsevd9E1oROng2IXxjTbXyLOmTvPzBtdcY28iFDiUar/ZPNyXo4rSY8cSE7
 31QxokltC2HOSk5eujABOGbJ/4TmsBW+pkjgLi0GCkFhmW2EodYuDiIrOkxVzml8tANgJPhK7OK
 CB6k/G5O2L9BVUMOASg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050089



On 30/04/26 11:19 am, Amit Machhiwal wrote:
> Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
> documentation.
> 
> The ioctl exposes host processor compatibility modes supported for
> nested KVM guests on PowerPC systems.
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   Documentation/virt/kvm/api.rst | 35 ++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 52bbbb553ce1..7a10c3c6cbf1 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6555,6 +6555,41 @@ KVM_S390_KEYOP_SSKE
>   
>   .. _kvm_run:
>   
> +4.145 KVM_PPC_GET_COMPAT_CAPS
> +-----------------------------
> +:Capability: KVM_CAP_PPC_COMPAT_CAPS
> +:Architectures: powerpc
> +:Type: vm ioctl
> +:Parameters: struct kvm_ppc_compat_caps (out)
> +:Returns:
> +	0 on successful completion,
> +	-EFAULT if ``struct kvm_ppc_compat_caps`` cannot be written

-EINVAL also needs to be documented?

> +
> +IBM POWER system server-based processors provide a compatibility mode feature
> +where an Nth generation processor can operate in modes consistent with earlier
> +generations such as (N-1) and (N-2).
> +
> +This ioctl provides userspace with information about the CPU compatibility modes
> +supported by the current host processor for booting the nested KVM guests on
> +PowerNV (KVM nested APIv1) and PowerVM (KVM nested APIv2) platforms.
> +
> +::
> +
> +  struct kvm_ppc_compat_caps {
> +         __u32   flags;
> +         __u64   compat_capabilities;    /* Capabilities supported by the host */
> +  };
> +
> +The ``compat_capabilities`` bit field describes the processor compatibility
> +modes supported by the host. For example, the following bits indicate support
> +for specific processor modes.
> +
> +::
> +
> + bit 1: KVM guests can run in Power9 processor mode
> + bit 2: KVM guests can run in Power10 processor mode
> + bit 3: KVM guests can run in Power11 processor mode

May be use H_GUEST_CAP_POWER9 and friends ?

> +
>   5. The kvm_run structure
>   ========================
>   

