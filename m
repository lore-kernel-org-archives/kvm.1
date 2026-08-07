Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957438F64D
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 04:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786077830; cv=none; b=JNbxqgZ+PiaHjgX8xoRaCBrtkom0zi7ZiqvxpdA3dCJ+WArwv4REw4zO134LnL44K9yMVGqsyam50Cm+b96VqoB6ohcGIFvErAeK5AhRDXPIQnzs36q8esebUU1s4CiQ/4qhsGJUbUnZWw50HWRSn9qzO5gZb/iGcTB0r+hao20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786077830; c=relaxed/simple;
	bh=bXafEeRa/aBkiRSCWIVw0Sey2csmxtqoARR3l1ea9Ek=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=PGRtBi4xXJVAp4aPD/StlaEt7gf2MSLSbCP68228WTUaSHyVk6oKW3jZ33F8DhB/ULD9m6RgVfBPggmat9/lSoM5DHuqYSqvdM9AijPzZvVZXZA2D5QTuq72fuWFWz400AteBMc+WHoif/vlhqF66Fln3hj4JKfvCiRM3P3uYUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyJvh7A+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyJvh7A+"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cace91f112so34221735ad.0
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 21:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786077828; x=1786682628; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QgHVsHtQu5HJOyA8OxcWU271rWUfL0isA+SyxkEMQI4=;
        b=SyJvh7A+h1vrmm4cYRQk3PNOeMHI7Qmx9zJ+I7ZQncbcAQbG2ralqDQ4lBbi20oItr
         auDyoKknJ+vl8GyzanLEfwNLq8cJm83YqDPO8Ga9EMhkVH1HwyO4QSscCNI4+NWHA7UK
         yLl2xLjZZrPIu29gm/O+qXKTOqTLkAihq7iihKUkX8kDPwAT0u7RQgHgMtopvhtahoFb
         VvMtDUmjO6WfNdzrWCS88djUAtXx+pfoLEtID5i7NNNIAe62gxMrRH0CdZ+Co72idWKr
         u4rVVIOoF8HL7jTIw7Zi7qvkTko2u7ZSLb7XvlkoH1rzmETXC5/wmL+rjZhsLZS7UOiw
         CHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786077828; x=1786682628;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QgHVsHtQu5HJOyA8OxcWU271rWUfL0isA+SyxkEMQI4=;
        b=ERCbC4VaPcsxfDFhA9pdVS/PM7PCD5zTU0NYYcfbehn14nmVSzmk9d3/nXTepMd5T4
         BTgviACIusBnRJxyKE0Pyn7d8TGI5iIGr93zb0oAVah+fgpfIttG1Bh1fjDb04f4kWCS
         Is7Sgn88edzvb4qQVC794HnhSpZVItxYwn1AymNeeritG3yBKaB+g1wowLsz+sehgygl
         uMd2fot1m7j58XqQ3UumTYzIb7T+A0RQxifdTM5xC9dbf4tQF7Ece+wZIIcZPdAtU8F1
         CB70rh8fVelQioFAjA/5riDc7EEs4mf2ou4rlrmccRJ9S/TH9tOSs9W2PWpJFQVEOWW4
         1f9A==
X-Forwarded-Encrypted: i=1; AHgh+RqTZglHCZ5x1ixqPuZYfgBWdvqAW5YyS9wepOSZYTuqVI9eRLWB3Sbsc8IT/o/OAkMhx9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Au5ugopD7tgYwisuck8gQGtCL5IdMjKj/ysr7rrxk+80h9pD
	oRH2Ql0dybUhIn/Yf6/kLywvZnY7SmrW+WZyxPABQEkyU8d5khe5muwq
X-Gm-Gg: AR+sD11KwfyN/IAZO+tuHaxxaYS7LNFR4x49/x/ykaOJTJAIWoftlWbUH4+/t+SeChQ
	WC6ohnHhUKAv0xACamWlt6zzVFsiPCVx1NnmN1J9VDBpDijrs98XWPFAuDrkcEiTINw5j31r43S
	mfXa+lK3rth5DLOoC/vtm7HfY4ZDx2S/G2/1y9KAXoIJEZvrE6mj2SqUCiT2HnJHyqP8FpsIqcQ
	/LD0m9ip3laXYT54aPA9VVkgYWiC3GqejV/USeQNk8nfsyc4UVN8uJrIFgeI2y6HqwomQQOQotJ
	4a5L6npdkLLXlBdLovnUxyIoZS/GwZZa/PbbU9WivASqM46NYW77zJW+D6T3BRJCbLGAlFLUen0
	lZBZvIXb0mYrfkV5tIrJp9FEsF+WdOQbLBIKaplKnZ/Uj5U5UaIC+VqjF1OZwJCvA4lhmsA4dUL
	/zvKdxYLn4sd0EIb/xUuzr5/sBQAK5fJxVMwJ4SpxU5Xw57Ux+pKYLK0in6cw=
X-Received: by 2002:a17:902:d581:b0:2cf:a108:7605 with SMTP id d9443c01a7336-2d0ca75b37cmr255853705ad.11.1786077827947;
        Thu, 06 Aug 2026 21:43:47 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec5aac2sm2577332eec.30.2026.08.06.21.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 21:43:47 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v7 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
In-Reply-To: <20260806170645.11892-5-amachhiw@linux.ibm.com>
Date: Fri, 07 Aug 2026 10:05:22 +0530
Message-ID: <cxvulf91.ritesh.list@gmail.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com> <20260806170645.11892-5-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
> documentation.
>
> The ioctl exposes host processor compatibility modes supported for
> nested KVM guests on PowerPC systems. The documentation covers error
> code descriptions including E2BIG for forward compatibility, the
> extensible size-based versioning contract using
> KVM_PPC_COMPAT_CAPS_SIZE_VER0, the rationale for rejecting non-zero
> reserved fields to prevent ABI ambiguity, bit numbering clarification
> for IBM MSB-0 convention, and KVM-specific capability bit constants.
>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  Documentation/virt/kvm/api.rst | 79 ++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index e3003a241d5b..22fedb0aa34b 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6566,6 +6566,85 @@ KVM_S390_KEYOP_SSKE
>    Sets the storage key for the guest address ``guest_addr`` to the key
>    specified in ``key``, returning the previous value in ``key``.
>  
> +4.145 KVM_PPC_GET_COMPAT_CAPS
> +-----------------------------
> +:Capability: KVM_CAP_PPC_COMPAT_CAPS
> +:Architectures: powerpc
> +:Type: vm ioctl
> +:Parameters: struct kvm_ppc_compat_caps (in/out)
> +:Returns: 0 on success, negative value on failure
> +
> +Errors include:
> +
> +  ======== ============================================================
> +  EFAULT   if ``struct kvm_ppc_compat_caps`` cannot be read from or
> +           written to userspace
> +  EINVAL   if the ``size`` field is smaller than
> +           ``KVM_PPC_COMPAT_CAPS_SIZE_VER0``, if the ``flags`` field
> +           is non-zero, or if the backend fails to retrieve or map
> +           CPU compatibility capabilities
> +  E2BIG    if ``size`` is larger than the kernel's struct size
> +           (new userspace on old kernel); the kernel writes back its
> +           own struct size into the ``size`` field so userspace can
> +           retry with the correct size
> +  ENOTTY   if the backend does not implement the ``get_compat_caps``
> +           operation (e.g., on non-HV KVM implementations where the
> +           required KVM operations are not available)

Amit, this may not be true anymore right after your changes in v7?
Can we please update the documentation accordingly as well.

> +  ======== ============================================================
> +
> +IBM POWER system server-based processors provide a compatibility mode feature
> +where an Nth generation processor can operate in modes consistent with earlier
> +generations such as (N-1) and (N-2).
> +
> +This ioctl provides userspace with information about the CPU compatibility modes
> +supported by the current host processor for booting the nested KVM guests on
> +KVM on PowerNV (nested API v1) and KVM on PowerVM (nested API v2) platforms.
> +
> +::
> +
> +  struct kvm_ppc_compat_caps {
> +	__u64	size;			/* Size of this structure */
> +	__u64	flags;			/* Reserved for future use, must be 0 */
> +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> +  };
> +
> +Before calling this ioctl, userspace must set the ``size`` field to
> +``sizeof(struct kvm_ppc_compat_caps)`` and zero the ``flags`` field.
> +The kernel rejects non-zero ``flags`` with ``-EINVAL`` to prevent
> +uninitialized stack values from being silently accepted, keeping the
> +field available for future use without ABI ambiguity.
> +
> +The ioctl uses ``copy_struct_from_user()`` and ``copy_struct_to_user()``
> +to support extensible versioning: if userspace passes a struct smaller
> +than the current kernel version (``size >= KVM_PPC_COMPAT_CAPS_SIZE_VER0``),
> +the kernel zero-pads unknown trailing fields. If userspace passes a larger

So I already requested that we should fix this. We cannot write more
bytes than requested by the user, since that memory may not be allocated
for this struct in userspace.

On checking Sashiko comments in reply to this patch - I think that is
also complaining of the same thing that it could cause buffer overflow.


> +struct (``size > sizeof(struct kvm_ppc_compat_caps)``), the kernel writes
> +back its own struct size into the ``size`` field and returns ``-E2BIG``,
> +allowing userspace to discover the kernel's struct size and retry.
> +``KVM_PPC_COMPAT_CAPS_SIZE_VER0`` (24) is a frozen constant marking the
> +size of the initial struct version.

Once we update the comments in patch-1 - I think we should correct this
documentation too accordingly. We should just simply use
copy_to|from_user_struct() style for doing this.

> +
> +The ``compat_capabilities`` bit field describes the processor compatibility
> +modes supported by the host. The following bits indicate support for specific
> +processor modes (using IBM's MSB-0 convention where bit 0 is the most
> +significant bit):
> +
> +- ``KVM_PPC_COMPAT_CAP_POWER9``  (bit 1) -- KVM guests can run in Power9 processor mode
> +- ``KVM_PPC_COMPAT_CAP_POWER10`` (bit 2) -- KVM guests can run in Power10 processor mode
> +- ``KVM_PPC_COMPAT_CAP_POWER11`` (bit 3) -- KVM guests can run in Power11 processor mode
> +
> +.. note::
> +
> +   The bit numbering above uses IBM's MSB-0 convention (bit 0 is the most
> +   significant bit). In the actual implementation, these are defined as:
> +
> +   - ``KVM_PPC_COMPAT_CAP_POWER9``  = ``(1ULL << 62)``
> +   - ``KVM_PPC_COMPAT_CAP_POWER10`` = ``(1ULL << 61)``
> +   - ``KVM_PPC_COMPAT_CAP_POWER11`` = ``(1ULL << 60)``
> +
> +   Userspace should use the defined constants from ``<linux/kvm.h>`` rather
> +   than hardcoding bit positions.
> +
>  .. _kvm_run:
>  
>  5. The kvm_run structure
> -- 
> 2.50.1 (Apple Git-155)
