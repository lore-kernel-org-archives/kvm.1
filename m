Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F88121CFEF
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310063; cv=none; b=uVhs8FfC1ONm3m02HMjdd5I1p/QAMqMyF8U9HZt9cCCLVL8tM5uGWJ8wx4AuudlEuPf7Ciaytmyd2Mqqh0HeiJD8y8An5PcAY8WDDoSTsFc3qazCA3np84uYDAjVSO8EI4CL/Z62+JErmKZJPp6X0JI2oURvbQFUGMpELE8Yenc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310063; c=relaxed/simple;
	bh=TObSNBgjkInxJGjw2YdLrOBZhaJqdZwS4UxfQe0WJjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qvrmwSUkmvVB/MnxdtLPsIl8Qx4Vu2HgLx9RE7QkZLJdyOdZq699RwIRA581Xl0JTJ7JHJlY/jWIob5IKAVfOE9HehqUxgQXNtWKxjabLNz02Qpbm2ddgvi3tDktVNEWnROOOLEaVO4Klpm2TsvsB+HAdnV/zpyS2VaNEAEAbN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aBfUm9ez; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aBfUm9ez"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c858e0cbc89so843302a12.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310057; x=1781914857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=INXzSK5pqsexbm4tR/dA1tSz1dz6sV9VupQoZ4YYg/M=;
        b=aBfUm9eznID2tCaG7fVeMUjZa+ErtXUfCgMOmf7d+UGeIQefb0iypvndYlvcVQ0xSu
         QmFmrjF0fKZi8gGOb59uRpKT8IdmEvg/a5naxVOTARvO7KxA/Hn2IlXCHn+gzpu2rw1W
         thaDkPpzBTOTi9V/Nsw2rlkTmnEKIBA/T1wAP4vg0R0U7EV/mIcKXsF0wJNdRKyfEE/j
         7VH4grH6ZdpPqe/QQLMGLVOrDIUEjYstY14gAokx6FZZJLTpj/YYRPPLFn2dOgwqCDUe
         EGFiOZcvM8/HK1ZTqZz7JvU+G4QvBggyywaLWuncVfAbAVJYvc9jwxMu4xDNGzVO2BNP
         vFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310057; x=1781914857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INXzSK5pqsexbm4tR/dA1tSz1dz6sV9VupQoZ4YYg/M=;
        b=eE6+gZZnsVKS4zevh5NgOBQo7NULWNaflmXr/skak2NdUoxOc/itLHgTOxujsx47MJ
         +P+7Pg68hQLQYmKehcswv8Bz6Q5Z5mSW4K0bn+gOj/nGnh9ous2kHHqUMu54gK8n/xhu
         YA9KB3eBnon7R2Fanh2S+uN8GcboiDPZ4T1UUEQmbDfGimezoX9o4sg1rZi3cgEvxnh2
         Bzf/GTEo/1ssFPBSX/UAZ3kaptUVytA6jgJ3ibiJ29EC4UDCzMosaq6wBJDyS3xzM0Gb
         VkGFtOWB1XW0sgsHc8QgHTfM9JgoamXH1sOBSCIEUq/BuKZZAKrworC+R91VPeLZwvBo
         x7ew==
X-Forwarded-Encrypted: i=1; AFNElJ/aMr+KFS0xoRt+66m4ZoKz68YO/+hCBVvUXSqajHIaM+L4LbuLQrf16nKsjhEcNDruTLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMOO6m0t0mP84+mW6PuIW0RKgdUFrNp5rkDpZ0GmNKfUbIcFe
	Rl/+qF6E6wth4Cy4elfar2ta4b/PWimxH4jx6+vBgewxASH4IJl8V9jmiS/dnfknDlot80wcWTc
	MPdTDyA==
X-Received: from pgbcr12.prod.google.com ([2002:a05:6a02:410c:b0:c79:3224:837d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6da4:b0:3b1:80c7:5f8c
 with SMTP id adf61e73a8af0-3b783f3c781mr6308620637.28.1781310056984; Fri, 12
 Jun 2026 17:20:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:20:28 -0700
In-Reply-To: <20260613002031.745413-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613002031.745413-18-seanjc@google.com>
Subject: [PATCH v7 17/20] KVM: selftests: Add a utility to pin a task to a
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
index 9bf28b7d9d7a..2eee1e46f9e9 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -667,6 +667,27 @@ void kvm_print_vcpu_pinning_help(void)
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
2.54.0.1136.gdb2ca164c4-goog

