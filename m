Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6269403E8C
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073508; cv=none; b=SfsvsaNVlbAGlZyBxSCI8Srnj3iuq+cg9tXjduPbjHXNhDri0jukrcK7DiQmzzq/YGpGSZ0VkFl6lw3JiwmPCSkfAItdxnCYm3jsmwwi9f+nadZIDLDU5ovYCtct6GR6db4fS4TN6oqd5rHYjz1kOPxAUCBfPxo1kcF2T8lzppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073508; c=relaxed/simple;
	bh=eRpqhsXGVulDHWpEG+Es7s7b63lWnDs9riy9U+fNOtA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jfDVnTe8ul3gxRTbs4CzUTMhwsmDLsCIgOFC7/Fe/j8sEdrk0JZDL6jRGmOe0gSqyU98VGHusYeaCgoQqGyyuQew1GBF2MaRb81C2FWWC4b4UYudUovH7IBVAWnZr4/pyIAJoc/eZyPsXnoAbN98Y5JRYHURRMlnSIoFtChDyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FlPeygS6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FlPeygS6"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bd4146cb2so609695a91.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073503; x=1780678303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YdeRkiZ514PCwhPFqIiDSwP2lVsh3k3Oe44aCTYNQts=;
        b=FlPeygS6YtJfpApB9Hs2GkFNN2KTW57S5AVqSiAEN9UIFllasFuWNj3aD/p7o/8khX
         iZfS/6SEVVxJHQtKvul4kThlKo4WB4Dz+5oxpSgeDeUbeTdTXFqCes/41u43FBQD8Znx
         bovP9y9vJbvZXQp+6LCVsOAXaITvlIwgQWDTjtgWXgz5a2GwWGYSgJLuzBoBsyO1nbxY
         bgriXPkclN8d7+MZ4MWTPZ0xYKQm70ivB0QnFdMG87ZZpQlxcmjZiFEHIrNa3iuUyDgq
         r2athTjDbPDqZBAC0gjd5JrmLDbfB/r0wsxL1MaAuy0xgSDD0Aqo8a49RA/1QivKFh7c
         hT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073503; x=1780678303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdeRkiZ514PCwhPFqIiDSwP2lVsh3k3Oe44aCTYNQts=;
        b=f5whGWxef1IdU/FRZV1uwKuvSeikli+ArnCwuT/8jPtP3krl6k4THC08ENt/2wVTJ5
         22H6aSmjFzVTYxbU4c3gNP66IYzOTQQGSKtEdU5yobn2khfEEUL57r1UC2exLjyypCzg
         27muwrJiHxGHcVGLF32l3pI8ZN8gFhcGbpBNoy1QGykD9/GG47+sEvTAKmeS1zgxBKDQ
         pIWhy4JCRkUPW6kalll8pV8wi3hgceCkMyOKx3pUi5aTvpxIjexgcno9OLJvJ5ss2eyR
         MUY9nAQLnwKD4+y84Od3LRwRuQRdsx6yZR2kAwk1DtwwTwofpShgheNFZKToJnFWKKxm
         AiaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fB/JToBvvbc0GeFtoPBWUvj8F4pd/yvesN5tuj3rWUTyPIyj2zQLfmezr3eTxT9oge3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxOc7qkpRM2XSeyHPXgsYqKmHE1ff1wOJ7JWm4a2Ajwm4WntvT
	emF9MBlymfrBAAiLINZHgHOMHxg4w+cYBqp0uNAKs420ryN5z2L3J6WUJo7BXxGS4teKSBm9umQ
	HhnbWiA==
X-Received: from pjbem5.prod.google.com ([2002:a17:90b:145:b0:36b:d802:9795])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1fc5:b0:369:3c3d:f899
 with SMTP id 98e67ed59e1d1-36beb2ad6ddmr232947a91.2.1780073502851; Fri, 29
 May 2026 09:51:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:51:11 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-18-seanjc@google.com>
Subject: [PATCH v2 17/20] KVM: x86/xen: Drop local "kick_vcpu" from __kvm_xen_set_evtchn_fast()
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

Now that the CLASS()-based gpc mappings allow for early returns, drop the
local "kick_vcpu" from the event channel fastpath, and simply return early
if the vCPU doesn't need to be kicked.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 89daad3fe712..2c776e475a4f 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1761,7 +1761,6 @@ static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
 static void __kvm_xen_set_evtchn_fast(struct kvm_vcpu *vcpu, int port_word_bit)
 {
 	struct gfn_to_pfn_cache *gpc = &vcpu->arch.xen.vcpu_info_cache;
-	bool kick_vcpu = false;
 
 	/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
 	CLASS(gpc_try_map_local, vcpu_info_map)(gpc, sizeof(struct vcpu_info));
@@ -1771,39 +1770,37 @@ static void __kvm_xen_set_evtchn_fast(struct kvm_vcpu *vcpu, int port_word_bit)
 	 * vCPU to deliver it for itself.
 	 */
 	if (IS_ERR(vcpu_info_map)) {
-		if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
-			kick_vcpu = true;
+		if (test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
+			return;
 		goto out_kick;
 	}
 
 	if (IS_ENABLED(CONFIG_64BIT) && vcpu->kvm->arch.xen.long_mode) {
 		struct vcpu_info *vcpu_info = *vcpu_info_map;
 
-		if (!test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel)) {
-			WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
-			kick_vcpu = true;
-		}
+		if (test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel))
+			return;
+
+		WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
 	} else {
 		struct compat_vcpu_info *vcpu_info = *vcpu_info_map;
 
-		if (!test_and_set_bit(port_word_bit,
-					(unsigned long *)&vcpu_info->evtchn_pending_sel)) {
-			WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
-			kick_vcpu = true;
-		}
+		if (test_and_set_bit(port_word_bit,
+				     (unsigned long *)&vcpu_info->evtchn_pending_sel))
+			return;
+
+		WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
 	}
 
 	/* For the per-vCPU lapic vector, deliver it as MSI. */
-	if (kick_vcpu && vcpu->arch.xen.upcall_vector) {
+	if (vcpu->arch.xen.upcall_vector) {
 		kvm_xen_inject_vcpu_vector(vcpu);
-		kick_vcpu = false;
+		return;
 	}
 
 out_kick:
-	if (kick_vcpu) {
-		kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
-		kvm_vcpu_kick(vcpu);
-	}
+	kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
+	kvm_vcpu_kick(vcpu);
 }
 
 /*
-- 
2.54.0.823.g6e5bcc1fc9-goog

