Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3501E3B19BA
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423507; cv=none; b=NcTVjzWocNwJim/fXX3eqxqhjTA8gBGmLeOwUsjVwuFD4gwd4iMtw8wfYkuXLMwamBOhivbgpoMR8gOy7KbmzABDCNGoq3sXKSw6WjBlKRWNauLNQaUNTsL7pKFQKVmVQl8AZ3qMHExJfMrxI8aYXwAFE5pRtMLflP5jakWTD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423507; c=relaxed/simple;
	bh=F/4Xnh15SczIa0qPOtFI4zCcQlupScUJWSm0yyFrGWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pTlP9XfXGYO0YiykMDXQzBSR98th1BscNoMs5xZ9y2yQRvVXpabdGOYedaCIRU0bpmOxDDXgVLSqgdBd1++fQVd2fcnupBdjjBZmWc2WzPZpBFkp9s1pQV4xrj/L+6XcmGKmUkangOj6LWtFpYE914d4r4zTgZu8lysbv85Ry30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HhnM1UYM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HhnM1UYM"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2022920B6F0C;
	Fri, 17 Apr 2026 03:58:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2022920B6F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423506;
	bh=X85EpAHSMzz7M95oI+CtSvddIAuC0r/f6yk0GhyxFBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HhnM1UYMafnLMKftyD2QVQTz31/+heGgk02vAGAsK/Ju3VFjVvacvxcgAzHJ/4xbQ
	 2QD+nqIYszFI6OxKiCae9owPeJLE4b9z+tiFXkE7bqz5I1SGr6fH3z9mtEGHfM41E4
	 88ZNtabmB7Nz5UkBaxeCmB5MpnXcDZ1ZA+1K18Rg=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 33/34] target/i386/mshv: migrate MP_STATE
Date: Fri, 17 Apr 2026 12:56:17 +0200
Message-Id: <20260417105618.3621-34-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSHV's "internal activity state" roughly maps to QEMU's env->mp_state
and cpu->halted states that describe state of APs in a guest.

We don't invoke set_mp_state as part of store_vcpu_state() b/c we would
put all BSP + APs in a RUNNABLE (0) state immediately, breaking SMP boot

Instead we store the mp state as part of the load_cleanup() routine
after a migration.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c       | 10 +++++
 include/system/mshv_int.h   |  1 +
 target/i386/mshv/mshv-cpu.c | 80 +++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index facdc733e7..ffe84d6151 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -205,6 +205,7 @@ static int mshv_load_setup(QEMUFile *f, void *opaque, Error **errp)
 static int mshv_load_cleanup(void *opaque)
 {
     MshvState *s = opaque;
+    CPUState *cpu;
     int ret;
 
     ret = mshv_arch_set_partition_msrs(first_cpu);
@@ -213,6 +214,15 @@ static int mshv_load_cleanup(void *opaque)
         return -1;
     }
 
+    CPU_FOREACH(cpu) {
+        ret = mshv_arch_set_mp_state(cpu);
+        if (ret < 0) {
+            error_report("Failed to set mp state for vCPU %d: %s",
+                         cpu->cpu_index, strerror(-ret));
+            return -1;
+        }
+    }
+
     resume_vm(s->vm);
 
     return 0;
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index bc16b794b2..c24efc8675 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -98,6 +98,7 @@ int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
 int mshv_arch_store_vcpu_state(const CPUState *cpu);
 int mshv_arch_load_vcpu_state(CPUState *cpu);
 int mshv_arch_set_partition_msrs(const CPUState *cpu);
+int mshv_arch_set_mp_state(const CPUState *cpu);
 void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 463bf7efa0..ae70133c3c 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -33,6 +33,11 @@
 
 #include <sys/ioctl.h>
 
+#define MSHV_MP_STATE_RUNNABLE       0
+#define MSHV_MP_STATE_UNINITIALIZED  1
+#define MSHV_MP_STATE_INIT_RECEIVED  2
+#define MSHV_MP_STATE_HALTED         3
+
 #define MAX_REGISTER_COUNT (MAX_CONST(ARRAY_SIZE(STANDARD_REGISTER_NAMES), \
                             MAX_CONST(ARRAY_SIZE(SPECIAL_REGISTER_NAMES), \
                                       ARRAY_SIZE(FPU_REGISTER_NAMES))))
@@ -814,6 +819,76 @@ static int set_vcpu_events(const CPUState *cpu)
     return 0;
 }
 
+static int get_mp_state(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    struct hv_register_assoc assoc = {
+        .name = HV_REGISTER_INTERNAL_ACTIVITY_STATE,
+    };
+    union hv_internal_activity_register activity;
+    int ret;
+
+    ret = mshv_get_generic_regs(cpu, &assoc, 1);
+    if (ret < 0) {
+        error_report("failed to get internal activity state");
+        return -1;
+    }
+
+    activity.as_uint64 = assoc.value.reg64;
+
+    /*
+     * map MSHV activity state to KVM mp_state values, which are used as the
+     * shared representation in env->mp_state and serialized by vmstate_x86_cpu.
+     */
+
+    if (activity.startup_suspend) {
+        env->mp_state = MSHV_MP_STATE_UNINITIALIZED;
+    } else if (activity.halt_suspend) {
+        env->mp_state = MSHV_MP_STATE_HALTED;
+    } else {
+        env->mp_state = MSHV_MP_STATE_RUNNABLE;
+    }
+
+    cpu->halted = (env->mp_state == MSHV_MP_STATE_HALTED);
+
+    return 0;
+}
+
+int mshv_arch_set_mp_state(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    union hv_internal_activity_register activity = { 0 };
+    struct hv_register_assoc assoc = {
+        .name = HV_REGISTER_INTERNAL_ACTIVITY_STATE,
+    };
+    int ret;
+
+    switch (env->mp_state) {
+    case MSHV_MP_STATE_HALTED:
+        activity.halt_suspend = 1;
+        break;
+    case MSHV_MP_STATE_UNINITIALIZED:
+    case MSHV_MP_STATE_INIT_RECEIVED:
+        activity.startup_suspend = 1;
+        break;
+    case MSHV_MP_STATE_RUNNABLE:
+    default:
+        break;
+    }
+
+    assoc.value.reg64 = activity.as_uint64;
+
+    ret = mshv_set_generic_regs(cpu, &assoc, 1);
+    if (ret < 0) {
+        error_report("failed to set internal activity state");
+        return -1;
+    }
+
+    return 0;
+}
+
 static int update_hflags(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
@@ -876,6 +951,11 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    ret = get_mp_state(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     return 0;
 }
 
-- 
2.34.1

