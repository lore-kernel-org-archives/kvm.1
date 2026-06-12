Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A3038C2B0
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228079; cv=none; b=U/1oqe02TSll2jzggeiWpRA+4b+VEgs18enfoVSqIxGqAGooiRyHAQHUmCyExjmUdUWjvFsfOo1GAXbJi0ksZe9uYgGixaLDIdNqFLw8m6RVVJShlk+Mbj3jE3JFj9X8QQUf4lSOW3zgnfZm/BIduhjDcElVxgVHj0kyrVUeOn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228079; c=relaxed/simple;
	bh=AJpCk4J32WNyLFxxfpnYHB/kVMhE8euK4GNuaoR7vtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjQ6VSxOYVSA/ClFWjjSbxhNpN7TPWqaaETLTuEPzW1nsLF9Da1S5U+zSKGQP7uuam0JYu5C72dgHQFSwc/kgCe0ogUg6QtmGU+eGP5NHCB6WL0Nhxin8iCdkH+SlTPesolYmg0vHRHIexcksdwxxqz0O50Z9EL5MVq18HeohMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1wxNE+T; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1wxNE+T"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36da8439078so429788a91.2
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 18:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781228078; x=1781832878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54g1mIxlnWdVC1XTdANPpLR1bjjl4JSbtVvv4qaUW8k=;
        b=S1wxNE+To6CKZTUh5geCmZg9ybnXfcCYWar0tebgJjcXfrUPkTYuH+0w8U8V5OieX8
         /jbUP+N/oDyjtfvX7eafv13ednZlPgs1NUxsVvlBFtCuPJwFJNJaFNTGSQTDhDoljkRc
         O/KKx7+G1Cr//bFc5avAERKapmdkm0MnJvVdbURSJaMaVpfCCBHXdR5A83zqvNOIDkqN
         O2yN6lSH0N3dwXBZpysmMOjygKHYmjjVOZy+/GuZuTNsQSFzaEQhsmDMv6TCSgUp51Nf
         ommhHNmcP6A5A7vYNzBlNrwe88rXYDIZxfxw7UckeEQU7WhDLSm+4COO77PYarR5Qq/4
         VYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781228078; x=1781832878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=54g1mIxlnWdVC1XTdANPpLR1bjjl4JSbtVvv4qaUW8k=;
        b=aMHY86ukbpChThridSaqD+V7POvvNoyktHdtJIjeFXE595mVGyz1ju9MQgf/JbSwxl
         6qm+4wRHsA8wyFysospVSs/MSqWyyuC3/RSABP0U/Fxa8C7nZw5dOQrIyFsxXo5+Qu2U
         mcR6h0/zf9N0lOljQ/BtSjA3hJhgpBrUtMoTuxDqZpIEfrlJQJWaSgB7iImMUdVaY+6T
         D6Jqljv8WSe9zbGVj48LeFaDQHkK58ORBQuAYCRcRWF8vdN7giUmn2f7XIke4fRouvpv
         xy1eNZmaLM9yO+VAi1lOFrupB8iDkv0CAZGVeHoxVh+iZJ0lBgOSqvxS+rxt9OYOZvPA
         y6Ew==
X-Forwarded-Encrypted: i=1; AFNElJ8FnZMp5ShEIWwTtZRf2OpCwWIxg4S1cN6BFLlng067bf0VYOdE7Qf81wVQlzsRxPgXQKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLKnpk11cQfTr1uIjjzfV1k96rveVljazVEQe+WiD1i8d76Hqd
	22eL56KJ7eAq2JwMX3Obhul/6pIO9m/C4jfr+T0NWPz+VrDtKLWTpttoJ2+2JS2hqAnSFQ==
X-Gm-Gg: Acq92OEsHGUEvszOBnjJls9i6KLxLFyBpX0IHG5AzIYCEqtzkOxSW3tkynoNSbx3FJp
	axZGJFkc2/SoaY1AK/nsUSU0nxEr8d9RpgUSGwKB9NG+N0S4yqr9a8sNU6ABDytZAocWU9FdF9U
	l+D+7V964bV+0+aF8J6zOy2JTP0A/OoZkkHiygW2CtCaSDDYAAHzBQ033oshj4XsCP+TE/a3rRy
	98S3Fqm0URo3QDL68OaoJNKppY0hhP6TCM91Jj8VeFg732/ZVfwLyfLuKDN8Eb0ZhBqyKeu+2tJ
	Eo/JHotHFvoqcU5ZglzD2LhjThC3w4/uGA78ycZEOZmbJ3Ni0I87xSWr/EZDJuWioxRDSSwJTCn
	h2cT+uTcT++8D44CYOYwWMuHfhbi8YUcFlosYX3lkRfG9hpAP9OWsxU7AIYiLt6FoPDweN+uv9x
	pPcd2ejknGV88qaGEP6fsOmVIRug==
X-Received: by 2002:a17:90a:e7ce:b0:36d:ae6a:22ed with SMTP id 98e67ed59e1d1-37a041afaa2mr939962a91.22.1781228077904;
        Thu, 11 Jun 2026 18:34:37 -0700 (PDT)
Received: from wanpengli.. ([2408:822f:1aba:84a0:651:104c:ba0c:1f4a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-37a1f07bbfdsm250713a91.5.2026.06.11.18.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:34:37 -0700 (PDT)
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
Subject: [PATCH v3 08/10] KVM: x86/lapic: Clear IPI tracking on matching-vector EOI
Date: Fri, 12 Jun 2026 09:33:53 +0800
Message-ID: <20260612013355.59231-9-kernellwp@gmail.com>
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

Clear IPI tracking from both EOI sites, apic_set_eoi() and
kvm_apic_set_eoi_accelerated(), matched on the EOI'd vector. A receiver
may handle unrelated interrupts between an IPI's arrival and its EOI; a
vector-blind clear could evict the still-pending context and make directed
yield miss the receiver.

When the vector matches, clear the receiver's context unconditionally, and
clear the sender's pending flag only if it still points at this receiver
with the same vector and within the recency window. The existing
trace_kvm_eoi() tracepoint already records the vector, so no new tracepoint
is added.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/lapic.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 3a5f197eb2c6..0925d359384e 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1746,6 +1746,65 @@ static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
 #endif
 }
 
+/*
+ * Clear IPI tracking state associated with a just-acknowledged vector.
+ *
+ * Called from both the emulated APIC_EOI write path (apic_set_eoi)
+ * and the accelerated exit path (kvm_apic_set_eoi_accelerated).
+ *
+ * Vector matching is deliberate: the receiver may handle an unrelated
+ * interrupt (timer, device IRQ) between an IPI's arrival and its EOI.
+ * If we cleared unconditionally, such an intermediate EOI would evict
+ * the still-pending IPI context and cause directed yield to miss the
+ * real receiver. We therefore only touch state when the EOI'd vector
+ * matches the one we recorded at send time.
+ *
+ * Two-stage cleanup:
+ *  1. Clear the receiver's context unconditionally when the vector
+ *     matches: it has processed exactly this IPI.
+ *  2. Clear the sender's pending_ipi flag only if the sender still
+ *     points at this receiver, with the same vector, and within the
+ *     configured recency window. This avoids evicting a newer IPI
+ *     that happens to share the vector with a stale one.
+ */
+static void kvm_clear_ipi_on_eoi(struct kvm_lapic *apic, int vector)
+{
+	struct kvm_vcpu *receiver = apic->vcpu;
+	struct kvm_vcpu *sender;
+	int sender_idx;
+	u64 then, now;
+
+	if (unlikely(!READ_ONCE(ipi_tracking_enabled)))
+		return;
+
+	if (vector < 0 || vector > 0xff)
+		return;
+
+	if (READ_ONCE(receiver->arch.ipi_context.vector) != (u8)vector)
+		return;
+
+	sender_idx = READ_ONCE(receiver->arch.ipi_context.last_ipi_sender);
+	kvm_vcpu_clear_ipi_context(receiver);
+
+	if (sender_idx < 0)
+		return;
+
+	sender = kvm_get_vcpu(receiver->kvm, sender_idx);
+	if (!sender)
+		return;
+
+	if (READ_ONCE(sender->arch.ipi_context.last_ipi_receiver) !=
+	    receiver->vcpu_idx)
+		return;
+	if (READ_ONCE(sender->arch.ipi_context.vector) != (u8)vector)
+		return;
+
+	then = READ_ONCE(sender->arch.ipi_context.ipi_time_ns);
+	now = ktime_get_mono_fast_ns();
+	if (now - then <= READ_ONCE(ipi_window_ns))
+		WRITE_ONCE(sender->arch.ipi_context.pending_ipi, false);
+}
+
 static int apic_set_eoi(struct kvm_lapic *apic)
 {
 	int vector = apic_find_highest_isr(apic);
@@ -1766,6 +1825,7 @@ static int apic_set_eoi(struct kvm_lapic *apic)
 		kvm_hv_synic_send_eoi(apic->vcpu, vector);
 
 	kvm_ioapic_send_eoi(apic, vector);
+	kvm_clear_ipi_on_eoi(apic, vector);
 	kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
 	return vector;
 }
@@ -1781,6 +1841,7 @@ void kvm_apic_set_eoi_accelerated(struct kvm_vcpu *vcpu, int vector)
 	trace_kvm_eoi(apic, vector);
 
 	kvm_ioapic_send_eoi(apic, vector);
+	kvm_clear_ipi_on_eoi(apic, vector);
 	kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_apic_set_eoi_accelerated);
-- 
2.43.0

