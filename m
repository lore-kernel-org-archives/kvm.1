Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4823CC7F1
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365550; cv=pass; b=FpzSTkk6wOqbhZUMzYjHESAXjd+qK5s5ouVCtbYJVDlNqQ1TDgyYU/7t4UG0Nt18Q4FAzPWGiVfJXyahIXrcv0NKJyrD5LCmD80Fx6oVD2RGeHKgfcfSKDCgth5x54SxODUzezYi7W+BvVupZ0J/lifEnfA2z867kWU5AYAkZGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365550; c=relaxed/simple;
	bh=mUWTvSyqIoqkETcgZuIds2FYkJwuokmb9q2VYy+exYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzu6NFgBMTMAI6/+POrPOUByNUzEh8+TkeYp4N5/e9RsTHQ7giqLfV+tNJLG9bgIHzR4RD2xvHeRy4UacN8ZdftXI97DdtK31f2HYVEBoh4PDAiCMENCFLVlcmcruPyaVjWD/nTKpTbqRRAEiXfIlwHgeDIZ1uBOtKCRYONW8Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eSxUwN2U; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eSxUwN2U"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-515548f390fso4881cf.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 05:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779365547; cv=none;
        d=google.com; s=arc-20240605;
        b=Hv81L7dc1qxrqx2kc5ciywUoxXLLuU8ahAva5rqkjx1KZklMp+6IdfTr3A4N1EGNHw
         CqWpQ/R53Jcccg/KjQu7ZmzxHPo2Gbfughusa/SQ/MH94BzdFwb9fTmF+exZRSFJpF4W
         2+hF+IG9IB02I3yRu2Ses4W6mxwa9mitYXnw60nzxuV2OMyh8tCDpSQM4KQCMHdCV0iH
         PBV0u/VLuqVHEHGWzctJd/hgIlSiTorKjHgh9aWr9me/Wjx7swbDQMxB6gZFg97k7xsr
         s0Rk7kRr9yIF08jsgQBaxDJvW0t5QO9zfCtQfBS48fM0wTpPEsN+FJ+UkvHR+gaBKi3i
         TCHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=F1wmmG0cNegB4E+dlRzmEOWoIo3QXb0mRCuTWAZdGJs=;
        fh=EKoznAxkBa+vZSjoXwLYOnaUFTCjx6Qe391aJV3P31o=;
        b=GVI4Gsicvcg2Yst+7zsva9/04nqj2QZ8ZqvRVam5/APTRBE2Qs+iKJdI5TY6g+HP8i
         T1kEAa/007loKlZSm0jHX1Ep5elYEF70xRt57L9xNnZJVKGHvEKJ0m//ClwnZmJCk6kX
         C9Nwk3gUcTWc6l1EjMYe7iPNwAG/xc+Mwh2UUWu3refEvMGI77Ms8enMxDjd1YolBmak
         waHslcDhauRaZrmqlRx69RkBkboMEb8baI3emW8X4jazjd0ItAxhqjWM2+O0XfguAhZ5
         jobReQIzZIqSiy4VnSPREUm9ofiapT4RTTTKS4Cxr9hzrfZQk5TcaRETBZ1xR3FSoHYs
         LEkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779365547; x=1779970347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F1wmmG0cNegB4E+dlRzmEOWoIo3QXb0mRCuTWAZdGJs=;
        b=eSxUwN2UUN0gARyiwlHRhjFeTgTwoYSX6HnwV3HJBMWWPGKbRBBm8GoVr5jIuqOxxT
         KLvP6ZUdR4xTql4y8w669ChBS76GV5GjN6JhPBx4/0Y/Gm4pdN64oH5Nbk5V3iAqmZ26
         CSmQP/S/dnUovh/Mt3TredUArYrIjoVsofJhWHXfP9ECgMjtCvUNRAN+aaLzfWVFk19I
         ObfdSkGwq5zPKDUOlnkfNi5cyGa5akLiCDtta8BKEhh0SCgkqPMvDL5EcjZBkjetHE/x
         iWvwetxUqdI8bYADuRlHhVdXqTAXPP5D4yZ0BPu3qE/FWSAdee6DWPWbrnSXdnJEWZoO
         kOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779365547; x=1779970347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1wmmG0cNegB4E+dlRzmEOWoIo3QXb0mRCuTWAZdGJs=;
        b=EePtaLHYQ5obu5+mUTV71BGvjqWagHLGx58SR33IVmgj5eYZqzkeDexHjOOrXcHdt2
         ygDsZRKHc3JyeH9dlPXZuyI6kTJpvv+F9QYrtXq2XftbeHMZrl3FXxUlGnYZpEacBmIi
         oqy57m1VvkQ7eJ7PI05yJsL2Kb1kLzEzp1vUHtcEW6+tPnYW6hEMRQRHUvpR9iLzVkuW
         6FG3Vo6qokjnF2l1qjSg98PU8QM9t+uTygE6gqZszO/BadOo6DyG9xdi/WlHpwOtkiRk
         h3JazVTbPci2ga5apn7qUz+xneOunWF2vFs45N4BiA4IvbxkhiA5ZkVTHNgfu0z7C/Z1
         qLsg==
X-Forwarded-Encrypted: i=1; AFNElJ8LxHzCfzkjPQ76NexCz1EPWomcAQgUBa6tgAEz8P9fAPibZv4go+dQznaFjJ8HjMCEO6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlXS14LjHOTR4Kw4QsaNnJw15LjNMtNWtga+7UOejpIPHd2phJ
	SPPP7UFqXfJRSqLcIUI1kC0QxuQ2nFR1l3PPqYDQPLNmItR1h+4Emjggyl4dyz/plOe8z3Xy6ve
	ciQIUfSARZZ/U7bFX7/pTPbWp25duitYmyPEb95w8
X-Gm-Gg: Acq92OGh/6xDXb0UQaxAg65cjFRfxEFxfR5w562JgjxrnNAodrPApDHPk77+mEytTAi
	vLy3BYWyFi/qnx7STquju9dHeUCD87yECh/ItIeU5yqfzGwiNMPeUl5YxlwrOvn9FENh2DCozrS
	Ly9mJCJ9wjjb79Ab9OJRGDF/n75sqU95vzgK0Ax/eIELld5oobHhlLRur/Ziv2xbwCzRsP8c1Gl
	7E4mTyAJpG3+P9jb4q9IvXqx4HcgYZQNgpJVFoTkGIsfQHYGNJViKVRFvIXcNwmz0O/F067yqvM
	A4+NDl7aDTBt7BOiFBfE/CjydAOXHw==
X-Received: by 2002:a05:622a:995:b0:514:c25e:c164 with SMTP id
 d75a77b69052e-516c545d403mr10074811cf.10.1779365546829; Thu, 21 May 2026
 05:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-23-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-23-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 21 May 2026 13:11:49 +0100
X-Gm-Features: AVHnY4I9MwIePcJowBi5yVnmSFDQMJen-Uv4dVyPJ1sLPspDsU0lqTAnhNGKza0
Message-ID: <CA+EHjTyftaGzz5-NgZGHZvgvuKDCBVSuhSsWSQ=niP_giotk7w@mail.gmail.com>
Subject: Re: [PATCH v6 23/43] KVM: selftests: Create gmem fd before "regular"
 fd when adding memslot
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
> When adding a memslot associated a guest_memfd instance, create/dup the
> guest_memfd before creating the "normal" backing file.  This will allow
> dup'ing the gmem fd as the normal fd when guest_memfd supports mmap(),
> i.e. to make guest_memfd the _only_ backing source for the memslot.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 45 +++++++++++++++---------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 2a76eca7029d3..df73b23a4c66a 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1054,6 +1054,29 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>         if (alignment > 1)
>                 region->mmap_size += alignment;
>
> +       if (flags & KVM_MEM_GUEST_MEMFD) {
> +               if (guest_memfd < 0) {
> +                       u32 guest_memfd_flags = 0;
> +
> +                       TEST_ASSERT(!guest_memfd_offset,
> +                                   "Offset must be zero when creating new guest_memfd");
> +                       guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
> +               } else {
> +                       /*
> +                        * Install a unique fd for each memslot so that the fd
> +                        * can be closed when the region is deleted without
> +                        * needing to track if the fd is owned by the framework
> +                        * or by the caller.
> +                        */
> +                       guest_memfd = kvm_dup(guest_memfd);
> +               }
> +
> +               region->region.guest_memfd = guest_memfd;
> +               region->region.guest_memfd_offset = guest_memfd_offset;
> +       } else {
> +               region->region.guest_memfd = -1;
> +       }
> +
>         region->fd = -1;
>         if (backing_src_is_shared(src_type))
>                 region->fd = kvm_memfd_alloc(region->mmap_size,
> @@ -1083,28 +1106,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>
>         region->backing_src_type = src_type;
>
> -       if (flags & KVM_MEM_GUEST_MEMFD) {
> -               if (guest_memfd < 0) {
> -                       u32 guest_memfd_flags = 0;
> -                       TEST_ASSERT(!guest_memfd_offset,
> -                                   "Offset must be zero when creating new guest_memfd");
> -                       guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
> -               } else {
> -                       /*
> -                        * Install a unique fd for each memslot so that the fd
> -                        * can be closed when the region is deleted without
> -                        * needing to track if the fd is owned by the framework
> -                        * or by the caller.
> -                        */
> -                       guest_memfd = kvm_dup(guest_memfd);
> -               }
> -
> -               region->region.guest_memfd = guest_memfd;
> -               region->region.guest_memfd_offset = guest_memfd_offset;
> -       } else {
> -               region->region.guest_memfd = -1;
> -       }
> -
>         region->unused_phy_pages = sparsebit_alloc();
>         if (vm_arch_has_protected_memory(vm))
>                 region->protected_phy_pages = sparsebit_alloc();
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
