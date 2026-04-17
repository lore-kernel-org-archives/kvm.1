Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914AD37F735
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423440; cv=none; b=kHGfF7UHD4WVoXFXO20GFz3V+P6ovJxQCHPZ34h71fN2JQUP/1L4b4uPgQAHLOJGSpBMhl0Tt5HX+fWXacyvB8LeeQqf0ZK5dOja6KZKDOQUckBg6jqXxpsnok5mMKxXB5NfN5elYvD8FWNLMcD13ZUQd8f0L/5jxA5TZDybQL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423440; c=relaxed/simple;
	bh=lv8nDl+YoTo4b+h4Eq4WQKQHCME/QMSrVUu0C1hvt78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T326dfkhrrb47bjxGBaLAPakGUPwITsyvs1LaV05mni19JQJHEOsZq2TdLpa96RohhQn6UCF0AqJ6s63diV50U5Zb57peu4OEQgwH+evyTWP3lqr7Yah1Wq02EtXiNztQBJ47TTMGEn4kRbu8U1L2hUQnpjU5/aqTHo7HFJWiDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZxqR/aTj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZxqR/aTj"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9A93520B7128;
	Fri, 17 Apr 2026 03:57:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A93520B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423439;
	bh=4/dGjUSqCuffa4776aRoVC+jjvuxIlehRsFhT8amsVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZxqR/aTjwlgbpwdxaY5Nt0HyvpuzI3Z8Xqr9QpvFZ83qguRiiPmDWyjUfZTKdeM7+
	 QyQS7f1lC/42te9qLjh9hEn5BhHh8lbsdoGPvdipzQPPiqXCaBmBNgNoLnwA3DAxSj
	 ZhRt92S+VD8II9aB3vAFVkKYicWuZjxPNZq34aDI=
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
Subject: [PATCH 15/34] target/i386/mshv: remove redundant apic helpers
Date: Fri, 17 Apr 2026 12:55:59 +0200
Message-Id: <20260417105618.3621-16-magnuskulke@linux.microsoft.com>
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

This change remove the now redundant apic helpers in mshv-cpu.c

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 88 ++-----------------------------------
 1 file changed, 3 insertions(+), 85 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 56656ac0b0..12343acb01 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -919,101 +919,19 @@ static int set_xc_reg(const CPUState *cpu)
     return 0;
 }
 
-static int get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state)
-{
-    int ret;
-
-    ret = ioctl(cpu_fd, MSHV_GET_VP_STATE, state);
-    if (ret < 0) {
-        error_report("failed to get partition state: %s", strerror(errno));
-        return -1;
-    }
-
-    return 0;
-}
-
-static int get_lapic(const CPUState *cpu,
-                     struct hv_local_interrupt_controller_state *state)
-{
-    int ret;
-    size_t size = 4096;
-    /* buffer aligned to 4k, as *state requires that */
-    void *buffer = qemu_memalign(size, size);
-    struct mshv_get_set_vp_state mshv_state = { 0 };
-    int cpu_fd = mshv_vcpufd(cpu);
-
-    mshv_state.buf_ptr = (uint64_t) buffer;
-    mshv_state.buf_sz = size;
-    mshv_state.type = MSHV_VP_STATE_LAPIC;
-
-    ret = get_vp_state(cpu_fd, &mshv_state);
-    if (ret == 0) {
-        memcpy(state, buffer, sizeof(*state));
-    }
-    qemu_vfree(buffer);
-    if (ret < 0) {
-        error_report("failed to get lapic");
-        return -1;
-    }
-
-    return 0;
-}
-
 static uint32_t set_apic_delivery_mode(uint32_t reg, uint32_t mode)
 {
     return ((reg) & ~0x700) | ((mode) << 8);
 }
 
-static int set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state)
-{
-    int ret;
-
-    ret = ioctl(cpu_fd, MSHV_SET_VP_STATE, state);
-    if (ret < 0) {
-        error_report("failed to set partition state: %s", strerror(errno));
-        return -1;
-    }
-
-    return 0;
-}
-
-static int set_lapic(const CPUState *cpu,
-                     const struct hv_local_interrupt_controller_state *state)
-{
-    int ret;
-    size_t size = 4096;
-    /* buffer aligned to 4k, as *state requires that */
-    void *buffer = qemu_memalign(size, size);
-    struct mshv_get_set_vp_state mshv_state = { 0 };
-    int cpu_fd = mshv_vcpufd(cpu);
-
-    if (!state) {
-        error_report("lapic state is NULL");
-        return -1;
-    }
-    memcpy(buffer, state, sizeof(*state));
-
-    mshv_state.buf_ptr = (uint64_t) buffer;
-    mshv_state.buf_sz = size;
-    mshv_state.type = MSHV_VP_STATE_LAPIC;
-
-    ret = set_vp_state(cpu_fd, &mshv_state);
-    qemu_vfree(buffer);
-    if (ret < 0) {
-        error_report("failed to set lapic: %s", strerror(errno));
-        return -1;
-    }
-
-    return 0;
-}
-
 static int init_lint(const CPUState *cpu)
 {
     int ret;
     uint32_t *lvt_lint0, *lvt_lint1;
+    int cpu_fd = mshv_vcpufd(cpu);
 
     struct hv_local_interrupt_controller_state lapic_state = { 0 };
-    ret = get_lapic(cpu, &lapic_state);
+    ret = mshv_get_lapic(cpu_fd, &lapic_state);
     if (ret < 0) {
         return ret;
     }
@@ -1026,7 +944,7 @@ static int init_lint(const CPUState *cpu)
 
     /* TODO: should we skip setting lapic if the values are the same? */
 
-    return set_lapic(cpu, &lapic_state);
+    return mshv_set_lapic(cpu_fd, &lapic_state);
 }
 
 int mshv_arch_store_vcpu_state(const CPUState *cpu)
-- 
2.34.1

