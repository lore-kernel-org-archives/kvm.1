Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EBD3655DB
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538570; cv=none; b=Nw8EQAfC9uXyie2dCAUrouoqckmCrEDc8uvg7M7U+dyADZfJtJH7qDVXtiEd4vhrnmSL/yaVD6ZXk4dGL+WeF6lXQ1TsLkN5rG67SWkZKYVMggfXGHyHOKISiJUhS2UGwPbp30NVExuEeBl2LCZ+CemrP2krBsHr2taEQQMHMAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538570; c=relaxed/simple;
	bh=pL8YPf5lVlSz8x/nILJ4nyVQiNlnQ496QrJe69U0+Dw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DPV4NpHTiHjnl/JIqOXCsZv2AWitosN/LnLAS8SJJO2iyZs/irB6OHGuXbqsNBqVM8GYPrpaHXwI6ciO1VHnnYxqBVbgkERv219us17gHNvkgxrHyzorapWt86MCzazsa6gjvTbtFQIQ7tBzs3FGG0UCrWwX7f5u8ITQo50wHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=avhKiL2q; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="avhKiL2q"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf1dece2ecso2344845ad.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538567; x=1781143367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSxc/jK0Y5Zc8rsqIx/UM7MOPm6sv49R27dtlFb7iI4=;
        b=avhKiL2qecJ5wFcrGljSxGI3VidUNB2rR/f5VMo/FH188gK6tdWRi2MQOYapmRtIyw
         Xk6jd0zdxOnlX0322ewalu8nwy2L7UCnfXvaQHtyFOtiwYQpCyrJgrWSh80TOwWXybZX
         +zE6ZLR5jq579FYFrPVVlOCGPGIid7n3HoAU6ph6lDmPlV0OUdcFe2UvaVKSNw8bLllq
         RaFwkElFF7OT+9Fjd7CXRiM5qrAbP5AeBr94YLOJtr+rx9A0sr43O2nCAiBZfhZLIFa4
         u7AoidfguLMBMV9VQoOMIYl1DsBRIhRqSO6XmDfzBcnmwCmgVeWkQXKwIaUwuHmaUjC0
         LSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538567; x=1781143367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSxc/jK0Y5Zc8rsqIx/UM7MOPm6sv49R27dtlFb7iI4=;
        b=r9okjbJdgtv6Wljs57sDrgo7CRdWTEquCIERJdZ8kMHeVC8RZoT08+cMs35ThuHP+u
         2XkfoKycYIIc0gq6m9ZF1naT0LIdEf7dGZuWQbKV7o31erIG2DPmKPmLU+NrKuObDmhF
         V0REzkv4XqpsW7Rn5NEiRQif3oCco1ua+/TfGk+kHSJmoyBvOzkljMR5vN4adqn64oEh
         6d+p12TzihCsKaGu9RS2KaEPBpIuBHcdqpac/C6NMatsL48T5r8N1ewheDFY/cJ2YxZV
         z95bIHV5ichsxcHdiov9sdbVOlem7mPEmtxZdY27Kz+zzG7RKI4Z/WAI/o9F6wcSwMQ0
         kzNQ==
X-Gm-Message-State: AOJu0YzJQh9Xq5tNELzERS58e6esFAI4L3g+3WV3MJTmX1RNKtMppaQ7
	g398CLBg/7tIky6dalRM1HbrATfLpuzq+FfIjLQFlPwchEMMEXEmmmS5TtRmSMVqRg+rqyHSO6r
	HaIRzcYgQ
X-Received: from plgo6.prod.google.com ([2002:a17:902:d4c6:b0:2bd:55dc:a132])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c6:b0:2bd:a5e:4c66
 with SMTP id d9443c01a7336-2c163a53619mr58703835ad.14.1780538567281; Wed, 03
 Jun 2026 19:02:47 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:41 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-20-jrhilke@google.com>
Subject: [PATCH v5 19/21] KVM: selftests: Print vCPU affinity on timeout
 during IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
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
index 5968d04a77ea..18b9e9713d78 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1117,6 +1117,7 @@ static inline int pin_self_to_any_cpu(void)
 void kvm_print_vcpu_pinning_help(void);
 void kvm_parse_vcpu_pinning(const char *pcpus_string, u32 vcpu_to_pcpu[],
 			    int nr_vcpus);
+void kvm_print_vcpu_affinity(struct kvm_vcpu *vcpu, pid_t tid);
 
 unsigned long vm_compute_max_gfn(struct kvm_vm *vm);
 unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size);
diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 5f7df76005ec..1d66293b6d0b 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -319,6 +319,8 @@ int main(int argc, char **argv)
 					print_proc_irq_smp_affinity(irq);
 					print_proc_irq_effective_affinity(irq);
 				}
+				if (migrate_vcpus)
+					kvm_print_vcpu_affinity(vcpu, vcpu_tids[vcpu->id]);
 
 				TEST_FAIL("vCPU %d timed out waiting for IRQ from GSI %d (Vector 0x%x) !\n",
 					  vcpu->id, gsi, vector);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e538e6147ec3..7fc3aaf76379 100644
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
 	int target_idx;
-- 
2.54.0.1032.g2f8565e1d1-goog

