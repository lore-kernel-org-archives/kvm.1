Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737D72D5923
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183782; cv=none; b=XljfVWEmXj8BVaW3dsEtzzRpROm4eY8ntPZQxDW+lxWKTRhDv+8IUGsRLb43YbI9rM8xKG+74GGOpjubBM4pelcgiqECZ4tRnRN8u8Y2TzfYAk1flOCTPFk0uFzXgeg6IS2Jh6LK3x0BS7HBNp4fgWDVCeon2hRofvA59GEMODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183782; c=relaxed/simple;
	bh=+mtnjfAbkq9mykGV+znG/NBgx6xv4b0+pBRp2Ssr818=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VqBKOnoYh8AoCgXCoR1ul3EyoE8WqPZe++oKQU3xZF4pSedS9WrmsgCZnFim81IpDBMyC4C0bTCVsyO/G2MDy/RwbxtT6mShNxCJ+MiZ/84Nk3u5Mt8YUx+oNY03cvMin4LnKq9/tu4s9x93mElqlCZJbg/2msa9jw6WYnW4cTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EkAojRTy; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EkAojRTy"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39e25a5f6e8so1136110a91.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790183773; x=1790788573; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qd7c8sCPSTVG4sj8Jdv+Q7gffaqRcr+/MUM/BeQpcX4=;
        b=EkAojRTy287OUAC4Aw0xN7oIK8wSe8zAw4nBw4sfFoaHesEamNwTldNb2zemYFrRKl
         QNXcYHcY1ks80g0pY2vhNJj3BodtPSAj0Md9q3gHNEjTJiaPBdPCYaX4F3mANCdlEqrb
         Yk14dOJQAyCSRClVwtHh46BVSSYvjCbpY7S/2lUHxDwY2EhbsdVillrgzaFIrafLHsbZ
         O5m0yExX0+YHVe8rf58en0a3L/EcK+V0qZ2LszUSasnQYR4ZnAFbHxxawDpZin5tN6XW
         3fNvbzIyc9UHw71H10X1v6Yv7inmlhyDh8Hobk/RyyvHab6wZARsaxqiv9hAFu6zf5l6
         Oi1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790183773; x=1790788573;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qd7c8sCPSTVG4sj8Jdv+Q7gffaqRcr+/MUM/BeQpcX4=;
        b=uIDOjRXazyHOuyq8JaMss28PeHApClX77ci3PkE4kXA9QRMk+F6DUfJPEp18oehGZ2
         Km1iTxpXIsvSQQ1bmaD3BfQnaR7sp1jHpAcRZypqupJ2tOA0FFH3Kuj7AtOP5dz4JOvO
         lRYzqbXuERFkmmqzKfZQ5iztOi77kNriBWD1Dxjhm5Vqz5EOUzcxq20wgrA+ryGn+Xl7
         QhdN5DaE9a5TBkmi6NzroRk0iJsvAe58O3DmDL51/XdZgEWpsclFHkuXcWJv5OFLNJdl
         SorymhNXqb/Y9MjmnHL8XU9hMyktVQRkZ6F7OnPGB6qT72v9sv/0WyXGM5ZKCyrPUgaS
         ROsA==
X-Gm-Message-State: AFuF++mBYVq3UAmn4SQB4WJpV5SSz9Voi2fHm9r6bfxTT1GkJt0O7o8r
	L2bUkwm40G7MiVgLxI0D+ZDD38pm10Jpr3aOJRY8qo5U8w34ns2tqRPyb9Bwu6Is5E9A/gHpqB5
	VLzdFTA==
X-Received: from pjbor4.prod.google.com ([2002:a17:90b:39a4:b0:39e:1d3:781d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:588e:b0:39e:6a81:5a98
 with SMTP id 98e67ed59e1d1-3a07e71658dmr2816595a91.44.1790183772462; Wed, 23
 Sep 2026 10:16:12 -0700 (PDT)
Date: Wed, 23 Sep 2026 10:16:11 -0700
In-Reply-To: <20260923165304.1662E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923163721.1584779-1-seanjc@google.com> <20260923163721.1584779-3-seanjc@google.com>
 <20260923165304.1662E1F000FF@smtp.kernel.org>
Message-ID: <arQJW6bs7RRjLJFv@google.com>
Subject: Re: [PATCH 2/2] KVM: SEV: Do cache maintenance on the source VM
 during intra-host migration
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 23, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] kvm: sev: TOCTOU race in sev_migrate_from causes host memory corruption
> --
> 
> commit b97586a7411bd5d8a55967b35859f6e485f10868
> Author: Sean Christopherson <seanjc@google.com>
> 
> KVM: SEV: Do cache maintenance on the source VM during intra-host migration
> 
> This commit manually performs cache maintenance on the source VM during
> intra-host migration. Since the source VM is converted to a non-SEV VM,
> automatic memory reclaim flows will not trigger the required cache
> maintenance, potentially leaving stale data in the CPU caches.
> 
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index c9242c936a401..71923cb72d1d1 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -2048,6 +2048,12 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
> >  	src->pages_locked = 0;
> >  	src->es_active = false;
> >  
> > +	/*
> > +	 * Do cache maintenance on the source VM as it is no longer an SEV VM,
> > +	 * i.e. memory reclaim flows won't trigger cache maintenance on the VM.
> > +	 */
> > +	sev_writeback_caches(src_kvm);
> 
> [Severity: Critical]
> Is there a race condition here if memory is reclaimed concurrently?
> 
> If a userspace process or kernel reclaim triggers a memory unmap (for
> example, via MADV_DONTNEED) concurrently with the KVM ioctl, it could happen
> in the window between setting src->active to false and calling
> sev_writeback_caches():
> 
> CPU1 in sev_migrate_from():
>     src->active = false;
> 
> CPU2 running concurrent unmap:
>     Since active is false, the automatic cache flush in
>     sev_guest_memory_reclaimed is skipped.
>     The host frees and reallocates the page.
> 
> CPU1 in sev_migrate_from():
>     sev_writeback_caches(src_kvm);
>     Executes a hardware cache flush (wbnoinvd), which writes the guest's old
>     dirty ciphertext over the new page owner's data.
> 
> Because sev_migrate_from runs without mmap_lock or mmu_lock, MMU notifiers
> can run concurrently. Can this cause host memory corruption by overwriting
> newly allocated host pages with stale ciphertext?

Oof, yeah.  It's a tiny window, but also trivial to fix and document.
