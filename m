Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338E1386C18
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377923; cv=pass; b=KPBxnS+uR3DJJVgx24e+/E7gWvEC5UhMqOkVRkZSciGGDefLOxj5DMfkFTOpNd4fu7FlFQTfU6OoSd0Tu9chZ21ggaLfLy3tFoGJxtOgKL8ImRYEpCnKeZgzDV3CFe9OwVX5amxJmM/V6DkGNSNR4WD2NBiFRx5+TX0UsBwraQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377923; c=relaxed/simple;
	bh=nIj/KPVXWgrY4C2B+8ZBQ4iBoKspX6TI4aa5GobFD10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYk0JjvbbZxlQOqKyj/OQtmrZRXrEeH3J49Fg40vOFQXbM5K11giAUR3QhdaGXy96InIkHHKmGrdjhta4ttdYNwty8tyxLTJb4gXx34e3cZCMAC8u84ADdwB0LByPoMyUTd97e2EaCdwpgDXFsJezwgSCfWj/IYp8mOkN7ycvRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zx3LaQha; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zx3LaQha"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51765331535so156681cf.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 01:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782377921; cv=none;
        d=google.com; s=arc-20260327;
        b=Z/iafIgwwbX2AN+e86mlm9nB0wJbYjc1ezQACSXjESETtz+jeafyorvvh5oDx7+0Qn
         i8QHqVYmej5hgcw0584Gq7PmazDLRJ5LXLuDYtULm2LmP+A2L806VAjGzmLXDkLMyTU3
         D8B/6d0JH60oUeXGQwR/7HMu3+6KFuLeBELNYcnhd7UwM3AyQvIclCWN8daIu+t9aCXB
         RKnMhXcZIM/oy6q5z+ED6NJ8rG1WvVugNAL0tKuLfIk9mcLeTdF1hAcPjWdmThGp4a2q
         /xw9oTuJ8Rbtj++nL0s/g2jRaeVFFR/TWoyLL4zMYj1ByLLmGImXXqD2vRkMCc2Wjhbg
         WabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WlALM42viJ6jSZuQC8WWXMFlP84OGAnUizlvgeGuSiM=;
        fh=v4KC5nXps42/fWhsjf5ik1x6jFPTh5ci1XRdd+gRTF4=;
        b=SfpaILKmC3vZxrCmfIe5/akJnCVV5RlQmTKvTQj3zgUx1imafOCALDV1nxaPmmMYRz
         fB5y5o7fD4zgI/0HfiqdP6dGzeYP3zhet8bf/lMfRw1siV/hDkbZdL37Zzq3IhDrxGp3
         I3fVLEVlmWF3NOlk6gKDZyTVJjVHQaxx+CF5BsmFYQ206AZCSLjAG7lj/bFQHW330THh
         M9EcfwM32e87k2/r8P5wuLyKJckTgWEi3XQuwTwIF7giuJHq0Fi9XH9iGEwAP6ohJ3XI
         dYAOBV6f13M9s9RS93S2Lrlmc0u5tV4kUcS4g6AG513DGr0bCD2sYdi9kw0k0o6fjKib
         wPQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782377921; x=1782982721; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WlALM42viJ6jSZuQC8WWXMFlP84OGAnUizlvgeGuSiM=;
        b=Zx3LaQhagq9VYxuuf7uz5Me6IFi1uVku8YYoOCnJc6YQCvBEp0NKmOYA64WHyYjOkQ
         8Az63MHNlciL8o7s1xy+OpW4GQnnCoOkvsbLJOq3bdL2v/2GxCvjdhOh25ucn2kwHS/s
         yLK84wBDAoJjkofQ0Eh143/TPAhQdixGpQseyTIJiOimhxFauGmiHTXJ5XJuYTQzQqE9
         jHf3pL60m/nUprNMJyt61y0XO/GaucEetdd0FQig1jKbKoe2oXqd8OokY2M6mEy6kl2D
         GjEpNOa64HFjL+w5At/7FbSMySX2naZR5uFkbBgnf1vPhgOs4nvrjYmsWSkfXZvhsydw
         rdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782377921; x=1782982721;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WlALM42viJ6jSZuQC8WWXMFlP84OGAnUizlvgeGuSiM=;
        b=BNv7otiBo4wiHX66H0JNIGrqeFopMxZoM0/3y0OSstjL9jyBeOXXV+nG7OYao6IIAe
         0ypM8CtinghAr0T3PhthlLI8QNFmXYZSN2L5slgKD8kfFSLDDHXhUbibVrHTLiAWIsdW
         6xdg8kbw61VIb9xF+YScqg/dG2sjSinqWiX6nKL7jcQUuLOK6PEGN+sak41mCD4b1A3j
         eTl1Y72cl5cOeRlFZFy2wo3Bk846qwXWsOmwamo4r0l7DCZTruFAEOeTfz6t4bzgMZac
         eF0vqNNBKArdAOKWOrIZrECZPqEEC3xwcGUqotm4pPpS2qxEjfWxxV/2W18DWZaXpvA5
         1kqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kS6pzdkbnTGyL8Q9+wi6l4XNTa6VTUAt3MTiEcfvZbtf+bmf4gp9fJVVEJE6rc4pYvpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO3xbCS/+jgZQWPYmMgbqgFjT/umPxFFj/AQ23DrH6RSLLV2Ot
	fG2XQcdrlRxHZu1vZJ0Q+eoi0WMiPc8RdUDhbdwHNHjjZ7Yp/PzEyWR/erELSxX3wI7gYW5naQQ
	deMdhSOgcTc8MFcY3PVyDzpfeyB5EYrRM5uCiG1wQ
X-Gm-Gg: AfdE7cl2X/ed8rV8PKVFeiNzGTgyw06riV2oUePQvic2u7WIk75jexQf4LVHLX/lgqP
	EbCLIAAIqPAmIflv6WnhQ10n3kgGKnZMsRJhNRQqy9UWtcqAJyl/uO5bshc966s7cSswSDw2JIq
	shBmQdx7AQ1lKVOwGMq+7KsNvQ4Ru1ZqR47eIgBuPSYeZwtRfdtdSaTme/0tdMOaNqpKUbnhrc1
	0FD0Wbc/RNvodRBgp5AWRPQtxzEd7JscFv2Gsdl29UziMGI0E6Mpm8qWjgIJE78frg4Dt0GEg==
X-Received: by 2002:a05:622a:4d99:b0:516:4f62:85ec with SMTP id
 d75a77b69052e-51a7097cdf7mr6284681cf.17.1782377920655; Thu, 25 Jun 2026
 01:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-41-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-41-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 09:58:00 +0100
X-Gm-Features: AVVi8CfUfIb60mScgDza3EFRj37-Gqen4zYG94Wyqg-j1BEdnIuc7f71TPLwtRQ
Message-ID: <CA+EHjTyOX8Ewj1pc0-OJr9So5=wOQPUUvJeQEC1a7=0OODEAHA@mail.gmail.com>
Subject: Re: [PATCH v8 41/46] KVM: selftests: Provide function to look up
 guest_memfd details from gpa
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jun 2026 at 01:32, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> Introduce a new helper, kvm_gpa_to_guest_memfd(), to find the
> guest_memfd-related details of a memory region that contains a given guest
> physical address (GPA).
>
> The function returns the file descriptor for the memfd, the offset into
> the file that corresponds to the GPA, and the number of bytes remaining
> in the region from that GPA.
>
> kvm_gpa_to_guest_memfd() was factored out from vm_guest_mem_fallocate();
> refactor vm_guest_mem_fallocate() to use the new helper.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  tools/testing/selftests/kvm/include/kvm_util.h |  3 +++
>  tools/testing/selftests/kvm/lib/kvm_util.c     | 37 ++++++++++++++++----------
>  2 files changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 79ab64ac8b869..3a6b1fa7f26ef 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -428,6 +428,9 @@ static inline void vm_enable_cap(struct kvm_vm *vm, u32 cap, u64 arg0)
>         vm_ioctl(vm, KVM_ENABLE_CAP, &enable_cap);
>  }
>
> +int kvm_gpa_to_guest_memfd(struct kvm_vm *vm, gpa_t gpa, off_t *fd_offset,
> +                          size_t *nr_bytes);
> +
>  /*
>   * KVM_SET_MEMORY_ATTRIBUTES{,2} overwrites _all_ attributes.  These
>   * flows need significant enhancements to support multiple attributes.
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 524ef97d634bf..0b2256ea65ff9 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1305,27 +1305,20 @@ void vm_guest_mem_fallocate(struct kvm_vm *vm, u64 base, u64 size,
>                             bool punch_hole)
>  {
>         const int mode = FALLOC_FL_KEEP_SIZE | (punch_hole ? FALLOC_FL_PUNCH_HOLE : 0);
> -       struct userspace_mem_region *region;
>         u64 end = base + size;
> -       gpa_t gpa, len;
>         off_t fd_offset;
> -       int ret;
> +       int fd, ret;
> +       size_t len;
> +       gpa_t gpa;
>
>         for (gpa = base; gpa < end; gpa += len) {
> -               u64 offset;
> -
> -               region = userspace_mem_region_find(vm, gpa, gpa);
> -               TEST_ASSERT(region && region->region.flags & KVM_MEM_GUEST_MEMFD,
> -                           "Private memory region not found for GPA 0x%lx", gpa);
> +               fd = kvm_gpa_to_guest_memfd(vm, gpa, &fd_offset, &len);
> +               len = min(end - gpa, len);
>
> -               offset = gpa - region->region.guest_phys_addr;
> -               fd_offset = region->region.guest_memfd_offset + offset;
> -               len = min_t(u64, end - gpa, region->region.memory_size - offset);
> -
> -               ret = fallocate(region->region.guest_memfd, mode, fd_offset, len);
> +               ret = fallocate(fd, mode, fd_offset, len);
>                 TEST_ASSERT(!ret, "fallocate() failed to %s at %lx (len = %lu), fd = %d, mode = %x, offset = %lx",
>                             punch_hole ? "punch hole" : "allocate", gpa, len,
> -                           region->region.guest_memfd, mode, fd_offset);
> +                           fd, mode, fd_offset);
>         }
>  }
>
> @@ -1662,6 +1655,22 @@ void *addr_gpa2alias(struct kvm_vm *vm, gpa_t gpa)
>         return (void *) ((uintptr_t) region->host_alias + offset);
>  }
>
> +int kvm_gpa_to_guest_memfd(struct kvm_vm *vm, gpa_t gpa, off_t *fd_offset,
> +                          size_t *nr_bytes)
> +{
> +       struct userspace_mem_region *region;
> +       gpa_t gpa_offset;
> +
> +       region = userspace_mem_region_find(vm, gpa, gpa);
> +       TEST_ASSERT(region && region->region.flags & KVM_MEM_GUEST_MEMFD,
> +                   "guest_memfd memory region not found for GPA 0x%lx", gpa);
> +
> +       gpa_offset = gpa - region->region.guest_phys_addr;
> +       *fd_offset = region->region.guest_memfd_offset + gpa_offset;
> +       *nr_bytes = region->region.memory_size - gpa_offset;
> +       return region->region.guest_memfd;
> +}
> +
>  /* Create an interrupt controller chip for the specified VM. */
>  void vm_create_irqchip(struct kvm_vm *vm)
>  {
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
