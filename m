Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F197034DB78
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933181; cv=none; b=VNXkR9E+yc4v5oG02S7AWztvBSiiKK9NKPL0A5bJHfkb8amQwbEULsM96og+mMEDiMhCityty+BWWZV2Fk+gxWLI4tV8uiqfZjyne96D9Ytc1Axvl0y5Im+bUl1rLp21Zn43ZkSVZFTgRFm3+diUvdedSeYDtPHluEcuOw1cjVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933181; c=relaxed/simple;
	bh=UiJXBzEDtGjAo4NQFaDDUFk7SrWNgKloU8ziFTr9lAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HD3r314HQIdpNyHZKGDSilz2UiLcXKRjAwoSOdpxKudqjTVfzjZUStO1z6PjlTo81+rAXxpNCjl4dGisb5eb9NNuwLI6uWp14/v4kzCYWsv5hhBElDqh7KzIdWxETMUOGZfoROBI0AQK0L+agmvykSubCBNRRGN57Qa4TXDmUA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=JeBC3zob reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="JeBC3zob"
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63N8Wewo059581
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 23 Apr 2026 17:32:49 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=sJSMTWN03zXVLHAoey3crPJfwg9o9kfFUUSlPmyQkRE=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1776933169; v=1;
        b=JeBC3zobdNvyzyZesxEHdBOa4qhlt4wHIPbaa4MSvQBKwtgpIkmFg7P9QQairgP/
         2+Qo+leHafQGuHK6wYFIlyBSl+wQByW3dKPzmyBZ4Opxg00FXis87gh/9VIjv+eV
         QThs7FF8o0VoOzJhKZbEXQy5G3+rkpmX2N4T7OdwrKhnMcGfsTAiNOXarkZf0SNL
         orH9qoEF1/Lm/9aTLSHokdOH8RgQTeBu5KZSQZmchZF9osMTq4lf5fHt+QlwQH4p
         1iny0olLD4mPJ+gzUWTz+BSYLeWwdwQ0b6JGjmJrW5Fy0POkE5vgfDTB26DyKiGZ
         Eyw9Xv5kqx4+5cxZzN8VjA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 23 Apr 2026 17:32:39 +0900
Subject: [PATCH RFC v3] target/arm/kvm: Choose PMU backend
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260423-kvm-v3-1-e3c2f87974ac@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XPTW7DIBAF4KtYrAsaBmOQV5Eq9QDdVl3w54RGD
 ik4qFGUuxeRtrsuZwY+vXcjJeQYCpmHG8mhxhLTqQ3iaSDuYE77QKNvM0FACUoAPdaV6sXB5PS
 iEA1pL885LPGrK2/k9eWZvLflIZYt5WuXK++njmiYOlI55dRzL8EqkNr5XS575iKL7EK3dLwmZ
 hz7OHes4i8wAaJ8ANgAq70ahbewKPEvcH9kzOHz0gpuP0H/+s1Dd0dEanJrN1oU3niQE59b8vb
 ZmhKoS+sat3monDNg0Nj7N6QpPb0/AQAA
X-Change-ID: 20250730-kvm-8fc06c8f722a
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
        qemu-arm@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047

Commit 6ee7fca2a4a0 ("KVM: arm64: Add KVM_ARM_VCPU_PMU_V3_SET_PMU
attribute") of Linux describes the KVM_ARM_VCPU_PMU_V3_SET_PMU
attribute, which allows choosing a PMU backend, and its motivation:
> KVM: arm64: Add KVM_ARM_VCPU_PMU_V3_SET_PMU attribute
>
> When KVM creates an event and there are more than one PMUs present on
> the system, perf_init_event() will go through the list of available
> PMUs and will choose the first one that can create the event. The
> order of the PMUs in this list depends on the probe order, which can
> change under various circumstances, for example if the order of the
> PMU nodes change in the DTB or if asynchronous driver probing is
> enabled on the kernel command line (with the
> driver_async_probe=armv8-pmu option).
>
> Another consequence of this approach is that on heteregeneous systems
> all virtual machines that KVM creates will use the same PMU. This
> might cause unexpected behaviour for userspace: when a VCPU is
> executing on the physical CPU that uses this default PMU, PMU events
> in the guest work correctly; but when the same VCPU executes on
> another CPU, PMU events in the guest will suddenly stop counting.
>
> Fortunately, perf core allows user to specify on which PMU to create
> an event by using the perf_event_attr->type field, which is used by
> perf_init_event() as an index in the radix tree of available PMUs.
>
> Add the KVM_ARM_VCPU_PMU_V3_CTRL(KVM_ARM_VCPU_PMU_V3_SET_PMU) VCPU
> attribute to allow userspace to specify the arm_pmu that KVM will use
> when creating events for that VCPU. KVM will make no attempt to run
> the VCPU on the physical CPUs that share the PMU, leaving it up to
> userspace to manage the VCPU threads' affinity accordingly.
>
> To ensure that KVM doesn't expose an asymmetric system to the guest,
> the PMU set for one VCPU will be used by all other VCPUs. Once a VCPU
> has run, the PMU cannot be changed in order to avoid changing the
> list of available events for a VCPU, or to change the semantics of
> existing events.

Choose a PMU backend with the following priority order:

1. The event source specified with the pmu property. It is a user's
   responsibility to ensure that the VCPUs runs on PCPUs associated with
   the event source.

2. The default backend if the machine version is old. This ensures
   backward compatibility but the resulting PMU may or may not work.

3. An event source that covers all PCPUs. This exposes its full feature
   set to the guest. If multiple such physical PMUs exist, selection is
   deterministic, based on the device hierarchy.

4. The fixed-counters-only PMU, which is emulated with all compatible
   event sources, if available.

Disable PMU if no backend can be chosen.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Based-on: <20260422-arm-v1-1-106a9a9e22dd@rsg.ci.i.u-tokyo.ac.jp>
("[PATCH] target/arm/kvm: Mark host feature cache valid last")

This is an RFC patch to demonstrate the usage of a new device attribute
which is added with the following series:
https://lore.kernel.org/r/20260418-hybrid-v7-0-2bf39ad009bf@rsg.ci.i.u-tokyo.ac.jp
("[PATCH v7 0/4] KVM: arm64: PMU: Use multiple host PMUs")
---
Changes in v3:
- Simplified PMU probing by following what kvmtool does.
- Added missing kvm_arm_destroy_scratch_host_vcpu().
- Changed the KVM compatibility property optional for non-Arm.
- Ensured to avoid setting a PMU when pmu=false.
- Fixed register probing.
- Added a check to prevent changing properties after initialization.
- Link to v2: https://lore.kernel.org/qemu-devel/20260225-kvm-v2-1-b8d743db0f73@rsg.ci.i.u-tokyo.ac.jp

Changes in v2:
- Updated the backcompat-pmu compatibility property.
- Renamed the KVM_ARM_VCPU_PMU_V3_FIXED_COUNTERS_ONLY attribute.
- Link to v1: https://lore.kernel.org/qemu-devel/20250806-kvm-v1-1-d1d50b7058cd@rsg.ci.i.u-tokyo.ac.jp

To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Yanan Wang <wangyanan55@huawei.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: kvm@vger.kernel.org
Cc: qemu-arm@nongnu.org
---
 hw/core/machine.c       |   2 +
 target/arm/kvm.c        | 339 +++++++++++++++++++++++++++++++++++++++++++++++-
 qemu-options.hx         |  20 +++
 target/arm/trace-events |   2 +
 4 files changed, 359 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0aa77a57e956..2492e985b6dd 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -23,6 +23,7 @@
 #include "qemu/madvise.h"
 #include "qom/object_interfaces.h"
 #include "system/cpus.h"
+#include "system/kvm.h"
 #include "system/system.h"
 #include "system/reset.h"
 #include "system/runstate.h"
@@ -41,6 +42,7 @@
 GlobalProperty hw_compat_10_2[] = {
     { "scsi-block", "migrate-pr", "off" },
     { "isa-cirrus-vga", "global-vmstate", "true" },
+    { TYPE_KVM_ACCEL, "backcompat-pmu", "true", .optional = true },
 };
 const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 03c3346d50ed..d352b3e4398f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -15,6 +15,7 @@
 
 #include <linux/kvm.h>
 
+#include "qemu/cutils.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
@@ -43,6 +44,8 @@
 #include "target/arm/gtimer.h"
 #include "migration/blocker.h"
 
+#define KVM_ARM_VCPU_PMU_V3_FIXED_COUNTERS_ONLY 5
+
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(DEVICE_CTRL),
     KVM_CAP_LAST_INFO
@@ -52,6 +55,19 @@ static bool cap_has_mp_state;
 static bool cap_has_inject_serror_esr;
 static bool cap_has_inject_ext_dabt;
 
+typedef enum PMU {
+    PMU_UNSET,
+    PMU_NONE,
+    PMU_DEFAULT,
+    PMU_EVENT_SOURCE,
+    PMU_FIXED_COUNTERS_ONLY
+} PMU;
+
+static PMU pmu;
+static uint64_t pmu_user_event_source;
+static uint32_t pmu_effective_event_source;
+static bool pmu_backcompat;
+
 /**
  * ARMHostCPUFeatures: information about the host CPU (identified
  * by asking the host kernel)
@@ -221,6 +237,259 @@ static bool kvm_arm_pauth_supported(void)
             kvm_check_extension(kvm_state, KVM_CAP_ARM_PTRAUTH_GENERIC));
 }
 
+static bool read_pmu_attr(int fd, const struct dirent *ent, const char *name,
+                          char **buf, size_t *n)
+{
+    FILE *attr_file;
+    g_autofree char *rel_name = g_build_filename(ent->d_name, name, NULL);
+    int attr_fd = openat(fd, rel_name, O_RDONLY);
+    bool ret;
+
+    if (attr_fd < 0) {
+        return false;
+    }
+
+    attr_file = fdopen(attr_fd, "r");
+    assert(attr_file);
+    ret = getline(buf, n, attr_file) >= 0;
+    assert(!fclose(attr_file));
+
+    return ret;
+}
+
+static bool parse_cpus(const char *list, unsigned long **bitmap,
+                       unsigned long *nr)
+{
+    unsigned long start, end;
+
+    bitmap_clear(*bitmap, 0, *nr);
+
+    while (*list && *list != '\n') {
+        if (qemu_strtoul(list, &list, 0, &start) == -EINVAL) {
+            return false;
+        }
+
+        if (*list == '-') {
+            if (qemu_strtoul(list + 1, &list, 0, &end) == -EINVAL) {
+                return false;
+            }
+
+            if (end < start) {
+                return false;
+            }
+        } else {
+            end = start;
+        }
+
+        end++;
+
+        if (end > *nr) {
+            unsigned long new_nr = ROUND_UP(end, BITS_PER_LONG);
+            *bitmap = g_realloc(*bitmap, new_nr / BITS_PER_BYTE);
+            bitmap_clear(*bitmap, *nr, new_nr - *nr);
+            *nr = new_nr;
+        }
+
+        bitmap_set(*bitmap, start, end - start);
+
+        if (*list == ',') {
+            list++;
+        }
+    }
+
+    return true;
+}
+
+static PMU choose_pmu(uint32_t *type, uint64_t explicit_type, bool backcompat)
+{
+    DIR *devices = NULL;
+    FILE *file;
+    PMU pmu = PMU_NONE;
+    size_t n = 64;
+    g_autofree char *buf = g_malloc(n);
+    g_autofree unsigned long *possible_cpus = NULL;
+    g_autofree unsigned long *pmu_cpus = NULL;
+    int devices_fd;
+    int fdarray[3];
+    struct dirent *ent;
+    unsigned long npossible_cpus = 0;
+    unsigned long npmu_cpus;
+    ssize_t ret;
+
+    struct kvm_vcpu_init init = {
+        .target = -1,
+        .features[0] = BIT(KVM_ARM_VCPU_PMU_V3),
+    };
+
+    if (explicit_type <= UINT32_MAX) {
+        *type = explicit_type;
+        return PMU_EVENT_SOURCE;
+    }
+
+    if (!kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
+        return PMU_NONE;
+    }
+
+    if (backcompat) {
+        return PMU_DEFAULT;
+    }
+
+    file = fopen("/sys/devices/system/cpu/possible", "r");
+    if (!file) {
+        return PMU_NONE;
+    }
+
+    ret = getline(&buf, &n, file);
+    assert(!fclose(file));
+    if (ret < 0) {
+        return PMU_NONE;
+    }
+
+    if (!parse_cpus(buf, &possible_cpus, &npossible_cpus)) {
+        return PMU_NONE;
+    }
+
+    npmu_cpus = npossible_cpus;
+    pmu_cpus = bitmap_new(npmu_cpus);
+
+    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
+        return PMU_NONE;
+    }
+
+    devices = opendir("/sys/bus/event_source/devices");
+    if (!devices) {
+        goto out;
+    }
+
+    devices_fd = dirfd(devices);
+    if (devices_fd < 0) {
+        goto out;
+    }
+
+    if (kvm_device_check_attr(fdarray[2], KVM_ARM_VCPU_PMU_V3_CTRL,
+                              KVM_ARM_VCPU_PMU_V3_SET_PMU)) {
+        g_autofree char *link = NULL;
+
+        while ((ent = readdir(devices))) {
+            unsigned long new_type = ULONG_MAX;
+            const char *endptr;
+
+            /* Check if this event source exposes type and cpus. */
+            if (!read_pmu_attr(devices_fd, ent, "type", &buf, &n) ||
+                qemu_strtoul(buf, &endptr, 0, &new_type) == -EINVAL ||
+                (*endptr && *endptr != '\n') ||
+                !read_pmu_attr(devices_fd, ent, "cpus", &buf, &n) ||
+                !parse_cpus(buf, &pmu_cpus, &npmu_cpus)) {
+                continue;
+            }
+
+            if (bitmap_andnot(pmu_cpus, possible_cpus, pmu_cpus,
+                              npossible_cpus)) {
+                continue;
+            }
+
+            /* Order by the device location to ensure stable selection. */
+            while (true) {
+                ret = readlinkat(devices_fd, ent->d_name, buf, n);
+                if (ret < n) {
+                    break;
+                }
+
+                n *= 2;
+                buf = g_realloc(buf, n);
+            }
+
+            if (ret < 0) {
+                continue;
+            }
+
+            buf[ret] = 0;
+
+            if (link && strcmp(link, buf) <= 0) {
+                continue;
+            }
+
+            *type = new_type;
+            link = g_realloc(link, ret + 1);
+            strcpy(link, buf);
+        }
+
+        /* Choose an event source covers all PCPUs if available. */
+        if (link) {
+            pmu = PMU_EVENT_SOURCE;
+            goto out;
+        }
+    } else {
+        while ((ent = readdir(devices))) {
+            if (!read_pmu_attr(devices_fd, ent, "cpus", &buf, &n) ||
+                !parse_cpus(buf, &pmu_cpus, &npossible_cpus)) {
+                continue;
+            }
+
+            /*
+             * If the kernel does not support KVM_ARM_VCPU_PMU_V3_SET_PMU and
+             * there is an event source that covers all PCPUs, it will be the
+             * default one because:
+             * - such a kernel only supports armv8-pmu as a
+             *   compatible event source
+             * - there is no other armv8-pmu as it occupies fixed system
+             *   registers.
+             */
+            if (!bitmap_andnot(pmu_cpus, possible_cpus, pmu_cpus,
+                                npossible_cpus)) {
+                pmu = PMU_DEFAULT;
+                goto out;
+            }
+        }
+    }
+
+    /* Choose the fixed-counters-only PMU if available. */
+    if (kvm_device_check_attr(fdarray[2], KVM_ARM_VCPU_PMU_V3_CTRL,
+                                KVM_ARM_VCPU_PMU_V3_FIXED_COUNTERS_ONLY)) {
+        pmu = PMU_FIXED_COUNTERS_ONLY;
+        goto out;
+    }
+
+out:
+    if (devices) {
+        assert(!closedir(devices));
+    }
+
+    kvm_arm_destroy_scratch_host_vcpu(fdarray);
+
+    return pmu;
+}
+
+static int set_pmu(int fd, PMU pmu, uint32_t pmu_event_source)
+{
+    int ret;
+
+    switch (pmu) {
+    case PMU_NONE:
+        ret = -ENOTSUP;
+        break;
+
+    case PMU_EVENT_SOURCE:
+        ret = kvm_device_access(fd, KVM_ARM_VCPU_PMU_V3_CTRL,
+                                KVM_ARM_VCPU_PMU_V3_SET_PMU, &pmu_event_source,
+                                true, NULL);
+        trace_kvm_arm_set_pmu(pmu_event_source, ret);
+        break;
+
+    case PMU_FIXED_COUNTERS_ONLY:
+        ret = kvm_device_access(fd, KVM_ARM_VCPU_PMU_V3_CTRL,
+                                KVM_ARM_VCPU_PMU_V3_FIXED_COUNTERS_ONLY,
+                                NULL, true, NULL);
+        trace_kvm_arm_set_pmu_fixed_counters_only(ret);
+        break;
+
+    default:
+        ret = 0;
+    }
+
+    return ret;
+}
+
 
 static uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg)
 {
@@ -283,7 +552,6 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     int fdarray[3];
     bool sve_supported;
     bool el2_supported;
-    bool pmu_supported = false;
     uint64_t features = 0;
     int err;
 
@@ -319,9 +587,8 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
 
-    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
+    if (pmu != PMU_NONE) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
-        pmu_supported = true;
         features |= 1ULL << ARM_FEATURE_PMU;
     }
 
@@ -331,6 +598,11 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     int fd = fdarray[2];
 
+    if (pmu != PMU_NONE && set_pmu(fd, pmu, pmu_effective_event_source)) {
+        kvm_arm_destroy_scratch_host_vcpu(fdarray);
+        return false;
+    }
+
     err = get_host_cpu_reg(fd, ahcf, ID_AA64PFR0_EL1_IDX);
     if (unlikely(err < 0)) {
         /*
@@ -428,7 +700,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
             ahcf->isar.dbgdidr = dbgdidr;
         }
 
-        if (pmu_supported) {
+        if (pmu != PMU_NONE) {
             /* PMCR_EL0 is only accessible if the vCPU has feature PMU_V3 */
             err |= read_sys_reg64(fd, &ahcf->isar.reset_pmcr_el0,
                                   ARM64_SYS_REG(3, 3, 9, 12, 0));
@@ -625,6 +897,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    pmu = choose_pmu(&pmu_effective_event_source,
+                     pmu_user_event_source, pmu_backcompat);
+
     if (s->kvm_eager_split_size) {
         uint32_t sizes;
 
@@ -1733,6 +2008,44 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
     return (data - 32) & 0xffff;
 }
 
+static bool kvm_arch_get_backcompat_pmu(Object *obj, Error **errp)
+{
+    return pmu_backcompat;
+}
+
+static void kvm_arch_set_backcompat_pmu(Object *obj, bool value, Error **errp)
+{
+    if (pmu != PMU_UNSET) {
+        error_setg(errp, "Unable to set backcompat-pmu after KVM has been initialized");
+        return;
+    }
+
+    pmu_backcompat = value;
+}
+
+static void kvm_arch_get_pmu(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    visit_type_uint64(v, name, &pmu_user_event_source, errp);
+}
+
+static void kvm_arch_set_pmu(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint64_t value;
+
+    if (pmu != PMU_UNSET) {
+        error_setg(errp, "Unable to set pmu after KVM has been initialized");
+        return;
+    }
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    pmu_user_event_source = value;
+}
+
 static void kvm_arch_get_eager_split_size(Object *obj, Visitor *v,
                                           const char *name, void *opaque,
                                           Error **errp)
@@ -1769,6 +2082,17 @@ static void kvm_arch_set_eager_split_size(Object *obj, Visitor *v,
 
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
+    ObjectProperty *property;
+
+    object_class_property_add_bool(oc, "backcompat-pmu",
+                                   kvm_arch_get_backcompat_pmu,
+                                   kvm_arch_set_backcompat_pmu);
+
+    property = object_class_property_add(oc, "pmu", "uint64", kvm_arch_get_pmu,
+                                         kvm_arch_set_pmu, NULL, NULL);
+    object_property_set_default_uint(property, UINT64_MAX);
+    object_class_property_set_description(oc, "pmu", "KVM PMU event type");
+
     object_class_property_add(oc, "eager-split-size", "size",
                               kvm_arch_get_eager_split_size,
                               kvm_arch_set_eager_split_size, NULL, NULL);
@@ -2000,6 +2324,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return ret;
     }
 
+    if (cpu->has_pmu) {
+        ret = set_pmu(cs->kvm_fd, pmu, pmu_effective_event_source);
+        if (ret) {
+            return ret;
+        }
+    }
+
     if (cpu_isar_feature(aa64_sve, cpu)) {
         ret = kvm_arm_sve_set_vls(cpu);
         if (ret) {
diff --git a/qemu-options.hx b/qemu-options.hx
index 21972f832682..f7a6c4149303 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -237,6 +237,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "                tb-size=n (TCG translation block cache size)\n"
     "                dirty-ring-size=n (KVM dirty ring GFN count, default 0)\n"
     "                eager-split-size=n (KVM Eager Page Split chunk size, default 0, disabled. ARM only)\n"
+    "                pmu=n (KVM PMU event type. ARM only)\n"
     "                notify-vmexit=run|internal-error|disable,notify-window=n (enable notify VM exit and set notify window, x86 only)\n"
     "                thread=single|multi (enable multi-threaded TCG)\n"
     "                device=path (KVM device path, default /dev/kvm)\n", QEMU_ARCH_ALL)
@@ -310,6 +311,25 @@ SRST
         have an impact on the memory. By default, this feature is disabled
         (eager-split-size=0).
 
+    ``pmu=n``
+        Specifies the event source to be used for Arm PMUv3 emulation. The value
+        specified here is identical to the one used in perf_event_open(2), but
+        not all event sources are compatible.
+
+        Since QEMU 11.0, the default behavior is to select a backend that
+        supports all host CPUs. The emulation cannot be enabled if there is no
+        such backend exists. Use this property to choose a specific event source
+        when there are several such event sources or to choose one that only
+        supports a subset of the host CPUs. If you specify an event source that
+        only supports a subset of host CPUs, you must ensure that guest CPUs run
+        exclusively on those supported host CPUs.
+
+        Prior to 11.0, KVM chose an arbitrary host PMU that supports at least
+        one CPU in the process's affinity.
+
+        Ensure that the CPU's ``pmu`` property is also set to ``on`` to enable
+        the emulation when setting this property.
+
     ``notify-vmexit=run|internal-error|disable,notify-window=n``
         Enables or disables notify VM exit support on x86 host and specify
         the corresponding notify window to trigger the VM exit if enabled.
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 2de0406f784d..44e9c8c126a6 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -13,6 +13,8 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 
 # kvm.c
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
+kvm_arm_set_pmu(uint32_t type, int ret) "type %" PRIu32 " ret %d"
+kvm_arm_set_pmu_fixed_counters_only(int ret) "ret %d"
 
 # cpu.c
 arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64

---
base-commit: 14f38a63b9adc02c0ebe3b5ada1f1208abaf21ea
change-id: 20250730-kvm-8fc06c8f722a
prerequisite-change-id: 20260422-arm-84b23dad0561:v1
prerequisite-patch-id: 32416c1227e9477cc97ea72e3d3e90d799eb9221

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

