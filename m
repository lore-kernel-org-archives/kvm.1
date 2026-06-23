Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B01306B31
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206596; cv=none; b=EhB+rNwnAVGmp5yzgBPXS0H2z4bURWQ0lL0D/T8SkxMyV9I5LmhUhaJh98ZHfw96m0Y5F4O0bgn8aqyf1TW7ry4xUCF0b4cIXfdVorAOFo8UPjCsk+aGUFiFv2Ux9XIRzsJwlAIGeV4gBVvv+7bJYNTn6Hc3YuBxCU6BC++egS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206596; c=relaxed/simple;
	bh=X+/1bdqRCGYUvtLCmEj+coH+pXHSbO7VtAKSPU52ONY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6wrh23pW684l0Cl/qK0lPmtfsIFmQzGyEGuQ3ZNxferdpXuZz6xM8mVdgOyKLBuqJ5GIiIpXYHbLuy0i9//jYxer7VRj+RIw+eWmuBVsAkOE2jqKrUfCm37kcnNcCq6bfPha0cKpFdRmaP/Es5CPzXHHQfD2SOPs3E+3sC13Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kq+K1k9F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kq+K1k9F"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6n3ST1142953;
	Tue, 23 Jun 2026 09:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=IOtiJ9y0jOvLN4XKUFnzSCrOY7onpm
	cdNThrdwGzwZw=; b=Kq+K1k9F436RI/uJVFRZNTbfjCAv7J/p+Zk4w9cxQ45CdW
	4u8N2uZLcc49NeZMsb9bMQyHcrek2povU5yHVNxMKZQcHbH1nQMpa6oyddES8j2i
	TocYMwvLmrk7XlpCGdmTchqU2KoG4eW8HkeZ+bzwYAKKROeHOAaFR2ESeIHfuKuf
	8PlKqfmelDi9s8EJRXLDOrjT23tzqiSQByZ+STYeG1jX5cs9DMdfNfGowEfBnjkI
	aCgJhmnNOsauaPT27/r0+l2+Xyc6NL2uVzj+9fkMKxRgKy6u4xj/lyyxQmo0cPnl
	FWMt6yw3O+6V6XRaDF7fZxRP1Of93OZlW8SgXrIg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gdnjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 09:23:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N9Je3a001354;
	Tue, 23 Jun 2026 09:23:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyj6a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 09:23:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N9N3Fr43581926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 09:23:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49D0720043;
	Tue, 23 Jun 2026 09:23:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52A2E2004B;
	Tue, 23 Jun 2026 09:23:01 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Jun 2026 09:23:01 +0000 (GMT)
Date: Tue, 23 Jun 2026 14:53:04 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/3] target/ppc/kvm: Use host compatibility mode for
 nested guests
Message-ID: <20260623145009.caa751f8-9a-amachhiw@linux.ibm.com>
Mail-Followup-To: Vaibhav Jain <vaibhav@linux.ibm.com>, 
	qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
	Glenn Miles <milesg@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	qemu-devel@nongnu.org
References: <20260616113915.25589-1-amachhiw@linux.ibm.com>
 <20260616113915.25589-4-amachhiw@linux.ibm.com>
 <87tsqybx39.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tsqybx39.fsf@vajain21.in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3a507c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=tPGWoPwWrlZebnym-z0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3NSBTYWx0ZWRfX4STSnRX7xIXy
 nxwFl102Ge08T1Ze8UgPusPPaQ4aWOhVOPNCGd5s7akuf23BP/AKCDV3PbAg/OQn31jMhriGsKG
 nJBiY6MWGl4eic7g5fU6VYMJuRWCLf2N+IpQr0wzPSCRSnJkE3b3P6wivykYcHtfHTpm+lWEQuk
 EJI7/89on4YibtPzzPRmRFhEebobyJz5Yv48XVtsLzsPcZNB4F4Cml+IvEXlg8YZUX0npijStj+
 T7tXn7LrMumcPRuPYasRee21/0os/V76/G/FnKlvWL0WnW0X8WU1LHy2PhUXaGSxORMYtR9ubrT
 V8XvSh7B4p4DykB5X/7jBgRUrBZw9mPh9p47KW0AZ6pK46LcNUuQ4JuQ23lLRSJOfZSm9zZP01P
 fosUfuUNLVB5Kdhp39sdx9eS/dHJ9A==
X-Proofpoint-GUID: 9Xl24Vao034gVEvNYhpmp2kFPWnkg5tr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3NSBTYWx0ZWRfX58eRuSshmiei
 Wt8NN3ZIhptlbN+pMrGeKoKl4jpt/9qRhAC/5dfCm3EOlDygmu8Kvq0a1h94q+JNqFX3GSpIkVd
 3pYV0H/r+jveUj892sAbsV4kRriv56o=
X-Proofpoint-ORIG-GUID: nv2J2eB3QR4MOpHdLCGI-36W5QonI0MO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606230075

Hi Vaibhav,

Thanks for reviewing the patch. Please find my response below.

On 2026/06/19 04:45 PM, Vaibhav Jain wrote:
> Hi Amit,
> 
> Thanks for the patch. My review comments inline below:
> 
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > On POWER systems, the host CPU may run in a compatibility mode (e.g.,
> > a Power11 processor operating in Power10 compatibility mode). When
> > running nested KVM guests, QEMU currently derives the host CPU type
> > using mfpvr(), which reflects the physical processor version. This can
> > result in a mismatch between the CPU model used by QEMU and the
> > compatibility mode enforced by the host, leading to guest boot failures
> > such as "KVM-NESTEDv2: couldn't set guest wide elements".
> >
> > Update kvm_ppc_get_host_cpu_class() to check if the host is running in
> > a compatibility mode using kvm_ppc_host_compat_pvr(). When available,
> > use the compatibility PVR instead of the raw hardware PVR when selecting
> > the CPU model. This ensures that QEMU selects a CPU model consistent
> > with the host compatibility mode, allowing nested guests to boot
> > correctly.
> >
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >  target/ppc/kvm.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 9e5006e0c2cd..a72f237f0c8a 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2672,6 +2672,15 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
> >      uint32_t host_pvr = mfpvr();
> >      PowerPCCPUClass *pvr_pcc;
> >  
> > +#if defined(TARGET_PPC64)
> Use CONFIG_KVM

As I mentioned in the response to previous patch's review comments, the
TARGET_PPC64 guard is needed to fix ppc32 build breakage, and CONFIG_KVM
would be redundant since target/ppc/kvm.c is only compiled when
CONFIG_KVM=y.

Thanks,
Amit

> 
> > +    uint32_t compat_host_pvr;
> > +
> > +    compat_host_pvr = kvm_ppc_host_compat_pvr();
> > +    if (compat_host_pvr) {
> > +        host_pvr = compat_host_pvr;
> > +    }
> > +#endif /* TARGET_PPC64 */
> > +
> >      pvr_pcc = ppc_cpu_class_by_pvr(host_pvr);
> >      if (pvr_pcc == NULL) {
> >          pvr_pcc = ppc_cpu_class_by_pvr_mask(host_pvr);
> > -- 
> > 2.50.1 (Apple Git-155)
> >
> >
> 
> -- 
> Cheers
> ~ Vaibhav
