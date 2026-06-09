Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44C26C385
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 00:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965949; cv=none; b=tkKli4P5lQlDUzIUqI5EgJrmkbpW2Qixx7HMJXAtkTNPb78CWGtP77u18g7siIJpSJBaUfvCv5IvevfgUXhmTIKEH1q7ruuRKHmhmO5TS5GO3wcNka47bQFTTbse82TCs5BRud79dV5sTH1AwRzHGJ+OgbQ4J7AfrTIS7ZnMvUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965949; c=relaxed/simple;
	bh=I/tGt7KzcBETNAgm8Dtn6Epq7mEFNModkgfXeYn3IKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=deDGFJ92XntwP9cEdT6cjz8U5f/i4vL3kPp5uZeFB8GG4n9gCNYJ5cBdBAfmTGRzikTTHbS5eDiTPFQAKh5Y3s63YYMJ2ATcIltuoJPyiv8LV7+msP+aF12HHdyJ2o6MP6mWQuwOBsPvp1xLsrZbbLzLxhaH6teK7X6KFjux7Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GEQ+lQDx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEQ+lQDx"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85a2f19558so2870584a12.2
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 17:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780965946; x=1781570746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WefpHHOSV8JYGHScIIv9soq8IINRPl3fy/zAA/txa0=;
        b=GEQ+lQDxnkBqxmbEAuySBBkpXDr8A9pOSa2Q6srV20FTmWKozDp7/mA+MnDsAV/jHq
         iIVxdDF4W7vggi+Xj3mxCoGAcssT5AcyzMWHg7naIXWR5vr+3ybd62r5kHv47HgkqvfF
         t60tqphiMGBm1QcZjFzTAwkD9HSwZ/eZgUsoUk8GOvenyFKG81ALH5j1TVKqiKAZEqpa
         VDeoGWSW72Yu2I4L8vQgHxY6Ka912Qib3UUlbtCZkO0d5vbGjPmJ7Y3Vx8Ktqe2Vd5sy
         uzG94SRPXSg7V8mIkB+JKq1GBYhweWvgo5F7zxQEw1vJIWnALRiWMUVJRkMBxQtTXQ2S
         g53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780965946; x=1781570746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WefpHHOSV8JYGHScIIv9soq8IINRPl3fy/zAA/txa0=;
        b=HcAG4+oLcdBWVLSPQy767XZLwax7dAvg5jbreKKXt6Hpk//iNPrSW/xsuXKHxMyLtU
         vSz7L5QVKGtcpfdFSy5xuUcGY3A9e4FgiAVAdqOGmhLfP8lxQ1DKUhp/CImBUqUDMjZ9
         lCl9yzPkIRHHUnNI4z++8Al3M5sVCQzeM7Igk34Kr84qUI1IoHTlzRSw9SY7w4TuXgTk
         3Nrl7PtgRvsxTcjVD9yxD6kMDcFZ4vo1X4UGnp/mQcQ//m6jtstxBd+KGlcGCv+ZnnHK
         eaxV4vkpkrmwGwtKg8dGz+5srvWCEsz3er1cRgFX+XLtGWA5jFLt8YEFz5fgeyi+Ad20
         cjXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8t8Ne5ozLUkgqwwMMaovm54uGQyVYICN2+05Vpr/e/tNlyOIxxq7WvgLu6OVDqusFl6sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzrVSb987GN9f7w6sS803/XYYlI5wS4lDSpgZjfDNj3QtruseN
	UTM6CGtMsCUl3k37IE1FPfearNF8B8ci41rzvW3GAxj7eCAEZh1DgdmSBWTFaEG+1sDOlbQT6Y7
	7Rbjo3w==
X-Received: from pgbl13.prod.google.com ([2002:a63:570d:0:b0:c82:295e:3b51])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:eec4:10b0:3b4:6265:3787
 with SMTP id adf61e73a8af0-3b4ccf49532mr11901169637.28.1780965946303; Mon, 08
 Jun 2026 17:45:46 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:45:45 -0700
In-Reply-To: <3291d47ea5fdd6ee2f284cadb518473130954cfc.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530061932.7849D1F00893@smtp.kernel.org> <3291d47ea5fdd6ee2f284cadb518473130954cfc.camel@infradead.org>
Message-ID: <aidiOemcna1Un9wG@google.com>
Subject: Re: [PATCH v2 20/20] KVM: x86: Use gfn_to_pfn_cache for record_steal_time
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: sashiko-bot@kernel.org, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sashiko-reviews@lists.linux.dev, stollmc@amazon.com, dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 02, 2026, David Woodhouse wrote:
> On Sat, 30 May 2026 06:19:32 +0000, sashiko-bot@kernel.org wrote:
> > [Severity: High]
> > Does this introduce a scheduling while atomic bug on non-PREEMPT_RT kernels?
> >
> > The CLASS(gpc_map_local, st_map) macro acquires a read_lock on gpc->lock,
> > which disables preemption. While this lock is held, if the guest supports
> > PV TLB flush, the code calls kvm_vcpu_flush_tlb_guest().
> >
> > If TDP is disabled (shadow paging), kvm_vcpu_flush_tlb_guest() calls
> > kvm_mmu_sync_roots() and eventually mmu_sync_children(). This path can yield
> > via cond_resched_rwlock_write(). Yielding while preemption is disabled by
> > the gpc read lock will trigger a BUG.
> 
> Ah, that issue exists in the previous versions too, but it's simple
> enough to fix. There's no particular timing constraint for flushing the
> TLB; it just have to be done before this vCPU ever runs again. It can
> just be moved to the end of the function after the lock is dropped.
> 
> That does mean record_steal_time() should use the explicit
> gpc_map_local_lock()/gpc_map_local_unlock() instead of the CLASS()
> macro, but that's easy enough.

Actually, we use KVM_REQ_TLB_FLUSH_GUEST and "optimize" the code for the rare
case where KVM already have a TLB flushed queued for the vCPU.  E.g. over two
patches (so that changing the order of the request processing is isolated):

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1b27dd9ba0aa..48234eeb246b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3764,7 +3764,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
                trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
                                       st_preempted & KVM_VCPU_FLUSH_TLB);
                if (st_preempted & KVM_VCPU_FLUSH_TLB)
-                       kvm_vcpu_flush_tlb_guest(vcpu);
+                       kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
        } else {
                WRITE_ONCE(st->preempted, 0);
                vcpu->arch.st.preempted = 0;
@@ -11165,6 +11165,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
                        if (unlikely(r))
                                goto out;
                }
+               if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
+                       record_steal_time(vcpu);
                if (kvm_check_request(KVM_REQ_MMU_SYNC, vcpu))
                        kvm_mmu_sync_roots(vcpu);
                if (kvm_check_request(KVM_REQ_LOAD_MMU_PGD, vcpu))
@@ -11214,8 +11216,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
                        r = 1;
                        goto out;
                }
-               if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
-                       record_steal_time(vcpu);
                if (kvm_check_request(KVM_REQ_PMU, vcpu))
                        kvm_pmu_handle_event(vcpu);
                if (kvm_check_request(KVM_REQ_PMI, vcpu))


KVM needs to ensure the RMW on st->preempted is atomic, to avoid re-introducing
the bug fixed by commit b043138246a4 ("x86/KVM: Make sure KVM_VCPU_FLUSH_TLB flag
is not missed"), but AFAICT there's nothing that requires to complete the TLB
flush before bumping the version, KVM just needs to service the flush before
entering the guest on that vCPU.
