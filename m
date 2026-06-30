Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D835841322F
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824809; cv=none; b=oXG8DXB+56OdWnr5mFKNN2C3C/dYlOuHMPeqdkmAyyMah7WT+0Yn565uDF4T4NCHpT4pxrZ0BoLcFkrzhGcG40oJY02FwkjbCD9p+ABmT2f2abi6V+IquHxJ7YoDNHQ/f8qPoLZsI/6ho01oiwR7DWFUOla3QFFwB/BpNMSwcIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824809; c=relaxed/simple;
	bh=CyC5ny1bAKX8WJocn0Ihrx94MGIS+dltREW/5h3LDKw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P6iu9zVhZyECa0nUw7Nm10501i0rsDSvRipqudomfRsuAq1NWVf2jLOYAtk9h4aJ9FFr5UCpcBsg/FNJZ/Wo0L7qASoXILrds9rENNj1A4f5NWcXhvNcbiSAkJp6niEJNIyv05LAHD/BNI5Qfzx9O78Z6JfUyPQYuzJ3cLVgbrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sraIy6fQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sraIy6fQ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37e1f96b248so1348807a91.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 06:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782824806; x=1783429606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GKmnhEmEL5Q9+VdT5YV6KYZqx0ZeftgvFW7GNXKQRJU=;
        b=sraIy6fQUAc9T2fRHpKRf5UIjBi0jiWOeptfzHjJGemwp260d1pQnh1JKRazxc0NNJ
         ovXNZnB36PaChp8qyWvb1TQiY+ALfjd1/FBY95Iol2/sTjiT5FAZr+46ZaTJUQQszlWB
         /Od4z6goREAn123zyfofwdZAkLf82+ijSFBaxAii4NMcyBu9TpVI7WoQx0cAAkBpeof+
         YOi9dY3u/m/Hl+q4OmjZ7tqKvUvfkTeQXEiitrQdM/DL8NefX/Vbd4RQzHBi2Hors8EI
         j3u1K5XdOQZWeIEc2laW5j3gRFd3ToFT4TiJIXqHi8sfbxG8P90ThZCIA3p24G6PMaP8
         YK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782824806; x=1783429606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKmnhEmEL5Q9+VdT5YV6KYZqx0ZeftgvFW7GNXKQRJU=;
        b=a+/rqD95qglCym7jIKFyXtjw8S2v2Dz+iDzencIfJNmYZkhud0KFkEU3fPRPvGWTwx
         d/j2KskgHDuhgOm8P+/7PI/+coU37vCLsD5/vXYuCUj4u8h62lEu2j/SXWX7PhjGuOHb
         SAsWiffpy7YExXQehD9gvhdBpKVdgdudHhLwtoGvDUrVKr0OF5C+S0oYPtf3i+AAF6Cx
         enAVeijgNxx1wUeV2St55P/KYtEp6JLVGn8ogil4k/+EKDlbdX43AYKVcNN5h45FOs6U
         ai+o7isYlQesIuWcYOkL69fFwQH02RAu3Wk93bq8RRJnwIAzF0JTGvhrMRsrJj2/eldR
         fCLA==
X-Forwarded-Encrypted: i=1; AHgh+RrkTPQIGpeqqY4AsYipqd9Aq+A22CE90+fI0HwD5jIT6TQVWtNjyivcAJu0pvMoFdTX5i4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBVU72rkOiV8fHjhorfRrgdfR5L2EO7Dcgf4DmFZfd/SeAdva
	tliBEFSD9Q8f/GFOqJxZ6aIolx7CXjLk9uwLByA+cgS5DP4+bCSviCqZTrShSqh8FU294aJtVUS
	FQ2ZHBw==
X-Received: from pjboo8.prod.google.com ([2002:a17:90b:1c88:b0:37d:8595:7a08])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:390b:b0:380:540:d49a
 with SMTP id 98e67ed59e1d1-3808bd2ffe9mr347677a91.7.1782824805381; Tue, 30
 Jun 2026 06:06:45 -0700 (PDT)
Date: Tue, 30 Jun 2026 06:06:43 -0700
In-Reply-To: <6b1f0c77-f059-4f8d-8f46-443b944c59a0@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-4-9d2959357853@google.com> <6b1f0c77-f059-4f8d-8f46-443b944c59a0@intel.com>
Message-ID: <akO_Y0-ERgBoCqoQ@google.com>
Subject: Re: [PATCH v8 04/46] KVM: Decouple kvm_has_arch_private_mem from CONFIG_KVM_VM_MEMORY_ATTRIBUTES
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
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
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 30, 2026, Xiaoyao Li wrote:
> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> >   arch/x86/include/asm/kvm_host.h | 4 +++-
> >   include/linux/kvm_host.h        | 2 +-
> >   2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index 8e8eb8a5e8a6b..1bde67cf6eb0e 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -2394,7 +2394,9 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
> >   		       int tdp_max_root_level, int tdp_huge_page_level);
> > -#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> > +#if defined(CONFIG_KVM_SW_PROTECTED_VM) ||	\
> > +	defined(CONFIG_KVM_INTEL_TDX) ||	\
> > +	defined(CONFIG_KVM_AMD_SEV)
> 
> Maybe we can just remove the #ifdef and make it always avaiable?

No, because common KVM keys off the macro to determine whether or not PRIVATE is
a supported attribute:

  #ifdef kvm_arch_has_private_mem
  static u64 kvm_supports_private_mem(struct kvm *kvm)
  {
	return !kvm || kvm_arch_has_private_mem(kvm);
  }
  #else
  #define kvm_supports_private_mem(kvm) false
  #endif

And also whether or not to provide the in-place conversion param (without PRIVATE,
conversions aren't supported in general):

  #ifdef kvm_arch_has_private_mem
  bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
  module_param(gmem_in_place_conversion, bool, 0444);
  EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
  #endif

I agree the #ifdeffery is ugly, but kvm_supports_private_mem() in particular
needs to evaluate to false if PRIVATE memory isn't supported.
