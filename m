Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE083B38A4
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973865; cv=none; b=Vn3dHLavFMUqr/ocd2xNxT8rsbmsNJ0xvCzTE6lzy5Ty9AUz4YN4Y9aOKA+cF+RaNanac4o/0LROTVoUx0wZxFk/dAtRQPP1tczb8bKhrQ1S3fGShUgpYFHQCAIGXOTNkKfygmXG02psDCQ7VdZiIoka/AiaPcAM++kphlPTDgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973865; c=relaxed/simple;
	bh=30ZTbT56GY9AkmmdBy2y8tmHdsCkpJYYneFiHFc6OMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jeLrnBJSdaIvG4uUH5CtGvjzmruTt7wKbY6aMhY0lIT2iBGI6rgbvAXzzSkBxY3jfUfaSjLaktkUvTuVjinrwNywioEpiTLb3vqLQ3xyIFvut4ImH+FdR8MaYNhcAHWB1xE1ZkUv5Riktoeom15HLR2vYUK6IRP/fWIpdi3X3vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m0Rw9Ght; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m0Rw9Ght"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848474825ffso3916400b3a.0
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 06:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786973862; x=1787578662; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BB4bAflOhpYzRfZSR0NX17xoh05DYymUXAZR8QHYHVg=;
        b=m0Rw9GhtVGid90pdmPTInFeCJGNu/ky3kQA+Nj4nhRuIis6eYWj9CpsQKv8oJ5xauD
         PUKJefaQiVxyPgrFEgnER/x86Civ8AKW6BIVnrUeNgU69x3GPYhboa9pRiYKELULUBcx
         E67TcGYFqUS/qNCk5frrzeyzOLNiXm4U0oXHFj7pzNPbooqp3vG2mBDg8xqfarbthPGf
         DLIhkiHLiJVfVZeurEIZ5R/f4S9SOi95iMVTaNJL8ciexONGojq3HR0NSWF4yIicffXO
         FQ0XS+jHC/BRh/OmygG0Kmj/1dwDF7LaZ/MUsMA+KAQrbGLJzusU3GV1smfi89rTuGpx
         VxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786973862; x=1787578662;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BB4bAflOhpYzRfZSR0NX17xoh05DYymUXAZR8QHYHVg=;
        b=ZnpCHfUbexHomDHzrL/uDVXh69QgAEGnxNn0G63AgJbw0BKDOagTh3gSqMpLv7WYFX
         K77gY9+pfU/R3NQwQLim+0l7iaq+FxqISzce7HrQOEVPYbzkMxSPaFE8e7wT4s+rGAfu
         0i4Zqw2Ty28Ryl28cPnGad+YxltxcfvNk1gEIx0J2rjTfh1D7IWHMl/nJSYnx20Y2HpG
         5ylk3aXsG+EEgVkhHBR+pgDNwOnZ9mgZG+NcBK3n+FWfXXjFvrf4iWhDPrhqSAwLheWT
         d9Z5nn4znBrEf9i8TdjZlc6cUJ5Bo6T8dXex+h0sJ5I6WfV0pVccpulZtsU/a7F8ZfbH
         xhrg==
X-Forwarded-Encrypted: i=1; AHgh+RrhtHVhxfUG6wAjohgT+/8vZ8vgn/qyPgcqZGbQaBZSPhEQ+Gq5yAZPqmKB3qx25JJp0EA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+V81SAeK0PDZu6fbYhOIAMM7hrtAn9me8abCB910CrRnzwi9h
	ZW+mY3pV2MLEPn78BvBDNaB7uw1Z1b8JQxrHT+xr6jS40JoYXmTe2hntw9uIs/C2v19aM3H9f6Z
	F0MrK/w==
X-Received: from pfam7.prod.google.com ([2002:aa7:8a07:0:b0:847:926b:dc15])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d11:b0:847:9d6c:a56d
 with SMTP id d2e1a72fcca58-84fdc77a25emr17322479b3a.12.1786973861885; Mon, 17
 Aug 2026 06:37:41 -0700 (PDT)
Date: Mon, 17 Aug 2026 06:37:39 -0700
In-Reply-To: <aoK4szIBYjaJ6RS7@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806214050.78058-1-seanjc@google.com> <20260806214050.78058-3-seanjc@google.com>
 <anrI0WZ3rA0q6X+Z@yzhao56-desk.sh.intel.com> <antW3aKeEabMCsyV@google.com> <aoK4szIBYjaJ6RS7@yzhao56-desk.sh.intel.com>
Message-ID: <aoMOo--zGYqmgwtT@google.com>
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Harden "map private PFN" against
 unexpected root invalidation
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 17, 2026, Yan Zhao wrote:
> On Tue, Aug 11, 2026 at 10:07:41AM -0700, Sean Christopherson wrote:
> > On Tue, Aug 11, 2026, Yan Zhao wrote:
> > > On Thu, Aug 06, 2026 at 02:40:48PM -0700, Sean Christopherson wrote:
> > > > Move kvm_tdp_mmu_map_private_pfn()'s reload of the MMU into its tight loop
> > > > so that an unexpected root invalidation has a better chance of being
> > > > handled gracefully, even though it should be impossible for the vCPU's root
> > > > to be invalidated after the initial reload.  As is, encountering an invalid
> > > > root is *guaranteed* to put the task into an infinite loop (albeit a
> > > > breakable loop that honors NEED_RESCHED).
> > > Note: without the newly added is_page_fault_stale() check in patch 4, an invalid
> > > root would not put the task into an infinite loop :) 
> > > 
> > > BTW: As noted in [1], is_page_fault_stale() only checks !mirror roots, and
> > > kvm_mmu_reload() reloads mirror roots only when !mirror roots are also invalid,
> > > since an invalid mirror root was considered impossible. (up to now, no?)
> > > 
> > > [1] https://lore.kernel.org/all/anrD8nI8RfYoNvbf@yzhao56-desk.sh.intel.com
> > 
> > > > Add a WARN to try and detect bugs that break KVM's expectations, along with
> > > > a comment to explain why it should be impossible for the root to be
> > > > invalidated.
> > > And there's already a warning in kvm_tdp_mmu_map():
> > > "KVM_MMU_WARN_ON(!root || root->role.invalid);".
> > > So the warning also seems redundant.
> > 
> > No, KVM_REQ_MMU_FREE_OBSOLETE_ROOTS can be pending even if the current root is
> > valid.  And once the is_page_fault_stale() check comes along, the WARN in
> > kvm_tdp_mmu_map() is effectively unreachable.  The patch ordering is weird, but
> > there wasn't a great solution because adding is_page_fault_stale() first would
> > create an obvious infinite loop.
> Ok. When KVM_REQ_MMU_FREE_OBSOLETE_ROOTS is pending, it is only for direct roots.

No?  KVM_REQ_MMU_FREE_OBSOLETE_ROOTS is also used by the shadow MMU, in
__kvm_mmu_prepare_zap_page() and in FNAME(fetch).  Or did I misunderstand the
question?

> This patch still holds that assumption true, right?
> 
> If so, since mirror roots cannot be invalid after the first reload, any
> subsequent kvm_mmu_reload() calls triggered later in the loop would only reload
> direct roots.
> 
> Is this necessary for kvm_tdp_mmu_map_private_pfn(), which only maps private pfn?
> Or is the purpose of this patch simply to avoid the potential infinite loop
> after patch 4?

Yes, though I would still want this change even without patch 4, as there are no
guarantees that KVM won't gain an equivalent check in kvm_tdp_mmu_map() in the
future, e.g. as hardening.
