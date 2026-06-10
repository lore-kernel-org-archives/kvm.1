Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03C7331ED7
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781129994; cv=none; b=dZhlFGU7d74eIjYufCEL/dbp7CuJKpoY907bpHHjMBhmIBpY9uLDl0J3RZnVNXgOWXc8cJzISzuOuCUdT825mhCDlT5/Gy9sKoUug5Z+4W43i7knWEiGwCd3b4K1Wc8+ffMkMUwokkqAp9j+dggzWYEtADzXNg6GKuutw912Jys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781129994; c=relaxed/simple;
	bh=BOqSVJmxLhcTxId4mKxBy6QT0CiREOB6byamA0QERaI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kmf4+GPWNh9poGlAzqFf6ShCo5mKhMchL4HkNzxN56RI904EmxZwECDz8h9w1t2OIp4UQL9PAoKRHS0wihtwkXl+oVvP+c4vaa6GN5QusWA+v07aSVsGS5pqSXoC95vhWqoIwesqPTIcA3FQ6j1VP6dydZyz0vcNirGibJxiVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aTXNsPFv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTXNsPFv"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c2d65d9773so5741865ad.0
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 15:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781129991; x=1781734791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCXjEr9VLMiB3RNr9V4LUHEdwVcyHXL9rlViMmJIYhA=;
        b=aTXNsPFvPEiDDCAFSsO+jf7T2rvyxel9mt033kL/2WL2iU91N/kmuxaDkFJgWYjFrd
         SeQarSM61K9UxEz7t5fxO91xCLK5u1UtLCm11LwAgOOqlmET3VCO7jeKEDEZW1nL5iPZ
         cD9EfhFKfLZ0pmGEBkL33ve59G8BqR9xLPF24QZjIet4MbrvMQwSz9RC/qQUg/KouUT9
         d7gF9HeqEnJpwczrFtsW+UHc61nR3EU16RbvvPsFkQ1iT5bCa+Sl0pyPVOGPALqv4QHV
         Navl7sxehCbkngefZoZEEEdrhdv4O2S11Iur3zsllRJU3IySo8ExbT34nHpLJaD14ia2
         Ev2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781129991; x=1781734791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCXjEr9VLMiB3RNr9V4LUHEdwVcyHXL9rlViMmJIYhA=;
        b=BRtHpNSzLfn65rShsiJu4Nqs2vp3KLzkHNgwhCLSWQ0tY+FFjYMddp2HC1Cd/SF2YK
         l3bSrl1KT5G7ZgLcx8FaZvQF3FBB4HJMkn2aWHJrKFv+03vnpUuKzedHfwp1aG4F9NSu
         pa5/lGXRCCmdXspQYjGaG/0x2GgYfwt2uiYmUSPHhG9LZ55xSXoKnpP6VdB6eQiDH0wp
         XumGPfisCLu8+XdqPFazroqizyT4FAdvGjuL9NiVyvAgv+06Z+BlIMbFA3r2UrLCt7Uw
         CEvWtVc0G1eXi3RWQkQUOiXNFdIoGYJfBcvjEntXgH2kRQRsPSVaapm65rPiXNFEa/Ge
         yGbg==
X-Forwarded-Encrypted: i=1; AFNElJ+gZpMHpOkuJeyOv2rH91qSh56ERl2WL3bbokR0V8eSQtzpvzkgNvCNj30I19EOjmwXCPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiXE21lza3bhYPGY6apdBBDIM8j89NxTsAA0NWm9X0cVRW7Qij
	pIKHQGpX905Ia/sKn2vsb2WRsjQECk6KtN5HBm78J0wIzJA8GGAv6xCE2ji8HgMI92U9Hd58/rE
	S6TjqNw==
X-Received: from plcp17.prod.google.com ([2002:a17:902:e351:b0:2bf:1958:c64d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1acb:b0:2c0:ccdb:e02c
 with SMTP id d9443c01a7336-2c2a1baf93fmr114931065ad.7.1781129990748; Wed, 10
 Jun 2026 15:19:50 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:19:50 -0700
In-Reply-To: <20260522-gmem-inplace-conversion-v7-4-2f0fae496530@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com> <20260522-gmem-inplace-conversion-v7-4-2f0fae496530@google.com>
Message-ID: <ainjBvqDTU5DNZR7@google.com>
Subject: Re: [PATCH v7 04/42] KVM: Stub in ability to disable per-VM memory
 attribute tracking
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
Content-Type: text/plain; charset="us-ascii"

On Fri, May 22, 2026, Ackerley Tng wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Introduce the basic infrastructure to allow per-VM memory attribute
> tracking to be disabled. This will be built-upon in a later patch, where a
> module param can disable per-VM memory attribute tracking.
> 
> Split the Kconfig option into a base KVM_MEMORY_ATTRIBUTES and the
> existing KVM_VM_MEMORY_ATTRIBUTES. The base option provides the core
> plumbing, while the latter enables the full per-VM tracking via an xarray
> and the associated ioctls.
> 
> kvm_get_memory_attributes() now performs a static call that either looks up
> kvm->mem_attr_array with CONFIG_KVM_VM_MEMORY_ATTRIBUTES is enabled, or
> just returns 0 otherwise. The static call can be patched depending on
> whether per-VM tracking is enabled by the CONFIG.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---

...

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index abb9cfa3eb04d..ee26f1d9b5fda 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -101,6 +101,17 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_shrink);
>  static bool __ro_after_init allow_unsafe_mappings;
>  module_param(allow_unsafe_mappings, bool, 0444);
>  
> +#ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +static bool vm_memory_attributes = true;
> +#else
> +#define vm_memory_attributes false
> +#endif
> +DEFINE_STATIC_CALL_RET0(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_KEY(__kvm_get_memory_attributes));
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_TRAMP(__kvm_get_memory_attributes));
> +#endif

Fudge.  This morning's PUCK discussion about VBS made me realize that we really
don't want to kill off _all_ per-VM attributes like this, we really just want to
kill off PRIVATE.  And even if RWX protections never arrive, conceptually shoving
all attributes into guest_memfd doesn't make any sense, because it really is only
the private vs. shared state that is tied to the physical memory, things like RWX
protections aren't so tightly couple to the data.

It'll require a bit of minor surgery to these patches, but the silver lining is
that I think the end code will be slightly easier to follow.

I'll sync with you off-list to splice in the changes to your current series (I
have them sketched out).
