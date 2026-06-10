Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235C129D291;
	Wed, 10 Jun 2026 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106733; cv=none; b=punp06V+1Vc04fTEDcTZit0TgVTcZeHi3sa4YHMRLfBCMi45ywavyrTzAVEWUxqUOmPTmoh12bH0sxUFTHOZI1eqb7qIKEgYC6MWnFNGT88L4RS5z66P+WKtO7T5VLHobUGeWzxrNBTseUjLetvzgClQRUdVuRRRZdqZ+ciM890=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106733; c=relaxed/simple;
	bh=eHH0zlwmngCSs/hziX/jCixhLgqCQLkRg3q4kYasCoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czyiHLREMj455EHwC0Q2lEsAt9aWX/1pF6wlIWoHIc4oPO/kVO0K3sMs/oO/o0JC2MIs0uQyiOBtLpM5+xGJ4nd+2HaBT4YkeIGf0uzEUhZhhwfMRcLXNC7YjXi/AOkMK6uclNaDjpTC1vpMKJ97eOL8rcWtxm52nMdFi0WLdmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cmN0YoMe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cmN0YoMe"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A3cVAU1458768;
	Wed, 10 Jun 2026 15:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qnSv+8DzM9eao3OqbP5ORykl9cJ7Wj
	jB5RtyUbnINGA=; b=cmN0YoMezaGL9GihUSJeG6HHKCKVDJpyxT6V+kkMdmGopk
	+DclGQoCOTtccfWQp8iLtwLHlFcaf4jzIAyWtrWN7Iw1vot6lIPNtNpWBDaBUgjx
	efYB9Jx5n3GBXaN8LZU/u5KMAJwrfiQwyx+JsbnHUL2XUxRxggd6sERS+nW4Lx+x
	+pzJtMlzmRymDXzo2qHGgl6MkXK99kNkuRmws6bc3Kry9Z1kU3PFWPVNqbbBM0qD
	Q7XPVjMeQ7QIoDJ5iIbDdChNQKLn1zMDjAGbPVgwSnxLMN9vqe1QOV4Pe9hLHAba
	L5ytg21ySGxceFY0sAdcXGg5k2pecMTxYKu6mXhw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb95hvan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 15:51:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AFna9w010151;
	Wed, 10 Jun 2026 15:51:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq7exx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 15:51:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AFplGB40698132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 15:51:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 920662004D;
	Wed, 10 Jun 2026 15:51:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5C1E20040;
	Wed, 10 Jun 2026 15:51:44 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Jun 2026 15:51:44 +0000 (GMT)
Date: Wed, 10 Jun 2026 21:21:46 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v3 3/5] KVM: PPC: Book3S HV: Implement compat CPU
 capability retrieval for KVM on PowerVM
Message-ID: <20260610211740.b4b75f3b-ba-amachhiw@linux.ibm.com>
Mail-Followup-To: Vaibhav Jain <vaibhav@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, lkp@intel.com
References: <20260522152744.55251-1-amachhiw@linux.ibm.com>
 <20260522152744.55251-4-amachhiw@linux.ibm.com>
 <87mrxcz300.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mrxcz300.fsf@vajain21.in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a298818 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=YJwquTfWpi-7YPPFYTYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: VjZH7_ymHKOPSEplpFekukwXaYZdc0YZ
X-Proofpoint-GUID: 3DNe3EZguYYZ44aEvVFpND0VA4IKI6D-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE0OCBTYWx0ZWRfX8/BdK6KCgb5o
 IE4DIUr4++avyDeBMPe3vqQKi3OlzJlJn5x1mbvJ7ap92yegatBEihcXo0r8LfqFXty47E60jfv
 Co6hbf4sO9iYWn7RhawTM+rQ//wkub+dbjRVj6bbA2xyz7cxVhOC3guy/s2/41tp1IhRrkSzIF/
 EvthcAoofVQPz1zTLOoZGsCk9RfWySz0Pfz8o5R4ZO9+iqG0eyoVWOENzfZvUBfLkXDRyNSlcbg
 3OqYhONZrpsMhpghwPZIdocR9VZhnEk0vZN83eNVmHHKlG4KZ30tVj6c9qb2FtmE53jlmk2Kkc3
 gzFrQnMhknpB322qk59M8uKJYHErOy3tB0Ppk21tBno5grthGL533SlKUrvJVRxEFWExY6KPu1k
 1TBJnIkqZ0Zh+zjsji2PtIs0Zikqtarq8t8/YcnZ2wojB7U53APnbis+0LMPcO7eaqww5QaKAVX
 WjmvzRuS9fcJwg4tT5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100148

Hi Vaibhav,

Thanks for taking a look at this patch. My response is inline.

On 2026/06/03 09:31 AM, Vaibhav Jain wrote:
> Hi Amit,
> 
> Thanks for the patch. My review comments inline below:
> 
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
> > Add support for retrieving host CPU compatibility capabilities for
> > nested guests on PowerVM (PAPR nested API v2). The hypervisor provides
> > the effective compatibility levels via the H_GUEST_GET_CAPABILITIES
> > hcall, which reflects the processor modes negotiated between the Power
> > hypervisor (L0) and the host partition (L1).
> >
> > On pseries systems, obtain the capability bitmap using
> > plpar_guest_get_capabilities() and return it via struct
> > kvm_ppc_compat_caps. This information is then exposed to userspace
> > through the KVM_PPC_GET_COMPAT_CAPS ioctl.
> >
> > Hook the implementation into the Book3S HV kvmppc_ops so that it can be
> > invoked by the generic KVM ioctl handling code.
> >
> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >  arch/powerpc/kvm/book3s_hv.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 249d1f2e4e2c..38de7040e2b7 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -6522,6 +6522,21 @@ static bool kvmppc_hash_v3_possible(void)
> >  	return true;
> >  }
> >  
> > +
> > +static int kvmppc_get_compat_cpu_caps(struct kvm_ppc_compat_caps *host_caps)
> > +{
> > +	unsigned long capabilities = 0;
> > +	long rc = -EINVAL;
> > +
> > +	if (kvmhv_on_pseries()) {
> > +		if (kvmhv_is_nestedv2())
> > +			rc = plpar_guest_get_capabilities(0,
> > &capabilities);
> 
> since this value will trikle back to userspace please apply a mask on
> the hcall return value so that any reserved and non-PVR related bits
> doesnt leak back to userspace.

Though currently we only supply the bits corresponding to supported
processor versions, it makes sense to mask out unrelated bits so that
they don't unnecesarily passed on to the userspace. I'll make the
changes in v4.

Thanks,
Amit

> 
> > +		host_caps->compat_capabilities = capabilities;
> > +	}
> > +
> > +	return rc;
> > +}
> > +
> >  static struct kvmppc_ops kvm_ops_hv = {
> >  	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
> >  	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
> > @@ -6564,6 +6579,7 @@ static struct kvmppc_ops kvm_ops_hv = {
> >  	.hash_v3_possible = kvmppc_hash_v3_possible,
> >  	.create_vcpu_debugfs = kvmppc_arch_create_vcpu_debugfs_hv,
> >  	.create_vm_debugfs = kvmppc_arch_create_vm_debugfs_hv,
> > +	.get_compat_cpu_ver = kvmppc_get_compat_cpu_caps,
> >  };
> >  
> >  static int kvm_init_subcore_bitmap(void)
> > -- 
> > 2.50.1 (Apple Git-155)
> >
> >
> 
> -- 
> Cheers
> ~ Vaibhav
