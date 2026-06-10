Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013D309EFC
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052844; cv=none; b=lQeyhmZEuKWvDEpwb16n2RVIeGMHnGVMeDmrPRzY1dZ0H/9nI0yZwEDu318GpVpt6HleUfucrZdVxwvL7w6MP0n0Z3kUgktEsDeryEgV79mne0vm9UIHEp2aBCXl4WLQmMZApsK4SK6nh+hOR5SZopww7zOXHTbhSJGFdvXEpps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052844; c=relaxed/simple;
	bh=JlooIplFY0tapZ4KHCVZzqX1ug3glWpGzl8vxECWm74=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Us0J3RD5UoohqPr+JVL/RxSp16rP/s0G0zLOQd2kKT4ep91sh9JRs1Qxjq18aNkhkXeyX0Oamt74BUzyVZPJy/HIEodP4pFU5m/aC4tQmraLq53XQoUzYJ9nU3HSKQBHBFvAmA1Cbqk7Eie/dVP7+eucbwbk4dS7CBt7vog4CLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UidSsVs5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UidSsVs5"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423f1fe39eso6740649b3a.1
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781052842; x=1781657642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=i+ncGA6Fvns8f5sP+kNiRwZfNV+IfAKagrqzhgLKDtg=;
        b=UidSsVs5pEagXBkDRhiJZQxl3C2y9BWqt3kDNbsKI6qIOPJHwBDZUuqzGOgbJfRuaa
         SSW743JlgVA4GoTLqhYw9QxD0Xnfo3PqZCfewSyCfRsDZebiH77kgt152TjRJQUHB9v7
         omD4cQtj/kUsBy3Rt/Od6y8G6b7eeu455AGeahKFn48x09dKitFBJXc01XVbj+9u7Q7J
         APEnZNVRK8EYMAA1ntal794dk66OHyVkF/HSPqQcrI359c09ZVFwpQyE9CjAhAIQEzJX
         5A5y417WTDhGPBZH4JjKmf18biL7NC/IqaWRy0rrjFC/3KcNMvxfitCG71sS6tsai6DX
         tEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781052842; x=1781657642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+ncGA6Fvns8f5sP+kNiRwZfNV+IfAKagrqzhgLKDtg=;
        b=LG8OQJqzlkKvWg/TUPWZ4wbITMjCQVnR/ROqdkS9SHWZN7xYXPnKAVzL6FqmZ2Gww5
         c/SnzJyU7KA7lRCcaHU/X9K/58UZBaWCxj9a/DLy4e5LE0GC6p8ShdDNsS3+yCq3qaF2
         RsLlaEdbreGyQ8X/z5eebONLrylXsb9b0rOzcEt7kQLa4UjFj3neTUhO/f2fFMZGyuJT
         i6uynirULwu4kcOnDwKJ3nA6hkvhKm3u5qatHi1v+ouxDjd+UgLa4taigHLVKaA28gnP
         ifq4ny5OyO1kj89/tYh4ntBKfqBrDnTw1gyw/nSVeevA54rkIA0LIOY/Bm71WRCf6GhE
         acyw==
X-Forwarded-Encrypted: i=1; AFNElJ982h9aipcKSeZFsvfolCmSRJjsB536IaeU0xusHcC43UlrIA2/kB0T4cQMyYf3tm2tbfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxNwGcqr7dzge2eBHsdE2USWj6cAU65sWZOPw/5rVA81ytaSmB
	xMUlgFRynpVkQw14JRozwBOrjr8YH6col/HUf39mI2eZI9KxHYglraOBtMOHSjeebMhJ966Yehk
	ODoz0eg==
X-Received: from pfad10.prod.google.com ([2002:a05:6a00:28a:b0:842:84fc:f4f3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b90b:b0:82a:6461:6d15
 with SMTP id d2e1a72fcca58-842b0f49acamr22128319b3a.46.1781052842229; Tue, 09
 Jun 2026 17:54:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:53:35 -0700
In-Reply-To: <20260610005338.2967132-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610005338.2967132-16-seanjc@google.com>
Subject: [PATCH v6 15/18] KVM: selftests: Add a utility to pin a task to a
 random CPU, given a CPU set
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Josh Hilke <jrhilke@google.com>

Add a helper function, pin_task_to_random_cpu(), to pin a task to a random
CPU from a given cpu_set_t.

This helper will be used eventfd IRQ test to migrate vCPUs to random pCPUs,
to stress host-side interrupt routing and delivery.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 21 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index c1f588154398..b39e713c30a4 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1094,6 +1094,8 @@ static inline void pin_task_to_cpu(pthread_t task, int cpu)
 	TEST_ASSERT(!r, "Failed to set thread affinity to pCPU '%u'", cpu);
 }
 
+void pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus);
+
 static inline int pin_task_to_any_cpu(pthread_t task)
 {
 	int cpu = sched_getcpu();
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 92013883f35b..72f41b15594c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -662,6 +662,27 @@ void kvm_print_vcpu_pinning_help(void)
 	       "     (default: no pinning)\n", name, name);
 }
 
+void pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus)
+{
+	int target_idx;
+	int nr_cpus;
+	int cpu;
+
+	nr_cpus = CPU_COUNT(possible_cpus);
+	TEST_ASSERT(nr_cpus > 0, "No CPUs available in possible_cpus");
+
+	target_idx = kvm_random_u64(&kvm_rng) % nr_cpus;
+
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (CPU_ISSET(cpu, possible_cpus) && target_idx-- == 0) {
+			pin_task_to_cpu(task, cpu);
+			return;
+		}
+	}
+
+	TEST_FAIL("Failed to find random CPU in possible_cpus");
+}
+
 void kvm_parse_vcpu_pinning(const char *pcpus_string, u32 vcpu_to_pcpu[],
 			    int nr_vcpus)
 {
-- 
2.54.0.1099.g489fc7bff1-goog

