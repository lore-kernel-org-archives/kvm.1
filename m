Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6274038C402
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228088; cv=none; b=OYZaS5Tr6wcvLHBQlATx5u9A6yJXNZ4oM+xdXV+eZH9T0p1H0uox8ZysHIrcAK/dnjWHo4/i/tiumel1XyhJH2akgGH4euymDTml4U5y46gBnPTIY32eU//JFgi/DXPc1UJD5DxmiS4x+nouN88AEipygHk7O5+VTcc2ZFCRAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228088; c=relaxed/simple;
	bh=Pt0kJwgUwlLNl23Jnnw6Rx+m3BWoC0ybefPFydsyusg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D22+/VhthnaIimxcgX+ekOgqr4T0w8S8eB1yY0GjvYR1BiMydjoo+/BdpiqFJOgKEPtQjTJpEYsLX5kD7XZnRJx7ZLsKHmPfXgY04Sbnd2KHnf3e/blwl5MLfHyvQkNbWZtEnAr9nyj53xHc7MHlvqiuPHTA5pnp75DdOANcHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/tzZCiC; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/tzZCiC"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36da151a152so394495a91.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 18:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781228087; x=1781832887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJDxKofU7sziA4xb8cmnLTJQqmBI/O7ABljJar8QvjU=;
        b=X/tzZCiCPAPcZPi2WqX1tperdeioNz3ZWUvQqUAiVeGIuj4pNCD1fZM+bsH2ndbFcM
         wwIawSPdEGbWWZYYfyDjmvNXJBFYuNhSP/k9h+NUUp+qw69WESJlU0ei30wEkRpF+0ar
         dpYuzSbVi6mSfv5TmUH1c3YmrnQ2ZzXWTJZICzwO5nFFwJqotH+ZIfIyaxe2IUZdCW0i
         5CWvwJbRq5BdEjkmmEIiBpceqbumjGKurQGQD3WSD/MoQkh6ydqoIhdZeX3T4tNUUzhI
         gEZ8BASvqNqzTd4bT1M8dD7UgzqID0feH0n2qRwU/iVi/4aBbkgSSLmG9Zys7uQ0QdEn
         hpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781228087; x=1781832887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cJDxKofU7sziA4xb8cmnLTJQqmBI/O7ABljJar8QvjU=;
        b=APbuHfmJh6KdtZx8CeiHL53Jq9xwREJ2Apmn42xAuOdx//mGQ3dxyd3BIlbWNzyOUt
         D/86a1FDO6ta1y3Szoje6Z7juNPbV5JczNfB0jN/ASHku+KJjM1k2tMpGOjIqtZ6wPta
         lDv+eh931LgQkCk2P9iH/SXnJ/oinCXmCiei3JRPMvCmJmjrrkgolL6XZmcR5n2yh+ZM
         aezyhjEr7GEI4j2Axykkv2VTRyPPaR1b4QwtJ1kN20imT/5zxn23aLxEU1L5TpK8nPG1
         sDCP1hOu1P4sEBTeAcpfCbJjJbJcv5x4tNkN6WSo9aJkL7g/sE4uI4aranPWJBJEfs0C
         JWbw==
X-Forwarded-Encrypted: i=1; AFNElJ9S+y78ntK4NuFy0VYwsv+XpWEjLJXmDDPacQ3u5p+0OyBalkDh4IBQIBFyUWi/62LVBiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzleQcj8gs99V79u0x+dTJhIBxMxYKBMttXIagewufU4d+d3tjj
	xiLb4lfgl/0lya574VgonTergaGyQz0I88E8W3coPirAl20GJQpDYjl3
X-Gm-Gg: Acq92OFlIgKB7hi3wGe1lUAV3LEb8FcE5UK0tk5g0GrdPMVbkrRUFnnFVs3Qc+zY5Su
	Or5y4ChMuwSESw4WiJ0Tvyz3UkTIs17melVTDCMwn4HF0GuDj2E8k2qyccBTOjUbyaj0hftGUmv
	mfNQ8o2KkyIEd47Z5P3J+JQx9/rm8RU5hA41TX9u+l5m3wSqJnxAx77KW11WBOpNtxTjIv+J6kw
	kGbv4U31qcuD5xyR69v8Hvrc6yLzU4bFsg1NNuvRcof2KnhXGxQZweUOTy3APHHbvkrETdQ/b+1
	UzWtbQmoCe2xRY5p5xVOa8oxVJIJKBdkFdj8zufyg++btj4KauCXarTozVP7rfN7ApbmZFMkOjO
	eNUAXrXTQE5ODJUbhJLMxLnrnn5ZyEpoWng1B5BY8mPTCBVL/9asWaElhti4UCtC5yTCl4PVGev
	iAIDWJBG8ZMbeV6a6VeyhzAjYKIQ==
X-Received: by 2002:a17:90b:2249:b0:36d:70c8:3a1 with SMTP id 98e67ed59e1d1-37a037e2860mr875406a91.13.1781228086534;
        Thu, 11 Jun 2026 18:34:46 -0700 (PDT)
Received: from wanpengli.. ([2408:822f:1aba:84a0:651:104c:ba0c:1f4a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-37a1f07bbfdsm250713a91.5.2026.06.11.18.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:34:46 -0700 (PDT)
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
Subject: [PATCH v3 10/10] KVM: Add relaxed preempted-only fallback for directed yield
Date: Fri, 12 Jun 2026 09:33:55 +0800
Message-ID: <20260612013355.59231-11-kernellwp@gmail.com>
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

The strict IPI-aware candidate filter can find no target if IPI tracking
misses the relationship, for example for APICv-delivered IPIs, or if the
runnable set changes during the scan.

If the strict pass yields nothing, run a second relaxed pass gated only by
vcpu->preempted. Control the fallback with the enable_relaxed_boost module
parameter (default on), so it can be disabled at runtime if it causes
over-boosting.

With the full series, PARSEC simlarge on 16-vCPU guests under host CPU
overcommit, latency reduction:

  Dedup (IPI-heavy synchronization):
    2 VMs:  +8.87%
    3 VMs: +10.29%
    4 VMs: +15.60%

  VIPS (balanced sync and compute):
    2 VMs: +10.23%
    3 VMs:  +6.63%
    4 VMs:  +4.50%

The IPI-heavy Dedup workload benefits most, as the confirmed IPI receiver
is preferred over the generic preempted lock-holder heuristic.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 virt/kvm/kvm_main.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 84cbd7a6183f..a327acb198de 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -101,6 +101,19 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_shrink);
 static bool __ro_after_init allow_unsafe_mappings;
 module_param(allow_unsafe_mappings, bool, 0444);
 
+/*
+ * enable_relaxed_boost - second-round safety net for kvm_vcpu_on_spin().
+ *
+ * When on (default), if the strict scan finds no eligible yield target,
+ * fall back to a relaxed scan gated only by vcpu->preempted. This
+ * preserves forward progress if IPI tracking is missed (e.g.
+ * APICv-delivered IPIs) or the runnable set changes mid-scan.
+ *
+ * Disable this at runtime if the relaxed pass causes over-boosting.
+ */
+static bool enable_relaxed_boost = true;
+module_param(enable_relaxed_boost, bool, 0644);
+
 /*
  * Ordering of locks:
  *
@@ -4037,6 +4050,8 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 	 * they may all try to yield to the same vCPU(s).  But as above, this
 	 * is all best effort due to KVM's lack of visibility into the guest.
 	 */
+retry:
+	yielded = 0;
 	start = READ_ONCE(kvm->last_boosted_vcpu) + 1;
 	for (i = 0; i < nr_vcpus; i++) {
 		idx = (start + i) % nr_vcpus;
@@ -4077,6 +4092,15 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 		}
 	}
 
+	/*
+	 * Second, relaxed pass if enabled, the strict pass yielded nothing,
+	 * and we still have retry budget for -ESRCH paths.
+	 */
+	if (enable_relaxed_boost && first_round && yielded <= 0 && try > 0) {
+		first_round = false;
+		goto retry;
+	}
+
 	kvm_vcpu_set_in_spin_loop(me, false);
 
 	/* Ensure vcpu is not eligible during next spinloop */
-- 
2.43.0

