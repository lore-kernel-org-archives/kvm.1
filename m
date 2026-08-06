Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE0D3A5E7A;
	Thu,  6 Aug 2026 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032883; cv=none; b=r/YGPk/BNd9xsuUSCREMEoNLEP61iiDUm/ZYj3rNUZHdhBVgxcfwzpjOvnYwHecWCWFct5wPa02NY5CM6KLwfVDxGvk/OOLC4mjp4ZAWUAAiISfY2C1zDL+cbImN3tWn5WfXbGXJSpmL+MeOUcK25+Yuv+Tf9qPHn1ve4rp/FcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032883; c=relaxed/simple;
	bh=b4pR8+WGAn1HO6dGeBhuF9aS+qDcdK7RbS9uiwPIEPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlLririhz92svGwFVI2ccizbk/ASRb951U4v16SIDPVrif+zBimNAaaQPxE+DiJLL08WZb6mwy4ImNaNG8+LRama91aM6cW9ppB8+OZBmPx/9G4zXtKkoaXeBCXLPzHfwGpCVxVw53f2TQwA5hGxoe7ZFyZz/aCTpf8AHpIJmuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lzZtW74h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lzZtW74h"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Enwor3014104;
	Thu, 6 Aug 2026 16:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=daHOpv
	f5mdNJBkB+0/AJXJ9TJwiwG8MI5z2OSVgnHIo=; b=lzZtW74hE2NBQPJrSi0QN/
	ilYguAAWyb38PN7jtCYAhyDlaSN5nx3w3Q12l50GZvlel9BGaxB80goCZIBvzc0x
	sn3YyXkpYOPg69zB8FeyChGbPjOnd/i1naMjvCoxX+i9K9glFGN41nylP94DHFeW
	XiQxrnAqvN94cw1ZgDO5PD9yKQhajKfs9sQDfsaBwJ3hb8komALhR288+yquv3ab
	zVgmpIB8RIM8HfSRb+akA3crE/qGDQvmAZUtHfAx9ySpqygZoxzLQEPJL3qGkafp
	AJujjraj93Rf48/QSyHnmzb5y6Fdten5D2ogefXeMYRU/YS6BsIGkTX8wsABScVw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8ev0hv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 16:14:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676GBFvx011988;
	Thu, 6 Aug 2026 16:14:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kbwkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 16:14:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676GEaPi31457754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 16:14:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DCFE20043;
	Thu,  6 Aug 2026 16:14:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D3E020040;
	Thu,  6 Aug 2026 16:14:35 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  6 Aug 2026 16:14:35 +0000 (GMT)
Date: Thu, 6 Aug 2026 21:45:24 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v6 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Message-ID: <20260806214458.c27578cf-84-amachhiw@linux.ibm.com>
Mail-Followup-To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
References: <20260804180705.59160-1-amachhiw@linux.ibm.com>
 <20260804180705.59160-5-amachhiw@linux.ibm.com>
 <20260804182718.DB3B01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804182718.DB3B01F00A3A@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Wfp1my9PYdQ9IuR9S15y9wb4RQ9Ht7An
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMiBTYWx0ZWRfX5b8ss3yWk9kC
 ewu4Ik6AkVSLyGvpwYY1iBlgP28LyZMMzXumukfmadHR/H8qI5KqefLMxSo4iSRG0tOixOAJuw2
 wYDnwH7MK7f4FkWcJXMlr325ZHbkC+0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMiBTYWx0ZWRfXwNv+/XL8IBsk
 Cn9KnYouZ6TlU9ueWXm0IWqzJz8jnPCIzY7l/aqPySBBwYB8remoqmqDaRJHXjNNszXFBibsRbV
 hztZSs3y/14n2lfmSZt6lKemsEew6V8MWMvEMLr2+UnMw6hc7UQdLTyrNyNhxvvrELrObeKvd3S
 A6SvbvXhcGymFWAwS/7sx5f/IQ/EIkxOwafKNgqt6RiV2upf7XEF5TLfCtGyu5V295/LCYF/fRc
 YBMbxUG/vvLIK0DQdJ+nREVVYINu54f0MajZnx+m2V6zF5WXBsXESM+zuVTbEa9M7rFfT9XLBCy
 63qmiEBzCM454hCJV874S6sAyXTYZp+0kTlLb0TWrJngel8RX/yiZY6TIIIwVqgJF5EasczNRqu
 5vHIW7LiHRracfXZAsDT/lVcFAS/u83vArQXFNBjkGZwNojxRYdQuWe4DhTXrHEi/AsqUWHekdV
 MZwBwneO+96jGzChuYg==
X-Proofpoint-GUID: Wfp1my9PYdQ9IuR9S15y9wb4RQ9Ht7An
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a74b2f0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=hHt5DYquJjdmILyaf9sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1011 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060122

On 2026/08/04 06:27 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Unconditional rejection of larger structs breaks the forward compatibility mechanism of copy_struct_from_user().
> - [High] Overwriting the userspace size field with the kernel's struct size creates dangerous ambiguities on success.
> --
> 
> --- Patch [4]: [PATCH v6 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl ---
> commit 5d4e2edcf1688edc6d21e5f2463ef8b58bd3d0a7
> Author: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
>     
> Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
> documentation. The documentation covers error code descriptions including
> E2BIG for forward compatibility and the extensible size-based versioning
> contract.
> 
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index e3003a241d5b0..22fedb0aa34b4 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -6566,6 +6566,85 @@ KVM_S390_KEYOP_SSKE
> >    Sets the storage key for the guest address ``guest_addr`` to the key
> >    specified in ``key``, returning the previous value in ``key``.
> >  
> > +4.145 KVM_PPC_GET_COMPAT_CAPS
> > +-----------------------------
> > +:Capability: KVM_CAP_PPC_COMPAT_CAPS
> > +:Architectures: powerpc
> > +:Type: vm ioctl
> > +:Parameters: struct kvm_ppc_compat_caps (in/out)
> > +:Returns: 0 on success, negative value on failure
> > +
> > +Errors include:
> > +
> > +  ======== ============================================================
> > +  EFAULT   if ``struct kvm_ppc_compat_caps`` cannot be read from or
> > +           written to userspace
> > +  EINVAL   if the ``size`` field is smaller than
> > +           ``KVM_PPC_COMPAT_CAPS_SIZE_VER0``, if the ``flags`` field
> > +           is non-zero, or if the backend fails to retrieve or map
> > +           CPU compatibility capabilities
> > +  E2BIG    if ``size`` is larger than the kernel's struct size
> > +           (new userspace on old kernel); the kernel writes back its
> > +           own struct size into the ``size`` field so userspace can
> > +           retry with the correct size
> 
> [Severity: High]
> Does explicitly rejecting a larger struct size with -E2BIG break the standard
> forward compatibility mechanism of copy_struct_from_user()?

These are the same concerns raised on patch 1/4 — please see the
response there. In summary: the pre-check is necessary for
stack-allocated structs, and the size field update follows the
documented versioning contract for extensible structs.

> 
> Extensible struct UAPIs are designed to allow newer userspace to run seamlessly
> on older kernels as long as new fields are zeroed. 
> 
> Looking at arch/powerpc/kvm/powerpc.c in kvm_arch_vm_ioctl(), the code
> short-circuits the native trailing-zero check in copy_struct_from_user():
> 
> 		if (usize > sizeof(host_caps)) {
> 			host_caps.size = sizeof(host_caps);
> 			r = -EFAULT;
> 			if (put_user(host_caps.size, (__u64 __user *)argp))
> 				goto out;
> 			r = -E2BIG;
> 			goto out;
> 		}
> 
> This forces userspace to implement fallback retry loops instead of relying on
> the kernel's native UAPI extensibility.
> 
> [ ... ]
> 
> > +Before calling this ioctl, userspace must set the ``size`` field to
> > +``sizeof(struct kvm_ppc_compat_caps)`` and zero the ``flags`` field.
> > +The kernel rejects non-zero ``flags`` with ``-EINVAL`` to prevent
> > +uninitialized stack values from being silently accepted, keeping the
> > +field available for future use without ABI ambiguity.
> > +
> > +The ioctl uses ``copy_struct_from_user()`` and ``copy_struct_to_user()``
> > +to support extensible versioning: if userspace passes a struct smaller
> > +than the current kernel version (``size >= KVM_PPC_COMPAT_CAPS_SIZE_VER0``),
> > +the kernel zero-pads unknown trailing fields. If userspace passes a larger
> > +struct (``size > sizeof(struct kvm_ppc_compat_caps)``), the kernel writes
> > +back its own struct size into the ``size`` field and returns ``-E2BIG``,
> > +allowing userspace to discover the kernel's struct size and retry.
> 
> [Severity: High]
> Can overwriting the userspace size field with the kernel's struct size create
> dangerous ambiguities on success?
> 
> If userspace passes a smaller struct (e.g., 24 bytes) and the kernel uses a
> larger struct (e.g., 32 bytes), the kernel updates host_caps.size to 32 and
> copies 24 bytes back to userspace.
> 
> Looking at arch/powerpc/kvm/powerpc.c in kvm_arch_vm_ioctl():
> 
> 		host_caps.size = sizeof(host_caps);
> 		r = copy_struct_to_user(argp, usize, &host_caps,
> 					sizeof(host_caps), NULL);
> 
> Userspace would receive a success code (0) but its size field is now 32. This
> falsely indicates to userspace that the kernel provided 32 bytes of valid data,
> which can lead to out-of-bounds reads if userspace trusts the returned size
> field to determine valid data bounds within its buffer.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260804180705.59160-1-amachhiw@linux.ibm.com?part=4
