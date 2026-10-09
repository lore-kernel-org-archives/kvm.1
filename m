Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3742868AB
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534082; cv=none; b=j6CN20UhnGZzKu3UasijRU/zOsCvJbvMfsJCQJG3gAYBrUiOTLU6Quo1xjTPZBrYoQWyFjq3V1fNOLEvOSkVIYKCKlCIjq8EEWmdGKfXvUCdwYJ+pF5gDNWPenoZti4b0UmtD/N8KyA8+OxfT+rRAKS9H4nlhc3BmyInpEAyBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534082; c=relaxed/simple;
	bh=7NX2Tcj00ESmCKdE+4gjub5XJfqX21W272pBIID4UNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lszvq+zLP8S4h0Txg2wxu1r7AgekN5Li+edmA8V0W11sIXJJW3nzbDXuCLA4dhFzFojS7m2x7nxa7ibhhMEtt3S8KTzFM9/M8jIzZNW4yUqzf2pivP6oA0NOvBojXMweTk4sX/JzKUXrULGrQEnncYR+z9mHq6Em6elbP+faXXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DAnEm91B; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DAnEm91B"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993ZXkx3209136;
	Fri, 9 Oct 2026 08:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hY8FSnfUfzlRPPNGy71tUlOb+ePsVA
	7YZyLQAXOTbUg=; b=DAnEm91Bo5y9xoPTTXSQeLRxtLrrw6phm9lhPG2UVwkv8C
	hTCNqOfyr3dnXQNAROSYaTSyt9oDotF8TW83w2Ag1tnmLiZLcE3BnXHZgyYo6NKH
	zYT9RT5WoaYKjfz4rRfMNNAHZqEgk04XjLlGmWfNhXaP9v20UHPCikwYFm6PTG7N
	xbNSJQqssjny01klGsWZ9CDhJaw55tJR+yMXcgg+AdRlRHef+dI6oiCOCQ0XgcSd
	fLK28Twencp0U+Y85smx6hjXx9ApRC6fUPLpHmS0r64ROCopEl3+PvUDjxUwus2w
	DzqMH+Geqj6OKTArXjwjdOrV/+T/9rHUN9HTGcSA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvrr08-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:21:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I0GY620189;
	Fri, 9 Oct 2026 08:21:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6du27s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:21:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6998LCsw34668826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 08:21:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 375E820040;
	Fri,  9 Oct 2026 08:21:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 181292004E;
	Fri,  9 Oct 2026 08:21:11 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.39.24.32])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 Oct 2026 08:21:10 +0000 (GMT)
Date: Fri, 9 Oct 2026 13:51:08 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] KVM: PPC: Book3S HV: XICS: Update irq_type for
 cleanup to work
Message-ID: <asiitdl00RI1Zoa2@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20261001100208.1271628-1-gautam@linux.ibm.com>
 <20261001100208.1271628-3-gautam@linux.ibm.com>
 <20261001101052.42CBB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001101052.42CBB1F000FF@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AIdLPwtHnKJomSIpz-l8bbXvXfFV_5qT
X-Proofpoint-ORIG-GUID: AIdLPwtHnKJomSIpz-l8bbXvXfFV_5qT
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac8a3fa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Q5Jx9UpPnlvGt3Uw_04A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfXwOaOhNGIOcw1
 yL4uTntRjYJ10xSZC9XTr0ZgsZ4WvdhaXk7l6gxgOrK3G/FeBuagUUFhrqTpPJ/TeeaSd669ZBW
 jtj6DUVbjM9YnplHrtZXXDAzQfF7GX8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfX+CWQXtSPYVrc
 46HuuOiLR4xEqTxz9LYrjgHt+5lGVnTY8lBD0M8+S5O0fR+uCqWltpEBLgGXEE0wpei+6wqDsIa
 p0E8etBIC0ZR36ARyCTyPMLAxUmeNAXSNvwwUiXDTWkd4uwcnqbcRGTjmaKzfEDVaYv34tEQey0
 9da518IwsKXKBDairKL+COaqEZ2RDPFhyjLQB+fsC1QNHiKnpHP6dY53yKRGeU126qJOX36IUEz
 Q7s/bLa7hTSetWPgb2zrIIFOQ0EapVAO+YpNR4ITIQT+FCeuEc3dKMTAW2qgLy63Ph1Jo4c5lth
 KPvrXPIivtB/6PuOUeB5A+X/ZX0zCw44J2YvDpXggGtyKygT3g/XzVMWf7RMwvAkHgdOSD+22Hj
 pCoNMCi5J2C1KPT2S2CZ6Shy+nxaWRiNW6yqUcA/DiERBXJuWlgtqCa1YidwojeZae0cK05XW4w
 8otfLKMaGKNS6hSRSjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090032

On Thu, Oct 01, 2026 at 10:10:51AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] xive: host kernel panic in kvmppc_xive_cleanup_vcpu() due to uninitialized eoi_mmio
> --
> 
> commit 2d2dc3956268ca839bb2cf6d3521ccdcf2a1831b
> Author: Gautam Menghani <gautam@linux.ibm.com>
> 
> KVM: PPC: Book3S HV: XICS: Update irq_type for cleanup to work
> 
> This commit updates the assignment of vcpu->arch.irq_type to occur before
> vcpu configuration starts. This is intended to ensure that
> kvmppc_xive_cleanup_vcpu() can properly execute if early setup failures are
> encountered during kvmppc_xive_connect_vcpu().
> 
> > diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
> > index 1d67237783b71..67219044fb8c7 100644
> > --- a/arch/powerpc/kvm/book3s_xive.c
> > +++ b/arch/powerpc/kvm/book3s_xive.c
> > @@ -1937,6 +1937,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
> >  	xc->vp_id = vp_id;
> >  	xc->mfrr = 0xff;
> >  	xc->valid = true;
> > +	vcpu->arch.irq_type = KVMPPC_IRQ_XICS;
> 
> [Severity: Critical]
> Could this cause a regression where an early failure leads to a host
> kernel panic?
> 
> If xive_native_get_vp_info() or xive_native_alloc_irq() fails shortly after
> this assignment, the code jumps to the bail label and calls
> kvmppc_xive_cleanup_vcpu(). 
> 
> Because irq_type is now KVMPPC_IRQ_XICS, kvmppc_xive_cleanup_vcpu() no
> longer bails out early, and unconditionally attempts to mask the VP IPI:
> 
> kvmppc_xive_cleanup_vcpu()
>     /* Mask the VP IPI */
>     xive_vm_esb_load(&xc->vp_ipi_data, XIVE_ESB_SET_PQ_01);
> 
> Since xive_native_populate_irq_data() has not been successfully executed yet,
> xc->vp_ipi_data.eoi_mmio is still uninitialized. When xive_vm_esb_load()
> is called:
> 
> xive_vm_esb_load()
>     val = __raw_readq(__x_eoi_page(xd) + offset);
> 
> Would this dereference the uninitialized eoi_mmio pointer and cause a
> fatal page fault?

Yes, this is a valid bug. I'll fix it in v2.
