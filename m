Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77A238D3EC
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228084; cv=none; b=Y4DDx2vRIF9rLr0flP1bPU8PVgdr7XRWFR15x7l2+LqAtls9iH2EzsWkHVIdcwliQGzeOqqxUnCtAK9ZnQM8DZCyvjxeoQKymnkKk5BZQkS1VV+w3rYiRsU3X5sn/+4Z0ai4uh2DGKsQ/V0ShNlJVEruQKEFlIMd9b8rDKbwQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228084; c=relaxed/simple;
	bh=oUqyS4YMguLg/y3GYzm8PmUs/ARE2no+ciMJQW4t+bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxT3EXADPChMpsKcF7mHh0D6s4dH/UIv1+Yv52tz5felHtyfdKe1qJjrdemV0jy516Htl8O665oBkpcbffxfswJUfMr7b1cLpONHe1HtR6xZHPM8UuJcm6ZhePqN+oCNjuZSOa9JhDeD1xlXRNuIt53xG11POAwrEpe51yYlwDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nlyf61QQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nlyf61QQ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b8d414666so337620a91.3
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 18:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781228082; x=1781832882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIB83M9OUPc1oc/Q0slx6pHU1K2bFQQF2y5JLcs4bZM=;
        b=Nlyf61QQFNkbZ3LeYYdcdxNeuB8a8YLA4+OQvFGUei7yYc1LOSX+oII/cMEWzBWmIc
         f9RpvHvy7RDNXtHXVAY2E8hkCm3SEJKscgS/lLPgA4yFnHd5OgUwEGoUSWpLWiHLk2WW
         ALvRsH4rLTVgmbB60nXz5LUvX4ACc0YWSKhs9FfR0TpEByynl1YuVYW02J5EnreuJ9uF
         JzwdWdGI4aFAXg2+GcZu61M2/UXAPJFWRLg7Gk6hhZINOp4CMMC8aNbCGW+xbMnHZxBb
         /mrPvHx1ER/fSe46vzOvab0sy9eX7E7o+/kqF53Z1G2slnJjPvkeSkFqfAhZtpeRaaLt
         /gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781228082; x=1781832882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oIB83M9OUPc1oc/Q0slx6pHU1K2bFQQF2y5JLcs4bZM=;
        b=ZDrpSyRm5TOjkyNSRZ0CHk3PYUagSkG7mpXjhW3D5kwGGsAKFg9TNq30JnXchcOeQV
         KrchE/JrwxAHDevtuFInkXznIfiQTk4lnGkFALtDusYS88Eh0nfUYtK07QaMMLxomdO1
         Szk8OTtpE+szp/wHVb+P6ynUlvxvqqeLrf41a4jRcM94SjNygWRaU1wik2xHC7BhICA2
         w6/azxurbqN1/7ptY7TwgMJNqT/t9bD+SCxv4jxqp+rwgd36/E6/lEhWNY9J5fl4Shep
         dNaJ1bA35ZVxtCJ4dyH5eH8mqOFMFKVxmMXG7vvYG9nqfC0jhZOE53/8DVll4vGhIaq0
         3CYA==
X-Forwarded-Encrypted: i=1; AFNElJ+7ItqLaPR0S2j4pEBPqeYag5HWEmtCOblYFnG70IGhukU27EMP0SZfsv18FLWaqkqEWQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypAVSQYNZlAAk3u3UjWQCNbxvlFyJ6ruTJlPWGX5uvWwiCHTMv
	+RvtJEWsv1dzSqxp+X/oL5GvOKCNVAzHCeI+xaLb50KgliSOXHBmhn1b
X-Gm-Gg: Acq92OGgvLFeWBeUN4Uk0dbgrMUgDdO/oVh81nnLSVGd1PtUe4XVua65S5jC6rpVRdP
	8uZSa32gAKtNofep9llRI5UZXulIN2afAbqpRI8Y+Xg4g2M8qqzE4BUGC4AlpCuVBEpEUQZUIqk
	+F6BuR9ILxCQYeajcmpk5nh7js6gMUcA41et12H9rThJtmVL3grzRACYMqXz2ymZ25m6VU6sJHP
	POvTHSxSDhOWiJ+kya6rrP+wW++mEYAR68RWFVCCT0piXoeCuXGdCdAd34T2c4eOWPVknVMOBua
	Pnr1wdCnSfksptmhz90Wj1LgquTdc13gJ6gJtTQmQUC38kExxI17k1aMJ59OQ9OfrulWVWvsmzE
	amfu7qgbW5/dZEGRXC07JIV6v789TAqL4U32fXvgZOn1Udd9nmHvkikkTr7jaUztUDCcgZrKGjz
	lpBZZmQhN9fPAt7JUs71POYG+JL+60IrPhlzyz
X-Received: by 2002:a17:90b:4b87:b0:369:c5f4:9681 with SMTP id 98e67ed59e1d1-37a041b0151mr899333a91.22.1781228082253;
        Thu, 11 Jun 2026 18:34:42 -0700 (PDT)
Received: from wanpengli.. ([2408:822f:1aba:84a0:651:104c:ba0c:1f4a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-37a1f07bbfdsm250713a91.5.2026.06.11.18.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:34:41 -0700 (PDT)
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
Subject: [PATCH v3 09/10] KVM: Add IPI-aware directed-yield candidate selection
Date: Fri, 12 Jun 2026 09:33:54 +0800
Message-ID: <20260612013355.59231-10-kernellwp@gmail.com>
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

kvm_vcpu_on_spin() selects a directed-yield target from coarse preempted
and preempted-in-kernel state. It cannot distinguish a vCPU spinning on an
IPI response from a vCPU spinning on a lock, and can therefore yield to an
unrelated vCPU.

Add kvm_vcpu_is_good_yield_candidate(), a priority-ordered filter. Prefer
a confirmed recent IPI receiver of the spinning vCPU, then an
arch-provided pending-interrupt hint, and finally the existing preempted
heuristic with the optional in-kernel filter.

Use the helper in the strict scan before falling back to the existing
directed-yield eligibility checks.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 virt/kvm/kvm_main.c | 65 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2e11c6cfc167..84cbd7a6183f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3963,12 +3963,51 @@ bool __weak kvm_vcpu_is_ipi_receiver(struct kvm_vcpu *sender,
 	return false;
 }
 
+/*
+ * Priority-based candidate filter for directed yield.
+ *
+ *   1) Confirmed IPI receiver of @me within the recency window.
+ *      This is the highest-confidence signal that selecting @vcpu
+ *      may help @me complete its spin-on-IPI-response.
+ *   2) Arch-provided fast pending-interrupt hint (APICv / AVIC /
+ *      arch_dy_has_pending_interrupt()). Covers cases where IPI
+ *      tracking was bypassed by hardware acceleration.
+ *   3) Legacy preempted fallback, with the existing optional
+ *      in-kernel filter when @yield_to_kernel_mode is set.
+ *
+ * Returning false asks kvm_vcpu_on_spin() to skip @vcpu in the
+ * strict (first) round; the relaxed (second) round applies only a
+ * vcpu->preempted check.
+ */
+static bool kvm_vcpu_is_good_yield_candidate(struct kvm_vcpu *me,
+					     struct kvm_vcpu *vcpu,
+					     bool yield_to_kernel_mode)
+{
+	/* Priority 1: confirmed recent IPI receiver. */
+	if (kvm_vcpu_is_ipi_receiver(me, vcpu))
+		return true;
+
+	/* Priority 2: arch-specific pending-interrupt hint. */
+	if (kvm_arch_dy_has_pending_interrupt(vcpu))
+		return true;
+
+	/* Priority 3: preempted, with optional in-kernel requirement. */
+	if (!READ_ONCE(vcpu->preempted))
+		return false;
+
+	if (yield_to_kernel_mode && !kvm_arch_vcpu_preempted_in_kernel(vcpu))
+		return false;
+
+	return true;
+}
+
 void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 {
 	int nr_vcpus, start, i, idx, yielded;
 	struct kvm *kvm = me->kvm;
 	struct kvm_vcpu *vcpu;
 	int try = 3;
+	bool first_round = true;
 
 	nr_vcpus = atomic_read(&kvm->online_vcpus);
 	if (nr_vcpus < 2)
@@ -4010,16 +4049,21 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 		if (kvm_vcpu_is_blocking(vcpu) && !vcpu_dy_runnable(vcpu))
 			continue;
 
-		/*
-		 * Treat the target vCPU as being in-kernel if it has a pending
-		 * interrupt, as the vCPU trying to yield may be spinning
-		 * waiting on IPI delivery, i.e. the target vCPU is in-kernel
-		 * for the purposes of directed yield.
-		 */
-		if (READ_ONCE(vcpu->preempted) && yield_to_kernel_mode &&
-		    !kvm_arch_dy_has_pending_interrupt(vcpu) &&
-		    !kvm_arch_vcpu_preempted_in_kernel(vcpu))
-			continue;
+		if (first_round) {
+			/* Strict round: IPI-aware and legacy preempted filters. */
+			if (!kvm_vcpu_is_good_yield_candidate(me, vcpu,
+							      yield_to_kernel_mode))
+				continue;
+		} else {
+			/*
+			 * Relaxed round: only require preempted. This is the
+			 * safety net for missed IPI tracking (e.g. APICv) or
+			 * transient runnable-set changes since the strict
+			 * scan.
+			 */
+			if (!READ_ONCE(vcpu->preempted))
+				continue;
+		}
 
 		if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
 			continue;
@@ -4032,6 +4076,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 			break;
 		}
 	}
+
 	kvm_vcpu_set_in_spin_loop(me, false);
 
 	/* Ensure vcpu is not eligible during next spinloop */
-- 
2.43.0

