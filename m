Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D55418379;
	Fri,  7 Aug 2026 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786109817; cv=none; b=eiHOyuoraGvLbLx7KNrFA9fJ9ObGvT2lyQ+mpbnRhLnHxRFNWSq9qdAHWDDxf4O66oXm+L8V3F8v0sWSfNR6jNnUI1KwctIcTQra7ZB7SaZZTMufqTMZ2Xa5L+lNLNiTHmA12a7KyF1RicSg4xPR/jYBknzuQDprCw3XVH3wxe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786109817; c=relaxed/simple;
	bh=sT3ahbnXMZ9t4rpM3gumL3uV+Sh9Kwfc03FGq3Rg9VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWp4DkqhHNn0Rkd856pLvmVC56ik5hPy9pnesAUZDLQgVLAKUcC/cOS/jA9/O5G8jAWGC1KbQ72N+w7UwjJoxQ8X2AQNm4cDBo5SdgjRJAHKIR5ZR60ZUHZ1SCQ44FUG+Xoy18T926KdtaE8lzFHsIAfyicBYAn3tSR7eQowzbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fxwphvE6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fxwphvE6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CmDVT1421031;
	Fri, 7 Aug 2026 13:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GRECM3
	GaZ88UcMsGphWUSnPzgHK78b9b/X3diBFUWF0=; b=fxwphvE69kd8Rsdd2meZFX
	LHd+cRNVUNYU+gWdICPmpzTu4oXDr5Doxy4qSK6tNASuULdNlz5FEvrpdpGJ/Gcp
	UgHphmbvaVLzCoqLdWEzagUDpXSQ4NALle7F2hBiHaHO8OooAPm75waCigdXBAjq
	vCCsa4wHIgR2ckOZtUOOFhY004LTuJuuJxA75OKtj1siRUEvM2mPAqvqx2EfLoG3
	0gpVkqBDHCqd1c8JLBgnQCGuHlhSiZ4UU+MKM8vuC+x4WJwGLz+0iHgERuPgNuP8
	qjwNbJmsI2Yo81XmIG9g46jx/LQC/qQS6q5ZCBdTtjN8v7pz7RE+t/EGR6lMyBkg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy023yy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 13:36:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677DQFM6004958;
	Fri, 7 Aug 2026 13:36:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyynf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 13:36:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677DaSnD33685970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 13:36:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F61D2004D;
	Fri,  7 Aug 2026 13:36:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13ACD2004B;
	Fri,  7 Aug 2026 13:36:25 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 13:36:24 +0000 (GMT)
Date: Fri, 7 Aug 2026 19:06:32 +0530
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
Subject: Re: [PATCH v7 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Message-ID: <20260807185102.b3807c34-a8-amachhiw@linux.ibm.com>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Gautam Menghani <gautam@linux.ibm.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com>
 <20260806170645.11892-5-amachhiw@linux.ibm.com>
 <cxvulf91.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cxvulf91.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: sVVC1MnJZ-kV-8nwVDu8p3dp1pmf0Moq
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a75df61 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=81Yfd86rcNwulvXOhKAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wT5zWtdpfvI_3BJ54menIOVcETZS2LHo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEwNCBTYWx0ZWRfX3k7yAoEMrCNv
 lswZP5K5MBg9r23PT7c3/4kFOJgcFszwZKtwBhfFn7QRT7pM8IxQYCoVdUTQFUewjue8IXlmsxI
 zAaCcQXelu7ra1d+okQyHofCJAYGO6TK7WKdtcdY2pczO683OMX4XHBvZN36htxcmP/1Eev5n47
 HUABImq7afMCY6QktCDuM/qEEP8FjxY8YIwFk77S4nC9E1pUwKhvL4yek3CMe8yib3vxBL+9/JN
 3IxcCHs3DHRCLnyw6Gh5kJcVA+HuHANDV7vH14gsebqhmi9QelEBoxtYTL6p2gYe5P+cDc/DRK3
 5vrjSx2ob7UxjH41KNRAYEfxK2BJ74djqzjx3EBpSPJ2saLm46lOdURzy9vrLQppX9HQo7DoLf1
 Yx2azFv5m+f3A/ECOzAnqEKVHEtHobAGJCs1DsTkAkCqyke6qk/1AdvBkzBIlUfSTSjo8C/1RMH
 N+cB0A20/eRUZdPxIOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEwNCBTYWx0ZWRfX5jeqg34ma6/D
 zNuFy5VShU6ZnEC+qmUxmodIa+cjcm6VPhl502Eqa94yA6ee8HlbJ3sIfS7P/2HNqw+/wJqgHqN
 q0MvA85m2Ww76DNIVtk1WhxBExeyVzI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070104

On 2026/08/07 10:05 AM, Ritesh Harjani wrote:
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
> > documentation.
> >
> > The ioctl exposes host processor compatibility modes supported for
> > nested KVM guests on PowerPC systems. The documentation covers error
> > code descriptions including E2BIG for forward compatibility, the
> > extensible size-based versioning contract using
> > KVM_PPC_COMPAT_CAPS_SIZE_VER0, the rationale for rejecting non-zero
> > reserved fields to prevent ABI ambiguity, bit numbering clarification
> > for IBM MSB-0 convention, and KVM-specific capability bit constants.
> >
> > Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> > Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >  Documentation/virt/kvm/api.rst | 79 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> >
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index e3003a241d5b..22fedb0aa34b 100644
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
> > +  ENOTTY   if the backend does not implement the ``get_compat_caps``
> > +           operation (e.g., on non-HV KVM implementations where the
> > +           required KVM operations are not available)
> 
> Amit, this may not be true anymore right after your changes in v7?
> Can we please update the documentation accordingly as well.

Agreed. After dropping the manual pre-check in patch-1 and delegating to
copy_struct_from_user(), -E2BIG is no longer unconditional when usize >
ksize — it only fires if the unknown trailing bytes are non-zero. Will
update the E2BIG entry to:

  E2BIG    if ``size`` is larger than the kernel's struct size and
           the unknown trailing bytes are non-zero (new userspace on
           old kernel with non-default fields set); the kernel writes
           back its own struct size into the ``size`` field so
           userspace can retry with the correct size

> 
> > +  ======== ============================================================
> > +
> > +IBM POWER system server-based processors provide a compatibility mode feature
> > +where an Nth generation processor can operate in modes consistent with earlier
> > +generations such as (N-1) and (N-2).
> > +
> > +This ioctl provides userspace with information about the CPU compatibility modes
> > +supported by the current host processor for booting the nested KVM guests on
> > +KVM on PowerNV (nested API v1) and KVM on PowerVM (nested API v2) platforms.
> > +
> > +::
> > +
> > +  struct kvm_ppc_compat_caps {
> > +	__u64	size;			/* Size of this structure */
> > +	__u64	flags;			/* Reserved for future use, must be 0 */
> > +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> > +  };
> > +
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
> 
> So I already requested that we should fix this. We cannot write more
> bytes than requested by the user, since that memory may not be allocated
> for this struct in userspace.
> 
> On checking Sashiko comments in reply to this patch - I think that is
> also complaining of the same thing that it could cause buffer overflow.

copy_struct_to_user() itself is safe — it caps its write to min(ksize,
usize) bytes so it never writes past the user's buffer. However, the
problem is in the value written back in the size field: if usize <
sizeof(host_caps) (old userspace, new kernel), we'd write size =
sizeof(host_caps) into the first 8 bytes of the user's smaller buffer.
If userspace then reuses the struct naively, it would pass usize =
sizeof(host_caps) against its smaller allocation, which would cause an
actual overflow on the next call.

The fix is to write back usize instead:

  host_caps.size = usize;
  r = copy_struct_to_user(argp, usize, &host_caps,
                          sizeof(host_caps), NULL);

This tells userspace "I filled exactly as many bytes as you gave me",
which is the correct contract for copy_struct_to_user().

Will update both the code in patch-1 and the versioning paragraph in the
documentation accordingly in v8.

Thanks,
Amit

> 
> 
> > +struct (``size > sizeof(struct kvm_ppc_compat_caps)``), the kernel writes
> > +back its own struct size into the ``size`` field and returns ``-E2BIG``,
> > +allowing userspace to discover the kernel's struct size and retry.
> > +``KVM_PPC_COMPAT_CAPS_SIZE_VER0`` (24) is a frozen constant marking the
> > +size of the initial struct version.
> 
> Once we update the comments in patch-1 - I think we should correct this
> documentation too accordingly. We should just simply use
> copy_to|from_user_struct() style for doing this.
> 
> > +
> > +The ``compat_capabilities`` bit field describes the processor compatibility
> > +modes supported by the host. The following bits indicate support for specific
> > +processor modes (using IBM's MSB-0 convention where bit 0 is the most
> > +significant bit):
> > +
> > +- ``KVM_PPC_COMPAT_CAP_POWER9``  (bit 1) -- KVM guests can run in Power9 processor mode
> > +- ``KVM_PPC_COMPAT_CAP_POWER10`` (bit 2) -- KVM guests can run in Power10 processor mode
> > +- ``KVM_PPC_COMPAT_CAP_POWER11`` (bit 3) -- KVM guests can run in Power11 processor mode
> > +
> > +.. note::
> > +
> > +   The bit numbering above uses IBM's MSB-0 convention (bit 0 is the most
> > +   significant bit). In the actual implementation, these are defined as:
> > +
> > +   - ``KVM_PPC_COMPAT_CAP_POWER9``  = ``(1ULL << 62)``
> > +   - ``KVM_PPC_COMPAT_CAP_POWER10`` = ``(1ULL << 61)``
> > +   - ``KVM_PPC_COMPAT_CAP_POWER11`` = ``(1ULL << 60)``
> > +
> > +   Userspace should use the defined constants from ``<linux/kvm.h>`` rather
> > +   than hardcoding bit positions.
> > +
> >  .. _kvm_run:
> >  
> >  5. The kvm_run structure
> > -- 
> > 2.50.1 (Apple Git-155)
