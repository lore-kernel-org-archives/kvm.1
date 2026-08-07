Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09962D249B;
	Fri,  7 Aug 2026 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100348; cv=none; b=pHm8Q9Max45W3NqkzJyDuzM7lG0smbpLsNHudtTnkBmMRmMj2uFqa5Cdxa3dKHL8t1Mz0WbBoZrGxamVqR/Af8+0ad4eFckRWfRhMZjPjrrqO5ZXlHdr/u/RZy24pv1Hn860Vg0BsI5/LgbAC13V935uVayf4vmjs4W9o7HNtS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100348; c=relaxed/simple;
	bh=L1MhdzwapaQeZxWjhc3Ij6CUn/5aZkpaV9BwvEAzj0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXeNRYHao/v4UoSk3nUdXTR6JhI/Eoh93XWgu0ckzuN6CPH33OWGMCRU1A1z/ZmwCQa18Qz+f260qewd93fXENwT7SRW9nG/nJ6nRExnWL/eDxYgKUQnUCBKpKwrsXXL8c7PbS7YvgLMg3M0t77/okq10lknbSmZ88aAdm9MRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dqeHSIaL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dqeHSIaL"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770I5V74162026;
	Fri, 7 Aug 2026 10:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=wdarfIqciowp+pL47aDTBo7eMfzKp2
	1bb8+EWwO9clM=; b=dqeHSIaLb+XDkSqXw2C2MLQY7zbKt5fGBYOIuusv2XU07s
	lFUr4M/B12oxS8+cBVD5DZvrCyJpqj6peEfiFbtHB2dlBobAjAAAnRuJ8HwY40Ea
	sLllYYdEBYSdSQsFCvcKfMKYtMpp8CDMA56mdhgaRPjO88B4YvAKGYeaTag0GCig
	WQtCF2LYLV69Yg1oCS5Q6IzX7HFTxTExbsCOVTGqYTpgIVEQ75j1YQ358W9xgXPs
	mQNTBl8SitC9sFxmus69q+plTbhNUurHFcdQSdDa4x3xrZU/AlJKyHo6pw1jZx8V
	cODu+pgXapgjrWMi0HNTDVAQMTaRXXedz5L6JfRg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyugwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:58:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677AuGlj018972;
	Fri, 7 Aug 2026 10:58:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgq5y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:58:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677AwmYl32309522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 10:58:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00B8620043;
	Fri,  7 Aug 2026 10:58:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EEFD20040;
	Fri,  7 Aug 2026 10:58:45 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 10:58:44 +0000 (GMT)
Date: Fri, 7 Aug 2026 16:28:51 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v7 2/4] KVM: PPC: Book3S HV: Implement compat CPU
 capability retrieval for KVM on PowerVM
Message-ID: <20260807162828.2a058992-ed-amachhiw@linux.ibm.com>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Gautam Menghani <gautam@linux.ibm.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com>
 <20260806170645.11892-3-amachhiw@linux.ibm.com>
 <h5l6lfep.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h5l6lfep.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a75ba6d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=nVGv5udEVB_H-HuN8jAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfX41cLFsdUHpnw
 3MJ8CVzPs6V6RWuQgPTn6DV3ZCFVBWfMamQOnb0NQLW568BH8rv23nJyKqTbWK8lrJpgxoGJZEA
 Nb5EgXtsuykKgkFr8fOe/JoHuubkwVc=
X-Proofpoint-ORIG-GUID: A5C6p1omfupWrT1c77AgYDvtCGUbsntY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfX3WvTxNIZm6E1
 qwYS06xflV2u5is1JubIOFdsNl/Kn36LA4kUgUwCYutB6uBzRRXG7aGNHEkKLnhwqaN4XkL0aiP
 NZSp8EeoZkn6kMgDYPC5monLGdgsobhRQ5TgKFJcjDzMfZG12Y4hc8CjxMQvTub/rsWl8qi6c30
 /DR2eeumgnWz4iZSLcuBfSCLuTOax2c3qjFd6NEozKZ/bwlSJA0+Pw5XLD0qSF6mdTkidm5bk+V
 l3T59CoHm4re5DlmVTSbZi+uUnNHrFpI0lv/Mg1XzCr9XhB0nVQmqP8KXb5/d7ncNE4J04H35vN
 4KbYi4EvyoKZW+3qsc5no9RQqNk4+AgoeLqoksTT8XGt0DSgj4FFigPAk602c8ZuXbJOqOlAAG5
 r4V8L9rdkIpaeaep/4LjHBlcWTglKLK+FyPiOuebv9N1v1dX//B5Yw5pTelAyjnEZPZfbuNuWgm
 1s6bkbMpimUYAMR4szg==
X-Proofpoint-GUID: BZb3XddkEIH-vHW_axws0ufPySg33Ivd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070083

On 2026/08/07 10:01 AM, Ritesh Harjani wrote:
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > On POWER systems, the host CPU may run in a compatibility mode (e.g., a
> > Power11 processor operating in Power10 compatibility mode). In such
> > cases, the effective CPU level exposed to guests differs from the
> > physical processor generation.
> >
> > When running nested KVM guests, QEMU derives the host CPU type using
> > mfpvr(), which reflects the physical processor version. This can result
> > in a mismatch between the CPU model selected by QEMU and the
> > compatibility mode enforced by the host, leading to guest boot failures.
> >
> > For example, booting a nested guest on a Power11 LPAR configured in
> > Power10 compatibility mode fails with:
> >
> >   KVM-NESTEDv2: couldn't set guest wide elements
> >   [..KVM reg dump..]
> >
> > This occurs because QEMU selects a CPU model corresponding to the
> > physical processor (via mfpvr()), while the host operates in a lower
> > compatibility mode. As a result, KVM rejects the requested compatibility
> > level during guest initialization.
> >
> > On pseries nestedv2 systems, add support for retrieving host CPU
> > compatibility capabilities for nested guests on PowerVM. The capability
> > bitmap reflects the processor modes negotiated between the Power
> > hypervisor (L0) and the host partition (L1) via the
> > H_GUEST_GET_CAPABILITIES hcall, but is retrieved from the cached
> > nested_capabilities value populated during module initialization,
> > avoiding repeated hypervisor calls. A WARN_ON_ONCE() flags the
> > unexpected case where nested_capabilities is zero on a nestedv2 system.
> > The implementation defines KVM-specific capability constants
> > (KVM_PPC_COMPAT_CAP_POWER9/10/11), masks unsupported bits, and exposes
> > the result through the KVM_PPC_GET_COMPAT_CAPS ioctl.
> >
> > Hook the implementation into the Book3S HV kvmppc_ops so that it can be
> > invoked by the generic KVM ioctl handling code.
> >
> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> > Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >  arch/powerpc/include/uapi/asm/kvm.h | 10 ++++++++++
> >  arch/powerpc/kvm/book3s_hv.c        | 20 ++++++++++++++++++++
> >  2 files changed, 30 insertions(+)
> 
> Looks good to me. Please feel free to add:
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks for the review, Ritesh!

~Amit
