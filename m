Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B693AC0FB
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513573; cv=none; b=mSECYeDM7zZhUfBHUoNcYYYf+Bs2kqK5stL9SkgtsKIRblWUcTZAH1G38ctSnwh2scmETOAbef8dWh6QY/VezlFD+1TkuvpAkfTUPGwk1tJO5pMRiUL+Km9j6vfteD+8TrYr3aJCR91Xs0sJOXHtmC/Ds1BavCYKnflugqhN1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513573; c=relaxed/simple;
	bh=DdPgxRcwTN++1ZeByScHlclTpSBKDPuurI8ybtADU1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5nXBFG/rNAZorggdq0fDaBRAkdjkLhjSAfLqYVstiplEpId45B1b69IESdRhfF8WT4aOGvZq6FQfSUppERFgyeUE6l0U2x4uV/UXFanFXJHy6u6F6LjoovvFTQU1JQqEZLnwmVuqkNexLzXuC4d/BuZfbRd1NdWGJCNpo2qTi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hBw5UvjI; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hBw5UvjI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781513569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmGJOFjPLK/OVWREwAr5PuAPfPwrzXxVlFOvZAt5ZpA=;
	b=hBw5UvjIZGbg0tBdizXfLTe82aPBJscjJqgC8ZW/lBL6mPgp32PXsYEgwHRmE27KHcdbtv
	LjczFf+mNyIOWf4cFvsiFKUSb1hn9fqsD3o/p03Mqwdbv97HJSTIWEjezUEWawpTCfTFa1
	MyajRfmFF6yZPPHO813nzVuiLD9a71E=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	kvm@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 2/2] target/loongarch: Enable PV TLB flush advertisement to the guest
Date: Mon, 15 Jun 2026 16:52:14 +0800
Message-ID: <20260615085214.44526-3-cui.tao@linux.dev>
In-Reply-To: <20260615085214.44526-1-cui.tao@linux.dev>
References: <20260615085214.44526-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

Probe the KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH VM-level capability and, when
the host supports it, advertise KVM_FEATURE_PV_TLB_FLUSH to the guest by
including it in the CPUCFG_KVM_FEATURE feature mask handed to the kernel.

This mirrors the existing PV IPI / steal-time enablement.  A new
kvm-pv-tlb-flush CPU property (on/off/auto, default auto) lets users
disable the feature, e.g. when migrating to a host that lacks it.

The feature is only advertised when the host actually supports it, so a
guest never observes KVM_FEATURE_PV_TLB_FLUSH on a host that cannot
service PV TLB flush requests (which would otherwise lead to stale TLBs).

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 target/loongarch/cpu.h                |  2 ++
 target/loongarch/kvm/kvm.c            | 38 +++++++++++++++++++++++++++
 target/loongarch/loongarch-qmp-cmds.c |  4 +--
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ad30c73167..94e8f176f4 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -300,6 +300,7 @@ enum loongarch_features {
     LOONGARCH_FEATURE_PMU,
     LOONGARCH_FEATURE_PV_IPI,
     LOONGARCH_FEATURE_STEALTIME,
+    LOONGARCH_FEATURE_PV_TLB_FLUSH,
     LOONGARCH_FEATURE_PTW,
 };
 
@@ -447,6 +448,7 @@ struct ArchCPU {
     OnOffAuto msgint;
     OnOffAuto kvm_pv_ipi;
     OnOffAuto kvm_steal_time;
+    OnOffAuto kvm_pv_tlb_flush;
     int32_t socket_id;  /* socket-id of this CPU */
     int32_t core_id;    /* core-id of this CPU */
     int32_t thread_id;  /* thread-id of this CPU */
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index d6539c12ac..f91c388bf3 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -981,6 +981,12 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
         ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
         return (ret == 0);
 
+    case LOONGARCH_FEATURE_PV_TLB_FLUSH:
+        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
+        attr.attr = KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH;
+        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        return (ret == 0);
+
     case LOONGARCH_FEATURE_PTW:
         attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
         attr.attr = KVM_LOONGARCH_VM_FEAT_PTW;
@@ -1150,6 +1156,20 @@ static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
         env->pv_features |= BIT(KVM_FEATURE_STEAL_TIME);
     }
 
+    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_PV_TLB_FLUSH);
+    if (cpu->kvm_pv_tlb_flush == ON_OFF_AUTO_ON) {
+        if (!kvm_supported) {
+            error_setg(errp, "'pv_tlb_flush' not supported by KVM host");
+            return -ENOTSUP;
+        }
+    } else if (cpu->kvm_pv_tlb_flush != ON_OFF_AUTO_AUTO) {
+        kvm_supported = false;
+    }
+
+    if (kvm_supported) {
+        env->pv_features |= BIT(KVM_FEATURE_PV_TLB_FLUSH);
+    }
+
     if (object_dynamic_cast(OBJECT(ms), TYPE_LOONGARCH_VIRT_MACHINE)) {
         LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
 
@@ -1266,6 +1286,18 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
     cpu->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
 }
 
+static bool kvm_pv_tlb_flush_get(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->kvm_pv_tlb_flush != ON_OFF_AUTO_OFF;
+}
+
+static void kvm_pv_tlb_flush_set(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    cpu->kvm_pv_tlb_flush = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+}
+
 void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
 {
     cpu->lbt = ON_OFF_AUTO_AUTO;
@@ -1291,6 +1323,12 @@ void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
                              kvm_steal_time_set);
     object_property_set_description(OBJECT(cpu), "kvm-steal-time",
                                     "Set off to disable KVM steal time.");
+
+    cpu->kvm_pv_tlb_flush = ON_OFF_AUTO_AUTO;
+    object_property_add_bool(OBJECT(cpu), "kvm-pv-tlb-flush",
+                             kvm_pv_tlb_flush_get, kvm_pv_tlb_flush_set);
+    object_property_set_description(OBJECT(cpu), "kvm-pv-tlb-flush",
+                                    "Set off to disable KVM PV TLB flush.");
 }
 
 int kvm_arch_destroy_vcpu(CPUState *cs)
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index f053f22bb8..5f372d85a9 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -41,8 +41,8 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 }
 
 static const char *cpu_model_advertised_features[] = {
-    "lsx", "lasx", "lbt", "pmu", "kvm-pv-ipi", "kvm-steal-time", "msgint",
-    "ptw", NULL
+    "lsx", "lasx", "lbt", "pmu", "kvm-pv-ipi", "kvm-steal-time",
+    "kvm-pv-tlb-flush", "msgint", "ptw", NULL
 };
 
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-- 
2.43.0

