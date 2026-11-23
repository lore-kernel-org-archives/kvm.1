Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447991;
	b=T1UJxhfO2wSXHTGEtY12cUR9Byb0z59sj51/tvoj8nMkqv3se7ZlayEOqqj54ArNXWWM
	 aAG4A8CrxShBlF8Rxw6KTPUYlcb/Kue6PwgApCJT+wXZCAILzPhZNX22qmBzLHVr184Td
	 blAuJxuLh9q88F6bYeTnZ572Y/Gy6QzHbVSaETwmmFj0chUPT0dNrd6lJ9/BCW/GRfPll
	 oaDrZLlt1jp7EjhsFtgaYSBajTY+khJoyqD7wKkiuZDSOB3k76i9cc2z0bF0oNMmxnv9S
	 P3GrSqbeUzhjfmRWOMQ9K2uVEdVI3AavP38N8f/5aNSUqYhw6QNcEoKj+ef57LV6HTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=P0HmEkR7XVIgQImbtvtX44VFrjVW2UkwB3zPu47siq4=;
	b=Y6yLLawjrrw0v+rED1zW6UO4vLf50UNv74TFh1bVLlv8p1kcTvnCirwIQIG7jVIZF45e
	 Gp3d999wXmFTDvaQVqEo+tsdR1xIyykOpx5uFkqDjTEveWXn4dCxxeAY0uxoVDysMzNLc
	 FiId6sTCTN/3zkp2+TTS1hY7kT1FtyQAxlJ1nL+acCLXCBSENcy+ERS1g3JY2/WiKU3qK
	 j0LGTVoZSINtPHQr8GhCbC4tDsWSLLvsZAZa8WfUMMWv50HThD3q1FLSKkI39VWFcZ9L2
	 pN4qDNDe+XpRh9Rb1LOMTNI4A6pw8+UHEH6FARgXdlaxQaP28UoeOhTVElSr3Bkbu0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=FrKH2y0b;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D3D606A693
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 15:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43D3D606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=FrKH2y0b
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-38587f3de36so4146482eec.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 07:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1795447990; x=1796052790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P0HmEkR7XVIgQImbtvtX44VFrjVW2UkwB3zPu47siq4=;
        b=FrKH2y0bcC6ghR/xaOyppJpaHBu1yn4n87Ls9TabAolNslQAgG/twQ3Z1+G/743gMV
         PDK95QGtBr9ewAQbJ5o/JHBTywWh6J2ScA+qMp2LwSkxfRXX82JS//T+vAgeQd6f64AS
         Biatf0d2WhGETOH0uBjR5elCkvX17EvLbQhdfXHGviub1aem2eqdZAwGl3+sryDYSB6E
         GJmlyEt70FmxnX0kZW5SpaIWH0W7HrB618ri5TaBcCZbUyt5rbpKunPhyTRuzMkILz2j
         3aSLEpcURdQQbQDKE4HIgJiD+2s7j/KOy3hCluawHTuc38NM0DhNSz6QGH0FU1/7wY1O
         bqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447990; x=1796052790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P0HmEkR7XVIgQImbtvtX44VFrjVW2UkwB3zPu47siq4=;
        b=P1o6fBjjzSDTwvUj4W/ujrxiIafVwnbOKbM1N5FTcsqFd8uKspUs3zevJxhQ2JtpuR
         oe5ncTpFQOkx104yGU0gVbkbRUMvIuXRhXpHqyYfcpEJjVHtBaz8ExfNY94Q8cRjP2vg
         u1gpE0vE6KnwuSOsz0FCDcv5gcaIftCxE6BVjUtSiwTWSMQ/BBddWzjrnw811WBZ3f/b
         5PuoI9weHO3DZW3rfEQQJWdPguQKHXB0OWneh74QZVNvtvlzlgbekPsv8/2THf9rIgKp
         hYk0CpmhlB+lvBFaVO3xXth28JndM3fGSkZtulSrDAVAvQ65XFnZ12G0Ztkbsvfe7Orh
         89iA==
X-Forwarded-Encrypted: i=1; AL+hErFv7/7kTmMka5yJji8Bx5X2e0200ghH8u+CD92j7bOQbtGhj86k7L1xCRZ/GgFGpNR8NCU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RsXpcVhly/zKP6k5Zvawkodp9I60AQ8ukmMaMqbOs7Zip9K/S
	wKf88iNxNjHKM6irVXkunb/hThop4Wy/ObZWJAES5+zPF/XRatES4miMpRT8tVf/8w==
X-Gm-Gg: AZFdTZc9zw3YzisEVHBtqQob+IbkafvPPke2BuQ3GY6sVmU+l3xVJfRbUQiOyYLQXTq
	tdG1vuvjJPsx38zRvCTj2nYN8AXzobfyPmMIxyKr+VBljuJYPubub+OPyBNJNOoxfYHNAkllGcc
	Rd3BSmKXiFGFcIQKqHXxSMBSM92fec/O8kdQnEwJ3QqErTb4cdgnTt7H5ZDGdDZICYyY/8/Uk5I
	OysaqQGJ7LCwtIG/80h3yLq8wJqTx5PV96zo9pAQS52tD71YxZfKx1w3tTJVd2F830G/z1xo1Nn
	h3Alv/k5aCeSQcNcgO6eHbPvBTp3ClLQ21FgP+RX+++W3a6S3syyXy+Sh/lL1JoszJWwP4Y3iRH
	e80ULqQ4sibOAGxefgH6jvf5zkqEnmwmGdxFEYDC3phpW0rnulOw9UcsMgBjQ4U8mnHoLZunaO0
	bzLvbTyHjNjaPcyBpwKkSymsSQ5TT0LA/vtW7Idost2uUAYi6TfOddAY/AesByn9EPtS6f/vWuu
	sPAzfuJeYSgHZ1436FizMHJzQ5rkZaKGeDIu33s1EpELeEX3J0ltk0HCmGerScvevpk9UW7dncQ
	cnLAtN1e6qRAEAEzeUYP2jb+ZJPCypC3Ubhd+3yxzEbPRpFb/6Cd9dO4sxdtXSo=
X-Received: by 2002:a05:7300:d0a8:b0:386:9957:752f with SMTP id 5a478bee46e88-386995777f4mr8441803eec.25.1795447990313;
        Mon, 23 Nov 2026 07:33:10 -0800 (PST)
Received: from localhost.localdomain ([2600:8800:1e00:25f0:3391:10c3:1717:1522])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm34601237eec.16.2026.11.23.07.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:33:10 -0800 (PST)
From: Siddharth Mishra <smish149@asu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	James Houghton <jthoughton@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Mishra <smish149@asu.edu>
Subject: [PATCH 2/2] KVM: selftests: Test dirty ring pushes from vCPU preemption
Date: Mon, 23 Nov 2026 08:32:38 -0700
Message-ID: <20261123153238.1036972-3-smish149@asu.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123153238.1036972-1-smish149@asu.edu>
References: <20261123153238.1036972-1-smish149@asu.edu>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that dirties pages in a dirty-logged memslot that also holds
the vCPU's steal-time structure, while a busy thread shares the vCPU
thread's CPU so that the vCPU task is preempted often.  After every
KVM_RUN, harvest the dirty ring and assert that no entry is left dirty,
which fails if kvm_steal_time_set_preempted() pushes to the ring in the
middle of kvm_dirty_ring_push().

Require PML, as flushing the PML buffer on VM-Exit is where KVM pushes
to the dirty ring with preemption enabled.  Pass -S to run without steal
time, and -t to change the run time from the default of 60 seconds.

Signed-off-by: Siddharth Mishra <smish149@asu.edu>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/dirty_ring_steal_time_test.c      | 146 ++++++++++++++++++
 2 files changed, 147 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/dirty_ring_steal_time_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 17a4256e9081..ab4dff45d306 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -78,6 +78,7 @@ TEST_GEN_PROGS_x86 = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_x86 += x86/cpuid_test
 TEST_GEN_PROGS_x86 += x86/cr4_cpuid_sync_test
 TEST_GEN_PROGS_x86 += x86/dirty_log_page_splitting_test
+TEST_GEN_PROGS_x86 += x86/dirty_ring_steal_time_test
 TEST_GEN_PROGS_x86 += x86/feature_msrs_test
 TEST_GEN_PROGS_x86 += x86/evmcs_smm_controls_test
 TEST_GEN_PROGS_x86 += x86/exit_on_emulation_failure_test
diff --git a/tools/testing/selftests/kvm/x86/dirty_ring_steal_time_test.c b/tools/testing/selftests/kvm/x86/dirty_ring_steal_time_test.c
new file mode 100644
index 000000000000..6e65055e8c2d
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/dirty_ring_steal_time_test.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define _GNU_SOURCE
+#include <pthread.h>
+#include <sched.h>
+#include <stdlib.h>
+#include <time.h>
+#include <unistd.h>
+#include <asm/barrier.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "ucall_common.h"
+
+#define TEST_SLOT		1
+#define TEST_GPA		0x10000000ul
+#define TEST_PAGES		16384
+#define RING_ENTRIES		65536u
+#define DEFAULT_SECONDS		60
+
+static bool stop_hog;
+static int test_cpu;
+
+static void guest_code(u64 gva)
+{
+	u64 gen = 0, i;
+
+	for (;;) {
+		gen++;
+		for (i = 1; i < TEST_PAGES; i++)
+			WRITE_ONCE(*(u64 *)(gva + i * PAGE_SIZE), gen);
+		GUEST_SYNC(gen);
+	}
+}
+
+static void pin_self(int cpu)
+{
+	cpu_set_t set;
+
+	CPU_ZERO(&set);
+	CPU_SET(cpu, &set);
+	TEST_ASSERT(!pthread_setaffinity_np(pthread_self(), sizeof(set), &set),
+		    "Failed to pin to CPU %d", cpu);
+}
+
+static void *hog(void *arg)
+{
+	pin_self(test_cpu);
+	while (!READ_ONCE(stop_hog))
+		;
+	return NULL;
+}
+
+static u32 harvest(struct kvm_dirty_gfn *ring, u32 *fetch)
+{
+	struct kvm_dirty_gfn *e;
+	u32 n = 0, i;
+
+	for (;;) {
+		e = &ring[*fetch % RING_ENTRIES];
+		if (smp_load_acquire(&e->flags) != KVM_DIRTY_GFN_F_DIRTY)
+			break;
+		smp_store_release(&e->flags, KVM_DIRTY_GFN_F_RESET);
+		(*fetch)++;
+		n++;
+	}
+
+	for (i = 0; i < RING_ENTRIES; i++) {
+		TEST_ASSERT(READ_ONCE(ring[i].flags) != KVM_DIRTY_GFN_F_DIRTY,
+			    "Entry %u is dirty, but entry %u before it was never written",
+			    i, *fetch % RING_ENTRIES);
+	}
+	return n;
+}
+
+int main(int argc, char *argv[])
+{
+	int seconds = DEFAULT_SECONDS, opt;
+	struct kvm_dirty_gfn *ring;
+	bool steal_time = true;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	u32 fetch = 0, n;
+	pthread_t thread;
+	struct ucall uc;
+	time_t end;
+
+	test_cpu = sched_getcpu();
+	while ((opt = getopt(argc, argv, "c:t:S")) != -1) {
+		switch (opt) {
+		case 'c':
+			test_cpu = atoi(optarg);
+			break;
+		case 't':
+			seconds = atoi(optarg);
+			break;
+		case 'S':
+			steal_time = false;
+			break;
+		default:
+			TEST_FAIL("Usage: %s [-c cpu] [-t seconds] [-S]", argv[0]);
+		}
+	}
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_DIRTY_LOG_RING) ||
+		     kvm_has_cap(KVM_CAP_DIRTY_LOG_RING_ACQ_REL));
+	TEST_REQUIRE(host_cpu_is_intel && get_kvm_intel_param_bool("pml"));
+	if (steal_time)
+		TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_KVM_STEAL_TIME));
+
+	pin_self(test_cpu);
+
+	vm = __vm_create(VM_SHAPE_DEFAULT, 1, 0);
+	vm_enable_dirty_ring(vm, RING_ENTRIES * sizeof(struct kvm_dirty_gfn));
+	vcpu = vm_vcpu_add(vm, 0, guest_code);
+	kvm_arch_vm_finalize_vcpus(vm);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, TEST_GPA,
+				    TEST_SLOT, TEST_PAGES,
+				    KVM_MEM_LOG_DIRTY_PAGES);
+	virt_map(vm, TEST_GPA, TEST_GPA, TEST_PAGES);
+	vcpu_args_set(vcpu, 1, TEST_GPA);
+	if (steal_time)
+		vcpu_set_msr(vcpu, MSR_KVM_STEAL_TIME,
+			     TEST_GPA | KVM_MSR_ENABLED);
+
+	ring = vcpu_map_dirty_ring(vcpu);
+	TEST_ASSERT(!pthread_create(&thread, NULL, hog, NULL),
+		    "Failed to create hog thread");
+
+	end = time(NULL) + seconds;
+	while (time(NULL) < end) {
+		vcpu_run(vcpu);
+		if (vcpu->run->exit_reason != KVM_EXIT_DIRTY_RING_FULL) {
+			TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+			if (get_ucall(vcpu, &uc) == UCALL_ABORT)
+				REPORT_GUEST_ASSERT(uc);
+		}
+		n = harvest(ring, &fetch);
+		TEST_ASSERT_EQ(kvm_vm_reset_dirty_ring(vm), n);
+	}
+
+	WRITE_ONCE(stop_hog, true);
+	pthread_join(thread, NULL);
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.54.0

