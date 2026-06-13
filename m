Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA026304976
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309053; cv=none; b=CF5CwLmWUo4lc5ki+vpRzr3Sj7megRszq9FzyGWwpvOfUe4Bnedb/ADZ6BU8bxRu73GKhbVRkBEsIJ1XdG55rg0wfIE8J83M3o8ip/joI4QFhLI5QyiVwWW+eErGtY/IMMhBCRl1rhQXYkmr/Pxw4g0ai5JiQzVcw0D1sijCJcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309053; c=relaxed/simple;
	bh=TUs8+D3WQzak/3ZK7/ZuXM9Z8eiT94gH6iLznJppYyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jtybz0rNlYm9fDxnNT5omLPTTF7MmN44Ro7KLAqk2AtQmr11CkdShqsqflNqx5xAgjk+lxq8YXyzn53M0z9vH/9ReSN57MBFJf7RyVTzj6GgPItUQhCA15oX+CGDgT6LymBbT0faSz0VjFVANQzcHbbBBQhEcCWPFliysvu+zBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=veVDZu49; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veVDZu49"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2c305d0so739053a12.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309050; x=1781913850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=r9wPaZtQHX5Bx6eh7lTncgy5Eq4/yAkBzcyfxii5Ebk=;
        b=veVDZu49y9YMr06hQeCM0u3RqmNsCR9LRxF1FEeJhK0Nx1gDBzwAI48/fv7hyZVevE
         i55JdqJOTd+AGE1sbAnnEpd1TsblhBY2wmlfvFUmrgsEowG6X7lyiDoG1/EwZ+PrXoNU
         /R4dhtt5P6dxngaAC0OvkkfgmYw/ISWU2/bUB0/zrLHlAVCzGMsAq4CVE4IYemEFNWGl
         Plmz0veM4brwkdvULQMCDYbM5hv9akHIVvEbFIkmFw7IoQbOlOqZ4i29DYVJByguGy1p
         37sUK7VnTtkxP18VSX52LtP/b4S8T3V2yzVDHWuuTFu5aQ0+FvCj120OuEkm6xjxrLjw
         uBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309050; x=1781913850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9wPaZtQHX5Bx6eh7lTncgy5Eq4/yAkBzcyfxii5Ebk=;
        b=p2tYFug7OXibOhIemQ5MBwYxtjdMNGYUW/jVw7O823RoGlf80U/Lw/iBXCbk5HOo5Q
         +eU7Ft7bhBDLHJJTVGiQ9OEnZW3rp1rAC8HORT1OnpFNBKjhaacKX7F0TVVS70XhB7rL
         REjeiYQW9f9yXHWCb4Qqk9fo7/EKVKAUylyNjcau9YgcANVPbBbqxCcgg/rD2AP+X8CV
         7N45jsCjYtU6XrnE+5EyLbK63s7wsU9dVVMUb5ZLRcs2Grhw1ztWOXFsdUvqR4X0QNP6
         l1drk6KvFzZRiqjEcW2fw4mwiT9hedq4o/BLM6uQlNnmrs/VIcj+TzOoIi4FXb0JTDT4
         Iqog==
X-Gm-Message-State: AOJu0Yx/uUWzPIwEmOTkuHZHHOdCTNRQKU9srueftuqnbMmqYCT3LRFX
	1glRlrwYTE/hOg4KPs95iokEace9VgXhc9ec3oMPIUAlbo8njfO8/8Xj1jBdNjIFQxVMRalerxN
	fA5DOGw==
X-Received: from pgbl26.prod.google.com ([2002:a63:571a:0:b0:c85:a528:228f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7d02:b0:3b3:216b:274c
 with SMTP id adf61e73a8af0-3b783f1bd60mr6127156637.22.1781309050199; Fri, 12
 Jun 2026 17:04:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:24 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-26-seanjc@google.com>
Subject: [PATCH v4 25/30] KVM: x86: Move kvm_pv_send_ipi() declaration from
 kvm_host.h => lapic.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the declaration of kvm_pv_send_ipi() into lapic.h, as its
implementation is provided by lapic.c (sending PV IPIs relies on the
optimized APIC map provided by the in-kernel local APIC), and it's only
used by KVM x86 code.

No functional change intended.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 4 ----
 arch/x86/kvm/lapic.h            | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 811687b7a76a..0f6f71642e1d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2341,10 +2341,6 @@ enum {
 int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu);
 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 
-int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
-		    unsigned long ipi_bitmap_high, u32 min,
-		    unsigned long icr, int op_64_bit);
-
 u64 kvm_scale_tsc(u64 tsc, u64 ratio);
 u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc);
 u64 kvm_calc_nested_tsc_offset(u64 l1_offset, u64 l2_offset, u64 l2_multiplier);
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 32f09b25884a..58dbb94f980d 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -131,6 +131,9 @@ static inline int kvm_irq_delivery_to_apic(struct kvm *kvm,
 }
 
 void kvm_apic_send_ipi(struct kvm_lapic *apic, u32 icr_low, u32 icr_high);
+int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
+		    unsigned long ipi_bitmap_high, u32 min,
+		    unsigned long icr, int op_64_bit);
 
 int kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value, bool host_initiated);
 int kvm_apic_get_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
-- 
2.54.0.1136.gdb2ca164c4-goog

