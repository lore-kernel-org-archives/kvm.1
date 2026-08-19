Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158713F076F
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787179394; cv=none; b=grJiaV6/PupxQGzVNUbI1vVyHWMiAu5KywEuQ/Pe2wCEK1maCUmz7EC0V0Pe3nhdlCg2tz2y55+5s2djjCfoAabdGZA1v8UOOqfzgBA2le4jWpsv/pjdXEqI2SPX2ojv3GQnkXGCbTq08yn0BMwPV5lVWYo5dX20ladgW1Eix68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787179394; c=relaxed/simple;
	bh=JsaezUgZuqyAGhX1M6QEu1MJ3MJycvUa7dNttqCPacs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vq5N91iqouOWkHkRJOSjSH73hhtSGdux2qUEuDLUni13yNcS/vyvhXBz5UpWUz2ygBc4wuVmk+rGtcaFZKA9nP6micAAWJJQ6C3t8Fm2N93X1cmFLjCJnoXUG0NvJbeHxIWZykKLsxUQuSt49Cbt+C3NcTCjLLNsxsa146BJbXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROCtQTT5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROCtQTT5"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47fe377a217so920403f8f.1
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 15:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787179391; x=1787784191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8yRbZXjon4rpFYxflr/N9botiLzLz0TZjPgpbneMm6g=;
        b=ROCtQTT5E04Gnh9WmnvRfdm2VDKKKaF+HR1l2u38PcaoqeHWwh8W2pAtsHFLGdctiL
         2ob8siHIYz2RX1DqFZTiHVbdiztKSL47wIuLIW9LA7mpcUZb1kqaQToXOUqRTp6IRQgZ
         8hXB8PHEecmG+NaKBEUOSKy3rzabjsQYVhE1nTrT0chjor66in0H0/JxnqzXVW8F1MFU
         8AXi1pY5o7Lisf6VFQSmKe3a5oqsqxwaRRgZJ+tT3ASNspSRBiHqPFgrvHWSjvakAtId
         2SRvjG5GYNIthXqDZBJOnHl8hufFRjcz/UJkWYj0InnZ2YDgl+Yv7h0Izpg2/duEbS67
         lGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787179391; x=1787784191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8yRbZXjon4rpFYxflr/N9botiLzLz0TZjPgpbneMm6g=;
        b=n/RNPCsUSD1BWYgjFFjEXid21yHcpLNhIStoZX0DinLluAq4i5fRvR8YMbbw0LFYXc
         5dBaVvEvALWZVJNvT20rVlwXDGTztyMsJxPQI/nude+Ahvij3QGrdhTBA9bOiahaE/Ue
         Y8WjOJOSFukOCVdzuSvqK48kTsa+y5ajhIlHjQYBT4wCg63ZWywY9aeM65YjnoJMfmy1
         6D1mo8XRhpy2bAYji0BiPF6IHtA1smBXU7+dmeiW4YMsHdaR3LRag/CTZRx/KMbSWQYQ
         PJz3eS5RynAtp2uwELPqcJCiauLlVUBIi8Z2brTRsqncRfTYTfaLNhKtT0SHqHLVSPbz
         SW6Q==
X-Forwarded-Encrypted: i=1; AHgh+RqhKlHvroNHw0FhJJxfkNNLiQkTHeXYn7NlygKL+SsH59yIMioMjryhBZ+Oqwl4XM3bvZY=@vger.kernel.org
X-Gm-Message-State: AFuF++mTMk0FNVkNLUzjzr99mSAqIAhjhdTR7n7ngMyHJ6y7zrgRLulb
	O6PX9RZApfgsEtWHsGjiAqQVo1oLLgqqgK7M/jBJuj/YAwkwXkAPxZA6
X-Gm-Gg: AR+sD12ZhxNYebYCllMwE+L43vzH4VoWnE0lIfdizdpOl618HpU0G3ZkLt2AatN1rDa
	d3nnzMKyzCzlwSemWkRsPgJ6C5JMvZm/jVK3OOBBc+l44deMdu+C4s3197z/mRMOOwIThCY3EDV
	t89T+yTZKFqpFZczoJpzGpHu7tIDQXKhQjRKLA9yoc7NNTiHTBMgwluAeqbBLCJSwMQzz2SAJDg
	VBC9/VrJiKd9AmBLJ+tOk0+Gk2M8W+wl4IuDE+uPagaSHmdUKffulseK33CXUUcZo7F+TBE2iKF
	0Ytx/UWLXq5b3fw72jtUNDwsrj7FON/o5LQK2SacCh7cQ+r6QIM0p36uD52pfVL7Q7l2k75jaMo
	zsVbLqsb/l3fCMp6DS86ExGghduu8uU05+G+84lg02n110Lq21NYwsjlDAGwDmhxJC0uYsTqOV1
	HSsWfpbOtHHiuIj4KpKFRZYWJj6n7jWbvhZ9J3xDkOlHQ0T+5UtC7W1NrifMTTPRV1bZgUIqpa2
	ygF3Zi2tzcGBYx11IBtoQBlwUq4g6zV8E90t8bnsAp3h14LnlvsTo1pZ9+T33e8eWokONm2aT/D
	BmdigQlMHG4sRlXsYfo3i6yqVo/QQnJn9xV1mm57MVBAqtSoL8gMOr33x3lJm8lBZpc=
X-Received: by 2002:a05:6000:715:b0:47f:86d5:d1d7 with SMTP id ffacd0b85a97d-482b1e957b9mr16809030f8f.6.1787179391108;
        Wed, 19 Aug 2026 15:43:11 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae9e-1d01-58d3-443d-4fa6-01cd.310.pool.telefonica.de. [2a02:3100:ae9e:1d01:58d3:443d:4fa6:1cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1450e61sm8553317f8f.13.2026.08.19.15.43.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Aug 2026 15:43:10 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <tabba@google.com>,
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
Subject: [PATCH v2 5/5] KVM: arm64: selftests: Test VGICv3 redistributor region retry
Date: Thu, 20 Aug 2026 00:42:29 +0200
Message-Id: <20260819224229.82948-6-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260819224229.82948-1-kmehltretter@gmail.com>
References: <20260819224229.82948-1-kmehltretter@gmail.com>
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
---
 tools/testing/selftests/kvm/arm64/vgic_init.c | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/vgic_init.c b/tools/testing/selftests/kvm/arm64/vgic_init.c
index 91484fd4f786..6d9998c764bc 100644
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
@@ -65,6 +75,22 @@ static void guest_code(void)
 	GUEST_DONE();
 }
 
+static void guest_check_redist_retry(void)
+{
+	unsigned int i;
+
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
@@ -462,6 +488,70 @@ static void test_v3_new_redist_regions(void)
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
@@ -986,6 +1076,7 @@ void run_tests(u32 gic_dev_type)
 
 	if (VGIC_DEV_IS_V3(gic_dev_type)) {
 		test_v3_new_redist_regions();
+		test_v3_redist_region_retry();
 		test_v3_typer_accesses();
 		test_v3_last_bit_redist_regions();
 		test_v3_last_bit_single_rdist();
-- 
2.39.5 (Apple Git-154)
