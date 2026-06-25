Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFE91EBFE0
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378555; cv=pass; b=V0MN/osVKCU0VEukoLBf4uAoImI0ChZBV4eN1i6Imwr9kRPlnsph/nssD8UKguUfw+3Uhks27Lhhdx7vZtE1TU2JF+kBrE4+WEaAV05A0ILcyNXiD2t9lk+iG7vj36kPix6xcu84Jb55e+cpcl/N+wJ/hkaNR6QlxTKAAI+qav0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378555; c=relaxed/simple;
	bh=9leBl/vLIM3qHmEH/Edw801DRnY2C/1n405lmvRfXQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QN1dtBZ0DdabdiXAFoAx01DHTD4UwgBkqnB8SOnu9LuIFZ7KRsPJrenM6wnj0l7Qa+VRhBG6TMBXySFObW4cJ/2+OFFCwPvlAvOVbdwUE3hRM8XN46jkLfgvRKWC95wWxOilt2+A0DKr9XqdNG7oM9FkzGmm7D3/41YC/j1DCqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jns7aV1x; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jns7aV1x"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-519ed52bcc6so216051cf.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 02:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782378552; cv=none;
        d=google.com; s=arc-20260327;
        b=KQpOJMF8Fh9uaWSNm+KUvDCjfffVaZIK+MK+OIHv+Ud8oG2tI1WXSEWEWakirx0D8a
         oM60Ndak8vXAKceS+8GDdc3bWeVd1osDdIvPwwYa0ni8hwuOg+4dd1pbOTIufRmMsVVx
         KqfHWf98LCG0V+XHjgLToIIMLsdZXnMvqH2b9RXY57bDCmEXEWQMNHteIuMv5kMkEyKm
         kueP7kGcKKYA++yw2UpVdPqq6NyoRrt+ZFFtd7llOMvKoKTNBGdIfTBuvAjmbMj2x9ru
         vz1KGY7MjZg9yiVDdnjirqFYUSwRszBcbfzuQJGUbZE6j1HzSGUXe4ELcsBK3k1UHu9F
         Vd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R9slP6pRfRJTNIoqGcM2r5fRlSRzSJ4pkgblOXA4Ai4=;
        fh=CekmLGcqPcaLHF8sOkJGmfpUyJcPjdJdjjggckMqTKs=;
        b=hksds9ABZCTmwqXziMDHTIqOohOyAbFdwe2vyknEwL8Yxcycs1ndE9J9G9SGJdbvbt
         swLKD9uokaVqMwqNmtZCi484lIKK1XJvDrpnU/EiaXQINhI4P4R9P1aGAJ4itB1zAdQm
         PvtCstDoLP00nhh4/kvN4gRGGoT1ZbYwuarhGxazibbSh+R+zWopw+Et1Z6SqHveomcy
         BMolX2ZlVAcXFyxsk5jI4PJso8IvPICW2sffjxserVLTRAAmAI1347pTH1rK7+aqV+m1
         hKjVZ9PX0Xsb05lBigqFbjKHRQ0Y5zNaTEa6y0K6kmoEfEjfbbIzBYJ9EmPfpn2PpOBv
         biNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782378552; x=1782983352; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9slP6pRfRJTNIoqGcM2r5fRlSRzSJ4pkgblOXA4Ai4=;
        b=Jns7aV1xdMJ0wBIgduyQPFR0i/K2Wph7bvTFq94JApIKkbLwjHjiWDFQ58cCcIsZHf
         XZ31fGTuuQMlpRgpEEqaJd1dY4NTe99sSITIrcC/QdBf6HApy3aSQp2UeEoc+SaaxTjd
         0nO3WRMR+xSeZ7s5VfRIjXflhEtnedgpuDeQsgKPY1RpwvYotgIcvJHKUpZPBj401Tpy
         g/WX2JLzw0068RgvKmCx7uZZtGnJNBdveIVRyu1QCbJpvjlqgpWDeZ6VXjMLx/n+2fyd
         8sQaqlrBb5aP3SnLO79/W+LlUQ4DQMFK6cUcMf2A0JGyzo7AiYDQa7lBQJUSKLoyTc39
         GDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378552; x=1782983352;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R9slP6pRfRJTNIoqGcM2r5fRlSRzSJ4pkgblOXA4Ai4=;
        b=PK7gVM5AccrRkcOoan1LVeiktlaPvB7mEWV/VYYtre555JR/sJYDaTJhCFC0H5iOge
         ep89swKCOLt2h0yBkhHhRZ4aP7yVSCMgjOhHBrtuk8+YCJzjpfa+NCUsHjik98a9VQxp
         /z5KlUwzw83c/+KFvuBBT2costMm+8o+NKmTf+BMGN9Tn+NejluGmIWljdAkLa5+HmPS
         5+ZOsncgqh2m82sXYAQiwAnwndk28eF/bQ0Px0+yh2IaVkxQu0o98Ew6UBZURAkZFu0w
         gRzjmDaRMck6gP+/g+he0wGBQ8YSJncZHXMOOPUXGTfrE+LxQ6783XReDEekWyyoeVfG
         k0mg==
X-Forwarded-Encrypted: i=1; AFNElJ8h6zHpsZS1rdGkOgw1A0iV0iRd7WEUblKuVhql7WxlsbBwehoA0U5yIM2Zj9FZhokiAl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyZ3LVjw75ZG2uMeDa7KfNntJvljZrowhrO2SJh/lg2P7XUJJX
	YzntB3EfLsNLK1nu17ScjlgEhv/GpaiHJkIix/Uh6BFf77y+F5HdzBkqqjgX06ljNsEfDUfOyVz
	GWE6D+rz1jNch+seXctOrefMiD8xjYDqjEvg3ySRP
X-Gm-Gg: AfdE7clMmABG4hDLEkXlZ9uj5r3JcpzEbFbuDx8m9MmjtSociFCi4Z3qVyt0Ql1vqr5
	CexykBFtMAjPz+YbEXbUvFFfxxa6gZGKU2T/A8sZ3FxT+O4b8rTPnmVJoGzUQ7ZXLlK/UNbGIUh
	ne0cpgqawMmnLb9foEJVbKZpP/FWewW/lOADp3aH7b8vu07wQC7BIldbEjToHemUaf33Ek9D2wk
	PLOHv7fU9mtvxPyY3rb5EQbnbU7jK2UIkMNjcrNNji761AILK9/xo1g+Gu2KmQg90wLspQL8Q==
X-Received: by 2002:a05:622a:681b:10b0:51a:713c:7444 with SMTP id
 d75a77b69052e-51a713c7d5emr4672591cf.18.1782378551258; Thu, 25 Jun 2026
 02:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-42-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-42-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 10:09:00 +0100
X-Gm-Features: AVVi8CetvJC1Xv6WjNcu210fkMycJkdRkSQWNh7yK6lGtnxBBkgdQs08aLwNOyo
Message-ID: <CA+EHjTyHQa2Pmgc=0zf6emtALxAN5f8gUXoV11mShz2qdrqjTw@mail.gmail.com>
Subject: Re: [PATCH v8 42/46] KVM: selftests: Provide common function to set
 memory attributes
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
> From: Sean Christopherson <seanjc@google.com>
>
> Introduce vm_mem_set_memory_attributes(), which handles setting of memory
> attributes for a range of guest physical addresses, regardless of whether
> the attributes should be set via guest_memfd or via the memory attributes
> at the VM level.
>
> Refactor existing vm_mem_set_{shared,private} functions to use the new
> function. Opportunistically update the size parameter to use size_t instead
> of u64.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  tools/testing/selftests/kvm/include/kvm_util.h | 46 +++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 3a6b1fa7f26ef..db1442da21bb1 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -454,18 +454,6 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, gpa_t gpa,
>         vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
>  }
>
> -static inline void vm_mem_set_private(struct kvm_vm *vm, gpa_t gpa,
> -                                     u64 size)
> -{
> -       vm_set_memory_attributes(vm, gpa, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
> -}
> -
> -static inline void vm_mem_set_shared(struct kvm_vm *vm, gpa_t gpa,
> -                                    u64 size)
> -{
> -       vm_set_memory_attributes(vm, gpa, size, 0);
> -}
> -
>  static inline int __gmem_set_memory_attributes(int fd, u64 offset,
>                                                size_t size, u64 attributes,
>                                                u64 *error_offset)
> @@ -532,6 +520,40 @@ static inline void gmem_set_shared(int fd, u64 offset, size_t size)
>         gmem_set_memory_attributes(fd, offset, size, 0);
>  }
>
> +static inline void vm_mem_set_memory_attributes(struct kvm_vm *vm, gpa_t gpa,
> +                                               size_t size, u64 attrs)
> +{
> +       if (kvm_has_gmem_attributes) {
> +               gpa_t end = gpa + size;
> +               off_t fd_offset;
> +               gpa_t addr;
> +               size_t len;
> +               int fd;
> +
> +               for (addr = gpa; addr < end; addr += len) {
> +                       fd = kvm_gpa_to_guest_memfd(vm, addr, &fd_offset, &len);
> +                       len = min(end - addr, len);
> +
> +                       gmem_set_memory_attributes(fd, fd_offset, len, attrs);
> +               }
> +       } else {
> +               vm_set_memory_attributes(vm, gpa, size, attrs);
> +       }
> +}
> +
> +static inline void vm_mem_set_private(struct kvm_vm *vm, gpa_t gpa,
> +                                     size_t size)
> +{
> +       vm_mem_set_memory_attributes(vm, gpa, size,
> +                                    KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +}
> +
> +static inline void vm_mem_set_shared(struct kvm_vm *vm, gpa_t gpa,
> +                                    size_t size)
> +{
> +       vm_mem_set_memory_attributes(vm, gpa, size, 0);
> +}
> +
>  void vm_guest_mem_fallocate(struct kvm_vm *vm, gpa_t gpa, u64 size,
>                             bool punch_hole);
>
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
