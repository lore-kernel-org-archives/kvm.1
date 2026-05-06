Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94583282F13;
	Wed,  6 May 2026 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032682; cv=none; b=FHyxXL51XC6teAt4F/D8C4ExTARMDZhjh5i2GCi7XiSkXLfff4WRJ1b1xISDuU5XqxTJ+N63H6HnaeSEIOpeuP5VbXkyRYQz/FusawqFqLsp6+ATkY9uH4EfUjvEvp9b1R70Xqj5sbjN5gSaCi+27xdpT+9UI7PHeDOTA0KR4pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032682; c=relaxed/simple;
	bh=cCwH5w0fK4UfQLUAiej/+ef24PRVhP/LsGjCzYXi6Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mC5OvWjHkGem5aXOQhlxihGuZLmlB8i0j3No9l7X0JhOKH/VcsgTbc6B1IAcjaG4YQMw+zcbF0t7EKoX8BTgzzGPhNlDg+QpWBr6O6Hx8XYtuHL36vjcEyFTabnInvmBrtjMe94dH/UmZrbKbO+CyrNowV/8JgVWBeF3wD/4ewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3wQPgAr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3wQPgAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E125FC2BCC9;
	Wed,  6 May 2026 01:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032682;
	bh=cCwH5w0fK4UfQLUAiej/+ef24PRVhP/LsGjCzYXi6Cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3wQPgArAwRFRvdpPpCmcYmD9hypAn1PUW0MdykXMlvQCtdqfJOkqD8fuyLlwEreK
	 gTSY1p4o1Yh+VkwmRmPokva6HB9LYAlwKFRRC6TZIB3dbW/OhbOWWA+gxpSMOOTI0V
	 y3rurMVBLSMLdfak8B+dhhXtf0qFdYS9LJQSJGjNB7+CTKjIqyGM4tG5+yRu+mgIVB
	 UN2tP4xbsBHxjOEUJ4v3vw3w1AHvwNZE0CnKmQb0LrMp2/KnuH+oGPB8hjX26U1xcU
	 eBbsc1qsEXw6YtxsQdBait+wZFoLXpBBG7Mh/QJmP11Lku76FVR3sBWO9Ra7ifXHzV
	 yoPJ123qqS9YQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v6 04/16] KVM: x86: Move enable_pmu/enable_mediated_pmu to pmu.h and pmu.c
Date: Wed,  6 May 2026 01:57:20 +0000
Message-ID: <20260506015733.1671124-5-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260506015733.1671124-1-yosry@kernel.org>
References: <20260506015733.1671124-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The declaration and definition of enable_pmu/enable_mediated_pmu
semantically belongs in pmu.h and pmu.c, and more importantly, pmu.h
uses enable_mediated_pmu and relies on the caller including x86.h.

There is already precedence for other module params defined outside of
x86.c, so move enable_pmu/enable_mediated_pmu to pmu.c.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c | 10 ++++++++++
 arch/x86/kvm/pmu.h |  3 +++
 arch/x86/kvm/x86.c |  9 ---------
 arch/x86/kvm/x86.h |  3 ---
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index e218352e34231..d6ac3c55fce55 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -16,6 +16,7 @@
 #include <linux/perf_event.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/moduleparam.h>
 #include <asm/perf_event.h>
 #include <asm/cpu_device_id.h>
 #include "x86.h"
@@ -33,6 +34,15 @@ static struct x86_pmu_capability __read_mostly kvm_host_pmu;
 struct x86_pmu_capability __read_mostly kvm_pmu_cap;
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_pmu_cap);
 
+/* Enable/disable PMU virtualization */
+bool __read_mostly enable_pmu = true;
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(enable_pmu);
+module_param(enable_pmu, bool, 0444);
+
+/* Enable/disabled mediated PMU virtualization. */
+bool __read_mostly enable_mediated_pmu;
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(enable_mediated_pmu);
+
 struct kvm_pmu_emulated_event_selectors {
 	u64 INSTRUCTIONS_RETIRED;
 	u64 BRANCH_INSTRUCTIONS_RETIRED;
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 0925246731cb1..b1f2418e960ac 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -53,6 +53,9 @@ struct kvm_pmu_ops {
 	const u32 MSR_STRIDE;
 };
 
+extern bool enable_pmu;
+extern bool enable_mediated_pmu;
+
 void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops);
 
 void kvm_handle_guest_mediated_pmi(void);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 08be0a63b93bd..0b421ea29977b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -182,15 +182,6 @@ module_param(force_emulation_prefix, int, 0644);
 int __read_mostly pi_inject_timer = -1;
 module_param(pi_inject_timer, bint, 0644);
 
-/* Enable/disable PMU virtualization */
-bool __read_mostly enable_pmu = true;
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(enable_pmu);
-module_param(enable_pmu, bool, 0444);
-
-/* Enable/disabled mediated PMU virtualization. */
-bool __read_mostly enable_mediated_pmu;
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(enable_mediated_pmu);
-
 bool __read_mostly eager_page_split = true;
 module_param(eager_page_split, bool, 0644);
 
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 38a905fa86de2..30a69effc81e2 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -490,9 +490,6 @@ fastpath_t handle_fastpath_invd(struct kvm_vcpu *vcpu);
 extern struct kvm_caps kvm_caps;
 extern struct kvm_host_values kvm_host;
 
-extern bool enable_pmu;
-extern bool enable_mediated_pmu;
-
 void kvm_setup_xss_caps(void);
 
 /*
-- 
2.54.0.545.g6539524ca2-goog

