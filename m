Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A364D596E;
	Mon,  5 Oct 2026 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222545; cv=none; b=RF/3buChqYPaEEq8B+2rkvZHL7SQpjxSwY4lTbe3wxdVixuVj2mJkhfsJF6ppcGmSS8JxUHix0RkBImrT2n0rvoY5/9qP1uWqMVf/ZAQXytxpvD8AUCPLK23F67RIjj04uOe6tvzEf/i2MoDlaOicB8TZq6w7Mli4cgBUZF69B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222545; c=relaxed/simple;
	bh=cTVEOTSX3L3eErrdq8mBnziN6GscpcdmpOcmhVNn+yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bz6K/SgdY8JW1AZuvY93t0j7VBuJyzEOlT2LQxxLk57Ayt1gHCkVCUFpJHE2476oyFzf2tBErF9RM/109vHJ8A75hGW4lOf3lFa0ee2cUAUgs0yjRBTuOtIGhsjNYaBMYwk9xi1CL0OTrTLK7kX8b8RQeEGVtmF0JFm5TTyhLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GmHrnuin; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GmHrnuin"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695HZg9j1131374;
	Mon, 5 Oct 2026 17:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t0RuP8
	msZqzgRqlx85iIGSCxZNORUlsqsomgArmKdjk=; b=GmHrnuinuiEpKcW3ahl+vO
	RqBwoRQkhYkL/sSduSkfPlegcuYkoa4BhacyYwiqyRiSEaL3UnDmn0dziYZYQ+Sx
	pFLkrFntlHYLLRJQhKytnfMqXEhpKNxZLUHCymdoVv7sqDs9RjIks4q956790BVm
	MZfDim6HENQjmLTV1XGiZiFivl34dHAAhZzlwacUB4VvF5v5sLMfxd+9LRUCzKuT
	uTTiaUau84eDSvhnLgB03EReetcgJxnQ3mvUCkDrQdXmcZHKFUIUToyjEn2O+9iX
	VtEm7AbshIH/UGe4XdduLxq3JyLkwW4No8AYZnECtKQmvjV4IBm/FNs4+MEXSPZg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jk9s2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 17:49:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695HMZnB3214612;
	Mon, 5 Oct 2026 17:49:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jpg57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 17:49:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695Hmw4550987486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 17:48:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 284742004B;
	Mon,  5 Oct 2026 17:48:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 496CE20043;
	Mon,  5 Oct 2026 17:48:57 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 Oct 2026 17:48:57 +0000 (GMT)
Date: Mon, 5 Oct 2026 23:27:08 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] KVM: PPC: Book3S HV: Add preempt_disable() around
 virtual-mode HPTE bit-lock users
Message-ID: <20261005232317.1da37e05-5f-amachhiw@linux.ibm.com>
Mail-Followup-To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
References: <20260930173750.56759-1-amachhiw@linux.ibm.com>
 <20260930173750.56759-3-amachhiw@linux.ibm.com>
 <20260930175243.54FF71F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930175243.54FF71F00898@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UkJWMhBC_IsVTAA7Fsrfl0Ip2ve4vUHs
X-Proofpoint-GUID: UkJWMhBC_IsVTAA7Fsrfl0Ip2ve4vUHs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2OSBTYWx0ZWRfX8aZs1Oax8UaS
 itqVNhonH7HcfoeuseftYel1nkLKU5be/sADWNeSiQ6usCeSakCgI+AbMnsBylOmyvLh8cWFri8
 zre37L46xs4LkZe6Kt4CU8ea6kdE+F8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2OSBTYWx0ZWRfX3oSrdgXTY3Go
 DgKUMWFIcVh/ZzcKye/95iBlSa1eSGPfVLZbuQMBbdNc2NNUsulUfvGn7laVsf3B5XHmeNty8ut
 Oww3q7EMYjKYWiE9w9VWtWiuBl0FY75rnC+QlI9SkgD66eEYbWBy1HWI2lHlKtWg90jKWrosXAW
 RWHNjPkp2FVImxRuEIUXFAcy6LYMrJRLfMtWLzsi/1Dgb0Zzuw0LWgrSfmGJHfijpyUWfjP7J5A
 8Lx8PvW3UAMdlYSMdKmH6NamDahzEl7rPK1B1xzVsr2Okne2JdzzLqejObceRoq8W/9rIDXgYlP
 Xy7WaZT8xRHo5Tq3z3E3QB/QsBjhnp7tSGZA8g9FG4KKujzp5uUNecwUrfDrbLcPuMOXf5clzj1
 AnVSuONGQZlZOesMf++a5D0ICdlrPl/1eHuoEQH+Pqi50ovMPoNlcX5XhXLLG4fCFeVkPj5tfob
 GymEjCq/5DGC5VvFHNw==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac3e30e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gvuWFeR2MmSz4E1sB28A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050069

On 2026/09/30 05:52 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] kvm: ppc: deadlock in lock_rmap() due to preemption guard in HPT hcalls
> - [Medium] kvm: ppc: resize_hpt_rehash_hpte() spins with preemption disabled
> --
> 
> commit 68aaf6c48f58de2d582ba27ebef746d63f655779
> Author: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-lock users
> 
> This patch adds preemption disable guards around virtual-mode HPTE bit-lock
> users in KVM PPC. This prevents situations where a lock-holding thread
> gets preempted, starving other threads spinning on the same lock.
> 
> > diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > index 2ccb3d138f46c..59da958e09cb4 100644
> > --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> 
> [ ... ]
> 
> > @@ -1219,6 +1229,7 @@ static unsigned long resize_hpt_rehash_hpte(struct kvm_resize_hpt *resize,
> >  	if (!(vpte & HPTE_V_VALID) && !(vpte & HPTE_V_ABSENT))
> >  		return 0; /* nothing to do */
> >  
> > +	preempt_disable();
> >  	while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
> >  		cpu_relax();
> >  
> 
> [Severity: Medium]
> The commit message states: "On failed lock acquisition the guard is released
> before the cpu_relax() spin so the lock owner can be scheduled."
> 
> Does this unconditional spin with preemption disabled violate that
> description?

Acknowledged.  The commit message description of the preempt_disable() guard is
imprecise for resize_hpt_rehash_hpte().  I'll look into clarifying it.

> 
> [ ... ]
> 
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index aa51968e206a7..0b7743bb89d9a 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> 
> [ ... ]
> 
> > @@ -1212,9 +1216,11 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
> >  	case H_CLEAR_REF:
> >  	case H_PROTECT:
> >  	case H_BULK_REMOVE:
> > +		preempt_disable();
> >  		idx = srcu_read_lock(&kvm->srcu);
> >  		ret = kvmppc_pseries_do_hpt_hcall(vcpu, req);
> >  		srcu_read_unlock(&kvm->srcu, idx);
> > +		preempt_enable();
> >  		if (ret == H_TOO_HARD)
> >  			return RESUME_HOST;
> >  		break;
> 
> [Severity: High]
> Does this preemption guard create a permanent deadlock with lock_rmap()?
> 
> For example, a host thread executing kvm_test_clear_dirty_npages() or
> kvm_unmap_rmapp() acquires lock_rmap() with preemption enabled:
> 
> arch/powerpc/kvm/book3s_64_mmu_hv.c:kvm_test_clear_dirty_npages() {
>     ...
>     retry:
>         lock_rmap(rmapp);
>     ...
> }
> 
> If the host thread is preempted while holding the bit-lock, and a VCPU
> thread for the same guest is scheduled on the same CPU, it can execute an
> H_ENTER hypercall.
> 
> When the VCPU thread reaches kvmppc_do_h_enter(), it attempts to acquire
> the same rmap lock:
> 
> arch/powerpc/kvm/book3s_hv_rm_mmu.c:kvmppc_do_h_enter() {
>     ...
>     if (realmode)
>         rmap = real_vmalloc_addr(rmap);
>     lock_rmap(rmap);
>     ...
> }
> 
> Since preemption is now disabled across the entire hcall by this patch,
> the VCPU thread could spin indefinitely on contention. It would never yield
> the CPU, meaning the preempted host thread could never resume to release
> the lock.

This is correct.  The v2 fix placed preempt_disable() just before try_lock_hpte(),
but lock_rmap() is acquired earlier in kvm_unmap_rmapp() and kvm_age_rmapp()
with preemption still enabled — leaving a residual window where a host thread
can be preempted while holding lock_rmap() alone.  I'll look into fixing this.

Thanks,
Amit
