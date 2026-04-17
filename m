Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823B13A9D93
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423389; cv=none; b=Bmh8jwohiDSoNOmEK9pmGfZsg/4DANNWc9pkYaXdKo9FyN/KlARUgbWv+W4RULZIB2p/7Df7uLnoQnZUQ5umU6qNiQaSft6j/VQ6v+NvaAMhRHvV2bIVQK01W5O9GCnxufC3CeqFaKKvYiFvwTvxnhx/Hfp3d5cHZqhmJLHitF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423389; c=relaxed/simple;
	bh=YpVZa0KllEBW36jE4jrvNY98y7F9Ue7CymtV2K70qQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NHtQ1AA/vcvS0tRjuCr/msAp8JyaWI1pn8/elVfHAK4ov+cfm9nzTlGKh/i84X3rUp7AqxbioCAOMJMa11BK4l7EoTkP3OhNRcdJTE64fbi/a51f5Xtu/0yUc+LozupD2IXIHgXW62+GdGSP+VA3bFQkKawYxRjiYRZ0ox8F6og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eKKkOVDm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eKKkOVDm"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 50C5020B7129;
	Fri, 17 Apr 2026 03:56:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 50C5020B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423388;
	bh=Vlb84NjCXw4NOONm0D1TCpsCilPuQF2CzdK3RJxUGA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKKkOVDmtfcnC1Z5Fbt7GMN3ytR5hULbR6Jo6QJN+JdawvFnWIz1SlcyKdqbk5umG
	 5MgnRyd7bYryZGX27OcNjC4szU50dUIwEuSyQZbk6BN3NxYpdzQP8Tgnk8iPxPXsx0
	 YXaLAz37RH0kTEj89RyBFrZeJJOaNBcs5eDaJceA=
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
Subject: [PATCH 01/34] target/i386/mshv: use arch_load/store_reg fns
Date: Fri, 17 Apr 2026 12:55:45 +0200
Message-Id: <20260417105618.3621-2-magnuskulke@linux.microsoft.com>
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

Improved consistency around the naming of load/store register fn's. this
is required since we want to roundtrip more registers in a migration
than what's currently required for MMIO emulation.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c       |  2 +-
 include/system/mshv_int.h   |  6 ++---
 target/i386/mshv/mshv-cpu.c | 52 ++++++++++++++-----------------------
 3 files changed, 23 insertions(+), 37 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index d4cc7f5371..7c0eb68a5b 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -650,7 +650,7 @@ static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
 static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->accel->dirty) {
-        int ret = mshv_load_regs(cpu);
+        int ret = mshv_arch_load_regs(cpu);
         if (ret < 0) {
             error_report("Failed to load registers for vcpu %d",
                          cpu->cpu_index);
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 35386c422f..a142dd241a 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -82,11 +82,9 @@ void mshv_init_mmio_emu(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
 int mshv_configure_vcpu(const CPUState *cpu, const MshvFPU *fpu, uint64_t xcr0);
-int mshv_get_standard_regs(CPUState *cpu);
-int mshv_get_special_regs(CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
-int mshv_load_regs(CPUState *cpu);
-int mshv_store_regs(CPUState *cpu);
+int mshv_arch_load_regs(CPUState *cpu);
+int mshv_arch_store_regs(CPUState *cpu);
 int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
                           size_t n_regs);
 int mshv_arch_put_registers(const CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 2bc978deb2..9456e75277 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -107,6 +107,8 @@ static enum hv_register_name FPU_REGISTER_NAMES[26] = {
     HV_X64_REGISTER_XMM_CONTROL_STATUS,
 };
 
+static int set_special_regs(const CPUState *cpu);
+
 static int translate_gva(const CPUState *cpu, uint64_t gva, uint64_t *gpa,
                          uint64_t flags)
 {
@@ -285,7 +287,7 @@ static int set_standard_regs(const CPUState *cpu)
     return 0;
 }
 
-int mshv_store_regs(CPUState *cpu)
+int mshv_arch_store_regs(CPUState *cpu)
 {
     int ret;
 
@@ -295,6 +297,12 @@ int mshv_store_regs(CPUState *cpu)
         return -1;
     }
 
+    ret = set_special_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to store speical registers");
+        return ret;
+    }
+
     return 0;
 }
 
@@ -323,7 +331,7 @@ static void populate_standard_regs(const hv_register_assoc *assocs,
     rflags_to_lflags(env);
 }
 
-int mshv_get_standard_regs(CPUState *cpu)
+static int get_standard_regs(CPUState *cpu)
 {
     struct hv_register_assoc assocs[ARRAY_SIZE(STANDARD_REGISTER_NAMES)];
     int ret;
@@ -401,8 +409,7 @@ static void populate_special_regs(const hv_register_assoc *assocs,
     cpu_set_apic_base(x86cpu->apic_state, assocs[16].value.reg64);
 }
 
-
-int mshv_get_special_regs(CPUState *cpu)
+static int get_special_regs(CPUState *cpu)
 {
     struct hv_register_assoc assocs[ARRAY_SIZE(SPECIAL_REGISTER_NAMES)];
     int ret;
@@ -422,17 +429,17 @@ int mshv_get_special_regs(CPUState *cpu)
     return 0;
 }
 
-int mshv_load_regs(CPUState *cpu)
+int mshv_arch_load_regs(CPUState *cpu)
 {
     int ret;
 
-    ret = mshv_get_standard_regs(cpu);
+    ret = get_standard_regs(cpu);
     if (ret < 0) {
         error_report("Failed to load standard registers");
         return -1;
     }
 
-    ret = mshv_get_special_regs(cpu);
+    ret = get_special_regs(cpu);
     if (ret < 0) {
         error_report("Failed to load special registers");
         return -1;
@@ -1103,16 +1110,16 @@ static int emulate_instruction(CPUState *cpu,
     int ret;
     x86_insn_stream stream = { .bytes = insn_bytes, .len = insn_len };
 
-    ret = mshv_load_regs(cpu);
+    ret = mshv_arch_load_regs(cpu);
     if (ret < 0) {
-        error_report("failed to load registers");
+        error_report("Failed to load registers");
         return -1;
     }
 
     decode_instruction_stream(env, &decode, &stream);
     exec_instruction(env, &decode);
 
-    ret = mshv_store_regs(cpu);
+    ret = mshv_arch_store_regs(cpu);
     if (ret < 0) {
         error_report("failed to store registers");
         return -1;
@@ -1291,25 +1298,6 @@ static int handle_pio_non_str(const CPUState *cpu,
     return 0;
 }
 
-static int fetch_guest_state(CPUState *cpu)
-{
-    int ret;
-
-    ret = mshv_get_standard_regs(cpu);
-    if (ret < 0) {
-        error_report("Failed to get standard registers");
-        return -1;
-    }
-
-    ret = mshv_get_special_regs(cpu);
-    if (ret < 0) {
-        error_report("Failed to get special registers");
-        return -1;
-    }
-
-    return 0;
-}
-
 static int read_memory(const CPUState *cpu, uint64_t initial_gva,
                        uint64_t initial_gpa, uint64_t gva, uint8_t *data,
                        size_t len)
@@ -1429,9 +1417,9 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
 
-    ret = fetch_guest_state(cpu);
+    ret = mshv_arch_load_regs(cpu);
     if (ret < 0) {
-        error_report("Failed to fetch guest state");
+        error_report("Failed to load registers");
         return -1;
     }
 
@@ -1462,7 +1450,7 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
 
     ret = set_x64_registers(cpu, reg_names, reg_values);
     if (ret < 0) {
-        error_report("Failed to set x64 registers");
+        error_report("Failed to set RIP and RAX registers");
         return -1;
     }
 
-- 
2.34.1

