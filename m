Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255983ACA5D;
	Tue,  9 Jun 2026 05:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981911; cv=none; b=jhdEje1boyyv9SdXHIYtYzeJCeL7xHmeUd9RXAbWhOX2pxYwTRZI4fWaOBG1ZtmCj7uzFbaqHEmidJQ1JNpB72xRNmoHpoqZT8wR3+Eog0+hsHw3FykcVq3MnWB/rfegtw+DzYFaCwYnO+lkn5AvFbuDS1rD+mOM/4z30AV7Yls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981911; c=relaxed/simple;
	bh=Ekdj8csd/Z47gl9OxUyZNrIx6pkiqBtQLQ5bt+pDHiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSssgvUlCdp5qdixqo87hbI2vPOSbMehpp39Hv1So6I6bD+9wmCKHKe+dw5It5TuV30pkyQ1dSqVHte3rtP6vCcY38zSPjGmDDlla0y/oFeo366MbT0gnQAMtN+Nnk2oS01kd7nzmkrFjog670RhwPmWB0hsn+KHNnnolYjmn8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nhRzzKq3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nhRzzKq3"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658Kg8px3420508;
	Tue, 9 Jun 2026 05:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZESugM
	OhTaltoGi7S5b9tGg+zWmprJ8SdomDsrK9xjI=; b=nhRzzKq3XWRMzV1OBxfq6o
	xhWMkKCECG0p/n/kThMJwhQ+d2ETCQDHZX/HaF0wJt1uFpqLiI4DXkLZbyRRLxJa
	JtWr4RZZnbWiHmATWPSKsNAnHANQZlskpA8GsfBNKqzRiCaw4eUh163AZCazZpEg
	1eEW3NYJi1xsG+B1eiHYIc26PDra2rqasOLGAH4EoCI3Ny3mjXf465tQTi2zhQv8
	i/V/l6gBd8cJeRuTrLd2/ecC71gI8SYPb3qtR1e88Aa+D1dfgNWFMMHwkDxa8aYt
	bQaKmU2y/FkaSBIKVnKkI9JsrH35oOlpP/NnCD/9BOB1lOdSa9Q4JhDxRuEpXbSg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye2dgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 05:11:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65954fkI032061;
	Tue, 9 Jun 2026 05:11:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjrfnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 05:11:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6595BiZX49611196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 05:11:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5284620043;
	Tue,  9 Jun 2026 05:11:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 893C820040;
	Tue,  9 Jun 2026 05:11:43 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Jun 2026 05:11:43 +0000 (GMT)
Date: Tue, 9 Jun 2026 10:41:55 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
Message-ID: <20260609103124.a7827206-22-amachhiw@linux.ibm.com>
Mail-Followup-To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
References: <20260608201001.65760-1-amachhiw@linux.ibm.com>
 <20260608202747.E521A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608202747.E521A1F00893@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA0NCBTYWx0ZWRfXzJuSyb9WYWiu
 fALS1LiVWXLxzDUWmbc1UoxDL2r3WJZDQPz4AeZ5sxRp+UEErsE9Ar+NaHO5e0wkruZ8Jwm+Uuo
 8k0udb0MqXn7iTqJrZsuX4RawGlHngddq7cZlOSno4M+qL8UHyP4+OnYCYQ3+fUhfHsT9Gxu5U+
 ftFQEbS2u4gcaUr+rc+J5+ZKll3i3oVYzKsljW2Ba5ePIpKopblhyz8Tnz2KmC2XcJ8+Kr0KvVF
 OmNnT1wJLJn/nipXbicRQPvGOsz7kNSTFS8c+bRH9JacT4wQHyxoxEsATRt4vmHjiwas4EPTjaE
 tnIhUG25CBaBVzkyK462eOa5xv/GVyTzTMBJUl153G5Qzbtjk+E1WnEy94mjhdtO0SRbqKJl45O
 1DiaKmViWsLfP8qJhC7bS1W16J0QjTp8hTsMDCmAN9m0Gea3bBHk/p7WpdkEjrZB4PQhSWnpmmX
 1LEVp48MwCxV7o+v+jw==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a27a094 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=jqxJ-K0nebAUikD8VG0A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: mM95Ee9CypC8p-gd4J-6pTkuVq78-kj3
X-Proofpoint-ORIG-GUID: mM95Ee9CypC8p-gd4J-6pTkuVq78-kj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090044

On 2026/06/08 08:27 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Unconditional dereference of `vcpu->arch.vcore` in `kvmppc_sanity_check()` causes a deterministic kernel panic for Book3S PR and BookE KVM guests.
> - [Medium] Bypassing PCR capability checks corrupts shared VCORE state on older architectures and inconsistently blocks sibling VCPUs.
> --
> 
> commit 8aae14bd53c26cd9bec6b3a9d75dc94d32e6e296
> Author: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
> 
> This commit detects unsupported arch_compat values early in the guest
> initialization path. It sets arch_compat to PVR_ARCH_INVALID and marks
> the vCPU as invalid, preventing the guest from running with an invalid
> processor compatibility configuration.
> 
> Cc: stable@vger.kernel.org # v6.13+
> 
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 61dbeea317f3b..f9380ef657500 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> [ ... ]
> > @@ -446,7 +446,19 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
> >  			guest_pcr_bit = PCR_ARCH_300;
> >  			break;
> >  		case PVR_ARCH_31:
> > +			guest_pcr_bit = PCR_ARCH_31;
> > +			break;
> >  		case PVR_ARCH_31_P11:
> > +			/*
> > +			 * Need to check this for ISA 3.1, as Power10 and
> > +			 * Power11 share the same PCR. For any subsequent ISA
> > +			 * versions, this will be taken care of by the guest vs
> > +			 * host PCR comparison below.
> > +			 */
> > +			if (!cpu_has_feature(CPU_FTR_P11_PVR)) {
> > +				arch_compat = PVR_ARCH_INVALID;
> > +				goto out;
> 
> [Severity: Medium]
> When jumping to the out label, the code applies the invalid arch_compat and
> a restricted pcr to the shared vcore structure before returning an error.
> Since vcore can be shared among multiple vCPUs on older Power architectures,
> does this state affect sibling vCPUs?

Setting arch_compat to PVR_ARCH_INVALID is intentional. The value is
stored in the shared vcore so that all vCPUs associated with the VM
observe the invalid compatibility state. Subsequent calls to
kvmppc_sanity_check() fail and prevent any vCPU from entering the guest.

> 
> While kvmppc_sanity_check() marks the current vCPU as insane, sibling vCPUs
> might retain sane == true. Could they then execute the guest using the
> updated pcr and invalid arch_compat state?
> 
> > +			}
> >  			guest_pcr_bit = PCR_ARCH_31;
> >  			break;
> >  		default:
> [ ... ]
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index 00302399fc37b..7e2d489af6423 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -258,6 +258,9 @@ int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
> >  	if (!vcpu->arch.pvr)
> >  		goto out;
> >  
> > +	if (vcpu->arch.vcore->arch_compat == PVR_ARCH_INVALID)
> > +		goto out;
> > +
> 
> [Severity: High]
> Does this code introduce a null pointer dereference for Book3S PR and BookE
> guests?
> 
> kvmppc_sanity_check() is a generic helper used across Book3S HV, PR, and
> BookE KVM implementations. While vcpu->arch.vcore is populated for Book3S HV,
> it remains null for Book3S PR and BookE guests.

Good catch! I see vcore is only set for KVM-HV and may cause a null
deref on PR and BookE. I'll introduce a NULL check in the next version.

# git grep "arch.vcore.*="
[...]
arch/powerpc/kvm/book3s_hv.c:   vcpu->arch.vcore = vcore;

Thanks,
Amit

> 
> During vCPU creation for PR or BookE, the initialization sequence sets
> vcpu->arch.pvr and calls kvmppc_sanity_check(). Because pvr is non-zero,
> execution will reach this check and dereference the null vcore pointer,
> which can cause a host panic.
> 
> >  	/* PAPR only works with book3s_64 */
> >  	if ((vcpu->arch.cpu_type != KVM_CPU_3S_64) && vcpu->arch.papr_enabled)
> >  		goto out;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260608201001.65760-1-amachhiw@linux.ibm.com?part=1
