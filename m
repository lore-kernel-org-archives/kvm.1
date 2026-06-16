Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A53C819A;
	Tue, 16 Jun 2026 06:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591389; cv=none; b=Xo0ilagpMGJ8edGGnKk2RKTYmQdC39QIqiZDDCXBb0D/kG4AlGW2XJYucfwnyQOKQufBwkZhXRuqEN0w3M42MVlCjydY47fh2PA4BArh2mXuAZRqzm5kEhU000ArgxK3lsLNkzztFZ70gfWAlHquh3paRxfx6KPEtQ5tFf8ZB04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591389; c=relaxed/simple;
	bh=yeXTWBMDfVYyDMcTh6RemfuGVrnkEW4Q4H4mS5haS2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/fTaRx86/tyEKJRy8m5hkCRFQW19TTKB2og+YFetaaN8CQnsXPHS8VWlPFB3247+BveWmvN38m0wi/0srbuddHghapq2U9km3/f7ihFA2XcIhxFvHUSArfYKAjknnK62XijBO9MPKYMz8tJi1kO6ynxzFYRDqw+UihpTBNuz7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6aRbH6K; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6aRbH6K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781591387; x=1813127387;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yeXTWBMDfVYyDMcTh6RemfuGVrnkEW4Q4H4mS5haS2Q=;
  b=X6aRbH6KpBbuZnP6aoUkpqmW/4z0BeTT/iDX6doAObdoWotM7dtFgHfa
   TpEdjnRNsOhRLHX8w6zWg5vj+xqcSqEfmu70wYy8OZrdjlqE8GRNjYs8Y
   vYYdy3fEo0CJ794VVPKxBvgoYw8Gu5hn9Rr8Ofss2NZRQExxmiX58fjOJ
   fBVxZmvS2ZgrvuU2d2T6rivINxuRfQZfkr3KmMRd34eSWQxuBNdbrqyVs
   t5VzB0PYzoVYOxoyh976secY8R112lPN3YuwHbdRIDeMmCPL68cBJOUm2
   tGPrgKifbV5oJPcRbKD8YUWGX2qcxaH4U9QQgS+RZBqfXOMuvGqCPI0TC
   g==;
X-CSE-ConnectionGUID: Hi9YFVJrRAKW7+0ce/TlMA==
X-CSE-MsgGUID: PwBwOP6JRfKv0E2+VnzyTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="92905969"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="92905969"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 23:29:40 -0700
X-CSE-ConnectionGUID: PZxr5B/FRWyb4fnMGTGY4A==
X-CSE-MsgGUID: BcIPS7RtTqCDJleynatLEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="252659559"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 23:29:36 -0700
Message-ID: <906e9797-08d4-4ebe-aed3-34002aa1f917@linux.intel.com>
Date: Tue, 16 Jun 2026 14:29:34 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/30] KVM: x86: Move "struct kvm_x86_msr_filter"
 definition to msrs.c
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-19-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-19-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Move the definition of "struct kvm_x86_msr_filter" and its associate,
> "struct msr_bitmap_range", to msrs.c, as the details of the filters are
> very much implementation details that can and should be buried in msrs.c.
> While the _existence_ of filters is public knowledge, almost by definition,
> the contents don't need to be exposed outside of the MSR code as the filter
> data is provided by userspace, i.e. it pretty much has to be dynamically
> allocated, and thus never should be fully embedded in a globally visible
> structure.
> 
> Note, this creates a discrepancy with the PMU event filter structure; that
> will be remedied shortly.
> 
> No functional change intended.
> 
> Suggested-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 15 ++-------------
>  arch/x86/kvm/msrs.c             | 13 +++++++++++++
>  2 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 09e437c947a9..4ff6304c02d0 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -315,6 +315,8 @@ enum x86_intercept_stage;
>  struct kvm_kernel_irqfd;
>  struct kvm_kernel_irq_routing_entry;
>  
> +struct kvm_x86_msr_filter;


Just FYI, the code failed to build on my desktop with an old gcc version v9.4.
Due to dereferencing pointer to incomplete type ‘struct kvm_x86_msr_filter' via
typeof().

It's not the fault of the patch, the issue was fixed for GCC 10+ according to
the link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44257

But the minimal tool version got for gcc is still v8.1.0, not sure if it needs
to bump the version in scripts/min-tool-version.sh?


--- Build error information below ---

In file included from ./include/linux/rculist.h:11,
                 from ./include/linux/cgroup.h:15,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/resume_user_mode.h:8,
                 from ./include/linux/entry-virt.h:6,
                 from ./include/linux/kvm_host.h:5,
                 from arch/x86/kvm/x86.c:20:
arch/x86/kvm/x86.c: In function ‘kvm_arch_destroy_vm’:
./include/linux/rcupdate.h:502:9: error: dereferencing pointer to incomplete type ‘struct kvm_x86_msr_filter’
  502 |  typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
./include/linux/srcu.h:240:20: note: in expansion of macro ‘__rcu_dereference_check’
  240 |  __auto_type __v = __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
      |                    ^~~~~~~~~~~~~~~~~~~~~~~
arch/x86/kvm/x86.c:9969:22: note: in expansion of macro ‘srcu_dereference_check’
 9969 |  kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, &kvm->srcu, 1));
      |                      ^~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/notifier.h:16,
                 from ./arch/x86/include/asm/uprobes.h:13,
                 from ./include/linux/uprobes.h:66,
                 from ./include/linux/mm_types.h:16,
                 from ./include/linux/mmzone.h:22,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/xarray.h:16,
                 from ./include/linux/list_lru.h:14,
                 from ./include/linux/fs/super_types.h:7,
                 from ./include/linux/fs/super.h:5,
                 from ./include/linux/fs.h:5,
                 from ./include/linux/cgroup.h:17,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/resume_user_mode.h:8,
                 from ./include/linux/entry-virt.h:6,
                 from ./include/linux/kvm_host.h:5,
                 from arch/x86/kvm/x86.c:20:
./include/linux/srcu.h:243:2: error: ‘__v’ undeclared (first use in this function)
  243 |  __v;         \
      |  ^~~
arch/x86/kvm/x86.c:9969:22: note: in expansion of macro ‘srcu_dereference_check’
 9969 |  kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, &kvm->srcu, 1));
      |                      ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/srcu.h:243:2: note: each undeclared identifier is reported only once for each function it appears in
  243 |  __v;         \
      |  ^~~
arch/x86/kvm/x86.c:9969:22: note: in expansion of macro ‘srcu_dereference_check’
 9969 |  kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, &kvm->srcu, 1));
      |                      ^~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/rculist.h:11,
                 from ./include/linux/cgroup.h:15,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/resume_user_mode.h:8,
                 from ./include/linux/entry-virt.h:6,
                 from ./include/linux/kvm_host.h:5,
                 from arch/x86/kvm/x86.c:20:
./include/linux/rcupdate.h:502:9: error: dereferencing pointer to incomplete type ‘struct kvm_x86_pmu_event_filter’
  502 |  typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
./include/linux/srcu.h:240:20: note: in expansion of macro ‘__rcu_dereference_check’
  240 |  __auto_type __v = __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
      |                    ^~~~~~~~~~~~~~~~~~~~~~~
arch/x86/kvm/x86.c:9975:8: note: in expansion of macro ‘srcu_dereference_check’
 9975 |  kfree(srcu_dereference_check(kvm->arch.pmu_event_filter, &kvm->srcu, 1));
      |        ^~~~~~~~~~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:289: arch/x86/kvm/x86.o] Error 1
make[3]: *** [scripts/Makefile.build:548: arch/x86/kvm] Error 2
make[2]: *** [scripts/Makefile.build:548: arch/x86] Error 2
make[1]: *** [/home/litbin/workspace/kvm-x86/Makefile:2143: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

