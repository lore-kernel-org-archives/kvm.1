Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32DF223DCE
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309038; cv=none; b=j0Nea98BTjvUBLrASt970kLJy9BLV78qk0JOnnByafkCVmMIv/xgJCrH+UzsLAQGTpRrWxMuBqiz5PH28pL1RvPUPe4b7V9d1pEW1YCHIom9Bp4t/xpW6/y00CLTYE2lPQjzOx9hFmsngFgSAjWCz1Im0vm8cACNf+TsMkNEYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309038; c=relaxed/simple;
	bh=Jn2PBmvgHG2x/szDC4gcvtmFfWfy599MF7GZdc1ODEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WlwY9PYLy1973En4/bpsluL96WGZnHz1rjXxcf/4kHjkmGWi3B3CMe8W96qjfqXPBaKfiFWdbO9I1cmJvDS/rGfmL3gvuqdhFF8Z31zxL3U9vdfMWeJWfFlGGv+YrvVMxk8zanyPJJoue3ZHOCSae8ZCKg4wiko7iTKfHhI42kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HIjEOmLq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HIjEOmLq"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422f987f2eso2392847b3a.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309036; x=1781913836; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PyyESs6EVCERvbHmvgwRw36JEYCsAq1dHwl75cF+1Hw=;
        b=HIjEOmLqp4zg7xxxDHExTSFo/R+Wy1NCVcZp/2Ceho+/s2kWIK7WdECE3c2g7gLTE/
         SHxIPV0L+mKJwHFKTcIhO/+Y3ePorsGr3xPgyCEzWkTHkrjGOY20mqgzfGDFMulswgKW
         gpJWwVoyofKis9SUwoLAak5E0lZ0zrrr4MP7tderCAfsl+arHb0iZSCQDKLhYnCtkwVx
         GU78qXAghVNtR0PuY2/S7kximhWAxMworj39Yz2b4DKr1kVE+Je7h7nRJKGO7x+DHCu6
         7yeQ8rzsKCiD1kyg3qlLswsEXfNvqjMCe/fa5b03AEP41FH4yWIBux8mNZjzLZSjLekA
         ZU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309036; x=1781913836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PyyESs6EVCERvbHmvgwRw36JEYCsAq1dHwl75cF+1Hw=;
        b=BUTB6E73MvvJRLo52zzAniPL5w8obcc4VwNL5MuZeimmPETfqcOGBjiIK8fRXvtkK5
         or7pPHBYjtym5bD4RBhR22D4CG5b/zbmGXJwy4AbME8hgv2mjjVkME2qIPTdcHK1i+Wa
         SIDYUn45vjO0gvC4KCril+Qj+PFPrzF83JGCSHogGl53LzRdupbd7v3m+pQxDoXE5F+q
         JHWsi6HyuZe7SbTvt2gpytJEMFhF5yCCHRK49o9CDnffkooiUGyB4zAAWA6CU6rP/nlc
         LTyzTcleBTcTBw2G8ITgdINvdwj5vfDIegfXBikOq9SOZNYBTQ9tBDPt5b6y2+ljwp1w
         X9rw==
X-Gm-Message-State: AOJu0YwH4zLcaFx7G2J6tRgBE+1j7HkTpX1I0P+6radyn4F2K+YA2OZw
	6rAb3IzxtTh7yehR6CIZaELtkLOsggOLFVvv45yGGDVVe5AeRV2eNVZOrBS/WZ73+0NwgpN6S6Z
	ZP3Mmdg==
X-Received: from pfn35.prod.google.com ([2002:a05:6a00:a223:b0:842:b0e7:887d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a211:b0:82c:d7c9:5479
 with SMTP id d2e1a72fcca58-8434ce92392mr5419615b3a.32.1781309036003; Fri, 12
 Jun 2026 17:03:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:15 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-17-seanjc@google.com>
Subject: [PATCH v4 16/30] KVM: x86: Move kvm_{g,s}et_segment() to inline
 helpers in regs.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Define kvm_{g,s}et_segment() as inline functions in regs.h, as they are
literally one-line wrappers to invoke vendor code.

No functional change intended.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 --
 arch/x86/kvm/regs.h             | 12 ++++++++++++
 arch/x86/kvm/x86.c              | 12 ------------
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cc96a9acaf88..3c3e160b0991 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2303,8 +2303,6 @@ int kvm_emulate_halt_noskip(struct kvm_vcpu *vcpu);
 int kvm_emulate_ap_reset_hold(struct kvm_vcpu *vcpu);
 int kvm_emulate_wbinvd(struct kvm_vcpu *vcpu);
 
-void kvm_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
-void kvm_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
 void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
 
 int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 30ef08d60a74..7a823422d78e 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -437,6 +437,18 @@ static inline unsigned long kvm_get_segment_base(struct kvm_vcpu *vcpu, int seg)
 	return kvm_x86_call(get_segment_base)(vcpu, seg);
 }
 
+static inline void kvm_set_segment(struct kvm_vcpu *vcpu,
+				   struct kvm_segment *var, int seg)
+{
+	kvm_x86_call(set_segment)(vcpu, var, seg);
+}
+
+static inline void kvm_get_segment(struct kvm_vcpu *vcpu,
+				   struct kvm_segment *var, int seg)
+{
+	kvm_x86_call(get_segment)(vcpu, var, seg);
+}
+
 unsigned long kvm_get_linear_rip(struct kvm_vcpu *vcpu);
 bool kvm_is_linear_rip(struct kvm_vcpu *vcpu, unsigned long linear_rip);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index caf01afe13f0..c6cc0961a4e7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4720,18 +4720,6 @@ static int vcpu_mmio_read(struct kvm_vcpu *vcpu, gpa_t addr, int len, void *v)
 	return handled;
 }
 
-void kvm_set_segment(struct kvm_vcpu *vcpu,
-		     struct kvm_segment *var, int seg)
-{
-	kvm_x86_call(set_segment)(vcpu, var, seg);
-}
-
-void kvm_get_segment(struct kvm_vcpu *vcpu,
-		     struct kvm_segment *var, int seg)
-{
-	kvm_x86_call(get_segment)(vcpu, var, seg);
-}
-
 gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 			      struct x86_exception *exception)
 {
-- 
2.54.0.1136.gdb2ca164c4-goog

