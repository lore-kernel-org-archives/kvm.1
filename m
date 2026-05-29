Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577BC348C4E;
	Fri, 29 May 2026 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062787; cv=none; b=S3/sXvpLsW4BLPXidq/GBLz51cjqpVOwyD1y/hGlmu2hb+g7iXmXjCvDbVHLo8MbrhSg7bS9Y9ZgnAwZq0u9pPIw1yAb/zuStRd4BdfBrCrt3OkGTU+fh/dG1TjUa4yS1dBbUtiGN2aXLHhvwtERXQnCCndrUTgSbYGpN8whaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062787; c=relaxed/simple;
	bh=jN6q13cCMdBqCnZ0YJPf2rSqYL4pTXX09THl5R00o/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlVEku2aaGNqNmrzE7BJBq38MoyhyP1F/c9s4egBYL7xkRKQLDCr2NbefeQmkm847TeXyfVX8ia+zCKxzxQFzO1aCguRRWf7WcAJLs2IWF1c91CzV/p0S6BJelXzMHx82aBia88cEz58LHL1Dgqwdc8qIVJ9TTlT2xi53ebDtfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HHmWY+bh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HHmWY+bh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TB1SGk2776290;
	Fri, 29 May 2026 13:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9sxXUl
	X0Sw+lvi00afE77OBjTvC27VlMXkRJdze7KW0=; b=HHmWY+bhdDdTHTVznOdd0m
	ZidPJ0b/jszsu3BNXU9NB78ZgNilOUm0h4XqjU5KTH5wAJoNjhwq+EltKcE4JlXC
	5qry5nRuftvCVq2ehlPR0mdDy6LtoqePLcUHSVJP3vV9MN58fydfiKpOsAuRY4h8
	IGSF9o4A/E7vAct0RIsJ6cSnGuDLxeiRd8ImVDaR7XzsOgshIJ7KE/ZMqmlfPtwp
	izrFRlnPSzdV1bo0RTf8EWEeHICVaiRd2GHH5KTvybqFqHmValhKfqKzB6avR8R7
	eIB9SuREtjCImflkZf5+o5430gTectB7KpKG34KOdbmUPDs2hhEJmORIv1ksxGQg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889gjyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 13:53:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TDdCJQ020572;
	Fri, 29 May 2026 13:53:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbduck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 13:53:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TDqwIw49742140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 13:52:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3061320043;
	Fri, 29 May 2026 13:52:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 315B720040;
	Fri, 29 May 2026 13:52:57 +0000 (GMT)
Received: from Amits-MacBook-Pro.local (unknown [9.123.0.51])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 May 2026 13:52:56 +0000 (GMT)
Date: Fri, 29 May 2026 19:22:53 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v3 5/5] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Message-ID: <20260529190750.69cc6577-e6-amachhiw@linux.ibm.com>
Mail-Followup-To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
References: <20260522152744.55251-6-amachhiw@linux.ibm.com>
 <20260522175602.9064B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522175602.9064B1F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hOV5HFNlCPRNs4OAqiw3vXFk_uZSG17q
X-Proofpoint-GUID: hOV5HFNlCPRNs4OAqiw3vXFk_uZSG17q
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a199a3e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=c92rfblmAAAA:8 a=FPN5NLQJRj0HrcRoAXcA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEzNiBTYWx0ZWRfX9penM0XgimCY
 /KIackb0ODnHbWVkLC+kDsXAh0OYs247/8r62NXlnUO63rZ1fjMmDZuDf/n8K87Rb6YvOoEnSck
 fnoH2tpGAVLkusWfLvlzVRapTjOO5sg5r5Z3qALmpkZ+qQHDnDPE3jyrL5joDHrimEr4kPHj9KK
 DXAuY1Q7jiPj3FAEE36BTbpTL2sPU8o4m3egZWX1Re5vuR7tIw6a/AidppWe+FAJ8eTASbZ/E2r
 XJNGV3SYpN1ySjOcaB1Ulis/hwFy1nlVjqu+ANFSecnkHiBFQEIBkXPTRweh46+dQ+jVxfjK1Nz
 ZRmVixvCe9ilxYkZKmGRlriJs4kuSs5UWLHAo8hM6UnTea6u2ZKQcZLy4h/T1QohnX0kAJZD9GP
 DJ9znTOf8v+vkLZ8VITRuV2l3LTgGJJr7FzKz/kx/qyNLWa7h9aZU3jQ5xBVNCADEbFwGxzDlNK
 7U4FhdqXksVpi0yOfnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290136

On 2026/05/22 05:56 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Macros referenced in the user-facing API documentation are missing from UAPI headers.
> - [Medium] The documentation uses ambiguous and non-standard bit numbering (MSB-0), likely causing userspace to check the wrong bits.
> - [Low] The new documentation section breaks the existing `.. _kvm_run:` reStructuredText anchor target.
> - [Low] The documented return values omit multiple valid error codes natively returned by the ioctl (-EINVAL, -ENOTTY).
> 
> Pre-existing issues:
> - [High] kvmppc_map_compat_capabilities under-reports supported compatibility modes on APIv1 platforms.
> --
> 
> commit 72ed781761ff2f69a81eff7405946f0c54c590e0
> Author: Amit Machhiwal <amachhiw@linux.ibm.com>
> KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
> 
> This commit adds documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the
> KVM API documentation. It describes the compatibility modes supported for
> nested KVM guests on PowerPC systems.
> 
> Link: https://lore.kernel.org/oe-kbuild-all/202605140717.W1StD3Ke-lkp@intel.com/
> 
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index 52bbbb553ce10..d11e054e6665c 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -6555,6 +6555,41 @@ KVM_S390_KEYOP_SSKE
> >  
> >  .. _kvm_run:
> >  
> > +4.145 KVM_PPC_GET_COMPAT_CAPS
> > +-----------------------------
> 
> [Severity: Low]
> Does inserting the new section here break the rST anchor target?
> 
> By placing the new section directly after the .. _kvm_run: anchor, cross
> references to the kvm_run anchor throughout the documentation will jump
> to this new 4.145 section instead of section 5.

Yes, it got overlooked. I'll fix this is next version.

> 
> > +:Capability: KVM_CAP_PPC_COMPAT_CAPS
> > +:Architectures: powerpc
> > +:Type: vm ioctl
> > +:Parameters: struct kvm_ppc_compat_caps (out)
> > +:Returns:
> > +	0 on successful completion,
> > +	-EFAULT if ``struct kvm_ppc_compat_caps`` cannot be written
> 
> [Severity: Low]
> Should this documentation also include -EINVAL and -ENOTTY?

Yes, I missed to include -ENOTTY from the change in my previous version. Looked
more closely and we do return -EINVAL from one path. I'll document that too in
the next version.

> The kernel implementation explicitly returns -ENOTTY if the underlying
> architecture callback is unsupported, and returns -EINVAL if capabilities
> cannot be mapped or the CPU version cannot be parsed.
> 
> > +
> > +IBM POWER system server-based processors provide a compatibility mode feature
> > +where an Nth generation processor can operate in modes consistent with earlier
> > +generations such as (N-1) and (N-2).
> > +
> > +This ioctl provides userspace with information about the CPU compatibility modes
> > +supported by the current host processor for booting the nested KVM guests on
> > +PowerNV (KVM nested APIv1) and PowerVM (KVM nested APIv2) platforms.
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the APIv1 implementation
> of kvmppc_map_compat_capabilities under-report supported compatibility modes?
> 
> The underlying implementation for APIv1 nested KVM uses a switch statement
> with breaks that only sets a single bit matching the host's native generation.
> 
> Because backward compatibility modes are missed, QEMU might erroneously
> conclude the host does not support older guests.

No, its currenlty intentionally done for APIv1. I had responded to a similar
query here:

  https://lore.kernel.org/all/20260507202740.96fb259f-22-amachhiw@linux.ibm.com/

> 
> > +
> > +::
> > +
> > +  struct kvm_ppc_compat_caps {
> > +	__u64	flags;			/* Reserved for future use */
> > +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> > +  };
> > +
> > +The ``compat_capabilities`` bit field describes the processor compatibility
> > +modes supported by the host. For example, the following bits indicate support
> > +for specific processor modes.
> > +
> > +::
> > +
> > +  H_GUEST_CAP_POWER9  (bit 1): KVM guests can run in Power9 processor mode
> > +  H_GUEST_CAP_POWER10 (bit 2): KVM guests can run in Power10 processor mode
> > +  H_GUEST_CAP_POWER11 (bit 3): KVM guests can run in Power11 processor mode
> 
> [Severity: Medium]
> Are these macros exported to include/uapi/linux/kvm.h?
> 
> The documentation directs userspace to interpret the bitmask using macros
> like H_GUEST_CAP_POWER9. However, these are defined exclusively in the
> kernel-internal header arch/powerpc/include/asm/hvcall.h. This forces
> userspace to hardcode internal kernel values.

These macro names (H_GUEST_CAP_*) are for documentation clarity only. Userspace
should use the bit numbers directly as these macros are not exported to UAPI
headers.

> 
> [Severity: Medium]
> Will the bit numbering here mislead userspace developers?
> 
> The documentation specifies capabilities as (bit 1), (bit 2), etc., which
> implies standard LSB-0 numbering. However, the KVM implementation uses IBM's
> MSB-0 bit numbering, where H_GUEST_CAP_POWER9 is defined as (1UL << (63 - 1)).

I'll add a note clarifying that IBM PowerPC uses MSB-0 bit numbering (bit 0 =
most significant), so bit 1 corresponds to (1UL << (63 -1 )).

Thanks,
Amit

> >  5. The kvm_run structure
> >  ========================
> >
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260522152744.55251-1-amachhiw@linux.ibm.com?part=5
