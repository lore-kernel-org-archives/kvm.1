Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795320512;
	b=gnIhePOdemTKK2ROApEuYkWBwX9UkbWRUQe0I/opfM3mZGvgnlKs4UWXzuDVdXoRw9Fe
	 QKF9Ci20PT107XPxtsa7VLOElj/Z3mJctvq9ijvuNPSfu6BErYFc7RzgjgKCtM23eQpR6
	 2ijLU0uUHXoskX6n/fBkEdaUfGtfMip3Yt3Nagxu5+8DLx6mBrrQklLX6kBOwb+F93QsL
	 bNdl4ZFelxytyHDt1Kcv6ztQu9iSxBk4zqPXpzXQfBmf7Hx9l1tuTuxJuCaHpvSlX6t4W
	 1DLr0ImjbcRK6VttXcknNT2wHcRSN0Z5dv5DoEXXJI5HDd7fiieI8RNgH5/nnSQn9ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795320512;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Uv8h2L45V4jj5LVvESCeSMq451qPSPNLhaVFN3TApkA=;
	b=rFyAY9aLHs5JYv+8jfx670rSx0k4hzF4VYTZXJDRnYLx8ePck+VxItZt5tyLEGyXOTmD
	 HhH8Jn11LdIpElGp3KQwbs4fLS8ZMyRIgRzJmLWX9XAc96F0XYtyXxMHbv4NuFix37y6h
	 OOqWjqiLg3CTE2Wg4g0KYkpdfwPd3WbXSstqn7UThmf4C93IyYD8kRb31KAtFCkoF0Qt1
	 B8kJWKLQLmnwFjZsOjBPQG5Ntpzydj5z6l6V1TvKtKsaHvl0gsJYlMYGgXf6Pjxb+D4BR
	 37df2JXrzvU3rSf4HfdD/FJBamM5iXHckCVjEsfB+uEKYidQIntMh8/Arab9+DzsyYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fY1iywxG;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20799606A320;
	Sun, 22 Nov 2026 04:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20799606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fY1iywxG
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM44Wnv3724081;
	Sun, 22 Nov 2026 04:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Uv8h2L
	45V4jj5LVvESCeSMq451qPSPNLhaVFN3TApkA=; b=fY1iywxGSjyaQuK2adLxRj
	2CeiRAC5Q/x9YGowm2V3q+7wiQQrahExgsczFCn3nwUGPoF685L9931mDCjlnDLV
	OsLwn189d2a238bwXYEtOFUG5R3PBqqb9+qtQ6DIY02h1QkMNbWflWWhLIRKe93O
	wBl7hg9/F+XrgkFJuLbp6K9EBuV6TcjZ35IoPQ/9Bcin4qSh2Cqwzx0D0+7I6I71
	43+RJf86/8+J0FZzLWH+QSR8TuV6u8Wc8XLMGhMIS9ITYTubjJVpB42kElL8kbiZ
	30DHtzOuDyYmTlYGAOD37Im7iFA0tDIm6Es2vmu3D9lhyAUm7azG8K8zw/6Bnuxg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fk4uqq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:08:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM3nD751128197;
	Sun, 22 Nov 2026 04:08:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmjrff0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:08:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AM48NoS52953456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Nov 2026 04:08:24 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A336458055;
	Sun, 22 Nov 2026 04:08:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CD0F58043;
	Sun, 22 Nov 2026 04:08:22 +0000 (GMT)
Received: from [9.43.90.96] (unknown [9.43.90.96])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Nov 2026 04:08:21 +0000 (GMT)
Message-ID: <ac3d60d5-1bd3-4f60-9933-e03af7323162@linux.ibm.com>
Date: Sun, 22 Nov 2026 09:38:20 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: PPC: remove unnecessary #ifdef
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20261120133413.475489-1-pbonzini@redhat.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20261120133413.475489-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxNiBTYWx0ZWRfX+0QTWCPrwkhd
 2Ny+u/rYMMxR0z4ARAskb2kgvEiRP4WLBNGEhT/+bPCJYxVjCEfHQ3uU5vQ3jOQ7KR2Va8y5iu3
 cYBk6biXug08Of/gBUaYqcoafEQAeKR7A/AbqhGym2zgxxWYviVFjtIW6jZcFIiPadbxTKNJ2O7
 QaiY1tXrzJbInqmFNNmzUPTmLJaRxAc290HUL6el1KoeztHfzymLHdxMJONzANupLDnh9NLanT7
 KIOFP6AGHgP1Kd6mDZX7ULUc4ky5PrPaEVCs1nMpcEw3QCkQ1XNODx3TE7d8fFDqdmsnRPvQG9h
 4dIUNJx9yPHWC1HMTTB1saT8l0Px31S4lAe/DX5EIflhTlO/sVXI8nbHSf/U+UXWGvrb5eL7Q9D
 P9UQ63QB+qNhAZVBoW8kQOm3d5boK/IN73OwzPll+BAXjX+JHEP/l+Udf9KvcLV2RAoDs0YN6xn
 Qs+vNVYkQ9LZYz1+yug==
X-Proofpoint-ORIG-GUID: hCpujaJVqeKogjbmvqemIG1K_zYI_K0k
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxNiBTYWx0ZWRfX4GWVfEmf1jds
 a+TN+TbkXXod5hlOBO2b5yuiWXkelIyxC48jA8UG47OepvTrLoQviRF27TjM16JSywuG5UC+W4a
 u6DFCnpM6euGe9cyyc+Kwk143IwtPjM=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b026ab9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=BE-TfwSVDWWdQ4Vu56kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hCpujaJVqeKogjbmvqemIG1K_zYI_K0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220016

++linuxppc-dev

On 11/20/26 7:04 PM, Paolo Bonzini wrote:
> booke.o is only built as part of kvm-e500-objs (which is conditional
> on $(CONFIG_KVM_E500V2)) or kvm-e500mc-objs (likewise conditional
> on $(CONFIG_KVM_E500MC)).  Thus, the #ifdef in kvmppc_core_check_requests
> is always true.  Remove it.
yes kvmppc_core_flush_tlb() is defined in e500_mmu.c which is 
unconditionally linked in
both e500 config (kvm-e500mc-objs and kvm-e500-objs)
Nice catch. Thanks for the patch

Queued via PPC tree.

Maddy


> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   arch/powerpc/kvm/booke.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index fd7f24a68b31..ba762ac1fb56 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -738,10 +738,8 @@ int kvmppc_core_check_requests(struct kvm_vcpu *vcpu)
>   
>   	if (kvm_check_request(KVM_REQ_PENDING_TIMER, vcpu))
>   		update_timer_ints(vcpu);
> -#if defined(CONFIG_KVM_E500V2) || defined(CONFIG_KVM_E500MC)
>   	if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu))
>   		kvmppc_core_flush_tlb(vcpu);
> -#endif
>   
>   	if (kvm_check_request(KVM_REQ_WATCHDOG, vcpu)) {
>   		vcpu->run->exit_reason = KVM_EXIT_WATCHDOG;
