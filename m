Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B12E1EE0
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100617; cv=none; b=sbetstVY1xIh9ghknzhwONFoLtxnjwrOWeM368P0E6Un9xOzghGTluaiYeccS4exBgyTo6jiSgZbHE6EOTFF0SvcPFRK0dv4s7XSESY3P5DF8PxIepHZSDkTfbTYHPxq3+N0AjFSeJib+TQ9UIYyJ4JVn4tj8iLhQpSGKaz6f2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100617; c=relaxed/simple;
	bh=kHpMtpup6pJQOyEsscJ6R53ahK3JLy7NK5P7+EpKqXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sfaQ/SVzZCUEudkmlPoDWKalCLbRGI3+juZqNhBGM0wKkooh1dC7cOtEtaFqlEHPng/VTef/MW5TL62XViF4izAzFBX6q0D3GjW5y43HFLbMDJ/61Gr2Y15nERVFpQdnOXAweSm6TdgkyRkK+/IpAJF9/n421d8YEgErpfCQz4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0mzyBsT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0mzyBsT"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422f987f2eso11147b3a.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100615; x=1780705415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8JVFFS3ixiomAORGObVWJ+yUD++/pWXNo86z/Bpd9hk=;
        b=Y0mzyBsTKCqm2MQaycJ2SCmWY8HZL+GDIPo2i8Kj7EeMZ8FNb5QoC1oo++0fjB5QJc
         JZyyYqCUSWdlGKh+DfCh/1Fc5AGbWJjKBnGIRkM9G/YGKRVCHnZeNChDyDN/xuWvGCqi
         39MDNFauLNhBhQko7EpI++U803dW0iabLyU6bUmE8VCJBeGXUbWGKZFLpD2cfFzb1PA3
         79IZH7eWX2OqwGvU/DwziLK4QYpM9MBJOkVVanhfV5D/sbIb13aT1beLsHliDwX+g/n0
         LwrUEkkinWuh5uNSIULfu7MwaFK+3qT0GGKllD8+sioxnPdYm6FxGLGcUBDsmRVcC9OF
         hKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100615; x=1780705415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JVFFS3ixiomAORGObVWJ+yUD++/pWXNo86z/Bpd9hk=;
        b=CM2C+3LkhM+FMEk3GjYam3/INomS39/L074HOwPBkg7RG3ARExJRy1leC/onA/t0Lr
         FOY3/DEnmcY0qacOywvzJgIDmY8sBGCxa5emtcJNlfBT4S9xxSvdu51wbm4sOtSF9bwk
         5tXxAUAZ7r1tT9U5VT6jmrq0PrbKU6C5mlamisr+/7dxCHB3ZHZsuz6tBoP+ZMkn0u6L
         mZYeQbzS0fRTo1+UI7uTVW66OahtdUKb93F0Pqbq6ERfXPc0A55Dcb3ZjBIhMem/Eugp
         L3ULt5+PIMfnxiQHtK5mlLYlPeWgfweYJwHi7fWAvQbir67DYKuQ3wJ1O1/QH9suymIO
         J3XA==
X-Gm-Message-State: AOJu0YyTQC9hkUG7we5Wox6Ia1+BlLOT1JsrMq5uv+gGwSlJXCaBbgKe
	/fO4fbw15mNXkQoK9gdAI1ULtf0vavCXqOvC4dfSSU2L41DA0YOf26BEJhPmftU60ZASb5ZexMr
	SsuBgYDqw
X-Received: from pgbcs9.prod.google.com ([2002:a05:6a02:4189:b0:c79:3224:837d])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e58d:b0:3b3:be1b:733e
 with SMTP id adf61e73a8af0-3b4280a4e36mr1599545637.23.1780100615185; Fri, 29
 May 2026 17:23:35 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:32 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-18-jrhilke@google.com>
Subject: [PATCH v4 17/19] KVM: selftests: Print vCPU affinity on timeout
 during IRQ test
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
index f653317022e3..0db4ea4eb1ef 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -309,6 +309,8 @@ int main(int argc, char **argv)
 				printf("  is interrupt NMI: %s\n", do_use_nmi ? "true" : "false");
 				if (irq_affinity)
 					printf("  irq_cpu: %d\n", irq_cpu);
+				if (migrate_vcpus)
+					kvm_print_vcpu_affinity(vcpu, vcpu_tids[vcpu->id]);
 
 				TEST_FAIL("vCPU %d timed out waiting for IRQ from GSI %d (Vector 0x%x) !\n",
 					  vcpu->id, gsi, vector);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 29cd649a54d5..b2e534f331e2 100644
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
2.54.0.929.g9b7fa37559-goog

