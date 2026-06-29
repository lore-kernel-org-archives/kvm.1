Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BE83EAC76
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782720633; cv=none; b=Bt1P0AEQ3ayVUMr29AnSR1sKU6V0LJHpfzepFWpT2DZEcMXXREM5mpTMCRP2Xn79qzDLqMjufWHwt3ZsohhWMX+OIW9a7SRUpBgHDLtvXFYGm62dIbT+wo2kXwsBY+UGwOEXQSM2CsxUoxOumRQByl9k40rDFaaPZwHsnabAuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782720633; c=relaxed/simple;
	bh=NOddyoW1QSFprsadGPfRc4eDcTb4qMBeBLKW310x0/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W265lhVIgKogWEt/cWAloqMk4f80dtGcVBEN9j9QXsNBfSPuJTFnFjQKHeEsMQ6kb5BD+YHIrsGOUjf2HO0hfZP27/Oi3mI9l7JwFUcN2Jiw6zG+ZADOppUrZF8tSwpWgtHgqLjvhgkDZ3WYSFWjCILmPUsu6nhMVTBbnD+EhkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=Bj/+ZD8Q reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="Bj/+ZD8Q"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65T8A8FN080280
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 29 Jun 2026 17:10:20 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=45A0yc7fdzoVpIaOAtzzsDwOKquOmy46iehdiNNBXeY=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1782720620; v=1;
        b=Bj/+ZD8QdgUvVlbQiSYUC1wPU5wF5e3gCYPMZVx/KEcsUzoiLI2SRnC3RFxpuPBR
         E5iOlUqpWlTErxiJeJEykckol8a+j08F0Iwmgvug+Pvsi09Q5CSB+H9No25aVI34
         VoNSZ7VFd0nZOCzfHE8A/Bg9yzMhphabUGan5R617HUemj+hEESZfIveM2KeCZHk
         8ugI5Lo0fGOkWAkioaQIT+cU+rC024T9F8O6/7TZPNTyqg1aFR54AmTxWUtWj7D4
         gXWxSs4HQYhhetpm91EXfiZK8Og8zBhqgTlWbo5JxZHRggsm4rtWclbfaZ1Dr42z
         wlf12BKpJSXYt97KXhuPMg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 29 Jun 2026 17:10:06 +0900
Subject: [PATCH v7] target/arm: Always add pmu property for host and max
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pmu-v7-1-939518c349be@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23My27CMBCF4VdBXteWPb5NuuI9Kha+BdyKOEogI
 kJ59xqiilbp8ozm++9kTENOI3nf3cmQpjzm0tVh33YknFx3TDTHuglwUNxAQ/vzlbqoW2MTBB0
 5qZ/9kNp8e1Y+DnWf8ngpw/yMTuJx/esnQTm1YBoB0iM6tY9u7vKNhXImj8AEL2SFWRFU1Mokk
 /IQZdQbJP9BsiIMNgjU6ADsBqlfCPiKVEXgwAO2xnNsN0j/IM0FVyvSVFCfmoDW2mDRbJB5IS3
 FikxF4L0JCOhikvthPLKQWWZXeilfc2EusM+eHJZl+QYzfaZhrAEAAA==
X-Change-ID: 20240629-pmu-ad5f67e2c5d0
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
        devel@daynix.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3881;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=NOddyoW1QSFprsadGPfRc4eDcTb4qMBeBLKW310x0/A=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5aTRrbu9kd61/XYdxjNilDIlmgpfTEp5c3FKvWX/lrbn
 SLqORI7SlkYxLgYZMUUWVKKdnNrRNd+KkyIb4GZw8oEMoSBi1MAJuK7h5HhEZvqG9vWKWkar6sl
 P3t3c7zjqDScdZhBPWRR6PT9N6/bM/z3MbBda37myMkIxSvcb+fxCUVyL5RhdV1eMGun/r6Os1O
 YAA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

kvm-steal-time and sve properties are added for KVM even if the
corresponding features are not available. Always add pmu property for
"host" and "max".

Note that we still don't add the property for other CPUs that lack PMU.
This is because we do not know what a PMU version should be enabled
when the user sets the property to true while it is defined as an error
for the "host" or "max" CPU when the hardware accelerator is enabled and
the host doesn't have a PMU.

This fixes qtest-aarch64/arm-cpu-features on the hosts that supports
KVM but doesn't support PMU emulation.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v7:
- Reject pmu=on for "host" when PMU is unavailable.
- Handle "max" too, since it maps to "host" with hwaccel.
- Link to v6: https://lore.kernel.org/qemu-devel/20250531-pmu-v6-1-2bb6c828ade3@rsg.ci.i.u-tokyo.ac.jp

Changes in v6:
- Limited the scope of the change to the "host" CPU.
- Link to v5: https://lore.kernel.org/r/20250104-pmu-v5-1-be9c8777c786@daynix.com

Changes in v5:
- Rebased.
- Link to v4: https://lore.kernel.org/r/20240720-pmu-v4-0-2a2b28f6b08f@daynix.com

Changes in v4:
- Split patch "target/arm/kvm: Fix PMU feature bit early" into
  "target/arm/kvm: Set PMU for host only when available" and
  "target/arm/kvm: Do not silently remove PMU".
- Changed to define PMU also for Armv7.
- Changed not to define PMU for M.
- Extracted patch "hvf: arm: Raise an exception for sysreg by default"
  from "hvf: arm: Properly disable PMU".
- Rebased.
- Link to v3: https://lore.kernel.org/r/20240716-pmu-v3-0-8c7c1858a227@daynix.com

Changes in v3:
- Dropped patch "target/arm: Do not allow setting 'pmu' for hvf".
- Dropped patch "target/arm: Allow setting 'pmu' only for host and max".
- Dropped patch "target/arm/kvm: Report PMU unavailability".
- Added patch "target/arm/kvm: Fix PMU feature bit early".
- Added patch "hvf: arm: Do not advance PC when raising an exception".
- Added patch "hvf: arm: Properly disable PMU".
- Changed to check for Armv8 before adding PMU property.
- Link to v2: https://lore.kernel.org/r/20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com

Changes in v2:
- Restricted writes to 'pmu' to host and max.
- Prohibited writes to 'pmu' for hvf.
- Link to v1: https://lore.kernel.org/r/20240629-pmu-v1-0-7269123b88a4@daynix.com
---
 target/arm/cpu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 86aae36ae552..4a4bed525359 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1345,11 +1345,11 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
-    if (value) {
-        set_feature(&cpu->env, ARM_FEATURE_PMU);
-    } else {
-        unset_feature(&cpu->env, ARM_FEATURE_PMU);
+    if (value && !arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
+        error_setg(errp, "'pmu' feature is not supported");
+        return;
     }
+
     cpu->has_pmu = value;
 }
 
@@ -1529,6 +1529,7 @@ static void arm_cpu_propagate_feature_implications(ARMCPU *cpu)
 static void arm_cpu_post_init(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMCPUClass *acc = ARM_CPU_GET_CLASS(obj);
 
     /*
      * Some features imply others. Figure this out now, because we
@@ -1585,6 +1586,10 @@ static void arm_cpu_post_init(Object *obj)
 
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
         cpu->has_pmu = true;
+    }
+
+    if (cpu->has_pmu || !strcmp(acc->info->name, "host") ||
+        !strcmp(acc->info->name, "max")) {
         object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
     }
 

---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20240629-pmu-ad5f67e2c5d0

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

