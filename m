Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B362D7DF1
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100614; cv=none; b=PU3g88v/q9TmhdugjtaaWNdXKPIt/lb46NbxCLiGVx2aoHJMuWMQbWm1qfgQlhIcETcbf/9qdDRi9xEIu+dwTkS8dpCuAFpTuFyud2fQiIJvbZhjscO+BkxHmpKsvaPJkCCeUc+H6t92xp3TWWarpaofhRF20ACREMZe4eaQt3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100614; c=relaxed/simple;
	bh=TcFrdCIU/eLdRB40OcXqQhVamDIbW7fFaM4iPioZupY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a/GPtmxNi4jMETMk2GkLWC17ribyvdXWWg5Gp+U8KYxxOtErEG59/gaNw1EGeQx8mLCdo+i8Ljnn9UTV4R27P82yd36STjukJqH70C3tyLvlx4pilSjQzrB+Mf79Vdjcncy/w2RTOEmn0ZFYPSebYyubWI3xV3BvXXNXjRuR2Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J0eSl1gO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0eSl1gO"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-367bb9caa54so13198115a91.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100612; x=1780705412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8AMZSjjAVMXNbasa4YAYk1Hpbm/K3EtJ8vDdHI7VRcM=;
        b=J0eSl1gOjP9ImYvYHN2teGpBR7099yXvvVJT/2fRCyfSQFGcAIA5tN9fi2WNTqFGjz
         VViz/o5444FHiM6+ZDSKluh+xzGGtYswpg/lPsxNFLbUew/rckG0EvcsRriIPSzwkrtg
         DCvWpqNQV/ujEBd8KxoV4aVIXX0pIEZzUnHcHteSI7mU2+EOG+XI/h5OzK9Wqn5ycLCW
         p4ZTd6EcM+rRsIcrcY/wHNuUNsJEDEWoRjFBuGGyYSVQoL2/EOcU45QJ3fgqpRXGH8kq
         qecEZ6JtZQ8X5l0g6YoPLlH+PAH2m3YCr1VEdRot60h5JuUJ2enpgUJXeX5y8w81oxiu
         /O7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100612; x=1780705412;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8AMZSjjAVMXNbasa4YAYk1Hpbm/K3EtJ8vDdHI7VRcM=;
        b=joNpGQ9DvtlnipGEJn3w5eP1B4kAW46K6SwfBtkpG6XE6N5jaEEzkg1IT8RcXTUD9z
         o1Obu52ZQRSFMCYoIdasXdpg0jH2rsxUUV9hLHrnG0AlIWnVBi8aPlrPScL8UZXFjAUL
         iepXF+QrT4/LW0BME7YqYwdxAv6Lj+KFn3X8bu9y017BGiXag7w4yu55WD4iaansrhvq
         0Pq6ZAykemOSSh6cudvtbzLAy0EvU/kyBHz4B+QHc0HDcLQeSiySumUfJ9vevN3y4rVV
         H1YmI9DFW0aBJCJq02aufE4HQRp5lY1BXZVRc7cEc8HWgxEq1MCqrChY0vqweaXzBNco
         f6mw==
X-Gm-Message-State: AOJu0YxRHW6yc4KE2aai/K6MwWZvzGK22Nt4zcuJTklFwl/cGC3Ruco6
	bZpDj7Nc+3SWs4BHxVQ8jItqpP5ItSvrx+qPSbWtkdYbg8tV7Y3VurneMjaNqkodb12BjczVL5x
	R3VgPTEZX
X-Received: from pgu22.prod.google.com ([2002:a63:1456:0:b0:c79:67fe:6d9e])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cc9a:b0:398:aea8:a9c0
 with SMTP id adf61e73a8af0-3b427c690a2mr1614367637.19.1780100611348; Fri, 29
 May 2026 17:23:31 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:30 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-16-jrhilke@google.com>
Subject: [PATCH v4 15/19] KVM: selftests: Add pin_task_to_random_cpu() helper function
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a helper function pin_task_to_random_cpu() to randomly select a CPU
from a given cpu_set_t and pin the specified task to it.

This helper will be used in a future change in the KVM IRQ test to
migrate vCPU threads.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 21 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 499e695f1fc4..f725ab0ed4f9 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1096,6 +1096,8 @@ static inline void pin_task_to_cpu(pthread_t task, int cpu)
 	TEST_ASSERT(!r, "Failed to set thread affinity to pCPU '%u'", cpu);
 }
 
+void pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus);
+
 static inline int pin_task_to_any_cpu(pthread_t task)
 {
 	int cpu = sched_getcpu();
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index ebd04cf1847b..29cd649a54d5 100644
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
 void kvm_parse_vcpu_pinning(const char *pcpus_string, uint32_t vcpu_to_pcpu[],
 			    int nr_vcpus)
 {
-- 
2.54.0.929.g9b7fa37559-goog

