Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792636099;
	b=Da6SBrS2LxELFc+jlALK67tZic+Bx480KT2qfgIZ0ja2gLCCUtz+zwD003cynDBgCn0Z
	 H2iXKjmHHgRnXTYZWBybUgsaBdgJsbXFQjIm/Gz3sD8FgdSzGPQuFwMBoIivI80sw9LMt
	 8ANL2rrwN7hmuHd8hOjNFa1syi3uMyY4+kbOpJAVTXwDf9jmxnJ5Xe2K6elsZYBsQBvp+
	 FW7wl+IzgIlAfnEtCSI8gaIeCHArWMQATcVvU3Y4FjQoLo6rtiyjemfgl24b7bOa3j4Xx
	 P9tAvzkla4QKP3Ipxe9t5TIY5e0JK2jFNCj0LwkKqRLbMw0iiHlI8xyx/tY4qkzNy8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792636099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=EAAWKPNIvnyz4HJ+1ciZLxfch9wphgM0NQmQydeHNgo=;
	b=wp6+Y9Px4KjpZ9Y6vkEPIUVuDGSt5r1h0sRptinsqBjvLl7ACExeMHzjctEwv2mUIFM8
	 ZXI3zC4Usd5A8NymrEmy29CehTFDNwW0Lv/+kmZVm1TV/E7O9n6r2vrWtt+m8Xa2H++07
	 j2ALl2GvsdDhz1vBnwLCa4qYZbqzPHoYvP1ed0LURFYpYgr5cJzPkTRMfoui2zNwh2XfL
	 mkrnm0gMaJXBKV+VsUEv43iB/xGolnqSUi9JOp2aApSn0qHsWY1PGF7s6pXYa4phIe4g/
	 qZoD96FFM4s28e+m71+bNYmpzHxmfLgCzPHIAGSUo06LAnapz8pmIMN54bQQu3Sr2QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pEIsnjxv;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B2606A323
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A9B2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pEIsnjxv
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e601800e58so18580515ad.2
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 19:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792636098; x=1793240898; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EAAWKPNIvnyz4HJ+1ciZLxfch9wphgM0NQmQydeHNgo=;
        b=pEIsnjxvndomloZziXjUozDNpVKzKo57Y8WjqClBGF24o16h7eIB8xiTaHNgZ16ydK
         YRAGbvuKBlVAYAQO/8WYx0RGS47eVQ8SFa7m0Mz3C9o5VCQhIRlEgqouK9Qq9Z9k1POx
         2XmO5M3qt/3aNIWJCg1OHsDKFeiCxjhrtpaAPcWizrx+Vph954RZRxpFpeO92EL+RY8Q
         igXNUBE/EufpL/vso/2xrj+oYSkIQecx+UsuSS1HFxae8p1AKxADIU2puWJ60HdMy6jr
         Vl+6PY7OMr9+4Ywvwivnf1P9tG/2Ea0NPSCa2SD9VisunCIxEdsEjpWfdg8EiiY4WsPY
         FDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792636098; x=1793240898;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EAAWKPNIvnyz4HJ+1ciZLxfch9wphgM0NQmQydeHNgo=;
        b=nJ6r9vvy6oJcXDH8TFCeEiuAZDffihIndF7R4kWs0k9Pwp2kuXY6yPj86jASagddRT
         NysL0qXyAW3iZtjigpv5LMNLn1vZSzcpi471JtFfj+emiSm4oFsiEpHFUsFOw8ZfCZzQ
         +zI/Uiz1/lpAbuHFnXv+SX1nBzJWDMf8KcHqaedsk19Fj0PbdfXr7h1oDC5frqv5naPl
         0UjO5WFyj8b0XYjoyAUs40UpdER/unmYq1nJ+xQ5WqiA8afusZicBBgMsKMW0shJmOkt
         HB0Ov0PM4up40errHOO4juEZ27BCl5pqIOEe0WZhUleKWW0ODRGEfzg3LdX/z2Zp0ErJ
         uT/Q==
X-Gm-Message-State: AFq9FYKcL6CX30XMQcvgPQ34XAyTSdLiqjUUrhKQ5U6CjIjgBxiFQ5lk
	jR0Am9jp/VkopIMAJF+V9n0jQSxK7Yf+VJKJMBoPSghKXR1yyLlo0YiFJYA1WZy1BrEgHEFPFce
	332lB5w==
X-Received: from plkq19.prod.google.com ([2002:a17:902:edd3:b0:2e5:db9c:f03f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a0c:b0:2e9:5714:6082
 with SMTP id d9443c01a7336-2ea43d85a51mr32346975ad.55.1792636097710; Wed, 21
 Oct 2026 19:28:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 21 Oct 2026 19:28:13 -0700
In-Reply-To: <20261022022813.303978-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022022813.303978-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022022813.303978-3-seanjc@google.com>
Subject: [PATCH v2 2/2] KVM: x86: Consolidate invocations of kvm_x86_ops.load_eoi_exitmap()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset="UTF-8"

Rework KVM's handling of EOI exit bitmap updates to consolidate the calls
to vendor code so that it's easier to see that the Hyper-V path is doing
the exact same thing, just with extra input to account for the SynIC
vectors.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0028d57e964a..483dac323c8e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8047,6 +8047,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_inc_or_dec_irq_window_inhibit);
 
 static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 {
+	unsigned long *eoi_exit_bitmap = vcpu->arch.ioapic_handled_vectors;
+	DECLARE_BITMAP(__eoi_exit_bitmap, 256) __maybe_unused;
+
 	if (!kvm_apic_present(vcpu))
 		return;
 
@@ -8064,17 +8067,14 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 
 #ifdef CONFIG_KVM_HYPERV
 	if (to_hv_vcpu(vcpu)) {
-		u64 eoi_exit_bitmap[4];
-
-		bitmap_or((ulong *)eoi_exit_bitmap,
+		bitmap_or(__eoi_exit_bitmap,
 			  vcpu->arch.ioapic_handled_vectors,
 			  to_hv_synic(vcpu)->vec_bitmap, 256);
-		kvm_x86_call(load_eoi_exitmap)(vcpu, eoi_exit_bitmap);
-		return;
+
+		eoi_exit_bitmap = __eoi_exit_bitmap;
 	}
 #endif
-	kvm_x86_call(load_eoi_exitmap)(
-		vcpu, (u64 *)vcpu->arch.ioapic_handled_vectors);
+	kvm_x86_call(load_eoi_exitmap)(vcpu, (u64 *)eoi_exit_bitmap);
 }
 
 void kvm_arch_guest_memory_reclaimed(struct kvm *kvm)
-- 
2.56.0.218.g1ec904b173-goog

