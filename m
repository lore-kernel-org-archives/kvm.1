Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7EC3911D5
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406122; cv=none; b=lGW0mlCUBYPG6jAfy0ClwuTNjBc6j12RsZorivWUldsYM+ISp6LVh3jdvztzY8v/cz6KMTSKzi9vffFmeVy7VrDUBsN4CWUa1lYEaRLGVgzzJXqVrZ07kvRCjS5M9DeG4SZQl0gBv/JO8oUSJ0RP8/32RMPDeQUSkevnRs2F3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406122; c=relaxed/simple;
	bh=RsmFmaIpLJAVk9IjgG6MrPLEx6eqIgcCwNymqmmR4OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6PIXa8l4mtZjqjm4FM/W/LIrM61XUvrB+IGhzY0Gm31Kp7ym51U76SSFCLKiQ3nGhFQnvMfC3KL0Y49tUsF1h7/ndsky54jJpVMPzbWjusJhQPnOWIGZPQqPb4xkhCDEqOBStrCWkWczMShHRRrl4EWBtjaETaG097SRyrlbIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oc0kf4mj; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oc0kf4mj"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso1387511eec.2
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406120; x=1791010920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NmcVVZs2AdigVyOz3zzkAE1Rb9Ccoa5Uym0KVLWzyjs=;
        b=Oc0kf4mjaYwK5+y7AkvC/JLuxuDgYPm8Ihro14ps3sf/cJgl5S25vn20Bn7o6WMHsA
         q/cZbVxzqEVechDHpHa20u82mFdhAZBv1uWfIGjhlTpjDTOCxGoyPU9mftDR74ko5YM+
         h9ZegIUZpp84L4widlkn2wLlaj+Zxs255W9BDBb9nLeMpHRRasuYIcPsXuo4wbO4ukUO
         4yNRkKlk5RHlU3j2YMv7MLifI5P0DKs6zp5d/6yTx1rYYaVmVsiUnRvrRCsgIOte7OB4
         JHKKNQT2hWWXeeqP4pmIt+g0DzUS0kxIv+/hg5lb27yTCxSfzT3NVXJHsjW3Uh6aqD+U
         OYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406120; x=1791010920;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NmcVVZs2AdigVyOz3zzkAE1Rb9Ccoa5Uym0KVLWzyjs=;
        b=AW9XdfnXAOp9PWaS5Cvsho5j6vwwICtmcV6Jt8T+ATqb7DFR/1b2u7/CQSghNCtTjF
         1XDWhBwjJ3TOZnb3An3UKKDhNTxzrHuMwEVmUggOez6agni/1QvH79Cq/uPWsFsM4+wo
         sSJvwdOlnArIaPImJNTqraWJ4XtlHYUEsVuRWxCTxIqLmiIRnj0dcdrlc3GYjNIqKePy
         rJLaoQidp/YqpK6FXkMfaLsdblWCmczIojRA6K/OqcVaVD8T+xMH8nqbPe2awq5qjiqf
         ndn6NlVTB6AYhE8sGFZnNePBK/k48B5BQkQpmA2LZuym0+ymdsIgEYz8bpkz9sIm0qJ+
         9B1g==
X-Forwarded-Encrypted: i=1; AKwUvBwec+WMNyefRDaRJy3IlpqlIccvy6EbOj5CvjXAD5EQMCyKgORcXxkjWxUz/22xcasPbh4=@vger.kernel.org
X-Gm-Message-State: AFuF++lenXncfBuTxVHXofzue6nCkH2c4l5sjxvWuEPcN0CnA1XR8J1b
	7cNJ7TiHVWk7soUQ3zLqFabZoNaMurxB39Ki+QSjGP620KF/Lp0hYlyA
X-Gm-Gg: AYBFou1jX+CjjyFrHmd/eom25AbMSEoM3wMnaGIXIvyguKG+Csve0y6wuif4vmSOVIw
	i0BUTcHHRjlfXVuCN4aFbmCkxisJMu1Xz67kCc9nHGOtDiRoL9l1fkPbbqtBZ+Uj7uum3hB3z48
	Q+HZuM4lCVs9STB/6uI1rdt1470V6HsSMjt0KwflqSco3VNf3Yz+nL2xZ1unb95PN9bynrOJYZh
	4UU7JzxBfcx027J9BuybwaRsUnt2V/FuoHS3hdGKK3GMtidGnrfDZVZm8y3lXR6Wka3ifzYpogj
	PVLszp+LlEpHYNOYhHx/1ANRp3++FVb8caPXXgD7jNI3bWJpp1hr+unjUEYPOA9zIkhuSu4rZeY
	S8c79tD/PukF6+qS2CuiUl66+pCow6eGQJMRjTfsZcs0X2golTjnfiIbRWMXeQRqem8s492/IHN
	ckcLrF6LFEktJ1LM92gbIYaqgx8wDvZP8pLeuOlaFEMBmwV/AdoOObLOSfrPn8nGM7URjO8apb9
	wL3SfEM56GOb0NuQKaUwYBxWatTWpKCv1TTzVkPEB8=
X-Received: by 2002:a05:693c:2589:b0:341:9040:8ec6 with SMTP id 5a478bee46e88-34273850d16mr1979752eec.41.1790406119966;
        Sat, 26 Sep 2026 00:01:59 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:01:59 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 14/55] target/arm: move kvm_arm_set_cpreg_mig_tolerances to kvm.c
Date: Sat, 26 Sep 2026 15:00:13 +0800
Message-ID: <20260926070057.1234-15-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Keep KVM kernel register-list migration policy with the other KVM
cpreg helpers.

- Move kvm_arm_set_cpreg_mig_tolerances from cpu64.c to kvm.c
- Declare it in kvm_arm.h
- Add a kvm-stub.c assert stub

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/cpu64.c    | 38 --------------------------------------
 target/arm/kvm-stub.c |  5 +++++
 target/arm/kvm.c      | 36 ++++++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h  |  9 +++++++++
 4 files changed, 50 insertions(+), 38 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 4e8c4725308..1e64eb54cdc 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -754,44 +754,6 @@ static void aarch64_a53_initfn(Object *obj)
     define_cortex_a72_a57_a53_cp_reginfo(cpu);
 }
 
-#if defined(CONFIG_KVM)
-static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
-{
-    /*
-     * Registers that may be in the incoming stream and not exposed
-     * on the destination
-     */
-
-    /*
-     * TCR_EL1 was erroneously unconditionnally exposed before linux v6.13.
-     * See commit 0fcb4eea5345 ("KVM: arm64: Hide TCR2_EL1 from userspace
-     * when disabled for guests")
-     */
-    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 2, 0, 3),
-                                     0, 0, ToleranceNotOnBothEnds);
-    /*
-     * PIRE0_EL1 and PIR_EL1 were erroneously unconditionnally exposed
-     * before linux v6.13. See commit a68cddbe47ef ("KVM: arm64: Hide
-     * S1PIE registers from userspace when disabled for guests")
-     */
-    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 2),
-                                     0, 0, ToleranceNotOnBothEnds);
-    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 3),
-                                     0, 0, ToleranceNotOnBothEnds);
-
-    /*
-     * KVM_REG_ARM_VENDOR_HYP_BMAP_2 pseudo FW register is exposed
-     * from v6.15 onwards. Backward migration from a >= v6.15 to an older
-     * kernel would fail without cpreg migration tolerance definition.
-     * If the register is present on source but not on destination, make
-     * sure it has its reset value, ie. 0, meaning no service is exposed
-     * to the guest.
-     */
-    arm_register_cpreg_mig_tolerance(cpu, KVM_REG_ARM_FW_FEAT_BMAP_REG(3),
-                                     UINT64_MAX, 0, ToleranceOnlySrcTestValue);
-}
-#endif
-
 void aarch64_host_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 88cbe8d85c4..ecbd4f9aca1 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -50,6 +50,11 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     g_assert_not_reached();
 }
 
+void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
 void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
 {
     g_assert_not_reached();
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ed99be7fd80..2525b9d429c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -505,6 +505,42 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     env->features = arm_host_cpu_features.features;
 }
 
+void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
+{
+    /*
+     * Registers that may be in the incoming stream and not exposed
+     * on the destination
+     */
+
+    /*
+     * TCR_EL1 was erroneously unconditionnally exposed before linux v6.13.
+     * See commit 0fcb4eea5345 ("KVM: arm64: Hide TCR2_EL1 from userspace
+     * when disabled for guests")
+     */
+    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 2, 0, 3),
+                                     0, 0, ToleranceNotOnBothEnds);
+    /*
+     * PIRE0_EL1 and PIR_EL1 were erroneously unconditionnally exposed
+     * before linux v6.13. See commit a68cddbe47ef ("KVM: arm64: Hide
+     * S1PIE registers from userspace when disabled for guests")
+     */
+    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 2),
+                                     0, 0, ToleranceNotOnBothEnds);
+    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 3),
+                                     0, 0, ToleranceNotOnBothEnds);
+
+    /*
+     * KVM_REG_ARM_VENDOR_HYP_BMAP_2 pseudo FW register is exposed
+     * from v6.15 onwards. Backward migration from a >= v6.15 to an older
+     * kernel would fail without cpreg migration tolerance definition.
+     * If the register is present on source but not on destination, make
+     * sure it has its reset value, ie. 0, meaning no service is exposed
+     * to the guest.
+     */
+    arm_register_cpreg_mig_tolerance(cpu, KVM_REG_ARM_FW_FEAT_BMAP_REG(3),
+                                     UINT64_MAX, 0, ToleranceOnlySrcTestValue);
+}
+
 static bool kvm_no_adjvtime_get(Object *obj, Error **errp)
 {
     return !ARM_CPU(obj)->kvm_adjvtime;
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index e7c40fb003e..014b7bad65b 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -133,6 +133,15 @@ void kvm_arm_destroy_scratch_host_vcpu(int *fdarray);
  */
 void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
+/**
+ * kvm_arm_set_cpreg_mig_tolerances:
+ * @cpu: ARMCPU to register the tolerances on
+ *
+ * Register KVM cpreg migration tolerances for kernel register-list
+ * differences (hidden sysregs and newer FW feature bitmaps).
+ */
+void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu);
+
 /**
  * kvm_arm_add_vcpu_properties:
  * @cpu: The CPU object to add the properties to
-- 
2.52.0.windows.1

