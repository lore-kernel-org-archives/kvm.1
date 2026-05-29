Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582813F9288
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073496; cv=none; b=oQN2SfoMr/fKHb5cmAUSfSTPYxoSRnXOlzT+OfHRMz8XsXILTZtaHFEf+1tnpLePnboWgT2Ix8gCLmDjMErGBGxa/WjhEyE3otNNs5qBP2+yVetbNf5cqLYwpNZ+jUQ1cB+hUanNdHjh7Rk6ndsNQhD//ycPSExJk9h8FUAOXMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073496; c=relaxed/simple;
	bh=O4qpHyxDqbUyRC7xhAqgdYzXBuoRUCZbiNwyQ4FQt3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MmEDc9Rr/HMkBa/qqHrXZN4wPlVjJ6YuYMRuzloIQfQlplUr0Tmc79DqMVUtKLhmhw1irN60pzsYoT/INDIH4ptr1fmHTpLNlkjHYV3YvPPjBbDybNCVwxzRcEuQvx47vs7HwGmLPuZk3HXKmWWZAgXKmkvxat4pCtKLnpaV2rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6aQtMgI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6aQtMgI"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4530a90fdso106709365ad.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073489; x=1780678289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=V3YJTc4/phuSx/AsQ9kARrMuegtvoBaks7Ls8Sj689w=;
        b=i6aQtMgI2K8hiq95NeVfSxAhcfAf4oMNvLU+zzGS5XpCe1U+MBy4l5U7K7/HhKP+et
         FANMnobcZdpSp1rGMPk55B1KxBrzDMMdn30i/m3XZA4LXf2KH0in5eMDlb+o2TxmsjCV
         QoQD7taaNYzIQYgG/RKJ6gYmCFI2voKLskQXcnhzDU57hEoKIMl5yMOya58k+sIjw5Pr
         IDlnE6wytr6cM7gNi8c/kksYFtbzCTk3nhWxcq0Rx5G316MpFNMQMt4mRA0/C+qqn5AL
         JezJs5qk5cH8ANkGILCphoUWKlPxnVPFR6XCYIOqnPiFTiGjJRIbnoHMu1WM+YfpmemW
         tj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073489; x=1780678289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3YJTc4/phuSx/AsQ9kARrMuegtvoBaks7Ls8Sj689w=;
        b=mi6Bcf9BID57Y6fdWpqMpfS3qZK/vfuVAxoqA6Uaqtnk4MY4S2DuXiw3DFJGLdIe5D
         XUn11uRepz17CHAbD3hkYyUHUXvEfcP/D64fV/MgjrfDKwTKkGML96EmPKAJoBpvfv30
         QoKp3sYbr7O3tbn8kXi0yxVL5rhnBDigEjaOiF1pp+ve7kFqB2bLBYtDrl3DQO0fgUFj
         NptGoBGwdzOfR7pFB2WjgbplvMjvfOfjNIiqBUb+FPk/bujqjUOKuDKkzjGbY/IzrmHn
         6tGahwNTFStGo6m+XVwv3hrFePhs3VLHyhhCmdSeszt8WSV5Prj69roCzgNExU9epSBP
         D4zw==
X-Forwarded-Encrypted: i=1; AFNElJ8rZ1VDvdEC0ztMousjeSEAUDdLKG0zWiKjx+EYO99MJiX0MQimDouDSZGcGAigtyddPFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdbJmCwOsGqAHeRUKbobSSDUBnKgGBPzcUpvSZJvdFy5IXobwh
	K/dOEVb9gaJzjtjFkd7HdR6E0duU7jfFghE3+pc75MsFBsdjTj69VIR4bk7qcSLralIigxSHOAt
	B4SpMEQ==
X-Received: from pln12.prod.google.com ([2002:a17:903:360c:b0:2bf:162a:acda])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f651:b0:2b2:4bf9:1766
 with SMTP id d9443c01a7336-2bf36889aa0mr7584825ad.33.1780073489348; Fri, 29
 May 2026 09:51:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:51:00 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-7-seanjc@google.com>
Subject: [PATCH v2 06/20] KVM: x86/xen: Use guard() to grab kvm->srcu around
 gpc critical sections
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

Use guard() to acquire and release kvm->srcu protection around gpc
critical sections, so that said critical sections can also use the fancy
__cleanup() functionality.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index b1fae42bf295..0c6b74b97408 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -42,8 +42,9 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	u32 *wc_sec_hi;
 	u32 wc_version;
 	u64 wall_nsec;
-	int ret = 0;
-	int idx = srcu_read_lock(&kvm->srcu);
+	int ret;
+
+	guard(srcu)(&kvm->srcu);
 
 	read_lock(&gpc->lock);
 	while (!kvm_gpc_check(gpc, PAGE_SIZE)) {
@@ -51,7 +52,7 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 
 		ret = kvm_gpc_refresh(gpc, PAGE_SIZE);
 		if (ret)
-			goto out;
+			return ret;
 
 		read_lock(&gpc->lock);
 	}
@@ -99,10 +100,7 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	read_unlock(&gpc->lock);
 
 	kvm_make_all_cpus_request(kvm, KVM_REQ_MASTERCLOCK_UPDATE);
-
-out:
-	srcu_read_unlock(&kvm->srcu, idx);
-	return ret;
+	return 0;
 }
 
 void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
@@ -1437,9 +1435,10 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	unsigned long *pending_bits;
 	bool ret = true;
-	int idx, i;
+	int i;
+
+	guard(srcu)(&kvm->srcu);
 
-	idx = srcu_read_lock(&kvm->srcu);
 	read_lock(&gpc->lock);
 	if (!kvm_gpc_check(gpc, PAGE_SIZE))
 		goto out_rcu;
@@ -1462,8 +1461,6 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 
  out_rcu:
 	read_unlock(&gpc->lock);
-	srcu_read_unlock(&kvm->srcu, idx);
-
 	return ret;
 }
 
@@ -1795,7 +1792,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	unsigned long *pending_bits, *mask_bits;
 	int port_word_bit;
 	bool kick_vcpu = false;
-	int vcpu_idx, idx, rc;
+	int vcpu_idx, rc;
 
 	vcpu_idx = READ_ONCE(xe->vcpu_idx);
 	if (vcpu_idx >= 0)
@@ -1812,10 +1809,11 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 
 	rc = -EWOULDBLOCK;
 
-	idx = srcu_read_lock(&kvm->srcu);
+	guard(srcu)(&kvm->srcu);
 
 	if (!read_trylock(&gpc->lock))
-		goto out_rcu;
+		return rc;
+
 	if (!kvm_gpc_check(gpc, PAGE_SIZE))
 		goto out_unlock;
 
@@ -1856,7 +1854,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 			 */
 			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
 				kick_vcpu = true;
-			goto out_rcu;
+			goto out_kick;
 		}
 		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
 			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
@@ -1888,9 +1886,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 
  out_unlock:
 	read_unlock(&gpc->lock);
- out_rcu:
-	srcu_read_unlock(&kvm->srcu, idx);
-
+ out_kick:
 	if (kick_vcpu) {
 		kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
 		kvm_vcpu_kick(vcpu);
-- 
2.54.0.823.g6e5bcc1fc9-goog

