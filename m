Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180A24A1E0F
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 05:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790056771; cv=none; b=ht9mPl/HEw/wKHtqJVCh5/AjLvoxObVyo6Q1n1AZzbX1lvkLGuWCZuiVc2aej1b+yKJPAcE8aAQ6x5BdUeAtgMv6s8d98xkp+BwZGyZe3iKS2O+bFrqixUZKZ10M/NtH1oqU55Y+3xtkSFEmZYKt8gn7lYGArcMhcmt1+AgM5nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790056771; c=relaxed/simple;
	bh=IubJ/xAJ7gQJ992bRuafKmN8ihKxmqpgMVtGVau5Zl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRfbhg5PEei50O6a0FjD5itXqDznIX/BF9H4UVl9uDQgbtZgSd20/58NzkgERbN6Xfsqd1roemR0ekaxurMBK7WVZUVver+CHLDu7uuNUVGRbuom177N+T3bXYrIVKXH7Fz6VQlolI7IPPoQLXjrU0+rtxi3KzPn0bMEcHLv8ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jmGcaSdS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jmGcaSdS"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M06N0r2982139;
	Tue, 22 Sep 2026 05:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/CgOOA
	FoHJJXq8KyAObLLcMnmhG5iWqYQKZpygX589c=; b=jmGcaSdSp5/a2s4vAd1li8
	OyoNRmQ4CSzozDg8ltJhVIaLEkw9kKs7aTHeVNODSO7yuj0gISi+Y4Hr8DyAeEWW
	hH8DF/cPluPCrpDtphMi1fASm//iDrFCeMAKD4RyZsvSy2BiJpok0yIhChLJ0Qr0
	q5EH9LCTvHfrkodU1M5ROIcYOPWtwoFPjM1Z51M88vcTYppBIYmAgbd5CtT3ncH5
	TQMWuF0e88BQt9s37b/gy2mGeiBpk9YjyK7yTmXf/gNR7nUFNcaE6yfByEPocrpz
	fSDfTzA6lk7FaR7xI+FrerVQ2KUHouzol3cYUm9VHyKVTsySo/Qg65BgOIJ93eQA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv3x9x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 05:59:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68M5UjLG2085698;
	Tue, 22 Sep 2026 05:59:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq8n77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 05:59:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68M5xHwf47383020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 05:59:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97F3720043;
	Tue, 22 Sep 2026 05:59:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61AA920040;
	Tue, 22 Sep 2026 05:59:16 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.39.19.247])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 22 Sep 2026 05:59:16 +0000 (GMT)
Date: Tue, 22 Sep 2026 11:29:28 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Avoid spurious interrupts caused
 by LPCR_MER bit
Message-ID: <arIXVvCG1xipFnnt@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20260921111043.49825-1-gautam@linux.ibm.com>
 <20260921112538.ED7101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921112538.ED7101F000FF@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WDeimTp8R-6Ld2nIvyo7j80XWZb03_2F
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA3OCBTYWx0ZWRfXxshE52VIu1nB
 b3a2uN2qaM6WwSpW/QKQWgg5DPfIwfyBY8ZFKcJX6Uzni5xMzm9uHMTyOfp9wTiwxz6nuip1zV3
 ghvfSoSQ7EWp5PEwqgv13113e6o3+Ac=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab21938 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=yKAn6K1XAAAA:8 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=iDXJWKRIO_aAfW5byYkA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=6M1ixcW_PCWoKiWyFx5v:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: WDeimTp8R-6Ld2nIvyo7j80XWZb03_2F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA3OCBTYWx0ZWRfX2T5I6yil0jlD
 TJ2tRgC/SZLbS9o/qxHFi9hrx/m6Tm9UQ/zOnJhK2NxC8YjxZL/BNx6QN8EnXMc1+8jwaYdIIpb
 dnGqMnANvYiJxCs4Cc8I26ENcMkBElu+nUc1b3fFjQj6OJhmLrPRSRU+NZwdmerBJX9+adSTSOj
 lnpETUwWnmS+0KVTVQ2gucz1Qpu0aTZd3Vdah1TNlok9PBjOh1PRecCiSIm+E+t89pxAz6g0mUU
 BpeOIQ7DIVT6/dx/l9lfp8WG+f9ag6eTSO/ubbBLEK+LlQ3Ztbes7k06yefhTUKBAK5zmCxPtuj
 0JvIi+aLZ9ulWZQcqIkHy9GICCF0dqlqOKs0wYS6aPrjkwnU1pGylhfPs6/8t70XxOijX6p/i6U
 vlj0WpNCrTy4Lom3vdPXSzPhfh1hJSiopMFSNKcJN5M/i+I6PUSi/Y8Sd5Itmk0CeO6Zgq4DngF
 zfZRO8P4BQvXckhHAtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220078

On Mon, Sep 21, 2026 at 11:25:38AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kvm: ppc: lost LPCR_MER interrupts for XICS due to XIVE state leak
> --
> 
> commit 215dda3f95780a965ce67c9c452b6f7d1948e486
> Author: Gautam Menghani <gautam@linux.ibm.com>
> 
> KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit
> 
> This commit avoids spurious interrupts for KVM on PowerNV guests by not
> setting the LPCR_MER bit when native XIVE is available. It introduces a new
> helper, kvmppc_xive_native_enabled(), to check for native XIVE and skips
> setting LPCR_MER if it evaluates to true.
> 
> Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
> 
> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> > index 169ea6a7fbad4..580ad2548c2bf 100644
> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > @@ -747,6 +747,11 @@ static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
> >  	return vcpu->arch.irq_type == KVMPPC_IRQ_XIVE;
> >  }
> >  
> > +static inline bool kvmppc_xive_native_enabled(struct kvm *kvm)
> > +{
> > +	return kvm->arch.xive_devices.native;
> > +}
> > +
> 
> [ ... ]
> 
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index dbac3573b2c89..cb2bb29451a7f 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
> >  			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
> >  				kvmppc_inject_interrupt_hv(vcpu,
> >  							   BOOK3S_INTERRUPT_EXTERNAL, 0);
> > -			else
> > +			else if (!kvmppc_xive_native_enabled(vcpu->kvm))
> >  				lpcr |= LPCR_MER;
> >  		} else {
> >  			/*
> 
> [Severity: High]
> Does kvmppc_xive_native_enabled() accurately reflect whether XIVE is currently
> in use?
> 
> If a VM switches from XIVE to XICS (such as during a kexec or CAS
> renegotiation), the XIVE native device is destroyed. However, the native
> pointer is intentionally not cleared:

The kexec case is not supported for guests - booting a KVM guest in XIVE mode and
kexec to XICS mode.

> 
> arch/powerpc/kvm/book3s_xive_native.c:kvmppc_xive_native_release() {
> 	...
> 	/*
> 	 * A reference of the kvmppc_xive pointer is now kept under
> 	 * the xive_devices struct of the machine for reuse. It is
> 	 * freed when the VM is destroyed for now until we fix all the
> 	 * execution paths.
> 	 */
> 
> 	kfree(dev);
> }
> 
> When running in XICS mode after this switch, kvmppc_xive_native_enabled()
> will continue to evaluate to true.
> 
> Will this cause KVM to bypass setting LPCR_MER, and subsequently fail to
> inject external interrupts when MSR_EE=0, resulting in a guest hang?

No. If LPCR_MER is not set, the only effect of that is the vCPU will have to
exit to the host for the host to inject interrupts into the vCPU. One
extra exit isn't a big deal.

> 
> Could this check instead evaluate the active vCPU IRQ routing, for example by
> using !kvmppc_xive_enabled(vcpu)?

kvmppc_xive_enabled() does not check for native/irqchip=on case. It
returns true even if emulation is used.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260921111043.49825-1-gautam@linux.ibm.com?part=1
