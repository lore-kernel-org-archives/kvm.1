Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A600B3B27EF
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274392; cv=none; b=rp3982WXzBsMW4gx03Oxfx7EKlKohENDLRSHaOFHCSlmRsXXwwJOUN2/ETEEPST9mp+Yjz85G7L76KaLhpsY25k0rnQOMRhrMQnOwTTQ1jt9kV9mhMfUllU8ncKiQADZolpef9boPYJksPJea6mXVKB9Uo5ZuU+PUIrSM0VDpBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274392; c=relaxed/simple;
	bh=VfT8FD77JJqyUIE1zIozwuUOhuY9LR57vHkBPt8FBok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kg56B0pMU8YzKis838SYVaoJ+HYLLmKG2W72h8BsCW3Jhkf/nZFFgiSLwQceAPkK6+WM5R/amN46cnX5Ltc28C/KmOki5pTHKzbvicpZwL0coeiqr2icXAkyEBDrCt5a1zRfkaW4tXiBIcyJNnoVcna2lNohPAzlKHVFsCu5mp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dyeboFIJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dyeboFIJ"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id AA00220B6F15;
	Mon, 23 Mar 2026 06:59:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA00220B6F15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274391;
	bh=/aJjVtv2N2HvKWYe9sJ5DIN7GG5pVPTEVn5pz5+VPjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dyeboFIJ2FdETlp6CR65ZWMlL/58/lM9WsOgz8YXa8ZdGCT4GFFQbhdVxXhGh3Zc4
	 xuNLnzXedjOIEom/ui2tP4fdkQwBPdtgkbgn+ZN/lKv10UleqbkEO3i563jq2ln8o0
	 gZLNOK8aRjvC8y4hsQ6pgG/8pRxphI88VyPINcHw=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Wei Liu <liuwe@microsoft.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 25/32] accel/mshv: write synthetic MSRs after migration
Date: Mon, 23 Mar 2026 14:58:05 +0100
Message-Id: <20260323135812.383509-26-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
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
index 365288b901..22e838ede6 100644
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
index a47bc6212e..00daac0431 100644
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
index ec1caf4e7a..0b08f478ce 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1141,6 +1141,21 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
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

