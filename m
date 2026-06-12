Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6946B38C2B0
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228075; cv=none; b=la0bFFnE3irZeiP+NWCF8OWCSmveFktlzenFffbT8bXJDDEZmxMiCEXEMkU81gQAbj3wHUxbdcbPRsjgmwhhIuzrbVyKyuHR1tGWmFkxdMSrlZsHF5CqupXGAzqdK9rbVaEZ62zu07IYugc1RkqP72n9Pj/pOlEujRMu+Qvyr8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228075; c=relaxed/simple;
	bh=JiShA7+5k6wkBLyEEo1AiuPhdT0PxayKXh0Nmlh+7Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPYn+DywAhgBWGB6fNKaqJn/YtzbFIiiZlirHGZSb4T369d+xIzoxJWPPaJsyTjRaLpn1Soy+1EY5pkjPZu8liP03+hoq1Zzqm1VT08EVJDh0stUwH+RJUlhFPvRofIYdnSJS8f7c9mPRIgN6gmUxvNfXc4rPw9dC4+Uerw9ky0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rFnj3aAC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFnj3aAC"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36da8439078so429756a91.2
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 18:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781228074; x=1781832874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+Z4aVkKub+KMW7PmPSQF98jOvVjaWCA6l7UoH1skF0=;
        b=rFnj3aAChWzyT73647WVo3XkfsdXNxl3ejTWvkFyLb9kcsIF365aSDY4mkH8b9Q8wk
         uULDjiYWTlEjm1q8QXLSzJUsJWu9t9AZqfzeKd8ka73lVnGAGbIfT9/r4fWhcCgNi2QR
         Sb/7QPmBEsbtKt9vy73b4Aw4B/g13+/LjEtZ3wJK8JW4uD6nITcaf3NG5vcqqn+nGFMe
         /AkgPOiKTyiCy0rx14cLhXbGP3rm2A2clKExn1YAgm2L9lh7lcAQcgT8nIATeSGxhnUV
         dKUGJcp43q4vpvvqwUCnG+O1pnaBBOc4UzxVcyNozw3RKSSBE8emosXgl/ed5ncw4o0x
         ubMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781228074; x=1781832874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+Z4aVkKub+KMW7PmPSQF98jOvVjaWCA6l7UoH1skF0=;
        b=q+TetgvoCURjWSm0kcO8HqxVbC+leB+rvMKzjJbLX4pCoX9/h1NO+2hVXtANe/EIXw
         +JrRqvA0MynOyQPFJYXxfurPiFrX7QYFKCbvdWtArSzBtvTI6+zu0MznUBgRGJ9jkcna
         +twnJR+myE9DiEdhC/UrkjNpM5ceI/pznjUOQjwjjzIewRIc0M6scJhPb9y99OYUHeQf
         J5yRmYYgzLGHOtC4Q6B1UVeuNY+m3SIDvbdYRxRExhpcP0JFGjjWoVqG7PtStHHj8GuA
         4ah1aqkrKJXBij4ijyoLR0ZmL5q8YyD7jmqwVw56xjBuwLuO408FkUy0+ONJdpD0aFH5
         33lA==
X-Forwarded-Encrypted: i=1; AFNElJ/EPxNnZlCIv9Cx9ZrZ5DdJkkDBgk7cPYnSTmDvyZhOFtRyYBv9E8sYRmHE6hfExZi8MPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ogBRJi8MQx3Ssqzejwxch02tgqOg9mp4FyKifjK27P6cPD53
	AwVDUXojIrdndLC2fBqJtZe9xZbtmvlNXl45MnvwmmzKYKSDskk97haF
X-Gm-Gg: Acq92OGI0VOSpGJoVIU3i07OCm6+yU5E+/FVzba5bZJz/nYQNHuh4R5OdpABWnmx4Yr
	P6X6FJ1gyby5opSxlt4CDxlidAFyFQRmPQwcM7/t08t1TKfggv8t9LVnSzmd5i7duSwUljLW16Q
	ndqzXYDvZJcnRiCnjq4uOhh6P8UFCyaU2+EBZ2K3xvXP7GUJBs3KBT6ymWOH6mpOchZTuASlJdo
	N/KtmtO6V9UQCftCw/S3O0nNtaALwMAL9FTjgAXKO+WkjVI2kHugvBzwA578ATNDRA27KyElq76
	JtldhTV481cR5gtZAuRpZWjQ7T2ZwU4uzH9k+aHyibWE8qte9I90GE5lbJY3POhQymLn5auEogG
	+k4UYDEwOzEvZT4sptoZCrhZ0nJK5mc16OFZisd3Gl2GK7tqSVMoxCrbW3Vu/YWoCwvVCBXD5Fj
	JxfQw1yKrq71lDoJYbWBq/JcIOGw==
X-Received: by 2002:a17:90a:fc45:b0:377:36af:c996 with SMTP id 98e67ed59e1d1-37a040b3518mr867261a91.21.1781228073667;
        Thu, 11 Jun 2026 18:34:33 -0700 (PDT)
Received: from wanpengli.. ([2408:822f:1aba:84a0:651:104c:ba0c:1f4a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-37a1f07bbfdsm250713a91.5.2026.06.11.18.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:34:33 -0700 (PDT)
From: Wanpeng Li <kernellwp@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	Wanpeng Li <wanpengli@tencent.com>,
	Richie Buturla <richie@linux.ibm.com>
Subject: [PATCH v3 07/10] KVM: x86/lapic: Track unicast fixed IPI delivery
Date: Fri, 12 Jun 2026 09:33:52 +0800
Message-ID: <20260612013355.59231-8-kernellwp@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612013355.59231-1-kernellwp@gmail.com>
References: <20260612013355.59231-1-kernellwp@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wanpeng Li <wanpengli@tencent.com>

Record IPI sender/receiver relationships from both LAPIC delivery paths:
the APIC-map fast path and the slow fallback.

Only record a directed sender->receiver hint when the IPI originates from
a vCPU, uses APIC_DM_FIXED delivery, has no destination shorthand, is
accepted by exactly one destination vCPU, and is not a self-IPI. The
tracking helper also filters the disabled case.

This change only records the relationship; directed-yield candidate
selection is unchanged.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/lapic.c | 71 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 515409e0e22c..3a5f197eb2c6 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1326,7 +1326,8 @@ static bool __kvm_irq_delivery_to_apic_fast(struct kvm *kvm, struct kvm_lapic *s
 	struct kvm_apic_map *map;
 	unsigned long bitmap;
 	struct kvm_lapic **dst = NULL;
-	int i;
+	struct kvm_vcpu *ipi_unique = NULL;
+	int i, ipi_targets = 0;
 	bool ret;
 
 	*r = -1;
@@ -1347,10 +1348,37 @@ static bool __kvm_irq_delivery_to_apic_fast(struct kvm *kvm, struct kvm_lapic *s
 	if (ret) {
 		*r = 0;
 		for_each_set_bit(i, &bitmap, 16) {
+			int delivered;
+
 			if (!dst[i])
 				continue;
-			*r += kvm_apic_set_irq(dst[i]->vcpu, irq, rtc_status);
+			delivered = kvm_apic_set_irq(dst[i]->vcpu, irq, rtc_status);
+			*r += delivered;
+			if (delivered > 0) {
+				ipi_targets++;
+				ipi_unique = dst[i]->vcpu;
+			}
 		}
+
+		/*
+		 * Track unicast fixed IPIs for directed-yield optimization.
+		 *
+		 * Only record when:
+		 *  - the IPI originated from a vCPU (LAPIC write, not kernel
+		 *    injection): src != NULL;
+		 *  - delivery mode is plain fixed: synchronization
+		 *    primitives such as spinlocks, TLB flushes and
+		 *    smp_call_function() use APIC_DM_FIXED;
+		 *  - no shorthand: shorthand encodes broadcasts and self
+		 *    which we explicitly do not track;
+		 *  - exactly one recipient accepted the interrupt, giving a
+		 *    directed sender->receiver relationship.
+		 */
+		if (src && irq->delivery_mode == APIC_DM_FIXED &&
+		    irq->shorthand == APIC_DEST_NOSHORT &&
+		    ipi_targets == 1 && ipi_unique && ipi_unique != src->vcpu)
+			kvm_track_ipi_communication(src->vcpu, ipi_unique,
+						    irq->vector);
 	}
 
 	rcu_read_unlock();
@@ -1443,6 +1471,13 @@ int __kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 	struct kvm_vcpu *vcpu, *lowest = NULL;
 	unsigned long i, dest_vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)];
 	unsigned int dest_vcpus = 0;
+	/*
+	 * Track unicast fixed IPI for directed-yield optimization in this
+	 * slow fallback path (APIC map miss). See the fast-path equivalent in
+	 * __kvm_irq_delivery_to_apic_fast() for the full filtering rationale.
+	 */
+	struct kvm_vcpu *ipi_unique = NULL;
+	int ipi_targets = 0;
 
 	if (__kvm_irq_delivery_to_apic_fast(kvm, src, irq, &r, rtc_status))
 		return r;
@@ -1456,6 +1491,8 @@ int __kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 	memset(dest_vcpu_bitmap, 0, sizeof(dest_vcpu_bitmap));
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
+		int delivered;
+
 		if (!kvm_apic_present(vcpu))
 			continue;
 
@@ -1466,7 +1503,12 @@ int __kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 		if (!kvm_lowest_prio_delivery(irq)) {
 			if (r < 0)
 				r = 0;
-			r += kvm_apic_set_irq(vcpu, irq, rtc_status);
+			delivered = kvm_apic_set_irq(vcpu, irq, rtc_status);
+			r += delivered;
+			if (delivered > 0) {
+				ipi_targets++;
+				ipi_unique = vcpu;
+			}
 		} else if (kvm_apic_sw_enabled(vcpu->arch.apic)) {
 			if (!vector_hashing_enabled) {
 				if (!lowest)
@@ -1487,8 +1529,27 @@ int __kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 		lowest = kvm_get_vcpu(kvm, idx);
 	}
 
-	if (lowest)
-		r = kvm_apic_set_irq(lowest, irq, rtc_status);
+	if (lowest) {
+		int delivered = kvm_apic_set_irq(lowest, irq, rtc_status);
+
+		r = delivered;
+		if (delivered > 0) {
+			ipi_targets++;
+			ipi_unique = lowest;
+		}
+	}
+
+	/*
+	 * Record a unicast fixed IPI delivered via this slow path. The fast
+	 * path records the APIC-map-hit case; this covers the fallback
+	 * where kvm_apic_map_get_dest_lapic() missed but delivery still
+	 * resolves to exactly one recipient.
+	 */
+	if (src && irq->delivery_mode == APIC_DM_FIXED &&
+	    irq->shorthand == APIC_DEST_NOSHORT &&
+	    ipi_targets == 1 && ipi_unique && ipi_unique != src->vcpu)
+		kvm_track_ipi_communication(src->vcpu, ipi_unique,
+					    irq->vector);
 
 	return r;
 }
-- 
2.43.0

