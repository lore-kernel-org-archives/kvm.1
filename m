Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B35D3BED55;
	Thu,  7 May 2026 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160995; cv=none; b=HctIbnXg1GhqKHbhhsxOr3JDpjZexRR3e4BJ8sgqVuxqHjWW3yHwoiyuk62qAEpsoiFvTCbdSn1KGbLAT0gGoCUPAOx23OIzGoLhGG2UHQEah9KInmW1RjuKMDdb7+A0hog/zxfkskZi8Gv0IUGTkHrOIq9ZDk6VC9gY8nnTc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160995; c=relaxed/simple;
	bh=WWCMaLDR9vXbdjXmmbxHRFTfH3JsBNIW1Dv4zbeE3hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P474Tm5YOYFWTlUBd6kGU6EuBbTVX1vVogWhFw1LOKWEBj/tbmSlapMWKntTGleabx3nkJ1mgAeVq/7/sI5tItRU67qLaF+EdGmoMx5uA2gbZbnqqgMF/P8bePctQDakQdFb4PzFNZnqB5UagU0uNXPSVCRsCrTbQjxt77D6DHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eQdwG5H+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eQdwG5H+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647BJdeP2510470;
	Thu, 7 May 2026 13:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ptn6DQ
	3I/w0dx/2bXRM5vURz3HF4y9XiV2rZ7frnlVg=; b=eQdwG5H+RNMA+tIeTGTMt8
	AZMMU9KrA3JxGpNns/DSHkWb6gBoy/5PSyIeAsiZOM4aLdS9B21N07fqscURiv8+
	fkD2kOSrcfBbQuUdAW3a/uUD5ONGqoG2FpmpOxRMsYFf/5DVTLOJp+uTlkvYINI7
	4cED/69Oe/rWoo8RIWApVY0ztUJ8C/iN0l5YPNDY37wNoadORkk/S5wTQE4dC7Cc
	eunQxEgRnakSvP/7rvYfxCe1FpyDqVrV38weQMCQ0i2n87KQvRPt6rs86qT3vt/h
	epCeH59S87qRoVOu34lWswkLrqq2e6/y+grmY3X4zt9dcNZNcOEZGFybNpYAjirQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4xpk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 13:36:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647DOUCw031725;
	Thu, 7 May 2026 13:36:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqky6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 13:36:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647DaDgN14418366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 13:36:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 679D920040;
	Thu,  7 May 2026 13:36:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 936F120043;
	Thu,  7 May 2026 13:36:09 +0000 (GMT)
Received: from Amits-MacBook-Pro.local (unknown [9.124.211.112])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 May 2026 13:36:09 +0000 (GMT)
Date: Thu, 7 May 2026 19:06:06 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 KVM_PPC_GET_COMPAT_CAPS
Message-ID: <20260507185925.074d9db8-aa-amachhiw@linux.ibm.com>
Mail-Followup-To: Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
 <20260430054906.94431-3-amachhiw@linux.ibm.com>
 <8c72bee5-664d-4ecc-b4c5-03f825febc75@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c72bee5-664d-4ecc-b4c5-03f825febc75@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzNiBTYWx0ZWRfX8idr5oCIRjj2
 YR6nx5SzYzuXC8CN19RUSJtlYrNw28WAQ1bLvy6eDEmzX3sfm+9EEOqywm1obOeYbozl2WEhKGd
 2b8HiBKHdcYdbva7Vf3Ym2bnA018CJJ4CsyRSxMz/92yA5HF+1sSkEQKge8tPudu11dfeitaZl6
 S4pul1afxNUJT+tj6UxVtx8Jo/U7+tsA0TdiwayzC4Ww3MY4NwibjoTlRCqIHkkcIVGTBt5vf8T
 uZuLYHlI8ugI2Vgz+Ge+Q0R7kPioVgqglgSABlzjIHVH+t1XxgItz4bTpQF6hYNJw766VbY1w4W
 vHCJrLR6mUFFaIREjTbjR5aJ39F9euSEbG+a3+eLA6k+XpDIY5eWROcF4O0vn0Nj7dqDnwTEQTq
 0Gt6vYszmUVq2TQ5Yz6tho//3hC/GGqu/bnoQKlhrJbUmmh6cfeo3OnYwedysmNZECRKoKeUMSp
 6TH2usmF9J7hB3iofJw==
X-Proofpoint-ORIG-GUID: 8Mb9dzgTNlcCif9jroF-UYKP675MUaW4
X-Proofpoint-GUID: X17cmiSU6Gq-8Au-23YjOu1QNiHoXcUU
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fc9552 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=igKWJiBubbBvPOcM4eYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070136

On 2026/05/05 02:01 PM, Harsh Prateek Bora wrote:
> 
> 
> On 30/04/26 11:19 am, Amit Machhiwal wrote:
> > Introduce a new capability and ioctl to expose CPU compatibility modes
> > supported by the host processor for nested guests.
> > 
> > Introduce a new KVM capability, KVM_CAP_PPC_COMPAT_CAPS, and a
> > corresponding vm ioctl, KVM_PPC_GET_COMPAT_CAPS, to expose processor
> > compatibility modes supported by the host.
> > 
> > On IBM POWER systems, newer processor generations (N) can operate in
> > compatibility modes corresponding to earlier generations, like (N-1) and
> > (N-2). This is particularly relevant for nested virtualization, where
> > nested KVM guests may need to run with a specific processor compatibility
> > level.
> > 
> > The new ioctl returns a bitmap describing the compatibility modes
> > supported by the host in respective bit numbers. This allows userspace
> > to select an appropriate compatibility level when configuring nested KVM
> > guests.
> > 
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >   arch/powerpc/include/uapi/asm/kvm.h | 6 ++++++
> >   include/uapi/linux/kvm.h            | 4 ++++
> >   2 files changed, 10 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> > index 077c5437f521..a38dff7a8aea 100644
> > --- a/arch/powerpc/include/uapi/asm/kvm.h
> > +++ b/arch/powerpc/include/uapi/asm/kvm.h
> > @@ -437,6 +437,12 @@ struct kvm_ppc_cpu_char {
> >   	__u64	behaviour_mask;		/* valid bits in behaviour */
> >   };
> > +/* For KVM_PPC_GET_COMPAT_CAPS */
> > +struct kvm_ppc_compat_caps {
> > +	__u32	flags;
> 
> You may either want flags to be __u64, or rearrange to keep variables in
> descending order of size or add padding as appropriate.
> Also, if we are not using flags with this series, we need to document
> comment as /* reserved for future use */

Good catch. Sure, will do in the next version.

> 
> > +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> > +};
> > +
> >   /*
> >    * Values for character and character_mask.
> >    * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 6c8afa2047bf..1788a0068662 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -996,6 +996,7 @@ struct kvm_enable_cap {
> >   #define KVM_CAP_S390_USER_OPEREXEC 246
> >   #define KVM_CAP_S390_KEYOP 247
> >   #define KVM_CAP_S390_VSIE_ESAMODE 248
> > +#define KVM_CAP_PPC_COMPAT_CAPS 249
> >   struct kvm_irq_routing_irqchip {
> >   	__u32 irqchip;
> > @@ -1349,6 +1350,9 @@ struct kvm_s390_keyop {
> >   #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
> >   #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
> > +/* Available with KVM_CAP_PPC_COMPAT_CAPS */
> > +#define KVM_PPC_GET_COMPAT_CAPS	_IOR(KVMIO,  0xe4, struct kvm_ppc_compat_caps)
> > +
> 
> 
> This patch can actually be squashed with next patch where the struct, macros
> are actually being used.

Sure, I can do that. I had split the uAPI addition and ioctl wiring as separate
logical steps, but they are tightly coupled and the split may not add much
value. I’ll squash patches 2 and 3 in the next revision.”

Thanks,
Amit

> >   /*
> >    * ioctls for vcpu fds
> >    */
> 
