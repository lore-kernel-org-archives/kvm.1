Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527A63B19B8
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274366; cv=none; b=khJ/07W1SM+mnPMBKcV1fMxNZP5cVbK3yL2uXuE0KrtsqStCBJCjHxhREhjT6qLAXS1fEesK832lUsMyUXh8XrzOWfFNNem0JtYsRp4WamQYP5ckc0thJCUGUE59DoXWNtjVDDebDpFiZenmO2UjY8nYF7W1CbLqDGmgsoDFq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274366; c=relaxed/simple;
	bh=fIwQxxa56zq+0srYHkrjX4DwZdoELcwg8Q2urVyTMck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MH8pP75imjm6LYd20t3QhjuMe4S3vomGSGjGfx80J+4n0V9lAafd1bHkuXhen1XSv3t/PzhVx0ZHDmacvH6j2sJuBGqpCdWH28WWFBsrHJggoaU7M7EKIf3hEoN3urX1c0llZrcCTmm1kOnGokQyVODqdLCFJApjl3tpIkHTkiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AEtv4OcT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AEtv4OcT"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4AD4820B6F1F;
	Mon, 23 Mar 2026 06:59:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4AD4820B6F1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274365;
	bh=ASHwIUqJhX6VXNhjtPjQt2QC4yNFkvq7Vac2whkLBwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AEtv4OcTVKomZFVNK/kGBko1z4d0IDgkNtbtPVl/n7a9C/U4RgbmeMHzA3L53fdpy
	 n+T0JSs5ZkVnVDg3u0KUJDwGSPdjtQmD6HS0CIXxU5EgywxL8v2H5RAWwYdtwz+hG/
	 layGbJuszzJhBQ9zC2SFfpMvc5bxICZWPAQzBwMY=
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
Subject: [RFC 18/32] target/i386/mshv: expose msvh_get_generic_regs
Date: Mon, 23 Mar 2026 14:57:58 +0100
Message-Id: <20260323135812.383509-19-magnuskulke@linux.microsoft.com>
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

We expose the fn, so we can call them from the other source files
(msr.c).

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/system/mshv_int.h   |  2 ++
 target/i386/mshv/mshv-cpu.c | 15 ++++++---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 2b6d7b2f35..2c5d16bf9a 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -81,6 +81,8 @@ int mshv_configure_vcpu(const CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
                           size_t n_regs);
+int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
+                          size_t n_regs);
 int mshv_arch_store_vcpu_state(const CPUState *cpu);
 int mshv_arch_load_vcpu_state(CPUState *cpu);
 void mshv_arch_init_vcpu(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 906f5b0c3d..ecb4711b95 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -108,9 +108,6 @@ static enum hv_register_name FPU_REGISTER_NAMES[26] = {
 };
 
 static int set_special_regs(const CPUState *cpu);
-static int get_generic_regs(CPUState *cpu,
-                            struct hv_register_assoc *assocs,
-                            size_t n_regs);
 
 static int get_lapic(CPUState *cpu)
 {
@@ -187,7 +184,7 @@ static int get_fpu(CPUState *cpu)
     for (size_t i = 0; i < n_regs; i++) {
         assocs[i].name = FPU_REGISTER_NAMES[i];
     }
-    ret = get_generic_regs(cpu, assocs, n_regs);
+    ret = mshv_get_generic_regs(cpu, assocs, n_regs);
     if (ret < 0) {
         error_report("failed to get special registers");
         return -errno;
@@ -207,7 +204,7 @@ static int get_xc_reg(CPUState *cpu)
 
     assocs[0].name = HV_X64_REGISTER_XFEM;
 
-    ret = get_generic_regs(cpu, assocs, 1);
+    ret = mshv_get_generic_regs(cpu, assocs, 1);
     if (ret < 0) {
         error_report("failed to get xcr0");
         return -1;
@@ -300,8 +297,8 @@ int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
     return 0;
 }
 
-static int get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
-                            size_t n_regs)
+int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
+                          size_t n_regs)
 {
     int cpu_fd = mshv_vcpufd(cpu);
     int vp_index = cpu->cpu_index;
@@ -450,7 +447,7 @@ static int get_standard_regs(CPUState *cpu)
     for (size_t i = 0; i < n_regs; i++) {
         assocs[i].name = STANDARD_REGISTER_NAMES[i];
     }
-    ret = get_generic_regs(cpu, assocs, n_regs);
+    ret = mshv_get_generic_regs(cpu, assocs, n_regs);
     if (ret < 0) {
         error_report("failed to get standard registers");
         return -1;
@@ -527,7 +524,7 @@ static int get_special_regs(CPUState *cpu)
     for (size_t i = 0; i < n_regs; i++) {
         assocs[i].name = SPECIAL_REGISTER_NAMES[i];
     }
-    ret = get_generic_regs(cpu, assocs, n_regs);
+    ret = mshv_get_generic_regs(cpu, assocs, n_regs);
     if (ret < 0) {
         error_report("failed to get special registers");
         return -errno;
-- 
2.34.1

