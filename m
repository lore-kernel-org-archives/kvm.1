Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8603A7F48;
	Fri,  7 Aug 2026 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104515; cv=none; b=p4Cn2hmHGOubZBhXSfqjRbp45akPCShrxN9RE1J4YRDgvNM8Bf+DmxeSgl380v0Z9ygY/0xQG9PmivcVCRT9tV/m1vFy7lbe8+wed7CGkVfj4Q7Dhapu0JhCd4JTjmc1cwMTIvjMR+qLqQ0VRlVKu+U38IcxHPWm7fxB9+0iDuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104515; c=relaxed/simple;
	bh=HSpm/ilFlKL9C7zSnRA7Fv6mPmAahK0SYIkU4uTFUQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTtgWhvjB1ZSzoCC77wHeWMvBujXKLUcPVQSoil0/+/fxklHesFSuzp9OG84dKjgzo80QtKYRTNQIekUmIS0coc30QsWLJTT65cjxmnCeE+5JQ/JeBigIaepMYDyvpcjXpjRqnghmQSylTP0534mPMxgPyuJVNKyrW6Rn4c9JII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e2KVrDgm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e2KVrDgm"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770I3pK4135292;
	Fri, 7 Aug 2026 12:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BfZRbE
	TEo3DVte5hEdWjaM9qnh99mmSlCn36/NdyqnE=; b=e2KVrDgmyXUj3ITOJZZVoc
	tkCcCfJsPng8Iksgk3JXSEKilFeIH9+BL8rcFHETI65BBLAFfoznMb3QIDiLLuGW
	Ow74hTlp+izJpHd8XohBTbuw84+8eebYAsx374GWegeah7SAWGfr3ViyAE6+OGQD
	gMUG600PPl2Iv2JOGzBGIOA/zmUP5ZFY4sY7wIaX1wUAkhy39sKNChv6cw1TklbX
	v5F37/ZEkTkr3qGaVbU8wuYS6CQgOcvyrJhzsFT6PhqvLkw3no9w/uHcWMNL0Yue
	mteztkhQipmwKiKgZ1QUsU5aF7SoESII/mBYz/HSFvta1dLbvSBQY65vReh6RJVA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy043rb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 12:07:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677BuJDq029357;
	Fri, 7 Aug 2026 12:07:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kfknk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 12:07:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677C7icQ52494812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 12:07:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 737552004D;
	Fri,  7 Aug 2026 12:07:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 210FD20043;
	Fri,  7 Aug 2026 12:07:41 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 12:07:40 +0000 (GMT)
Date: Fri, 7 Aug 2026 17:37:47 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v7 3/4] KVM: PPC: Book3S HV: Add support for compat CPU
 capabilities for KVM on PowerNV
Message-ID: <20260807170704.3280f54c-e2-amachhiw@linux.ibm.com>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Gautam Menghani <gautam@linux.ibm.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com>
 <20260806170645.11892-4-amachhiw@linux.ibm.com>
 <bjbeledh.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bjbeledh.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5MSBTYWx0ZWRfX5TzLKCqXDqZu
 b6BiRef/oECz9G4XMeWgvA3fRyFHPyA4v0D6/QI66iMXht8JO4WINYvKcNOhEt85PpoV8J2a4Ey
 Ep62KKeD9up0soUyfqq97/Agaf+ofRa9IAov4qPkmW8kgpr6EEtPAH5c6kcuAh74iZzDDOJmfiw
 C11ETLzDAv+8v9CtmCVrYaKj/QlvcE4W8bduXqN9iShbOpd4pClixHWB4PA12rRgbuCLdAIu8D9
 4Z8wFDrEWPiLRjfOvIESpnxmdR40/39S/fjIXGWrDvVVIiwiWcl4SMnOXHNjJOMEdRM/nDnA/+K
 Z/pWhxnM6K6B+XOC8jgpDsop0AFKnexR9tZOtzY/6HJk7vOVEdTKdNFhMjNo8mRDoNfSJiFRtCU
 y3vQhfWTQjN91c/lpMkAm8VJltSo3Wwc5TxsVSNZvL4f0/Rzr+cgdRkj4srds+m25/GP6hJLDY6
 pymDQfkM1f/vH/29dhQ==
X-Proofpoint-ORIG-GUID: ERwgD-8BR_5ciBrCIKEi1d0ZZbgjqrpg
X-Proofpoint-GUID: CGhTxUgT4QzOkim8g4v8w8QZtS1Ros_H
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5MSBTYWx0ZWRfX5fEiy5kiu5dz
 /9UUwCHcAhK6LahuHI127uI9T+aO2PrM3naXuobCTQWLYO3zlX3oofWQNlmvzDD1esHQHSrWOFw
 flOx3ORG5JleaUuuz9TdTzA5Mb/G1WA=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75ca96 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=H9A0j7aUrpR-r5edhhgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070091

On 2026/08/07 10:24 AM, Ritesh Harjani wrote:
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:

<snip>

> >  
> >  static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
> >  {
> > +	struct device_node *np;
> >  	unsigned long capabilities = 0;
> >  	long rc = -EINVAL;
> > +	u32 cpu_version = 0;
> >  
> >  	if (kvmhv_on_pseries()) {
> >  		if (kvmhv_is_nestedv2()) {
> >  			WARN_ON_ONCE(!nested_capabilities);
> >  			capabilities = nested_capabilities;
> >  			rc = 0;
> > +		} else {
> > +			for_each_node_by_type(np, "cpu") {
> > +				if (!of_property_read_u32(np, "cpu-version",
> > +							  &cpu_version)) {
> > +					of_node_put(np);
> > +					break;
> > +				}
> > +			}
> 
> What happens when we don't have "cpu-version" DT property?
> Check this commit
> 5a61ef74f269f2 ("powerpc/64s: Support new device tree binding for discovering CPU features")
> 
> And also why do we need to parse the DT properties again?
> Shouldn't we check something like this?
> 
> 	if (cpu_has_feature(CPU_FTR_P11_PVR))
> 		capabilities |= KVM_PPC_COMPAT_CAP_POWER11;
> 	if (cpu_has_feature(CPU_FTR_ARCH_31))
> 		capabilities |= KVM_PPC_COMPAT_CAP_POWER10;
> 	if (cpu_has_feature(CPU_FTR_ARCH_300))
> 		capabilities |= KVM_PPC_COMPAT_CAP_POWER9;
> 	

Thanks for the suggestion, Ritesh! After closer analysis, cpu_has_feature()
would give the same result on pseries, but I believe that using 'cpu-version'
directly is both more correct and more explicit for this context.

Here's why:

1. 'ibm,powerpc-cpu-features' / dt-cpu-ftrs is baremetal (powernv/OPAL) only.
   SLOF firmware used by pseries guests never provides that node. On pseries,
   dt_cpu_ftrs_in_use() is always false, and CPU feature bits including
   CPU_FTR_ARCH_300, CPU_FTR_ARCH_31, CPU_FTR_P11_PVR are set by identify_cpu()
   from the cpu-version DT property at prom.c:423:

     if (!dt_cpu_ftrs_in_use()) {
         prop = of_get_flat_dt_prop(node, "cpu-version", NULL);
         if (prop && (be32_to_cpup(prop) & 0xff000000) == 0x0f000000) {
             identify_cpu(0, be32_to_cpup(prop));

   So cpu_has_feature() on pseries is just an indirect readback of what
   identify_cpu() already derived from 'cpu-version' — the source of truth is
   still cpu-version.

2. Commit e4de1b9cb3b5 ("powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11
   and later processors") explicitly documents this split:

     "This issue does not affect pseries guests, where SLOF firmware
      does not provide this node, causing the kernel to fall back to
      the traditional cputable path (identify_cpu) which correctly
      sets CPU_FTR_P11_PVR during PVR-based CPU identification."

   That fix was needed on powernv only — and our code is in the
   kvmhv_on_pseries() branch, so the dt-cpu-ftrs path is never taken.

3. 'cpu-version' is the PAPR-defined compat level indicator — it is what PHYP
   and QEMU explicitly set to communicate the negotiated compat mode. Reading it
   directly is semantically correct: we are reporting the compat level the
   hypervisor advertised, not a kernel-internal feature bit derived from it.

I also responded to a similar concern from Sashiko covering points 1 and 3 here:

  https://lore.kernel.org/all/20260806214117.8a2ca150-97-amachhiw@linux.ibm.com/

So I'd prefer to keep the direct cpu-version lookup.

Thanks,
Amit

