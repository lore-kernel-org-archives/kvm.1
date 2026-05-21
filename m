Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8094E39FCC8
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365641; cv=pass; b=nH0YK7KwH4A0YLZmuboEV4hPXG2YrAqwk2KvaVfN3KPJ/KZTtJ5NWx3uVV3/m2UGXCzr8cOxi9e1L1IwT7uMqEShQTG8OtwqlfigpaOeXt/QhSIQwWMkmR74s0V+yrQZxm6oFm+MfwjksKAE1zp9N4NR4hWYTH7n0eEadbA7PYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365641; c=relaxed/simple;
	bh=LYJgALBMb92rrgNb+Wzk0+WAd9qpquSCRXx7gbDTCrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3LC6UBks9cdUsEePLtxEHUR1TuyzsKLya9aAxa0IDVgfDrkV3K98DSI+y1Gd4hG00JqqvkgLQ/69uoF9f5JMLDIjCexQexwZvDLWdpJ/qPTyROeBUZGmHS5CUVUPCa4GMoC8TVVKP/9HxEynLZbz8cKHOIZJPa3241Ye44KhOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFHJ6HfF; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFHJ6HfF"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-515548f390fso5701cf.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 05:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779365637; cv=none;
        d=google.com; s=arc-20240605;
        b=H2V/AEmkWVIpcdsC+Xe3iL85j1Fyw0eQa7oXGGXmv1SsNS/jstn/U1U4DFD3p5gxX5
         zo8iWLzX7LNgORGCdjTZKYl3OymO7MW0F01p0DuDGaXRsVSHuXbr0oHWTnYhdcHZ6pU0
         hK4vxqTOX/SmbaT+E5/8+NPT4X2trl8tzHF7WlcO23Ch6WENTjqcfm6aYdyFi5svV6Wd
         9I620Ka3lIOxkAXKVGf3qYaNVq7LljtHgFHw+MEowvVrfiO8DSzi7eu5CzBerZySKP3c
         9rUZ3Ny1tMUJ1XfzkZp/ggMx2VXdadyvTbiFLTFD+gi+wqZyOxpM1GLyqj1nC8tl/h6M
         Uudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GJBi6kqgS/T+2nzhRr9ooN0dsVaPQuEMdq7fBLHxWNg=;
        fh=xecdtPRFhPbDPl+qJ9rZC5PWY2PaVIMdNSfYKardwew=;
        b=CThZAb86mr7pbBApTqInb8R7P/foVgE+NrIdRrnFiIEgnG8yrPnnA/JQd+25E2fV4H
         FXIJghQ8CFew6Ji6A9KYT6AHnybNMIqNzsHF9l69i0eYr4ygkKUdqWNjO7fqT5Gg991w
         UZfgxwWVGIDh/2B+vV2lZvXA6tjy8p5OqqSoCO3dqddfKCy9B0p7fni/3EyfM/C0qdl/
         p4vENDF1d/+AQUyuTLJ9aZ5neCwBFt2XNuTq3LLFMN9gInUQEfoFb9M71tsuSIvvpsM0
         sG4D17jlFt9vOnkSMFxAITz0ubNsIqWM4ktz0Pct6p0KP/3yR4dT+NjRj3rZlVC8Ooa8
         if4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779365637; x=1779970437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GJBi6kqgS/T+2nzhRr9ooN0dsVaPQuEMdq7fBLHxWNg=;
        b=GFHJ6HfFWhVmtJRoPBhDn/ulCqOaysCBK3brYom94GQlfDOQKzB4MpFvZaJXjPiuOu
         8pg2JPzVfn+xbIA6DWFgM6A+uhslgNWQtGgCU2ug24dPsPimU8xwdeTlE4IfEq0zGmBM
         muYV6M0QYp1cB+LpfLwntvULFEWtjUHli91ZTaVflY2C7nnKwbMFrrSWUF6GZAt6Xc82
         Wt1WUZcmimL4Md1t2HqIxmDmg7Y2il9qS3uWNUnOZA0tRW5GJo0GTSUZHD9w5AZ+OSLf
         VLyshcq8SWuFAa3WwrrPeyG2vSE8f8VXueePjhBRhApvdFPk/cX8TsCpc5Z90HGJl4z6
         Spcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779365637; x=1779970437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJBi6kqgS/T+2nzhRr9ooN0dsVaPQuEMdq7fBLHxWNg=;
        b=TpXsetGrHIo/8BVEL/fmbogbKmwvu4Q5uCWx2hX2qU3keJn31OzgATW84IdrJOvebV
         7taPM/XQYEE14WZ1dWvd5KCWrxDh5FChluKVXyFGalLXrBDB393FjvzkSuChsTL22mx8
         gN52mNste4m2FWsCtlFhL25gAAS07Rh9EYJ88BPLhdS4NRMY/fUXd9ODGArdQ5hP8Byv
         fg4AAfKtfWfRyNXmbC4s/Dz8wGEPmX4K5QJWrnfVRSPIczC75/+F0SB0okEVtwAOc8uW
         FZSQVW9iphSqtK9THxRmsSRaKf89MaZHinJiCNxuL/Ad7grwDjRUg1L9m8Yn76uUVk0J
         jDuw==
X-Forwarded-Encrypted: i=1; AFNElJ+ph9jKN13g8zY3PECSgMFcBKkllhZMlRyLXwvZQHz6PghRoAmiig6cl3Dpgw27po23sCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0v1I149Z3V+Qxie4/jsEhMeV7yJAIw1Iu6/HrsQHVsoBJvAMQ
	QrcH86i2yotkm4GywWHf5tZQnHshuleTf/rKbIy04ZcmIMXQ5rZRV4NciyghpBGExUfSHTTNsaM
	E4ni0csHHjLo/hjrPCVWvh6PGdPVej5IyCKCkdTzT
X-Gm-Gg: Acq92OFf6kv9Lj8PSj0d2q2O8l5VmouIAS3YlWmGxOSGc0kwikYVMG/PeVTRVUL15Oz
	Cc7edGibb6UhbEFwZ1JyZuDJFWGYDNbgGm0Zij0AXqqZz2NXPLp/9yn9ouYI2tYxXFNYjfzJBmS
	VOE7hQITp+7WLtsa/GTC/vAda2SdAL2eqS6qkNHgqusHwwJYJYBt60JIjEtu2gK+b33+oD93Kti
	kgHyVoVLo6Ps5NfSyDDBMeC6o081ONrZfGztENqCPUaYj88whLM/Q1QmJFEHyDVRPG1X1rwUNzG
	E587dIM+bwQsTzJG5lI=
X-Received: by 2002:a05:622a:a94e:b0:516:4f62:85f1 with SMTP id
 d75a77b69052e-516c552fa38mr6885881cf.22.1779365636942; Thu, 21 May 2026
 05:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-24-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-24-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 21 May 2026 13:13:19 +0100
X-Gm-Features: AVHnY4KHC9HIiDmjKgEge5iH3VKNmS75Hv9JyZN2WMHPkcnLceuX40X-36gd_Tk
Message-ID: <CA+EHjTzfo0_uxHbrcntLdHLaLGB3uO41+JzcyW+vHr+u=VB5=g@mail.gmail.com>
Subject: Re: [PATCH v6 24/43] KVM: selftests: Rename guest_memfd{,_offset} to gmem_{fd,offset}
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

On Thu, 7 May 2026 at 21:23, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Rename local variables and function parameters for the guest memory file
> descriptor and its offset to use a "gmem_" prefix instead of
> "guest_memfd_".
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  tools/testing/selftests/kvm/include/kvm_util.h |  6 +++---
>  tools/testing/selftests/kvm/lib/kvm_util.c     | 26 +++++++++++++-------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 2ecaaa0e99654..f19383376ee8e 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -690,17 +690,17 @@ int __vm_set_user_memory_region(struct kvm_vm *vm, u32 slot, u32 flags,
>                                 gpa_t gpa, u64 size, void *hva);
>  void vm_set_user_memory_region2(struct kvm_vm *vm, u32 slot, u32 flags,
>                                 gpa_t gpa, u64 size, void *hva,
> -                               u32 guest_memfd, u64 guest_memfd_offset);
> +                               u32 gmem_fd, u64 gmem_offset);
>  int __vm_set_user_memory_region2(struct kvm_vm *vm, u32 slot, u32 flags,
>                                  gpa_t gpa, u64 size, void *hva,
> -                                u32 guest_memfd, u64 guest_memfd_offset);
> +                                u32 gmem_fd, u64 gmem_offset);
>
>  void vm_userspace_mem_region_add(struct kvm_vm *vm,
>                                  enum vm_mem_backing_src_type src_type,
>                                  gpa_t gpa, u32 slot, u64 npages, u32 flags);
>  void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>                 gpa_t gpa, u32 slot, u64 npages, u32 flags,
> -               int guest_memfd_fd, u64 guest_memfd_offset);
> +               int gmem_fd, u64 gmem_offset);
>
>  #ifndef vm_arch_has_protected_memory
>  static inline bool vm_arch_has_protected_memory(struct kvm_vm *vm)
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index df73b23a4c66a..11da9b7546d03 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -947,7 +947,7 @@ void vm_set_user_memory_region(struct kvm_vm *vm, u32 slot, u32 flags,
>
>  int __vm_set_user_memory_region2(struct kvm_vm *vm, u32 slot, u32 flags,
>                                  gpa_t gpa, u64 size, void *hva,
> -                                u32 guest_memfd, u64 guest_memfd_offset)
> +                                u32 gmem_fd, u64 gmem_offset)
>  {
>         struct kvm_userspace_memory_region2 region = {
>                 .slot = slot,
> @@ -955,8 +955,8 @@ int __vm_set_user_memory_region2(struct kvm_vm *vm, u32 slot, u32 flags,
>                 .guest_phys_addr = gpa,
>                 .memory_size = size,
>                 .userspace_addr = (uintptr_t)hva,
> -               .guest_memfd = guest_memfd,
> -               .guest_memfd_offset = guest_memfd_offset,
> +               .guest_memfd = gmem_fd,
> +               .guest_memfd_offset = gmem_offset,
>         };
>
>         TEST_REQUIRE_SET_USER_MEMORY_REGION2();
> @@ -966,10 +966,10 @@ int __vm_set_user_memory_region2(struct kvm_vm *vm, u32 slot, u32 flags,
>
>  void vm_set_user_memory_region2(struct kvm_vm *vm, u32 slot, u32 flags,
>                                 gpa_t gpa, u64 size, void *hva,
> -                               u32 guest_memfd, u64 guest_memfd_offset)
> +                               u32 gmem_fd, u64 gmem_offset)
>  {
>         int ret = __vm_set_user_memory_region2(vm, slot, flags, gpa, size, hva,
> -                                              guest_memfd, guest_memfd_offset);
> +                                              gmem_fd, gmem_offset);
>
>         TEST_ASSERT(!ret, "KVM_SET_USER_MEMORY_REGION2 failed, errno = %d (%s)",
>                     errno, strerror(errno));
> @@ -979,7 +979,7 @@ void vm_set_user_memory_region2(struct kvm_vm *vm, u32 slot, u32 flags,
>  /* FIXME: This thing needs to be ripped apart and rewritten. */
>  void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>                 gpa_t gpa, u32 slot, u64 npages, u32 flags,
> -               int guest_memfd, u64 guest_memfd_offset)
> +               int gmem_fd, u64 gmem_offset)
>  {
>         int ret;
>         struct userspace_mem_region *region;
> @@ -1055,12 +1055,12 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>                 region->mmap_size += alignment;
>
>         if (flags & KVM_MEM_GUEST_MEMFD) {
> -               if (guest_memfd < 0) {
> -                       u32 guest_memfd_flags = 0;
> +               if (gmem_fd < 0) {
> +                       u32 gmem_flags = 0;
>
> -                       TEST_ASSERT(!guest_memfd_offset,
> +                       TEST_ASSERT(!gmem_offset,
>                                     "Offset must be zero when creating new guest_memfd");
> -                       guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
> +                       gmem_fd = vm_create_guest_memfd(vm, mem_size, gmem_flags);
>                 } else {
>                         /*
>                          * Install a unique fd for each memslot so that the fd
> @@ -1068,11 +1068,11 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>                          * needing to track if the fd is owned by the framework
>                          * or by the caller.
>                          */
> -                       guest_memfd = kvm_dup(guest_memfd);
> +                       gmem_fd = kvm_dup(gmem_fd);
>                 }
>
> -               region->region.guest_memfd = guest_memfd;
> -               region->region.guest_memfd_offset = guest_memfd_offset;
> +               region->region.guest_memfd = gmem_fd;
> +               region->region.guest_memfd_offset = gmem_offset;
>         } else {
>                 region->region.guest_memfd = -1;
>         }
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
