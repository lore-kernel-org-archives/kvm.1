Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2B31B812
	for <kvm@vger.kernel.org>; Wed,  4 Feb 2026 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196392; cv=none; b=ocZAlTZaxG4xy3NaO4J8Pmwz/zos2g+Z4M1i9nXJw6EcJA47hkoESO1sXMJaakjQ/yJ4wHDm+tZjZHMAq+JMWN4Ywkl5i+kdkwVx9upxMGmlJ1Q2d0RwrqFvIa5FJWM+29/w1WVpb47cKIfaemkEWtgik33S4mONF9z9Q2ujCsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196392; c=relaxed/simple;
	bh=LaRQ0vCws0uuqMSC9/0w2IvKxe/d71c4FZtQGXI+Nhc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QyJv6wCgAZmlNq6awN2/eqwKjrtxWTU106q0YE9LGQCVoVN6ji8JOQIxnDFnRKLeEXRHsx43Dz6GTmD7kjZOJWyMOCmaxJ7zx32mli5Ym2fncjpO9+GP9iOgj1Xm7oH9MikK1HSQfFW0bKozUvnaIQgDWm0Gk9ZYJSM4w+ypuoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, <kvm@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] KVM: x86: Fix SRCU list traversal in kvm_fire_mask_notifiers()
Date: Wed, 4 Feb 2026 04:12:06 -0500
Message-ID: <20260204091206.2617-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc5.internal.baidu.com (172.31.3.15) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

The mask_notifier_list is protected by kvm->irq_srcu, but the traversal
in kvm_fire_mask_notifiers() incorrectly uses hlist_for_each_entry_rcu().
This leads to lockdep warnings because the standard RCU iterator expects
to be under rcu_read_lock(), not SRCU.

Replace the RCU variant with hlist_for_each_entry_srcu() and provide
the proper srcu_read_lock_held() annotation to ensure correct
synchronization and silence lockdep.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/kvm/ioapic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 2c27832..793c9db 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -327,7 +327,8 @@ void kvm_fire_mask_notifiers(struct kvm *kvm, unsigned irqchip, unsigned pin,
 	idx = srcu_read_lock(&kvm->irq_srcu);
 	gsi = kvm_irq_map_chip_pin(kvm, irqchip, pin);
 	if (gsi != -1)
-		hlist_for_each_entry_rcu(kimn, &ioapic->mask_notifier_list, link)
+		hlist_for_each_entry_srcu(kimn, &ioapic->mask_notifier_list, link,
+				srcu_read_lock_held(&kvm->irq_srcu))
 			if (kimn->irq == gsi)
 				kimn->func(kimn, mask);
 	srcu_read_unlock(&kvm->irq_srcu, idx);
-- 
2.9.4

