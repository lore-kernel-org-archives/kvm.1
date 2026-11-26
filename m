Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795674768;
	b=fAzTQKn5f8Cc4xwbK669FW4FgBx7CLwa1AX55A00tJdnvVImyD4joEVVZD++7FnF49D3
	 X32XUBwDZ994FKBntZdhmdb5ZdMJNZpGC+6maL20kAxvLwDa87yVo5VoFwvevqbvPWuyd
	 wL3u9+OgmCqgsQ8tCm0ziaIOTUlK/vGRsMKBYf89ABssXnnUaj62wPdiv50tH9wunNbNn
	 7FaaVf+H3pSiPaogyI2OcUhUc/uda95R6SNuow6g1rLggf2b9qX/7luYtIm+30yRHX7cx
	 z85wyoBqqNSaKFBLbgaAmZyJjq9MSpHBMXARDBw8UpUherL1yCnfwSCGU8g2beAUpgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674768;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=absz+50pJ1uI+qK5l0IMT1oIs9ioiga8DOfOnx5z5wI=;
	b=w1s1CttBevnIiGKTlFpsldAwUXoCwGkQcsGU2pq+gtwi8qdx9yBrvEE6IHQXw0as/CrW
	 seFEVYqu9Y/LdfAN4nIiOyjky/oZh3ZwZjOCvb5GWKSIJUTZLWGFZS048zPiqXG9jNpyH
	 cnIMwpL5vuwU6OIV3qHkEtsBJAg2qpo0AQ4cVDY3Kgwcjt9wl9W3cNkUPMeu7MQYoegGj
	 i4K3XMMhMMAhnO2iSp4hHtWWXXfUXyDYgzfekhiN+ColY095jA1vPiJVqZrLQfnJ6rv2u
	 lSHE/VfeJE4lsK/KvFQc9Acqrk4JfMba49nkoDMYi+uJ2/2d2k4TYPsvAhW2Se3kT7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tdMrpK5f;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C81606A31E;
	Thu, 26 Nov 2026 06:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1C81606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tdMrpK5f
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ34hlV1516252;
	Thu, 26 Nov 2026 06:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=absz+5
	0pJ1uI+qK5l0IMT1oIs9ioiga8DOfOnx5z5wI=; b=tdMrpK5fmeaQR6Ku9oTWvN
	BL1t7wiGdavSQkQtaOZGXo88DulLTEPjenwNDjxYQUf6MwkxUrHatXNKW8+7Gv9y
	8z3YmdmZhPgEJXmG2TCergX0OfOQDILMfUQZXHD6+I4peXhS+m+IwiyEC1Eh96XF
	jkhKegRUzlDf7507vTUmekqBXrzNJi1fUh/erGnzmNLTa+j9i5pxMtfJ4by+mXzj
	Qa8v4cK69MsRtEchRiqvx6ZqgblUZRO4KjZi9WxSFgpZX6rdDWPqxIDI9TsphbxW
	/Keg2GTSn1YK5EFl4Z7MidBV0dJREt/cBFKTFBllqb+/oYc16ZyRew1DGiw1EFvw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3g0xk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 06:32:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ34MaA2799060;
	Thu, 26 Nov 2026 06:31:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4hhcg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 06:31:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQ6VuWL41615700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 06:31:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA69A2004B;
	Thu, 26 Nov 2026 06:31:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C0F020040;
	Thu, 26 Nov 2026 06:31:56 +0000 (GMT)
Received: from [9.111.6.167] (unknown [9.111.6.167])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Nov 2026 06:31:56 +0000 (GMT)
Message-ID: <4648f4b5-d035-4769-9270-741ea9141b7e@linux.ibm.com>
Date: Thu, 26 Nov 2026 07:31:56 +0100
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
Subject: Re: [PATCH v2 1/6] s390/smp: Export arch_smp_send_reschedule() for
 KVM
To: Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Satish Kharat <satishkh@cisco.com>, Oliver Upton <oupton@kernel.org>,
        Marc Zyngier <maz@kernel.org>
References: <20261119235656.70315-1-seanjc@google.com>
 <20261119235656.70315-2-seanjc@google.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261119235656.70315-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b07d260 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=4WT1KQsdlCIwYG2GvGEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyMyBTYWx0ZWRfX/8uqfARVMILD
 ccS+WMMmuq3+XUA111e2wdqq+UFSPwDyFYzkNg7F9NEveWPvw2bbxnKnVB7cRhkPvN76aB30WM/
 kfxgdrzEd8+GSOcGWuh8jvZDpiNLLqw=
X-Proofpoint-ORIG-GUID: _jKcKdIQlBMnoegqbZ3dEEeUhY0_Ushz
X-Proofpoint-GUID: ecojTTRl91Olr0aMPhbj_bOvqCE_kWMH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyMyBTYWx0ZWRfX6+fwnkTY6PRS
 Hr20YUKkqV99SCjhm+7qpZQ9ceVQMPuDtLzzLnZO8XzagAaoTuKpEqB+/8BkNS6EM5LOVTpxmFD
 cH55Ac3HHpz7JCOWVVfQxBbU+HizJ7p+apGD2pJoyQ2fn0aEDNtnti6gVfuKOqudvpu1kmYQauO
 Odx308ObPEBLvC354ZrjFPHGDCVe2oEpTBJDmYjXl04FOM1dUY2YEsdASdvlxzKqyVosC3SJw9S
 TIs8V4DfjOBRL1ixR8Ct7Ww7d9fXnmHIHwldSPacEuLwXlAa5w/67evKkITWAc1qcqr20lfRWMp
 S2ECBdDJ+QmXx/pM8QiNEoAK+QSGlE2ambxuq6Ii9oLYX5gEC4UwAc9BQkycuhZC9wXQ7rjr13n
 lfCcEHY2oiDCV+BCgUT3vRsC+KqQ7KkjQzJJfDYb5bYb53QPT5fGWevs0VDgiNA6cim/tJdME4K
 oR6UCMPw+GdPCjMjj9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260023

Sean,

Steffen needs this as well for our arm work.
What is your timeline for this? via kvm/master or next?


Am 20.11.26 um 00:56 schrieb Sean Christopherson:
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
>   arch/s390/kernel/smp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index 32499cad86f0..39318aa7ab7f 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -531,6 +531,7 @@ void arch_smp_send_reschedule(int cpu)
>   {
>   	pcpu_ec_call(per_cpu_ptr(&pcpu_devices, cpu), ec_schedule);
>   }
> +EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
>   
>   #ifdef CONFIG_IRQ_WORK
>   void arch_irq_work_raise(void)

