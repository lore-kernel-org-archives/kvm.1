Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396272;
	b=LcyT9DF/BKwpERVnpMi8BD7pmm9mcHRDXyvQ4EqUqbV3iefgomd1uuK3vQbtkTEkeoun
	 +m+I+ZMt2vVhFAV9ArgWrcAAkodB1JH1CCfHVLiJPYHWw51O0ql4G0S+Qm46fwrQ9JqlL
	 eat2U1+kUfOqOrJphga4upcZ29vYf8/xxO/8cg5s8w5eSY5Iam/lfx5J1w1Djc7DDKPDo
	 qEPGJ+vrgOQiNSKz9W7bHV33ZF1e+bEndKSq04ynFjyATb27Qcdpf2ob+bEqJx86blUCN
	 BKE3SI8Bs66FHn6CzmA/phlhuR7ZRRlNlFewPtHSIZImle2dfRJfgZJ/taClbANbSpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=UWpoThsKVVH8wpihCZprx9pHZaFu0THdyOfPf9yMXho=;
	b=e7XSM9xkH6rVo041BH071KbMpT0KJHhD3TkxgdsYpRwqAoJOHWF7ULNbCabUHVpC3zOh
	 WKuOt+UZfVurWYcVsBO75wq+8qor6qKHT9SCh6f68KtRSFJ505m3REjaY6cMnFVQm7Ot2
	 /OU4JK8T8TTofauHVr00FkbJ6NZiYH/lLoqwViIhreKY/SgZV6DU5Ol8WQfMmxcYolMrK
	 vYonHcC7byOAJ7XySlM1Ibn44xzPKDxSiSbVbzciOlIUqoFE0MrTQenCc6SLTtxnsiFzQ
	 r2bOiyoc9YelMLkJscqYGIbgc4O/xDPRMTDSEtHTzi2A6JaDdi2AZU24zPFHQ0bikog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="gtryOvc/";
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793D606A338
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8793D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gtryOvc/
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e954d87b48so18767615ad.2
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793396272; x=1794001072; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UWpoThsKVVH8wpihCZprx9pHZaFu0THdyOfPf9yMXho=;
        b=gtryOvc/4zzvrqwQWsgk67IFil5Pi4Bb2Hnu4kdTfu39Vph8zpUlFTNg3rdUGxeEek
         zvoysvJL7nA/khRDZMfZg90RsxjZvr9N+/FXE0xBA3Rve06zI9abzDtwegHO/AwArq3x
         Jxg/a7eEMinVphpSZ7JhgM36DikoLiGPC/7/CX+GlrWoj6rH2jSR/xw6xLDnEr+B94X9
         +3SxxnQXyxwc08si/IW2xJ7X0OhFIZIp+2/45m5lCjFMHc/z4ekWzGYFVwpupceoA30T
         ZtYfnzWUAWmOv53V9gJ/yCgbG+zfN+LcyoXBiZVduiHgRfal9KebHm8feUG+Ss/7iR/U
         a3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793396272; x=1794001072;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UWpoThsKVVH8wpihCZprx9pHZaFu0THdyOfPf9yMXho=;
        b=iuvXFGJseizXFNaIKZnJg3MpjDFiwZGFv1xm0I9hWa/ysga+iENi4wnukOFynd5UtW
         gaR2nmzPOXTJv0B3lfd5+MjszBvqlmAdjP4jxfkrJ0iz4U0HPRtqiSsA34uHgededAOu
         ZblUyQ2okHFPN3vidW1E8az4vzLrQIBI1PYTzLMKKY1/zxObBnoI4JSRkRIYza3rHnKS
         UPM1BJLnV/Coj8OgwTia/r4OB0WA9PWG34EzaiG3Ykbia3fSyTXOjNDBK6H+pz1CfS0V
         SBUlTHsw2kfwC5A/Qdyn0t0aUmswlHp77CQaU9LRP/jrSmISe5C8Pk+kUGqGwMPCckmd
         F16w==
X-Gm-Message-State: AFq9FYLlAlH6s6qKxrO+RtD8eISVHBCnm3Cm03DGRK9QHx+Zha5+J9fm
	Z82zjyZSooOVsFrypZ6iF163QzQ0YD1+hK8s7qmUgmzqMKk5BGR2mLeHE0DGSwmRf/CbDbKUq4j
	JFrGk2g==
X-Received: from plpn9.prod.google.com ([2002:a17:902:9689:b0:2e6:e1e:5217])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:38c3:b0:2e9:5b4e:b8a1
 with SMTP id d9443c01a7336-2eb3650af7dmr38510525ad.55.1793396271705; Fri, 30
 Oct 2026 14:37:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:37:44 -0700
In-Reply-To: <20261030213747.2611815-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030213747.2611815-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030213747.2611815-3-seanjc@google.com>
Subject: [PATCH v3 2/5] KVM: nVMX: Honor L1-owned CR0 bits when emulating
 intercepted LMSW for L2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Mahmoud Abumandour <ma.mandourr@gmail.com>

When emulating an intercepted LMSW on behalf L2, i.e. when LMSW exits to L0
but not to L1, emulate it via handle_set_cr0(), as is done for MOV to CR0,
so that KVM honor's the guest/host mask and read shadow from vmcs12.  This
fixes a bug where so L2 could change L1-owned CR0 bits, e.g. clear TS, and
read their effective values instead of the read shadow.

Drop kvm_lmsw() as it is no longer used, and opportunistically trace the
effectively CR0 value (previously, KVM traced the raw CR0.PE value), e.g.
so that users don't have to piece together that CR0.PE will be preserved if
it was already '1'.

Fixes: eeadf9e7558c ("KVM: nVMX: Handling of CR0 and CR4 modifying instructions")
Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/regs.c    | 6 ------
 arch/x86/kvm/regs.h    | 1 -
 arch/x86/kvm/vmx/vmx.c | 6 ++++--
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 3621f1a47d37..44a88c70b77b 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -303,12 +303,6 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_set_cr0);
 
-void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw)
-{
-	(void)kvm_set_cr0(vcpu, kvm_read_cr0_bits(vcpu, ~0x0eul) | (msw & 0x0f));
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_lmsw);
-
 int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
 	bool skip_tlb_flush = false;
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 97c17b120a57..c30ac8394271 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -62,7 +62,6 @@ int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val);
 unsigned long kvm_get_dr(struct kvm_vcpu *vcpu, int dr);
 unsigned long kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu);
 unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
-void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
 
 static inline bool is_long_mode(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 544b7840897c..2d5feeb8a059 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5743,8 +5743,10 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 		break;
 	case 3: /* lmsw */
 		val = (exit_qualification >> LMSW_SOURCE_DATA_SHIFT) & 0x0f;
-		trace_kvm_cr_write(0, (kvm_read_cr0_bits(vcpu, ~0xful) | val));
-		kvm_lmsw(vcpu, val);
+		val |= kvm_read_cr0_bits(vcpu, ~0x0eul);
+
+		trace_kvm_cr_write(cr, val);
+		(void)handle_set_cr0(vcpu, val);
 
 		return kvm_skip_emulated_instruction(vcpu);
 	default:
-- 
2.56.0.385.gac671c819a-goog

