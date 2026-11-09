Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214197;
	b=muVKD+nMGuNkbjQsJT2uI3vt3FdGs2h6DxMbvXGN/kxsoXRtyoXDTgXy5KeTcfG1yEfx
	 zyFLL4r1yrHEkXqks28CKGQ1cbOhsxPqoAQqVoyWmED3L1BuQr0/gnfCdDHBB3NfgP34r
	 R79kRBebI4JromPzxJwpy7941kr+wnSFjg2muSTsr+RF7bcmf8uHdOmsOM2DqJfP3RoES
	 ti94RxR8jCmigwfQd/YIlpJgbThAgwJ/zRlluUwfau7K2vu4hDJvT8HgOxh5SOS1X2PJP
	 7jRg1LEnEYGeIBjgTNwN6vJC3NYO4MApATrNsGUBhnjJWplPiXODiK1dtXXGHpWBEkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214197;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U2XBWSBfcfQCqve1wrsykzKjay5QUHR6JzVkYSHce1U=;
	b=UI/wARtHiXRSE6zVqjuZmAT9E5XevYbn+8b7+nzgjMQ5qk6Tz2TrGeMYpygaOF168WYF
	 DlvjVALzqzYa/EIdCm9v7BP5C8NqDIDRCJrJNqPEMMrXxmYxoHsqAvJbCNNZKD475MP2N
	 yczP1eMfjVU0LXCrvq2eYti/DS0MXPjj1IMoeyQdxnbkmnXTgAvIo43u+rm2jSvTwyrnA
	 phAgbVvtFHJPdXVwVLG/u00m6ASm2BW0R+xzcHUsN8jiZJc6CxohR7P9R1iQhFCLVUKMq
	 V1IMVss22vjy1ewGxKOL+yWPZzM4xb9Fs2zILA0ue+D6EqMy1uTsk61CYwRYAPV6Frg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="rs8ZZ/2Y";
	arc=none smtp.remote-ip=95.215.58.50
Received: from mta1.migadu.com (out-50.mta1.migadu.com [95.215.58.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B6606EEAF
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 08:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B2B6606EEAF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rs8ZZ/2Y
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=p3Len8xL7Q9ENP4Ztv32/RbG11wP2iP1K8oXCC/ZeVA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794214194; v=1; x=1794818994;
 b=rs8ZZ/2Y2aQw3Ulb9IQ9MKan7q+A+77pB/hj9cOBdr75eX1AOQjGLOvfzYU8xLEizUkxZBrc
 Hg7yGDfeLMaeveOBP2aMZyli+jJ8WSRPxTi7ugf7hYFNwuEMStYCd8lnLkfW8PH9Im9/sJn0Ol9
 aCBjBDihCYgnJRLNL7EsPWto=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 410a3ad52a9fa7ba;
	Mon, 09 Nov 2026 08:49:53 +0000
X-Mizu-Trace-ID: 410a3ad52a9fa7ba
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Quentin Perret <qperret@google.com>,
	Fuad Tabba <tabba@google.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/19] KVM: arm64: selftests: Add pkvm_lifecycle teardown test
Date: Mon,  9 Nov 2026 08:48:51 +0000
Message-ID: <20261109084854.840576-17-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109084854.840576-1-fuad.tabba@linux.dev>
References: <20261109084854.840576-1-fuad.tabba@linux.dev>
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

Each protected VM holds an entry in EL2's table of KVM_MAX_PVMS (255)
VMs until teardown has reclaimed its pages, so if teardown leaks
entries, KVM_CREATE_VM eventually fails.

Create, run and free twice that many VMs, four alive at once and freed
in random order. Check that each VM's memory survives the others'
teardown, and that freeing a VM drops the process's locked memory by
what its runs added.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/arm64/pkvm_lifecycle.c      | 110 ++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/arm64/pkvm_lifecycle.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 68bdd01f62270..214f38e3f67a7 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -194,6 +194,7 @@ TEST_GEN_PROGS_arm64 += arm64/pkvm_host_abi
 TEST_GEN_PROGS_arm64 += arm64/pkvm_id_regs
 TEST_GEN_PROGS_arm64 += arm64/pkvm_irq
 TEST_GEN_PROGS_arm64 += arm64/pkvm_isolation
+TEST_GEN_PROGS_arm64 += arm64/pkvm_lifecycle
 TEST_GEN_PROGS_arm64 += arm64/pkvm_mem_share
 TEST_GEN_PROGS_arm64 += arm64/pkvm_psci
 TEST_GEN_PROGS_arm64 += arm64/pkvm_smccc
diff --git a/tools/testing/selftests/kvm/arm64/pkvm_lifecycle.c b/tools/testing/selftests/kvm/arm64/pkvm_lifecycle.c
new file mode 100644
index 0000000000000..0ee475799abc5
--- /dev/null
+++ b/tools/testing/selftests/kvm/arm64/pkvm_lifecycle.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pkvm_lifecycle - more protected VMs than EL2's VM table holds, freed out of order.
+ *
+ * Copyright (C) 2026 Google LLC
+ * Author: Fuad Tabba <fuad.tabba@linux.dev>
+ */
+
+#include <stdlib.h>
+
+#include "kvm_util.h"
+#include "pkvm.h"
+#include "processor.h"
+#include "test_util.h"
+
+/* EL2's VM table has KVM_MAX_PVMS entries, and a VM holds one until it's freed. */
+#define VM_TABLE_SIZE	255
+/* Enough that leaking the entry of one VM in two fills the table. */
+#define NR_VMS		(2 * VM_TABLE_SIZE)
+#define NR_ALIVE	4
+
+struct pvm {
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	u64 tag;
+	size_t locked;
+};
+
+/* Set in the guest's copy by the host before the first run. */
+static u64 tag;
+
+static void guest_code(void)
+{
+	pkvm_guest_init();
+	for (;;)
+		GUEST_SYNC(READ_ONCE(tag));
+}
+
+/* The tag comes from the guest's own memory, so the VM must survive the others' teardown. */
+static void run_vm(struct pvm *p)
+{
+	size_t locked = pkvm_host_locked_vm();
+	struct ucall uc;
+	u64 cmd;
+
+	vcpu_run(p->vcpu);
+
+	switch (cmd = get_ucall(p->vcpu, &uc)) {
+	case UCALL_SYNC:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	default:
+		TEST_FAIL("Unexpected guest exit: ucall %lu", cmd);
+	}
+	TEST_ASSERT_EQ(uc.args[1], p->tag);
+
+	p->locked += pkvm_host_locked_vm() - locked;
+}
+
+static void create_vm(struct pvm *p, u64 tag_val)
+{
+	p->vm = pkvm_vm_create_with_one_vcpu(&p->vcpu, guest_code);
+	p->tag = tag_val;
+	p->locked = 0;
+	write_guest_global(p->vm, tag, tag_val);
+
+	run_vm(p);
+	TEST_ASSERT(p->locked, "VM %lu pinned no memory", tag_val);
+}
+
+static void free_vm(struct pvm *p)
+{
+	size_t locked = pkvm_host_locked_vm();
+
+	kvm_vm_free(p->vm);
+	TEST_ASSERT_EQ(locked - pkvm_host_locked_vm(), p->locked);
+}
+
+int main(void)
+{
+	struct pvm vms[NR_ALIVE];
+	int i, j;
+
+	TEST_REQUIRE(pkvm_supported());
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	for (i = 0; i < NR_ALIVE; i++)
+		create_vm(&vms[i], i + 1);
+
+	for (; i < NR_VMS; i++) {
+		struct pvm *victim = &vms[random() % NR_ALIVE];
+
+		for (j = 0; j < NR_ALIVE; j++)
+			run_vm(&vms[j]);
+
+		free_vm(victim);
+		create_vm(victim, i + 1);
+	}
+
+	for (j = 0; j < NR_ALIVE; j++)
+		free_vm(&vms[j]);
+
+	ksft_test_result_pass("%d VMs, %d alive at once, freed in random order\n",
+			      NR_VMS, NR_ALIVE);
+	ksft_finished();
+}
-- 
2.47.3

