Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535686;
	b=hE456Cy2NoV3dzy/ufgcvDxzf1Y4Qja3v2wHISI1ROROPpcAqvgzTuR9R2DOV6whOz1p
	 RJWVb4ll+VM5/VcOhMThQOSF79w16aOov92Tiui4ZBiHoW/NL8t3SJ94bsikLFyuVkGU2
	 34iDJH3WOK8A+x1RdzlNU240roOxWHSpwxJLkeFj5lt3wlAx07ywowfBRP6wWOwSYiclc
	 bz3qcL/3w6AdLWJ6+ckMfq1TOzOYZ9HT5rdFlkzBHwIC4FTGMPXdVYVVCqobC+ZsnvSKz
	 PH6vT+hfUa8ywz7M1HuT3E3Tq1u1ZgQ+xyboEXz0hzogEMAPkEo8Cv1ULdjCQx5w+KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535686;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=e8e5Qp1fHXt4+wDVm9b3f5ItDKG64BVLYi7l2B//IBs=;
	b=v0CuHvGwXJkYkTyhNnK3AFxZovbM+8Z4T9bWd7vUQ1uALsaCqJyUAjpUF0AVkHW642wV
	 eK44dTlvLTHiSGxrwbDj+WIbn38FI3w73g3Oaj1Y6VkDVSxh1Cu58P5KgnKpQRky3BTTN
	 lymBRshvjdrltdwlzR1GmxPNj3e5SyJXUovWgwiLktzq6aVaYblUz8qgG/ly3jgVdb3EA
	 7NVOgII7t09S2ji/IDYP6ivjDoZJytN4AA8+NeJKkJiP6AnqD/pU4RqddMl4m5o6wG6o9
	 FtjpM63Evrd1JQmwFtG5A+dwjaIFkCplcZpbUakjjocc8/9PLZmR63fg+Cg91JHqovg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IvehIjTx;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71DD60A263F;
	Tue, 24 Nov 2026 15:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B71DD60A263F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IvehIjTx
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFa4p01235548;
	Tue, 24 Nov 2026 15:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=e8e5Qp1fHXt4+wDVm9b3f5ItDKG64B
	VLYi7l2B//IBs=; b=IvehIjTxyW41YYLcEj9hfBmMX/DNwm6hUGBFQ04/DQ3Hpa
	/GALt1spoMwdhkXTXvUzYZlKC4ZgMyR0j/OxQdPkZdLdq3uGgQ2QPyuOoWeMk2sf
	bvSJL7bZLHUneMoSV1m+UaRbGyQ8PgRSk9QMc5Tyk9hAxq+Q1MlEWzjQi6nB/EOw
	SKuoD9v5MWFE0MoOcv9R9DzL1gZEKDlWMU1V4UVNsK3zun/VM/RpKMGgxEcKumCV
	rK8Hwvt93SnMa3Z+6ydK8x4i7+Ihdv1hsrsCSKwUJTW3/b1ImzBJucwYtsjmQTBD
	M8soFqxEScDmFha3wjzqE+JeRdx8f+Gk+6YzKdvw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g38f3b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 15:54:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFJVqZ2883589;
	Tue, 24 Nov 2026 15:54:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vk8d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 15:54:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOFsCDb54329758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 15:54:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9E732004D;
	Tue, 24 Nov 2026 15:54:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF1232004B;
	Tue, 24 Nov 2026 15:54:12 +0000 (GMT)
Received: from osiris (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 24 Nov 2026 15:54:12 +0000 (GMT)
Date: Tue, 24 Nov 2026 16:54:11 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Satish Kharat <satishkh@cisco.com>,
        Sashiko Bot <sashiko-bot@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 1/6] s390/smp: Export arch_smp_send_reschedule() for
 KVM
Message-ID: <20261124155411.1489564A75-hca@linux.ibm.com>
References: <20261119235656.70315-1-seanjc@google.com>
 <20261119235656.70315-2-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119235656.70315-2-seanjc@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b05b32a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=4WT1KQsdlCIwYG2GvGEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2MSBTYWx0ZWRfX1qSMkmTptHel
 W6OpUxOd1ZXedvXCCHG4xDBqEBxC7bFhBvdtHtNvVr/2BL8WQnE7XQfbYdgL/73saBGUsaXH90K
 4VjQfgfBV9+i3rw7Re3zParwhaGdeWE=
X-Proofpoint-ORIG-GUID: 8x3EP2G_xh-a5P8D35ad-3xqBjQmLoxl
X-Proofpoint-GUID: 8zI-4aIuiUn9SupCeJySvMMrO1JykAiH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2MSBTYWx0ZWRfX2+BqfhGF5WYr
 y1huu7NowjGuaM97CEwgdH1YR/sHcch2UPgo8d9liMJ4b7tvAI2XMjimygwrKLResX65ZUOF+Dq
 YdBN1z8sSTtlKibrvxnu2llpVlCjGfTmogXJ9y26MjsQvdbOzDqPiuF5QrT8AmbXvwRmyn0yIlI
 qw6xViD5/p4choJZ4YCuHKJXZXPcatTHgVNRPWQoFHlx5TA9RHXgccNdUjqzLfA2NbkIhU30ckH
 qSGpKa45vHl6a/reEWI3LPAgG8c55oPPIBkbBg1OBnqfykwx8iSVuNw4g3AMcXZ/TYvKyxAlmAL
 kU/TAutYC0g9SppsNbk4nsS4ZAfERWOrQaJU71kJkXudf2lYj4IvJxggmWe6mFqNLSRRKs7ugZJ
 8BmwH5Ag0uh6xlzoxi02yWP/BIONNbejXNDR+s7ZH8ZkGEFHGIgFSN2pPxU5GnyrRhe2JsytXIM
 2YXF2A8/Z6v5/vwIJgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240061

On Thu, Nov 19, 2026 at 03:56:51PM -0800, Sean Christopherson wrote:
> Export arch_smp_send_reschedule() so that KVM can use smp_send_reschedule()
> in common "kick vCPU" code without running afoul of build issues on s390.
> KVM currently uses smp_call_function_many() when kicking multiple vCPUs,
> but several KVM architectures (at least arm64 and x86) kick vCPUs with IRQs
> disabled.  Using SMP function calls with IRQs disabled is unsafe as it can
> lead to two CPUs waiting for each other to respond to the function call,
> i.e. KVM needs to use smp_send_reschedule() to avoid potential deadlock on
> other architectures.
> 
> Alternatively, KVM could go out of its way to avoid smp_send_reschedule()
> on s390, as KVM does when kicking a single vCPU, but given that all modules
> can reach smp_send_reschedule() via kick_process(), forcing KVM to dance
> around s390 adds no practical value and would add non-trivial complexity to
> KVM.
> 
> Note, thanks to s390 now building kvm.ko and kvm-arm64.ko, using
> EXPORT_SYMBOL_FOR_KVM doesn't Just Work.  Exporting the symbol just for KVM
> would also complicate backporting the upcoming fixes to older kernels.  For
> now, keep it simple.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/s390/kernel/smp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index 32499cad86f0..39318aa7ab7f 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -531,6 +531,7 @@ void arch_smp_send_reschedule(int cpu)
>  {
>  	pcpu_ec_call(per_cpu_ptr(&pcpu_devices, cpu), ec_schedule);
>  }
> +EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);

Given that quite a few architectures export this already this is fine.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
