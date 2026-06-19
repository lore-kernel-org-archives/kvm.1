Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2726433CEB0
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901118; cv=none; b=PKrftcbQD/HFb4UJDbJrIJgIYBlC35QWQayTxcN+G/BMa8OzQMm7siorNIIgJfNu9xU7HBXruLq+wq9qBKhQQwJcSZPnO93sUkUMsE8QNnHvB/wfjkkC76Adm01sXhxKBhba0Nt7N8NMEAtksQuuLd6QgrXJh+Z1UrKumeq0YYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901118; c=relaxed/simple;
	bh=u3DS0RW8qwKnPXbLqw4zkRsFPGr0SmLyS4ByHV94B/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oyt7Y4/R3DK0oMpSLLuA9CzT3vH7tFQBlWM5bStPe4yJAFUur8KLhIYZrXOipRySaMLXVCOLSZmComYwBmgNaYq4D+n7VVo/a3fXJui5gCWJobfdxh8AjQfRZ7yEmHpdJlnTgoALD9aRYEoA9UhQpDyy5RaVTr7l9+9prEmfc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOi3drpz; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOi3drpz"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6611689dc10so2837363d50.1
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 13:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781901115; x=1782505915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd1mWB6GNyNzgHCKDKsPJpGXztRF54FOFrBz+pWkAI8=;
        b=IOi3drpziRfoWd/KJT3NdR34UPQHXXrOZkgOkvG3WnQ9MXdrN+coIQyYH+93SERPpt
         iYTzXqmM+X4eZ7Dywh9fwj53nXqGG6+TNT12Wtamj4FHUns1o36g5ssyr6Gh7KYRwoIw
         a8HZNY11mj9SAleCt56qNZyL5Cx4qg0Pn9eXSdlyDEbGsDk4eQ3PZ6pCRi3iOLxGWjsJ
         4S0BJdstjC5b9cIuCarC3xa+RmMaoRpX3OLtgiVgp4bQt3fIq75R2JXStuV6aIB/pmfU
         kVtvTByA9A7Ofsk3s1RrpairRXAj0t6MUT2d452g4exk8yheSAeaIjXPz14n6j2cRwl/
         xW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781901115; x=1782505915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bd1mWB6GNyNzgHCKDKsPJpGXztRF54FOFrBz+pWkAI8=;
        b=ADvSBxGTB7ZonedHSWRZByXM/FTCmtOIerIE4yphCvhe5Fgw1gwxlDFpvsfne7Ixv4
         eWTwEKtso2fERCU82zXvcLCZLNWesh7402plxJB3vb4/+0Ng5vZS3YttwLOKrYvSbP2H
         CNF5JvWZ7bZF4w4ar2hMoQ2QI6iYrmkIRfTzZpNlOOpv7RhEp5cuAxejjP1T0H3+Hdny
         t00Avhvo9ffyRNM06gz7UVISVPJZuP9ey12qecP/nzJxtFsVxhJkNQ77m1l1mToPESns
         WJ+7kZK9svXbQnpbSt99IiWEIRBWe+eNs3+gYIp0SscnM1wELJ0n/azeXeXd0WMCdifZ
         wr9g==
X-Forwarded-Encrypted: i=1; AFNElJ/KWSLTZuap28yYRbeo8PMB4ds9wdPZL+l3sOCzUiF0XrD4RlstCKe3sqjigjWplggah4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKi2jAlBxWq7ptMU1J9lpAi0JbxlUmrFxcD1lfUKEwsISOdDma
	ce0nx/yyzfYVL0Ep7bcLAcYYDtMcmZMlvC5hVUg7Sq4JwXJCGgbKHZdP
X-Gm-Gg: AfdE7cmcdAgy8xDxwxIU4ARdEpIsOuRPzbMq2EaLNL8PMnW0HtYIIdeLla4Jn8uKtER
	uJVe1gdH7xkEJI+jNDpRGYYt2AqNMbJRq3c3UEGkJIIIc9mnaBCRVTx05VowWOZNBE3Vd1UwWxn
	HRSRC7IrFj5tVO8CU329aW5jzhodQusrLF4u7k3E7LuqJhFML8Tf+DLvtXOEWOzOZxo9ZXKNrKE
	I4ugXfR21aVUokyVhIQ9+Cwp7B97XyTCuRZ01qsxwCzUedi5BUMckwqbH6bbZMVWeuc00djm+HL
	tftWBQL4N1sVQYiaWigDjZVRDXH3YetoHacuTZmX5NB4Yy4JFega0tzdtdoBzdWvmglzmbCe4Qs
	qbiaYJsWQGkLQzaqnBss7XAPjtB1ceOVWAHZQLNc+jINZIcmHEsrw4XZbjm7+I+lAEGucr3LK+1
	qvBHOCMMJviRyBQfU=
X-Received: by 2002:a05:690e:e85:b0:65d:7db3:5587 with SMTP id 956f58d0204a3-66302f041e5mr4221049d50.4.1781901114833;
        Fri, 19 Jun 2026 13:31:54 -0700 (PDT)
Received: from TurinLinux.. ([37.19.212.13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f015805sm11106986d6.1.2026.06.19.13.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:31:54 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: stable@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	gregkh@linuxfoundation.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	0wn@theori.io,
	mlevitsk@redhat.com,
	jmattson@google.com,
	Nicholas Dudar <main.kalliope@gmail.com>
Subject: [PATCH v2 6.1.y 1/3] KVM: nVMX: Add a helper to get highest pending from Posted Interrupt vector
Date: Fri, 19 Jun 2026 16:31:05 -0400
Message-Id: <20260619203107.2752678-2-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619203107.2752678-1-main.kalliope@gmail.com>
References: <20260619203107.2752678-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit d83c36d822be44db4bad0c43bea99c8908f54117 upstream.

Add a helper to retrieve the highest pending vector given a Posted
Interrupt descriptor.  While the actual operation is straightforward, it's
surprisingly easy to mess up, e.g. if one tries to reuse lapic.c's
find_highest_vector(), which doesn't work with PID.PIR due to the APIC's
IRR and ISR component registers being physically discontiguous (they're
4-byte registers aligned at 16-byte intervals).

To make PIR handling more consistent with respect to IRR and ISR handling,
return -1 to indicate "no interrupt pending".

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240607172609.3205077-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ Nicholas Dudar: backport to 6.1.y. 6.1.y defines struct pi_desc in
  posted_intr.h and predates the move to <asm/posted_intr.h>, so the helper
  and the <linux/find.h> include go in posted_intr.h. ]
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/x86/kvm/vmx/nested.c      |  5 +++--
 arch/x86/kvm/vmx/posted_intr.h | 10 ++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bdc462944..7d8e18dbe 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -12,6 +12,7 @@
 #include "mmu.h"
 #include "nested.h"
 #include "pmu.h"
+#include "posted_intr.h"
 #include "sgx.h"
 #include "trace.h"
 #include "vmx.h"
@@ -3818,8 +3819,8 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
 		return 0;
 
-	max_irr = find_last_bit((unsigned long *)vmx->nested.pi_desc->pir, 256);
-	if (max_irr != 256) {
+	max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
+	if (max_irr > 0) {
 		vapic_page = vmx->nested.virtual_apic_map.hva;
 		if (!vapic_page)
 			goto mmio_needed;
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index 269920765..88cea0dac 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -2,6 +2,8 @@
 #ifndef __KVM_X86_VMX_POSTED_INTR_H
 #define __KVM_X86_VMX_POSTED_INTR_H
 
+#include <linux/find.h>
+
 #define POSTED_INTR_ON  0
 #define POSTED_INTR_SN  1
 
@@ -103,4 +105,12 @@ int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 		       uint32_t guest_irq, bool set);
 void vmx_pi_start_assignment(struct kvm *kvm);
 
+static inline int pi_find_highest_vector(struct pi_desc *pi_desc)
+{
+	int vec;
+
+	vec = find_last_bit((unsigned long *)pi_desc->pir, 256);
+	return vec < 256 ? vec : -1;
+}
+
 #endif /* __KVM_X86_VMX_POSTED_INTR_H */
-- 
2.34.1

