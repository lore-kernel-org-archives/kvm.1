Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C31C3B2FDD
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278185; cv=none; b=sIHAJUanSlknzWXM6D4ZFAnhPNncSqxvA44GjdvRHkSqwMJyT3/noea5yKdI0SYaF6x+O5ZXHKtSBONnpMq+fWJo+XKOFJsXKVssNq498XeAEntPTqgbRCS+J2tx94cNifIDt2ap0nviLbuHNqyuGlAW9qVcWtlqAOFqq6PC3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278185; c=relaxed/simple;
	bh=hnrIP/ujXYSfRKtkWkpnk6bgY6OndSaI3Ziv782woc8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddx/YCyD3qzqHgH2Xahb6+PGajf301zdXJTQlHFcC0hZdFi0OuSdVEpA0GdNEUF1cYOye9GdLqwzwcV5DH+WdlbXA956bnfqPf2oSh5nLfw95WAF5P9QvtSDw1TwEjxXtrV3pI9XZoXXKik4Hqnh6AZLe3Ai3Ohl/zPy6m0yHG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FBA314BF;
	Mon, 23 Mar 2026 08:02:57 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC4E13F694;
	Mon, 23 Mar 2026 08:03:00 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com,
	maz@kernel.org,
	oupton@kernel.org,
	jean-philippe@linaro.org,
	andre.przywara@arm.com,
	suzuki.poulose@arm.com,
	kvm@vger.kernel.org
Subject: [PATCH kvmtool 6/6] arm64: Improve KVM_ARM_VCPU_PMU_V3_CTRL diagnostics
Date: Mon, 23 Mar 2026 15:02:21 +0000
Message-ID: <20260323150221.49256-7-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323150221.49256-1-alexandru.elisei@arm.com>
References: <20260323150221.49256-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvmtool issues several ioctls when configuring the PMU, and each of them
can fail for different reasons. Be more specific about the ioctl that
failed when that happens.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm64/pmu.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/arm64/pmu.c b/arm64/pmu.c
index e15244b51c1f..1f583c16d119 100644
--- a/arm64/pmu.c
+++ b/arm64/pmu.c
@@ -12,6 +12,24 @@
 
 #include "asm/pmu.h"
 
+static const char *pmu_attr_names[] = {
+	[KVM_ARM_VCPU_PMU_V3_IRQ]	= "KVM_ARM_VCPU_PMU_V3_IRQ",
+	[KVM_ARM_VCPU_PMU_V3_INIT]	= "KVM_ARM_VCPU_PMU_V3_INIT",
+	[KVM_ARM_VCPU_PMU_V3_FILTER]	= "KVM_ARM_VCPU_PMU_V3_FILTER",
+	[KVM_ARM_VCPU_PMU_V3_SET_PMU]	= "KVM_ARM_VCPU_PMU_V3_SET_PMU",
+	[KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS] = "KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTER",
+};
+
+static const char *pmu_get_attr_name(u64 attr)
+{
+	switch (attr) {
+	case KVM_ARM_VCPU_PMU_V3_IRQ ... KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS:
+		return pmu_attr_names[attr];
+	default:
+		return "UNKNOWN";
+	}
+}
+
 static bool pmu_has_attr(struct kvm_cpu *vcpu, u64 attr)
 {
 	struct kvm_device_attr pmu_attr = {
@@ -32,13 +50,12 @@ static void set_pmu_attr(struct kvm_cpu *vcpu, void *addr, u64 attr)
 	};
 	int ret;
 
-	if (pmu_has_attr(vcpu, attr)) {
-		ret = ioctl(vcpu->vcpu_fd, KVM_SET_DEVICE_ATTR, &pmu_attr);
-		if (ret)
-			die_perror("PMU KVM_SET_DEVICE_ATTR");
-	} else {
-		die_perror("PMU KVM_HAS_DEVICE_ATTR");
-	}
+	if (!pmu_has_attr(vcpu, attr))
+		die_perror("KVM_HAS_DEVICE_ATTR(%s)", pmu_get_attr_name(attr));
+
+	ret = ioctl(vcpu->vcpu_fd, KVM_SET_DEVICE_ATTR, &pmu_attr);
+	if (ret)
+		die_perror("KVM_SET_DEVICE_ATTR(%s)", pmu_get_attr_name(attr));
 }
 
 #define SYS_EVENT_SOURCE	"/sys/bus/event_source/devices/"
-- 
2.53.0

