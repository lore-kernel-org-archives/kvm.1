Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E09320CAD;
	Tue, 28 Apr 2026 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363402; cv=none; b=KbIzZVHHC+6ZKEKCkrOHI7XCmO2T5l6Lf1SSi8rlT7JAbSrEeDFhYXtIvV+BWZdaWgw0kscrqp8NJcD2D1W35oecPRYgCrjAtddrTI/3S5Ok1UJWtDRjl+GZzc/KHnxKyEtZfj9NwrWA0tAK57o8l++MQ45ouOoWJenV+kd/cA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363402; c=relaxed/simple;
	bh=jCWrQkTXboxOoUS/fG/K8UK5bDgLyCq2iAt9QGU806U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixQ11ekU+uaHC7FdIHiQI6cUsS9oLEWrb4giwgECj1uqHb/y0As44CP/RFsrUiuUg/KN88+JL4z3RvnEMCpyvv33G+Xjqj8TtwJBTUYu7D5FtDee5DKijZR4BKWjomzdOweLuq/whYM1xiIR2Es4djXahzetoNBDy8GcEdxREQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e7yjLDcV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e7yjLDcV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S5amEN3291685;
	Tue, 28 Apr 2026 08:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XRcKvfubTgnuYoZj4RDFyohZ+1R2Yu
	cxZPqp34BQZnE=; b=e7yjLDcVpVP//dUIGRUfKiaW3AofLwuFI1KixYefDQvn1C
	Jikds/dF8unsSwOGa13KMTj8oImIpIjuTjshRawhECDnHLCRbAuja+OwllUrqYC6
	dGl8e0MTh1R3DRJCkVeBUKMtbozLMWFae9g9dzjkxO50nUlQ5QllU90+eal93J0F
	XfVFbKflAKWbqyZ1SsfNv/u3r3rpsDTd381LJ+wBAWrcIswCGcIzff7sEO/xykfj
	ORgqHDriwfDOBmAPJumWfSItt445i3K6s1SZIFuo44YFYPCqZd4BOH0+IxuC8gLr
	V66tR+gJPtJkO7a2yhGPE+pT1ot6WXSDHZFK2+0g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jkh3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:03:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63S7umBN007149;
	Tue, 28 Apr 2026 08:03:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamy8hgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:03:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63S831FC42991966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 08:03:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64EC520049;
	Tue, 28 Apr 2026 08:03:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80A0220040;
	Tue, 28 Apr 2026 08:02:59 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.36.19])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Apr 2026 08:02:59 +0000 (GMT)
Date: Tue, 28 Apr 2026 13:32:52 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Gautam Menghani <Gautam.Menghani@ibm.com>, maddy@linux.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Add H_FAC_UNAVAIL mapping for
 tracing exits
Message-ID: <afBprGx5SaaaW7sP@Gautams-MacBook-Pro.local>
References: <20260424092558.31798-1-Gautam.Menghani@ibm.com>
 <lde9s0qx.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lde9s0qx.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA3MSBTYWx0ZWRfX4AyHZNupc10o
 3ql5+Db1qvJOyb/RKA3nP++MXijpO8TDtpbe7o3mfu5NYXnhzfjbh+asK8cyLi+XYI1J/kLgHIh
 fQK7+ei/lZfVwGAKJj6vEGigeZ+0kZvdV5c1XkB1sa1fAtQ8+qNxgQb3WSjkCzVjKPvDqnqabCy
 jx3AutnIQDLlOpapfRDfPWTjxWDQfDWtWzE3IJHyACzyV1yATCHHWUrmdhMieutk7/LuDCoHej/
 jWVPQU1UC7lrc2MUPZRYAjUZEssvYybYz73qlvAMYEaic0R1fq5g9jPAsTQIgSxWdNpy69Z+ubV
 imoWRmf+rGWlHsmhC4zZ0jRXNEA50yJswSz66qwUUwHAtmY9UCyV3wqJCrny8bxi6geMTbOjRO2
 EefhXnmfoSCZVqsgp+DdQFX/VS2ELgybnBE76gQTS5wjNZySnyqwUjYmdNc3YHVi8QvAWBvR6Fp
 YgO7hB+pyYRuDutOWFg==
X-Proofpoint-GUID: pCRF3-F9OXIK5D9Hv3mU3ryuljJo7swI
X-Proofpoint-ORIG-GUID: A977XpbCjYmlkOhW-XMxRyVCjo2aNFvF
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f069b8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ekTaQhlKxMoBV4_VeZsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280071

On Mon, Apr 27, 2026 at 06:00:46AM +0530, Ritesh Harjani wrote:
> Gautam Menghani <Gautam.Menghani@ibm.com> writes:
> 
> > From: Gautam Menghani <gautam@linux.ibm.com>
> >
> > The macro kvm_trace_symbol_exit is used for providing the mappings
> > for the trap vectors and their names. Add mapping for H_FAC_UNAVAIL so that
> > trap reason is displayed as string instead of a vector number when using
> > the kvm_guest_exit tracepoint.
> >
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > ---
> >  arch/powerpc/kvm/trace_book3s.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/kvm/trace_book3s.h b/arch/powerpc/kvm/trace_book3s.h
> > index 9260ddbd557f..eafbaeb5a9db 100644
> > --- a/arch/powerpc/kvm/trace_book3s.h
> > +++ b/arch/powerpc/kvm/trace_book3s.h
> > @@ -28,6 +28,7 @@
> >  	{0xea0, "H_VIRT"}, \
> >  	{0xf00, "PERFMON"}, \
> >  	{0xf20, "ALTIVEC"}, \
> > -	{0xf40, "VSX"}
> > +	{0xf40, "VSX"}, \
> > +	{0xf80, "H_FAC_UNAVAIL"},
> 
> So I ended up looking into other trace_symbols too and I don't think we
> should have a trailing comma here. It may cause some issues silently in
> trace-cmd or other places. I remember going through it when I was doing
> some other tracing work earlier but I don't recollect it now.
> 
> Can we just remove the trailing comma and send a v2 please?

Good catch, thanks. Will send a v2


> 
> btw, 0XF80 is correct as per "arch/powerpc/include/asm/kvm_asm.h"
> 
> #define BOOK3S_INTERRUPT_H_FAC_UNAVAIL	0xf80
> 
> -ritesh
> 
