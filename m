Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6907B1C84BC
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 06:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491183; cv=none; b=rHLUIbkl1EEFInC8S8hClP5mU0tzhcFhP86ih/265FwglNnZLoJpxLnWeW406Lh36/H4ASZ+33rwtbnUJFgDYARJEWjRPBzG2JbbH4RfjAirOKNO6mcYHToSuRhwxfXhdjkBEfHddk9ngJ3ftv/4BOqlxM4He0tXaRyivihKU2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491183; c=relaxed/simple;
	bh=lPGsvclOAgh0V32F20ZSyGCdcW75sOUIIViF4fpQO2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GK3kZGMuPZ3HX2vup9xdL3BmLEUk2HD6RNdlKyF70sG3lhHkAphWxmghb9kZjsMLVBzMRia59bsQ13sZst+FN3DAHyKFqbGM7bkNeevR/G2an7ZsHJ5p9kDJ2XPICnQjkiGCusOpZVXkm+30O5FqK5GynIAxPlfRr8qt7ic8A4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PvBoRSaP; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PvBoRSaP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783491180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbhZAdbxxI1/a4pn8N1gZliVnKCnUpBEdqiligF4ubY=;
	b=PvBoRSaPlwNC1Irbwu+t3S/2h21PyxY1OqwMISIaIr1BLYNNCyFTyePO+mnWRnFBwkylbA
	2Xw5rg1ywvVnBingBeib0YyN1YPAXW9J6zjEN9sclrHN1JjAfYbYnCeZF74gBoWMLV8ymR
	VihuFyV92MesDiw2KLTZpOlj299N3uY=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	armbru@redhat.com,
	eblake@redhat.com,
	kvm@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v1 2/2] accel/kvm: emit KVM_VCPU_ERROR on unrecoverable vCPU exits
Date: Wed,  8 Jul 2026 14:12:20 +0800
Message-ID: <20260708061220.53507-3-cui.tao@linux.dev>
In-Reply-To: <20260708061220.53507-1-cui.tao@linux.dev>
References: <20260708061220.53507-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

Emit the KVM_VCPU_ERROR event at the three points where a vCPU run
becomes unrecoverable:

  - KVM_RUN ioctl failure           (reason "ioctl-failed")
  - KVM_EXIT_UNKNOWN                (reason "unknown")
  - KVM_EXIT_INTERNAL_ERROR         (reason "internal-error",
                                     with suberror and exit-data)

The KVM_RUN loop in kvm_cpu_exec() runs without the BQL, but QMP event
emission goes through the monitor and requires it; take and release the
lock around the send, mirroring the KVM_SYSTEM_EVENT_CRASH path.

This resolves the long-standing FIXME in kvm_handle_internal_error().

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 accel/kvm/kvm-all.c | 46 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5d55cb45cf..4f68e3b82b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -46,6 +46,7 @@
 #include "qapi/visitor.h"
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-events-run-state.h"
 #include "system/reset.h"
 #include "qemu/guest-random.h"
 #include "system/hw_accel.h"
@@ -3140,6 +3141,38 @@ static void kvm_handle_io(uint16_t port, MemTxAttrs attrs, void *data, int direc
     }
 }
 
+/*
+ * Notify the management layer that a vCPU hit an unrecoverable KVM run
+ * error.  The KVM_RUN loop in kvm_cpu_exec() runs without the BQL, but
+ * emitting a QMP event goes through the monitor and therefore requires
+ * it; take/release the lock around the send.
+ */
+static void kvm_emit_vcpu_error(CPUState *cpu, KvmVcpuErrorReason reason,
+                                bool has_suberror, int64_t suberror,
+                                uint32_t ndata, const uint64_t *data)
+{
+    g_autofree char *qom_path = object_get_canonical_path(OBJECT(cpu));
+    uint64List *exit_data = NULL;
+    uint64List **tail = &exit_data;
+    uint32_t i;
+
+    for (i = 0; i < ndata; i++) {
+        uint64List *node = g_new(uint64List, 1);
+        node->value = data[i];
+        node->next = NULL;
+        *tail = node;
+        tail = &node->next;
+    }
+
+    bql_lock();
+    qapi_event_send_kvm_vcpu_error(cpu->cpu_index, qom_path, reason,
+                                   has_suberror, suberror,
+                                   !!ndata, exit_data);
+    bql_unlock();
+
+    qapi_free_uint64List(exit_data);
+}
+
 static int kvm_handle_internal_error(CPUState *cpu, struct kvm_run *run)
 {
     int i;
@@ -3151,6 +3184,12 @@ static int kvm_handle_internal_error(CPUState *cpu, struct kvm_run *run)
         fprintf(stderr, "extra data[%d]: 0x%016"PRIx64"\n",
                 i, (uint64_t)run->internal.data[i]);
     }
+
+    kvm_emit_vcpu_error(cpu, KVM_VCPU_ERROR_REASON_INTERNAL_ERROR,
+                        true, run->internal.suberror,
+                        run->internal.ndata,
+                        (const uint64_t *)run->internal.data);
+
     if (run->internal.suberror == KVM_INTERNAL_ERROR_EMULATION) {
         fprintf(stderr, "emulation failure\n");
         if (!kvm_arch_stop_on_emulation_error(cpu)) {
@@ -3158,9 +3197,6 @@ static int kvm_handle_internal_error(CPUState *cpu, struct kvm_run *run)
             return EXCP_INTERRUPT;
         }
     }
-    /* FIXME: Should trigger a qmp message to let management know
-     * something went wrong.
-     */
     return -1;
 }
 
@@ -3508,6 +3544,8 @@ int kvm_cpu_exec(CPUState *cpu)
                             "secondary threads offline.\n");
                 }
 #endif
+                kvm_emit_vcpu_error(cpu, KVM_VCPU_ERROR_REASON_IOCTL_FAILED,
+                                    false, 0, 0, NULL);
                 ret = -1;
                 break;
             }
@@ -3543,6 +3581,8 @@ int kvm_cpu_exec(CPUState *cpu)
         case KVM_EXIT_UNKNOWN:
             fprintf(stderr, "KVM: unknown exit, hardware reason %" PRIx64 "\n",
                     (uint64_t)run->hw.hardware_exit_reason);
+            kvm_emit_vcpu_error(cpu, KVM_VCPU_ERROR_REASON_UNKNOWN,
+                                false, 0, 0, NULL);
             ret = -1;
             break;
         case KVM_EXIT_INTERNAL_ERROR:
-- 
2.43.0

