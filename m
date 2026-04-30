Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB03B389F;
	Thu, 30 Apr 2026 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580882; cv=none; b=KWx3LMJZn2OJ3c1N+xEzZRZAhDkRK7g29XQd6mEqp9H5wu79Y3HocUsDzNnQwpycBR0E881dx+ADnctFhOpmbGFp9KlLG9F8AFt6S8t+D2RbbjKAoVJMc5dr6nV3QHOvNe4UV7uOa6/NcuNo/svZ8V8kTquMhk23diTR+6FP0LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580882; c=relaxed/simple;
	bh=cCwH5w0fK4UfQLUAiej/+ef24PRVhP/LsGjCzYXi6Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a45vDiZe3dUfLQafNVKBUHA5S6+JIpjetTukWOlMEm919sHB8EaHjasmDU48YAtOsyFz1Vl57dM4IxGiDfTeCiKHeI2N87XvO1NotD09KzfdGYE5Hr7EpkiMCRllyQYCQGOykVoBUgctQh8nQNj0/WBy8FoOfRBwE7nfX6mlfY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3jyQTHY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3jyQTHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84908C2BCC6;
	Thu, 30 Apr 2026 20:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777580882;
	bh=cCwH5w0fK4UfQLUAiej/+ef24PRVhP/LsGjCzYXi6Cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3jyQTHYM3/jf1V/TJHzAnsicniRHzvCwMww0oOUchFXhd6cmOBQVciJcpFMjzEPn
	 AM2YL5RYJz7zuV31f9HB8vKZZV8lZwJioCutiy7sxnwHd+FTxZ92Mu54PiReDarD/w
	 iampRdY9XSlKlBclSC1A+NZ1kkbAtJq1Ox5RoVwKKe22JsUeocKI8EQePZgF/8OFk1
	 p33e0LsYafTlVJTp1ebz8lybK5lZLrtAz6LqH2DgBwHhY5vO9Uk8Mziem9z54IOtyG
	 uhfg7WWO5pkFVNxKEbP8lcsSskpaciSGgZTN5A9DRiiK1wJXn+dJleynZrh3BGy3MB
	 4nKrufXItv+rg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v5 04/13] KVM: x86: Move enable_pmu/enable_mediated_pmu to pmu.h and pmu.c
Date: Thu, 30 Apr 2026 20:27:41 +0000
Message-ID: <20260430202750.3924147-5-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260430202750.3924147-1-yosry@kernel.org>
References: <20260430202750.3924147-1-yosry@kernel.org>
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

