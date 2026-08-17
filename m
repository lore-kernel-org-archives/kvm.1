Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A31470E82
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 21:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001049; cv=pass; b=DqQwyYlrdxrl4pBV6D83DwgN2Zft7TEFxMNyh0PwqCoBFCZDy4Yc04iufIAvyrQLGcM6eO+JVK8aCifk/Je6DyEvJIm0VjH3dnI10QsKtwQ4y1Ce0WRbidZmtSjsYWCNqDNUiTQ7jdPiCiizb9ob3YWRdoQYiY3Y3ME9UXtsu2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001049; c=relaxed/simple;
	bh=QAx+8stP7eWiwXcVtZ6oQcPc/yneHJUDQ532rBo3tmo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsOfuGPSlcfY94AEHIRrJUM5pau5z3+gffeNVABCAwUHf1QitnBMKa5Rpluv/VxLb4+Ot55zMzcBmT6iY+K1gNjfIR7SoagqKqdugUDuSLviA6eNnutm+63DKpavdOFgYk4a9MnZk4Nc/3JfxaRFuHWHYzqjpZyjjOexIXXaCB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=otx1ybqT; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="otx1ybqT"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc11a30a259so2809183a12.3
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 14:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787001045; cv=none;
        d=google.com; s=arc-20260327;
        b=giKF2PzKZgQ4P0m1I3e9OWu3mjoUtG7CKdXqIta4Loq564E+FChvmzpsqAd39OSD1T
         FhbyD9IeGUbHfqwsc3zNDF0dUAmBWaMogp5HVosN9EfGq1qT2GvVdrbd7JPV1rtoPIBU
         Yrb4wdJDGn1qVg7WX/IPr1uBBUnJ3J+JeNJzebixJKbP2yNnmdzKKfJnfTxOJL5zosg9
         psIR/5xS83Zx30hGf1NUvpw/u5yGDKCJKuh+Kew1k8RaUT6FQj7WsD05HmB8PvWIa0UV
         r1gC09GznV6aM2zCI4SvvvLDIaXePuujAIUpZqya97PVXBW0xHVxb8WC1Ai3Q/ivnFIH
         OMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=fXsAYGWxJyVowLSo+okTw01FCA+GPEAZRUERjwSXi8s=;
        fh=kqoOTIHTux7ezJ2XMS0BLyGpWCBEYjaECrPDVtyROnk=;
        b=ATWw0FJjn5+uhI4KvKz2CzZvEjTZnZwP0MygpM/q5Agqn0y7/oULP6hTe+QyWT0uBp
         SnnEb59F/kEN9jkx6nJJjeGC8wwUGxakQdrwmM+EgJsSjPFnME4FCMyacq91OQORq5h4
         IsoKXY0iN+Iy6KuE2YPbb5xY7lTkpJCpza/oFszRKmGsuuTvCtauZPd4qDPT9I3KTCPR
         rLLYZok2+Fg5tK3hAiBW+HxKS3X4qqQcXZ8ibtxJAhY1QpnTuz5J7zITI9TL3ruBRQbV
         doCyBMxJzqVE6qPNqUg6BLnutZ8HUDg9HspqRj53hFP8crryawb3oGeH6LuCn9DPr0kd
         xWHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787001045; x=1787605845; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fXsAYGWxJyVowLSo+okTw01FCA+GPEAZRUERjwSXi8s=;
        b=otx1ybqTXmds0ypcCwGr28grUwyjC1BDIkhhdWe8vDVALIk+WzbBUG3A2hBmW/vwv8
         BxaRr+/TpEKZsJr8HjbP7LwTY7oxk6MejbCeKrRBXT7e2Uo7Tq6oy38W3hoKyXeOu7Xg
         fI7ydFHLmLPw7g0EefQ/3WfJiqCfMyvmBg4u207Jw1Yq663D3BoKx4VxwyN7N51Wz96r
         O8YhNbWByqwcbBJH1StsiAFJ0oscfO+ykjvPlIWRHKE3TKXHuhUnIjAGUbzrbDtoRcQ0
         cp9vnZ9Ezj+yn3DD1F+skvwtRQMLUoGny7Dq8qastdwMbRCg/gMNtWMOqcBX7s5o7lJz
         h9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001045; x=1787605845;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fXsAYGWxJyVowLSo+okTw01FCA+GPEAZRUERjwSXi8s=;
        b=JCII2r2t1Tn6sTIqXZ4Ffvji5shz5Ci3/Jkky+aO+1EG49he2cMw3kZgphzWcDQcGB
         I5QcYa5jqjFy9g9/a/coliDldjZdTec1zQxKr5xhmMIlzA/jgjiSTWB2DbV/QjGXP35U
         FOFPBh2vxfhR0B4xwmQfovIde4l8B8T53T/dvXbcrGrtXiVf9Yi53K2v7aO0NgwFnPns
         SaYzCkSgXaAYrQFd/Fjx2QM2utU4cbyenne4Z4Uvt2Wp6zlcNo8BrUnB+FW2HiRQgqa5
         ysqT7OsZcS/Uku+92JOxSzoLVXwJadVo9HjHFZvy0F9Msgi2NO5+fPXcI+1LuF5dNRJB
         0HRA==
X-Forwarded-Encrypted: i=1; AHgh+Rp8ge2+7bGLv0BIXzB6vOP6qwcctWn0CJ/nlDMS+ulNsAbI815HgSoeHz+D+G1iRtEfiew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMg8xNXvMGjELEyyedhS41+NOfCFHMFdBsTTrZZCRddkiZnpbA
	a1pMS+G/SmHH+xg9HG75LNa6wbi8TipOGouWZTdTzCG+VDEHnNxAyXudq+qlmrWDASPrBpk5vhQ
	U6izlfjLXqSxX09WYhA2IDcnesvV+9LPYix73mYlo
X-Gm-Gg: AR+sD11qtAeaatd+/L5ntGQqbBfqTijNjVUoO+Bvm7B5D2OF3Z8X177VfuwugAXlWQi
	oz9Flkeii/3q+3K7/B6kSSjUZTTKxn7LqRMrQj5gIqviJuDVO14c7VCDiZPHcaLrVuwPXjIgt2D
	JIEBKFkdw18ZwPdL2gig8YcHUxtlMdhFSH7biya5BP++5AKDIU6h4jGyzIqUZRudV+ewAlMeTAu
	wvMe96mN6T+bzMcWGsp1iZy0WXZdaY1JKxEMWngLlWxI+MJA7kNTOe66Dg0Z8LHPvnJiwCL+RbH
	fnUalADFThA7nA4z2RoEflb1NlbKHMRxeft6g5Qy50wtTecSffDhCsSXreql7PMQof5jX0KmuQq
	feA==
X-Received: by 2002:a05:6a21:3398:b0:3bc:5284:5445 with SMTP id
 adf61e73a8af0-3cc71d53eacmr29096172637.21.1787001044531; Mon, 17 Aug 2026
 14:10:44 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Aug 2026 14:10:42 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Aug 2026 14:10:41 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aoNlZRb5SV7hyNuk@google.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-12-2fc18ee6d3ba@google.com>
 <1ec08cd8-3072-4753-ad5e-cd34956647f8@linux.intel.com> <an3o4h-E8mj6CUaM@google.com>
 <CAEvNRgGpCVCGVjc9jCt9Yr+XypF=71h6eBahkXNkrXhfrtGY+g@mail.gmail.com>
 <an5AcEG9mqDgnBYk@google.com> <CAEvNRgE+05c9U8C=Zkm1S9hLw3Lw6YMmijZhEe7J4rYQAuNyEw@mail.gmail.com>
 <an8umm0qisEidt4n@google.com> <CAEvNRgFNCDDSeuvbwj7pD_d18o1TBXo4TNR2dXHxpm18KPfR5A@mail.gmail.com>
 <aoNlZRb5SV7hyNuk@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Aug 2026 14:10:41 -0700
X-Gm-Features: AcwNN1XkDnEKM5GNqm9LOem-ACT2KBKH21AQXps-0CKMqEJi94nO9ANnicdLg5A
Message-ID: <CAEvNRgEojt8Kpot9VaFUyVbVH5QVEdW-TgQUbVnpVCNzFtdVag@mail.gmail.com>
Subject: Re: [PATCH v10 12/41] KVM: guest_memfd: Call arch make_shared
 callback for to-shared conversion
To: Sean Christopherson <seanjc@google.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, aik@amd.com, andrew.jones@linux.dev, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Fuad Tabba <fuad.tabba@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Sun, Aug 16, 2026, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>> > On Thu, Aug 13, 2026, Ackerley Tng wrote:
>> >> Sean Christopherson <seanjc@google.com> writes:
>> >> > That's why I think it's worth analyzing the cost: if it's in the
>> >> > noise, leave it alone.  If it's meaningful, figure out a not-too-gross way to skip
>> >> > the entire thing if kvm_arch_gmem_make_shared() is a glorified nop in the end.
>> >>
>> >> Is noise defined relative to the entire conversion process? Would this
>> >> benchmark look like
>> >>
>> >> 1. Convert 4G to shared on TDX with CONFIG_AMD_SEV defined
>> >> 2. Convert 4G to shared on TDX without CONFIG_AMD_SEV defined
>> >>
>> >> and then compare the difference in time taken?
>> >
>> > That'd work, though I was envisioning something even simpler: use rdtsc() to
>> > count the cycles it takes to iterate over various ranges of memory.  Do whatever
>> > is easiest for you though.
>>
>> I made some changes to add rdtsc() for the conversion process as Sean
>> suggested [1], and exercised conversion like this [2]:
>>
>> 1. Initialize some memory as private
>> 2. Get the guest to fault them into Secure EPTs
>> 3. Converts the memory to shared <<== this is being benchmarked
>> 4. Converts memory back to private
>>
>> I made it build the VM once and convert 5 times:
>>
>> ./gmem_benchmark_tdx_convert --iterations=5 --size=1g
>
> ...
>
>> And here's the above, tabulated:
>>
>>   nr_pages      make_shared            total    percentage
>> ----------  ---------------  ---------------  ------------
>>          1              930            39278       2.3677%
>>          1              252            28060       0.8981%
>>          1              176            26952       0.6530%
>>          1              176            27038       0.6509%
>>          1              176            26980       0.6523%
>>          1             1072            37236       2.8789%
>>          1              316            28338       1.1151%
>>          1              176            27182       0.6475%
>>          1              176            26972       0.6525%
>>          1              176            26886       0.6546%
>>     262144         15041018       6616067680       0.2273%
>>     262144         14937462       6608542680       0.2260%
>>     262144         15138858       6599494898       0.2294%
>>     262144         15721972       6610219850       0.2378%
>>     262144         15000406       6615114540       0.2268%
>>    1048576         61902982      26400884028       0.2345%
>>    1048576         61746114      26401170984       0.2339%
>>    1048576         61096794      26404409058       0.2314%
>>    1048576         61446290      26447461896       0.2323%
>>    1048576         61774646      26444608360       0.2336%
>>
>> Looks to me it is within noise.
>>
>> I also actually tried measuring the conversion time from userspace with
>> CONFIG_AMD_SEV enabled and disabled. Converting a 1G-sized TD was faster
>> by 0.2%, which is in line with the above table. Interestingly, when
>> converting a 4G-sized TD, skipping kvm_gmem_make_shared() was _slower_
>> over 2 runs. I don't have an explanation for that.
>
> Might be some cache/memory locality benefits?  Though with a conversion that big,
> it could also be nothing more than bad luck.
>
>> I think the code was correct. (If it makes a difference, I skipped
>> kvm_gmem_make_shared() using a custom guest_memfd creation time flag and
>> skipped make_shared if the flag was set on the inode.)
>>
>> I thought adding a kvm_arch_has_gmem_make_shared(), defaulting it to
>
> I would do kvm_arch_has_gmem_convert() for consistency with the Kconfigs, and
> because the cost of the reclaim invocation is a non-issue.
>
>> false for all archs and having x86 override with
>> !!kvm_x86_ops.gmem_make_shared is not too bad either:
>> + doesn't leak anything, since the function being called is
>>   kvm_arch_gmem_make_shared and the accompanying function is
>>   kvm_arch_has_gmem_make_shared. Or maybe just a little, since all the
>>   other ops don't have the accompanying _has_ function
>> + it's a kernel-internal thing
>> + not too many lines of code, not too complex
>
> It also provides a good excuse to kill off the #idfefs in guest_memfd.c.
> Compile tested only, but I'm thinking this?
>
> From: Sean Christopherson <seanjc@google.com>
> Date: Mon, 17 Aug 2026 12:31:50 -0700
> Subject: [PATCH] KVM: guest_memfd: Optimize away conversion overheads via
>  dead-code elimination
>
> Add and use kvm_arch_has_gmem_convert() to guard guest_memfd's invocation
> of arch hooks related to converting memory between private and shared, as
> only one half of the x86 CoCo duo needs the runtime hooks (any pre-work is
> pure overhead for TDX).  At this exact moment, the overhead is negligible,
> but that will change when in-place conversion comes along, at which point
> to-shared conversions will "need" to find all affected folios prior to
> calling into arch code.  In quotes because very technically that work could
> be pushed to arch code, but that would bleed guest_memfd details into arch
> code and would be far worse than adding yet another kvm_arch_has... hook.
>
> Opportunistically provide the kvm_arch_gmem_make_private() declaration, and
> rely on dead-code elimination to eliminate the call to non-existent code
> when CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT=n.
>
> Reported-by: Binbin Wu <binbin.wu@linux.intel.com>
> Closes: https://lore.kernel.org/all/1ec08cd8-3072-4753-ad5e-cd34956647f8@linux.intel.com
> Suggested-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 3 +++
>  include/linux/kvm_host.h        | 3 ++-
>  virt/kvm/guest_memfd.c          | 5 ++---
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 283847619ff8..5d5a7723abb6 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1854,6 +1854,9 @@ enum kvm_intr_type {
>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
>  #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
>  #endif
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +#define kvm_arch_has_gmem_convert() (!!kvm_x86_ops.gmem_make_private)
> +#endif
>
>  #define kvm_arch_has_readonly_mem(kvm) (!(kvm)->arch.has_protected_state)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 03bfc92864b6..e824ba59c60c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2599,9 +2599,10 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
>  }
>  #endif /* CONFIG_KVM_GUEST_MEMFD */
>
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>  int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>  			       kvm_pfn_t nr_pages);
> +#ifndef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +#define kvm_arch_has_gmem_convert() false
>  #endif
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b596486d184c..39d94938b5f6 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -773,11 +773,10 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		folio_mark_uptodate(folio);
>  	}
>
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> -	if (kvm_gmem_is_private_mem(file_inode(file), index))
> +	if (kvm_arch_has_gmem_convert() &&
> +	    kvm_gmem_is_private_mem(file_inode(file), index))
>  		r = kvm_arch_gmem_make_private(kvm, gfn, *pfn,
>  					       (kvm_pfn_t)1 << *max_order);
> -#endif
>
>  	folio_unlock(folio);
>
>
> base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
> --

I'll inserted this as the first patch for v11.

Then, the later patch "Call arch make_shared callback for to-shared
conversion" is now:

	if (!to_private && kvm_arch_has_gmem_convert())
		kvm_gmem_make_shared(inode, start, end);

kvm_gmem_make_shared()'s definition is still guarded by #ifdef
CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT, and there's still a stub for
kvm_gmem_make_shared() since kvm_gmem_make_shared() is defined and used
in the same file and the optimizing out only happens later.
