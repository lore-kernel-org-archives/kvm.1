Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7856223E325;
	Thu,  6 Aug 2026 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032398; cv=none; b=aFtCuYMwTRXRifzPheNyITY/5UL3wTeZsjKicRwe4zhi0bNDJMY7tF6o7HoiGC+/H2A+7OH3Wgoy1B/60DMYmDz8/LMQyDwCpR66R4lDrt7xL4dNWixk188xc8xVz/Z6lZi4AXYm/jBEUtPdI2RLcZ0U8peeu5jl95TMwnUPqnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032398; c=relaxed/simple;
	bh=EDNffItBrzBc2yFrQyApte0aDzP2Cz9QaErcHpzLVKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTl00GPl8xoK2pGiIeYI1o8bpnDV/RkXmgeHdu67/vpMJT4SMeWuJJpGJrs80/2I7FXuKysm9vpBkkaDrP6lOghqRspyu/DjncC23kiEIrs8Rcn02sHUvpnAXQDWVKN9lWgL/oeC6MOJbp4Ra8wsNiNXMFT6kkzdjgGlJLyMjV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bi0TCVdR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bi0TCVdR"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676En46L2939450;
	Thu, 6 Aug 2026 16:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mzGEVm
	etbGjsMDpWjtcnXUBmusbrgdkIn6JsyNh8xeY=; b=Bi0TCVdR5/z62UjrWOQdce
	UpuYimmGOp8jHzYBZY6gYtXZYXFcGFww/Up1dRxrQcSA3uREFRwRKFREdoIR+E1g
	w1GB7UgZbZlwTeNtkmZS76KlfUg8YuKzEhsAvNs6vIBe/SvGKIzx+NuB1a18OE4x
	jVb6swfTTWImK9dxTxfhD7McMLCwkmXLrSvSecPT6fJszukd8Jlvfrc+iQKpS3wl
	aeUm7GJ/4kGVFwt5zi5EQK7B2Ne001jQClOFuImmNoaOgLR0jxSV7//ZkmqHj75Q
	kMJdVx29hkSwp/52twli25ijLh/cLDy/7gcmr+8UmeNgErgmmZ7zbgWXN4BDULhg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a495d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 16:06:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676FuI78027270;
	Thu, 6 Aug 2026 16:06:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyunfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 16:06:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676G6Uwn17367424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 16:06:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FEDF20049;
	Thu,  6 Aug 2026 16:06:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A75D420040;
	Thu,  6 Aug 2026 16:06:29 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  6 Aug 2026 16:06:29 +0000 (GMT)
Date: Thu, 6 Aug 2026 21:37:19 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v6 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 wire up ioctl
Message-ID: <20260806211428.e98e021d-5c-amachhiw@linux.ibm.com>
Mail-Followup-To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
References: <20260804180705.59160-1-amachhiw@linux.ibm.com>
 <20260804180705.59160-2-amachhiw@linux.ibm.com>
 <20260804181937.2EF2A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804181937.2EF2A1F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a74b10b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=WvqGrGUc94HQVLc0aSkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: SXJwvlrgoFFVVsUN-1U6vXnC9LHlGu4A
X-Proofpoint-GUID: SXJwvlrgoFFVVsUN-1U6vXnC9LHlGu4A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMiBTYWx0ZWRfX6OJF3iZcJm3Y
 UxtuyO1rsVkUeeaeAl6DNXCCYadXVBIjw801obXMdwEx8rcq7rNEvz6iFReMYQKxY7CEaW/fcFL
 O0dT8GMQFh4IEkaH7CaYJXl7omLHroE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMiBTYWx0ZWRfXyMxso1R3AK8A
 reYE8iG6RLY4eDm1szYdBRp7X3b6Cd/0n0QgDViTLi3hEOOR1WvsnVtvLrqac6iW3vm9CUjgZHE
 JL0doqsjORZfhxyTiHZSc5x2kcFvhLUoBPr/6CEiM1BKlaTlOTefocrUjgtIcPcJSlxH2SKCWTX
 rWneTeFxu1EyNexlpAJ6h0+uJqJlfc4JlhIBo9LqggwXkhhBfv/Wyxk1l47fWXYpoMQEoWCCXeT
 2LdzSM8njD8ouLdWQ+xlpgfttMjIVJs06xZp24QOCoiJ9sLTNChE1vdeFHSvaZ7QKYXSrgK3pQN
 qYp2Zng6TgxcPc4FEaqfL7uZdji+ZtzHTKWvMpGTpa5BM3DQZy1cBWnPEqS+NO4LIyWDr87fbff
 az7IDvXKwSzPx2JgGtwF0pXl+aOKNlzxf23gSPHZaSxZN6KLLPC5fAfE93ILuJsoKqA2UbwJ+4y
 Fi3leOhJH71XBR1zKZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060122

On 2026/08/04 06:19 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] The ioctl artificially inflates the userspace struct's `size` field on success, creating a memory corruption trap if userspace reuses the struct.
> - [High] The ioctl unconditionally rejects larger structs with -E2BIG, bypassing standard UAPI zero-checking and encouraging silent input truncation.
> - [Medium] The KVM_PPC_GET_COMPAT_CAPS ioctl availability is decoupled from its KVM_CAP_PPC_COMPAT_CAPS capability, breaking capability negotiation and bisectability.
> --
> 
> --- Patch [1]: [PATCH v6 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl ---
> commit bcf86bb5d3079ca2dbb4bf09693ba6e6a24b06c5
> Author: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
> 
> This commit introduces a new capability and ioctl to expose CPU compatibility
> modes supported by the host processor for nested guests.
> 
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index 00302399fc37b..8d6632c64ca5f 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -697,6 +697,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >  			}
> >  		}
> >  		break;
> > +#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
> > +	case KVM_CAP_PPC_COMPAT_CAPS:
> > +		r = 0;
> > +		if (kvmhv_on_pseries())
> > +			r = 1;
> > +		break;
> 
> [Severity: Medium]
> Is this capability check fully aligned with the ioctl's availability?
> 
> This check returns 1 on a pseries host using PR KVM (since it misses the
> hv_enabled check), but the ioctl might fail with -ENOTTY if the backend
> is missing.

Looking closely, it looks like a good catch. PPC kernels can be built
both KVM-PR and as well KVM-HV config enabled. Though at one point in
time only one of kvm-pr and kvm-hv can be loaded, a PR KVM guest on a
pseries system can see cap=1 but then get -ENOTTY from the ioctl
(thought the documentation explicitly covers this case: "ENOTTY if the
backend does not implement the get_compat_caps operation (e.g., on
non-HV KVM implementations). But anyway, I'll fix in v7:

	case KVM_CAP_PPC_COMPAT_CAPS:
		r = 0;
		if (hv_enabled && kvmhv_on_pseries())
			r = 1;
		break;

> 
> Later in the ioctl execution, it succeeds on a bare-metal host using HV KVM
> (missing the kvmhv_on_pseries() check) even though this capability check
> would return 0.

On bare-metal, kvmhv_on_pseries() is false (CPU_FTR_HVMODE is set), so
the cap correctly returns 0 there regardless of hv_enabled. The ioctl is
only meaningful on pseries (PAPR guests) where KVM acts as L1 under a
hypervisor, which is why both conditions are required

> 
> Could this decoupling between the capability and the ioctl availability break
> capability negotiation for userspace?
> 
> > +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
> >  	default:
> >  		r = 0;
> >  		break;
> 
> [ ... ]
> 
> > @@ -2463,6 +2470,70 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> >  		r = kvm->arch.kvm_ops->svm_off(kvm);
> >  		break;
> >  	}
> > +	case KVM_PPC_GET_COMPAT_CAPS: {
> > +		struct kvm_ppc_compat_caps host_caps = {};
> > +		u64 usize;
> > +
> > +		/*
> > +		 * Read the size field first to drive copy_struct_from_user.
> > +		 * size must be the first field of the struct.
> > +		 */
> > +		r = -EFAULT;
> > +		if (get_user(usize, (__u64 __user *)argp))
> > +			goto out;
> > +
> > +		/*
> > +		 * Enforce a minimum: reject buffers smaller than the initial
> > +		 * struct version (VER0). This allows old userspace compiled
> > +		 * against the original struct to still work on a newer kernel
> > +		 * that has grown the struct with appended fields.
> > +		 */
> > +		r = -EINVAL;
> > +		if (usize < KVM_PPC_COMPAT_CAPS_SIZE_VER0)
> > +			goto out;
> > +
> > +		/*
> > +		 * New userspace with a larger struct called an older kernel.
> > +		 * Write back ksize in host_caps.size so userspace knows which
> > +		 * older struct to retry with, then fail with -E2BIG.
> > +		 */
> > +		if (usize > sizeof(host_caps)) {
> > +			host_caps.size = sizeof(host_caps);
> > +			r = -EFAULT;
> > +			if (put_user(host_caps.size, (__u64 __user *)argp))
> > +				goto out;
> > +			r = -E2BIG;
> > +			goto out;
> > +		}
> 
> [Severity: High]
> Does explicitly rejecting larger structs here bypass the standard UAPI
> zero-checking?

The pre-check `usize > sizeof(host_caps)` is required, not a bypass. The
-E2BIG path writes back ksize so userspace can discover the kernel's
size and retry explicitly. Userspace that retries with the smaller size
is making a deliberate choice to use the older interface; the kernel
cannot have seen the truncated extra fields, so there is nothing
silently ignored. copy_struct_from_user() itself would also return
-E2BIG for non-zero trailing bytes — but it cannot be called safely with
an arbitrary usize against a fixed-size kernel struct.

> 
> By catching usize > sizeof(host_caps) early and returning -E2BIG, the code
> bypasses copy_struct_from_user()'s built-in validation which would safely
> reject non-zero extended fields.
> 
> If userspace receives the smaller kernel size and retries by truncating its
> buffer size, the kernel will only read the truncated portion, silently
> ignoring any non-zero extended fields that userspace originally provided.
> 
> Should this rely on copy_struct_from_user() to safely check zeroed trailing
> bytes instead?
> 
> > +
> > +		/*
> > +		 * copy_struct_from_user() handles forward/backward compat:
> > +		 *   usize == ksize: verbatim copy
> > +		 *   usize <  ksize: zero-pad trailing (old userspace, new kernel)
> > +		 */
> > +		r = copy_struct_from_user(&host_caps, sizeof(host_caps),
> > +					  argp, usize);
> > +		if (r)
> > +			goto out;
> > +
> > +		/* Reserved fields must be zero */
> > +		r = -EINVAL;
> > +		if (host_caps.flags)
> > +			goto out;
> > +
> > +		r = -ENOTTY;
> > +		if (!kvm->arch.kvm_ops->get_compat_caps)
> > +			goto out;
> > +
> > +		r = kvm->arch.kvm_ops->get_compat_caps(&host_caps);
> > +		if (r)
> > +			goto out;
> > +
> > +		host_caps.size = sizeof(host_caps);
> > +		r = copy_struct_to_user(argp, usize, &host_caps,
> > +					sizeof(host_caps), NULL);
> 
> [Severity: High]
> Can this artificial size inflation cause an out-of-bounds read/write if
> userspace reuses the struct?
> 
> If an older userspace passes a smaller struct to a newer kernel (where
> usize < sizeof(host_caps)), the kernel sets host_caps.size to its own larger
> size. It then copies the smaller usize bytes back, overwriting the userspace
> size field with the kernel's larger size.
> 
> If userspace reuses this struct for a subsequent ioctl call, it will now pass
> the larger size. The kernel would then read past the end of the originally
> allocated userspace buffer, and if successful, write back past the end
> as well.

Not a bug. `copy_struct_to_user(argp, usize, &host_caps,
sizeof(host_caps), NULL)` copies min(usize, ksize) bytes back to
userspace. Today usize == ksize == 24, so exactly 24 bytes are written.
In a future kernel where ksize grows, the function correctly copies only
usize bytes (old userspace case), meaning userspace sees its own size
field reflected back — not the kernel's larger size. The kernel sets
host_caps.size = sizeof(host_caps) in the kernel-side copy so that the
output `size` field documents the kernel's struct version when it is
within the copied range, which is the designed semantics for versioned
structs. No out-of-bounds access occurs.

> 
> > +		break;
> > +	}
> >  	default: {
> >  		struct kvm *kvm = filp->private_data;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260804180705.59160-1-amachhiw@linux.ibm.com?part=1
