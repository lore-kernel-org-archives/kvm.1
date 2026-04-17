Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A083B47FB
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423485; cv=none; b=OhudAB4we5OKcsYXZe9y6lJUPMRsl+oaRHYj1T4bh3Y8B7ehMyC8CXp7JHQeFxznWpXkoyugZ2r9PCz4Yg2UgqK3d/LfqGMDmgdRWeiuxL5/m6o+jw5+Z3tL6I5+pqwXkvg+Ak4LzJ/YvZDSmKtKozXsEjcTh0VH3uLQgSVLNFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423485; c=relaxed/simple;
	bh=MBQFFa+v7xkoMpZQU31SQoYNaehvQP6W6ZlK2Ndz3UQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mqZ3pU2Zkn7WZYIEvcFq5Q/tmAxKu3LtqN1Ty0FRLwddK54BusSRu3KKto/pYVMj68vzj7RylLtvzPNb54omEaCfOexn3OgWaDP6kr6pSN5pPEAbE7b9XX1kcWkz7F/Hgs8VeWO0pfodWEUuykv8L8b676cZmeh3g2rPm7lqfyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MyrIg/5c; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MyrIg/5c"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5D9B020B700D;
	Fri, 17 Apr 2026 03:58:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D9B020B700D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423484;
	bh=fc1+1UtwU7yENZrAtYj54r8Jq6h7vAl8J9HXQQcnltg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MyrIg/5clsB9IB37QoTxF+UUkpHDOXUxXJtm3OypUnqpGZaeYsPA6p7qGhcP6ewVr
	 HmUtjEiBGNr3hRNOMthU2JeOoNiS8SpmwP7RXsASlRxtzq3/lCUlgdKyMBVtAkQ4Qw
	 MhSb5GCT7Q0EHE5ENndb4yaX6F+pERyPPdyFxeCE=
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
Subject: [PATCH 27/34] accel/mshv: write synthetic MSRs after migration
Date: Fri, 17 Apr 2026 12:56:11 +0200
Message-Id: <20260417105618.3621-28-magnuskulke@linux.microsoft.com>
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

Write partition-wide synthetic MSRs. This ensures the hypercall page and
SynIC facilities are set up before vCPUs attempt to use it.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c          |  7 +++++++
 include/hw/hyperv/hvgdk_mini.h |  3 +++
 include/system/mshv_int.h      |  1 +
 target/i386/mshv/mshv-cpu.c    | 15 +++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 5f81881c05..e97f480551 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -137,6 +137,13 @@ static int mshv_load_setup(QEMUFile *f, void *opaque, Error **errp)
 static int mshv_load_cleanup(void *opaque)
 {
     MshvState *s = opaque;
+    int ret;
+
+    ret = mshv_arch_set_partition_msrs(first_cpu);
+    if (ret < 0) {
+        error_report("Failed to set partition MSRs: %s", strerror(-ret));
+        return -1;
+    }
 
     resume_vm(s->vm);
 
diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index 75e953b86c..e987f59bb9 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -23,6 +23,9 @@
 #define HV_X64_MSR_APIC_FREQUENCY   0x40000023
 
 typedef enum hv_register_name {
+    /* VP Management Registers */
+    HV_REGISTER_INTERNAL_ACTIVITY_STATE = 0x00000004,
+
     /* Pending Interruption Register */
     HV_REGISTER_PENDING_INTERRUPTION = 0x00010002,
 
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 7d685fc647..7052f20a00 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -84,6 +84,7 @@ int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
                           size_t n_regs);
 int mshv_arch_store_vcpu_state(const CPUState *cpu);
 int mshv_arch_load_vcpu_state(CPUState *cpu);
+int mshv_arch_set_partition_msrs(const CPUState *cpu);
 void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 9ce66e9aa1..43dbbd6fbd 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1115,6 +1115,21 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
     return 0;
 }
 
+int mshv_arch_set_partition_msrs(const CPUState *cpu)
+{
+    CPUX86State *env = &X86_CPU(cpu)->env;
+    struct hv_register_assoc assocs[] = {
+        { .name = HV_REGISTER_GUEST_OS_ID,
+          .value.reg64 = env->msr_hv_guest_os_id },
+        { .name = HV_REGISTER_REFERENCE_TSC,
+          .value.reg64 = env->msr_hv_tsc },
+        { .name = HV_X64_REGISTER_HYPERCALL,
+          .value.reg64 = env->msr_hv_hypercall },
+    };
+
+    return mshv_set_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
+}
+
 void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features)
 {
-- 
2.34.1

