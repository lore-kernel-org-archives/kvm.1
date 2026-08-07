Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FCD282F10
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 03:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073202; cv=none; b=ErTHe127JJD9iNq1+HnWmqj7Rl0CED4Coi8NYpP7Clshjrf9T03eW/pExd7Ahw5gGo/Qn5A7HjBGS/OkQq+xGpDIE15O0D176Lsql/55PtuuR0DnuQS1nekYu/G8L+nJrrm0Z3gfKvz/AO13kBNSUSI1pO78axWHi8Ss3iFxUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073202; c=relaxed/simple;
	bh=j7j8TjC9eA2FYpmjEOuIioEe1d2Pn3oZcGiD30pxino=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=GBKL3NoaOkyHsoBacz22FUXgQWzEJPmJcBFdbWvUc/Oh/+e+/e5lMn1KP8izbC59fPxN7g6fX88V+HbPLin6Dm1+bhUm6euk0ccI8kBEe/w/V/L7Q82LfmM/k9N7HHrRed5qczSg8Md1xonJAjJ5mea8ccCsQ84DLMxEnnEu1YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOwonxmp; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOwonxmp"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso1988536a12.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 20:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786073200; x=1786678000; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JRf2EBTavDe7BzK6GUvtTHBHqH7rXidb69cs4e3i5nA=;
        b=bOwonxmp7F9lBKm7PVvYU/YMaTEhT+J6bJ0P/b+L4ZMQYQeeEdrUPKtLi+YlJy2koK
         ZjMDJfBy+GeI4n35XVS9GblXOamhqHBn31wfydG/oZWqtBLPiG42x/ID608NNaV3IG/w
         u0OrtGPUPiTsfwIhCHtwo/OUF18f8wSxbIHmt2rhLZDA+LsEcIGEbQRc+7cObksG1g0r
         HotpSVNYcy9jPfioodZ31iRKg3+nyRVeyfUcAZIj4oy52UBVmEP5uSIUw3oFaXjKEG/i
         7Z1oXPaFDQuRnWojFUbpK5LZHe69GsZQm8eZtP5m8laBPEjiqH9vbCrnWlBaaaU2DC4+
         nCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786073200; x=1786678000;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JRf2EBTavDe7BzK6GUvtTHBHqH7rXidb69cs4e3i5nA=;
        b=JBDE5aAvJCVX9mNC1LTbHo3g421yKSLDGHFyZy+vaveUeCkVxrvq+mpaFJypMmabPf
         WdtQDPpURqUabzZKpmVSkp4MKusW7FFOdoTd3zhgNoCUQ0c4+86K89yO9f1ucjnzXCvQ
         c+uqaXXyHLq9MpeDurFC59ztCarxmSmTo753Em0J4e22K+AqLJx1sW0u+fCxKUqxHnXG
         TTv6WPH7FDPBCMeR979cPvXpjbYyaxNNpCd/GT4qzhhmQDipQZQEBHEIIk2+DcdQ/cvO
         gIUx6/4DL/z2V3Jw/WV24jIxFU6kPdd9CAY2M8h70mnT3r3wR8oUto+B5ajWQN6Lrd4I
         ub1A==
X-Forwarded-Encrypted: i=1; AHgh+RpqmjaPuS4Mm6wrTMxbKwzuaeIAVT8tG/d5HM1GqbGs8KM0maXykPvNHmvxECGWKt28+rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydwwxbdXQMjFgQgMc/9QutgRB9zsPZvIZ3NJY2jn1juqec3e7Q
	Cyzh6ZF3C3QXVmzJxTvDP59qdGr90P2Eg1Q82HpY5RuZikWMNKxHnvQ6
X-Gm-Gg: AR+sD11mzZuoLzVVdVmvqlTf3IURJvMOql7ApsS8MQi0DosE78RxNV66T4SWdchn6js
	lJt5KBoEYd2mB7odY79In3Th2iZYMEr8fNsaru9XlSiRVupRrfdTD3tBrSybBwcugX8zZ1c7mEf
	gko+curjPOhZV6cUgAmhpGByn7n5VxJsocAoZY1nhxCXoPuhrQnuXH54ibX6dZ6rebDiaImEFg3
	TVp603g6JTrh0tsn97ps6MAZTZ+gp58A+WpScVAjNNNq29CsO8RdgLjoeSLwf3z8O9p8d//qZnc
	BnLFGxXnkJY42yYBWtsC+iA1LaK6mVPnfef4l1OoZh9XQx5Qum3QznIv0gnFzJ/+HKdxXsRzsK4
	tu2ogaVWj8d9tdG3MzGBx5cNbyXrJvUDzA1kcZ8/dBplO1nNILrdbIYbSDVCiyivf3kwemFC+Cw
	SM/beVZjeXj6Fs+KHkVVcYwAM2RoBq2XigpiSHlRX9rUauDpp2K8aTdcxYDqo=
X-Received: by 2002:a05:6a20:7fa1:b0:3c8:e140:63c3 with SMTP id adf61e73a8af0-3cb86076804mr21598472637.37.1786073200060;
        Thu, 06 Aug 2026 20:26:40 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86e90asm1946929eec.3.2026.08.06.20.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:26:38 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v7 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
In-Reply-To: <20260806170645.11892-2-amachhiw@linux.ibm.com>
Date: Fri, 07 Aug 2026 08:38:36 +0530
Message-ID: <ik5mlj9n.ritesh.list@gmail.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com> <20260806170645.11892-2-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Introduce a new capability and ioctl to expose CPU compatibility modes
> supported by the host processor for nested guests.
>
> On IBM POWER systems, newer processor generations (N) can operate in
> compatibility modes corresponding to earlier generations, like (N-1) and
> (N-2). This is particularly relevant for nested virtualization, where
> nested KVM guests may need to run with a specific processor compatibility
> level.
>
> Introduce KVM_CAP_PPC_COMPAT_CAPS capability and the corresponding
> KVM_PPC_GET_COMPAT_CAPS vm ioctl. The ioctl returns a bitmap describing
> the compatibility modes supported by the host in respective bit numbers,
> allowing userspace (e.g., QEMU) to select an appropriate compatibility
> level when configuring nested KVM guests.
>
> The ioctl handling is added in kvm_arch_vm_ioctl() and retrieves host
> CPU compatibility capabilities via a PowerPC-specific backend
> implementation when available.
>
> The struct kvm_ppc_compat_caps places the 'size' field first so it can
> be read alone via get_user() before copy_struct_from_user() is called,
> avoiding pointer arithmetic to locate the size field.
>
> The ioctl is defined using _IO so the ioctl number remains stable even if
> the struct grows in future versions. It uses copy_struct_from_user() and
> copy_struct_to_user() to provide forward- and backward-compatible
> extensibility: older userspace passing a smaller struct to a newer kernel
> gets zero-padded trailing fields, while newer userspace passing a larger
> struct to an older kernel (usize > ksize) gets sizeof(struct
> kvm_ppc_compat_caps) written back to host_caps.size so it can retry with the
> older kernel-supported size, after which the kernel returns -E2BIG.
>
> KVM_PPC_COMPAT_CAPS_SIZE_VER0 is defined as a frozen integer constant
> (24) marking the size of the initial struct version, used as the
> minimum floor for size field validation, similar to other versioned
> struct interfaces in the kernel.
>
> The 'flags' field is reserved for future use. The kernel rejects any
> call where flags is non-zero with -EINVAL, preventing garbage values
> from being baked into ABI permanently.
>
> The ioctl returns appropriate error codes: EINVAL for an invalid size
> or non-zero reserved fields, E2BIG if new userspace provides a larger
> struct than the kernel knows about (with ksize written back into
> host_caps.size for the retry), EFAULT for failed copy operations, and
> ENOTTY if the backend doesn't implement get_compat_caps.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes in this version:
>   - KVM_CAP_PPC_COMPAT_CAPS: add hv_enabled guard to align the capability
>     check with ioctl availability; a PR KVM VM on pseries now correctly
>     returns 0 for the capability [Sashiko]
>
>  arch/powerpc/include/asm/kvm_ppc.h  |  1 +
>  arch/powerpc/include/uapi/asm/kvm.h |  8 ++++
>  arch/powerpc/kvm/powerpc.c          | 71 +++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h            |  3 ++
>  4 files changed, 83 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 0953f2daa466..169ea6a7fbad 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -319,6 +319,7 @@ struct kvmppc_ops {
>  	bool (*hash_v3_possible)(void);
>  	int (*create_vm_debugfs)(struct kvm *kvm);
>  	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
> +	int (*get_compat_caps)(struct kvm_ppc_compat_caps *host_caps);
>  };
>  
>  extern struct kvmppc_ops *kvmppc_hv_ops;
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> index 077c5437f521..19e53d5ae540 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -437,6 +437,14 @@ struct kvm_ppc_cpu_char {
>  	__u64	behaviour_mask;		/* valid bits in behaviour */
>  };
>  
> +/* For KVM_PPC_GET_COMPAT_CAPS */
> +struct kvm_ppc_compat_caps {
> +	__u64	size;			/* Size of this structure */
> +	__u64	flags;			/* Reserved for future use */
> +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> +};
> +#define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
> +
>  /*
>   * Values for character and character_mask.
>   * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index b6b83fe3233f..e64b3cfadd3a 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -703,6 +703,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  			}
>  		}
>  		break;
> +#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
> +	case KVM_CAP_PPC_COMPAT_CAPS:
> +		r = 0;
> +		if (hv_enabled && kvmhv_on_pseries())

I think sashiko is just complaining in the 1st patch because we have not
yet wired up the kvmppc_hv_ops->get_compat_caps() yet in patch-1. I
think it is expecting..

if (hv_enabled && kvmhv_on_pseries() && kvmppc_hv_ops->get_compat_caps)

But either way is fine.


> +			r = 1;
> +		break;
> +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
>  	default:
>  		r = 0;
>  		break;
> @@ -2469,6 +2476,70 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  		r = kvm->arch.kvm_ops->svm_off(kvm);
>  		break;
>  	}
> +	case KVM_PPC_GET_COMPAT_CAPS: {
> +		struct kvm_ppc_compat_caps host_caps = {};
> +		u64 usize;
> +
> +		/*
> +		 * Read the size field first to drive copy_struct_from_user.
> +		 * size must be the first field of the struct.
> +		 */
> +		r = -EFAULT;
> +		if (get_user(usize, (__u64 __user *)argp))
> +			goto out;
> +
> +		/*
> +		 * Enforce a minimum: reject buffers smaller than the initial
> +		 * struct version (VER0). This allows old userspace compiled
> +		 * against the original struct to still work on a newer kernel
> +		 * that has grown the struct with appended fields.
> +		 */
> +		r = -EINVAL;
> +		if (usize < KVM_PPC_COMPAT_CAPS_SIZE_VER0)
> +			goto out;
> +
> +		/*
> +		 * New userspace with a larger struct called an older kernel.
> +		 * Write back ksize in host_caps.size so userspace knows which
> +		 * older struct to retry with, then fail with -E2BIG.
> +		 */
> +		if (usize > sizeof(host_caps)) {
> +			host_caps.size = sizeof(host_caps);
> +			r = -EFAULT;
> +			if (put_user(host_caps.size, (__u64 __user *)argp))
> +				goto out;
> +			r = -E2BIG;
> +			goto out;
> +		}

You anyways mentioned copy_struct_from_user() is taking care of both
forward and backward compat. Then what is the point of this check?
shouldn't we get rid of this complete if logic? I don't see a point of
this if we are anyway using copy_struct_from_user().

> +
> +		/*
> +		 * copy_struct_from_user() handles forward/backward compat:
> +		 *   usize == ksize: verbatim copy
> +		 *   usize <  ksize: zero-pad trailing (old userspace, new kernel)

+		 *   usize >  ksize: succeed iff the trailing bytes userspace
+		 *                   sent are zero, else -E2BIG

shouldn't we add usize > ksize case details, like ^^^,  which
copy_struct_from_user() handles since we are already adding the details
of other 2 cases.


</btw snip from copy_struct_from_user kdoc>

 * There are three cases to consider:
 *  * If @usize == @ksize, then it's copied verbatim.
 *  * If @usize < @ksize, then the userspace has passed an old struct to a
 *    newer kernel. The rest of the trailing bytes in @dst (@ksize - @usize)
 *    are to be zero-filled.
 *  * If @usize > @ksize, then the userspace has passed a new struct to an
 *    older kernel. The trailing bytes unknown to the kernel (@usize - @ksize)
 *    are checked to ensure they are zeroed, otherwise -E2BIG is returned.
 *
 * Returns (in all cases, some data may have been copied):
 *  * -E2BIG:  (@usize > @ksize) and there are non-zero trailing bytes in @src.
 *  * -EFAULT: access to userspace failed.
 
> +		 */
> +		r = copy_struct_from_user(&host_caps, sizeof(host_caps),
> +					  argp, usize);
> +		if (r)
> +			goto out;
> +
> +		/* Reserved fields must be zero */
> +		r = -EINVAL;
> +		if (host_caps.flags)
> +			goto out;
> +
> +		r = -ENOTTY;
> +		if (!kvm->arch.kvm_ops->get_compat_caps)
> +			goto out;
> +
> +		r = kvm->arch.kvm_ops->get_compat_caps(&host_caps);
> +		if (r)
> +			goto out;
> +
> +		host_caps.size = sizeof(host_caps);

shouldn't this be, since we don't want to be reporting a larger size to
the user?

          host_caps.size = min_t(u64, usize, sizeof(host_caps));


> +		r = copy_struct_to_user(argp, usize, &host_caps,
> +					sizeof(host_caps), NULL);
> +		break;
> +	}
>  	default: {
>  		struct kvm *kvm = filp->private_data;
>  		r = kvm->arch.kvm_ops->arch_vm_ioctl(filp, ioctl, arg);
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 419011097fa8..70e36e6a0ad4 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -997,6 +997,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_S390_KEYOP 247
>  #define KVM_CAP_S390_VSIE_ESAMODE 248
>  #define KVM_CAP_S390_HPAGE_2G 249
> +#define KVM_CAP_PPC_COMPAT_CAPS 250
>  
>  struct kvm_irq_routing_irqchip {
>  	__u32 irqchip;
> @@ -1341,6 +1342,8 @@ struct kvm_s390_keyop {
>  /* Available with KVM_CAP_COUNTER_OFFSET */
>  #define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
>  #define KVM_ARM_GET_REG_WRITABLE_MASKS _IOR(KVMIO,  0xb6, struct reg_mask_range)
> +/* Available with KVM_CAP_PPC_COMPAT_CAPS */
> +#define KVM_PPC_GET_COMPAT_CAPS	_IO(KVMIO,  0xb8)
>  
>  /* ioctl for vm fd */
>  #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
> -- 
> 2.50.1 (Apple Git-155)
