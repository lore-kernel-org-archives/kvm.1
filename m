Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304136;
	b=YmkYvZYpC8W0JMaYAn8VMe39rfr5qFJSgvuSusGe5QUIdkZA6KT2eazA523uTzs2vAGq
	 4bC9aJDRQXOlwWd/ah4hTYM+IAD6wf0qeMb6/hKCcuokdz4tW9LpFREW2bg2VWX9sHij0
	 T6V1FZZ1s+HdivZaKbTEVNNg5ZCmUI9mnyck9O25VWsy4RVLuJWCAkRr61Bj54Zdlopm6
	 hyyNHhwpkZvIH5pYDmnbWbiHdEyDpnvtNh5BxdFlEEGE8zVsb2UMNdvk7pJOGIRkCNeJC
	 4NVPrfip8ma+nsABazc+jAMKeBohCEBqQT07lrFy4c4tPB8huazIZmS0xx07ZFVK3pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ToZEVjNJ0PTS0mMKreAcFedmCPAxwnkNokZhg87lyPA=;
	b=EnANjPWfuleV3QrLJUOqxqfaXWgX4F4nHu5gf13EsV3BY5cAwbug68uH0Fk7FotZtaKp
	 8wKb5gOr23BCrO5Xy1kE4qG0fVl4jRXz7ZusPkl5c4X9+baJzFOfDRirrdRxKocfQO2pv
	 vD8lhvFkzB15a4ZmkxFMNGNh1ktypDAZ2Jm6hSnb/VWyR1H9AsbzE5DO8OP+qT9deK4YZ
	 0NOLF58ctpV+nY3/Dw0elz53Rq1mc7t0s/WPQXtc+kYRLFAwV9bxL0nREN4OFPMTbMLRA
	 NJRGfFEKDqiZxwfnZ8CUZwilGaor4ujy9wLF1dcCYCutdE/ij8dOL4QUXry6YVsJDlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvz.org;
	spf=pass smtp.mailfrom=openvz.org;
	dkim=pass header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=i69iXx1r;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA2606A31D
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 20:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39DA2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=i69iXx1r
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a210470b49so21742795e9.2
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1793304134; x=1793908934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ToZEVjNJ0PTS0mMKreAcFedmCPAxwnkNokZhg87lyPA=;
        b=i69iXx1ra30cdw3Wzg0EB2AItA+4a4gdg+DYEuUs7L1ectKkJUogAWvyDaVN86G3Eu
         v+JpLjSZskJASW1DEHuMKsrWpSHY+4WCqOhx3j5UlfbyKAkRBBFSq8F4X3zz9zoV+GBa
         WbB+NqS+zjFUYPh3rGWHd5X8cVrMPn3LoY9+yXT1fmhGLlu93emY3G6S0ty5wDwK+TNV
         nCmu+w5EGIj7iyGcGMHSkoeQ0po5w/q67XOYvps7rtSr5P44Hp8ybB00x6MwvaI5WOtt
         dcbv99KJ6+fdKRD2IVd+mhhAPcA8ojpEBY/aauf6n8SislG4mGKHL45dxcEzhb0ZUz3K
         9o2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793304134; x=1793908934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ToZEVjNJ0PTS0mMKreAcFedmCPAxwnkNokZhg87lyPA=;
        b=xn777Kfp5aZ0Je+q9eMyVLQJG98BT+/LZDS7p6A/3kuv8ApchjVpzi4g3WEB/4PbsE
         10hQ7RBH0ebpvVunzbHtC0fqfojkn9hGMxa7FfN94T4YriYOOIf5SktKxEcutfl1YpRg
         WR4q2PPWbjIjSATorWv0DplegU5tXfHS3U79UMoK6iu6PBPA2zGOcOM/XzRegjK5NRXu
         rTFw4kKXUAOZ/PI/aTqFumRRw1ZsXqhdq2RgooKEtDoce+zHjH8LzhPKfx3yfaLIdLOC
         Sb6W3s0Ljq8PgXnF1cJXeEEm12pK28yO125MoOE7t59VWzRviP2oVbJBFh+cXDF0pQ/f
         LsQQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/0Te363vqp1bjwCEnh5Kh33Za+3CZl1pBuUvC8bPxzAqOHzL+F7f14smTBc4uANpw9xU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtvS8/T2GmVwT/pC4JKbcM50jF23tl6kjLWRgprWb22dLVAR1X
	GW7LnnPthu2847HIziyXP8QPHfUNUooReMPFwxj8mptex0wrpnj66FQsOHu6xHSNBVE=
X-Gm-Gg: AYBFou2IWlwKfgXwIWhRfI5t6jns+3JbSSLMFyCB0v2b5IOpUdXZ0RAA4f1QgBGypQA
	U9QL+uQyMrBvDuVvux7aq30uGvlTb2wMOgtz9WW6ZW1MLvMVM05Ux6fV556Pgolqs4lsx8QSbki
	V11n3SuSpZ3XCMuidtTEkJGqpMRFfFUsn25yLsh6qGazOdN3JBhLjDifv2bcorGs33YYhrQXMQ6
	wcJfVvXnvVxTOl6U04XATAJzogzDLvDqPvgZe3i44CNtZ+ONi5+RxZVwCjlAlG2VIMkqANS1JPg
	M2mR77LFctdUIzSejgChTQUpZcKvvjEckMZ1BPsyA1SoofAMU9A2V+fHKOCJP5s44WWhf6mAFPQ
	rzynYf+cjzFNvTjKOCD3QL9A2mQl3CeVpe8HIRRgPGCfrM8Jxq2hNjHdyq709CE93c8RGpqrw9G
	usnBHSxGE++lPrY16iINDeD+6q9iYgBKe8q7aFYsT3i/luG9getDpaQKNvxmAGI8JzMkfxR0Sqh
	ewc6rNoOIp2n9SrnnVhxqH8fDv54hw96rgnRhc5zYPN5ICpfs1A4OvyUamGCB0xEmUqSNQD4cfx
	Z9NVLSwAPwJNu+gEFRTiZyJ9vQ==
X-Received: by 2002:a05:600c:a4e:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4ac187a766bmr583785e9.21.1793304134476;
        Thu, 29 Oct 2026 13:02:14 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f4be:f111:4ee0:40d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm84628175e9.1.2026.10.29.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 13:02:14 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	den@openvz.org
Subject: [PATCH] KVM: x86: Fix lost EOI when unmasking a pending level IOAPIC pin
Date: Thu, 29 Oct 2026 21:02:11 +0100
Message-ID: <20261029-kvm-ioapic-eoi-v1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the guest unmasks a level-triggered redirection entry whose line is
already asserted, ioapic_write_indirect() injects the pending interrupt
first and only then asks the destination vCPUs to rescan their
ioapic_handled_vectors and EOI exit bitmaps. If the same write also set
the vector or the trigger mode, a destination vCPU can take the interrupt
and EOI it before the rescan. A posted interrupt reaches a running vCPU
without a VM exit, and the EOI is then either virtualized without an exit
or dropped by kvm_ioapic_send_eoi() because the vector is not in
ioapic_handled_vectors yet. Remote IRR stays set and the pin delivers no
more interrupts until the guest reprograms it.

Linux programs the entry masked and unmasks it with a separate write, so
the vector is scanned before anything can be injected. Windows writes
the vector, the trigger mode and the mask bit in one go. A virtio balloon
on INTx whose line is already up when the driver connects its interrupt
then stops receiving interrupts for the rest of the boot, and the guest
ignores every later balloon target.

Make the scan request before servicing the pending IRR. The request
waits for the destination vCPUs to leave guest mode, and each of them
rescans the routes and reloads its EOI exit bitmap before it can enter
the guest and take the interrupt.

Fixes: c7c9c56ca26f ("x86, apicv: add virtual interrupt delivery support")
Fixes: 3bb345f387dd ("KVM: x86: store IOAPIC-handled vectors in each VCPU")
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
Reproducer: "[kvm-unit-tests PATCH] x86: add ioapic_eoi_race test for
unmasking a pending level pin", posted separately. On a nested Intel
host with APICv and a 7.2.13 kernel it loses about 95% of the EOIs in
the single-write case. With this patch it loses none, the masked-write
case never loses any, kernel_irqchip=split is unaffected, and
x86/ioapic.flat passes.

The symptom in the field is a Windows guest whose virtio balloon is on
INTx: the balloon raises its line before the driver connects the
interrupt, Windows programs the pin and unmasks it in one write, and the
balloon gets no further interrupt until the next boot.

 arch/x86/kvm/ioapic.c | 66 +++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 0d59b9c758c2..8cca333cdc9d 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -384,39 +384,6 @@ static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
 		mask_after = e->fields.mask;
 		if (mask_before != mask_after)
 			kvm_fire_mask_notifiers(ioapic->kvm, KVM_IRQCHIP_IOAPIC, index, mask_after);
-		if (e->fields.trig_mode == IOAPIC_LEVEL_TRIG &&
-		    ioapic->irr & (1 << index) && !e->fields.mask && !e->fields.remote_irr) {
-			/*
-			 * Pending status in irr may be outdated: the IRQ line may have
-			 * already been deasserted by a device while the IRQ was masked.
-			 * This occurs, for instance, if the interrupt is handled in a
-			 * Linux guest as a oneshot interrupt (IRQF_ONESHOT). In this
-			 * case the guest acknowledges the interrupt to the device in
-			 * its threaded irq handler, i.e. after the EOI but before
-			 * unmasking, so at the time of unmasking the IRQ line is
-			 * already down but our pending irr bit is still set. In such
-			 * cases, injecting this pending interrupt to the guest is
-			 * buggy: the guest will receive an extra unwanted interrupt.
-			 *
-			 * So we need to check here if the IRQ is actually still pending.
-			 * As we are generally not able to probe the IRQ line status
-			 * directly, we do it through irqfd resampler. Namely, we clear
-			 * the pending status and notify the resampler that this interrupt
-			 * is done, without actually injecting it into the guest. If the
-			 * IRQ line is actually already deasserted, we are done. If it is
-			 * still asserted, a new interrupt will be shortly triggered
-			 * through irqfd and injected into the guest.
-			 *
-			 * If, however, it's not possible to resample (no irqfd resampler
-			 * registered for this irq), then unconditionally inject this
-			 * pending interrupt into the guest, so the guest will not miss
-			 * an interrupt, although may get an extra unwanted interrupt.
-			 */
-			if (kvm_notify_irqfd_resampler(ioapic->kvm, KVM_IRQCHIP_IOAPIC, index))
-				ioapic->irr &= ~(1 << index);
-			else
-				ioapic_service(ioapic, index, false);
-		}
 		if (e->fields.delivery_mode == APIC_DM_FIXED) {
 			struct kvm_lapic_irq irq;
 
@@ -451,6 +418,39 @@ static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
 		} else {
 			kvm_make_scan_ioapic_request(ioapic->kvm);
 		}
+		if (e->fields.trig_mode == IOAPIC_LEVEL_TRIG &&
+		    ioapic->irr & (1 << index) && !e->fields.mask && !e->fields.remote_irr) {
+			/*
+			 * Pending status in irr may be outdated: the IRQ line may have
+			 * already been deasserted by a device while the IRQ was masked.
+			 * This occurs, for instance, if the interrupt is handled in a
+			 * Linux guest as a oneshot interrupt (IRQF_ONESHOT). In this
+			 * case the guest acknowledges the interrupt to the device in
+			 * its threaded irq handler, i.e. after the EOI but before
+			 * unmasking, so at the time of unmasking the IRQ line is
+			 * already down but our pending irr bit is still set. In such
+			 * cases, injecting this pending interrupt to the guest is
+			 * buggy: the guest will receive an extra unwanted interrupt.
+			 *
+			 * So we need to check here if the IRQ is actually still pending.
+			 * As we are generally not able to probe the IRQ line status
+			 * directly, we do it through irqfd resampler. Namely, we clear
+			 * the pending status and notify the resampler that this interrupt
+			 * is done, without actually injecting it into the guest. If the
+			 * IRQ line is actually already deasserted, we are done. If it is
+			 * still asserted, a new interrupt will be shortly triggered
+			 * through irqfd and injected into the guest.
+			 *
+			 * If, however, it's not possible to resample (no irqfd resampler
+			 * registered for this irq), then unconditionally inject this
+			 * pending interrupt into the guest, so the guest will not miss
+			 * an interrupt, although may get an extra unwanted interrupt.
+			 */
+			if (kvm_notify_irqfd_resampler(ioapic->kvm, KVM_IRQCHIP_IOAPIC, index))
+				ioapic->irr &= ~(1 << index);
+			else
+				ioapic_service(ioapic, index, false);
+		}
 		break;
 	}
 }

base-commit: 5b0764a53235d3c77e1ed674e836e1b3fe1a4b1f
-- 
2.53.0

