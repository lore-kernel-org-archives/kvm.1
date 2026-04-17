Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F203226D4E5
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423467; cv=none; b=LGsO7rZHQWTyQSqLGJB1NiudRbSGk4EoyN/c1rod1cESdibfwaHsbmls2ckFgIDX5ZJTtS/cj7COtbZh6Me0Jxr5XSfnvVoiakUqO6Q5/9NQfyxmlZQ6ggo50wKSL7eO4VS+a0PvRgTfLE2fbj7+3u7xvtIO3k4xmIlrEiD87qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423467; c=relaxed/simple;
	bh=3I0kWjGyfpw0o5dcVkPyHi9W/t7AJLUwAD+NY3i2GUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AWjBIQVCX7+78dqiJoZhZUhQI2SlsMw3I74NketbWH/o1kegfiMxGdLIDAgvxWl8PF+jz3no9uAZtfM7f24gfpn8TUzZcjyFoiMEpLRbjdoZUXFiojsh8YSfte+8gxq65Rq2SX2z+iu0m7n10JUOOig9Wh8Pjs4x8ImbxG3HlCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y1uj1HM/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y1uj1HM/"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 065BB20B712B;
	Fri, 17 Apr 2026 03:57:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 065BB20B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423465;
	bh=hkvpr9QCwBz+aAxOE4MLQ16OiKG8v7Bh8aJx066T5TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1uj1HM/fKCyvdDoBgRqm5KPgSqUuCU5IBK7lkT0ODgu807lNDX4HLDygbCnYLJ7U
	 LNCehxjd6mjE9oJNou5fw3IscyspowhJVKcM23Hxz2UCQNs2jm59OOOpcg9TTEy8AI
	 dzp0uVO9TpyAgcnx/BVb09RJYia4Kaa96VypdLI4=
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
Subject: [PATCH 22/34] target/i386/mshv: migrate Synic SINT MSRs
Date: Fri, 17 Apr 2026 12:56:06 +0200
Message-Id: <20260417105618.3621-23-magnuskulke@linux.microsoft.com>
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

Migrate HyperV SynIC SINT MSRs. We can only read/write those if SCONTROL
is enabled in the guest, hence we have to split the SINT MSR out and
make reading/writing them dependent on that MSR.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/msr.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index b26375e4c2..4881e15f4b 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -303,6 +303,8 @@ int mshv_get_msrs(CPUState *cpu)
     struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
     size_t i, j;
     uint32_t name;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    bool synic_enabled;
 
     set_hv_name_in_assocs(assocs, n_assocs);
 
@@ -329,6 +331,27 @@ int mshv_get_msrs(CPUState *cpu)
 
     store_in_env(cpu, assocs, n_assocs);
 
+    /* Read SINT MSRs only if SynIC is enabled */
+    synic_enabled = x86cpu->env.msr_hv_synic_control & 1;
+    if (synic_enabled) {
+        QEMU_BUILD_BUG_ON(MSHV_MSR_TOTAL_COUNT < HV_SINT_COUNT);
+
+        for (i = 0; i < HV_SINT_COUNT; i++) {
+            assocs[i].name = HV_REGISTER_SINT0 + i;
+        }
+
+        ret = mshv_get_generic_regs(cpu, assocs, HV_SINT_COUNT);
+        if (ret < 0) {
+            error_report("Failed to get SynIC SINT MSRs");
+            return -errno;
+        }
+
+        for (i = 0; i < HV_SINT_COUNT; i++) {
+            uint64_t hv_sint_value = assocs[i].value.reg64;
+            x86cpu->env.msr_hv_synic_sint[i] = hv_sint_value;
+        }
+    }
+
     return 0;
 }
 
@@ -363,6 +386,8 @@ int mshv_set_msrs(const CPUState *cpu)
     struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
     int ret;
     size_t i, j;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    bool synic_enabled = x86cpu->env.msr_hv_synic_control & 1;
 
     load_from_env(cpu, assocs, n_assocs);
 
@@ -395,5 +420,21 @@ int mshv_set_msrs(const CPUState *cpu)
         return -errno;
     }
 
+    /* SINT MSRs can only be written if SCONTROL has been set, so we split */
+    if (synic_enabled) {
+        QEMU_BUILD_BUG_ON(MSHV_MSR_TOTAL_COUNT < HV_SINT_COUNT);
+
+        for (i = 0; i < HV_SINT_COUNT; i++) {
+            assocs[i].name        = HV_REGISTER_SINT0 + i;
+            assocs[i].value.reg64 = x86cpu->env.msr_hv_synic_sint[i];
+        }
+
+        ret = mshv_set_generic_regs(cpu, assocs, HV_SINT_COUNT);
+        if (ret < 0) {
+            error_report("Failed to set SynIC SINT MSRs");
+            return -errno;
+        }
+    }
+
     return 0;
 }
-- 
2.34.1

