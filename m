Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792636097;
	b=RvhEfjere6br63AH0XXSV22jxBJgDT8xa30UwK8s/H+9TzarrdykuRyZMTr5Tt/I9Fe3
	 092+tTQq411U+bNmZu32zrr0EquDriP8A4vDFM7pNQ5moKtkqHW/bj1sGY+Sj24M6c2z6
	 /3orK8xCP39zB/j75SfBfbIZvS4zhefZATbwv/6NwOBhbBl4PpiIaMbYhU0xCcm4HfJ5m
	 CzkCaAA/71ppDJsqEM2rxPEjzDVkO4eaLNo3vSLv6uDQGONrE/4if5Gm09/LLJ1hXMJHW
	 NTqmxfxOKSvhLxH7KPhtV1l9pwst13l1TlSeE83vnLqMQcgiWlu8NKTg/UeNtXunQ7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792636097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=WPfHOvXnP2pKxcZMYBNtzP6lSrkoM1jHg8H216tgeOs=;
	b=1eWR6ACsfJ77F2tvcW/hmDMdDJ7skmy0v6gp1WkS3aIys3ssU7lqdVvo22PbxVtQQISP
	 3C2kjrMFDM0fdK3Mi/eo1vXS/cC/MbvpbJaZUqnxtR6DaEmDyxq/Akt0Z68iT1jDd2nR9
	 PFIadyNiAwGoGt/IrP286kWljyY88uFKQmIcSf0pD8Oh75cepnsLvqsnALZZhP8Zf0jH/
	 Az4QF1tRb5jnABgP3ATcULk8zkkx1Ei1SeDP/UWGurvo40MhoUY8ZUu2lIhAsoyRrXrBt
	 V/tM1BrQdFxwBQ3enrkDZF3A+4KOmuMw9R88GrmrefAww/Gb0k3QpaaNMLIW0AcQyow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="g/kb7P/p";
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B94606A327
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57B94606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=g/kb7P/p
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a01ea9e318so1709608b3a.2
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 19:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792636096; x=1793240896; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WPfHOvXnP2pKxcZMYBNtzP6lSrkoM1jHg8H216tgeOs=;
        b=g/kb7P/pYBlhozkfSb5vn5qD9Ok0DRMq0oNQOOyjPXIRL/TaQum1vC+c+TYOq6OfUr
         ZDwmTfeSVg+b0SMj2dO5uNvOVTtlHQ6BYHkcWWEB8ndrcfDgipG7G2168mc0MLmiL09c
         sauEjP556P1BuqCYmeA7mSwvTKwYUXR8oifklUm7K0/qf92YMioLMd9YHXCD9UruaCjh
         NculjjjCBMJSEs8kHtAk8EHq2m8ik5AEgQTeGF5QRNxP14RtTWsjFCrv7d+0p2V9kzuW
         ikl25Oj7xI4YJJWcDwS0vLG4wPEYqU2AigQLyJAqnZvA8HUuBuROHp4Mq5Qxz35TKwlc
         H3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792636096; x=1793240896;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WPfHOvXnP2pKxcZMYBNtzP6lSrkoM1jHg8H216tgeOs=;
        b=GWcYx4VwiTAjhkxpJpjCmlxGEi/1LNfdwnVFeJOD+P57At727GFY2mviOwEX5jY36h
         U36rVjkF+h8FqFAa/suBa3vyOMQQyRocCaUnhiT7NYwZ+i6YgS2xWTo3o5vSyw+VfFai
         DneeDl9nT1ZFTzwjpk1SkKOaJn0KGkjjKpkTM1mybFsnwv1/v+rPNpPB7Ro0pDVGuB7y
         3lZ98s2d6moexxrermIKNJP+j/7Y6BKj2kCAXvur6J6+gdWOpd2eRXYWiA37CzddU4Rz
         afDBPW1GcDVTh8B8CTKRN7Nan5fDOckCNdteukRhezv8Ilk8IZVbFO3gYIHlzANSR8A/
         eHsw==
X-Gm-Message-State: AFq9FYIKAhF5DblskERQGkJUYuP9b88Ufqta0d3nrUkWsuEj276AEZm2
	O5/c0dY/wkRFZ7/dlRxmRFzVD1elrh6xB1eJSJvPro5E8OHA2FeeoXxZL3sp4sIue3RFdcONaWM
	oaZH/OA==
X-Received: from pfhh4.prod.google.com ([2002:a05:6a00:2304:b0:88f:2ad7:b21c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a24b:b0:882:7bed:3b3b
 with SMTP id d2e1a72fcca58-8a089e99514mr3069913b3a.36.1792636096488; Wed, 21
 Oct 2026 19:28:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 21 Oct 2026 19:28:12 -0700
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
Message-ID: <20261022022813.303978-2-seanjc@google.com>
Subject: [PATCH v2 1/2] KVM: x86: Switch to vmcs01 to update EOI exiting
 bitmap on-demand if L2 is active
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset="UTF-8"

If KVM needs to update the EOI bitmap while L2 is running, temporarily load
vmcs01 and immediately refresh the bitmap in vmcs01 instead of deferring
the update until the next nested VM-Exit.  I.e. give the EOI bitmap the
same treatment as the many other updates that were previously deferred.

Reported-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Closes: https://lore.kernel.org/all/20261017093016.32348-2-amirmohammad.eftekhar@cispa.de
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/regs.h             |  6 ------
 arch/x86/kvm/vmx/vmx.c          |  2 ++
 arch/x86/kvm/x86.c              | 13 -------------
 4 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0378577d9d8b..f2c53a5f40e3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -113,7 +113,7 @@
 #define KVM_REQ_HV_RESET		KVM_ARCH_REQ(20)
 #define KVM_REQ_HV_EXIT			KVM_ARCH_REQ(21)
 #define KVM_REQ_HV_STIMER		KVM_ARCH_REQ(22)
-#define KVM_REQ_LOAD_EOI_EXITMAP	KVM_ARCH_REQ(23)
+/*#define FREE!!!  USE ME!!!		KVM_ARCH_REQ(23) */
 #define KVM_REQ_GET_NESTED_STATE_PAGES	KVM_ARCH_REQ(24)
 #define KVM_REQ_APICV_UPDATE \
 	KVM_ARCH_REQ_FLAGS(25, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 97c17b120a57..04d047f46753 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -463,12 +463,6 @@ static inline void enter_guest_mode(struct kvm_vcpu *vcpu)
 static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.hflags &= ~HF_GUEST_MASK;
-
-	if (vcpu->arch.load_eoi_exitmap_pending) {
-		vcpu->arch.load_eoi_exitmap_pending = false;
-		kvm_make_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu);
-	}
-
 	vcpu->stat.guest_mode = 0;
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6057..59b48d959ee0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7082,6 +7082,8 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 	if (!kvm_vcpu_apicv_active(vcpu))
 		return;
 
+	guard(vmx_vmcs01)(vcpu);
+
 	vmcs_write64(EOI_EXIT_BITMAP0, eoi_exit_bitmap[0]);
 	vmcs_write64(EOI_EXIT_BITMAP1, eoi_exit_bitmap[1]);
 	vmcs_write64(EOI_EXIT_BITMAP2, eoi_exit_bitmap[2]);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba9..0028d57e964a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8062,17 +8062,6 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 		kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
 #endif
 
-	if (is_guest_mode(vcpu))
-		vcpu->arch.load_eoi_exitmap_pending = true;
-	else
-		kvm_make_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu);
-}
-
-static void vcpu_load_eoi_exitmap(struct kvm_vcpu *vcpu)
-{
-	if (!kvm_apic_hw_enabled(vcpu->arch.apic))
-		return;
-
 #ifdef CONFIG_KVM_HYPERV
 	if (to_hv_vcpu(vcpu)) {
 		u64 eoi_exit_bitmap[4];
@@ -8240,8 +8229,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 		if (kvm_check_request(KVM_REQ_SCAN_IOAPIC, vcpu))
 			vcpu_scan_ioapic(vcpu);
-		if (kvm_check_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu))
-			vcpu_load_eoi_exitmap(vcpu);
 		if (kvm_check_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu))
 			kvm_vcpu_reload_apic_access_page(vcpu);
 #ifdef CONFIG_KVM_HYPERV
-- 
2.56.0.218.g1ec904b173-goog

