Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6D2594BD;
	Tue, 11 Aug 2026 05:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786425858; cv=none; b=hg4qdybmTlv1pywSw+Pv2Fujj+KEjA9Iel0YTW5VRyCj+TR6aQEb+8dcMENEEgVYBJzevESgLEqjzjlu4NrlP5l4PIeQO8Icz4zuqFoDBfL5y+AsaIjHiotsDygG7aJATAdxHd6u3oZDAAdBgb71VNsApro+3sJqhvLxfrVcpbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786425858; c=relaxed/simple;
	bh=gwT9H6/yaCRuxIbs6fnWrmttzPX8WwDiR3PU+4u6iFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1NNnLas636sHD5iUYngWR3yNtWntLXU9iwWWOl+133UuN+iDAVhNVGBQijXI8F1PB3biyewDzrjHGBxHWrsJEMY2ekGZYXaKUCS6rfEMtSJmgQpqPHiKCpY994nOOKW1QCMjV0hTm/aqqqdCax/Ipk/HliPMQ1bOl8FtyMAcFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XSweaJFe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XSweaJFe"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AN1hXI1102063;
	Tue, 11 Aug 2026 05:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=kuI8KRKLaGX/wHvIyWMrLp/tQGq1BX
	SnitbWSD//1AU=; b=XSweaJFeIqS+vYbWL95wxRkvSm+krze/6cdC7q2QmbKDQQ
	f5fAUX3AyrNpRh7LOSxNJe1BAw+wQRKZ9XQhD6PgCEupg3XsZ5NTF9jcH//s2RJk
	7ZADtgPN+6Xlo3uUO0lJWdExGX6IGn5EsjcrI+79wtAhRaFEx4zjfA8F4TfobPst
	aaTg0DMZGWQngTTuoUZk9bm3ykqXISgfHGjqxz60rBlmsddQun9X7fNBHyI6+ld6
	ZFiUDVL2VPyp/9okB7w+Y9E7RaOikgOYXKFNGnSh/k7PmJp3ve530/Bfor93fvcW
	wNZh9AU5SWEUdxrBQ3CggjxFCLoIxeI9UJo44jtw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyuet6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 05:24:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67B5BHgQ016234;
	Tue, 11 Aug 2026 05:24:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g7hva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 05:24:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67B5O2Dw35586414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 05:24:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A040920049;
	Tue, 11 Aug 2026 05:24:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 476B220040;
	Tue, 11 Aug 2026 05:24:01 +0000 (GMT)
Received: from Unknown_32:98:3c:96:ca:91 (unknown [9.124.217.93])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 11 Aug 2026 05:24:01 +0000 (GMT)
Date: Tue, 11 Aug 2026 10:53:53 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] KVM: PPC: Book3S HV nestedv2: Don't drop pending
 doorbell across L2 entry
Message-ID: <anqx6XCDNMcP-Sva@Unknown_32:98:3c:96:ca:91>
References: <20260803034426.44249-1-vaibhav@linux.ibm.com>
 <anm0x87QdleHJkCi@Unknown_32:98:3c:96:ca:91>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anm0x87QdleHJkCi@Unknown_32:98:3c:96:ca:91>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA0MCBTYWx0ZWRfX9NVrIOoAH8UT
 ATRB85d2IBgJKs6lRBygliKX9orUCad6/sbF3Hj7LQnVPGmv3FYPu8+8ZITotYdxnZ71t0oTDTL
 6JpJgd2M0AXKn4fRF8qH4SyOBA8aY9oAdDOtoffCUiB3tvX7gauroEarv1Nw/rhOyY5uTtk0u1g
 fckIUh1vINSIWWMvgJHsYsU+jNS9cZdW2xLa1sSAZAOyVpqaw2h6cAv+y9Uitjfoc+m0p8k8+LZ
 gwwUPY0W6b4l8mkhnaCr8ebyU6zITLK1uh2AMIGkNwS5hzawRss0jxq97+1p9uHeNRRYi7A4AVr
 /F2nDZssvdBlaeZ2NkkO392+PriALwanL4jkPvCeGZH2EeXea6I6JG6S8sSqPY2VQjjCBcZ4Eph
 EVRtIFxlapM9v7BcHplfsA4S+m1rs/qGB54HbP8Kqe73Krl6SdXvaR4fyu+zj4kH2uPdLEmyfyr
 4Gh1eqYfU2+Nvl1lzhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA0MCBTYWx0ZWRfX5TRNlsatnwAB
 aiWVQ2cXeq5cJ0M+zVc/HkZtK2gbVhWV/fia4+OavAIlA+YruzhGO1uB6wlpOeL/J2iov+psRaA
 MMC8Dzd2OHArtoXuLrhmQtIZjS2/BAE=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7ab1f7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Bgcttdl6W-Z8whbBMOsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: j5iZr9XWsGvqXfNV7HnHNbNQ54ogsGX7
X-Proofpoint-ORIG-GUID: j5iZr9XWsGvqXfNV7HnHNbNQ54ogsGX7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110040

On Mon, Aug 10, 2026 at 04:54:18PM +0530, Gautam Menghani wrote:
> On Mon, Aug 03, 2026 at 09:14:25AM +0530, Vaibhav Jain wrote:
> > On nestedv2 the L1 converts a pending doorbell into guest DPDES state at
> > the top of kvmhv_vcpu_entry_nestedv2() and immediately forgets about it:
> > 
> > 	if (vcpu->arch.doorbell_request) {
> > 		vcpu->arch.doorbell_request = 0;
> > 		kvmppc_set_dpdes(vcpu, 1);
> > 	}
> > 
> > Clearing 'doorbell_request' at this point assumes that handing DPDES to the
> > L0 is equivalent to the L2 having taken the doorbell. That is not true, and
> > the doorbell can be lost in two ways:
> > 
> >   - The block runs before the lazy_irq_pending() check, so the doorbell is
> >     consumed even on the path that returns 0 without ever calling
> >     H_GUEST_RUN_VCPU.
> > 
> >   - DPDES stays pending in the L2 until it is actually delivered. The L2
> >     may exit for an unrelated reason (hcall, page fault, HDEC) with the
> >     doorbell still set, typically because it was running with MSR[EE]=0.
> >     Nothing reloads DPDES afterwards, so the L1 never learns this.
> > 
> > Once 'doorbell_request' has been cleared, the L1 has no record of the
> > pending doorbell. kvmppc_doorbell_pending() returns false, so
> > kvmppc_read_dpdes() reports the target thread as idle when a sibling vCPU
> > emulates 'mfspr DPDES', and the vCPU can be treated as having no work
> > pending and blocked. From the L2's point of view the doorbell is silently
> > lost, which shows up as an SMT guest hanging on a doorbell-based IPI.
> > 
> > Fix this by making 'doorbell_request' track the L2's DPDES rather than
> > being consumed by entry:
> > 
> >   - inject DPDES after the early-return paths and before
> >     kvmhv_nestedv2_flush_vcpu() serializes it into the vcpu run input
> >     buffer, and no longer clear 'doorbell_request' there,
> > 
> >   - after H_GUEST_RUN_VCPU, reload DPDES from the L0. The run output only
> >     carries the state the L0 chose to return and the 'valids' bitmap is
> >     zeroed on exit, so an explicit kvmhv_nestedv2_cached_reload() is
> >     needed to see the L2's current value,
> > 
> >   - if DPDES is still set the doorbell was not delivered, so keep
> >     'doorbell_request' pending so that it is re-injected on the next
> >     entry; otherwise clear it.
> > 
> > This keeps a pending doorbell visible to the L1 for as long as the L2 has
> > not consumed it, so vCPU wakeup and DPDES emulation on sibling vCPUs stay
> > consistent with the L2's actual state.
> > 
> > Fixes: 54ec2bd9e017 ("KVM: PPC: Book3S HV nestedv2: Fix doorbell emulation")
> > Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Assisted-by: Claude:Opus-5
> > ---
> >  arch/powerpc/kvm/book3s_hv.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 61dbeea317f3..40f8717b8a7d 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -15,6 +15,7 @@
> >   * by Alexander Graf <agraf@suse.de>.
> >   */
> >  
> > +#include "asm/guest-state-buffer.h"
> >  #include <linux/kvm_host.h>
> >  #include <linux/kernel.h>
> >  #include <linux/err.h>
> > @@ -4253,11 +4254,6 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
> >  	int trap;
> >  	long rc;
> >  
> > -	if (vcpu->arch.doorbell_request) {
> > -		vcpu->arch.doorbell_request = 0;
> > -		kvmppc_set_dpdes(vcpu, 1);
> > -	}
> > -
> >  	io = &vcpu->arch.nestedv2_io;
> >  
> >  	msr = mfmsr();
> > @@ -4265,6 +4261,9 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
> >  	if (lazy_irq_pending())
> >  		return 0;
> >  
> > +	if (vcpu->arch.doorbell_request)
> > +		kvmppc_set_dpdes(vcpu, 1);
> > +
> >  	rc = kvmhv_nestedv2_flush_vcpu(vcpu, time_limit);
> >  	if (rc < 0)
> >  		return -EINVAL;
> > @@ -4296,6 +4295,17 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
> >  	if (rc < 0)
> >  		return -EINVAL;
> >  
> > +	/* Check if privileged door bell was requested and handled */
> > +	if (vcpu->arch.vcore->dpdes) {
> > +		kvmhv_nestedv2_cached_reload(vcpu, KVMPPC_GSID_DPDES);
> > +		if (vcpu->arch.vcore->dpdes)
> > +			vcpu->arch.doorbell_request |= vcpu->arch.vcore->dpdes;
> > +		else
> > +			cpu->arch.doorbell_request = 0;
> 
> This is a compile error, should be "vcpu->"
> 
> 
> > +	} else {
> > +		vcpu->arch.doorbell_request = 0;
> > +	}
> > +
> 
> I think this entire block after vcpu exit can be reduced to just
> 
>     if (vcpu->arch.doorbell_request)
>         vcpu->arch.doorbell_request = kvmppc_get_dpdes(vcpu);
> 

Gave this a bit more thought - this can miss the doorbell that was sent
to this vcpu while the vcpu was running. I think the below code should
work fine:

     if (vcpu->arch.doorbell_request) {
             vcpu->arch.doorbell_request = 0;
             kvmppc_set_dpdes(vcpu, 1);
     }

     rc = plpar_guest_run_vcpu(...);

    /* Restore the doorbell status and also account for the doorbell
     * received when this vcpu was running */
     if (vcpu->arch.vcore->dpdes)
        vcpu->arch.doorbell_request |= kvmppc_get_dpdes(vcpu);


- Gautam
