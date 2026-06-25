Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC88376465
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425105; cv=none; b=pNlwAOiSbYlbtwaERz1GtEd8XXqyCuZOAYK2g3ldi1VEn+voeSOlhvLl2XVjtRy7qUVQh5UQ2URmvcL/LPdS/9l5hba+rorC2dZWsZiT+b+PThWG8LoAj0bfPLMvvDT23nFXNvW+00UyHBJH0hiHs3MtUOhoRtfKHf94dWR5xrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425105; c=relaxed/simple;
	bh=wRHjL7Vxzskbz7E55ywnhG1dtfWEFY+OuV5osIH6qR4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YR/WHH8njPc3RmggfqQKw1RlQyXWh3K1JzieeiFNLZ/+1EIaWPbAs6iJeZjgu0GNSn+acbY7hR7kyDY80qtYJTDA+UmXqja97s2u0zQtctqXEhCkkgpWIJ4dIVzVTHX/MStX+lcRtXTvepQ1dhRhpITUvE+3sVBTIKyAkX9u4Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nRgOwifk; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nRgOwifk"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so191812a12.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782425099; x=1783029899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=H7E60LJzTlv9sk6UTbJ8U0xvMyb9HT0AFN1vWvqqyfI=;
        b=nRgOwifkcqTjeJgxKkr5416bH8YnWPXsKumRI4Cw/HfyiTYyVKivpSbwdCuZWlcO6T
         PyCdsdx9HXMecccKrvs53mOxTnu4XsHYSCrN19jHPRD7YSJVNO7UfM5c6YW/R1yc9DF6
         kNbkhgMY3SmN8srNpovmmv/rTRFONeJo/47hbKttKBOWXoBsL4m8cHmFyHrVsKbJltas
         vBChMhYp2apADBX9R93TGK+Wpg5VJa/vjocwge/ynfQrhTy15Aezv0F89bYpeyZQN54/
         mV1UYrnis3/vKT50g/Cp4RpSIY90G5IMGlem/z5nf6BfQT75Hs6oxaczzG/NWBySEmk4
         aQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782425099; x=1783029899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7E60LJzTlv9sk6UTbJ8U0xvMyb9HT0AFN1vWvqqyfI=;
        b=RP77f1P6Vsfj60SIkMWrhwe0fEiSA57o3XiIEcVHHt+/9NFuQbPNsROCzs0sdpqLsp
         /MSxmnN+Jzsu26d4iSvesJQo4bIB8YaqrqnM14eYRRHJL3uMZ5V7Md7ndj0GzGatboup
         teOzZ/5jPnEND6x4fr53emkJYU0HRq3h9CCB/M2pOKy1m/qPd1YG2BuSQXCnzB70EkX5
         QCxCYAAlr0vPdkUL0qFHMwgJ/mH34TpkNfMaegxiRVpD8lO8YG+k0n6kElcuMPI9sQpm
         jQ0w7hUgDuJzKXN4FK6G7pCF3if5497ikqz0qHMiDvguwjidHuX1LIhKuUUD30o9MczZ
         dZCw==
X-Gm-Message-State: AOJu0YyTUUM4sEmgFp1I4uwxRK3OtQjWQe8iBTMsdwr+rYVPV6a27tMz
	leh6yqBjAB/Y3lv0/+ST+QWpcOmR0KnTf03u1noo7PKvkkNUxDXmH0jOhqDJA9MTibPAj+9UlkJ
	S2lvKfA==
X-Received: from pfdb14.prod.google.com ([2002:a05:6a00:94ee:b0:845:c7a0:745a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:438b:b0:845:4f20:3832
 with SMTP id d2e1a72fcca58-845b3ac13f5mr5149375b3a.8.1782425098917; Thu, 25
 Jun 2026 15:04:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:04:46 -0700
In-Reply-To: <20260625220450.3354415-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625220450.3354415-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625220450.3354415-6-seanjc@google.com>
Subject: [PATCH 5/9] KVM: x86: Move KVM_GUESTDBG_VALID_MASK from kvm_host.h => x86.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move KVM_GUESTDBG_VALID_MASK into x86.c so that it's not globally visible.
As explained by commit 462474588b19 ("KVM: x86: Move misc "VALID MASK"
defines from kvm_host.h => x86.c"), which unintentionally missed GUESTDBG,
the set of valid flags/bits is very much a KVM-internal detail, as the
values from the hardcoded #defines are often captured and massaged by KVM's
setup code, i.e. *directly* using the macros outside of KVM x86 would be
actively dangerous.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 9 ---------
 arch/x86/kvm/x86.c              | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fd712f604636..f24e0de00692 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -212,15 +212,6 @@ enum x86_intercept_stage;
 
 #define KVM_NR_DB_REGS	4
 
-#define KVM_GUESTDBG_VALID_MASK \
-	(KVM_GUESTDBG_ENABLE | \
-	KVM_GUESTDBG_SINGLESTEP | \
-	KVM_GUESTDBG_USE_HW_BP | \
-	KVM_GUESTDBG_USE_SW_BP | \
-	KVM_GUESTDBG_INJECT_BP | \
-	KVM_GUESTDBG_INJECT_DB | \
-	KVM_GUESTDBG_BLOCKIRQ)
-
 #define PFERR_PRESENT_MASK	BIT(0)
 #define PFERR_WRITE_MASK	BIT(1)
 #define PFERR_USER_MASK		BIT(2)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0626e835e9eb..5ee6d0c33009 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -115,6 +115,15 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_host);
 
 #define KVM_CAP_PMU_VALID_MASK KVM_PMU_CAP_DISABLE
 
+#define KVM_GUESTDBG_VALID_MASK \
+	(KVM_GUESTDBG_ENABLE | \
+	KVM_GUESTDBG_SINGLESTEP | \
+	KVM_GUESTDBG_USE_HW_BP | \
+	KVM_GUESTDBG_USE_SW_BP | \
+	KVM_GUESTDBG_INJECT_BP | \
+	KVM_GUESTDBG_INJECT_DB | \
+	KVM_GUESTDBG_BLOCKIRQ)
+
 #define KVM_X2APIC_API_VALID_FLAGS (KVM_X2APIC_API_USE_32BIT_IDS		| \
 				    KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK	| \
 				    KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST	| \
-- 
2.55.0.rc0.799.gd6f94ed593-goog

