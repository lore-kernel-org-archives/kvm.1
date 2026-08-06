Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37148329E5A;
	Thu,  6 Aug 2026 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032546; cv=none; b=hXzUeEmooqSVhMNnRvAbWeQlRWEndLY/qRe5amPEHlenSdE1rkhcalvPWQ9ZzGW3T3rKmHwO71mRRZAG/cLKIZISxFpxphCaQXBgJ7XJZw1GEEe2zzEiNh0qx7HHFdwg3axa6FkoYmwCaZYVtbvYVIlFhidWBJtM4IggAhg4vXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032546; c=relaxed/simple;
	bh=rfrsYd7q9l+0ULV1cCIYgZsbhYijyiaPYX+e0gKYFDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEOBEg0YtZLG9r050lmn5EuGD6+YMDXa8m/GrFRYTPRcgucXHhRzu7y0fl7mE8x0fPXVpuvbyzsnWsecgUH/C5fR+tk8ROzd3AFgfAocnz59GAIrW9EfTt52fqI+gxyLETjrPS7o9jaJ8ZWHAaCYiZlhUKa1OXsXZ4c9SvdNxQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BfG6YfXn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BfG6YfXn"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676En3aT2939433;
	Thu, 6 Aug 2026 16:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qa2KKS
	vNuRRAesQ8kVn7IlzgkVkNpaGabQEsrklyW34=; b=BfG6YfXnXlaWkJ7jKrbjhk
	uOJiBglnRlxbt90a6/8fNrdyUuoLcsv7eYXn7rw7NmfI7sEWm6gCCH1JOnPLChd0
	SDejII9BWAzvKXis+AWT4OdznvGVFp0ozATwas3Op5EUAJblrbmihvXVSmyoLDIJ
	RhblW9HQ6OUWLa5E8iq1MoiOCg6+0jbWxYI0X/iyaYP11yhdfZ36H2BeeRU/rZqY
	0U8SoEmI1I4Z6RyvlGeKp77vEGVX/uUMh6k5rSAXyHJ3oN0UjutP4oYoHRAPgxwF
	P/KoEOtMl7ZeuslQ7ZPuQE+vvxWGdPj03cFuFrzI2LRItbdD6WtiyOQhFoVv13pQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a495xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 16:09:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676FuNOr031347;
	Thu, 6 Aug 2026 16:09:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwbyxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 16:09:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676G8xuR31457738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 16:08:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10F8D20043;
	Thu,  6 Aug 2026 16:08:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3432D20040;
	Thu,  6 Aug 2026 16:08:58 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  6 Aug 2026 16:08:58 +0000 (GMT)
Date: Thu, 6 Aug 2026 21:39:47 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v6 2/4] KVM: PPC: Book3S HV: Implement compat CPU
 capability retrieval for KVM on PowerVM
Message-ID: <20260806213926.140b3346-a3-amachhiw@linux.ibm.com>
Mail-Followup-To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
References: <20260804180705.59160-1-amachhiw@linux.ibm.com>
 <20260804180705.59160-3-amachhiw@linux.ibm.com>
 <20260804182156.62D511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804182156.62D511F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a74b1a0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=Ha8nLlLPPlwXYc-YV0sA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: zEK8XSC7g_4O6NR5gUkYQ1dlLDFgnSYQ
X-Proofpoint-GUID: zEK8XSC7g_4O6NR5gUkYQ1dlLDFgnSYQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMiBTYWx0ZWRfX7DQ2keNJjhMU
 FmTzVAJNWYiNSnW1FDpNEeDJNi2mCPYW5wWeervl1hebg7VwlVxvkBPxkZcgv9UAsUkjA/caxGu
 Y6sC7vHRYBUEtkxgS34V6DH8H12nGus=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMiBTYWx0ZWRfX8j4h2zOGeEqk
 mKe+lXyaEQ5UVrlO1oRG1zaGC/4/7m+P8w3Df2vpaQDLBx6xTVF7oDYCofpWFm6+e0mPCfKKrh8
 n3VhQKO/TtprMXzP359e0mXeQf1vIFAL9Hjx6N+OEvCTrYOtjR0/MdlH7Dtz24n2MNhUHR06eGg
 eX0RJFjG1P9xzfzVHzDk/Z3tVJal4ukH8B2xLknfNOFIp/svt8MUHCarHFNq3OtN020/mtFH/QD
 x3C4bkqV2tOgs1I/rLy52cBDWzJbBmIHqgiPo6mj7/y5tM+C8WyEjfHcx/qXCTzM4HzVNrlBBtZ
 DCRmus3Vay3f+OciREqd4jCluE1g5/gQN3wUI5FewOn9GNJaZJEyXVzEdysGrf22gyN91TNqGGZ
 RNuzcdGVBf2myE/I2La3vfc30mGHQr1857//t7HWlEX8oLjP9xNbpZP6z+ZO5gq72o/zN2FZWPU
 cRJ8RB+SSQItZALtkgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060122

On 2026/08/04 06:21 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Mismatch between KVM_CAP_PPC_COMPAT_CAPS advertisement and ioctl implementation for unsupported environments.
> --
> 
> --- Patch [2]: [PATCH v6 2/4] KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on PowerVM ---
> commit 8305652489744988576b7fa55e0424452c48a633
> Author: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on PowerVM
>     
> This commit adds support for retrieving host CPU compatibility capabilities
> for nested guests on PowerVM. The capability bitmap is retrieved from the
> cached nested_capabilities value and exposed through the new
> KVM_PPC_GET_COMPAT_CAPS ioctl.
> 
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 61dbeea317f3b..8799124b80960 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> 
> [ ... ]
> 
> > @@ -6510,6 +6510,25 @@ static bool kvmppc_hash_v3_possible(void)
> >  	return true;
> >  }
> >  
> > +
> > +static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
> > +{
> > +	unsigned long capabilities = 0;
> > +	long rc = -EINVAL;
> > +
> > +	if (kvmhv_on_pseries()) {
> > +		if (kvmhv_is_nestedv2()) {
> > +			WARN_ON_ONCE(!nested_capabilities);
> > +			capabilities = nested_capabilities;
> > +			rc = 0;
> > +		}
> > +	}
> > +
> > +	host_caps->compat_capabilities = capabilities & KVM_PPC_COMPAT_BITMASK;
> > +
> > +	return rc;
> > +}
> 
> [Severity: Medium]
> Will this return -EINVAL for pseries hosts when nestedv1 is used?

This is analysing patch 2 in isolation. The series is applied in order:
patch 3 adds the nestedv1 (KVM on PowerNV) path to
kvmppc_get_compat_caps(), filling in the `else` branch for the case
where kvmhv_is_nestedv2() is false. After the full series is applied, a
pseries nestedv1 host takes the DT-based path added in patch 3, not the
-EINVAL path. There is no issue in the complete series.

> 
> If KVM_CAP_PPC_COMPAT_CAPS advertises support by returning 1 for all pseries
> hosts (which appears to be the case in kvm_vm_ioctl_check_extension), 
> userspace might query KVM_PPC_GET_COMPAT_CAPS and hit this path when
> kvmhv_is_nestedv2() is false.
> 
> For example, if userspace checks KVM_CAP_PPC_COMPAT_CAPS and gets a positive
> result, but kvmhv_is_nestedv2() returns false here, we return -EINVAL.
> 
> Since -EINVAL typically indicates invalid structure size or bad flags, could
> userspace fail to differentiate an unsupported backend from invalid inputs,
> leading to initialization failures? 
> 
> Should this gracefully return 0 capabilities (or -ENOTTY), or should the
> capability check itself verify kvmhv_is_nestedv2() before advertising support?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260804180705.59160-1-amachhiw@linux.ibm.com?part=2
