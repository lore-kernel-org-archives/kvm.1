Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0605239E7E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073499; cv=none; b=TcuT0UaB3T6ye2c3FiCeNECGkystD8lzabVXH2rrcyJZbG9akw4PmQmRLEdOtdAWL2wB/mt53cJmc+Vw2T8gj2oh6vIJMuiNySzjF/7T/71f+BgvJB/RtpF8i5GMbWqVEs4StNWgq0ZgIqOpQZnktNNyQ3IeC78A+FPpzlUsreA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073499; c=relaxed/simple;
	bh=7d+dI7BCOXsb/xg7q8MDnqPJ4olf9QKcYi3J2vHMi8c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uvOHGSNJaWG0gC+yy23spmMavUJYtwSVIO1EdyNl/TJ2WzFNWfstuVvMbidOwK1EIVpB6KK9APo80Aj6tNAiZxJnUewyTCobxAqWJ9AlclPXDKVXUpIMH0ykEO53keK+W1jAx+GunRFCWB+EDZdNyNxVtpT+FxWb4FzXbiqiy/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YiggXDey; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YiggXDey"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf004bf8beso29515645ad.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073491; x=1780678291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eAHT4lc4Hf6k7nHbKC1TYzljr82cl9daWTb4LEaL2yg=;
        b=YiggXDeyXY5BHA2Z/7C26SwVwrcjkaWzkdH9aEJb8GinilHWEbnd7hLRb1crs35OS4
         sO2F6DKjPA31bLR1n3rJQ70wAlqSvn5yRMgqB07v/gG9XdF51Khw6dll0ZQV1Q5vIJhC
         vto+IgiU5ft9hGIyNdAUzohp2aPumYB74jiXgVsFL3YVLa2WbJHYbMzPQYKHdEjbKuuO
         ypDwU+WBq+r4Ob8BBuEDN9OPlSbKmq3wHm8tNQt1Hu8wmT09Sy18bOVz/JhzBCDBHtO2
         W+JTF2Bs9BNnakh1HlUOXIt5WS/1FLRGHTi85zct2U8rfWpvCc633XkX4lo2+kW8PdaJ
         lq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073491; x=1780678291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAHT4lc4Hf6k7nHbKC1TYzljr82cl9daWTb4LEaL2yg=;
        b=KTsK3PkLlHqaj0fZfllOnqalqKZOrXj/5poF0oA2yq/2lLU6H1AZNW/jSKCLPfxjrz
         2CJxwYEImIxIiAlAb9cToWa/XbVPBmx2RG6NMfkGkOMFBD1x3ibcn9y1WlP1MMOIXaxB
         mCisLIeYbG371g2klFhcGaz6SDrWsXEeC6AOauXZUeYbasKBS0Gnmkwujd3Pq6uXMA9J
         /nNRLPVWk/B/cBlP4Zhsn5W7MYBVBEJqjfxL2lY5HEVgIid5RqiNLpmTlLhi3PqlwyiJ
         U3QWev0qq3oL64DjFWuQPCy+h/qD3w9NrRHoHNjEykb2MGxvobT72ihvZM1NsDhikR5d
         PD0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8yPsddl2v1y9mUNNACMp25Af/grAU0Ow46A7RHnkmYmH0aiaCYnRaSikdJnI5REmya2Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg3fhaULdZnmDGWlOfA85ZLDfa7WIUJN76DbzLSPOebgsrIkxC
	OoQ4nlWCurr4kVzaI6TmcUelC18LJeMBQy+yhnWEZ2aPwKgpM7t/Zg/cVVi+nrp2sgweLL+hEPq
	jiIlPeg==
X-Received: from plblo7.prod.google.com ([2002:a17:903:4347:b0:2bf:8db:4516])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d58d:b0:2bf:21e6:baee
 with SMTP id d9443c01a7336-2bf36826736mr7842105ad.28.1780073488289; Fri, 29
 May 2026 09:51:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:50:59 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-6-seanjc@google.com>
Subject: [PATCH v2 05/20] KVM: Remove unnecessary IRQ disabling from GPC lock
 in pfncache.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>
Cc: Waiman Long <longman@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw@amazon.co.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	Carsten Stollmaier <stollmc@amazon.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

Now that all hardirq/atomic GPC users (xen_timer_callback,
kvm_xen_set_evtchn_fast) use read_trylock() instead of read_lock(), no
hardirq path ever holds the GPC rwlock. There is therefore no risk of
deadlock between the write side and a hardirq reader, and no need to
disable interrupts when taking the lock.

Convert all read_lock_irq()/write_lock_irq() and their unlock
counterparts to plain read_lock()/write_lock() in pfncache.c.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/pfncache.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 728d2c1b488a..70b102095173 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -29,12 +29,12 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 
 	spin_lock(&kvm->gpc_lock);
 	list_for_each_entry(gpc, &kvm->gpc_list, list) {
-		read_lock_irq(&gpc->lock);
+		read_lock(&gpc->lock);
 
 		/* Only a single page so no need to care about length */
 		if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
 		    gpc->uhva >= start && gpc->uhva < end) {
-			read_unlock_irq(&gpc->lock);
+			read_unlock(&gpc->lock);
 
 			/*
 			 * There is a small window here where the cache could
@@ -44,15 +44,15 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 			 * acquired.
 			 */
 
-			write_lock_irq(&gpc->lock);
+			write_lock(&gpc->lock);
 			if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
 			    gpc->uhva >= start && gpc->uhva < end)
 				gpc->valid = false;
-			write_unlock_irq(&gpc->lock);
+			write_unlock(&gpc->lock);
 			continue;
 		}
 
-		read_unlock_irq(&gpc->lock);
+		read_unlock(&gpc->lock);
 	}
 	spin_unlock(&kvm->gpc_lock);
 }
@@ -184,7 +184,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 		mmu_seq = gpc->kvm->mmu_invalidate_seq;
 		smp_rmb();
 
-		write_unlock_irq(&gpc->lock);
+		write_unlock(&gpc->lock);
 
 		/*
 		 * If the previous iteration "failed" due to an mmu_notifier
@@ -225,7 +225,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 			goto out_error;
 		}
 
-		write_lock_irq(&gpc->lock);
+		write_lock(&gpc->lock);
 
 		/*
 		 * Other tasks must wait for _this_ refresh to complete before
@@ -248,7 +248,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 	return 0;
 
 out_error:
-	write_lock_irq(&gpc->lock);
+	write_lock(&gpc->lock);
 
 	return -EFAULT;
 }
@@ -269,7 +269,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 
 	lockdep_assert_held(&gpc->refresh_lock);
 
-	write_lock_irq(&gpc->lock);
+	write_lock(&gpc->lock);
 
 	if (!gpc->active) {
 		ret = -EINVAL;
@@ -355,7 +355,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 	unmap_old = (old_pfn != gpc->pfn);
 
 out_unlock:
-	write_unlock_irq(&gpc->lock);
+	write_unlock(&gpc->lock);
 
 	if (unmap_old)
 		gpc_unmap(old_pfn, old_khva);
@@ -417,9 +417,9 @@ static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned
 		 * refresh must not establish a mapping until the cache is
 		 * reachable by mmu_notifier events.
 		 */
-		write_lock_irq(&gpc->lock);
+		write_lock(&gpc->lock);
 		gpc->active = true;
-		write_unlock_irq(&gpc->lock);
+		write_unlock(&gpc->lock);
 	}
 	return __kvm_gpc_refresh(gpc, gpa, uhva);
 }
@@ -458,7 +458,7 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
 		 * must stall mmu_notifier events until all users go away, i.e.
 		 * until gpc->lock is dropped and refresh is guaranteed to fail.
 		 */
-		write_lock_irq(&gpc->lock);
+		write_lock(&gpc->lock);
 		gpc->active = false;
 		gpc->valid = false;
 
@@ -473,7 +473,7 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
 
 		old_pfn = gpc->pfn;
 		gpc->pfn = KVM_PFN_ERR_FAULT;
-		write_unlock_irq(&gpc->lock);
+		write_unlock(&gpc->lock);
 
 		spin_lock(&kvm->gpc_lock);
 		list_del(&gpc->list);
-- 
2.54.0.823.g6e5bcc1fc9-goog

