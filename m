Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28C2E9757
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423470; cv=none; b=okG2qu9MukZjKwCd/uFMRH2xjcgYmz3282F2cK/xqvLFnRrTjP6QF7aAZaUi4GsotIuGJga019aEDtKYxjE5+wFfaJ+dISvLfGX/k3uRjyjax7AzftnuuMJ0sRL9mWRf+noFeDzefs+31UIwjaFZWVwg1xf1kR9NYMSUXXxd3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423470; c=relaxed/simple;
	bh=0b4pPYlLoRwVGOtg7+STR8KjLvrn6MElFSc6EDNaJwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G6x42ONid/I9wDfVbOhD1h1/0zUXwq13ZEdkhQ+vah9dBdk1T8/mxe6NdVsyE9YALJfpqk8f3dIdD1YKzKxxt5SSFSaQFD0Yj+kUYW4/4nlNWobDOcTme/K00mHo9usupxfWgHWsz+b/3zENo6jHm1KAX1QfHiBqyXmzCJ7C4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QzG34/US; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QzG34/US"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 80B5120B7129;
	Fri, 17 Apr 2026 03:57:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80B5120B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423469;
	bh=S92dx0H1HZeFjxrVBmrak0WH0pq895/vNqGc9ASOqFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzG34/USBCzLRxtfv5Cfx0sEjeo1SylWPk4y4zWIlWIewfUlKAhglnunro8MJfv+8
	 WCTTwoq/QIt3HL80tqW5tW4Vi6tI/q++c85z8pQ5tOErvqywwrpP8oLifxQkN++19N
	 ROttbN3jyNWSKd2HX/dhPYE9FXj40826SBC9xhes=
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
Subject: [PATCH 23/34] target/i386/mshv: migrate CET/SS MSRs
Date: Fri, 17 Apr 2026 12:56:07 +0200
Message-Id: <20260417105618.3621-24-magnuskulke@linux.microsoft.com>
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

This change migrates the MSRs required for CET shadow stack and indirect
branch tracking. They are gated behind cet_ss_support || cet_ibt_support
mshv processor feature flags.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/hw/hyperv/hvgdk_mini.h | 11 +++++++++++
 target/i386/mshv/msr.c         | 30 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index 4d1e062e48..75e953b86c 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -168,6 +168,17 @@ typedef enum hv_register_name {
     HV_X64_REGISTER_TSC_DEADLINE    = 0x00080095,
     HV_X64_REGISTER_TSC_ADJUST      = 0x00080096,
 
+    /* CET / Shadow Stack */
+    HV_X64_REGISTER_U_XSS                    = 0x0008008B,
+    HV_X64_REGISTER_U_CET                    = 0x0008008C,
+    HV_X64_REGISTER_S_CET                    = 0x0008008D,
+    HV_X64_REGISTER_SSP                      = 0x0008008E,
+    HV_X64_REGISTER_PL0_SSP                  = 0x0008008F,
+    HV_X64_REGISTER_PL1_SSP                  = 0x00080090,
+    HV_X64_REGISTER_PL2_SSP                  = 0x00080091,
+    HV_X64_REGISTER_PL3_SSP                  = 0x00080092,
+    HV_X64_REGISTER_INTERRUPT_SSP_TABLE_ADDR = 0x00080093,
+
     /* Other MSRs */
     HV_X64_REGISTER_MSR_IA32_MISC_ENABLE = 0x000800A0,
 
diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index 4881e15f4b..b985500797 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -83,6 +83,26 @@ static const MshvMsrEnvMap msr_env_map[] = {
     { IA32_MSR_MTRR_DEF_TYPE, HV_X64_REGISTER_MSR_MTRR_DEF_TYPE,
                               offsetof(CPUX86State, mtrr_deftype) },
 
+    /* CET / Shadow Stack */
+    { MSR_IA32_U_CET,       HV_X64_REGISTER_U_CET,
+                            offsetof(CPUX86State, u_cet) },
+    { MSR_IA32_S_CET,       HV_X64_REGISTER_S_CET,
+                            offsetof(CPUX86State, s_cet) },
+    { MSR_IA32_PL0_SSP,     HV_X64_REGISTER_PL0_SSP,
+                            offsetof(CPUX86State, pl0_ssp) },
+    { MSR_IA32_PL1_SSP,     HV_X64_REGISTER_PL1_SSP,
+                            offsetof(CPUX86State, pl1_ssp) },
+    { MSR_IA32_PL2_SSP,     HV_X64_REGISTER_PL2_SSP,
+                            offsetof(CPUX86State, pl2_ssp) },
+    { MSR_IA32_PL3_SSP,     HV_X64_REGISTER_PL3_SSP,
+                            offsetof(CPUX86State, pl3_ssp) },
+    { MSR_IA32_INT_SSP_TAB, HV_X64_REGISTER_INTERRUPT_SSP_TABLE_ADDR,
+                            offsetof(CPUX86State, int_ssp_table) },
+
+    /* XSAVE Supervisor State */
+    { MSR_IA32_XSS,         HV_X64_REGISTER_U_XSS,
+                            offsetof(CPUX86State, xss) },
+
     /* Other */
 
     /* TODO: find out processor features that correlate to unsupported MSRs. */
@@ -291,6 +311,16 @@ static bool msr_supported(uint32_t name)
         return mshv_state->processor_features.tsc_adjust_support;
     case HV_X64_REGISTER_TSC_DEADLINE:
         return mshv_state->processor_features.tsc_deadline_tmr_support;
+    case HV_X64_REGISTER_U_CET:
+    case HV_X64_REGISTER_S_CET:
+    case HV_X64_REGISTER_PL0_SSP:
+    case HV_X64_REGISTER_PL1_SSP:
+    case HV_X64_REGISTER_PL2_SSP:
+    case HV_X64_REGISTER_PL3_SSP:
+    case HV_X64_REGISTER_INTERRUPT_SSP_TABLE_ADDR:
+    case HV_X64_REGISTER_U_XSS:
+        return mshv_state->processor_features.cet_ss_support ||
+               mshv_state->processor_features.cet_ibt_support;
     }
 
     return true;
-- 
2.34.1

