Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57B0379980
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425108; cv=none; b=an7PydlUgTgo5kuy9+MRHqHiMZF4fzitFrJgCFJgwadG8XB931S68PwMWvFnvk+YzOkMmnalRE8Tkm9/OJ98aEGomnFwKzqm+VWWc8OC24BkV0qCIQACgn69vK7+0JsFTzfaLtIpgd24Ijw1C6EyerW7Uv6Mr2GqCHl2pJ+SNWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425108; c=relaxed/simple;
	bh=EJ0iE55IdiF9MbSosLSUG0oy4s7NJ1CsJIMXYS3ojuk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k0be7YpkIJdti9LV8CrSwjwQymSGLokpIMHOsPkj4Oix2JqUd5T2n8Q8lXvYxx0VEd55I4oKBLFqWc6uuOqUTZKU/rYrbsxN6vtLpNk9OQU/da2EfLULoavh6EqNs2vOgYHUVLs7+w22VXvS+1OxcuHNartVo7v/mFP4ekBHTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uAPwsm98; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uAPwsm98"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8bad49b171so149089a12.3
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782425101; x=1783029901; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sQHEPvtW1UE3NBSr5W9fVo6fZ1j2f2QjDZI9MpNWZeo=;
        b=uAPwsm98ELtZi3DvP67zNSAfL7T2WaZz7Y36aTIhQTLPTHaxyc0nfeQjCX7dcq6CqZ
         qNhEj7eylSRx56u7BvCK++BeTy96ERprTBIXTG8+l5/YoQ1ORNXvZ3uQXnM7r5O27zEm
         rj/UZb22lY5FqUH2I+6xD12Bh0AzUp2dGM0iTB8EI0x1C9/ZrsA6UwSUpgISLieRIaiy
         jyD3Vfy86kHm5nLGpxYDDE9OYCYLM9AZnZeR2VSEmxM5A/FyMR8aoKW8LBFkt/LmKUy+
         I+vDrEhgjomtHGdi8v7V2WCcpVPKQgPRBSBpXb4FbqGLE24mWbdECCBW9FnZsGN0Bkvu
         RVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782425101; x=1783029901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQHEPvtW1UE3NBSr5W9fVo6fZ1j2f2QjDZI9MpNWZeo=;
        b=Qr11nRQyN7iojgNv9odTmitI8T771z2dptkAu22pz7jirQ3N1mE+VA4MT4pw2FI8NC
         SlwwvfeRQX8o3+sw+Hydc0WMFUjcZhAPdKgeLac52hSaZ68yhMW+glPZk8loiQMJaUT9
         rt6rd6Q6tY0nG5IXQuU9iwNGlldPt0KYwaCPfuayBXTfbktU112BNzMZ6nJxCY+j63jr
         IsvX+LEbDR3Q4tifJrJ8q8hvGEA/Q1JqRox5HWnWPYMvK15KHSWUKGEnb+frjk9ed3nZ
         6Rbl29v79O0YZPmdSdlyYbuiX24ZMyEJ+pGoZaO+Pqftw5iuT44LTZIYdl2VRdibpfyT
         kTAw==
X-Gm-Message-State: AOJu0YxCEtx3zj7spNmn0ktcgeMP8BuXrDB2LPju4voncS1uaURAouwz
	zkCG4MdXUfi1r21ihL933gpAurGgCjtKKtIXnlN331xulau/d/KR3uwce7+mjoO23hFelbmvWJp
	lCiw2OA==
X-Received: from pgcl18.prod.google.com ([2002:a63:7012:0:b0:c88:9458:e8e7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a10d:b0:3b4:8268:23e8
 with SMTP id adf61e73a8af0-3bd4ae0f236mr5134460637.21.1782425101310; Thu, 25
 Jun 2026 15:05:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:04:48 -0700
In-Reply-To: <20260625220450.3354415-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625220450.3354415-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625220450.3354415-8-seanjc@google.com>
Subject: [PATCH 7/9] KVM: x86: Move KVM's arbitrary task switch reason enums
 to x86.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Relocate KVM's TASK_SWITCH_<reason> enums from kvm_host.h to x86.h, as the
enums are arbitrary values, i.e. not architectural, and are intended to be
used only to translate vendor specific information to a common x86 reason
when invoking kvm_task_switch().

Opportunistically name the overall enum to help document the role of the
values.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 7 -------
 arch/x86/kvm/x86.h              | 6 ++++++
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f24e0de00692..c7d53d46763b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1960,13 +1960,6 @@ static inline unsigned long read_msr(unsigned long msr)
 }
 #endif
 
-enum {
-	TASK_SWITCH_CALL = 0,
-	TASK_SWITCH_IRET = 1,
-	TASK_SWITCH_JMP = 2,
-	TASK_SWITCH_GATE = 3,
-};
-
 #define HF_GUEST_MASK		(1 << 0) /* VCPU is in guest-mode */
 
 #ifdef CONFIG_KVM_SMM
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 8ece468087a8..494d97e9a9c9 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -482,6 +482,12 @@ int kvm_emulate_wbinvd(struct kvm_vcpu *vcpu);
 
 void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
 
+enum kvm_task_switch_reason {
+	TASK_SWITCH_CALL = 0,
+	TASK_SWITCH_IRET = 1,
+	TASK_SWITCH_JMP = 2,
+	TASK_SWITCH_GATE = 3,
+};
 int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
 		    int reason, bool has_error_code, u32 error_code);
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

