Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BCF38C2BC;
	Thu, 26 Mar 2026 03:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774494751; cv=none; b=TehOJJdwuFuROiYrV+Zfdxg50GMWIic4/R1JHtG11sInupctRN2sG3DS8kwOIDY9jNMp5XHdBfKDWX8+53Qa/zR7t2WynlxTDeOyurPAjmv6PLNYmPXaLlnetBmXVx+Ri3TlzjWFAqBYuuLW/R2PlO3A9qEYUefgt1ksCYlaI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774494751; c=relaxed/simple;
	bh=TcgrzSZpv1N3EQ2sJcjdoz7K5gTllPG2CxppLL34jpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dhprx01Vl3Z1b81XqdcDzoCQ2HUlSHyhafBwn4rQHS1lJ0T407MX7nd16P1wozryoIU3DX6MZBrb9Dvtd9iHpC7vZk4unPvl0p4TgEKHPAfysCpWHoENG0GJuRLgW4X2k/zZljcbd/UWcRMYNQDyoCZJguW/utVXQzsnjofTfo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/DfdY+H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/DfdY+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62027C2BCB0;
	Thu, 26 Mar 2026 03:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774494751;
	bh=TcgrzSZpv1N3EQ2sJcjdoz7K5gTllPG2CxppLL34jpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/DfdY+HpwdkzsytrXSc2RSrSn58j4nDMDTAJ5bdA8lNXtboX2dNeS6cIJsF62Z0T
	 ZCBn3gT9Tpr4Z648pS0bZWiBN4KJWCIFUqaK2oAtmg3+ZdADz4mndklcoNyVi77/cQ
	 bNO2OQfkRFOWNo2hVtjEoj7/2ZGXLOMleqv6xMsC+R1FDVwTcSoI1adsUCUO1LxAeS
	 nVMLgeBk81EzO5z5QP9cLP9MuBGXaEKxK/68eTGKGuLNr5l7mqZKvDitaGSX6OleJz
	 WxKf/0et5tDK0NI5HRWrFjmzsne0jX8fUvq5aoxQFCLSvIusgJjmAXdIDpMCyxSA6h
	 d5MLxbBXAm4Dw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 1/6] KVM: x86: Move enable_pmu/enable_mediated_pmu to pmu.h and pmu.c
Date: Thu, 26 Mar 2026 03:11:45 +0000
Message-ID: <20260326031150.3774017-2-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260326031150.3774017-1-yosry@kernel.org>
References: <20260326031150.3774017-1-yosry@kernel.org>
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
index 0b5d48e75b657..0a5fd473a24e1 100644
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
index 44a28d343d407..48f3e8c0dc30d 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -480,9 +480,6 @@ fastpath_t handle_fastpath_invd(struct kvm_vcpu *vcpu);
 extern struct kvm_caps kvm_caps;
 extern struct kvm_host_values kvm_host;
 
-extern bool enable_pmu;
-extern bool enable_mediated_pmu;
-
 void kvm_setup_xss_caps(void);
 
 /*
-- 
2.53.0.1018.g2bb0e51243-goog

