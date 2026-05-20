Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A993E9C1F
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290613; cv=pass; b=KsmeV+dKITA/PJ0ZfrdOD1GuLJb631fVOzygSSahQfzJ9TvP6LRua8xRZTFdFltON5OyoV6n7TMkEUcka4+ays7Ey2udu9HNx+5X5Pl25N3Zyuw2zhQkBLOaToJrGkPndfGVYAKJMP0KZVjp/WFLXIMxo4DztVQkT3IIeBq60YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290613; c=relaxed/simple;
	bh=LTvt0GO2IIoMdW77kPYbGLjxm/bcueNLJXl7aSycoec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cahm+a9WvpEqPliFQtKU+0PgLoxiiORUYgRMDOuNRH0pW97aeMj01SjRHF/xpKnvToBjEzdJfyvSnkdu+TBcyXoOwrnZhPYNk/ud0J0KkWrSdEDWVwdZkLyPPidbpy+kJwJG49FowIKByFrLv+IQ69UBNLd8a7iIMcjzYUS+Fzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F7HBBnkv; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F7HBBnkv"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d864c23bdso23921cf.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 08:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779290611; cv=none;
        d=google.com; s=arc-20240605;
        b=Nyg0umKXvI2F3YNLSz+YhWLAy/NcIfGDAbQkXdYBi5ZwlqJiKEAodWUiIcuydxxWQP
         jMtafdyfLAiv7QpkkV9J07JF2wgK3KR5sQB8K2CQPTaccpmpgMTk8IzlaEJdE4q7p7pp
         bOFZSBZx6jgOQfF077MkI5xZITcv9JxYK2XYVApCMOV4q7OuWOP/bLV+jkTlpdRhW7U3
         lkrKzu2iDknI68rUY87wejhR0WyV6NZ99TO2KEiQ4PsCdogxccpow7VKNyGZd/j0af98
         yg5LlQvgySrii5xBmoI7Rz6U1cvqwlB2D2izrj+Fxmno84FbIx/36ezr1HmwD7O/U4+1
         opoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6WbZMU4miMiF9vdr/q40hrIlWLS/zCvaA9/R/fFQvCg=;
        fh=pkoccx0mkknpXxJBuzXT3GXJmn1kzTQFilblHchTJRk=;
        b=eBId3yOaOQaH2ErYx6AT0SWl11oBpUlm1sVYfwYDr881Wwue+iKmKJ0Gc79ifHY5gr
         0uj2BNScUkIJQ/MYxPnJipg5bzsC6FsoZPDjyFPRvallJX0Pnp2TGx/1M1m4MQamPpo/
         4kvAipFfaBdQcCpusQmcsX2yNY9LVXS3lIQHjyx1CtRO0O3/FXKpMQYuRq8cUm7I/4My
         4GIi6dPzQOiVqj+UM5FppZpS6IHvZDTY/6znCHryIOKJClRXth6Oyie8u+tBMrsbT8oo
         UuAXZXLfMTKJwlRudhibzE4esRoEHqE1T7B5IE9b8gwb6QW7mfeeyD58evc5BvoDq+tr
         S+kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779290611; x=1779895411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6WbZMU4miMiF9vdr/q40hrIlWLS/zCvaA9/R/fFQvCg=;
        b=F7HBBnkvkFRQMqLuWY6Kbo0xGXRcUz0mWhP6k/OQAWOveJeB2o8zicxm5Ihsg8sWDy
         6fw3/KWVWY+8FQ2fvwmpNC/P/7CBYBvPtq8eAMMFXPVdb/P7Wh/0t+eepKBfBZYitKVG
         waDA+TRtX7o4Hxu1vVuiTjc30nQsUmgmMpsKpekyQ4UC/NyMsm4hrnVqTWg0qTUOpBrl
         f2yoplNes41Gg/n2l970f5E58hUPVLx34S2x51imEyaO+QGBNJPm97/lKLXgmn9ZeIAX
         uoxLLYphaLLjTuisdoKT1FsCvEatnjQvUkAzFX9h5GhM46Ix+cg+7heP5iNmiub7dw+H
         XU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290611; x=1779895411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WbZMU4miMiF9vdr/q40hrIlWLS/zCvaA9/R/fFQvCg=;
        b=IUL5lWm8znrQPe4ytO7XhFtlWUx+1U8EOaOC60t9pC/Mz/r5GdGorHtLu2iNJ/BInx
         HThoaDeRqJ/44yTOqp0gyHQv3N7jIm+QL6VHFvlxqfMmv9SWZzc16OkxKJBG+yvz5H9X
         lsCddPA+P0Ex4neZA9ABuX2h23v4PA9o3TfmSLweYLIirBGPqikHZ21+WTQQuBLE8Rhr
         OTxR4N6aJmh8yPn49olk2MKkdA8q/uMaTcvRJ58Dl6tBTZZFY4fBNOXwB2T6AhrkaiZ4
         GymNjIMhIYiEzlp+kURqehKjxsT+gSw3wBwITr9t6OAQSSY+JTx2vfF/G4Py8s/tZ4uZ
         /X6g==
X-Forwarded-Encrypted: i=1; AFNElJ/8yvD1ozeSBC/gn/I+VZ+sjpYOswPrqK3PyBvbmyT4zNoLT4nkK7WUoR0n6iznycNJkdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM7nIjIzgBewOLLD6sp98HrTmrTqCcqK5D8c/pFyGnW9gGsdJ0
	mNuCEWoB2Tpne1Kp/AcjlOeBO1MEJs3Rv7WCGsLkFBzbucVobaDy9A4C5p1Re4NOfs5PxNga4fM
	4x6pnSvDnWAXimKbv7qMTXmOBeq8+p3Lwp/zH1NhD
X-Gm-Gg: Acq92OEStj82Xs602A4hqP27BgxCAIFrPz7KFaDMRZMhmMBUVtSS8JkuwOWTRUF9M86
	daagT3enGqQH4Sa5v4MT0jdnQVfm15eaDX+Lsf6Mcm5gDrg0Shhpirnnkv2Sg5g9iRtDGqJceP3
	qCG1kEwljDOozGx6aI2dYDsLLeklibQsmhlQwKVRg4O7qapXlpvLlX7HgIEB9ZGt3mnZA5IcEGn
	WhPUY6YMk9Gus7ZBTlCs88tW938UlYPh0zLM+ojoDCSjInSaAshgUy7nHQeugQmGGBHGLOlsrrJ
	NV3B7LApzDJQw/JUgHM=
X-Received: by 2002:a05:622a:900e:b0:50b:8d3c:5bd7 with SMTP id
 d75a77b69052e-5167b669c3fmr40334771cf.9.1779290609929; Wed, 20 May 2026
 08:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-14-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-14-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 20 May 2026 16:22:53 +0100
X-Gm-Features: AVHnY4LJuKw2B0K-Cm-8YOXgihnw0Pgc0Lt4U2X1C7F6RPo0tjkQqSgizt_3rx0
Message-ID: <CA+EHjTzf6Bc_YgSNv0d+Rm=ALuwYuCaS=EPhrjFKDes8=+0QSw@mail.gmail.com>
Subject: Re: [PATCH v6 14/43] KVM: guest_memfd: Advertise KVM_SET_MEMORY_ATTRIBUTES2
 ioctl
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> Introduce KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES to advertise the
> availability of the KVM_SET_MEMORY_ATTRIBUTES2 ioctl.
>
> KVM_SET_MEMORY_ATTRIBUTES2 is a guest_memfd-scoped version of the existing
> KVM_SET_MEMORY_ATTRIBUTES VM ioctl. It allows userspace to manage memory
> attributes, such as KVM_MEMORY_ATTRIBUTE_PRIVATE, directly on a guest_memfd
> file descriptor.
>
> This new version uses struct kvm_memory_attributes2, which adds an
> error_offset field to the output. This allows KVM to return the specific
> offset that triggered an error, which is especially useful for handling
> EAGAIN results caused by transient page reference counts during attribute
> conversions.
>
> Update the KVM API documentation to define the new ioctl and its behavior,
> and add the necessary UAPI definitions and capability checks.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Suggested-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  Documentation/virt/kvm/api.rst | 78 +++++++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/kvm.h       |  2 ++
>  virt/kvm/kvm_main.c            |  5 +++
>  3 files changed, 84 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 52bbbb553ce10..55c2701d9ed49 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -117,7 +117,7 @@ description:
>        x86 includes both i386 and x86_64.
>
>    Type:
> -      system, vm, or vcpu.
> +      system, vm, vcpu or guest_memfd.
>
>    Parameters:
>        what parameters are accepted by the ioctl.
> @@ -6361,6 +6361,8 @@ S390:
>  Returns -EINVAL if the VM has the KVM_VM_S390_UCONTROL flag set.
>  Returns -EINVAL if called on a protected VM.
>
> +.. _KVM_SET_MEMORY_ATTRIBUTES:
> +
>  4.141 KVM_SET_MEMORY_ATTRIBUTES
>  -------------------------------
>
> @@ -6553,6 +6555,80 @@ KVM_S390_KEYOP_SSKE
>    Sets the storage key for the guest address ``guest_addr`` to the key
>    specified in ``key``, returning the previous value in ``key``.
>
> +4.145 KVM_SET_MEMORY_ATTRIBUTES2
> +---------------------------------
> +
> +:Capability: KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES
> +:Architectures: all
> +:Type: guest_memfd ioctl
> +:Parameters: struct kvm_memory_attributes2 (in/out)
> +:Returns: 0 on success, <0 on error
> +
> +Errors:
> +
> +  ========== ===============================================================
> +  EINVAL     The specified `offset` or `size` were invalid (e.g. not
> +             page aligned, causes an overflow, or size is zero).
> +  EFAULT     The parameter address was invalid.
> +  EAGAIN     Some page within requested range had unexpected refcounts. The
> +             offset of the page will be returned in `error_offset`.
> +  ENOMEM     Ran out of memory trying to track private/shared state
> +  ========== ===============================================================
> +
> +KVM_SET_MEMORY_ATTRIBUTES2 is an extension to
> +KVM_SET_MEMORY_ATTRIBUTES that supports returning (writing) values to
> +userspace.  The original (pre-extension) fields are shared with
> +KVM_SET_MEMORY_ATTRIBUTES identically.
> +
> +Attribute values are shared with KVM_SET_MEMORY_ATTRIBUTES.
> +
> +::
> +
> +  struct kvm_memory_attributes2 {
> +       /* in */
> +       union {
> +               __u64 address;
> +               __u64 offset;
> +       };
> +       __u64 size;
> +       __u64 attributes;
> +       __u64 flags;
> +       /* out */
> +       __u64 error_offset;
> +       __u64 reserved[11];
> +  };
> +
> +  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> +
> +Set attributes for a range of offsets within a guest_memfd to
> +KVM_MEMORY_ATTRIBUTE_PRIVATE to limit the specified guest_memfd backed
> +memory range for guest_use. Even if KVM_CAP_GUEST_MEMFD_MMAP is
> +supported, after a successful call to set
> +KVM_MEMORY_ATTRIBUTE_PRIVATE, the requested range will not be mappable
> +into host userspace and will only be mappable by the guest.
> +
> +To allow the range to be mappable into host userspace again, call
> +KVM_SET_MEMORY_ATTRIBUTES2 on the guest_memfd again with
> +KVM_MEMORY_ATTRIBUTE_PRIVATE unset.
> +
> +KVM does not directly manipulate the memory contents of pages during
> +attribute updates. However, the process of setting these attributes,
> +which includes operations such as unmapping pages from the host or
> +stage-2 page tables, may result in side effects on memory contents
> +that vary across different trusted firmware implementations.
> +
> +If this ioctl returns -EAGAIN, the offset of the page with unexpected
> +refcounts will be returned in `error_offset`. This can occur if there
> +are transient refcounts on the pages, taken by other parts of the
> +kernel.
> +
> +Userspace is expected to figure out how to remove all known refcounts
> +on the shared pages, such as refcounts taken by get_user_pages(), and
> +try the ioctl again. A possible source of these long term refcounts is
> +if the guest_memfd memory was pinned in IOMMU page tables.
> +
> +See also: :ref: `KVM_SET_MEMORY_ATTRIBUTES`.
> +
>  .. _kvm_run:
>
>  5. The kvm_run structure
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 0b55258573d3d..f437fd0f1350c 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -996,6 +996,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_S390_USER_OPEREXEC 246
>  #define KVM_CAP_S390_KEYOP 247
>  #define KVM_CAP_S390_VSIE_ESAMODE 248
> +#define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 249
>
>  struct kvm_irq_routing_irqchip {
>         __u32 irqchip;
> @@ -1648,6 +1649,7 @@ struct kvm_memory_attributes {
>         __u64 flags;
>  };
>
> +/* Available with KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES */
>  #define KVM_SET_MEMORY_ATTRIBUTES2              _IOWR(KVMIO,  0xd2, struct kvm_memory_attributes2)
>
>  struct kvm_memory_attributes2 {
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 4d7bf52b7b717..cec02d68d7039 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4972,6 +4972,11 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>                 return 1;
>         case KVM_CAP_GUEST_MEMFD_FLAGS:
>                 return kvm_gmem_get_supported_flags(kvm);
> +       case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
> +               if (vm_memory_attributes)
> +                       return 0;
> +
> +               return kvm_supported_mem_attributes(kvm);
>  #endif
>         default:
>                 break;
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
