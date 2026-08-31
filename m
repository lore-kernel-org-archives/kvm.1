Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE273C65FD
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163833; cv=none; b=Wir8cd4a+Nw3gAWvfJUQWDqj79X+AXZg2KkfDEMB0QP4kld/xrzyR4BvhHu2xmiFaDKKczILFVTVTiGUP7DvoMjF8B0mTbgxHoNT88QBUvykApF8awrGMo4s4y2aDN5gL44MtFWUho7jJFSbCKqB/0FBdr+H342XFS+pWy8X7iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163833; c=relaxed/simple;
	bh=viAVRllkrsImHsNb1DnUub6XvU5jvIFJexyLibR+lA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2uKxkiEMhzMbBMCopDqgw58RE2I1clEWtPsZUAbHjizgJ4TjxpehrRE49a8ITY8yMSdRFVJSiSgOwizi95pAAJeOm2GOs0VwwVbO7FxryLSk2/Qw2+iHX3HB3I9ccEjz2r/5iggfwqrUj53Wyjp1gT0We3E9FySnyNfHj1fHOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5qnKccv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5qnKccv"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so24040295e9.2
        for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 01:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788163826; x=1788768626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zgxKhL7A1XKhNVrAX+Ck+KuNZ6TSYMACVM9Vad6BlYI=;
        b=D5qnKccvlUUEYfq9eCuyuQpE9/ccpM9rz/bAcchhSGdL7mFeocch4miEiUrQDGXQBU
         enuzFBdIp2aFtm9XoZxB5P0S/a7Vo6Ft4iDdJspNYtq1YU6+/TQ1K4QfaOM6/9FLusuY
         v/aAqJU1yrN4kolDJBUbUu6idmYeQKFKzHQYzG0bU+9tyOJdgB7hlx5LiiwWxjxjqJj3
         SY/69/mXTAO5+al0govVYo7pVmVmcxx79MKLpqw494PlG8vXc5DGMKw/PsRxPmu9wfuJ
         q95yLbHfi1KqpKX58SIH5jGN7H5mnepoULJv6eChf7pBFR7iVf1Wp/8ZlBaUOuT6/yM2
         fCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788163826; x=1788768626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zgxKhL7A1XKhNVrAX+Ck+KuNZ6TSYMACVM9Vad6BlYI=;
        b=qKQ7SDN+O+WpYznasLaj2CQbYBTX8uI1qRjmmChejQrdzMZznYTAQofAw3d2oYYdZM
         p+4HTDNCSPANiAKWsBDKMNHyrfPIimLdrMz3lChjBlJz2s07QA4j5wzhNyKkTAE1d/1v
         maFqt/0MfzgLPVdjHFzQXvUeVTmAXh6kfJGCNWrRGTZQqqsgN7eRoZMjGg9XBmaHfL25
         5D3//NKD5wDtMfxjP5jimuz/KSUS35D/I6NZkce9GCwwJ4rARvAIRuot8n6WaOTW/rzZ
         6o+kcuMJdfmHHDz1wStZ18Y5fSd2MfqvvQBtRi/ATCR1kqcGMltCXmNyoVZjC/XP/DtX
         Jkag==
X-Forwarded-Encrypted: i=1; AHgh+Ro1bo2q+GprUSQGi9cWcTo4eAofkT31UzbnY0A4hrX5ItakzGDb9eMqxJGWBk+V9Ex1v8c=@vger.kernel.org
X-Gm-Message-State: AFuF++kHz/oOIQifmggqZ1HiIMbk8eADxaCJ5PkOLLCxT6jqo4hX2yaY
	08f93Co71EvadOTlN5f7t3zUc9DU/+heyWDJhbbFKrtS7EsEh6tcbj80
X-Gm-Gg: AR+sD12PYE/JQ1qh/F6rbPaGfEgOoOotnCntA2zq4LQ30kkH2hxhjKMEOHmUBaXSHuT
	kqoHt2d1lwgMffyYnCRDnXclzvgvyXM9b4liF6DJ914jm8MZN/eYITWqz3gQO3RAirSIUhAzrmX
	u0oCncWsoF1gvxGuACFv57hKuNvEAbYDt0d25YDX7VEfrefGSZL5V0llU1TIpzB7FSt2KWudWZS
	+wZOF+n1cuHn38zn23AoBKuAE/ndjErcecYjmygrk6NKKFZvTU7zGwG8RO0OXnRnRURPhIyJ6rR
	LxB08aql6Y35LvluG0gWvnhgxsnz7noWsRLf8YnkisirZ33NMq2RqW9mLBVL6tv6GbwoYZBAfOq
	yctr0qO7dRp5ZjfYQndKBwheyMfjPhQ3pT4Qo7ECVlJi/eOUp92ekXb9VIBC8XhvDgSa3/dZshx
	pTZ6zuScND5ApV5mv6p1Cj051lQzHvACwqQHOql+EbTUMzMMi8sLNApZVOpniBxnTXVKzerGZXG
	EIn/+hHg+lbJOH0ADu0oHzZEBIbY1ERaWVbluCqSI6c9162ZqJBOXu8YufSZQVknv1sDTKr9ZjP
	jWv1R7k83fU9Oo0QkGdMEZ3aQHfUmDkQzvJs/izZyYk3hpMJ+pUT0YNZ/DjHz3YB/5TIo4M=
X-Received: by 2002:a05:600c:3155:b0:49b:910c:7703 with SMTP id 5b1f17b1804b1-49b91c3dcb4mr350375865e9.9.1788163825607;
        Mon, 31 Aug 2026 01:10:25 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-acb9-0201-68d0-34d2-ad1a-175a.310.pool.telefonica.de. [2a02:3100:acb9:201:68d0:34d2:ad1a:175a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b95013d06sm370393515e9.12.2026.08.31.01.10.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 01:10:24 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 4/4] KVM: arm64: selftests: Test VGICv3 redistributor region retry
Date: Mon, 31 Aug 2026 10:10:04 +0200
Message-Id: <20260831081005.41346-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260831081005.41346-1-kmehltretter@gmail.com>
References: <20260831081005.41346-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A failed REDIST_REGION write can remove redistributor iodevs without
clearing their cached vCPU assignments. A retry then skips those
assignments and leaves the redistributors absent from the MMIO bus.

Create two partial regions, reject a third region that overlaps the
distributor, and retry at a valid address. After initializing the VGIC,
have the guest read GICR_TYPER from all four redistributors and check their
processor numbers. This verifies the final configuration without assuming
that assignments survive the failed write.

Keep the redistributor IPAs outside the guest RAM memslot and install only
the stage-1 mappings needed for the MMIO accesses. If an iodev is missing,
KVM_RUN therefore exits with KVM_EXIT_MMIO. Without the fix, the first
redistributor access exits at 0x8030008.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 tools/testing/selftests/kvm/arm64/vgic_init.c | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/vgic_init.c b/tools/testing/selftests/kvm/arm64/vgic_init.c
index 84aa97204b7f..5a30f3cb039b 100644
--- a/tools/testing/selftests/kvm/arm64/vgic_init.c
+++ b/tools/testing/selftests/kvm/arm64/vgic_init.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2020, Red Hat, Inc.
  */
 #include <linux/kernel.h>
+#include <linux/sizes.h>
 #include <sys/syscall.h>
 #include <asm/kvm.h>
 #include <asm/kvm_para.h>
@@ -13,12 +14,21 @@
 
 #include "test_util.h"
 #include "kvm_util.h"
+#include "gic.h"
 #include "processor.h"
 #include "vgic.h"
 #include "gic_v3.h"
 
 #define NR_VCPUS		4
 
+#define REDIST_RETRY_REGION0_BASE	GICR_BASE_GPA
+#define REDIST_RETRY_REGION1_BASE	\
+	(REDIST_RETRY_REGION0_BASE + 2 * KVM_VGIC_V3_REDIST_SIZE)
+#define REDIST_RETRY_DIST_BASE		\
+	(REDIST_RETRY_REGION1_BASE + KVM_VGIC_V3_REDIST_SIZE)
+#define REDIST_RETRY_REGION2_BASE	\
+	(REDIST_RETRY_DIST_BASE + KVM_VGIC_V3_DIST_SIZE)
+
 #define REG_OFFSET(vcpu, offset) (((u64)vcpu << 32) | offset)
 
 #define VGIC_DEV_IS_V2(_d) ((_d) == KVM_DEV_TYPE_ARM_VGIC_V2)
@@ -65,6 +75,23 @@ static void guest_code(void)
 	GUEST_DONE();
 }
 
+static void guest_check_redist_retry(void)
+{
+	unsigned int i;
+
+	/* The first three redistributors span adjacent regions 0 and 1. */
+	for (i = 0; i < NR_VCPUS; i++) {
+		u64 base = i < 3 ? REDIST_RETRY_REGION0_BASE +
+				       i * KVM_VGIC_V3_REDIST_SIZE :
+				       REDIST_RETRY_REGION2_BASE;
+		u64 typer = readq((void *)(unsigned long)(base + GICR_TYPER));
+
+		GUEST_ASSERT_EQ(GICR_TYPER_CPU_NUMBER(typer), i);
+	}
+
+	GUEST_DONE();
+}
+
 /* we don't want to assert on run execution, hence that helper */
 static int run_vcpu(struct kvm_vcpu *vcpu)
 {
@@ -462,6 +489,70 @@ static void test_v3_new_redist_regions(void)
 	vm_gic_destroy(&v);
 }
 
+static void test_v3_redist_region_retry(void)
+{
+	struct kvm_vcpu *vcpus[NR_VCPUS];
+	struct vm_gic v;
+	struct ucall uc;
+	u64 addr;
+	int ret;
+
+	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS,
+				     guest_check_redist_retry, vcpus);
+
+	addr = REDIST_REGION_ATTR_ADDR(2, REDIST_RETRY_REGION0_BASE, 0, 0);
+	kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+			    KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr);
+
+	addr = REDIST_REGION_ATTR_ADDR(1, REDIST_RETRY_REGION1_BASE, 0, 1);
+	kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+			    KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr);
+
+	addr = REDIST_RETRY_DIST_BASE;
+	kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+			    KVM_VGIC_V3_ADDR_TYPE_DIST, &addr);
+
+	addr = REDIST_REGION_ATTR_ADDR(1, REDIST_RETRY_DIST_BASE, 0, 2);
+	ret = __kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				    KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION,
+				    &addr);
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "register redist region colliding with dist");
+
+	addr = REDIST_REGION_ATTR_ADDR(1, REDIST_RETRY_REGION2_BASE, 0, 2);
+	kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+			    KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr);
+
+	virt_map(v.vm, REDIST_RETRY_REGION0_BASE, REDIST_RETRY_REGION0_BASE,
+		 vm_calc_num_guest_pages(v.vm->mode,
+					 3 * KVM_VGIC_V3_REDIST_SIZE));
+	virt_map(v.vm, REDIST_RETRY_REGION2_BASE, REDIST_RETRY_REGION2_BASE,
+		 vm_calc_num_guest_pages(v.vm->mode,
+					 KVM_VGIC_V3_REDIST_SIZE));
+
+	kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+			    KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
+
+	vcpu_run(vcpus[0]);
+	switch (get_ucall(vcpus[0], &uc)) {
+	case UCALL_DONE:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	case UCALL_NONE:
+		if (vcpus[0]->run->exit_reason == KVM_EXIT_MMIO)
+			TEST_FAIL("Unexpected MMIO exit at 0x%llx",
+				  vcpus[0]->run->mmio.phys_addr);
+		fallthrough;
+	default:
+		TEST_FAIL("Unexpected ucall %lu, exit_reason %u",
+			  uc.cmd, vcpus[0]->run->exit_reason);
+	}
+
+	vm_gic_destroy(&v);
+}
+
 static void test_v3_typer_accesses(void)
 {
 	struct vm_gic v;
@@ -986,6 +1077,7 @@ void run_tests(u32 gic_dev_type)
 
 	if (VGIC_DEV_IS_V3(gic_dev_type)) {
 		test_v3_new_redist_regions();
+		test_v3_redist_region_retry();
 		test_v3_typer_accesses();
 		test_v3_last_bit_redist_regions();
 		test_v3_last_bit_single_rdist();
-- 
2.39.5 (Apple Git-154)
