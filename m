Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7108EBA3D
	for <kvm@vger.kernel.org>; Sun, 19 Jul 2026 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784443896; cv=none; b=pC4e6JRos2v96+q6PXhyyn0H+WLko8y8qc6Drlr2G2bQz8maczOM05l9/7vlff72VL+uzJ6dwvqKrU23Nyggt7Jlslsusjm1Ull8Nqka9htZxwarrSjFbo+G0iI/d0teMz38h2usuk2YGJYx/Fk0IrAYkhE7MqIparvP+huuuEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784443896; c=relaxed/simple;
	bh=4LtHX6TzliuSvKy7IsFirndpbHqkfe3EJczHKm24s34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kc3nnFaAI+z4eXTp/3chGDaxjBafCznGQaSEJ1INjHRY53Lr2++AtQ4CuVNy9NlVKyBXivrD7qdHG4qz7XkDdvkKFeoG1VZ0CRF0/42ePeqMUmrLRSvp1Z6gVw9Wg8up1YJYDLgZO6uRCgd6WQFMfL/QTMvRhszfSEmywUeAYFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=eACuYrzC reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="eACuYrzC"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66J6p4VO092290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 19 Jul 2026 15:51:23 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=phn2UzuGeCgjag8ugrXkeZstBKh0j4SJB0PgHQukIhI=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1784443883; v=1;
        b=eACuYrzCdmgiPfUYJpkL/QWjPl8mhCKS7RKJ7/bsDFbr7HDbXXMBQbNT0w2A1bMX
         6SFDmpJoUOzehl3p4ybtfIdELr+ztR3JWFo+AnwLlYHk3hL/YLxbbuupLwyAf+zU
         PPu4cQtdRFarwYjUgUj8SqW/gpfo6upGW0SVp44tsXqC/TUmlLMxUgSuJ1N0vO4B
         nBztOX5zJJj3NFsZ0hHX9oIj3WsIzGwHjNZN8dQsu36Pw68pSDZNGg0kY0rhU+ZU
         xdvfeJZ/zui0Sakx6bd5+bNj4BUrt+YFpFw9JVTZ5CiZBl1kVW+oltyxQGJSKmHD
         f6wNat0fo/n9ngFKpHE5eQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 19 Jul 2026 15:51:02 +0900
Subject: [PATCH RFC v5] target/arm/kvm: Choose PMU backend
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-kvm-v5-1-afd1fcdf7b9e@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33QS2rDMBAG4KsYrSszellyVoVCD9Bt6UIeSYkSH
 KeSYxpC7l4hN2TVLOfBx8x/Jdmn6DPZNFeS/BJznI6lUC8NwZ09bj2NrtSEA1egBdDDMlITEDo
 0QXNuSdk8JR/iT1U+ycf7G/kqzV3M85QuVV5YHVXEQFeRhVFGHXMKBg3KoHtNedtibGN7pvN0u
 EytxXZ/qtjC70AHnKsV4AUYjNNSuAGCFk8B8QAkFysgCuAF8mB0r6XFp4B8APr+giwAmB4tGuQ
 K/7/gtqaU/Pe5RDz/RTXY7ClO4xjnTSP7HkSv+5KEddqZbtBGB4/gbWDOSqYYQgBVsNsvYoaxr
 LcBAAA=
X-Change-ID: 20250730-kvm-8fc06c8f722a
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
        qemu-arm@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=23391;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=4LtHX6TzliuSvKy7IsFirndpbHqkfe3EJczHKm24s34=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1ZM8QvLI3pKM7n19O+rq8U8rDzV3nyIeaf77vC5n0z/9
 f8/H7qmo5SFQYyLQVZMkSWlaDe3RnTtp8KE+BaYOaxMIEMYuDgFYCKdHxn+aZjL8nwt6Tr17whH
 /T27FZODTSzMlsms1/i6Z41lztLigwz/Q251/Lev7vFLPWjNJhfk/oZ3Ooftedb7CkZLTpRI3b7
 EBgA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

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
   responsibility to ensure that the VCPUs run on PCPUs associated with
   the event source.

2. The default backend if the machine version is old. This ensures
   backward compatibility but the resulting PMU may or may not work.

3. An event source that covers all PCPUs. This exposes its full feature
   set to the guest. If multiple such physical PMUs exist, selection is
   deterministic, based on the device hierarchy.

4. The fixed-counters-only PMU, which is emulated with all compatible
   event sources, if available.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
This is an RFC patch to demonstrate the usage of a new device attribute
which will be added with the next version of the following series:
https://lore.kernel.org/r/20260710-hybrid-v8-0-621409f3a592@rsg.ci.i.u-tokyo.ac.jp
("[PATCH v8 00/11] KVM: arm64: PMU: Use multiple host PMUs")
---
Changes in v5:
- Kept PMU backend state per KVM accelerator instance so failed
  initialization does not affect accelerator fallback.
- Reported errors when configuring the selected PMU backend.
- Reset PMU registers after selecting the backend.
- Preserved legacy PMU selection for QEMU 11.0 machine types and documented
  automatic PMU backend selection for QEMU 11.1.
- Kept the fixed-counters-only fallback available when sysfs PMU discovery
  fails.
- Handled readlinkat() failures during PMU discovery.
- Link to v4: https://lore.kernel.org/qemu-devel/20260706-kvm-v4-1-089cac8c25c3@rsg.ci.i.u-tokyo.ac.jp

Changes in v4:
- Fixed PMU CPU list parsing to keep PMU and possible CPU bitmap
  sizes separate.
- Avoided clearing CPU bitmaps before allocating them.
- Link to v3: https://lore.kernel.org/qemu-devel/20260423-kvm-v3-1-e3c2f87974ac@rsg.ci.i.u-tokyo.ac.jp

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
---
 include/system/kvm_int.h |  13 ++
 hw/core/machine.c        |   2 +
 target/arm/kvm.c         | 349 ++++++++++++++++++++++++++++++++++++++++++++++-
 qemu-options.hx          |  24 ++++
 target/arm/trace-events  |   2 +
 5 files changed, 386 insertions(+), 4 deletions(-)

diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 0876aac938d3..f35b1699083a 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -101,6 +101,15 @@ struct KVMDirtyRingReaper {
     volatile uint64_t reaper_iteration; /* iteration number of reaper thr */
     volatile enum KVMDirtyRingReaperState reaper_state; /* reap thr state */
 };
+
+typedef enum KVMPMU {
+    KVM_PMU_UNSET,
+    KVM_PMU_NONE,
+    KVM_PMU_DEFAULT,
+    KVM_PMU_EVENT_SOURCE,
+    KVM_PMU_FIXED_COUNTERS_ONLY
+} KVMPMU;
+
 struct KVMState
 {
     AccelState parent_obj;
@@ -157,6 +166,10 @@ struct KVMState
     uint64_t kvm_dirty_ring_bytes;  /* Size of the per-vcpu dirty ring */
     uint32_t kvm_dirty_ring_size;   /* Number of dirty GFNs per ring */
     bool kvm_dirty_ring_with_bitmap;
+    bool pmu_backcompat;
+    KVMPMU pmu;
+    uint32_t pmu_effective_event_source;
+    uint64_t pmu_user_event_source;
     uint64_t kvm_eager_split_size;  /* Eager Page Splitting chunk size */
     struct KVMDirtyRingReaper reaper;
     struct KVMMsrEnergy msr_energy;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 805148678d57..55dea12f0f7f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -24,6 +24,7 @@
 #include "qom/compat-properties.h"
 #include "qom/object_interfaces.h"
 #include "system/cpus.h"
+#include "system/kvm.h"
 #include "system/system.h"
 #include "system/reset.h"
 #include "system/runstate.h"
@@ -50,6 +51,7 @@ GlobalProperty hw_compat_11_0[] = {
     { TYPE_ARM_SMMUV3, "ssidsize", "0" },
     { TYPE_ARM_SMMUV3, "oas", "44" },
     { "migration", "switchover-ack-legacy", "on" },
+    { TYPE_KVM_ACCEL, "backcompat-pmu", "true", .optional = true },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d40a6a985914..2f7c63b315df 100644
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
@@ -221,6 +224,262 @@ static bool kvm_arm_pauth_supported(void)
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
+    if (*nr) {
+        bitmap_clear(*bitmap, 0, *nr);
+    }
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
+static KVMPMU choose_pmu(uint32_t *type, uint64_t explicit_type,
+                         bool backcompat)
+{
+    DIR *devices = NULL;
+    FILE *file;
+    KVMPMU pmu = KVM_PMU_NONE;
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
+        return KVM_PMU_EVENT_SOURCE;
+    }
+
+    if (!kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
+        return KVM_PMU_NONE;
+    }
+
+    if (backcompat) {
+        return KVM_PMU_DEFAULT;
+    }
+
+    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
+        return KVM_PMU_NONE;
+    }
+
+    file = fopen("/sys/devices/system/cpu/possible", "r");
+    if (!file) {
+        goto out;
+    }
+
+    ret = getline(&buf, &n, file);
+    assert(!fclose(file));
+    if (ret < 0) {
+        goto out;
+    }
+
+    if (!parse_cpus(buf, &possible_cpus, &npossible_cpus)) {
+        goto out;
+    }
+
+    npmu_cpus = npossible_cpus;
+    pmu_cpus = bitmap_new(npmu_cpus);
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
+                if (ret < (ssize_t)n) {
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
+            pmu = KVM_PMU_EVENT_SOURCE;
+        }
+    } else {
+        while ((ent = readdir(devices))) {
+            if (!read_pmu_attr(devices_fd, ent, "cpus", &buf, &n) ||
+                !parse_cpus(buf, &pmu_cpus, &npmu_cpus)) {
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
+                               npossible_cpus)) {
+                pmu = KVM_PMU_DEFAULT;
+                break;
+            }
+        }
+    }
+
+out:
+    /* Choose the fixed-counters-only PMU if available. */
+    if (pmu == KVM_PMU_NONE &&
+        kvm_device_check_attr(fdarray[2], KVM_ARM_VCPU_PMU_V3_CTRL,
+                              KVM_ARM_VCPU_PMU_V3_FIXED_COUNTERS_ONLY)) {
+        pmu = KVM_PMU_FIXED_COUNTERS_ONLY;
+    }
+
+    if (devices) {
+        assert(!closedir(devices));
+    }
+
+    kvm_arm_destroy_scratch_host_vcpu(fdarray);
+
+    return pmu;
+}
+
+static int set_pmu(int fd, KVMPMU pmu, uint32_t pmu_event_source, Error **errp)
+{
+    int ret;
+
+    switch (pmu) {
+    case KVM_PMU_NONE:
+        error_setg(errp, "PMU unsupported");
+        ret = -ENOTSUP;
+        break;
+
+    case KVM_PMU_EVENT_SOURCE:
+        ret = kvm_device_access(fd, KVM_ARM_VCPU_PMU_V3_CTRL,
+                                KVM_ARM_VCPU_PMU_V3_SET_PMU, &pmu_event_source,
+                                true, errp);
+        trace_kvm_arm_set_pmu(pmu_event_source, ret);
+        break;
+
+    case KVM_PMU_FIXED_COUNTERS_ONLY:
+        ret = kvm_device_access(fd, KVM_ARM_VCPU_PMU_V3_CTRL,
+                                KVM_ARM_VCPU_PMU_V3_FIXED_COUNTERS_ONLY,
+                                NULL, true, errp);
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
@@ -283,9 +542,9 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     int fdarray[3];
     bool sve_supported;
     bool el2_supported;
-    bool pmu_supported = false;
     uint64_t features = 0;
     int err;
+    Error *local_err = NULL;
 
     ahcf->target = QEMU_KVM_ARM_TARGET_NONE;
     ahcf->dtb_compatible = "arm,armv8";
@@ -326,9 +585,8 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
 
-    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
+    if (kvm_state->pmu != KVM_PMU_NONE) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
-        pmu_supported = true;
         features |= 1ULL << ARM_FEATURE_PMU;
     }
 
@@ -338,6 +596,14 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     int fd = fdarray[2];
 
+    if (kvm_state->pmu != KVM_PMU_NONE &&
+        set_pmu(fd, kvm_state->pmu, kvm_state->pmu_effective_event_source,
+                &local_err)) {
+        error_report_err(local_err);
+        kvm_arm_destroy_scratch_host_vcpu(fdarray);
+        return;
+    }
+
     err = get_host_cpu_reg(fd, ahcf, ID_AA64PFR0_EL1_IDX);
     if (unlikely(err < 0)) {
         /*
@@ -435,7 +701,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
             ahcf->isar.dbgdidr = dbgdidr;
         }
 
-        if (pmu_supported) {
+        if (kvm_state->pmu != KVM_PMU_NONE) {
             /* PMCR_EL0 is only accessible if the vCPU has feature PMU_V3 */
             err |= read_sys_reg64(fd, &ahcf->isar.reset_pmcr_el0,
                                   ARM64_SYS_REG(3, 3, 9, 12, 0));
@@ -631,6 +897,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    s->pmu = choose_pmu(&s->pmu_effective_event_source,
+                        s->pmu_user_event_source, s->pmu_backcompat);
+
     if (s->kvm_eager_split_size) {
         uint32_t sizes;
 
@@ -1740,6 +2009,51 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
     return (data - 32) & 0xffff;
 }
 
+static bool kvm_arch_get_backcompat_pmu(Object *obj, Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+
+    return s->pmu_backcompat;
+}
+
+static void kvm_arch_set_backcompat_pmu(Object *obj, bool value, Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+
+    if (s->pmu != KVM_PMU_UNSET) {
+        error_setg(errp, "Unable to set backcompat-pmu after KVM has been initialized");
+        return;
+    }
+
+    s->pmu_backcompat = value;
+}
+
+static void kvm_arch_get_pmu(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+
+    visit_type_uint64(v, name, &s->pmu_user_event_source, errp);
+}
+
+static void kvm_arch_set_pmu(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    uint64_t value;
+
+    if (s->pmu != KVM_PMU_UNSET) {
+        error_setg(errp, "Unable to set pmu after KVM has been initialized");
+        return;
+    }
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    s->pmu_user_event_source = value;
+}
+
 static void kvm_arch_get_eager_split_size(Object *obj, Visitor *v,
                                           const char *name, void *opaque,
                                           Error **errp)
@@ -1776,6 +2090,17 @@ static void kvm_arch_set_eager_split_size(Object *obj, Visitor *v,
 
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
@@ -1965,6 +2290,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     uint64_t psciver;
+    Error *local_err = NULL;
 
     if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
         error_report("KVM is not supported for this guest CPU type");
@@ -2009,6 +2335,21 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return ret;
     }
 
+    if (cpu->has_pmu) {
+        ret = set_pmu(cs->kvm_fd, cs->kvm_state->pmu,
+                      cs->kvm_state->pmu_effective_event_source, &local_err);
+        if (ret) {
+            error_report_err(local_err);
+            return ret;
+        }
+
+        /* Reset PMU registers */
+        ret = kvm_arm_vcpu_init(cpu);
+        if (ret) {
+            return ret;
+        }
+    }
+
     if (cpu_isar_feature(aa64_sve, cpu)) {
         ret = kvm_arm_sve_set_vls(cpu);
         if (ret) {
diff --git a/qemu-options.hx b/qemu-options.hx
index 34970fffc94b..adb2bbd447c9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -242,6 +242,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "                tb-size=n (TCG translation block cache size)\n"
     "                dirty-ring-size=n (KVM dirty ring GFN count, default 0)\n"
     "                eager-split-size=n (KVM Eager Page Split chunk size, default 0, disabled. ARM only)\n"
+    "                pmu=n (KVM PMU event type. ARM only)\n"
     "                notify-vmexit=run|internal-error|disable,notify-window=n (enable notify VM exit and set notify window, x86 only)\n"
     "                thread=single|multi (enable multi-threaded TCG)\n"
     "                device=path (KVM device path, default /dev/kvm)\n", QEMU_ARCH_ALL)
@@ -315,6 +316,29 @@ SRST
         have an impact on the memory. By default, this feature is disabled
         (eager-split-size=0).
 
+    ``pmu=n``
+        Specifies the event source to be used for Arm PMUv3 emulation. The value
+        specified here is identical to the one used in perf_event_open(2), but
+        not all event sources are compatible.
+
+        Since QEMU 11.1, the default behavior is to select a backend that
+        supports all host CPUs. First, QEMU looks for an event source that
+        covers all host CPUs. If none is found and KVM supports
+        fixed-counters-only emulation, QEMU requests that mode. It has no
+        programmable event counters, and KVM may use different event sources
+        as the vCPU migrates. If neither automatic backend is available, PMU
+        emulation is disabled by default.
+
+        Use this property to choose a specific event source. If you specify an
+        event source that only supports a subset of host CPUs, you must ensure
+        that guest CPUs run exclusively on those supported host CPUs.
+
+        Prior to 11.1, KVM chose an arbitrary host PMU that supports at least
+        one CPU in the process's affinity.
+
+        Ensure that the CPU's ``pmu`` property is also set to ``on`` to enable
+        the emulation when setting this property.
+
     ``notify-vmexit=run|internal-error|disable,notify-window=n``
         Enables or disables notify VM exit support on x86 host and specify
         the corresponding notify window to trigger the VM exit if enabled.
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 8502fb3265ca..9a6072f50192 100644
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
base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
change-id: 20250730-kvm-8fc06c8f722a

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

