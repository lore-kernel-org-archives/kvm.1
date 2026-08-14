Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C745D5D2;
	Fri, 14 Aug 2026 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786709130; cv=none; b=Wan3S8D1+fKDsldCv+JIpV+3QAwoKeiMh8/ubwEfGcw+zApncr/fxp/LBOMJdz1HIb5Pe5QstGTFhmhrq7tdDKUUX483ij8L7WEkxcitpYEy4OTf+lNJCyTXq/AUcSwlO/4NOx3owIPyARkc3C6bw0TqF8trvPTbZp48tt0Eipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786709130; c=relaxed/simple;
	bh=S6+3ZjYq1tW93WwPs6rYSrQwSZrkjYjDFwX3eO35OG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFDAoWL0QHHb45cR8RS0CYNDdd0RfHQ86MhfD9GVlAYsq0WbM+1XTYFX65lbfFv2a/Legl6Zcw3a4DnIUXUD32EFO1GZ15mFJSAauWKgdhonG4ENewkeG4/P/DV4pAhonH22YTM0vuaKhJww1pn8bj9Wbs7H4LtSFACczrtalyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M++36K2T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M++36K2T"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EB1uQI4037654;
	Fri, 14 Aug 2026 12:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=53Wv7h
	hGzARbqTpEalo4GtKsuTEoCiyNdmVXA5yYUTA=; b=M++36K2Tnjsm9tiBOAKEQw
	m0bEQK9lFO5x/J+Qy58hRl+hH7suum/hWfuDE2KzjeZhHgMvnN2n5wbVMgPKLjJr
	ALqVUENPvgE/DT1ssGxeE9KRDa1pRv+F3zueVxCZ0vM2SK9BsvPWWrSGVwckJ+dD
	0TVvEn7ablvDx7IuZD1IP8vjzbhY7jMz+rwdM4RNaSoHd4sbt+1MDFWZimdZfwd1
	XqYeSVpIYpZGeBA+Yg52u5ALAN5ezSafHBEzg/7dNO1ySir86Pn7viIccfugVq4j
	eQHDW9xHuu84B+fJLxjaWL5bpyqZRMw3zwxhkaeZuQyP1+IbSpScvxAVB+6t1CuA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb244u80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 12:05:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EC0gLN010644;
	Fri, 14 Aug 2026 12:05:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wf956-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 12:05:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EC5Ogd45613534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 12:05:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8779C20043;
	Fri, 14 Aug 2026 12:05:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90AAB20040;
	Fri, 14 Aug 2026 12:05:23 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.124.210.252])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Aug 2026 12:05:23 +0000 (GMT)
Date: Fri, 14 Aug 2026 17:35:20 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] KVM: PPC: Book3S HV: Maintain aggregate context
 switch values for vCPUs
Message-ID: <an8EgFAggj9N_XIo@Gautams-MacBook-Pro.local>
References: <20260813094535.10083-1-gautam@linux.ibm.com>
 <20260813094535.10083-2-gautam@linux.ibm.com>
 <20260813100305.426951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260813100305.426951F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7f0487 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=jS0CeIvxKXgdbAVNWB4A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfXzFgZXMpBNuWt
 qL9xe3bd/wvHvX63YbMXYJAEiS57JCUtDj9xLJuG7JJxJ5S7RX9U1kmStenujCrewgE8sGptKZI
 hOPElsIAusAvZRbHJY0XgEdTA+5iIzo+ubW0DqLxTPaaIybyph9X+sEaeXJ0Dbaq4KgJJF1ggEr
 BZAYuSqWah2dl5rc9X8d3ciF/lJ15uywoI5ZRHoYiu8QG7C3wkPBpVlqqQTpbriHvEQk3YrCWVZ
 fKao4mnuEo3EGuTgN218VLfXaNk1x6BiBLjW9SuQvc6Ro+YqrbsfN2cNacMiU1jYooKNIxxe9d1
 hWe/mw6GoRGlmg3HF3fc/CeHIfAowwqxOgLUFS89Ki9v7YmH+7IfSCk5rmz2tSs2zErNtApksag
 zWxDh7XG56gp/eYAfmsD2LQq1GpgGWmzZHRpLuKjEEG1j3eK2sCM/h4rDITJzDD2jnpbMpKtadu
 EWWvNEqezF1uVDa9ZqQ==
X-Proofpoint-ORIG-GUID: 1ZXdIazlw6wAtER8MuTjv0TNjTDKNXSp
X-Proofpoint-GUID: 1ZXdIazlw6wAtER8MuTjv0TNjTDKNXSp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfX9lcOXLnP5OvY
 ujGJQmdX2iuJH+xJvo+KhPXSL2KFQaKqQeY4N3SLdM71yadCqkZLGHE5OGabkmLhq6QpUtdUzcs
 xQ/fr0bH5jtlIkGaoAAB9cVnVWDeqD4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140091

On Thu, Aug 13, 2026 at 10:03:04AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] The patch breaks task-bound VPA PMU events by subtracting independent VCPU aggregates, leading to severe underflows.
> 
> Pre-existing issues:
> - [Critical] Pre-existing Use-After-Free (UAF) and cross-VM data leak via stale `kvm_hstate.kvm_vcpu` pointer in VPA PMU callbacks.
> --
> 
> --- Patch [1]: [PATCH v2 1/3] KVM: PPC: Book3S HV: Maintain aggregate context switch values for vCPUs ---
> commit b8e49dde6d70a4c423cf40d03275e97149e3916e
> Author: Gautam Menghani <gautam@linux.ibm.com>
> 
> KVM: PPC: Book3S HV: Maintain aggregate context switch values for vCPUs
> 
> This commit changes the vCPU context switch latency variables in vcpu->arch
> to store aggregate values rather than the latest snapshots read from PACA.
> The goal is to provide each vCPU with its own record of total context
> switch latencies for the vpa-pmu driver.
> 
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 61dbeea317f3b..342168b8bfc86 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -4163,12 +4163,12 @@ static void do_trace_nested_cs_time(struct kvm_vcpu *vcpu)
> >  	trace_kvmppc_vcpu_stats(vcpu, l1_to_l2_ns - *l1_to_l2_cs_ptr,
> >  					l2_to_l1_ns - *l2_to_l1_cs_ptr,
> >  					l2_runtime_ns - *l2_runtime_agg_ptr);
> > +	vcpu->arch.l1_to_l2_cs += (l1_to_l2_ns - *l1_to_l2_cs_ptr);
> > +	vcpu->arch.l2_to_l1_cs += (l2_to_l1_ns - *l2_to_l1_cs_ptr);
> > +	vcpu->arch.l2_runtime_agg += (l2_runtime_ns - *l2_runtime_agg_ptr);
> 
> [Severity: Critical]
> This is a pre-existing issue, but does relying on kvm_hstate.kvm_vcpu expose
> a use-after-free and cross-VM data leak here?
> 
> When a task-bound VPA PMU event schedules in, vpa_pmu_add() calls into KVM
> which reads the vCPU from the physical CPU's PACA:
> 
> arch/powerpc/kvm/book3s_hv.c:kvmhv_get_l1_to_l2_cs_time_vcpu() {
>     ...
>     vcpu = local_paca->kvm_hstate.kvm_vcpu;
>     if (vcpu) {
>         arch = &vcpu->arch;
>         return arch->l1_to_l2_cs;
>     ...
> }
> 
> Since local_paca->kvm_hstate.kvm_vcpu is set during guest entry in
> kvmhv_run_single_vcpu() but never cleared on exit, it remains pointing to
> the last vCPU that executed on this physical CPU.
> 
> If that vCPU belonged to a different VM, its context switch data is leaked.
> If the VM was destroyed, wouldn't this dereference a freed vCPU pointer?
> 

This is a valid find - kvmhv_run_single_vcpu() is called after
vpa_pmu_add() is called, so the paca stores a stale pointer.

> [Severity: High]
> Will changing these fields to accumulate independent aggregates cause massive
> underflows in the PMU driver?
> 
> Before this patch, these fields stored a snapshot of the global monotonic
> timer. Now they store independent per-vCPU aggregates.
> 
> Because of the stale local_paca pointer issue mentioned above, vpa_pmu_add()
> records the previous vCPU's aggregate as the starting baseline:
> 
> arch/powerpc/perf/vpa-pmu.c:vpa_pmu_add() {
>     ...
>     data = get_counter_data(event);
>     local64_set(&event->hw.prev_count, data);
>     ...
> }
> 
> Later, vpa_pmu_read() subtracts this from the current vCPU's aggregate:
> 
> arch/powerpc/perf/vpa-pmu.c:vpa_pmu_read() {
>     ...
>     final_data = new_data - prev_data;
>     local64_add(final_data, &event->count);
> }
> 
> Since new_data and prev_data are now completely unrelated aggregates from
> different vCPUs rather than two points on a shared global timeline, won't
> this subtraction produce garbage values and severe underflows?
> 
> >  	*l1_to_l2_cs_ptr = l1_to_l2_ns;
> >  	*l2_to_l1_cs_ptr = l2_to_l1_ns;
> >  	*l2_runtime_agg_ptr = l2_runtime_ns;
> > -	vcpu->arch.l1_to_l2_cs = l1_to_l2_ns;
> > -	vcpu->arch.l2_to_l1_cs = l2_to_l1_ns;
> > -	vcpu->arch.l2_runtime_agg = l2_runtime_ns;
> >  }
> 

Yes, this is a consequence of the bug reported above.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260813094535.10083-1-gautam@linux.ibm.com?part=1
