Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2231E3B19DF
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274378; cv=none; b=H1BqFY1JG7Aqw3VHlCA80apE8Z7hO3hqbzU+bBevFdinKy7JbZsen9cCee44Ljh15tKHsJ1+qwhB0mxZn9dpkFbaaoIdMBRCjv4f9+mfKD+jO71BTf13+MyBcxXGuN+CnUy9xVn6Cwi52PlLy6ZlIXMMKZ4qoeRx1sZQ85IsRhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274378; c=relaxed/simple;
	bh=WrK9/ua82ltZogusFWTGnzePnXmQG06my+clgieUUj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZpbAOwA5N7x/I401Lass7CyqU904LxiytnZQs7KSJC2PKNDNRHb6DEP3NemmKQBoMiBr2irsy6l0Wmpe4AcZlhJ7sF34dHnZyH1GZuIH4iBH63AHRQM/O9ahkcJ5vOgkQqs3LKuixW6FOtE3otgLRKeJQolZmvIMQDU829jFejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NUiTn1Ga; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NUiTn1Ga"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2761C20B6F1B;
	Mon, 23 Mar 2026 06:59:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2761C20B6F1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274377;
	bh=fHGJO6oByr4zwjSDzga9p2/aohq98U3wlbaQ5tyzs2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUiTn1GaPrme945lxn1FyhsjFrYg/soTLtR90JhKsM+++6ZFoBGYjCUvRM6PH80VN
	 qVHJdTTt6rrtd0hRBgCxIikxepI9cLhDnwq+1cmfr3nbamuhQIL2Pwk4TOcApdm0NR
	 FOSQsCfFD9fWaq43SliFJL1QW3ZlCN6vYns6fUwU=
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
Subject: [RFC 21/32] target/i386/mshv: migrate Synic SINT MSRs
Date: Mon, 23 Mar 2026 14:58:01 +0100
Message-Id: <20260323135812.383509-22-magnuskulke@linux.microsoft.com>
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

Migrate HyperV SynIC SINT MSRs. We can only read/write those if SCONTROL
is enabled in the guest, hence we have to split the SINT MSR out and
make reading/writing them dependent on that MSR.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/msr.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index 240ee84447..d19b79d729 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -298,6 +298,8 @@ int mshv_get_msrs(CPUState *cpu)
     struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
     size_t i, j;
     uint32_t name;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    bool synic_enabled;
 
     set_hv_name_in_assocs(assocs, n_assocs);
 
@@ -324,6 +326,27 @@ int mshv_get_msrs(CPUState *cpu)
 
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
 
@@ -358,6 +381,8 @@ int mshv_set_msrs(const CPUState *cpu)
     struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
     int ret;
     size_t i, j;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    bool synic_enabled = x86cpu->env.msr_hv_synic_control & 1;
 
     load_from_env(cpu, assocs, n_assocs);
 
@@ -390,5 +415,21 @@ int mshv_set_msrs(const CPUState *cpu)
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

