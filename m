Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACF137F735
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423478; cv=none; b=q7Bl/QA9nrqyFf6rtfiR6NCXWdGU8Pc1yqvOCkcs+UAABYRFGCfCOD079cTqL6u9Al7j6xPEFFD4TUOgpZhD2Rb+3SfIbVGQpQHXTjmyYqVFZIbOxmhU1XgrJErEVTqKmSjkVtg1XVfCsVQtKIsBhs6ljr9bDXmcBcHhgWUhgHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423478; c=relaxed/simple;
	bh=2iWrCiNloJlP9JKP9HcoWk0lRB3vO/mxVq71DXjRpYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F75JiUueNqN2N9YCUsJ8zRaPuyl3KkCIY9TKDLYY6JPDUhGyUInCwaN5DUn714ybnV9xs1RBBIN8F3B3PzbVXAFrJ4w+nUnOaSUlVADj+2EMeulXI2MpFSspGC/cWNtrlYzmPYqV/QtS1ZX0kF8gFzQygjn8aYy043FApohdX7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j+0dmkx8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j+0dmkx8"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id E1F5320B7007;
	Fri, 17 Apr 2026 03:57:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E1F5320B7007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423476;
	bh=qy8N8vizhm7Q2Sughpi+d6J12wYekFd3ArpRfw0k1jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j+0dmkx8id/czeralWXffCE32Wjlpru0MMsY0APqJEuc3eEUX+7OcnjVvrfbN/jph
	 vug7c4JXO0cUX8wazQOlLGo2TGzHxiM0fBIsyEJWWPsCqtZKX2VKzHbeGjDt2Q9Kr3
	 JpMMQOu9NO3u03Do4Ga5k4yQsXarBaBLihVzW7vs=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 25/34] target/i386/mshv: migrate STIMER state
Date: Fri, 17 Apr 2026 12:56:09 +0200
Message-Id: <20260417105618.3621-26-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This part of Synic state is retrieved via a mem-aligned page. We declare
the required space (size reference: rust-vmm/mshv) as a buffer on the VM
state struct for inclusion in a migration.

Other than other SynIC features, STIMER doesn't depend on SCONTROL being
set.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/system/mshv_int.h   |  2 ++
 target/i386/cpu.h           |  5 ++++
 target/i386/machine.c       | 20 +++++++++++++++
 target/i386/mshv/mshv-cpu.c | 12 +++++++++
 target/i386/mshv/synic.c    | 51 +++++++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 80df4030c5..7d685fc647 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -125,5 +125,7 @@ int mshv_set_simp(int cpu_fd, const uint8_t *page);
 int mshv_get_siefp(int cpu_fd, uint8_t *page);
 int mshv_set_siefp(int cpu_fd, const uint8_t *page);
 bool mshv_synic_enabled(const CPUState *cpu);
+int mshv_get_synthetic_timers(int cpu_fd, uint8_t *state);
+int mshv_set_synthetic_timers(int cpu_fd, const uint8_t *state);
 
 #endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d010d26146..4ad4a35ce9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -45,6 +45,10 @@
 #define ELF_MACHINE_UNAME "i686"
 #endif
 
+#ifdef CONFIG_MSHV
+#define MSHV_STIMERS_STATE_SIZE 200
+#endif
+
 enum {
     R_EAX = 0,
     R_ECX = 1,
@@ -2295,6 +2299,7 @@ typedef struct CPUArchState {
 #if defined(CONFIG_MSHV)
     uint8_t hv_simp_page[HV_HYP_PAGE_SIZE];
     uint8_t hv_siefp_page[HV_HYP_PAGE_SIZE];
+    uint8_t hv_synthetic_timers_state[MSHV_STIMERS_STATE_SIZE];
 #endif
 
     uint64_t mcg_cap;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index f94cc544b3..38ccbbe19d 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -10,6 +10,7 @@
 #include "exec/watchpoint.h"
 #include "system/kvm.h"
 #include "system/kvm_xen.h"
+#include "system/mshv.h"
 #include "system/tcg.h"
 
 #include "qemu/error-report.h"
@@ -953,6 +954,24 @@ static const VMStateDescription vmstate_msr_hyperv_reenlightenment = {
 };
 
 #ifdef CONFIG_MSHV
+
+static bool mshv_synthetic_timers_needed(void *opaque)
+{
+    /* Always migrate synthetic timers */
+    return mshv_enabled();
+}
+
+static const VMStateDescription vmstate_mshv_synthetic_timers = {
+    .name = "cpu/mshv_synthetic_timers",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mshv_synthetic_timers_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BUFFER(env.hv_synthetic_timers_state, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool mshv_synic_vp_state_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -1942,6 +1961,7 @@ const VMStateDescription vmstate_x86_cpu = {
 #endif
 #ifdef CONFIG_MSHV
         &vmstate_mshv_synic_vp_state,
+        &vmstate_mshv_synthetic_timers,
 #endif
         NULL
     }
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 36549857ae..9ce66e9aa1 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -135,6 +135,12 @@ static int get_synic_state(CPUState *cpu)
     int cpu_fd = mshv_vcpufd(cpu);
     int ret;
 
+    ret = mshv_get_synthetic_timers(cpu_fd, env->hv_synthetic_timers_state);
+    if (ret < 0) {
+        error_report("failed to get synthetic timers");
+        return -1;
+    }
+
     /* SIMP/SIEFP can only be read when SynIC is enabled */
     if (!mshv_synic_enabled(cpu)) {
         return 0;
@@ -1039,6 +1045,12 @@ static int set_synic_state(const CPUState *cpu)
     int cpu_fd = mshv_vcpufd(cpu);
     int ret;
 
+    ret = mshv_set_synthetic_timers(cpu_fd, env->hv_synthetic_timers_state);
+    if (ret < 0) {
+        error_report("failed to set synthetic timers state");
+        return -1;
+    }
+
     /* SIMP/SIEFP can only be written when SynIC is enabled */
     if (!mshv_synic_enabled(cpu)) {
         return 0;
diff --git a/target/i386/mshv/synic.c b/target/i386/mshv/synic.c
index 8f9fee6ed7..4c629adc3a 100644
--- a/target/i386/mshv/synic.c
+++ b/target/i386/mshv/synic.c
@@ -54,6 +54,57 @@ static int set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state)
     return 0;
 }
 
+int mshv_get_synthetic_timers(int cpu_fd, uint8_t *state)
+{
+    int ret;
+    void *buffer;
+    struct mshv_get_set_vp_state args = {0};
+
+    buffer = qemu_memalign(HV_HYP_PAGE_SIZE, HV_HYP_PAGE_SIZE);
+    args.buf_ptr = (uint64_t)buffer;
+    args.buf_sz = HV_HYP_PAGE_SIZE;
+    args.type = MSHV_VP_STATE_SYNTHETIC_TIMERS;
+
+    ret = get_vp_state(cpu_fd, &args);
+
+    if (ret < 0) {
+        qemu_vfree(buffer);
+        error_report("failed to get synthetic timers");
+        return -1;
+    }
+
+    memcpy(state, buffer, MSHV_STIMERS_STATE_SIZE);
+    qemu_vfree(buffer);
+
+    return 0;
+}
+
+int mshv_set_synthetic_timers(int cpu_fd, const uint8_t *state)
+{
+    int ret;
+    void *buffer;
+    struct mshv_get_set_vp_state args = {0};
+
+    buffer = qemu_memalign(HV_HYP_PAGE_SIZE, HV_HYP_PAGE_SIZE);
+    memset(buffer, 0, HV_HYP_PAGE_SIZE);
+    args.buf_ptr = (uint64_t)buffer;
+    args.buf_sz = HV_HYP_PAGE_SIZE;
+    args.type = MSHV_VP_STATE_SYNTHETIC_TIMERS;
+
+    assert(state);
+    memcpy(buffer, state, MSHV_STIMERS_STATE_SIZE);
+
+    ret = set_vp_state(cpu_fd, &args);
+    qemu_vfree(buffer);
+
+    if (ret < 0) {
+        error_report("failed to set synthetic timers");
+        return -1;
+    }
+
+    return 0;
+}
+
 int mshv_get_simp(int cpu_fd, uint8_t *page)
 {
     int ret;
-- 
2.34.1

