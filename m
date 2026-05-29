Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8233DA7D7
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073502; cv=none; b=WvtgamJfgXccq7ld9ts53rRuO7aOr5HCHHKoUDNHbut2+K80DNSx9FyknnMF/HgugBJyHamSfW7AUnRdO74hL7LRO3lnlyhPfVUZPQ7yC0oFyyxSFIpCmfD8fSD+TtgKyVu4Glnbppub9WWXxJD1j2wNcZemCy8IvcKwmKRSTdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073502; c=relaxed/simple;
	bh=SeVlNuknHErmqDKUXqZSVrCJUPPszJUqPGMo15fPV5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AE/uvLeqMcj6zAg7eWcMDlWS42I4R9YpHHb7qskRV1JxRjNiGf/DQlw4q9rO81E/Dx8B2m6HO42rYOyfudBIbOaJgQlu7haRC4HfbfLUTF++WVY9oR4x5asBlVjmJushYbPrNzWPeQemTo7v0oO8lkHyKmPpIDZsRjlP11rotJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qcfWfII0; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcfWfII0"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-365fc4636bbso27335919a91.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073496; x=1780678296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HgTdIrRk7scNPvBPwk7WshkWagXictFKa90Nqw8RxOc=;
        b=qcfWfII0Qnhb5CcJH8mgiRabHsQcWKOR2S18uiPbLchOA8t3F/Le0rXKJK5DWJ4Hf5
         RFjK/YZj5KOQTZz8mF7O6gqfnNN7JvtUZ/7rxE2KpuOgOWqx9WkN9/fhaTFXJSXki7Lu
         saDKOgIwlrJ/QANWc5v9xGsbbCBcDeH4/GH9EkLdwQ9/R35PO7LeXV1/2rFyVeR+b1Ef
         lMm/vhzedJf9CvknBZhIFSgc6fxrkR/hF1x1czZg9Fjrh8DL20zZQVQrq/JPmBawPhmc
         rSqNUueQRi0qIBN3hcCvHvKyLqZnhTpCyYeMuJEnn+PuBsJrM8XMoQV9srbcJ2uxVALR
         4bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073496; x=1780678296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgTdIrRk7scNPvBPwk7WshkWagXictFKa90Nqw8RxOc=;
        b=HBQ9Uk1yAykDmn8KDTEydphn+t0POgAlhUMsfnctgDXxnCQnHMnqh2mEX/0fp+GUDk
         EwnANBHu+uEVvAvj/TzXyFVyX30qpoQBGv7T2YRFIQDFUglbscX4KARxfbSqN6JOZm/p
         s10hxeQiPvXeNKKlOfLIjUi5ix3x873zrSI80LHW4onkJhOCsmc+g0ErRGwFj9QnLcTv
         t72Dv/suj2WCapIjMCVsaJz+30B8nnfeLVVCEojK3WCljBKO8ME/fAKqljmKxB1H0/pj
         L3rEHJCSECnCVc2yXovP/mmYd+1wp5L0M63IZ33oybjsTWXF2Kwef+6e5425V/MHLsCL
         VWZA==
X-Forwarded-Encrypted: i=1; AFNElJ+guZTwE4IfAMccYb51WNB+O3qvPJmc0eZOUvOb4vv22iCww/uULwZnH+0zToSL+wTLKA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9d2vhmypVOmA+LwsN2HzVQWHl9ynQOzSxITvIhCyijv8WHpOk
	xNo8QhCUaocqJm6aQzb6YfqqAdMeO/z8qy7QGqdYUNXLv6KTvr2qddRYe3WfdDOsWtRq9YECwSY
	+UB2QZA==
X-Received: from pgaf27.prod.google.com ([2002:a63:381b:0:b0:c79:65ab:b3b4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d8b:b0:3aa:c9d8:d795
 with SMTP id adf61e73a8af0-3b427c15601mr88135637.10.1780073496201; Fri, 29
 May 2026 09:51:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:51:06 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-13-seanjc@google.com>
Subject: [PATCH v2 12/20] KVM: x86/xen: Convert kvm_xen_shared_info_init() to
 gpc's CLASS() APIs
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

Use the newfangled "map local" CLASS() APIs to access the Xen shared info
page via its gpc.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 7b527a983cfc..065b4c92f7ed 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -35,27 +35,19 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r);
 
 DEFINE_STATIC_KEY_DEFERRED_FALSE(kvm_xen_enabled, HZ);
 
-static int kvm_xen_shared_info_init(struct kvm *kvm)
+static int __kvm_xen_shared_info_init(struct kvm *kvm)
 {
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	struct pvclock_wall_clock *wc;
 	u32 *wc_sec_hi;
 	u32 wc_version;
 	u64 wall_nsec;
-	int ret;
 
 	guard(srcu)(&kvm->srcu);
 
-	read_lock(&gpc->lock);
-	while (!kvm_gpc_check(gpc, PAGE_SIZE)) {
-		read_unlock(&gpc->lock);
-
-		ret = kvm_gpc_refresh(gpc, PAGE_SIZE);
-		if (ret)
-			return ret;
-
-		read_lock(&gpc->lock);
-	}
+	CLASS(gpc_map_local, shinfo_map)(gpc, PAGE_SIZE);
+	if (IS_ERR(shinfo_map))
+		return PTR_ERR(shinfo_map);
 
 	/*
 	 * This code mirrors kvm_write_wall_clock() except that it writes
@@ -74,14 +66,14 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	BUILD_BUG_ON(offsetof(struct shared_info, wc_sec_hi) != 0xc0c);
 
 	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
-		struct shared_info *shinfo = gpc->khva;
+		struct shared_info *shinfo = *shinfo_map;
 
 		wc_sec_hi = &shinfo->wc_sec_hi;
 		wc = &shinfo->wc;
 	} else
 #endif
 	{
-		struct compat_shared_info *shinfo = gpc->khva;
+		struct compat_shared_info *shinfo = *shinfo_map;
 
 		wc_sec_hi = &shinfo->arch.wc_sec_hi;
 		wc = &shinfo->wc;
@@ -97,12 +89,20 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	smp_wmb();
 
 	wc->version = wc_version + 1;
-	read_unlock(&gpc->lock);
-
-	kvm_make_all_cpus_request(kvm, KVM_REQ_MASTERCLOCK_UPDATE);
 	return 0;
 }
 
+static int kvm_xen_shared_info_init(struct kvm *kvm)
+{
+	int r;
+
+	r = __kvm_xen_shared_info_init(kvm);
+	if (!r)
+		kvm_make_all_cpus_request(kvm, KVM_REQ_MASTERCLOCK_UPDATE);
+
+	return r;
+}
+
 void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
 {
 	if (atomic_read(&vcpu->arch.xen.timer_pending) > 0) {
-- 
2.54.0.823.g6e5bcc1fc9-goog

