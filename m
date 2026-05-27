Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAC93DD531;
	Wed, 27 May 2026 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925646; cv=none; b=pyi5/WNC1Vg4sQKKPVgMn9LiS6Rfw5/SqTF0L0K3mCUfcuhQgEMyUKWEdMpXgUEfpuVw341sbL5uEsc/x1pd384Q5avX36JpwIVuKoRDSvYUtyGulop64XliZw93B26jDhShqlGOPnaK32v54+TUQJ1nz2lCQ+QIQjw6mxVCoy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925646; c=relaxed/simple;
	bh=wfc7o0YVNYcCd4DlwXP/cWzxBWndg/FDvjk9nEW1Wuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZl134uEbVzP57pK6rPB9fxqcBBfh935lReRnFELlSOsRHCaKzctpiGcZ5EjTA5DMANHgPsQyeqq2XyLNc61JIEbti++Wf331c/53zuxAj7pbGVE7QY/yh9FtCyfkEuOdATlaskgfMgrGmaqvQIFTZTlC+OgZ7o1phUcZteri8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc1UGngZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc1UGngZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842021F00A3E;
	Wed, 27 May 2026 23:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925645;
	bh=MB81YlG2FDhoDL/Ufj59rhXsq8NtjHGVGEmFXI3z9pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qc1UGngZOAG0dAvkUwPSVSe1CXidaFPR5GFgJq+JuQ20ruq9HLZQkyWoVPUUIBHhd
	 SgEcMtPIjPnNLlSjMGftwPktaBYDxawgvhlUEQv4xAOX2VOU1+Pom2iTq8DGZ4pPpA
	 nD1LxKfwG8PDvLSc9hz9Dxw9HBze5D8iJAJY13ZmdjUKr4ilwsA5ynV7RSl8ATfVbV
	 9EsoZIXmhBdvjrre9pPP/Y2RUcbgQzU1wXKyBLurqA5Puhj5CdCvl7c/HOMcUXI5kk
	 SbBT1hmILJz5BNWuvdOcGTxx+wTTdJ/P9jhALoFIvQrpd0Ng2XmWcm960EblIOPurQ
	 nkUanF05xCeTg==
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
Subject: [PATCH v7 09/17] KVM: x86/pmu: Add support for KVM_X86_PMU_OP_OPTIONAL_RET0
Date: Wed, 27 May 2026 23:47:03 +0000
Message-ID: <20260527234711.4175166-10-yosry@kernel.org>
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

Add definitions for KVM_X86_PMU_OP_OPTIONAL_RET0() to resolve to
__static_call_return0, similar to KVM_X86_OP_OPTIONAL_RET0(). Move the
definition of kvm_pmu_call() to pmu.h, and add declarations for the
static PMU calls in the header to allow making callbacks from the header
in following changes.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h | 4 +++-
 arch/x86/include/asm/kvm_host.h        | 1 -
 arch/x86/kvm/pmu.c                     | 4 ++++
 arch/x86/kvm/pmu.h                     | 8 ++++++++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index d5452b3433b7d..0616243c84cf9 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #if !defined(KVM_X86_PMU_OP) || \
-    !defined(KVM_X86_PMU_OP_OPTIONAL)
+    !defined(KVM_X86_PMU_OP_OPTIONAL) || \
+    !defined(KVM_X86_PMU_OP_OPTIONAL_RET0)
 #error Missing one or more KVM_X86_PMU_OP #defines
 #else
 
@@ -31,3 +32,4 @@ KVM_X86_PMU_OP(mediated_put)
 
 #undef KVM_X86_PMU_OP
 #undef KVM_X86_PMU_OP_OPTIONAL
+#undef KVM_X86_PMU_OP_OPTIONAL_RET0
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d72051150bac9..0f3cbf9fc1ae1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2068,7 +2068,6 @@ extern bool __read_mostly enable_device_posted_irqs;
 extern struct kvm_x86_ops kvm_x86_ops;
 
 #define kvm_x86_call(func) static_call(kvm_x86_##func)
-#define kvm_pmu_call(func) static_call(kvm_x86_pmu_##func)
 
 #define KVM_X86_OP(func) \
 	DECLARE_STATIC_CALL(kvm_x86_##func, *(((struct kvm_x86_ops *)0)->func));
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 67dbbd4c73036..9b7e39610be22 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -98,6 +98,7 @@ static struct kvm_pmu_ops kvm_pmu_ops __read_mostly;
 	DEFINE_STATIC_CALL_NULL(kvm_x86_pmu_##func,			     \
 				*(((struct kvm_pmu_ops *)0)->func));
 #define KVM_X86_PMU_OP_OPTIONAL KVM_X86_PMU_OP
+#define KVM_X86_PMU_OP_OPTIONAL_RET0 KVM_X86_PMU_OP
 #include <asm/kvm-x86-pmu-ops.h>
 
 void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops)
@@ -109,6 +110,9 @@ void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops)
 #define KVM_X86_PMU_OP(func) \
 	WARN_ON(!kvm_pmu_ops.func); __KVM_X86_PMU_OP(func)
 #define KVM_X86_PMU_OP_OPTIONAL __KVM_X86_PMU_OP
+#define KVM_X86_PMU_OP_OPTIONAL_RET0(func) \
+	static_call_update(kvm_x86_pmu_##func, (void *)kvm_pmu_ops.func ? : \
+					       (void *)__static_call_return0);
 #include <asm/kvm-x86-pmu-ops.h>
 #undef __KVM_X86_PMU_OP
 }
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 0e99022168a85..a062f0bc3dbb1 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -53,6 +53,14 @@ struct kvm_pmu_ops {
 	const u32 MSR_STRIDE;
 };
 
+#define kvm_pmu_call(func) static_call(kvm_x86_pmu_##func)
+
+#define KVM_X86_PMU_OP(func) \
+	DECLARE_STATIC_CALL(kvm_x86_pmu_##func, *(((struct kvm_pmu_ops *)0)->func));
+#define KVM_X86_PMU_OP_OPTIONAL KVM_X86_PMU_OP
+#define KVM_X86_PMU_OP_OPTIONAL_RET0 KVM_X86_PMU_OP
+#include <asm/kvm-x86-pmu-ops.h>
+
 extern bool enable_pmu;
 extern bool enable_mediated_pmu;
 
-- 
2.54.0.794.g4f17f83d09-goog

