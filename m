Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B22E65D
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309029; cv=none; b=S+shnIRxHuvRwfQxiF6l1F2fnZpbgnCN7dG2kbzGvSzHGEa8joYBbQUDbHzrfiIRXUMextz7PSqh3NHIDNFKupZ96aa1bg9FeK6H7JBdbOMkMp9yztbrqBLfc+OgYe031aXQF8ZsaA5znW08wpDU7bEZp85lu0bNhAEymU6RC9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309029; c=relaxed/simple;
	bh=r9q9hpwN0VGTdKZbE/8pz4eSB+QbZhbZeIXVyR5vDbY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m5dnuS12oYMyADyvnWtnc/oG5lgcBeMXWnDQ4+RPFVBvUAWxB6BPBHpvRftVlhJStS1jjkOTahBnpWBrdnzBSFCzmAmYQUi98WM2aGJU3IsMg88PF+dRUwv9IBHTAVYGSxDS56NcWBCn0JswFaBik7xohsv67AD9qsbTOnj1mnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fIOynNjK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fIOynNjK"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c2c98c1be2so11613455ad.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309021; x=1781913821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow3W9VuHSZn9bHmzWxOY9lizwynA2XJRnpovH/K3Yuc=;
        b=fIOynNjKA7oBKXnp0TgPJ3gL7jz4icCMVyfUtSCgvEd9su5n2S9SQRflWpnLOcwcJm
         gf6pobUbbnIbSV7CX+zoe+zpOx4sdpVpsJau5MgwsSzA0+XxbxbctX1ht0+PCg5EtXGb
         2CSLha4mTaesw80QQ93r2sEo2gnoAHlkTbFJndddXt51sO/22AJ4iDhoCi6Nvxiq8YT8
         ifNyskR0UmDBTT+HBVdCr29beUgGH9aAWQNynxbg4Jp5sbyzkjYv9/uxmfdgckn71Zha
         MYlfr2h/66ahaA9fVD81Vx8Y8v/6SLS11nvgvGpk/+jPPtE7JNDTUXzE7RoJVzZf6Wo5
         qf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309021; x=1781913821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ow3W9VuHSZn9bHmzWxOY9lizwynA2XJRnpovH/K3Yuc=;
        b=I4mYtCCrIJr0eT1KECu5fN44RAjhuRDAMJSDiwgN2ulRSacUddyBVNqwCPabYMhbUY
         hpdfiJKMXoZB6y4J3NprBE1tny/gmeCYBHM+l2Fp+IkSurUjGuNVRXihpGwgfETahRTV
         Jijbkqn7SSGh4ZDk1nb3HtEgTwHR1rrRppL2NJZsSM74z10qFa3F9lw//lVjPLVtx2py
         Rydyb2T7Cg70kSCI/M/FYL5AiXLr2UV8DzO6MNeXtZm3LQJ9LPrBbapcESs6sTumOjrn
         R7LWhXDIu5SPw5JCyGPVbtpLW4YExPUUJoXvJ0BlTSH1NRoHRJ1m3lbyUUwtksh2jfvN
         UuHQ==
X-Gm-Message-State: AOJu0Yx9paMhih9KsPJMFBEGvlsutzy6D3MULY91TQ5ghO4PVQ9x0HFL
	JYRk1vA/nTLXX9LMb1cfcE8FWtrpfsSoFVOq/kpuoUtrQAiKQMQeOFH5/yz6m2w2qF+ah7imo+W
	Pn1ndvA==
X-Received: from plgn13.prod.google.com ([2002:a17:902:f60d:b0:2bc:aee7:306a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5d0:b0:2bf:800:19f8
 with SMTP id d9443c01a7336-2c4134ec57fmr54054985ad.17.1781309021276; Fri, 12
 Jun 2026 17:03:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:06 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-8-seanjc@google.com>
Subject: [PATCH v4 07/30] KVM: x86: Swap the include order between x86.h and mmu.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Invert the include ordering between x86.h and mmu.h, and move
mmu_is_nested() to mmu.h where it belongs (mmu_is_nested()'s placement in
x86.h was solely responsible for the existing ordering), so that x86.h is
not included by most KVM internal headers (but includes them).

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu.h | 6 +++++-
 arch/x86/kvm/x86.h | 6 +-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index e1bb663ebbd5..28fca48dcf64 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -4,7 +4,6 @@
 
 #include <linux/kvm_host.h>
 #include "regs.h"
-#include "x86.h"
 #include "cpuid.h"
 
 extern bool __read_mostly enable_mmio_caching;
@@ -300,6 +299,11 @@ static inline void kvm_update_page_stats(struct kvm *kvm, int level, int count)
 	atomic64_add(count, &kvm->stat.pages[level - 1]);
 }
 
+static inline bool mmu_is_nested(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.walk_mmu == &vcpu->arch.nested_mmu;
+}
+
 static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 				      struct kvm_mmu *mmu,
 				      gpa_t gpa, u64 access,
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index b7d3b54cde15..a0e68eaf1f80 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -6,6 +6,7 @@
 #include <asm/fpu/xstate.h>
 #include <asm/mce.h>
 #include <asm/pvclock.h>
+#include "mmu.h"
 #include "regs.h"
 #include "kvm_emulate.h"
 #include "cpuid.h"
@@ -210,11 +211,6 @@ static inline bool x86_exception_has_error_code(unsigned int vector)
 	return (1U << vector) & exception_has_error_code;
 }
 
-static inline bool mmu_is_nested(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.walk_mmu == &vcpu->arch.nested_mmu;
-}
-
 static inline u8 vcpu_virt_addr_bits(struct kvm_vcpu *vcpu)
 {
 	return kvm_is_cr4_bit_set(vcpu, X86_CR4_LA57) ? 57 : 48;
-- 
2.54.0.1136.gdb2ca164c4-goog

