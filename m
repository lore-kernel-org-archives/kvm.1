Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274FA38CFE1
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228071; cv=none; b=Vu/gLN2YjvPxfm0mkaC5JAcMccakUImNd2Tkwa6BQDClg0U8y1NWHxnFFfGbPfSpR43ne6DJdLD4JTsE7ebwiwESSvCXa3IZmFaeN+59VAIR4Xit8sYNik1mDYaWZ0hniY91ldGMuUftyFJXipJy/NHRac0JJ5readfEHFmYJ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228071; c=relaxed/simple;
	bh=1PT54fy1QW/5P2/PvMSEN+faQD8tlylOgJgA5QUQ1MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6UTMedqrp7Ha2kFu7l3kbHYh3UsOmWbZF4YDADqcQ26+He/Cctx6TgkGY96BK2ixlZv2kBGDDbm1w0rUZ5eTwJdLvhOkxndT/ZeG6VW9gu/W9WrtVs1iXw9Qt9BoLot0LmadqgxuPTAGWJJvKdnP90jTM/rkd3WggdqqQ44u44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNHtlcjP; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNHtlcjP"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-372b4330deeso363635a91.0
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 18:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781228069; x=1781832869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIKr0bqSdRIU+G2lKHT1QjsMF60rlF0pZBINnn+xYR4=;
        b=bNHtlcjPQgSJQYRfGvxhdcfXqY3Ttjppb9zVtLmdMCojqwUAo9hOGzsZmTqFMiy4Yy
         HR9pEhj+n4QuYfrRwL99Xn0IVxez3eMGpQWU9nnji1sRKGgoW6Koywty8gJPj54g9hrP
         cFwVWRfXA6uSdromIONO/nsztSiu54UjoOYFklYjZVtaFP252JBQTB5GuajpYS6mwadv
         kvVgAbnDFhxFYqsmmREXmMSWnVb37JptK7wn03GgNylcQuIq7KB+esr6wxI4VWkGU9vV
         CfLobd8AjHHFL6T4UuT7+LM9SN0E6isSQxogqr7tWeVeME5q9ZXxevZW0C9gXHO5P18c
         4LyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781228069; x=1781832869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tIKr0bqSdRIU+G2lKHT1QjsMF60rlF0pZBINnn+xYR4=;
        b=PBppbPtqTWeXi3lTuqGwrBLq0MjtbmEv1h3TiE7h3XsMLcTvCB7rPyE+/WfGMbSWrd
         pr5heQF1QFXC/dR+wD5CYjhClAYEYGFMP49IeB+tAPADasFaflVdcfZt9v7YU+osjlwJ
         hIiAp1ss9bgpMktj0GxE1LlxzBcjfB98y6sDfWOTuUZEYigOQyeHUxlg+P99ZrZFJrh+
         XIUHgISbJYINU7bb5bRPnFcNyqCVgAbU9OC9QitxZw63/7aydFz2GS7j3SB4XFFJM0E/
         MuqUTEDDGVzWhogze65aMxmtTxMnsm+zDdehOEdm0Z1eTLiJKI6PXikn/SqjNkfNC1Bx
         C8Lg==
X-Forwarded-Encrypted: i=1; AFNElJ/amtg358McQ+NZrytGbJlhSTBDcAvq1NLEw2Lem68fWfkacTvhKdVJ8482unnRmolOVC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7vemOVWSKRnJLCmPeVycOom7t+CPM24KBCSdfF2sEn+20pSxV
	DznT6qmrwMf9TvIloYacGxoMeZqVDMAcSs/8U1VT4mKSaTqMCADlPE3h
X-Gm-Gg: Acq92OGYU8eH+G00Si+5RK2wHfzUqS8aG3MqprtgMfM4tMBXOX95zpwDuOaQAtCwNOj
	FuxeHooaoEUcHN6C2hvgR3HCIX461hHWuaarMX+lsAuoFPCzXW2mcKFk+oJ7v9RO1dDTIOSso4T
	fcGv1d8XxC2EUzaHPFEra4cyuiIasR1bDK3fUnhXOUvyix8Inj6T4O6pteNE/4uGMOzLrmiFTwH
	HdCYjM/ORbdfLHDN9GZTvQzzt1aKpVUat2YIxQS0TEQseSBpOOStJN5q1AvRiPoGClqw7Htki48
	QUQvaQBHNQNPLVFalLgOFuLnpGMjo/l/Xt2lLJT5Nj1EEHPJwaLbUcS2OXwikwkGJ+p6UFnidCv
	SDg4bYCKLeFFp13a4ibV5HgjVJyRbw2Z32haqeH+30pQAVUnRvxCpNH9QeMlAhxJzbbUA29+o4n
	Zole6VtnR4M4aPVNoSl4Eq+Gn2yw==
X-Received: by 2002:a17:90b:3a83:b0:36b:9c70:3367 with SMTP id 98e67ed59e1d1-37a03dc314emr890148a91.17.1781228069398;
        Thu, 11 Jun 2026 18:34:29 -0700 (PDT)
Received: from wanpengli.. ([2408:822f:1aba:84a0:651:104c:ba0c:1f4a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-37a1f07bbfdsm250713a91.5.2026.06.11.18.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:34:29 -0700 (PDT)
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
Subject: [PATCH v3 06/10] KVM: x86: Add IPI tracking infrastructure for directed yield
Date: Fri, 12 Jun 2026 09:33:51 +0800
Message-ID: <20260612013355.59231-7-kernellwp@gmail.com>
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

On overcommitted hosts, a vCPU spinning on an IPI response is difficult
to distinguish from a vCPU spinning on a lock. kvm_vcpu_on_spin() can
therefore yield to an unrelated vCPU based only on coarse preemption
state.

Add per-vCPU IPI tracking for directed yield. struct kvm_vcpu_arch now
records the last sender and receiver vCPU indexes, the vector, a pending
flag, and a monotonic timestamp. Add helpers to record a send, query
whether a vCPU is the recent IPI receiver of another vCPU, and clear or
reset the context. Accesses use READ_ONCE() and WRITE_ONCE() because the
state is only a best-effort scheduling hint.

Add module parameters to enable tracking and to control the recency
window. Provide a weak generic kvm_vcpu_is_ipi_receiver() stub so
non-x86 builds keep the existing behavior. The state is reset on vCPU
create and destroy, and cleared on INIT.

This adds only state and helpers; directed-yield candidate selection is
unchanged.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/include/asm/kvm_host.h |  19 ++++++
 arch/x86/kvm/lapic.c            | 102 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              |   3 +
 arch/x86/kvm/x86.h              |   8 +++
 include/linux/kvm_host.h        |   8 +++
 virt/kvm/kvm_main.c             |   6 ++
 6 files changed, 146 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f14009f25a3b..a26623716a53 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1065,6 +1065,25 @@ struct kvm_vcpu_arch {
 	int pending_external_vector;
 	int highest_stale_pending_ioapic_eoi;
 
+	/*
+	 * IPI tracking for directed-yield optimization.
+	 *
+	 * Populated by kvm_track_ipi_communication() when a unicast fixed
+	 * IPI is delivered, and queried by kvm_vcpu_is_ipi_receiver() from
+	 * kvm_vcpu_on_spin() to prefer the confirmed IPI target before
+	 * generic preempted-lock-holder heuristics.
+	 *
+	 * All accesses are lockless READ_ONCE/WRITE_ONCE; best-effort by
+	 * design (see comment on kvm_vcpu_is_good_yield_candidate()).
+	 */
+	struct {
+		int	last_ipi_sender;	/* vCPU idx of last IPI sender  */
+		int	last_ipi_receiver;	/* vCPU idx of last IPI target  */
+		u8	vector;			/* vector of the pending IPI    */
+		bool	pending_ipi;		/* awaiting IPI response        */
+		u64	ipi_time_ns;		/* mono timestamp of IPI send   */
+	} ipi_context;
+
 	/* be preempted when it's in kernel-mode(cpl=0) */
 	bool preempted_in_kernel;
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4078e624ca66..515409e0e22c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -78,6 +78,29 @@ module_param(lapic_timer_advance, bool, 0444);
 static bool __read_mostly vector_hashing_enabled = true;
 module_param_named(vector_hashing, vector_hashing_enabled, bool, 0444);
 
+/*
+ * IPI tracking for directed-yield optimization.
+ *
+ * ipi_tracking_enabled  - master switch (default on). When off, the
+ *                         tracking hooks become no-ops and
+ *                         kvm_vcpu_is_ipi_receiver() always returns
+ *                         false, falling back to the legacy
+ *                         preempted-in-kernel heuristic.
+ *
+ * ipi_window_ns         - recency window. An IPI older than this is
+ *                         treated as stale and does not influence
+ *                         directed-yield selection. Long enough to
+ *                         cover typical spin-on-IPI-response periods,
+ *                         short enough to avoid stale state inflating
+ *                         boost priority on throughput-sensitive
+ *                         workloads.
+ */
+static bool ipi_tracking_enabled = true;
+module_param(ipi_tracking_enabled, bool, 0644);
+
+static unsigned long ipi_window_ns = 50 * NSEC_PER_MSEC;
+module_param(ipi_window_ns, ulong, 0644);
+
 static int kvm_lapic_msr_read(struct kvm_lapic *apic, u32 reg, u64 *data);
 static int kvm_lapic_msr_write(struct kvm_lapic *apic, u32 reg, u64 data);
 
@@ -1144,6 +1167,85 @@ static int kvm_apic_compare_prio(struct kvm_vcpu *vcpu1, struct kvm_vcpu *vcpu2)
 	return vcpu1->arch.apic_arb_prio - vcpu2->arch.apic_arb_prio;
 }
 
+/*
+ * Record a sender -> receiver IPI relationship for directed-yield use.
+ *
+ * Accessed lockless (READ_ONCE/WRITE_ONCE); this is best-effort, racy
+ * information consumed only as a scheduling hint by
+ * kvm_vcpu_on_spin(), so occasional torn or stale reads are harmless.
+ *
+ * Callers should already have filtered out self-IPIs and non-unicast
+ * or non-fixed-mode deliveries; this function only records the state.
+ */
+void kvm_track_ipi_communication(struct kvm_vcpu *sender,
+				 struct kvm_vcpu *receiver, u8 vector)
+{
+	if (!sender || !receiver || sender == receiver)
+		return;
+	if (unlikely(!READ_ONCE(ipi_tracking_enabled)))
+		return;
+
+	WRITE_ONCE(sender->arch.ipi_context.last_ipi_receiver,
+		   receiver->vcpu_idx);
+	WRITE_ONCE(sender->arch.ipi_context.vector, vector);
+	WRITE_ONCE(sender->arch.ipi_context.pending_ipi, true);
+	WRITE_ONCE(sender->arch.ipi_context.ipi_time_ns,
+		   ktime_get_mono_fast_ns());
+
+	WRITE_ONCE(receiver->arch.ipi_context.last_ipi_sender,
+		   sender->vcpu_idx);
+	WRITE_ONCE(receiver->arch.ipi_context.vector, vector);
+}
+
+/*
+ * Return true if @receiver is the confirmed recent IPI target of
+ * @sender, within the configured recency window. Directed yield uses
+ * this as a high-confidence signal that selecting @receiver may
+ * unblock @sender's spin loop.
+ */
+bool kvm_vcpu_is_ipi_receiver(struct kvm_vcpu *sender,
+			      struct kvm_vcpu *receiver)
+{
+	u64 then, now;
+
+	if (unlikely(!READ_ONCE(ipi_tracking_enabled)))
+		return false;
+
+	if (!READ_ONCE(sender->arch.ipi_context.pending_ipi))
+		return false;
+
+	if (READ_ONCE(sender->arch.ipi_context.last_ipi_receiver) !=
+	    receiver->vcpu_idx)
+		return false;
+
+	then = READ_ONCE(sender->arch.ipi_context.ipi_time_ns);
+	now = ktime_get_mono_fast_ns();
+	return now - then <= READ_ONCE(ipi_window_ns);
+}
+
+/*
+ * Clear the IPI tracking state of a single vCPU, typically when the
+ * associated interrupt has been acknowledged (EOI) or the vCPU has
+ * been reset/destroyed.
+ *
+ * Leaves the monotonic timestamp untouched to keep staleness checks
+ * on other vCPUs that may reference this one well-defined; use
+ * kvm_vcpu_reset_ipi_context() for a hard reset.
+ */
+void kvm_vcpu_clear_ipi_context(struct kvm_vcpu *vcpu)
+{
+	WRITE_ONCE(vcpu->arch.ipi_context.pending_ipi, false);
+	WRITE_ONCE(vcpu->arch.ipi_context.last_ipi_sender, -1);
+	WRITE_ONCE(vcpu->arch.ipi_context.last_ipi_receiver, -1);
+	WRITE_ONCE(vcpu->arch.ipi_context.vector, 0);
+}
+
+void kvm_vcpu_reset_ipi_context(struct kvm_vcpu *vcpu)
+{
+	kvm_vcpu_clear_ipi_context(vcpu);
+	WRITE_ONCE(vcpu->arch.ipi_context.ipi_time_ns, 0);
+}
+
 /* Return true if the interrupt can be handled by using *bitmap as index mask
  * for valid destinations in *dst array.
  * Return false if kvm_apic_map_get_dest_lapic did nothing useful.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0550359ed798..dcedd09bac10 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12907,6 +12907,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 		goto free_guest_fpu;
 
 	kvm_xen_init_vcpu(vcpu);
+	kvm_vcpu_reset_ipi_context(vcpu);
 	vcpu_load(vcpu);
 	kvm_vcpu_after_set_cpuid(vcpu);
 	kvm_set_tsc_khz(vcpu, vcpu->kvm->arch.default_tsc_khz);
@@ -12974,6 +12975,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_mmu_destroy(vcpu);
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 	free_page((unsigned long)vcpu->arch.pio_data);
+	kvm_vcpu_reset_ipi_context(vcpu);
 	kvfree(vcpu->arch.cpuid_entries);
 }
 
@@ -13050,6 +13052,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 		kvm_leave_nested(vcpu);
 
 	kvm_lapic_reset(vcpu, init_event);
+	kvm_vcpu_clear_ipi_context(vcpu);
 
 	WARN_ON_ONCE(is_guest_mode(vcpu) || is_smm(vcpu));
 	vcpu->arch.hflags = 0;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 38a905fa86de..eb7f50018f78 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -475,6 +475,14 @@ int handle_ud(struct kvm_vcpu *vcpu);
 void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
 				   struct kvm_queued_exception *ex);
 
+/* IPI tracking helpers for directed-yield optimization (see lapic.c). */
+void kvm_track_ipi_communication(struct kvm_vcpu *sender,
+				 struct kvm_vcpu *receiver, u8 vector);
+bool kvm_vcpu_is_ipi_receiver(struct kvm_vcpu *sender,
+			      struct kvm_vcpu *receiver);
+void kvm_vcpu_clear_ipi_context(struct kvm_vcpu *vcpu);
+void kvm_vcpu_reset_ipi_context(struct kvm_vcpu *vcpu);
+
 int kvm_mtrr_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data);
 int kvm_mtrr_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata);
 void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_code);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4c14aee1fb06..e54e72ae5ebb 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1549,6 +1549,14 @@ static inline void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 int kvm_vcpu_yield_to(struct kvm_vcpu *target);
 void kvm_vcpu_on_spin(struct kvm_vcpu *vcpu, bool yield_to_kernel_mode);
 
+/*
+ * IPI-aware directed-yield hook. Architectures that support IPI
+ * tracking (currently x86 via arch/x86/kvm/lapic.c) override this;
+ * the generic __weak stub in virt/kvm/kvm_main.c returns false.
+ */
+bool kvm_vcpu_is_ipi_receiver(struct kvm_vcpu *sender,
+			      struct kvm_vcpu *receiver);
+
 void kvm_flush_remote_tlbs(struct kvm *kvm);
 void kvm_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn, u64 nr_pages);
 void kvm_flush_remote_tlbs_memslot(struct kvm *kvm,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 881f92d7a469..2e11c6cfc167 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3957,6 +3957,12 @@ bool __weak kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu)
 	return false;
 }
 
+bool __weak kvm_vcpu_is_ipi_receiver(struct kvm_vcpu *sender,
+				     struct kvm_vcpu *receiver)
+{
+	return false;
+}
+
 void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 {
 	int nr_vcpus, start, i, idx, yielded;
-- 
2.43.0

