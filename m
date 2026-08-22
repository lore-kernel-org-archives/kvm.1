Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D533BE16C
	for <kvm@vger.kernel.org>; Sat, 22 Aug 2026 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787392447; cv=none; b=coujMDELcdx8CQzOCrvtSEhMMD0xd9CJUvkbsu1OduAmJXelbmb/Zex4KkBu+ueVbUt72FXtZnt0D8JoDz43yrEratfcMVLLkLbCbF9nd9ICgAKKBPXLlx+MXmwQNgxH8qvz9pGzhiH4dSCv9Gyh52R4NNfDujc2WYi202KAi1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787392447; c=relaxed/simple;
	bh=x1giPFDv/gONXuicCcEUE5OwuiGeHJuokCnsgSDm8JE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t1sgdgjwahTVwnKHT4uAHBGT5pUH4hQ9HXwroCCJyEuUIdRUp3GT9mgC4c9O9A8aGCEoWKNugLc8psW5qX7Fgg2StmM0oWbjF9XzrVQbkcOk4m0rl0PZl1+FSLFaeTUuKy8X9J8DvKi7riwVGf/nH4zbdKUNY2uL+Mb82vgGCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL1zbmWP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL1zbmWP"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so2964106a12.2
        for <kvm@vger.kernel.org>; Sat, 22 Aug 2026 02:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787392443; x=1787997243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IJR++uOi5dTiSKJhpV6uor7RZpeZqCuTfsiFF6sw6hM=;
        b=UL1zbmWPX+rlBmVCOAtzyj1Fkp3+mDpaKFsFHSb1A0BerxvTrm+J7qSVem0t9swKtk
         8X3VGcHhmcpORVXcF7tob7zQdMev09UNT3YqLeK4Lsh0k3psmc0XDJWBvCCCu/WaOzGu
         Ahx7kh8p01TnxWqsL/YK/1i9dBvBejqW7uFIDeYNRGhqn1jMHu2aZdigUO26vklt46X4
         nXLGgkqWk8uxOYimtdHqjpZZcWfn32YcILZf+PBc5WxQ41bexanpKbPBc+AJ+YgqiWrH
         L4s4pJgpKylJrOZn+00t4V/qWsEySBeTSpR4vDBAwzUA80E1i4vOPphSHK60lFtQwzOG
         i/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787392443; x=1787997243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IJR++uOi5dTiSKJhpV6uor7RZpeZqCuTfsiFF6sw6hM=;
        b=iZNZak4zmrOLnBRInDbwyqojKXkoqqKXW2q2uLtmndMTZ85930jmIcKJjO8t5FIneM
         KuUgCdLmqNpLq41SfyWoRXWLvtAsz3Ibtr6b722sNlLChLNs41itlUoyatbUW/Z9PJ65
         TDMv4IUPmjZQmBbPonxiI50TFHMT1aiwDrG8MHRrUkFxukbw0z542IYBaFJvAk+kRiBC
         EdyYChyQWd35t6rXXWrO7JLdXQm+h51acBL5biQCRzQ69Dyuuc4VIQrpoNvNkA9e4BuC
         fRrFD632XOzLzWPamdXJjUWW91Xm0J94LGx6HHt/PSzGVCXtGg2vAYz1oD16AXx7f8zv
         zScQ==
X-Forwarded-Encrypted: i=1; AHgh+RpOSYL8EVQzl85cc7WFCuVdLMtFVc6XMMYDM/t+zh/qfGGNMSSzQHs21WZOpdNjOOhD4Bc=@vger.kernel.org
X-Gm-Message-State: AFuF++l1J7JPsSCb1dLwjB6FLJSrZa27hSdSwPKkEnIHzA+UCjCnYceU
	d9AP0TMZfhkSfAmN4kIGuNQp2oXw6i8X2WTCjjNRObYj/zc13Fnx7xYk
X-Gm-Gg: AR+sD10/rk7Bpof2YWipuO60Q7Ej0ZHdnRyHIV5o5kH3BqXCEkDmPzM1/K2ZvFqfPM2
	nj7GG9UigXHuA8T0adjf8Q5MvgQRZh1WZO6+L7nZxrH3GJ/V8Qx3Kfp408mu74nLp5V6V/x+SLD
	c/sjZlBvym3bsmN8ov8pqcLVifZVnEIxBNyvo/EahCYzhMvWxJMW88PA1L03uMyiBBqPHB1ywnZ
	KCSfIQ0Zz6pCwvH5D43aNRbcNrrKklE+v+vCmUlXAgr1ZvJnEvYchirFWcwt2vAr08uwUjlmVfT
	HGPSor8H/+eQgq/wF4pqnhmGiBaoML1U4sJ0ucme2Exxcr9Su5jBQ8+EBABJtpxbqNoXYjQPPnK
	yHEM8m3dcvfFoyM5hM02WphVlzPUPD+oD3X8OFQNXNfMNIUsH7Ynw5Ptmi4y6Q+4vD0o3Xb/e78
	sxHA/f7yCeYX+m5PqCyimJRP3Kst6moYeGH4wMixPPsGvknWLoQXkVGDoI9FWzaHhbhXGiZ7qD6
	QTLjY8Hagr/plWd8l9pNIC7eUMdNzDGlwmC25JtYYH2qsyVSWSNf7ZrsvDXZ+T540jzS/Kw8V9N
	kTPMMUCRsRvjSPsI2rwJ74PzuqTYfjdiyXoAT+KvaXbGRpYSFUPO5gmObKQRf5wcpRpC
X-Received: by 2002:a05:6402:21dc:b0:6a3:fee5:adcf with SMTP id 4fb4d7f45d1cf-6a42f14d952mr13251775a12.1.1787392443344;
        Sat, 22 Aug 2026 02:54:03 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de. [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c327asm11151586a12.8.2026.08.22.02.54.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 02:54:02 -0700 (PDT)
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
Subject: [PATCH v3 4/5] KVM: arm64: selftests: Pass guest code to vm_gic_create_with_vcpus()
Date: Sat, 22 Aug 2026 11:53:45 +0200
Message-Id: <20260822095346.53882-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260822095346.53882-1-kmehltretter@gmail.com>
References: <20260822095346.53882-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the guest-code address to vm_gic_create_with_vcpus(), and use
guest_code at the existing call sites. This lets tests with different guest
code reuse the common VM and VGIC setup while retaining the void *
interface of vm_create_with_vcpus().

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 tools/testing/selftests/kvm/arm64/vgic_init.c | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/vgic_init.c b/tools/testing/selftests/kvm/arm64/vgic_init.c
index 47e34b43afb2..84aa97204b7f 100644
--- a/tools/testing/selftests/kvm/arm64/vgic_init.c
+++ b/tools/testing/selftests/kvm/arm64/vgic_init.c
@@ -73,6 +73,7 @@ static int run_vcpu(struct kvm_vcpu *vcpu)
 
 static struct vm_gic vm_gic_create_with_vcpus(u32 gic_dev_type,
 					      u32 nr_vcpus,
+					      void *guest_code,
 					      struct kvm_vcpu *vcpus[])
 {
 	struct vm_gic v;
@@ -338,7 +339,7 @@ static void test_vgic_then_vcpus(u32 gic_dev_type)
 	struct vm_gic v;
 	int ret, i;
 
-	v = vm_gic_create_with_vcpus(gic_dev_type, 1, vcpus);
+	v = vm_gic_create_with_vcpus(gic_dev_type, 1, guest_code, vcpus);
 
 	subtest_dist_rdist(&v);
 
@@ -359,7 +360,8 @@ static void test_vcpus_then_vgic(u32 gic_dev_type)
 	struct vm_gic v;
 	int ret;
 
-	v = vm_gic_create_with_vcpus(gic_dev_type, NR_VCPUS, vcpus);
+	v = vm_gic_create_with_vcpus(gic_dev_type, NR_VCPUS, guest_code,
+				     vcpus);
 
 	subtest_dist_rdist(&v);
 
@@ -411,7 +413,8 @@ static void test_v3_new_redist_regions(void)
 	u64 addr;
 	int ret;
 
-	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS, vcpus);
+	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS,
+				     guest_code, vcpus);
 	subtest_v3_redist_regions(&v);
 	kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
 			    KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
@@ -422,7 +425,8 @@ static void test_v3_new_redist_regions(void)
 
 	/* step2 */
 
-	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS, vcpus);
+	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS,
+				     guest_code, vcpus);
 	subtest_v3_redist_regions(&v);
 
 	addr = REDIST_REGION_ATTR_ADDR(1, 0x280000, 0, 2);
@@ -436,7 +440,8 @@ static void test_v3_new_redist_regions(void)
 
 	/* step 3 */
 
-	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS, vcpus);
+	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS,
+				     guest_code, vcpus);
 	subtest_v3_redist_regions(&v);
 
 	ret = __kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
@@ -608,7 +613,8 @@ static void test_v3_redist_ipa_range_check_at_vcpu_run(void)
 	int ret, i;
 	u64 addr;
 
-	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, 1, vcpus);
+	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, 1, guest_code,
+				     vcpus);
 
 	/* Set space for 3 redists, we have 1 vcpu, so this succeeds. */
 	addr = max_phys_size - (3 * 2 * 0x10000);
@@ -641,7 +647,8 @@ static void test_v3_its_region(void)
 	u64 addr;
 	int its_fd, ret;
 
-	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS, vcpus);
+	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS,
+				     guest_code, vcpus);
 	its_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_ITS);
 
 	addr = 0x401000;
@@ -684,7 +691,8 @@ static void test_v3_nassgicap(void)
 	u32 typer2;
 	int ret;
 
-	vm = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS, vcpus);
+	vm = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS,
+				      guest_code, vcpus);
 	kvm_device_attr_get(vm.gic_fd, KVM_DEV_ARM_VGIC_GRP_DIST_REGS,
 			    GICD_TYPER2, &typer2);
 	has_nassgicap = typer2 & GICD_TYPER2_nASSGIcap;
-- 
2.39.5 (Apple Git-154)

