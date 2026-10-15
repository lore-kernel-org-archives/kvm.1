Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7251599A;
	Thu, 15 Oct 2026 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061099; cv=none; b=WbzYH1LXbJAEYUvecmU8Ze4bF4PZlxey0e52yT2eqVVLYO6FKwGk9J+so+29QNH6hKkqah+B2QvIsUl+KufaaoJ5AJDl7RmjIA+Vld44dVK0s9TcINKAwEogWDBOrcjEsGhQvo3D2W3WX/VBiODPTKACnxn053fB//Btv30tkSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061099; c=relaxed/simple;
	bh=EcsGVo/EaqJzFEHbILjclgzrfs86bzldZNQbN3tCirQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3w24HvbnEXqqY8scrsgTNxPPo6C7dkK8vKW2aFg8kFtpKzskQSV413C/jqVmEbYH6AKBXYSDrF0z2LVJlHeOZPf4jH9L8gdHxnE6GSwuQ90sC/YCtlXxzpsCF0hnFpfyEF5vJ2bmpL0NsLqSBOtPduivLPCJ/6hyh7dbZEZNKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=euFh00ut; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="euFh00ut"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9kccf531930;
	Thu, 15 Oct 2026 10:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=D3DHfgUvSczPS90QlosCe6beusdbK+
	3al2oliDWEeUM=; b=euFh00utqxTVWOKkb44HslbQntniephltY/9ldLyWeTs8M
	/US1GxgiQ3W2d06XgD5AulUyTtgQc6B8xr4QIz/ur0wupEL15omyXAU3xUKzTii+
	9TdjG9kKopb85zyYMbvJefcY8hssNvZG2aRyIDOq/x98iWVQ1UtwmDyPlkNsdG2S
	sizRrQ7eU0uLy8AUj1SPrqq6rimGSFS8BrKTd68L5oHiIJEVDN3Gjyki8wCyGE2M
	8M6HotRFd+iMNpkme4yLJDME65H8Lwwvh2Tl1ic3XD5EGwJDE8FA7oMf6iK0Sfhn
	Pw4dFIanDgGe9QkliOhPGggHXaKGk1RP0DN3FBPQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv3sdp6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 10:44:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9nuLv1967770;
	Thu, 15 Oct 2026 10:44:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816hbjeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 10:44:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69FAimUR48693652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Oct 2026 10:44:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F14452004D;
	Thu, 15 Oct 2026 10:44:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EE2820049;
	Thu, 15 Oct 2026 10:44:47 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Oct 2026 10:44:46 +0000 (GMT)
Date: Thu, 15 Oct 2026 16:23:05 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Disable preemption around host-side
 HPT lock users
Message-ID: <20261015162140.3a47683d-77-amachhiw@linux.ibm.com>
Mail-Followup-To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
References: <20261014185215.71832-1-amachhiw@linux.ibm.com>
 <sashiko-outbox-171754@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-171754@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7ydpsoDdgPP9VD2zGMNqYCUzd1LjZzwN
X-Proofpoint-ORIG-GUID: 7ydpsoDdgPP9VD2zGMNqYCUzd1LjZzwN
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6ad0aea5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=lMOgnohsUXiygdNOCAwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfX0S1A5rRLMKv2
 NDjAqf8AQgHjRVODUik6dYb8WVUVH4RtmYBAl5Rqj7WWkjPeHWniJm4xMTagrrDfHq76FCTsaMc
 GWpeYY2PP+XOlcCn5IM4GI41t45/4l8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfXxc1DkNHlVZEz
 RE7te6hgpfFZL+qqb6VKi27FDQQByFfGtHXg5jlWlPQD1PzuEuknPRM3qmo8Ih8ftC/6MmrvrZI
 ft28Ch13GfWJfqHJuI1e+aBKvDGBR9PwsBcxHoT4/FoNv3WIhay95jVMbNt97Dr4fG9zU9+ozvr
 KOhAckCvqkKnZqc8kcEF7vrcq7EAjpq+RSMEmVwWSwhhRHvVxVixfX0mj8RP1vBUJQ2CurpgIfm
 YmxivR6o3pUOJq7rhS4gXuyAzzpQXh4SxDZ3bGUTwCAXWESy7Ph6IMPOEjhXco3uLKRDYwyzx6K
 LcLWr8lO7IgAHTho7Ugc7iMi53uj4j6Gzsu1pwxdRz3v3Qqaxg+911mrZfs/vTwNhQA0ngpQYrx
 0Xp21Ef2snob5F/8VffadyXD6qDkhtR9uUguVufnWAlUkjjjwLGHfiG9AFKAL7/j1+6sPC6X+la
 JJkz6XDyyl7N6SaPXJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150042

On 2026/10/14 07:09 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kvm: missing preempt_disable() in kvm_test_age_rmapp() leading to deadlock
> --
> 
> commit dbd9d3f82d3dd2c11f69c26045433b125bc70408
> Author: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> KVM: PPC: Book3S HV: Disable preemption around host-side HPT lock users
> 
> This commit disables preemption around host-side virtual-mode paths that
> acquire HPTE_V_HVLOCK and lock_rmap(). This prevents a permanent CPU hang
> where a preempted host thread holding either bit-lock blocks a spinning
> guest vCPU thread.
> 
> > diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > index 2ccb3d138f46c..8d85ce3440ae3 100644
> > --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> [ ... ]
> > @@ -890,6 +913,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
> >  
> >  	rmapp = &memslot->arch.rmap[gfn - memslot->base_gfn];
> >   retry:
> > +	preempt_disable();
> >  	lock_rmap(rmapp);
> 
> [Severity: High]
> Does this same deadlock risk apply to kvm_test_age_rmapp()?
> 
> Looking at kvm_test_age_rmapp() in the same file, it also acquires
> the spinning rmap bit-lock without explicitly disabling preemption:
> 
> arch/powerpc/kvm/book3s_64_mmu_hv.c:kvm_test_age_rmapp() {
> 	...
> 	lock_rmap(rmapp);
> 	if (*rmapp & KVMPPC_RMAP_REFERENCED)
> 		goto out;
> 	...
> }
> 
> kvm_test_age_rmapp() is invoked via MMU notifiers (like
> mmu_notifier_test_young) holding the PTE lock. Under PREEMPT_RT, the PTE
> lock is sleepable and does not disable preemption, so lock_rmap() is
> acquired in a preemptible context.
> 
> If a host thread holding this bit-lock is preempted, and a guest vCPU
> thread on the same CPU executes a virtual-mode path like
> kvmppc_virtmode_do_h_remove() (which disables preemption) and attempts to
> acquire the same rmap lock via remove_revmap_chain(), could it spin
> indefinitely without yielding?

No, this is not a problem on PPC.  I have explained the reason here:

  https://lore.kernel.org/all/20261008005700.c78e5a18-dc-amachhiw@linux.ibm.com

Thanks,
Amit
