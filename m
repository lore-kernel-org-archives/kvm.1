Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C2D37DEB6;
	Fri,  8 May 2026 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264251; cv=none; b=RXGkSZSoz/9SgEKFdCEOi5vzNQzS5BIgRyTLL7F6vTEMpDepxujRjBM3UIrhBK1Vo85940rneEHnIsdBiS2+uoObrBEJ+FvI1k3fe3vBinED+PUImox9ovc4IEfu5S7DkveN6XLndZFJ/GkuS5sRffRX82bVZEWKHubEAg+ko30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264251; c=relaxed/simple;
	bh=0inD9J5ZMx3ydStx8bgf42Nm3OYAdUYPQfpl1+huSLs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpGk2S1ObldFai73K/I4eOZ2sJyg8sTvXPRNjafU1Ynao0NKRPwYuPf738HtCzfFSUL0iMrKi1QEgMX3x1+49L8gjQ3jUDyKhLStFQTh2CD7ABuj/wSF7alZ1p67i61TqWHeySZ32p05N6doMxSrbFhCARYgD+f8NGYyHZcUhyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J+0DmznO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J+0DmznO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=REZRf0+NDKaOilloT3mYryb1YEizmDl3e++BEDzpvTs=; b=J+0DmznONpTTOv6NJoAvLRI8yd
	SgId31jjSWhdoaJsPZAnyk+kaLE3xS/nwPAnRfyY73IOSe4s30XgrvWy/Sxx8CU0AlwcTJnavM590
	JoJSa1loMa4PzcAjGUKJRulq4gSM9ZCxOkCV41sjrS8OG76XBccBNhWgCUuuWk2oDV/vA+xGDB3nW
	8cA2iUw0O/CaGFRZ0dO4SYl5aDfhmMkkdpNRx1kLOVzbXjPby9aSyh95bEElPWhahTIGEBR1ysB6x
	WfpVrKHirWfchofiSl4u9CEtOax32DaaTL1FDbeLUxD8gXPb9foKQeEJnK2o8SIApKXQ8fevseTrX
	2y9WNsKA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLPlI-000000072tq-0SK9;
	Fri, 08 May 2026 18:17:20 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLPlH-0000000DYYx-1OTh;
	Fri, 08 May 2026 19:17:19 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paul Durrant <paul@xen.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Mauricio Faria de Oliveira <mfo@igalia.com>,
	kernel-dev@igalia.com,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Subject: [PATCH 6/7] KVM: Remove unnecessary IRQ disabling from GPC lock in pfncache.c
Date: Fri,  8 May 2026 19:10:08 +0100
Message-ID: <20260508181717.3230988-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260508181717.3230988-1-dwmw2@infradead.org>
References: <20260508181717.3230988-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Now that all hardirq/atomic GPC users (xen_timer_callback,
kvm_xen_set_evtchn_fast) use read_trylock() instead of read_lock(), no
hardirq path ever holds the GPC rwlock. There is therefore no risk of
deadlock between the write side and a hardirq reader, and no need to
disable interrupts when taking the lock.

Convert all read_lock_irq()/write_lock_irq() and their unlock
counterparts to plain read_lock()/write_lock() in pfncache.c.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
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
2.51.0

