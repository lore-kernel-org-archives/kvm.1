Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0B13F6C22
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073497; cv=none; b=jH4s5AYDxAwVsBK/4RSsDhziHMNUWeJhd47689rmYLTFBZ0WPktDsI2yEtjXRuHiGsrjhhC9M1Y5Jfd6O8Z6bHT4RUc6GP+k9D4v1U04JOh63N14Je3JOGsDalPkjJLbzzuXx0KqYIbwfiT/hXsLC0k8MUEtMTCI/KYVrVDNtbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073497; c=relaxed/simple;
	bh=GoET2JKvJg3a0x9eCSCU+59BfoX2Vx7yF+LJx8bxDqM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VwkkesFBlzS4GAJBNM7WlU7N/L0nLqwCBQXm/RkeinfR9cgsedBUVEIc5C92Mxoi8GI52abFv8/IsGZKcTAsEXZt/LlbeL9wYVju+lZBZoIFAzuWkyfBFoOO5rKiPawpNaED33lWRdzjLIYw4gQxTFInrU7eSkhrES+aID5ysGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UDZvnhQ6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDZvnhQ6"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2babbeff9e4so157634155ad.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073491; x=1780678291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=i2QifqEk3Wa+x9NPrIkPMLqkVE5h8yODSs0wPMQc5rE=;
        b=UDZvnhQ6llmTpTa1CF4WrChHFnnJlK/WNVguJPoFr7b7Y1duOtI5JOxar9GkMgMEVo
         1cImU24BB45yJjX+YsgJ24gHGS87MlpYcJtI/7Njxsf3DoNQD9QUm9amIL+lQ6CPiRCp
         SoOfZ5+SpZ9tf4m+BzucY5APA2LrV4OYFaCaC9IUueRWvo+R8upd12YfGMUbNWaZYqOP
         RQZPWIRGbRpFEeqxWLd6EjjpUGz0wlJ46t/nGmibJ/Npa9T0nEm3oyVgUUYpIENNjZBB
         QFSJQ5Fm7Coo/2W/OJXPFtz3ubvW8AAzveEe028xtYz2VGb5A0e5gNXiDrU0+zeC2xpn
         8P6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073491; x=1780678291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2QifqEk3Wa+x9NPrIkPMLqkVE5h8yODSs0wPMQc5rE=;
        b=fdBz4QkVDwJYIIRCB2xCu17wPhmicJ4X4rc9tlo8w3l7N+n2K/SNwrcs48siWYMKUe
         1lXgKDUNb1TBQKolID8meZVl39PCo4dZH3dQjrhBotZD7awqYaPAbYg9ZNOUdBazqT5X
         hjP6Ssq+Wnzb5Rr+AOWyLKAJAJfSbZqAPWRrqWsO4qU9nGRCRVTJ9wr+VwsLSqdz6znP
         QS5CEV92Hxto17o7zD+vaYO6ELU9N7A+J9VVF5nD3V8g8+bokpMq3mdVhSaYRYg8Xgyv
         HeQjh5k+sI8q1Ri3XauNvk6U3q4jSPdVzufiAveVYMmn69k80NaRL2nTIutfYeJ8IF7o
         dfZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/UefIj6P2/f6FLRM0jN9QDLLzz8T0B1+aVwBpiCtskPZX5jIFXdXpeyHbVDfc/Edg/ZKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdPIZgxoSdPTM1OnZPcS2IlndMeObRAWDjY4FGf8vFidvcrr/g
	1YmplrBQkvv/sNR7l26pittOC+Xygu8En9T3pBRmHxyb2okKYwIyqX0javLDTm0r1esoYAwLsp1
	mnjeTJw==
X-Received: from play17.prod.google.com ([2002:a17:902:e191:b0:2bd:16cc:1966])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:94e:b0:2bd:73f4:8e4f
 with SMTP id d9443c01a7336-2bf372bcb77mr2964585ad.0.1780073490710; Fri, 29
 May 2026 09:51:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:51:01 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-8-seanjc@google.com>
Subject: [PATCH v2 07/20] KVM: x86/xen: Extract delivery of event to vCPU into
 a separate helper
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

Hoist the actual fastpath delivery of an event to a vCPU into a separate
helper so that CLASS()-based gpc locking+checking can be used without
needing to implement scoped versions.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 100 ++++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 46 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 0c6b74b97408..020ef0ddab01 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1775,6 +1775,57 @@ static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
 	}
 }
 
+static void __kvm_xen_set_evtchn_fast(struct kvm_vcpu *vcpu, int port_word_bit)
+{
+	struct gfn_to_pfn_cache *gpc = &vcpu->arch.xen.vcpu_info_cache;
+	bool kick_vcpu = false;
+
+	/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
+	if (!read_trylock(&gpc->lock)) {
+		/*
+		 * Could not access the vcpu_info. Set the bit in-kernel and
+		 * prod the vCPU to deliver it for itself.
+		 */
+		if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
+			kick_vcpu = true;
+		goto out_kick;
+	}
+	if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
+		if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
+			kick_vcpu = true;
+		goto out_unlock;
+	}
+
+	if (IS_ENABLED(CONFIG_64BIT) && vcpu->kvm->arch.xen.long_mode) {
+		struct vcpu_info *vcpu_info = gpc->khva;
+		if (!test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel)) {
+			WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
+			kick_vcpu = true;
+		}
+	} else {
+		struct compat_vcpu_info *vcpu_info = gpc->khva;
+		if (!test_and_set_bit(port_word_bit,
+					(unsigned long *)&vcpu_info->evtchn_pending_sel)) {
+			WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
+			kick_vcpu = true;
+		}
+	}
+
+	/* For the per-vCPU lapic vector, deliver it as MSI. */
+	if (kick_vcpu && vcpu->arch.xen.upcall_vector) {
+		kvm_xen_inject_vcpu_vector(vcpu);
+		kick_vcpu = false;
+	}
+
+out_unlock:
+	read_unlock(&gpc->lock);
+out_kick:
+	if (kick_vcpu) {
+		kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
+		kvm_vcpu_kick(vcpu);
+	}
+}
+
 /*
  * The return value from this function is propagated to kvm_set_irq() API,
  * so it returns:
@@ -1791,7 +1842,6 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 	unsigned long *pending_bits, *mask_bits;
 	int port_word_bit;
-	bool kick_vcpu = false;
 	int vcpu_idx, rc;
 
 	vcpu_idx = READ_ONCE(xe->vcpu_idx);
@@ -1843,55 +1893,13 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		kvm_xen_check_poller(vcpu, xe->port);
 	} else {
 		rc = 1; /* Delivered to the bitmap in shared_info. */
-		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
-		read_unlock(&gpc->lock);
-		gpc = &vcpu->arch.xen.vcpu_info_cache;
-
-		if (!read_trylock(&gpc->lock)) {
-			/*
-			 * Could not access the vcpu_info. Set the bit in-kernel
-			 * and prod the vCPU to deliver it for itself.
-			 */
-			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
-				kick_vcpu = true;
-			goto out_kick;
-		}
-		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
-			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
-				kick_vcpu = true;
-			goto out_unlock;
-		}
-
-		if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
-			struct vcpu_info *vcpu_info = gpc->khva;
-			if (!test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel)) {
-				WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
-				kick_vcpu = true;
-			}
-		} else {
-			struct compat_vcpu_info *vcpu_info = gpc->khva;
-			if (!test_and_set_bit(port_word_bit,
-					      (unsigned long *)&vcpu_info->evtchn_pending_sel)) {
-				WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
-				kick_vcpu = true;
-			}
-		}
-
-		/* For the per-vCPU lapic vector, deliver it as MSI. */
-		if (kick_vcpu && vcpu->arch.xen.upcall_vector) {
-			kvm_xen_inject_vcpu_vector(vcpu);
-			kick_vcpu = false;
-		}
 	}
 
- out_unlock:
+out_unlock:
 	read_unlock(&gpc->lock);
- out_kick:
-	if (kick_vcpu) {
-		kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
-		kvm_vcpu_kick(vcpu);
-	}
 
+	if (rc == 1)
+		__kvm_xen_set_evtchn_fast(vcpu, port_word_bit);
 	return rc;
 }
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

