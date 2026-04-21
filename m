Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922B33AD50E
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813416; cv=none; b=VdgYr0kJU136IyOcGc4jXP3RpKJZJJnW6L7xhh6T3QtlgSjM7+I0Af6Ux0VudndNTndIU/GhMfan5rpeIzco1lH8J1NvmxP+aP7xThTTICnNMxDqz9/uLLwPCQY+o2eastidtBHTd7f5K47dGQB9E5YmRKQGKuhHrrx6iWXLOqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813416; c=relaxed/simple;
	bh=4cnVa9ZZt3+B2TMTEd7btulyUDHWdkJ6QXPrVFuZKTg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CpNor4mC+ElZaozx3o2VoEkFMvR18O11CdKujxFpmrQNUdvsOaz1sh2VFafbkGiqWB9TDLKtoeS9JGmWv4vjD78SoXqxTFBubqR5Zlx1dFtvvMoYNW19xBb4EbqoTwg4+DKDYuXrtNWgyRdNCBjbxzHvFdrI7sxX6/MeRvo6YZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eEwrGwPR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eEwrGwPR"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa5ecd760so2016553b3a.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813415; x=1777418215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1SWlI+Mb08LTFyPEjXaQ1cgftdkltHpsWIL9YhvjdCs=;
        b=eEwrGwPRLDeNf2eHvqjJYOrnDgD68BuZFu2/AO0H85uZ1ueAZIHsx7vaPBbL6/zSgf
         zbwHCqJcE1JcTg8FQF22bDmJiGGn1GgLZbejXIdSg5tlkUdlDNanOh4pJ/rRO0xMRnu8
         u/Fi/pjzdiHL/ElXMnI0yY41O2ghBzzEyBLIKfIotFD2JrP+RP/7UWFNWsRzoqEUogrF
         iXMmmYRMJcSL9ANxfrOOBvuHDh7+YKg+jjJ1hIdJIvcVpiwmIeX1eicPvRxFbzfpx7d0
         OE0mqJBxzlh/2eS8yvjEhMhlxQuZ2A7KK2GKUQtAMj1/Gtuzv1L3cYvGEF8ehKtACxn/
         43fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813415; x=1777418215;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SWlI+Mb08LTFyPEjXaQ1cgftdkltHpsWIL9YhvjdCs=;
        b=jFwJ3yFKlSRvVLq+QAmgQUOMpRrIvWHCLBA/cWcV0H2s3KO2flP4ms2MMP3OP653nD
         MfI/x41TjB/XMkVxf23CEJhEk93NVb9GGY3P1Oi20WYljA2RKr5BnmqQYmHu8VCpYm2h
         c9q0sHVIGAhzxboaV2qW4MVhz55hqwsW+O88OvlV5LboTwfX97twAPkG2u4C6bq7kbGy
         rAyPKAeZH1r7Ld/gpuc3/xARlUulP5sOb8kPwSGIIgVu4m+vubBP7e0pge+pJXQyPnIh
         WjP62eX/xHW9AjFjGs++FxL9AbuVo1YKtEaWhlZj5f44Q1urhTTpYtOLzSpuvD4I97g9
         kgsA==
X-Gm-Message-State: AOJu0Yzc81hKrLPR+jlcEHEotsbNhgIJhkt7ToO2Hxt7iC81dwSXoK9Z
	oHrqhhRUxXX5Bg70n/ed/Pmhos/P8nIfT7ujZvQ5grlFlxKutI8C1OV6lUqGOn6zrUgptMgExM3
	AObRcFutE
X-Received: from pfgs10.prod.google.com ([2002:a05:6a00:178a:b0:82f:c180:a882])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1f18:b0:82a:5e9a:922e
 with SMTP id d2e1a72fcca58-82f8c94279emr23429942b3a.42.1776813414907; Tue, 21
 Apr 2026 16:16:54 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:55 +0000
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-15-jrhilke@google.com>
Subject: [PATCH v3 14/16] KVM: selftests: Print vCPU affinity on timeout
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Add kvm_print_vcpu_affinity() to lib/kvm_util.c to print the physical
CPU affinity of a vCPU thread in a human-readable format.

Use this new helper in tools/testing/selftests/kvm/irq_test.c to print
the vCPU's affinity if it times out waiting for an interrupt while vCPU
migration (-m) is enabled.  This provides valuable context for debugging
IRQ delivery timeouts when vCPUs are being actively migrated across
physical CPUs.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  1 +
 tools/testing/selftests/kvm/irq_test.c        |  2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 49 +++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index f725ab0ed4f9..0ec82088bc43 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1119,6 +1119,7 @@ static inline int pin_self_to_any_cpu(void)
 void kvm_print_vcpu_pinning_help(void);
 void kvm_parse_vcpu_pinning(const char *pcpus_string, uint32_t vcpu_to_pcpu[],
 			    int nr_vcpus);
+void kvm_print_vcpu_affinity(struct kvm_vcpu *vcpu, pid_t tid);
 
 unsigned long vm_compute_max_gfn(struct kvm_vm *vm);
 unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size);
diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index dd6a08d3bf4f..43338eb3ab41 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -306,6 +306,8 @@ int main(int argc, char **argv)
 				printf("  is interrupt NMI: %s\n", do_use_nmi ? "true" : "false");
 				if (irq_affinity)
 					printf("  irq_cpu: %d\n", irq_cpu);
+				if (migrate_vcpus)
+					kvm_print_vcpu_affinity(vcpu, vcpu_tids[vcpu->id]);
 
 				TEST_FAIL("vCPU %d timed out waiting for IRQ from GSI %d (Vector 0x%x) !\n",
 					vcpu->id, gsi, vector);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 83732c07dfda..f85e061f47fb 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -15,6 +15,7 @@
 #include <sys/resource.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/sysinfo.h>
 #include <unistd.h>
 #include <linux/kernel.h>
 
@@ -662,6 +663,54 @@ void kvm_print_vcpu_pinning_help(void)
 	       "     (default: no pinning)\n", name, name);
 }
 
+void kvm_print_vcpu_affinity(struct kvm_vcpu *vcpu, pid_t tid)
+{
+	int nprocs = get_nprocs();
+	bool first_range = true;
+	int i, start = -1;
+	cpu_set_t cpus;
+
+	kvm_sched_getaffinity(tid, sizeof(cpus), &cpus);
+
+	/*
+	 * Output format examples:
+	 * - Single CPU:  "vCPU 0 (TID 1234) affined to pCPU(s): 2"
+	 * - List:        "vCPU 0 (TID 1234) affined to pCPU(s): 0,2,4"
+	 * - Range:       "vCPU 0 (TID 1234) affined to pCPU(s): 0-7"
+	 * - Mixed:       "vCPU 0 (TID 1234) affined to pCPU(s): 0-3,8,10-12"
+	 */
+	printf("vCPU %u (TID %d) affined to pCPU(s): ", vcpu->id, tid);
+
+	for (i = 0; i <= nprocs; i++) {
+		/*
+		 * Iterate to nprocs (inclusive) to ensure that if the last pCPU
+		 * is part of a range, the 'else' block triggers one final time
+		 * to flush that range to stdout.
+		 */
+		if (i < nprocs && CPU_ISSET(i, &cpus)) {
+			if (start == -1)
+				start = i;
+			continue;
+		}
+
+		if (start != -1) {
+			int end = i - 1;
+
+			if (!first_range)
+				printf(",");
+
+			if (start == end)
+				printf("%d", start);
+			else
+				printf("%d-%d", start, end);
+
+			start = -1;
+			first_range = false;
+		}
+	}
+	printf("\n");
+}
+
 void pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus)
 {
 	int i = 0, nr_cpus = CPU_COUNT(possible_cpus);
-- 
2.54.0.rc2.533.g4f5dca5207-goog

