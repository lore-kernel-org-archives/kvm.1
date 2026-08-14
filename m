Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AE746982A
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786709861; cv=none; b=h06uFnNGNU35hXEVwJmc3TxA/yNVrT5wFK/TLh875Iv2pDJpnUDcidQkcxq9FGxmrw/YfF45sRRhmxNu4d4o7x88rntvqRtKyu3ye8RaGmSL8UINVnx5x2nwbTM6b1HDojAT6gBWOjiVn6TQpBqMx4O+TKcSlweE4z04/I7d5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786709861; c=relaxed/simple;
	bh=ykgD6hT6XlBNcBthqn3iMD2FWop8wZYLAn5NgOVztek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcU827GYBfVsnnJ10Gu9Y2SObnw8zSz5RjJL85c3EMb2cqHyVB8UWI53gDefiFLEuuxU4Ps1FfcqHjZNSoIomsmxyFH22ZfHkcSW7nEJcZ3D7hd+4cXw03CY3CupwFVJz37C5wDDtGhvFTiAlP3uYPCag6HZvOJgg6fe5UWh7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cty3rcPU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cty3rcPU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EB1gXW903724;
	Fri, 14 Aug 2026 12:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7kDLJ3
	55LYt1huG4H0p1pUx5oxXniRknXeT6bQxnHdg=; b=Cty3rcPU+pfGsHr0zpcPHh
	jAH4xfaaTHiM++L7qaaotX3EWOU1flm6I58ewM3D5ilNqUSezwIfLu08fI1kDeZS
	l8DE7mkps93uXRc32gwA25EO5luIvfF6cFhTm/YRvQlJpsh3f3bkxd3YgN5aKbgm
	GJUh+HV0TkW64deOjlCfxX8jE1EOLs4hA7NWBebkGzXBXxncrybVI6dE0YQmHNTA
	gY8FSK2MjafFHvKp0ygoy9J7v/cUMBAWw/emrXLGjZw8iAJ5VcDgZxsvcDInu/82
	tG/oNDr2BifbMum/k6p3h0gF+9/kN7I3PkVckXxRcR3BiNZVKyzbkFz7xR0kcQpg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9vn69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 12:17:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ECBpP7010658;
	Fri, 14 Aug 2026 12:17:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk76up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 12:17:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ECHWqO50004460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 12:17:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D4B82005A;
	Fri, 14 Aug 2026 12:17:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F203E20063;
	Fri, 14 Aug 2026 12:17:30 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.124.210.252])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Aug 2026 12:17:30 +0000 (GMT)
Date: Fri, 14 Aug 2026 17:47:27 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/3] powerpc/perf: Update prev_count of event to get
 accurate values
Message-ID: <an8HV08_-EyaA4-R@Gautams-MacBook-Pro.local>
References: <20260813094535.10083-1-gautam@linux.ibm.com>
 <20260813094535.10083-4-gautam@linux.ibm.com>
 <20260813100103.001361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260813100103.001361F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3KaWxEoTg-nwJ_VAj0ilcu0DccogpRNk
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7f075f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=DrxZ4JEAOZhTRNrT7n8A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfXzGxhbw9Eq05L
 xd5rsCVAMI97iLnL0akxa5Sc70ivbbeTVprJF0hbVwsEqquPxTjwKKfd8fCUwvI7oXg+BDuUr0d
 DvXxnZXvTUrAFyT4IAamAXxzKhk8gZyl/GbtV7KJLlpU5ontdIL9PJI8/R9N6/9UkLORo97Wl/h
 A2VJCuQLisw45tEPz4tjt80JFRnKmJtoC9ubW43vCaR7qSiIntyxdJ5ab5mH3OT4O4wqXqiLQQU
 TFTVePLFFl9tmh1b6TKZc6PXeJ/GnTP2vvniqSR8NBh0KIpNVtQCU3osCeGbqVX8O0lFaNU6Xh/
 jystvmqRg8B+EZ//taMCCaBrSSADWg7V7xZ0B10QzfstMI+h1zpClfjDKPmxRy6E2/eEuby+gm5
 Tej8Kl3TZda3QGUrJzF6S2QN6n8aXsIunucrOly4oZhCYu8XJRGCgSyvfAP9KE0h3UjdunRQzYq
 eN0WDSbgrNWErnrxAgw==
X-Proofpoint-ORIG-GUID: 3KaWxEoTg-nwJ_VAj0ilcu0DccogpRNk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfX3OY46rBrtpSt
 WEpoifIfh5E3teR54R5kgOY4+d15uzDZTWNvyC1S8TE9EDsvVhBoi/xKwTFWuXQNZ2NprYF7awG
 T8kpsfPaMzBM8AkTReT3GfXVGL70gYE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140091

On Thu, Aug 13, 2026 at 10:01:02AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Missing atomic cmpxchg loop in vpa_pmu_read() when updating prev_count.
> 
> Pre-existing issues:
> - [High] The VPA PMU `add` callback stores a raw pointer to `struct kvm_vcpu` in `event->pmu_private` without reference counting, leading to a Use-After-Free.
> --
> 
> --- Patch [3]: [PATCH v2 3/3] powerpc/perf: Update prev_count of event to get accurate values ---
> commit 7c392d724ba481a5282a90aed95397fac4533493
> Author: Gautam Menghani <gautam@linux.ibm.com>
> 
> powerpc/perf: Update prev_count of event to get accurate values
> 
> This patch updates the VPA PMU read function to keep event->hw.prev_count
> current. This prevents stale values from being returned on consecutive reads
> while a process is running on a CPU.
> 
> > diff --git a/arch/powerpc/perf/vpa-pmu.c b/arch/powerpc/perf/vpa-pmu.c
> > index e79d98447c743..efc39f71553bf 100644
> > --- a/arch/powerpc/perf/vpa-pmu.c
> > +++ b/arch/powerpc/perf/vpa-pmu.c
> > @@ -156,6 +156,7 @@ static void vpa_pmu_read(struct perf_event *event)
> >  	final_data = new_data - prev_data;
> >  
> >  	local64_add(final_data, &event->count);
> > +	local64_set(&event->hw.prev_count, new_data);
> 
> [Severity: Medium]
> Is it safe to use local64_set() here without a local64_cmpxchg() loop?
> 
> If vpa_pmu_read() is interrupted by an NMI (such as a hardware PMI) and a BPF
> program attached to the NMI reads the same event via bpf_perf_event_read(),
> the nested read will calculate its delta and update prev_count.
> 
> When the outer vpa_pmu_read() resumes, it could calculate its delta using the
> old prev_data (resulting in double-counting the inner delta) and then
> non-atomically overwrite prev_count.
> 
> Should this use a local64_cmpxchg() loop to safely update prev_count?

Yes, valid point.

> 
> >  }
> >  
> >  static void vpa_pmu_del(struct perf_event *event, int flags)
> 
> [Severity: High]
> This is a pre-existing issue, but does this code leave a stale vcpu pointer
> in event->pmu_private that can lead to a use-after-free?
> 
> Looking at vpa_pmu_add(), a raw pointer to struct kvm_vcpu is stored without
> taking a reference:
> 
> arch/powerpc/perf/vpa-pmu.c:vpa_pmu_add() {
>     ...
>     vcpu = local_paca->kvm_hstate.kvm_vcpu;
>     if (!vcpu)
>         goto out;
>     ...
>     event->pmu_private = vcpu;
> }
> 
> When the thread context-switches out, vpa_pmu_del() stops the event but
> does not clear event->pmu_private to NULL. When the thread is scheduled
> back in outside of KVM, vpa_pmu_add() sees the vcpu is NULL and returns
> early, leaving the event active with the stale vcpu pointer.
> 
> If the VM is then destroyed and the vcpu freed, would a subsequent thread
> exit or user read() calling vpa_pmu_read() trigger a use-after-free when
> dereferencing vcpu->arch.l1_to_l2_cs?
> 

Valid find, will fix in v3.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260813094535.10083-1-gautam@linux.ibm.com?part=3
