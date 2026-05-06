Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D292F7AAB;
	Wed,  6 May 2026 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032685; cv=none; b=VW3DQRzUGft4Y1REWZSYL4AGwlIBFKjL+aCuhJA6Uu3Y0uLO/qy84RpHz+O5Ce1TEq8R3Qr28dfEUXBSEHoHc7K2qjr47G3eCdZFy/YA7Fspe/4MdLddjCTUfxe1clLNN+TZxc1HK6hnmaFHD1VnYDsZIym28COzOZMk2KZXDpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032685; c=relaxed/simple;
	bh=KljEwRnIPMMzvljIZP+J/d4mM54f+4wV9Y9YVdi4fT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaHjSw/MwSIcU/7qAA6ZGpQuXge+3icc+ihL7yTldg+ROX7Ht1sjhx3OG+sajY/whflhVz38wQChuXFQIz4K40TJp/ECO7NcTfpbO28XLB9xqOlenOo62+LOQsEwsHQgptcgfuy5tl7OjjWTFIPnnOVepUoNvgHhimDIhrwELUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0OwRpm/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0OwRpm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B8AC2BCF4;
	Wed,  6 May 2026 01:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032684;
	bh=KljEwRnIPMMzvljIZP+J/d4mM54f+4wV9Y9YVdi4fT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N0OwRpm/tZr/8eOYfx2IqN3/aRYyE1Mpr+O4xbT1pCzx+d/CzrwTC+dnCeSRVCqB0
	 ZIIy7D1jX/AbjYR2z0jmlcjLvtHKxR80BXUAqMksidfLXqMK1GvT5+m8Y1xkyjfuCV
	 8HjxLn4QD3Mjy/lgzhlHEkt7tO1HGL4rkZcj/LyU89PzEsnHAUQ/n7gsUdtjcGIelI
	 46EMmyiIJNxauoGqkDJxQRxRHybEgAJsx4t8zheYWA07auBVAc65UfjF7HCpL1yyh+
	 QlIz1UKOoujS4NMjAu4ZkgotqQWXBRw2ZklGtdSGJGaR3oehwTTBel1tC2HAdL/Dnb
	 tMoEcKFQXCahg==
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
Subject: [PATCH v6 08/16] KVM: x86/pmu: Add support for KVM_X86_PMU_OP_OPTIONAL_RET0
Date: Wed,  6 May 2026 01:57:24 +0000
Message-ID: <20260506015733.1671124-9-yosry@kernel.org>
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
index d5452b3433b7d..03ed2c917bb56 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #if !defined(KVM_X86_PMU_OP) || \
-    !defined(KVM_X86_PMU_OP_OPTIONAL)
+	!defined(KVM_X86_PMU_OP_OPTIONAL) || \
+	!defined(KVM_X86_PMU_OP_OPTIONAL_RET0)
 #error Missing one or more KVM_X86_PMU_OP #defines
 #else
 
@@ -31,3 +32,4 @@ KVM_X86_PMU_OP(mediated_put)
 
 #undef KVM_X86_PMU_OP
 #undef KVM_X86_PMU_OP_OPTIONAL
+#undef KVM_X86_PMU_OP_OPTIONAL_RET0
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b191967c9c1e4..943adf62839fc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2041,7 +2041,6 @@ extern bool __read_mostly enable_device_posted_irqs;
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
2.54.0.545.g6539524ca2-goog

