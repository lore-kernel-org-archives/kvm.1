Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9543A2544;
	Thu, 23 Jul 2026 05:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782821; cv=none; b=DdBV62NDUpDiUtPJDDOW495vDuD1/o0OqGzQYwmzpDRI4vHCftfNBAlZwumUibjS4LpATLgvAsgdQlwctHwvi0VgFwa+imKk5gWIp6ZjsBEJSz82J/f1tbwhVlUDWbGMnFU7eflKFBHLZb6/ro4gEtQbwkrM9f3UMQA2qwu9e6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782821; c=relaxed/simple;
	bh=BVuAOl45rkZ4I50vNMVjH0n3TJlXV6yjDtDBxGLJcIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flSiJ/si0rfPL88r3sVNZiKAs2+5/N+lTrspH9l3VN6A8Dh7Zh8noBF03Y67Ew3a3u9lx+3G0GXhfhejpcWzf4j1cGiCBAid6xBOXYplPo4e9/BGiWju9q3hAKMTze1uJ4ZmHc8JxDae3YBcuc2ULo/JJbtZDM1uv5EcHuNi40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMMjL3pk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMMjL3pk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEB61F000E9;
	Thu, 23 Jul 2026 05:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784782818;
	bh=l4aekZh2tmmlmxKWda5TLzpVJ42LAqAlQEE3KvG8uWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NMMjL3pkJT+vylBIV2TN7+gELnB9tJynIZUNHvmTaN8mrdTwxjh5ZSO9n+VMbtz/f
	 fxyXYIGl5vliVhytCRX+6CvRU2YePpQl/3x+J298ZW+7TcXn7c0BCTFvRLW0YjqybX
	 jxvwzbdh6yytJ5IauLIyGV2GWEVkPyrMXNy2gO2opuGyV7Fa6lKn0T9R8D4Im+p+Jn
	 29XED929/mu6OHYqrW/v8J+yTEB68yIoh4fu+cZsIXhZsinpyOnWxas4iK5ue/fPPQ
	 yyICOFxY0NdMcYZk+y8gLbj7ZTAImONpzZPdRs+uF2W4sPX3s4Ytc2Y1snYCNgGGBt
	 Ab4I1EsmCRdow==
Date: Thu, 23 Jul 2026 05:00:16 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 04/25] KVM: x86/mmu: Support specifying a minimum
 TLB tag
Message-ID: <amGfcbuCuWpd_D9c@google.com>
References: <20260616004155.1435766-1-yosry@kernel.org>
 <20260616004155.1435766-5-yosry@kernel.org>
 <amFgEO8NnEql1MmC@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amFgEO8NnEql1MmC@google.com>

On Wed, Jul 22, 2026 at 05:28:00PM -0700, Sean Christopherson wrote:
> On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> > In preparation for using the TLB tags allocator for SVM, which has a
> > range of ASIDs allocated for SEV/SNP, pass in a minimum TLB tag when
> > initializing the TLB tags allocator. The bitmap is conceptually shifted
> > such that bit=0 corresponds to tag=min.
> > 
> > Specifying the minimum value during initialization also makes the API
> > clearer, as the passed number of tags becomes the actual number of
> > *usable* tags, and tag=0 is explicitly excluded by the caller.
> > 
> > No functional change intended for VMX as VPID=0 is not used anyway.
> > 
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  arch/x86/kvm/mmu.h     |  2 +-
> >  arch/x86/kvm/mmu/mmu.c | 38 +++++++++++++++++++++++---------------
> >  arch/x86/kvm/vmx/vmx.h |  3 ++-
> >  3 files changed, 26 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> > index 9a2916012cbff..cfffee92b8b71 100644
> > --- a/arch/x86/kvm/mmu.h
> > +++ b/arch/x86/kvm/mmu.h
> > @@ -337,7 +337,7 @@ static inline bool kvm_is_gfn_alias(struct kvm *kvm, gfn_t gfn)
> >  
> >  typedef unsigned int kvm_tlb_tag_t;
> >  
> > -int kvm_init_tlb_tags(unsigned int nr);
> > +int kvm_init_tlb_tags(kvm_tlb_tag_t min, unsigned int nr);
> >  void kvm_destroy_tlb_tags(void);
> >  kvm_tlb_tag_t kvm_alloc_tlb_tag(void);
> >  void kvm_free_tlb_tag(kvm_tlb_tag_t tag);
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index e021ed562502f..bf2e0c2205631 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -8197,24 +8197,26 @@ static struct {
> >  	spinlock_t	lock;
> >  	unsigned long	*bitmap;
> >  	unsigned int	nr;
> > +	kvm_tlb_tag_t	min;
> >  } tlb_tags;
> >  
> > -int kvm_init_tlb_tags(unsigned int nr)
> > +int kvm_init_tlb_tags(kvm_tlb_tag_t min, unsigned int nr)
> 
> Hmm, I think this code should handle "nr - min" instead of requiring the caller
> to do so.  Because people that know how SEV+ works, but aren't familiar with this
> code (like I am right now), will probably find it confusing that nothing in here
> appears to account for the "reserved" ASIDs.
> 
> Maybe this?  With documentation that reserved ASIDs start at 0, inclusive, and
> are contiguous.
> 
>   int kvm_init_tlb_tags(unsigned int nr, unsigned nr_reserved)
>   {
> 
>   }

So essentially make the reserved tags included in 'nr', and min becomes
nr_reserved. I wanted to keep it generic by not factoring in the
assumptions about the reserved tags, but we can revisit later if ever
needed (very unlikely).

I am fine with this suggestion.

> 
> And then tlb_tags.min becomes something like tlb_tags.offset (that's a terrible
> name, but you probably get the gist).

