Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F058351C34
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363693; cv=none; b=b2lIpYuFGDelSiKfs1DJHO1c3Z+8GJMGZcrw7N1vCfTr4mOiSpBqOQu7DTweWT/mtjBY9T9n7fpr9ZSOifMnUQl7xLIAY7rnr+sYUXHYFmzmh5qhNE+RaAI3PpYWicT4J3McbGEzvznMVO1NAGWZaMgZFMAO2n6eq8EzytCjTaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363693; c=relaxed/simple;
	bh=VC0CTmGJaewWmL615828FQCbNXWgDyp2PlwH1vmeh2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=upOhH8iswppuQ2NXcyYdy+aDQBh3UXC00Pa08JMOOkb0qHtoZgC4URvFMSU4RKg72I1P8WEYYJyRr/dMYeyOvhl91GOTV9U0XjVKAo+OGHST8LBeV45BH/pa+hwrLFPXtK6Q5KjzelQDRPXdt/7RcgdhS9dhW+8kWSVcd/grPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=Qd8ZIubz reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="Qd8ZIubz"
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63S87UMu001425
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 28 Apr 2026 17:07:40 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ZsX0U/9xuugcD5yPUItOyYoEt/O08ddTGev4YjQLges=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1777363660; v=1;
        b=Qd8ZIubzI5Go3svg+MQDT+IkczHKpm0rpdhXDb84Nyv+yTYXv1ox54SmwrqzCAPC
         5Pfoxq6Iyv2RzCfVrlMn+qmP/qyYp1Liz5rPdjzcvBiYvJquGyxUfBaHveJgl+t7
         ZQHIXn4sy4w+/UmMkRSUPObvJjyahO0qEyENnlpx6hNt+G0HRxyRYkHAFsaNYuS8
         I6hU2c4AiWBbefZANUN8wRXY1tLzPHNR98Gj9neiGesPlsbz99RtYtxdConl7Lxv
         UxbXR0c6FTgl9vJGDw1/1FkrkmbDrKx0dbtsocbJdry/ALCJEpIFsmXJUCUgwjuX
         ib3DAgupeWTxj7SMwh1blA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 28 Apr 2026 17:07:27 +0900
Subject: [PATCH] target/arm/kvm: Cache host CPU probe failure
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-features-v1-1-1841b39da7e6@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrDWpkqZxFbGo6WAskA4iEXdXL
 L/kf+8CocgkUGcXRDpYeJkTijwDHP08kOKQDEYbqyvjVE9+2yOJ8rYM6EOHziKkfI3U8/ldNe1
 v2buJcHv3cN8PThZJNmwAAAA=
X-Change-ID: 20260428-features-a63dcadbc86c
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
        kvm@vger.kernel.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047

kvm_arm_set_cpu_features_from_host() does not properly handle host CPU
probe failure with caching. The current algorithm can be summarized as
follows:

    If dtb_compatible is not cached:
        If kvm_arm_create_scratch_host_vcpu() fails:
            Report failure

        Cache dtb_compatible

        If getting register values fails:
            Report failure

    Report success

This algorithm has the following problems:

- If kvm_arm_create_scratch_host_vcpu() fails, probing may be repeated.
- If getting register values fails, later invocations incorrectly report
  success.

Make two changes to fix them:

- Cache dtb_compatible whenever a probe is attempted.
- Record probe failure by assigning QEMU_KVM_ARM_TARGET_NONE to
  arm_host_cpu_features.target.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Supersedes: <20260422-arm-v1-1-106a9a9e22dd@rsg.ci.i.u-tokyo.ac.jp>
---
 target/arm/kvm.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d4a68874b880..7d194ea112b1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -273,7 +273,7 @@ static uint32_t kvm_arm_sve_get_vls(int fd)
     return vls[0] & MAKE_64BIT_MASK(0, ARM_MAX_VQ);
 }
 
-static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
+static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     /* Identify the feature bits corresponding to the host CPU, and
      * fill out the ARMHostCPUClass fields accordingly. To do this
@@ -287,6 +287,13 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     uint64_t features = 0;
     int err;
 
+    ahcf->target = QEMU_KVM_ARM_TARGET_NONE;
+    ahcf->dtb_compatible = "arm,armv8";
+
+    if (!kvm_enabled()) {
+        return;
+    }
+
     /*
      * target = -1 informs kvm_arm_create_scratch_host_vcpu()
      * to use the preferred target
@@ -326,11 +333,9 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     }
 
     if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
-        return false;
+        return;
     }
 
-    ahcf->target = init.target;
-    ahcf->dtb_compatible = "arm,armv8";
     int fd = fdarray[2];
 
     err = get_host_cpu_reg(fd, ahcf, ID_AA64PFR0_EL1_IDX);
@@ -454,7 +459,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
 
     if (err < 0) {
-        return false;
+        return;
     }
 
     /*
@@ -471,9 +476,8 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         features |= 1ULL << ARM_FEATURE_EL2;
     }
 
+    ahcf->target = init.target;
     ahcf->features = features;
-
-    return true;
 }
 
 void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
@@ -481,18 +485,20 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     CPUARMState *env = &cpu->env;
 
     if (!arm_host_cpu_features.dtb_compatible) {
-        if (!kvm_enabled() ||
-            !kvm_arm_get_host_cpu_features(&arm_host_cpu_features)) {
-            /* We can't report this error yet, so flag that we need to
-             * in arm_cpu_realizefn().
-             */
-            cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
-            cpu->host_cpu_probe_failed = true;
-            return;
-        }
+        kvm_arm_get_host_cpu_features(&arm_host_cpu_features);
     }
 
     cpu->kvm_target = arm_host_cpu_features.target;
+
+    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
+        /*
+         * We can't report this error yet, so flag that we need to
+         * in arm_cpu_realizefn().
+         */
+        cpu->host_cpu_probe_failed = true;
+        return;
+    }
+
     cpu->dtb_compatible = arm_host_cpu_features.dtb_compatible;
     cpu->isar = arm_host_cpu_features.isar;
     cpu->sve_vq.supported = arm_host_cpu_features.sve_vq_supported;

---
base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
change-id: 20260428-features-a63dcadbc86c

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

