Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8211247DFA6
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093409; cv=none; b=Sy1Uql93BsqPeSW+upiY98UjPn2+AN5RD3pa/F0Hm0/WoRl2UpJo09HiICJe12lf2RLgcTaxSgkiEtfRtZ7rSS/78+tDNe+tJFDDZrAS3Amp+mC6JblYszb4KKTFE9BoTQTqw0g3piaDu5ZZBThIYQpcHV/czhLYENyQC2yup+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093409; c=relaxed/simple;
	bh=KgmvYQ4aIIIwB/uuTF147khWhwDE3Ci/RNN+FkKz8y8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gyO8Dpo1A7fa79exEjeWL+TExf4t4O6wERLKVO0LZ8KYUChoFVF5kE1WjkO2zkkO9QOAWViEunPDQHLhEG0Z4sklK1ejUpBZAQZE8OaIQULkjpRObSiAtG0GVEfkUJO9KEzQ5PoQ4Uh7+tk4T2xXM9sF6zWksl0tXwRY20UdjfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=snUDUwwX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="snUDUwwX"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf32259e0eso6853345ad.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093408; x=1780698208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EwR+3vho0VQrVi1Nz9jliESbfPqmEObd/3RZBDK6xpg=;
        b=snUDUwwXznHNttAIbiAeWb+yf6cniqSjcvHOAVyj6x/7yDXzoOPiSPIM2AX+4A8/Jo
         iml2L7+8VB9qwZlkhGGio+gTGkCYZSOTxut4FF+kcakCCkC9QSTwbTEeQZ/xhu66y2vz
         mY/5VXUfZNMEn7Gpk3ikTns3BoxI4gjqTkLg61r/ezA9pgGs6875jHYfGcvf9s+1jkpz
         syRONXE4ZvHNX3qaxnrS3/0TYA30PLcF7taOoOnodgCbSEw/7Vwbw5dt4M1z0QnKbxrF
         pslffISHGmflhP9fu0/Eawbt5WRayiv4WjPrO988cgK/loEYZiWRtm6sEoOEmGL141gz
         UiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093408; x=1780698208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwR+3vho0VQrVi1Nz9jliESbfPqmEObd/3RZBDK6xpg=;
        b=Hckigt8bcl2iN9a9Q1Vgkbq/6FpLJCkjMxvuDaF8qZJY2iU0FMXpL5mEHQZXthfIcB
         Nza/3RZai0keZXu/LzbJmiy1Xr1t+eRgDMvX6qMFPMLpP1RxTH6Ar7mCAVYhFzvmoH7k
         uBeAP7g++swr3WHMn74/nDgjegZnNSmNIkovm7K0IyhtSNmZjASBLyijlb1RWE0sWSNa
         Mk1h1UcC6b2RJT4XtEdMin8UjHsBn4wZ6dLgclEDuYo1WQvi4guHPpUFWmJvbIjSabV3
         j8lbK8DeCiFd2CeTpx9EvZE1z/Os1IMF7IDvOL9mvYQ23nkC6uZF3QgS+x7YqlZaFaXH
         +lOg==
X-Gm-Message-State: AOJu0YzEfti9XDOnpLHMqzLeoK9NVA4UoT/U+mLnRoOn2GOIazpiO/7i
	ApZdqNTBB90d6qLBvYv2NtFAIX8vEcIKzdR6ZQv4AiD8rfuG5O2EzgR7DytS+Qg/kKUEZS8Ylx+
	ScUaHTQ==
X-Received: from plxj8.prod.google.com ([2002:a17:902:da88:b0:2bf:10b7:41d7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccc8:b0:2b4:5aff:de60
 with SMTP id d9443c01a7336-2bf36833fefmr19350705ad.22.1780093407781; Fri, 29
 May 2026 15:23:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:20 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-38-seanjc@google.com>
Subject: [PATCH v3 37/40] KVM: x86: Move kvm_pv_send_ipi() declaration from
 kvm_host.h => lapic.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the declaration of kvm_pv_send_ipi() into lapic.h, as its
implementation is provided by lapic.c (sending PV IPIs relies on the
optimized APIC map provided by the in-kernel local APIC), and it's only
used by KVM x86 code.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 4 ----
 arch/x86/kvm/lapic.h            | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 38de6c0dc743..a3c1ff784e5c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2363,10 +2363,6 @@ enum {
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
2.54.0.823.g6e5bcc1fc9-goog

