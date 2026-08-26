Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E48D41D23B
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764389; cv=none; b=tYN8nIR9fQ/n0SQfhJTSZKMYo1l0sfd8bqJU3gTJ5aJ0ydWYcbpfhAag1ZrZmJg6zO6NoD+SmRs/mptiFTWrDmBPvP1deobdGouK//j3nSjouRJpQnfYLwuOS3JbfZSjDWcOOM9lQEK51RHW3aijKGUs2UUu8PN1wO+fC8lr6hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764389; c=relaxed/simple;
	bh=Xy9bUPMo10wPx+hGK64PejVqPjCe+tnmlzShZBrttKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CRCwJ8hqADMD5wCF6FTaY5mAmXXtDrXy4kWJirP35+kd9Xu1gNcQ/XuZRpLxxImyL8pzdf43Soh2gMdfKoGWBsORux7W/tROCgOYMVDf8yaIhkqBj5XeERaVFLABTMkGcoh/hDYaLDVvVKKf3pSOg7aVwm/ifybXZUKwgzOfp+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EVOa9PuD; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EVOa9PuD"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc15155cde2so1431608a12.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787764371; x=1788369171; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Df0A62BBX5SuQrh9wZqWxjT6F0PSRl8xPi6joM+3RXg=;
        b=EVOa9PuDXIcKd8pWFzPPRfhwscpTp5J5uV0C9i6uDlTIsNNgp9mkp86qgsSHpnP7bn
         sQV5+/L2nu5sk3r0Q+NIVXDsvnwtB3htXkfdEKvIDX59bq9nEvASBhFFPNsq8vLVimBL
         uELfI3JKLHeMkaoiWEzZxf0aE8t9HwUcwHP3Ywfx4v1vKEXBoem/OdS3BACsiUtJMvzK
         s4tIKYplTOGhgOX1sT/FVrnQcYm7J9U7A4Yc2UJRysqu+tIgUpVueX0VW1KH3diiXLEj
         Dsi9Mxn/tHLxrgBwdsX83PfdRxCgtpnhuV0y0yp12z/eRdvNUS/oOYC9/+0lxHDV7SOg
         wQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764371; x=1788369171;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Df0A62BBX5SuQrh9wZqWxjT6F0PSRl8xPi6joM+3RXg=;
        b=qXdh6LVXyWv1da9njizer91iSvIAPyMLDSy9H+W6MYdsmABLyMj7dttmPR3rCBb+jJ
         Dw5TsBMGKP5CFbOmfKi8C0them7kK4vH/gsot4YtnH1wg8y2kkNjxLIUnxmhWAW5I5H2
         BnzQuD0GmNoW4S6A3p72gKiZ7Qa5R1TLeiIGjk/twFlW6ndjb93Lv1pf9x1LBKVw6GS4
         8rlcG3Hjbkv/9ZAfN6OTbhNrl9f8ayjcdjaPFLAgYxfw9omFce/sCHF3NS07msCSB1Ws
         b2hU+AKLmjqKvPq5PXTYVf3bjHZGFA+govw4jwrKh51EP59v2ywittXGwiw/xn8041hh
         w3OA==
X-Gm-Message-State: AFuF++mB4b0HKzK7vsCuPVJRG6m3zAduwwr1XY6NoWoWDzmJGOy/Ce88
	vFmXBpx4YWK+lU4cA+b2UBBiQSnUYgD2HWAVmmvE0OpRMDHRdJe7ZVEGuTm8LL3yd8eiHikbcjB
	Lu5rVNQ==
X-Received: from pgby7-n2.prod.google.com ([2002:a05:6a02:6507:20b0:cbe:948f:d640])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3926:b0:848:46a0:3d74
 with SMTP id d2e1a72fcca58-8537499bb90mr14451563b3a.9.1787764370966; Wed, 26
 Aug 2026 10:12:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 10:12:40 -0700
In-Reply-To: <20260826171246.777729-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826171246.777729-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826171246.777729-3-seanjc@google.com>
Subject: [PATCH v2 2/8] KVM: VMX: Move the shared NMI handler/trampoline to
 common code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move vmx_handle_nmi() to main.c to capture that it's a common handler and
to allow guarding against incorrectly using to_vmx().

Opportunistically use a "vt" prefix instead of "vmx" to communicate that
it's a shared handler.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/common.h |  2 +-
 arch/x86/kvm/vmx/main.c   | 11 +++++++++++
 arch/x86/kvm/vmx/tdx.c    |  2 +-
 arch/x86/kvm/vmx/vmx.c    | 13 +------------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 88f637c81353..4b1d46eafd0f 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -189,6 +189,6 @@ static inline void __vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu,
 	kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_VECTOR);
 }
 
-noinstr void vmx_handle_nmi(struct kvm_vcpu *vcpu);
+noinstr void vt_handle_nmi(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_X86_VMX_COMMON_H */
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 274200b0a307..684b87692864 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -945,6 +945,17 @@ static void vt_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 	}
 }
 
+noinstr void vt_handle_nmi(struct kvm_vcpu *vcpu)
+{
+	if ((u16)vmx_get_exit_reason(vcpu).basic != EXIT_REASON_EXCEPTION_NMI ||
+	    !is_nmi(vmx_get_intr_info(vcpu)))
+		return;
+
+	kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
+	x86_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
+	kvm_after_interrupt(vcpu);
+}
+
 #define VMX_REQUIRED_APICV_INHIBITS				\
 	(BIT(APICV_INHIBIT_REASON_DISABLED) |			\
 	 BIT(APICV_INHIBIT_REASON_ABSENT) |			\
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a7..46b0e798f8b9 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -974,7 +974,7 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 	tdx->exit_gpa = tdx->vp_enter_args.r8;
 	vt->exit_intr_info = tdx->vp_enter_args.r9;
 
-	vmx_handle_nmi(vcpu);
+	vt_handle_nmi(vcpu);
 
 	guest_state_exit_irqoff();
 }
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index adf2bc13bed2..a06dd2d77f10 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7363,17 +7363,6 @@ static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu,
 	}
 }
 
-noinstr void vmx_handle_nmi(struct kvm_vcpu *vcpu)
-{
-	if ((u16)vmx_get_exit_reason(vcpu).basic != EXIT_REASON_EXCEPTION_NMI ||
-	    !is_nmi(vmx_get_intr_info(vcpu)))
-		return;
-
-	kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
-	x86_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
-	kvm_after_interrupt(vcpu);
-}
-
 static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 					unsigned int flags)
 {
@@ -7406,7 +7395,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	if (likely(!vmx_get_exit_reason(vcpu).failed_vmentry))
 		vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
 
-	vmx_handle_nmi(vcpu);
+	vt_handle_nmi(vcpu);
 
 out:
 	guest_state_exit_irqoff();
-- 
2.55.0.887.g758fc8c411-goog

