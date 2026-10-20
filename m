Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514382;
	b=rI7QTxOa4732bKzqpYf5FVMsak/4mdOJefBBmebwzfHFpwtS3tb6k8C/JRMAbByFjJRz
	 LSz61qJ9Vt0hCfylhhTBIawh5NVs1+FBNIebcRBV7QFcczBWdknxV/AFLlwMB+kRpEf6E
	 h0IThAK0jTSGPDYxLXRPoq9ocjmmQhBBsaolBYJV1pMeZpXC2jdkh7KEHRoWYZWH8bGhe
	 itY36AZE3v8FPHw8AiTtkjHM/2uaS0/1gyFX+NXUqec5s3W28NCS+4sUvnki+sSAKWGEg
	 iefl/puo7+iI1fvfmu2WW0oWgImSJmZV5ZS2tWtIxIBQHWfYmeELAQzgCI5jD4zjw4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514382;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Me8xE9/+Q42HSlzVQJcqG9CFCufmL51mc1y5dA1P6VI=;
	b=H4ubet1BusHAJ1u6HXNiurKZsgz5P2/gQN2htOH9lTD6u0IZFqjPKBnUWqGGopaUmYBt
	 d5ujuKS38MjYaCSCPLwUQnD17OKFZkZg6agVwQZm0b4lqz/dBi4XB193r7lOjrgZlSjyN
	 2+Hj6zr7Rq1eVrpOjN+l3hmGSi5FPEYgUbv3kj3PL3M6WSrplnrfCGYDdaYd8lGwZf9Ts
	 0u7+0DJhImYPGOvC4IHcrBBxwKo25ADUgtNGz0XuvPX6qIVtg/2JV9ARQwR8l2GqHlsm5
	 yMeIhg+4vhin353wm3XollYQz1uLzkj7ELKrldW+V05DbOTxzQt0ojbO9Lj2Pip/VUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=T70CvmUT;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3CF606D500
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 16:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A3CF606D500
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=T70CvmUT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9838525DD;
	Tue, 20 Oct 2026 09:39:37 -0700 (PDT)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FB173F7D8;
	Tue, 20 Oct 2026 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792514380; bh=uF3gHfbdma2orZBXGO3W33CSKmBuY31e2U0A16wUtI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T70CvmUTYgev5Tmb2X5hI2lrtGLa/fHVn7smRE79Yua3opx1vbQmGa9uCgJQ8o2uk
	 4VL222g2R4Lf5NZoSmSeHzwkVPfHec6aElCY6SYHnQkziTtAh0/atEJGKT50ABcPX4
	 iYkn3TI3zbfrsoWjqvlCtAWC+I69tJKgyKqf9xiA=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org
Cc: maz@kernel.org,
	oupton@kernel.org,
	fuad.tabba@linux.dev,
	joey.gouly@arm.com,
	seiden@linux.ibm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com
Subject: [PATCH v3 2/2] KVM: selftests: Reject GICv3 ITS with a GICv5 VGIC
Date: Tue, 20 Oct 2026 17:39:23 +0100
Message-Id: <20261020163923.1407856-3-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020163923.1407856-1-sascha.bischoff@arm.com>
References: <20261020163923.1407856-1-sascha.bischoff@arm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that a GICv3 ITS and a GICv5 VGIC cannot be paired, regardless
of which device is created first. Skip the check when the host does not
expose a GICv3 ITS.

Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 tools/testing/selftests/kvm/arm64/vgic_v5.c | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/vgic_v5.c b/tools/testing/selftests/kvm/arm64/vgic_v5.c
index d5df742b23001..5bf7d99d29147 100644
--- a/tools/testing/selftests/kvm/arm64/vgic_v5.c
+++ b/tools/testing/selftests/kvm/arm64/vgic_v5.c
@@ -2003,8 +2003,40 @@ int test_kvm_device(u32 gic_dev_type)
 	return 0;
 }
 
+static void test_vgic_v3_its_with_vgic_v5(void)
+{
+	struct kvm_vm *vm = vm_create_barebones();
+	int gic_fd, its_fd, ret;
+
+	if (__kvm_test_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_ITS)) {
+		pr_info("No GICv3 ITS support; skipping mixed-model test.\n");
+		kvm_vm_free(vm);
+		return;
+	}
+
+	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V5);
+	ret = __kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_ITS);
+	TEST_ASSERT(ret < 0 && errno == ENODEV,
+		    "GICv3 ITS created after GICv5 VGIC: ret=%d errno=%d",
+		    ret, errno);
+	close(gic_fd);
+	kvm_vm_free(vm);
+
+	vm = vm_create_barebones();
+	its_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_ITS);
+	ret = __kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V5);
+	TEST_ASSERT(ret < 0 && errno == ENODEV,
+		    "GICv5 VGIC created after GICv3 ITS: ret=%d errno=%d",
+		    ret, errno);
+	close(its_fd);
+	kvm_vm_free(vm);
+}
+
 void run_tests(u32 gic_dev_type)
 {
+	pr_info("Test VGICv5 and GICv3 ITS model mismatch\n");
+	test_vgic_v3_its_with_vgic_v5();
+
 	pr_info("Test VGICv5 address attrs\n");
 	test_vgic_v5_addr_attrs();
 
-- 
2.34.1

