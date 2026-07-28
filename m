Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5FC3FB077
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231230; cv=pass; b=uNx2lPzz0W4anU9LcjD+7scp8Jx+uFmvgNtHq2ID9XEQgvAuPcMxhirjX3tP1uKetHv0wRIGMOCdCPSH6YA461dvwlMjC2CKI5zm71xURcnEB9NNutAU5F+XnMyM8BXImujle40NxCh29lXZ3WivUrTPDiSAaFvYw0eepa41w18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231230; c=relaxed/simple;
	bh=J1o4dHV7U+1Ew0UtbcbsKTeggjMtHCkXXVkPjnbCYUA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Oujy2SEjpclIjX5WYCsNsb9UbQBwoMLjI7SXwt3tvQNCTYScF85CdhKq5ZBWppRgF24S+etV+hFLlZKF52fc5SRyxS4EMLKoAUGrVGN8O1L2VYykafr4BZgp93AUCtHSbrF9ZJOrw1va8ZDSSW1xmTqWatKrgpvWvUr1LTB9/Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW2a+eI2; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW2a+eI2"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15dd4b9132so531203866b.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 02:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785231227; cv=none;
        d=google.com; s=arc-20260327;
        b=HYcSdEucTx9FHaadC20rXBgpgnxgGLIzQ4MLvYM5ev2758dZYaYYNKMzFY8Ey5+2EY
         pa8wbSXqZGmhZJ3snpeybisSkmXKBmyVKZ9se/VHCqGCsJQWMzOyq0Thqkyt0A2ThfKF
         4fBaIHJkNZrQrK5EdCpM9BrUDEdEzsqDJTEP1/ZmrfVSi/rhGm9Y6LbDJu43wVlUlDul
         BjxUDEEHTGaNrvskK0svukFJcSgRU0nNmEOauCJAZSvQZ/2OWfPu4PoFFDAZ3fvgnTkt
         wHpm6t2XtAylYm+Sebf//Dqj1dCAJ3J69RTr2+0P163fnlrgJ3MIcq83NggD5aMG+ozf
         Nlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7anTwoJ6gAREbTJx72Mm68Sq3jGu+s8EJmYIrX7NAK4=;
        fh=JdtqOogSoO4kC4psKo2zydoO/hSxNBc8RpLPucSU1/A=;
        b=nkJei8EISqhphMFIjH6669eoGKxSl/3QvIl4qCv3TsKxnC5eN0XmhCKcIRJEDDLM7e
         KGqgjK6fJyEW9dwRontg4aX3iF7eURnRnnHsMq/RFHUjqsfcs4VCacXcqVStWnp5CnWl
         Z9Ra25fq1vFBxIs7nS7yK8AIIVpGdRTRDVmlKOczTSDpzGuR/SLh6wwQ6k0wsOr4DaVa
         9qpbd9xvRGvNBFDsEqEmiW8m4Q4GG3gGhT4StzLzyf7nRXQ+EP4q4yNVoRVgELTiCAR3
         eVuvNuU3CHPchh7U6FVGrNoXpyi742rtiv8CA+H5yiQfaxhdzPda/jyC+OTDLUfMxpiM
         HGPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785231227; x=1785836027; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7anTwoJ6gAREbTJx72Mm68Sq3jGu+s8EJmYIrX7NAK4=;
        b=LW2a+eI2TJQTLrYVOvD0GvfNIYm2AE0KZinPagZ7lXYUSVjCvB9fFchLJo7BsDMbEO
         S3Dk/L9mJ2Vx35h/YozZlD5wcM5PoG8p/fIjeuHsLNpfeHyk1lq5xrWZhkONjztxe0dz
         fofYGiAgGn+ZoBB4CDMowFPwu/AF0FiO3ampz07O5gdr6ztYdP28uAN8k7xE73JX7BIN
         /UpQsWB+jNvMwWUJIQukTAW3A7nIJbOZo7mMnBg04jcNkpc48Ma2GjiXeA17k8iVurRr
         H/v88ARIj81pUzVRdlTh3+GA3Kz0zmo5JyQ4YSx55XSJLkAKtcKgnin5V6fn5oTuAIPV
         4isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785231227; x=1785836027;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7anTwoJ6gAREbTJx72Mm68Sq3jGu+s8EJmYIrX7NAK4=;
        b=Zj2xRDA5Sfn7dDxcqfGXzH4+Qc5rwJRpQqyyedGRbvJpjspBkyNDQGDXx0JLnd6PU4
         wMTf8Qw4lrocAdrP0tz5yVS9PmNlPDTYLvc8lIkLj1PRqyPhyEvbTAa5pt4GLmZMi3FP
         erjErYKGF8rUuldV0IEtyxFA+nuvTqW5qgJpQ5RQ5iQRxPtKeKiBYBa2CcrYvw/xXDr9
         emfhS1XuMHulwR0hZic7E1kXacwYsOqSMKs8/HrxA+4+9t444NCBtgClt+In4VzuikoI
         yjNe2ALKhJakDBG+bD+r+/oPk4Q1pBesswu94CYrgQTgo1rHRRseZxEZI1BecYlR2KC5
         guWQ==
X-Gm-Message-State: AOJu0YyCWTbYZh3oh+xTTXFsZ2ceHwhWuAmW9RieWIHHu/n8plt6jUBI
	qw/zBN3SLB7PpnElrkWiyn3wGfm604D6UgdT/4PPYkz/eqOVxjZ0N+T2pW6eE3+OSMQvpxhE7jF
	r7mllAcOJ7F4DTrQTQ0SKmRJcy1lJPQ==
X-Gm-Gg: AR+sD11aS5FpznIDR+F7JYsvoupRzlM3xLquNOm6DR4CV0Sb/uZ9WJkCFSkHvyXNuDO
	XrXb4j9Tx63fNIf5V8h44KECAL7764zCOlTHMprqolKhtL3564nySXK25ffHIQ8BWIGdylEbkOv
	fNAHiarThbjFsQuF9vxKAx87M70271LkqO9G+WI5ssSpravzooV0RltVnn16G1cW3aovjraH7Cq
	2L6cVhfE37EioV6AZRdN+G8luGbF9qZ871Jf53zv4PB0pG3wRPYkno5b05JmRCl/T89r0i6e5j6
	4wc2lpz9EKxR86Z7i0xau6I6T2E0vWMQVWPuR9Etv7iTjgCtHdvlUS1egZCaXjctzIzlvWHR/g=
	=
X-Received: by 2002:a17:907:9414:b0:c1f:6822:945a with SMTP id
 a640c23a62f3a-c1f7249e8f5mr72893966b.57.1785231226472; Tue, 28 Jul 2026
 02:33:46 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 28 Jul 2026 02:33:45 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 28 Jul 2026 02:33:45 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Myeonghun Pak <mhun512@gmail.com>
Date: Tue, 28 Jul 2026 02:33:45 -0700
X-Gm-Features: AUfX_myIF7_i5vRck_Vtzi3_UtBGZs0pOxtIQT05nTQ-s69f71oGHbv7j0_VJMw
Message-ID: <CAGEsz8FbPu_DtOkTij0RvBriK1R0FspzEU6Oef0Gers-gS1d3w@mail.gmail.com>
Subject: [PATCH] KVM: x86: Cancel IOAPIC EOI work before freeing vCPUs
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, security@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The IOAPIC delayed EOI injection worker dereferences local APIC pointers
from the VM's APIC map.  Since commit 17bcd7144263 ("KVM: x86: Free
vCPUs before freeing VM state"), kvm_arch_destroy_vm() frees vCPUs and
their local APICs before kvm_ioapic_destroy() synchronously cancels the
worker.

Consequently, if the delayed work is pending when VM teardown starts,
the worker can run after a local APIC has been freed.  Generic KASAN
reported:

  BUG: KASAN: slab-use-after-free in
  __kvm_irq_delivery_to_apic_fast+0x7f6/0x840 [kvm]
  Read of size 8 by task kworker/3:3
  Workqueue: events kvm_ioapic_eoi_inject_work [kvm]

The allocation stack contains kvm_create_lapic().  The free stack is:

  kvm_arch_vcpu_destroy
  kvm_destroy_vcpus
  kvm_arch_destroy_vm
  kvm_put_kvm

A ring-0 guest can arm the delayed work by repeatedly acknowledging an
asserted level-triggered interrupt, and can then request a reset that
causes an unmodified QEMU process started with -no-reboot to perform
final VM teardown.  I reproduced the UAF on current Linux master as of
2026-07-27 with unmodified Debian QEMU 10.0.11.  No guest vCPU
hot-unplug or post-launch host-side teardown ioctl was used.

The regression first appeared upstream in v6.14.  The same ordering
change was backported to the v6.12.y stable series and first released in
v6.12.41.

Cancel the delayed work from kvm_arch_pre_destroy_vm(), before vCPUs and
their local APICs are freed.  Keep the cancellation in the final IOAPIC
destroy path through the same helper so that partial initialization and
error paths remain covered.

With this patch applied to the same KASAN build:

  - arch/x86/kvm modules build successfully;
  - scripts/checkpatch.pl --strict reports no errors or warnings;
  - 500 complete stock-QEMU guest trigger/teardown iterations completed
    without a new KASAN report;
  - 50 iterations of the direct KVM race reproducer, each with 64 vCPUs,
    completed without a new KASAN report;
  - a stock-QEMU kernel-irqchip=split smoke test completed successfully,
    covering the no in-kernel IOAPIC case;
  - ftrace confirms kvm_ioapic_pre_destroy() runs before
    kvm_destroy_vcpus() and kvm_free_lapic().

The source reproducer and full KASAN report are available on request.

Fixes: 17bcd7144263 ("KVM: x86: Free vCPUs before freeing VM state")
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 arch/x86/kvm/ioapic.c | 12 +++++++++++-
 arch/x86/kvm/ioapic.h |  1 +
 arch/x86/kvm/x86.c    |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

AI disclosure: I used AI assistance during the audit and am treating the
issue as public as required by Documentation/process/security-bugs.rst.
The reproducer has not been posted publicly.

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 757667fb2bfa0..6133061e18f10 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -741,7 +741,7 @@ int kvm_ioapic_init(struct kvm *kvm)
 	return ret;
 }

-void kvm_ioapic_destroy(struct kvm *kvm)
+void kvm_ioapic_pre_destroy(struct kvm *kvm)
 {
 	struct kvm_ioapic *ioapic = kvm->arch.vioapic;

@@ -749,6 +749,16 @@ void kvm_ioapic_destroy(struct kvm *kvm)
 		return;

 	cancel_delayed_work_sync(&ioapic->eoi_inject);
+}
+
+void kvm_ioapic_destroy(struct kvm *kvm)
+{
+	struct kvm_ioapic *ioapic = kvm->arch.vioapic;
+
+	if (!ioapic)
+		return;
+
+	kvm_ioapic_pre_destroy(kvm);
 	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &ioapic->dev);
 	mutex_unlock(&kvm->slots_lock);
diff --git a/arch/x86/kvm/ioapic.h b/arch/x86/kvm/ioapic.h
index 3dadae0936902..5bfbae63f3689 100644
--- a/arch/x86/kvm/ioapic.h
+++ b/arch/x86/kvm/ioapic.h
@@ -105,6 +105,7 @@ void kvm_rtc_eoi_tracking_restore_one(struct
kvm_vcpu *vcpu);
 void kvm_ioapic_update_eoi(struct kvm_vcpu *vcpu, int vector,
 			int trigger_mode);
 int kvm_ioapic_init(struct kvm *kvm);
+void kvm_ioapic_pre_destroy(struct kvm *kvm);
 void kvm_ioapic_destroy(struct kvm *kvm);
 int kvm_ioapic_set_irq(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm,
 		       int irq_source_id, int level, bool line_status);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index afcac1042947a..9b4e89cd8169c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13432,6 +13432,7 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
 	 */
 #ifdef CONFIG_KVM_IOAPIC
 	kvm_free_pit(kvm);
+	kvm_ioapic_pre_destroy(kvm);
 #endif

 	kvm_mmu_pre_destroy_vm(kvm);
-- 
2.47.2
