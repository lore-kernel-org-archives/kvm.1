Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F263D25CC;
	Wed, 27 May 2026 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925643; cv=none; b=lPM773zSAe4yDzLvHaWsUOKNbdm+qrDvRyygfAIMK31D0SAxnajkXuW8iq4NAbD5EkfKQSBCfsBEVk/tnT4h0tWF1wXIuYJxEl9VK2R24S17fG8ML1SoufRXpZXpNn6n9R9njrzvG4QYPE6VNGPIFLJrFHPGhsMWMaO1eQHshA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925643; c=relaxed/simple;
	bh=fKy5YCuj1HhVHXrB6k9r2l+HIsSNpTjnXLIix3FgnsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkGlLV0LRhBNAMETv6IDQn7snLM2nfNntNycDJVPyFV/VYhj2Ni3ETwxsLXVnPEK8dxqS8125Ph6YIbaRjU2qVPzVZ8orq5IN3qzgCJbifSXDXCfhXDKuLQXc2nh/QCDRMimuMKBG3JEBjr6a9ls58RpCVeyaj3Ag2uPKcr/pgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiPaT3qT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiPaT3qT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBC71F000E9;
	Wed, 27 May 2026 23:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925642;
	bh=gGILxze6ukmeEu8hVvjw9FiDyUkak6Xcqt2eg77NxBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FiPaT3qTz5biIsHXCi5rECym4Ses2KamO26CiVFP6AWOP/FFLslSqp4PwE7wK7f/l
	 h8D2z1pFF7oGoM0oINUY4nyqVSyLoHUtzfqmJFygVAdOLpdvq1+V3Mklw5Ic+QkUg8
	 PQJmuIMKTjU+bnhlE9K15KZzMZqzD7leJB5sMcp3BDHCwGhJC0TLioYl3NF773n4i/
	 tVGVUZkM4lC6kzY9mwLYtwMGR1TyY2/q9+ZrwwYMvO3wXwtuO4KELJzbS+l945jyOL
	 IqjVZv+nTV9A/2/FjCQTYeLVVbpWsfjL9jDiji0EQ6fE5EIWRJ1IkKX6zRkn+0mPLz
	 2xp6y/uagrPBA==
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
Subject: [PATCH v7 05/17] KVM: x86: Move enable_pmu/enable_mediated_pmu to pmu.h and pmu.c
Date: Wed, 27 May 2026 23:46:59 +0000
Message-ID: <20260527234711.4175166-6-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
In-Reply-To: <20260527234711.4175166-1-yosry@kernel.org>
References: <20260527234711.4175166-1-yosry@kernel.org>
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
index 1578c0ecbbd1b..cbe740dca5d21 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -181,15 +181,6 @@ module_param(force_emulation_prefix, int, 0644);
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
2.54.0.794.g4f17f83d09-goog

