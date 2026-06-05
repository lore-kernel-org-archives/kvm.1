Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8553B1ECD;
	Fri,  5 Jun 2026 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669849; cv=none; b=K8l2AviuDuGjfVGoOJzBN4g1CuH43ir62VYBs5fu45WFESq0elN6XatJ0imE0UnmVLW5F6q+UEle4ZB0g4FS2SE+0RcUwqYX438qmswGraXhgwHTmmraM+6ul6YJRy/Ld/ZXxJFLFu0QGs8lJ5rySLTku+ViEEfrhmc8sdRbTuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669849; c=relaxed/simple;
	bh=8T/5nsA/wlFXpvI3Www5yBG2dEEzVOH2TyRuWxqN+3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnBFgK+sTtRZd0JRqd/kR6AnQWGWbVAvbMesr+VgNgX9Upv/E+FVKMpbUElkMxKJUEGpLOWB6r19ZG/CQv3fgod5uukxibtKSKEZva8PdNqO03+1OOiuak/8zV2BNiBPnviH5t9OSNmHRFmtrKQgfDhvXIT1RL9Vg0n1vNUaCBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cKqqx7Lp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cKqqx7Lp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=S1+xA5OPImNvZdyaYwZzy4uNneY+HSte6Mte2bTUqTk=; b=cKqqx7Lp20LWJNAf4Cn5XN+pvI
	FuJ/qqJOGvotmewxho4Hivl3hMZWNurfBle+v6NUQRudQ+5XdFdcZ2/KBYZW0Wn4zvsj9yMI/mdSf
	c1xjloqFZ4l1ZPGgwsgd4ZR87ekVLUUDd4UFu3kDzx5DzuYnS+owVBqaERLwfTwnWWmZrcyGYVO92
	MRYKaDzsmA4hRlXsYJg4gpFK0X5imdbLlPNiPdcELqZvuBvlUZH2r7dWVxks2X4aJSrUJFJUbyZtE
	HA6pNdDKakMQQiFZGsX9wSkxPnTMfFcCU1bFGl9DznQh4m6+zh82frAC02dOiNPZ9Lb7ExjKka7N0
	yGmVc4ZA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVVZE-0000000848a-24kV;
	Fri, 05 Jun 2026 14:30:37 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVVZE-0000000013n-2Not;
	Fri, 05 Jun 2026 15:30:36 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paul Durrant <paul@xen.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] KVM: x86/xen: Use 32-bit locked ops in kvm_xen_inject_pending_events()
Date: Fri,  5 Jun 2026 15:17:33 +0100
Message-ID: <20260605143034.3603-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605143034.3603-1-dwmw2@infradead.org>
References: <20260605143034.3603-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The 64-bit path in kvm_xen_inject_pending_events() uses 'lock orq' and
'lock andq' on vcpu_info->evtchn_pending_sel. If the vcpu_info was
registered with only 4-byte alignment (valid for a 32-bit guest that
later switches to 64-bit mode), this 8-byte locked operation can cause
split-lock #AC exceptions on hosts with split_lock_detect=fatal.

Use the original 64-bit atomics when the vcpu_info is 8-byte aligned
(the common case). Fall back to a 32-bit loop for the rare case where
vcpu_info was registered at only 4-byte alignment. For compat guests
(32-bit evtchn_pending_sel) the loop executes once. For native guests
it executes a second iteration only if the high half has bits to
deliver.

Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
Reported-by: sashiko-bot@kernel.org
Assisted-by: Kiro:claude-opus-4.6-1m
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 63 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 24e939ef5d64..e7b0263d5143 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -638,11 +638,17 @@ void kvm_xen_inject_vcpu_vector(struct kvm_vcpu *v)
  */
 void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 {
-	unsigned long evtchn_pending_sel = READ_ONCE(v->arch.xen.evtchn_pending_sel);
 	struct gfn_to_pfn_cache *gpc = &v->arch.xen.vcpu_info_cache;
+	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(v->kvm);
+	union evtchn_pending_sel {
+		u64 sel64;
+		u32 sel32[2];
+	} pending, *sel_addr;
+	struct vcpu_info *vi;
 	unsigned long flags;
 
-	if (!evtchn_pending_sel)
+	pending.sel64 = READ_ONCE(v->arch.xen.evtchn_pending_sel);
+	if (!pending.sel64)
 		return;
 
 	/*
@@ -661,31 +667,50 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 	}
 
 	/* Now gpc->khva is a valid kernel address for the vcpu_info */
-	if (kvm_xen_has_64bit_shinfo(v->kvm)) {
-		struct vcpu_info *vi = gpc->khva;
+	vi = gpc->khva;
+	sel_addr = gpc->khva + (has_64bit_shinfo ?
+				offsetof(struct vcpu_info, evtchn_pending_sel) :
+				offsetof(struct compat_vcpu_info, evtchn_pending_sel));
 
+	if (has_64bit_shinfo && IS_ALIGNED((unsigned long)sel_addr, sizeof(u64))) {
+		/*
+		 * 64-bit shinfo with 8-byte aligned vcpu_info (the common
+		 * case): use a single 64-bit atomic.
+		 */
 		asm volatile(LOCK_PREFIX "orq %0, %1\n"
 			     "notq %0\n"
 			     LOCK_PREFIX "andq %0, %2\n"
-			     : "=r" (evtchn_pending_sel),
-			       "+m" (vi->evtchn_pending_sel),
+			     : "=r" (pending.sel64),
+			       "+m" (sel_addr->sel64),
 			       "+m" (v->arch.xen.evtchn_pending_sel)
-			     : "0" (evtchn_pending_sel));
-		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
+			     : "0" (pending.sel64));
 	} else {
-		u32 evtchn_pending_sel32 = evtchn_pending_sel;
-		struct compat_vcpu_info *vi = gpc->khva;
-
-		asm volatile(LOCK_PREFIX "orl %0, %1\n"
-			     "notl %0\n"
-			     LOCK_PREFIX "andl %0, %2\n"
-			     : "=r" (evtchn_pending_sel32),
-			       "+m" (vi->evtchn_pending_sel),
-			       "+m" (v->arch.xen.evtchn_pending_sel)
-			     : "0" (evtchn_pending_sel32));
-		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
+		/*
+		 * Use 32-bit operations to avoid splitlock on a vcpu_info
+		 * that is only 4-byte aligned (registered in 32-bit mode).
+		 * The loop copes with the extremely rare case that the
+		 * vcpu_info was registered in 32-bit mode and only enforced
+		 * 4-byte alignment, and then the VM was latched to 64-bit
+		 * mode afterwards. Which Xen tolerates, so so should KVM.
+		 */
+		int i = 0;
+		do {
+			asm volatile(LOCK_PREFIX "orl %0, %1\n"
+				     "notl %0\n"
+				     LOCK_PREFIX "andl %0, %2\n"
+				     : "=r" (pending.sel32[i]),
+				       "+m" (sel_addr->sel32[i]),
+				       "+m" (((u32 *)&v->arch.xen.evtchn_pending_sel)[i])
+				     : "0" (pending.sel32[i]));
+			i++;
+		} while (has_64bit_shinfo && i < 2 && pending.sel32[i]);
 	}
 
+	/* Assert that there is no need for compat for evtchn_upcall_pending */
+	BUILD_BUG_ON(offsetof(struct vcpu_info, evtchn_upcall_pending) !=
+		     offsetof(struct compat_vcpu_info, evtchn_upcall_pending));
+	WRITE_ONCE(vi->evtchn_upcall_pending, 1);
+
 	kvm_gpc_mark_dirty_in_slot(gpc);
 	read_unlock_irqrestore(&gpc->lock, flags);
 
-- 
2.54.0

