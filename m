Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873B34B1A3
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538568; cv=none; b=qk//IX/IZ652ZE8U+59l3qOmjDZ2cSZZd9GeA9xVd0wodLqaSNfil+Hg7kWqnJu0xQDLV++F6TNfA5/AfpkIK1KD6g1DlRciuGgnkmh5P+Iv1uhw91R245AePm5XqkyxYyLAxmxFSP00J/Kyl8xVy5NZ+sX/peCPSOkZqUIv4B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538568; c=relaxed/simple;
	bh=3t/DAyGvNL0/LW/JOD2fGCS4PNVrVIn6BhFfqveDG5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OlvJwSaXoYaq+VXAYabOdSCc8hrVnsr6YzNxR0dWKA3LUSeeW7ceX68QkoCfQVZ7XW0tUNRy57W4EiuGrlNitKcanOURJLXZoxYGT/YuC8J10//aDbQwE3KgQUSbBV++45pQkBzWrPNOJ11D9DToZh2KXjszt898JE+7HplZ4ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jWKVscqa; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jWKVscqa"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c3315d31so2250195ad.3
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538566; x=1781143366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cusk696wlOPTxoLpjL8sQnvno9DNsartad/zeYEHRE4=;
        b=jWKVscqarIpG57yRK8ideSo+LT/vaS4ohTXk9mEezWuqcZ3fMhkw7M3alDRqUh8H6A
         m0uGQe3TAmBPLTV6xFcrH8XssH6NZXyktGPqhCKcll1Cb8GoMFLPWF+DAHp0e+aVNhiL
         H7CH6k1DiKQ7n5bHaVx3+AbhetQu950/vspcGGql7t/4AXZNXx4n0dn5AyJz//ABEQBN
         aVUk5jtPYnbrh7tc80cefa3qP+/rwiUTDMo9ik2XKGc7TfAeTBup/35U7KbincJ0fg3N
         rfNt0pu+1vFQ6E1yusAxe6l3RVypnph2Xvqkuz2xok3I6DCAXW3KcD9QR5AWoQWQSJeF
         y7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538566; x=1781143366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cusk696wlOPTxoLpjL8sQnvno9DNsartad/zeYEHRE4=;
        b=ARS6XIl5rjyIw4J7zjjPJd79Opg5xUSHAE+OJDJk9J/RZkKtp9/kWC5bn1qoNT6f91
         snM5zdta67dX9v6R8eGwO/K8SknLNIi/ZrTrcX+QITg1v61QWWxC0vpvZaGUMgHSC0mK
         ie7vS4t9kHzGdAhHheZ8YO4z+P8GBmSpoHXkmWv8lNnS7qA9gwU2dTlu0f4mZQ4EUyYk
         jhTMDOJ8gju28FQJPg+8En6flLDf6GH5a3Czr/3pLsaQhOn04vCA1Ve513Psrxqc+Amf
         JGv7ucgkZqBRza54dU4ITIMitx8pdDSNDi+ZRgkh+SQeEuTeQY1oVmraoyaKMRxvtgqz
         Q1xg==
X-Gm-Message-State: AOJu0YwSpbKfnpQQs847qKDyNw6fWMxwAr6G3qQ3tC04gfe0wHN03DVc
	m8ZWLJ4ZIuiajV5PT2OO1QFANHg1ESWrvZGUfceS/uxTux+KAN1GCXrI5RpU2h2o+gbBtMDs5Lq
	VZMEm4Zi8
X-Received: from pldb6.prod.google.com ([2002:a17:902:ed06:b0:2bd:52b9:305e])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b28:b0:2c0:c625:4019
 with SMTP id d9443c01a7336-2c163fadcdemr62034665ad.25.1780538565666; Wed, 03
 Jun 2026 19:02:45 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:39 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-18-jrhilke@google.com>
Subject: [PATCH v5 17/21] KVM: selftests: Add pin_task_to_random_cpu() helper
 function for IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
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
index 88211d696a11..5968d04a77ea 100644
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
index 0089d4543f5e..e538e6147ec3 100644
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
2.54.0.1032.g2f8565e1d1-goog

