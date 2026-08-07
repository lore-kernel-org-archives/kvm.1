Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB0377A94
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104235; cv=none; b=oDFvwGTbKnoD0GmwUQY0H1Wsl6VUu3E9FV4qELSL5E9ghyB4Vt0ENsPmFurBkL+Y46B+ecrYK2HXmPCYX5nCeY6c6eQMVv0JQ+dhznHsnBHTkvTRToXgSN/if7E5iyj0csij645cX8C+i4Muky8XUa0y+Db+uka1ye0p7hRzTH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104235; c=relaxed/simple;
	bh=Q3w9umB0GYVc+ZMTE8GmvFD9QoqR9MKK2B15/0DCiBc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=mEEbCB8iUf0lKyhBvBM665JCYvoyUDyVB6qnArepaWm7bSMZCJMMgY0ABpjVHe8RJM6qm6IqV1Jtje/mAXTRl08a0NW/Y/PdCiSuRLlEO604PEwBDSfdYkun1txwp4AafSjdE3Uqm+wsXVk3cVQow/BhMYa8gp6hvd/sTLZImYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5YQN7I8; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5YQN7I8"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c999f162c9aso2384891a12.3
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 05:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786104217; x=1786709017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AOA/iAc0xzxZZXE3ta+pRA6RHW/L9nm5uGt53nCx5zY=;
        b=d5YQN7I8GUMlKQiY/IGTcjqzn5QxWl26p5YO3WuGr3YPmSa15oxmksHbDVNRMZnJ+k
         E6qfANWZY4hVX6N8RQDkw6yJgTeuLUQ/iuu2RD+XizI+5CEMh5KNw64Wth7n/JD0b+7N
         4LcjlOlcstM91oMxGERsf/8qMOmId8RL6YlnGRhck0r7KajlJjyDs3X45Y2XjzcqW8VA
         y6r2UlwJERLuZ8PKfBqGZBR9X1L/uEp0hHFWaaxi+giNNXVrouD/HHVyga9Jewv4axxb
         BZcNLl6SqeLR7vFntnQW0MT3+S2G2Fhc2LUD46tiQqoSV6oTqKPqlr4dbZrLHErze9ri
         7Taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786104217; x=1786709017;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AOA/iAc0xzxZZXE3ta+pRA6RHW/L9nm5uGt53nCx5zY=;
        b=URz5rivcCDmkmI4WpFT90iNRBDrxRh3z7CmzPF9Qoxk6CqDwMjwZ2KEVltvG5aedk9
         s3qa0rs/4nJgMiUkKcMT/O4x1ad35d0ieZ5MbKKJhQJCbvrAYlk2REGMzKlQuI9lnSRh
         0/gpPSpqVZlM7+vYMNl0enXne2x5tV7C4Kq5wZ+V8aBSjQ9cIXCSI2NQEelTqE6KP4ig
         qCSbeSN8AtUDXZRRXZ2WqL3kmKcT9qo2BInZRkuNckuQ9lSAGW/Nrsv7Oq3AivrIcnnQ
         FOqirjf8/8yMQW8dBuXw7WysvPZVno3y1Ig39gxaXad0S4JxsmWJexAd+MvIRmrF8mUm
         xjMg==
X-Forwarded-Encrypted: i=1; AHgh+RotCLvNQwBWZraBOR19813E2CkA+BUKs/mpw0cs/dZzh3hixxVE6H4AvCMaSn+DjlxM3o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOFwORQZjIoUzXkKicmv1bT/oF66lv3ZtVb4kDgogqvQJDzxbc
	f5K4dC6LHp2p5bJKSY/9IJD7Wi1/M7ukHdggstUST3loTXeAUSekgBNX
X-Gm-Gg: AR+sD13WoiHqpBx6eOHaGJhxc/j72B/31yjqkYx6ln57EHefg+gQQUHQ9gWWsELykwb
	ADbhtigZrqV5N5p+LDTX3WYgVEZP8g4X2tvBM77+Wxbk8zeQz+CsCtaqa6v9VU/0ZW5wGbj4Fdq
	7qS/YzBnQA9aBFbQSH+2EHtSbsytJNPzWrPPBCCsMGxwUJXTK4NUSXkDvBQB5BUvfJluMnCo2YE
	8vLrvYIFmlLDpOxX+04iIKwlxWaCC5OjtRaIx8ok6Wb6qhyA4QxZIZD0EMlH+41VycJ6yfPvfwr
	e9BEaEfvh12VANy0qdnhU5WXb0Fyp3JjYrrJyDmyMg53jZDCJoSKPOWy1oz1Q7mOjOhcvCVha9A
	JkhVCiHRkG8O59JX1BZtNIkRobGC/Sho9Sk3HgieqmmwRj86p/y6cKgs9BT6Ujbs6d3Yds5vjya
	E8wRkMeKkO2Ie9ONSjtJQBXQtCKoyJLCJ4Hq2MA7P+IVXOgEIQYtaBiE3C/eI=
X-Received: by 2002:a05:6a20:734c:b0:3b4:8ba9:4d8e with SMTP id adf61e73a8af0-3cb85e6c92emr25217065637.23.1786104217202;
        Fri, 07 Aug 2026 05:03:37 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141018f18d6sm7203235c88.0.2026.08.07.05.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 05:03:36 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v7 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
In-Reply-To: <20260807161434.73dfde8c-36-amachhiw@linux.ibm.com>
Date: Fri, 07 Aug 2026 17:06:47 +0530
Message-ID: <8q6ikvqo.ritesh.list@gmail.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com> <20260806170645.11892-2-amachhiw@linux.ibm.com> <ik5mlj9n.ritesh.list@gmail.com> <20260807161434.73dfde8c-36-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Hi Ritesh,
>
> Thanks for reviewing this patch. Please find my response inline below.
>
> On 2026/08/07 08:38 AM, Ritesh Harjani wrote:
>> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
>> 
>> > Introduce a new capability and ioctl to expose CPU compatibility modes
>> > supported by the host processor for nested guests.
>> >
>> > On IBM POWER systems, newer processor generations (N) can operate in
>> > compatibility modes corresponding to earlier generations, like (N-1) and
>> > (N-2). This is particularly relevant for nested virtualization, where
>> > nested KVM guests may need to run with a specific processor compatibility
>> > level.
>> >
>> > Introduce KVM_CAP_PPC_COMPAT_CAPS capability and the corresponding
>> > KVM_PPC_GET_COMPAT_CAPS vm ioctl. The ioctl returns a bitmap describing
>> > the compatibility modes supported by the host in respective bit numbers,
>> > allowing userspace (e.g., QEMU) to select an appropriate compatibility
>> > level when configuring nested KVM guests.
>> >
>> > The ioctl handling is added in kvm_arch_vm_ioctl() and retrieves host
>> > CPU compatibility capabilities via a PowerPC-specific backend
>> > implementation when available.
>> >
>> > The struct kvm_ppc_compat_caps places the 'size' field first so it can
>> > be read alone via get_user() before copy_struct_from_user() is called,
>> > avoiding pointer arithmetic to locate the size field.
>> >
>> > The ioctl is defined using _IO so the ioctl number remains stable even if
>> > the struct grows in future versions. It uses copy_struct_from_user() and
>> > copy_struct_to_user() to provide forward- and backward-compatible
>> > extensibility: older userspace passing a smaller struct to a newer kernel
>> > gets zero-padded trailing fields, while newer userspace passing a larger
>> > struct to an older kernel (usize > ksize) gets sizeof(struct
>> > kvm_ppc_compat_caps) written back to host_caps.size so it can retry with the
>> > older kernel-supported size, after which the kernel returns -E2BIG.
>> >
>> > KVM_PPC_COMPAT_CAPS_SIZE_VER0 is defined as a frozen integer constant
>> > (24) marking the size of the initial struct version, used as the
>> > minimum floor for size field validation, similar to other versioned
>> > struct interfaces in the kernel.
>> >
>> > The 'flags' field is reserved for future use. The kernel rejects any
>> > call where flags is non-zero with -EINVAL, preventing garbage values
>> > from being baked into ABI permanently.
>> >
>> > The ioctl returns appropriate error codes: EINVAL for an invalid size
>> > or non-zero reserved fields, E2BIG if new userspace provides a larger
>> > struct than the kernel knows about (with ksize written back into
>> > host_caps.size for the retry), EFAULT for failed copy operations, and
>> > ENOTTY if the backend doesn't implement get_compat_caps.
>> >
>> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> > Tested-by: Gautam Menghani <gautam@linux.ibm.com>
>> > Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
>> > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
>> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
>> > ---
>> > Changes in this version:
>> >   - KVM_CAP_PPC_COMPAT_CAPS: add hv_enabled guard to align the capability
>> >     check with ioctl availability; a PR KVM VM on pseries now correctly
>> >     returns 0 for the capability [Sashiko]
>> >
>> >  arch/powerpc/include/asm/kvm_ppc.h  |  1 +
>> >  arch/powerpc/include/uapi/asm/kvm.h |  8 ++++
>> >  arch/powerpc/kvm/powerpc.c          | 71 +++++++++++++++++++++++++++++
>> >  include/uapi/linux/kvm.h            |  3 ++
>> >  4 files changed, 83 insertions(+)
>> >
>> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
>> > index 0953f2daa466..169ea6a7fbad 100644
>> > --- a/arch/powerpc/include/asm/kvm_ppc.h
>> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
>> > @@ -319,6 +319,7 @@ struct kvmppc_ops {
>> >  	bool (*hash_v3_possible)(void);
>> >  	int (*create_vm_debugfs)(struct kvm *kvm);
>> >  	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
>> > +	int (*get_compat_caps)(struct kvm_ppc_compat_caps *host_caps);
>> >  };
>> >  
>> >  extern struct kvmppc_ops *kvmppc_hv_ops;
>> > diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>> > index 077c5437f521..19e53d5ae540 100644
>> > --- a/arch/powerpc/include/uapi/asm/kvm.h
>> > +++ b/arch/powerpc/include/uapi/asm/kvm.h
>> > @@ -437,6 +437,14 @@ struct kvm_ppc_cpu_char {
>> >  	__u64	behaviour_mask;		/* valid bits in behaviour */
>> >  };
>> >  
>> > +/* For KVM_PPC_GET_COMPAT_CAPS */
>> > +struct kvm_ppc_compat_caps {
>> > +	__u64	size;			/* Size of this structure */
>> > +	__u64	flags;			/* Reserved for future use */
>> > +	__u64	compat_capabilities;	/* Capabilities supported by the host */
>> > +};
>> > +#define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
>> > +
>> >  /*
>> >   * Values for character and character_mask.
>> >   * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
>> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>> > index b6b83fe3233f..e64b3cfadd3a 100644
>> > --- a/arch/powerpc/kvm/powerpc.c
>> > +++ b/arch/powerpc/kvm/powerpc.c
>> > @@ -703,6 +703,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>> >  			}
>> >  		}
>> >  		break;
>> > +#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
>> > +	case KVM_CAP_PPC_COMPAT_CAPS:
>> > +		r = 0;
>> > +		if (hv_enabled && kvmhv_on_pseries())
>> 
>> I think sashiko is just complaining in the 1st patch because we have not
>> yet wired up the kvmppc_hv_ops->get_compat_caps() yet in patch-1. I
>> think it is expecting..
>> 
>> if (hv_enabled && kvmhv_on_pseries() && kvmppc_hv_ops->get_compat_caps)
>> 
>> But either way is fine.
>> 
>> 
>> > +			r = 1;
>> > +		break;
>> > +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
>> >  	default:
>> >  		r = 0;
>> >  		break;
>> > @@ -2469,6 +2476,70 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>> >  		r = kvm->arch.kvm_ops->svm_off(kvm);
>> >  		break;
>> >  	}
>> > +	case KVM_PPC_GET_COMPAT_CAPS: {
>> > +		struct kvm_ppc_compat_caps host_caps = {};
>> > +		u64 usize;
>> > +
>> > +		/*
>> > +		 * Read the size field first to drive copy_struct_from_user.
>> > +		 * size must be the first field of the struct.
>> > +		 */
>> > +		r = -EFAULT;
>> > +		if (get_user(usize, (__u64 __user *)argp))
>> > +			goto out;
>> > +
>> > +		/*
>> > +		 * Enforce a minimum: reject buffers smaller than the initial
>> > +		 * struct version (VER0). This allows old userspace compiled
>> > +		 * against the original struct to still work on a newer kernel
>> > +		 * that has grown the struct with appended fields.
>> > +		 */
>> > +		r = -EINVAL;
>> > +		if (usize < KVM_PPC_COMPAT_CAPS_SIZE_VER0)
>> > +			goto out;
>> > +
>> > +		/*
>> > +		 * New userspace with a larger struct called an older kernel.
>> > +		 * Write back ksize in host_caps.size so userspace knows which
>> > +		 * older struct to retry with, then fail with -E2BIG.
>> > +		 */
>> > +		if (usize > sizeof(host_caps)) {
>> > +			host_caps.size = sizeof(host_caps);
>> > +			r = -EFAULT;
>> > +			if (put_user(host_caps.size, (__u64 __user *)argp))
>> > +				goto out;
>> > +			r = -E2BIG;
>> > +			goto out;
>> > +		}
>> 
>> You anyways mentioned copy_struct_from_user() is taking care of both
>> forward and backward compat. Then what is the point of this check?
>> shouldn't we get rid of this complete if logic? I don't see a point of
>> this if we are anyway using copy_struct_from_user().
>
> The pre-check is intentional and serves a purpose that
> copy_struct_from_user() alone cannot provide: explicit kernel struct
> size discovery.
>
> copy_struct_from_user() returns -E2BIG when usize > ksize and trailing
> bytes are non-zero — but it gives userspace no way to know what ksize to
> retry with. It also silently succeeds when trailing bytes are zero,
> which means a new userspace on an old kernel would never learn the
> kernel's struct size at all.
>
> This design is different by intent: when new userspace passes a larger
> struct, we always return -E2BIG and write back sizeof(host_caps) into
> the size field so userspace learns the exact kernel-supported size and
> can retry with it. This explicit negotiation is verified in the ABI
> extensibility testing in the cover letter ("Newer struct on QEMU, older
> kernel -> works"). The explicit -E2BIG + ksize writeback makes the
> version negotiation unambiguous.
>

yup, my bad, should have seen the comment in the code above.

But isn't this a bad design? Tomorrow, say we have a v2, a larger
version of this struct and if your newer Qemu (with larger struct size)
is running on an older kernel with a smaller struct size, then you will
fail it because usize > ksize even though the userspace has zero filled
the rest of the trailing bytes... 
     if (usize > sizeof(host_caps)) 

Instead wouldn't it be better if we do something like this?

		r = copy_struct_from_user(&host_caps, sizeof(host_caps),
					  argp, usize);
		if (r) {
			if (r == -E2BIG)
				put_user(sizeof(host_caps), &argp->size);
			goto out;
		}

So, we only fail if the userspace has passed a newer struct and the
trailing bytes, which are unknown to this older kernel, are zeroed,
otherwise we return -E2BIG. We also write the ksize back, so the user
knows what ksize it supports.

This would avoid an unncessary round trip and will simplify the
userspace design, isn't it?

>> 
>> > +
>> > +		/*
>> > +		 * copy_struct_from_user() handles forward/backward compat:
>> > +		 *   usize == ksize: verbatim copy
>> > +		 *   usize <  ksize: zero-pad trailing (old userspace, new kernel)
>> 
>> +		 *   usize >  ksize: succeed iff the trailing bytes userspace
>> +		 *                   sent are zero, else -E2BIG
>> 
>> shouldn't we add usize > ksize case details, like ^^^,  which
>> copy_struct_from_user() handles since we are already adding the details
>> of other 2 cases.
>
> The comment is intentionally limited to two cases. By the time we reach
> copy_struct_from_user(), the usize > sizeof(host_caps) case has already
> been caught by the pre-check above and returned -E2BIG. So
> copy_struct_from_user() can only ever see usize == ksize or usize <
> ksize at this point — those are the only two cases worth documenting
> here.
>
> Adding the usize > ksize case would be misleading since that code path
> is unreachable for this call site.
>
>> 
>> 
>> </btw snip from copy_struct_from_user kdoc>
>> 
>>  * There are three cases to consider:
>>  *  * If @usize == @ksize, then it's copied verbatim.
>>  *  * If @usize < @ksize, then the userspace has passed an old struct to a
>>  *    newer kernel. The rest of the trailing bytes in @dst (@ksize - @usize)
>>  *    are to be zero-filled.
>>  *  * If @usize > @ksize, then the userspace has passed a new struct to an
>>  *    older kernel. The trailing bytes unknown to the kernel (@usize - @ksize)
>>  *    are checked to ensure they are zeroed, otherwise -E2BIG is returned.
>>  *
>>  * Returns (in all cases, some data may have been copied):
>>  *  * -E2BIG:  (@usize > @ksize) and there are non-zero trailing bytes in @src.
>>  *  * -EFAULT: access to userspace failed.
>>  
>> > +		 */
>> > +		r = copy_struct_from_user(&host_caps, sizeof(host_caps),
>> > +					  argp, usize);
>> > +		if (r)
>> > +			goto out;
>> > +
>> > +		/* Reserved fields must be zero */
>> > +		r = -EINVAL;
>> > +		if (host_caps.flags)
>> > +			goto out;
>> > +
>> > +		r = -ENOTTY;
>> > +		if (!kvm->arch.kvm_ops->get_compat_caps)
>> > +			goto out;
>> > +
>> > +		r = kvm->arch.kvm_ops->get_compat_caps(&host_caps);
>> > +		if (r)
>> > +			goto out;
>> > +
>> > +		host_caps.size = sizeof(host_caps);
>> 
>> shouldn't this be, since we don't want to be reporting a larger size to
>> the user?
>> 
>>           host_caps.size = min_t(u64, usize, sizeof(host_caps));
>
> At this point in the code, usize has already been bounds-checked to
> [KVM_PPC_COMPAT_CAPS_SIZE_VER0, sizeof(host_caps)], so min_t(u64, usize,
> sizeof(host_caps)) is always equal to usize here — the min_t never
> actually clamps anything.
>
> Thanks,
> Amit
