Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C284377551
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425097; cv=none; b=Nlzzo8Pfy0lx7tzuPmzOYAOgQd44FGqEsL3C9sBJfMOspuETnxlbiQCs0pAbjhYP4G66c7RSMfLwN/829D8/sq1sHuvqzUNfGlHVtWS7G9sILAiwo6AymDhvXArKgjQ1QVwNB4iRzTyMhCLitMUIxte9ez1jp1I5RjlJIRHHn68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425097; c=relaxed/simple;
	bh=ohGR4tybGsGwnG8zSyNw7id14okyWjMdatdmOU8g+r8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bW/FEdsHyAZv1n5tQ0S+EA6f7sJgmynMYdma0eMxtKBNAG4cEzm+6dbw1otB6dKR3tsFlvmegiKQQgwsrF3mb5jw8JJWLS2C4p9IP/UF8DuLn8GLeLlQozqI24StllKFVhKC4zAcazoVJirwUcWeQkt/DVvsEs/yAmaZGE1vVy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MPLirnQ3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MPLirnQ3"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c818fe1ea9so103285ad.3
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782425096; x=1783029896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RZDKSZXWGrkG6G3v9NbzY5n6wGj5GjUyTAQDn3wMgSk=;
        b=MPLirnQ3gRZ1WZprOWTvnRSkolqM8LynARtTOQZbx9VLXHjEAa4YagTu1rtx+p8ReG
         opYLra44R4wFumBvVX3uU2Nl3nUP3T9Q1qHYdp7ESet+dUcUxMyk8NGrLYbU6okp+quF
         4y+6KxM0ydW+3s65oxo4X3x8gvakcsWqYQjmPpEeuA/x+pk362LdV26IREIsrvLvH0e+
         MTpQo3wHVhnd9quSIpoj0jg6iWUMlMxtiTO2sMLAummmw3OUoBIdFfTH/W4zdLBAvaN7
         jD9lVxyJsOVsCX3av3KCif9ibQdEw+oKm9+LHVIuiLJCevlUERhtqJLLHh853O846JkA
         v9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782425096; x=1783029896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZDKSZXWGrkG6G3v9NbzY5n6wGj5GjUyTAQDn3wMgSk=;
        b=XeK0upEu8E3eFz9EkO2FudZMyKXQMKE97yhzbxzmRwFCJGqmJUOXI+5NUlSni7v9gB
         EdvGe3BKJRNwqrjb841oxHw7QDG3qZYFbhuFTrFzaWaLXzKqZlDH51YugvaH3jSNPMK3
         KnkGmOs6BLfno/qR75KRPkckCVPuQFpQ8HS7cUsxzPtnspyJboG88bx5y6vdj7lr6res
         rDOxBbdOGjUn/Q4QqKBKY4F/zak1sDopMFVeteIAhXvnbU7iuf+SFVbEp2SJcTpRpcEW
         IdQB8AX8VH1Dear4t3N+MWgNXHqbiJ8tkFM49HsUPijRqi+FYbU60HP3zH/N1V5/du2k
         ba6Q==
X-Gm-Message-State: AOJu0YyL6f7XBwmA2YAeW1xB+rs8L8pauS8o91qOVC017Hu4PmARG0/k
	H6/eAG0YRfS6jDjCregRPvK/i4Es1Qjnj9wwdW0ZAgj0CeRSwwXzDo3ORy1r7i9n8sPmXz3iZnc
	bTDdvhQ==
X-Received: from plhd7.prod.google.com ([2002:a17:903:2307:b0:2bc:aee7:306a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec91:b0:2c0:a711:539
 with SMTP id d9443c01a7336-2c7fc65bf6amr39666525ad.5.1782425095342; Thu, 25
 Jun 2026 15:04:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:04:43 -0700
In-Reply-To: <20260625220450.3354415-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625220450.3354415-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625220450.3354415-3-seanjc@google.com>
Subject: [PATCH 2/9] KVM: x86/mmu: Annotate tdp_enabled as being read-mostly
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Tag tdp_enabled with __read_mostly as the variable is only ever written
during vendor module load, same as all the other global MMU variables that
are handled by kvm_configure_mmu().

Opportunistically annotate the tdp_mmu_enabled and eager_page_split
declarations with __read_mostly, to match their definitions.  The compiler
will warn if there are conflicting annotations, i.e. there's minimal risk
of the declaration annotation becoming stale.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu.h     | 6 +++---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index c9f628b97dae..85bc503de1b6 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -6,14 +6,14 @@
 #include "regs.h"
 #include "cpuid.h"
 
-extern bool tdp_enabled;
+extern bool __read_mostly tdp_enabled;
 #ifdef CONFIG_X86_64
-extern bool tdp_mmu_enabled;
+extern bool __read_mostly tdp_mmu_enabled;
 #else
 #define tdp_mmu_enabled false
 #endif
 extern bool __read_mostly enable_mmio_caching;
-extern bool eager_page_split;
+extern bool __read_mostly eager_page_split;
 
 #define KVM_MEMSLOT_PAGES_TO_MMU_PAGES_RATIO 50
 #define KVM_MIN_ALLOC_MMU_PAGES 64UL
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6c13da942bfc..af3820136f7c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -104,7 +104,7 @@ module_param_named(flush_on_reuse, force_flush_and_sync_on_reuse, bool, 0644);
  * 2. while doing 1. it walks guest-physical to host-physical
  * If the hardware supports that we don't need to do shadow paging.
  */
-bool tdp_enabled = false;
+bool __read_mostly tdp_enabled = false;
 
 static bool __ro_after_init tdp_mmu_allowed;
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

