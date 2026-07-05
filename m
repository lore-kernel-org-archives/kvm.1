Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A5220FA81
	for <kvm@vger.kernel.org>; Sun,  5 Jul 2026 05:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783227898; cv=none; b=RzYlZN4IkW3owqCR5PvSlKxIEp+KRhGJ14lXpVVkLKYSmoO5H+jBwd++VypbGuqrjMK/wouOl2PEyTvMcHwSR1xJLhpA5FCLKhi+e5dnfapp/rYMGclgHpg43MDbCR6MdRzDIli8mK+rHUPrsJEc4gpcY9E6Xl+YihR4o+El7yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783227898; c=relaxed/simple;
	bh=OiRKjNIJSDr2DR4ICvpEG+4MgnJjzdNYg0TEfBKxvN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uozwktajmRBiOyMKBiX7+knH1A1zyQM0XZTn7HyyUscYEQtJFpomLZgSP7/ayyot7fWvnNk/qE7Br4Gdx6ClrjWgXINmv8Ma98wjyqZiC1EjTrPp286L8zkma+l9ysvrm/7I5LJECVdeJ9799HbF++6Rc2DARHRAmCLvJ9ZKeLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR7iRYam; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR7iRYam"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caf4496889so7577055ad.1
        for <kvm@vger.kernel.org>; Sat, 04 Jul 2026 22:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783227896; x=1783832696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ELfc03vpGv3pMYS2ikJpXiGgz21KVOnLGkx55HIba8=;
        b=hR7iRYamYQCAEIF8Xy0O4CU1lX+I+H7ZQvtdFV1m/a+AT1gE964aEnk17PPYWzvznu
         emkziMcUh3E/CC3nJ+UwoNdoaUcJ41wE0O5GWLLn9/4QGZaAn0cuf1MEY5iFU/rMsq7x
         y9inUzcJrdjHQA9eqc74gbGnvfZFtOdZVEMRfYTl7VxWispoBfV9WBWkLneAqg9u4GCS
         7ctvkB88gf8wOUVNIsPhWDDQZ0VPB5boo1TOhZmjLwuOgKR0nPgzNl+bjsJzmadbYjYu
         +BEEkxKalJPLgQ0D6GRJHnC9/k5FGUr4anbc2ZRx72i4PVCifWshnq13lEtL8wMfnRpL
         6+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783227896; x=1783832696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ELfc03vpGv3pMYS2ikJpXiGgz21KVOnLGkx55HIba8=;
        b=F+pWH+YGwYknVWluDPAdF+EWHxaAHwA/3S9yYcvsy14UnbOE8xuv35SpfO9nrdtSOb
         bHTNdZTPeXurNEiTkDZQXfbNWsrk5JCKDm2hZRU7OmJXpvpQDJTCtTgBluZVt6fH/7Xl
         +8rONHEq0Wu0Tq6d+4Xxsn2GLOxWXjf6b9b/BwGUwHext24C83/2uCp8yfotfnE4Nj1t
         OX2Vhw1N5dTzjs/Dg4JDzFbB6gVH7MhODmDgO73FG3UhfljTuJjB1hd/UnNML0Ehj4Ce
         qsQCUOlQm0pnR8wqmwOZnounVaC2x3+wL2os8ZrJIJ1ir83jRFcZ5CCkMxr2LlFkaVk6
         Mr2A==
X-Gm-Message-State: AOJu0YwW2EDijk5gm4MdBfLG2+FlWDnPW4kg58LwTtnxB5JpEuIXzZAG
	9T4XS3PHnpQ0bscB3KT2byfaMmGGXtRwEeH/ja0gMxi/g6VPgHH8d8Kg
X-Gm-Gg: AfdE7ckqRHk+TjOrr2+Kw8NhDJrAIYzCv1nr7uu5q6qpeOXA2Kxh4mtr9LViC0K7AnC
	jnkz6vY6uZ8iLQ2/QR0VhdhcuXTw0QA7d0/+sxWuICLt8uE/kkT5y/+GbblN7T9kn7dNVdn/bvV
	q7PUz3ifl7fIkMheIw1AFduC1t/yNVxb31SneKuTlXtP4S3xhRVKs95ODQQ97vS95AtBeDCjMbv
	o21i7UskyFWlv9oZtzN74snHLU49IKSf1NfWeLwFfJmys4+/fSt5hjCgEhIcuTJ1IfblFmlK9gm
	ddxmV4MQ+V/NXBSwXXOQd2GwVhkiHlr9BB8SfctUY6uYePtLDONXKW0VGUEXci1hF+0VT9FYxyM
	CQor5FLSe0b1nxcp0kaT3JQbUpQatEH+fnU8834BCTygn1PFCZbsUyY9qfYAhp8fNgTMd/J71Q1
	v8/tLikG5w5Vkdt4yTs2ivNKi/IVZlZVPOXc9QpMZ5T/KpSH3zavr9HCarhgv0YQ==
X-Received: by 2002:a17:903:41c7:b0:2ca:f417:396b with SMTP id d9443c01a7336-2caf4173bbemr56506085ad.3.1783227895712;
        Sat, 04 Jul 2026 22:04:55 -0700 (PDT)
Received: from fedora.tail0ac356.ts.net ([152.69.221.40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa65asm39860184c88.6.2026.07.04.22.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 22:04:54 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Xuanqing Shi <shixuanqing.11@bytedance.com>,
	Zhong Wang <wangzhong.c0ss4ck@bytedance.com>
Subject: [PATCH] KVM: x86/ioapic: Cancel eoi_inject work before destroying vCPUs
Date: Sun,  5 Jul 2026 13:04:43 +0800
Message-ID: <20260705050443.1331662-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_ioapic_eoi_inject_work() re-delivers a throttled level-triggered
interrupt via kvm_irq_delivery_to_apic(), which walks kvm->arch.apic_map
and dereferences the destination vCPU's APIC.  The work is cancelled only
in kvm_ioapic_destroy(), which runs after kvm_destroy_vcpus() has freed
the vCPUs and their APICs.  kvm_free_lapic() does not rebuild apic_map, so
the map is left with dangling pointers, and a work item that fires during
that window reads freed memory:

 BUG: KASAN: slab-use-after-free in __kvm_irq_delivery_to_apic_fast (arch/x86/kvm/lapic.c:1248)
 Read of size 8 by task kworker/3:1
 Workqueue: events kvm_ioapic_eoi_inject_work
  __kvm_irq_delivery_to_apic_fast (arch/x86/kvm/lapic.c:1248)
  __kvm_irq_delivery_to_apic (arch/x86/kvm/lapic.c:1343)
  ioapic_service (arch/x86/kvm/ioapic.c:492)
  kvm_ioapic_eoi_inject_work (arch/x86/kvm/ioapic.c:525)
  process_one_work

 Freed by task 153:
  kvm_arch_vcpu_destroy (arch/x86/kvm/x86.c:12871)
  kvm_destroy_vcpus (virt/kvm/kvm_main.c:489)
  kvm_arch_destroy_vm (arch/x86/kvm/x86.c:13402)
  kvm_destroy_vm (virt/kvm/kvm_main.c:1302)
  kvm_vm_release (virt/kvm/kvm_main.c:1363)

A guest arms the work by EOIing a level-triggered pin 10000 times in a
row, so the window is reachable from guest ring 0 whenever its VM is torn
down soon after.

Add kvm_ioapic_pre_destroy() and call it from kvm_arch_pre_destroy_vm(),
which already stops the PIT and the kvmclock/MMU workers before vCPUs are
freed for the same reason.

Fixes: 184564efae4d ("kvm: ioapic: conditionally delay irq delivery duringeoi broadcast")
Reported-by: Zhong Wang <wangzhong.c0ss4ck@bytedance.com>
Reported-by: Xuanqing Shi <shixuanqing.11@bytedance.com>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 arch/x86/kvm/ioapic.c | 8 ++++++++
 arch/x86/kvm/ioapic.h | 1 +
 arch/x86/kvm/x86.c    | 1 +
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index eed96ff6e722..51b7b0807bb6 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -740,6 +740,14 @@ int kvm_ioapic_init(struct kvm *kvm)
 	return ret;
 }
 
+void kvm_ioapic_pre_destroy(struct kvm *kvm)
+{
+	struct kvm_ioapic *ioapic = kvm->arch.vioapic;
+
+	if (ioapic)
+		cancel_delayed_work_sync(&ioapic->eoi_inject);
+}
+
 void kvm_ioapic_destroy(struct kvm *kvm)
 {
 	struct kvm_ioapic *ioapic = kvm->arch.vioapic;
diff --git a/arch/x86/kvm/ioapic.h b/arch/x86/kvm/ioapic.h
index 3dadae093690..5bfbae63f368 100644
--- a/arch/x86/kvm/ioapic.h
+++ b/arch/x86/kvm/ioapic.h
@@ -105,6 +105,7 @@ void kvm_rtc_eoi_tracking_restore_one(struct kvm_vcpu *vcpu);
 void kvm_ioapic_update_eoi(struct kvm_vcpu *vcpu, int vector,
 			int trigger_mode);
 int kvm_ioapic_init(struct kvm *kvm);
+void kvm_ioapic_pre_destroy(struct kvm *kvm);
 void kvm_ioapic_destroy(struct kvm *kvm);
 int kvm_ioapic_set_irq(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm,
 		       int irq_source_id, int level, bool line_status);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fd1c4a36b593..3c03fd75c93b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13374,6 +13374,7 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
 	 */
 #ifdef CONFIG_KVM_IOAPIC
 	kvm_free_pit(kvm);
+	kvm_ioapic_pre_destroy(kvm);
 #endif
 
 	kvm_mmu_pre_destroy_vm(kvm);
-- 
2.54.0

