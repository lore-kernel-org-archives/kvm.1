Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106BF453A2F
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468064; cv=none; b=LUjilkZpyLgQn5K4YrzhpVFEaX+CN01sbsVTominbPImjtUi7VIXgJRoGe3zTgDoiOnnbkz5MEmFmSuDU37vIQl24y+Y0wW+gGJzKNBE7yQkkkg63druTga5cJNvQz/dOvlVaQaljXxqCQvpBTph8wpH1iiEaRtmGPUmY4l6wtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468064; c=relaxed/simple;
	bh=qCketXdC6G4ZLCZLNhe1WZPM9Debu7ygnkGEqtz+VmA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ObqYBZBy/kHtXgHR8v0QM+xWXWNbBOQgbNgCCU6xUGHOeprz7TJsp6lUdn17OYIPQc9fR4880zqCajttIKYZDgM2KyP7FfS4+2mNkD1vqQ32j11rWZSXzAipze17GEdymkDZ/HXkuuPehjkZ49KC5tWsJ8VRbU8r+5D4/+b1We8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F49X/zVv; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F49X/zVv"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c85798977dcso16458a12.0
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786468062; x=1787072862; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gwvEEAMAfJPVoc+KKEpciJe+2g7dIY92dShmHQsz/E0=;
        b=F49X/zVv8UmGsm5oyFjALIX5FyEeO1+grXbI3CXTiYRcIUb0Jt7ltOLzswg3CpGVr4
         LjahIee1/j0WtHHzYWR7WMW+ovoRI6/JR3THFYctwGqEVqm4bbloMbIl2GIr9sxAlXP9
         iLoqQzPAxHfRxidsyxu5Liv6Wtxi4+ROIo+3CsTTDF4L08gsEA8SciNO3sVC/0rqSmwd
         DdlbiZ1rXAMmUygV23t7bhqENdYNdgvTilW7lZfhdP49truENISEyQK3YY83sk8CZ05U
         INve+T5y411zZ3XPqBRBPqIxJXe9UU1TYz3HpNKNWwT3rqs/PuLN3iVH4HBMw/z4hA8V
         hqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786468062; x=1787072862;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gwvEEAMAfJPVoc+KKEpciJe+2g7dIY92dShmHQsz/E0=;
        b=dyQ78dR5hdO9I2llZKArf0iYuw2NlqqucqlMCSMc5OGhlIPYhhQOVf95EJG+GYgeTC
         hI+oYVay1w609aqLBY8+m4Es7SRG0FRjJxy1x53/MQix1D46CZP2z+GlLenPQeT9fAmq
         tqRc1eD0k/JslFNJm5EXE4nw5Si1Gml1fpRAinQJhezrZkUhORtyvyBJVTLypAbR20xB
         +UbkaOEd4kxHWZakfVWl9cfbSz1pNUMV2SeVuX5spO+U7vNTEQsaooZbaPedhnpQ6I+V
         KthUpLtR4ExkV/2IGKsWBQGOMOSJeH2PGxa5MH3cLKBA0mx2qfS6FgIuBoxcohpJpZ4v
         Vk4w==
X-Forwarded-Encrypted: i=1; AHgh+Rp/YcuzxvBYc4BBx7fcpaj8zW8Fy1zDH7a7OW81RkPOlryQRjJXveSQMDx/aVVmpvgs+yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHdI1YmVjqUjuecvbYx3VkwCrb8dj9sPluHGdQvd6CU5+fqL7V
	903U6ANwngNfE1YQPu8vSrOfaPi27Hl9f+FrJVCeLl4LPxTnzPfPSb+H0rH+7L0qBjVqNgIWagY
	8MpHCEw==
X-Received: from pgly26.prod.google.com ([2002:a63:181a:0:b0:c96:680f:db07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1b81:b0:3bf:7c02:c46f
 with SMTP id adf61e73a8af0-3cc2b853809mr6508305637.14.1786468062243; Tue, 11
 Aug 2026 10:07:42 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:07:41 -0700
In-Reply-To: <anrI0WZ3rA0q6X+Z@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806214050.78058-1-seanjc@google.com> <20260806214050.78058-3-seanjc@google.com>
 <anrI0WZ3rA0q6X+Z@yzhao56-desk.sh.intel.com>
Message-ID: <antW3aKeEabMCsyV@google.com>
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Harden "map private PFN" against
 unexpected root invalidation
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 11, 2026, Yan Zhao wrote:
> On Thu, Aug 06, 2026 at 02:40:48PM -0700, Sean Christopherson wrote:
> > Move kvm_tdp_mmu_map_private_pfn()'s reload of the MMU into its tight loop
> > so that an unexpected root invalidation has a better chance of being
> > handled gracefully, even though it should be impossible for the vCPU's root
> > to be invalidated after the initial reload.  As is, encountering an invalid
> > root is *guaranteed* to put the task into an infinite loop (albeit a
> > breakable loop that honors NEED_RESCHED).
> Note: without the newly added is_page_fault_stale() check in patch 4, an invalid
> root would not put the task into an infinite loop :) 
> 
> BTW: As noted in [1], is_page_fault_stale() only checks !mirror roots, and
> kvm_mmu_reload() reloads mirror roots only when !mirror roots are also invalid,
> since an invalid mirror root was considered impossible. (up to now, no?)
> 
> [1] https://lore.kernel.org/all/anrD8nI8RfYoNvbf@yzhao56-desk.sh.intel.com

> > Add a WARN to try and detect bugs that break KVM's expectations, along with
> > a comment to explain why it should be impossible for the root to be
> > invalidated.
> And there's already a warning in kvm_tdp_mmu_map():
> "KVM_MMU_WARN_ON(!root || root->role.invalid);".
> So the warning also seems redundant.

No, KVM_REQ_MMU_FREE_OBSOLETE_ROOTS can be pending even if the current root is
valid.  And once the is_page_fault_stale() check comes along, the WARN in
kvm_tdp_mmu_map() is effectively unreachable.  The patch ordering is weird, but
there wasn't a great solution because adding is_page_fault_stale() first would
create an obvious infinite loop.

> > Cc: Kai Huang <kai.huang@intel.com>
> > Cc: Yan Zhao <yan.y.zhao@intel.com>
> > Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 621b0a42f2a1..c6cac893cbad 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -5184,10 +5184,6 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> >  	if (kvm_gfn_is_write_tracked(kvm, fault.slot, fault.gfn))
> >  		return -EPERM;
> >  
> > -	r = kvm_mmu_reload(vcpu);
> > -	if (r)
> > -		return r;
> > -
> >  	r = mmu_topup_memory_caches(vcpu, false);
> >  	if (r)
> >  		return r;
> > @@ -5199,10 +5195,21 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> >  		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
> >  			return -EIO;
> >  
> > +		r = kvm_mmu_reload(vcpu);
> > +		if (r)
> > +			return r;
> > +
> Since kvm_mmu_reload() is moved inside the loop, should we also move
> kvm_gfn_is_write_tracked() inside the loop to prevent unexpected bugs?

I'm leaning no?  That check was extreme paranoia in the first place.
