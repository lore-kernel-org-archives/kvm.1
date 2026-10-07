Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C93DAAD2;
	Wed,  7 Oct 2026 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400957; cv=none; b=LrbEr2LwHA7ekSlGKBgnjXF+m0yl+1GjVQC2JCGGwmX6vAQpJ2/E7fSlrTnOfOf6eRtKk8wd9yE72GtNtCcCnLhenhzouNAfVR3h0Zm8qGdegY2Y1/mkT5b0z/RbpvXAha9QoWRRa37K+jG9SjOPMx4hd0nBSZRZjcKepobfuAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400957; c=relaxed/simple;
	bh=EBv+bmpOjW84niDSOeA22RRBhR28nmW1Gk9EMDEwYz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amYvfrNtuGjjK0VjhBlsDjkyDUL4PicH4njAsGzgHIkJ956Kef/837PnXgtJIK7i3ppQIiGfpXfIowe4ndB8bFOlpg46ts1B9vYMLhT1BAjf21X0r/7p995v0bZOkffZ/ORuennPyq9qQWkDRqt13Du6CytdJZpHZixuRhJoJe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XknvvGxo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XknvvGxo"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697IZPjx3356409;
	Wed, 7 Oct 2026 19:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+oPKf8
	szb4wyjb8A3Cm41T1jdnmda4EAW9uO9NKDYVk=; b=XknvvGxoX47la9pjYEGJGC
	/SSNDzLDZUO4BDL+JtXhDxEVzAFsUKW3YbezOEWjdR95vnW5CxckqPTxK+sM9ygb
	pavxAIy8QCUkYhIH5W3RjhRNhlRY83TzDhaJL6nIbsfLIT6ABzl/idVloDE7Yqtm
	I5Ftjh1Bhr7HoJw1NurevUtpAHweYfc1Aer6tXEzVI/U2iEqtZGItBVLhVmqnHbN
	AnL32eqG8HfpgMPH/m3XX6slUHFkI5E7GifU1uiLBS4cZx9AgbqhY4AZjnL/ya3c
	toX/NlFReaXSklO1Q4yf40yeMM33pk8LsMVyv01xklYAsJ53KzTV8XAUDbfx4G1A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74yjw2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 19:22:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697IHelu2265523;
	Wed, 7 Oct 2026 19:22:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ek4a63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 19:22:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697JMVpF12255672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 19:22:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8F8020043;
	Wed,  7 Oct 2026 19:22:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 162CA20040;
	Wed,  7 Oct 2026 19:22:30 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  7 Oct 2026 19:22:29 +0000 (GMT)
Date: Thu, 8 Oct 2026 01:00:43 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 2/3] KVM: PPC: Book3S HV: Add preempt_disable() around
 virtual-mode HPTE bit-lock users
Message-ID: <20261008005700.c78e5a18-dc-amachhiw@linux.ibm.com>
Mail-Followup-To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
References: <20261007182116.12479-1-amachhiw@linux.ibm.com>
 <20261007182116.12479-3-amachhiw@linux.ibm.com>
 <sashiko-outbox-163301@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-163301@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T4PTW3pnENmozDTc5dlJAS-ZpNw5mqjT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3NiBTYWx0ZWRfX1Nok+YejS322
 uXiOJ4vXaXfpWtnfBF9QdR5wtV8jkOFy32El7iTlMWso8NznqysZkuZwomKjs2M2SmxMUnH60ML
 xGcwuakyEkdA3sZ7MpZF+Qrz/XpARZ8=
X-Proofpoint-GUID: T4PTW3pnENmozDTc5dlJAS-ZpNw5mqjT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3NiBTYWx0ZWRfX5ipEONDjzex+
 NbYMXeqD+ZXy9VLeQ4URx3loB0tzq1GLoVbQMZhrsV5xlEXq39j0jOVGZi+JyeISw7PTDo2x2N+
 5azIFBKxx24o52GekwTRj1gxAYAKXjVWqY5O1Vi6p6yWwIEoJ50q0yOc2wl0Q8QXy0LvJ/vNFph
 j9AFArkHpxKWJmIn+8MGgFVYY3Z+csP0Qr+DOQ9N/lE5Ui0sUsbraFRMiZgG3HUjShjBDhMfrQ+
 4fpWkFvk0fVLkqRd0MWy6pJW7zYVZQwTIq9wFSV92WS+ZdNUQIHLfEX55EoisKmjcgeWMN8RK/S
 kw0WmHHHv4MznIOb7NnqbBw+pko2K32YzrRqn7GzPxW/97aAHgqf1mi+f0XrGSistz1v0yrC3Mo
 LMZkJYYvj0FqWOWM9FGC9Jp0NZwHRe/pgAgO0nOQOauQGmtJXPeu2dwd71O48pWmkMwboY4RWcf
 cOan0dHVo+oqfsS6qrg==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac69bfb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=DKcAYAtLK8KsSAPX9gUA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070076

On 2026/10/07 06:47 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kvm: deadlock in kvm_test_age_rmapp() due to missing preempt_disable()
> --
> 
> commit 6b1add31442320e6307f450d080fd72f64ee2368
> Author: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-lock users
> 
> This commit enforces that threads acquiring HPTE or RMAP bit-locks run with
> preemption disabled to prevent CPU hangs. It adds preempt_disable() and
> preempt_enable() pairs around various bit-lock acquisition paths.
> 
> > diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > index 2ccb3d138f46c..e8f73c8f97803 100644
> > --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > @@ -890,6 +913,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
> >  
> >  	rmapp = &memslot->arch.rmap[gfn - memslot->base_gfn];
> >   retry:
> > +	preempt_disable();
> >  	lock_rmap(rmapp);
> >  	if (*rmapp & KVMPPC_RMAP_REFERENCED) {
> >  		*rmapp &= ~KVMPPC_RMAP_REFERENCED;
> 
> [Severity: High]
> Does kvm_test_age_rmapp() also need to disable preemption before acquiring
> the rmap lock?
> 
> Looking at arch/powerpc/kvm/book3s_64_mmu_hv.c:kvm_test_age_rmapp():
> 
> 	lock_rmap(rmapp);
> 	if (*rmapp & KVMPPC_RMAP_REFERENCED)
> 		goto out;

This is not an issue on powerpc; here is why.

kvm_test_age_rmapp() has exactly one call site:

    kvm_test_age_gfn_hv()                 [book3s_64_mmu_hv.c:1020]
      <- kvm_test_age_gfn()               [book3s.c:896]
        <- kvm_mmu_notifier_test_young()  [virt/kvm/kvm_main.c:864]

Inside kvm_handle_hva_range(), the handler is invoked only after
KVM_MMU_LOCK(kvm) at kvm_main.c:626, which on powerpc expands to
spin_lock(&kvm->mmu_lock).  mmu_lock is a spinlock_t
(include/linux/kvm_host.h:774), and spin_lock() calls preempt_disable()
internally.  By the time kvm_test_age_rmapp() acquires lock_rmap(), preemption
is already disabled by the outer mmu_lock acquisition.

The lockless path in kvm_handle_hva_range() (line 625, gated on
CONFIG_KVM_MMU_LOCKLESS_AGING) would bypass KVM_MMU_LOCK and reach the handler
with preemption still enabled.  However, CONFIG_KVM_MMU_LOCKLESS_AGING is
selected only by x86 and s390; powerpc does not select it, so this branch is
dead code on powerpc at compile time.

No additional preempt_disable() is needed in kvm_test_age_rmapp().

~ Amit

> 
> This MMU notifier callback still acquires the KVMPPC_RMAP_LOCK_BIT without
> disabling preemption.
> 
> If a thread is preempted while holding this bit-lock, and another thread on
> the same CPU begins spinning for the same lock with preemption disabled
> (such as in the newly patched paths), couldn't this result in a permanent
> CPU hang?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261007182116.12479-1-amachhiw@linux.ibm.com?part=2
