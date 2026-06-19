Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA27349CC1
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781867723; cv=none; b=hKWfdfOsPjoofv1BlFQtv2QUSRB+zjnAiRRUOvBTOFVGxfRew4L/8CwAwYsUMVThENb6iTN2m096+EZvjwWWJd3Vor4pP7u+nAjbskJ/dhZmPGTCw796ZwK/pZrNoMYT/wI1k4/GwR+M+H91lC0cXiXrpi1ChPqXVDL4VFA63gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781867723; c=relaxed/simple;
	bh=0YK9noE9WtyxrFerTVJcLeeWn1yiO/zNr4c2x4rn6uo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n/dvO5hZoRALc378Ynq7i86sxejw919qEyIBIbH9Qwun1PGwchg6nk1WKZroYg78HmY7YUT1JAf0XRGmj/yoxboswWDzdL/mV0uRSWj7ioxdtFniEzrExN9+1E9gJvUbtLXqVc8uuv8X/xAz3BPTh7QAYCaUmyI/xBWcg5S0j4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ui1OI25s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ui1OI25s"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mP541674570;
	Fri, 19 Jun 2026 11:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=NoB0MsjvKONo8dUKXVrEa4M8V5PD+H
	FK5kzM5qWb45M=; b=Ui1OI25syPDyA5GCKThqhQ3YDolEK499tzdNG4A1IMk13j
	sgOPEMlO9FPjFyQ13wvm88Cqc7VTLLE2oCiA6CxH9yP5wtYld023BYWoJcdc65wt
	CzlL6aTpnT2u11lZhz4q+nxnzot/KiUsdMMF5AJqveU6zwQhBPUO2KANMBU9okM1
	K8rQdg1GAemGL0GkLTY/tZGqgFdQBkV7v30onuzqEyL6c/vrspFm5w778XSTue+1
	tCyJI3Hag0IJMSPJeLgnmLuX0GXjzPbYRP8KvwC9mxLsQBEo+UVoGXD+cgFZLoCF
	JxT/8NSVe/pJDY2xTSmevJ4niYtXWfh0aHCcJc8w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw57e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 11:15:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JB4br0014272;
	Fri, 19 Jun 2026 11:15:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172gh1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 11:15:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JBFDGN9503484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 11:15:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B8125805D;
	Fri, 19 Jun 2026 11:15:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C5B75805A;
	Fri, 19 Jun 2026 11:15:08 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.17.1])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with SMTP;
	Fri, 19 Jun 2026 11:15:07 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Fri, 19 Jun 2026 16:45:06 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
        Harsh
 Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>,
        Glenn Miles
 <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/3] target/ppc/kvm: Use host compatibility mode for
 nested guests
In-Reply-To: <20260616113915.25589-4-amachhiw@linux.ibm.com>
References: <20260616113915.25589-1-amachhiw@linux.ibm.com>
 <20260616113915.25589-4-amachhiw@linux.ibm.com>
Date: Fri, 19 Jun 2026 16:45:06 +0530
Message-ID: <87tsqybx39.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwMCBTYWx0ZWRfX4xwcrW/VnS41
 E4MEYFKJoXp8AjeJ3OKNR2zA/rBnnuVAD3MiqZT1kpVdesMymtse7J/t6nsyEL+58p6XF7d63Yj
 9uWvg0VQW3x+a/Aok5GQVoc1Ky6Y1eU=
X-Proofpoint-GUID: 46Ds43Rfojow832oKKqE9kcIHCQh5OYB
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a3524c4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=bvJF0EKgzo6ktdy21AQA:9
X-Proofpoint-ORIG-GUID: 017bLqA3rl5V9Dg7XXvbxbWGkJXjFKVK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwMCBTYWx0ZWRfXwOFfB3lMC5yo
 zQUy9wKwDzcVVtjoENaxdQWRJbBH+9cXaI9+ljtvytC8/4El+GNNIDFE5tjYsva/Gzgn10/EfGt
 tbVBZgZNn6T35T5ptWIj/1HJ27boUd81vO1u4yb9m95BIFDHsMrqtlfAYn4M2lZglDVpZaCLSQW
 8IyNY0Grqkvs5o31Oxg3SkpTiokOPUaO1QrXHJNf03OGlI5RfQHFTvvGaiE3h9PC4bmp0iMlp27
 NhZkH8LOsb6wLWpxWvfg8R4dKKPF453KrQOhAkkcp2v5yZWBL9W2jXmZyoaRykEHZBWOML/7RnC
 D0/5GQ+TJmaDUGcikzu11YP+gRwZzlAOx7FzNBMFjty1G6sLIIt0mt7FrWiFjkFd4cJXfBCwNjt
 sdexxZigqJtRMT+twdbfeHR93asd9RRRN2RcUWrPLiEuwFgEvUIMmDhiWRMVvhN2iXFbA+Um0Hw
 EW8gquxcwhqzSR6gu4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190100

Hi Amit,

Thanks for the patch. My review comments inline below:

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> On POWER systems, the host CPU may run in a compatibility mode (e.g.,
> a Power11 processor operating in Power10 compatibility mode). When
> running nested KVM guests, QEMU currently derives the host CPU type
> using mfpvr(), which reflects the physical processor version. This can
> result in a mismatch between the CPU model used by QEMU and the
> compatibility mode enforced by the host, leading to guest boot failures
> such as "KVM-NESTEDv2: couldn't set guest wide elements".
>
> Update kvm_ppc_get_host_cpu_class() to check if the host is running in
> a compatibility mode using kvm_ppc_host_compat_pvr(). When available,
> use the compatibility PVR instead of the raw hardware PVR when selecting
> the CPU model. This ensures that QEMU selects a CPU model consistent
> with the host compatibility mode, allowing nested guests to boot
> correctly.
>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  target/ppc/kvm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 9e5006e0c2cd..a72f237f0c8a 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2672,6 +2672,15 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>      uint32_t host_pvr = mfpvr();
>      PowerPCCPUClass *pvr_pcc;
>  
> +#if defined(TARGET_PPC64)
Use CONFIG_KVM

> +    uint32_t compat_host_pvr;
> +
> +    compat_host_pvr = kvm_ppc_host_compat_pvr();
> +    if (compat_host_pvr) {
> +        host_pvr = compat_host_pvr;
> +    }
> +#endif /* TARGET_PPC64 */
> +
>      pvr_pcc = ppc_cpu_class_by_pvr(host_pvr);
>      if (pvr_pcc == NULL) {
>          pvr_pcc = ppc_cpu_class_by_pvr_mask(host_pvr);
> -- 
> 2.50.1 (Apple Git-155)
>
>

-- 
Cheers
~ Vaibhav
