Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98B237F735
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423481; cv=none; b=mVBdPB0Lgo15OkB31RbAdfeMtGYh7C8P1x+FiJVFB28fQlMjT3GW2xk0NhBdpV5UFoZPHPz/F5dP9ARp/14ZviXLVfidTTPnbUqX3NcO5Wn1cXSZeRDMNaVnZmygS48jcXR7DSuybHvQtfED36lf16Sk9eevEQvt1vasQ6j6I+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423481; c=relaxed/simple;
	bh=YIYJz4uQV8Uzvv7mqWNjei+7jct6XwQmJ3XYupgIEy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nHyrdIGeOCYEpizDPF+jMcAEwBXZfGJ1WF9z6jhYAQsRUfpMLgh1WzIRMuaAhMXtb0d2HVkl4UcD+WbYzrfmYLbRneXbI67OgWLVxvQomA3B1qU0i4kKMVFdHLtCUm4g9gCfYk7jal1GswYGqtT4ljjNuLdfeXi4ZAdR3/UX+Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ICTUaaaS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ICTUaaaS"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8F9D120B7001;
	Fri, 17 Apr 2026 03:57:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8F9D120B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423480;
	bh=Xw/caTrzhER4UZh+Hl5RTibaD3S7XoFJ/++MpcgizJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICTUaaaSyGCPk0ZEfXl99cReLGE4GDPBP1BeA9SKYA/f3ocStA5vqjEvLVVi+ZwqF
	 Pss/ONFs/3Ge+KrNdBZu1fJj3QmRWpdJFeXqC2vesGGcaaHDpa3aljSY35PK/cLqKs
	 5GiNol8HCRn65C0xx2qoC1iIEMQhAepx/rhI+ly8=
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
Subject: [PATCH 26/34] accel/mshv: introduce SaveVMHandler
Date: Fri, 17 Apr 2026 12:56:10 +0200
Message-Id: <20260417105618.3621-27-magnuskulke@linux.microsoft.com>
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

This mechanism is used to handle more imperative partition-wide steps
that have to be taken as part of a migration routine.

Currently it's a skeleton that will just pause/resume the partition as
part of a migration. It will later be extended with more specific steps
like reference time and hypercall pages.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c | 75 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 4c1a42d002..5f81881c05 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -39,6 +39,8 @@
 #include "system/mshv.h"
 #include "system/mshv_int.h"
 #include "system/reset.h"
+#include "migration/qemu-file-types.h"
+#include "migration/register.h"
 #include "trace.h"
 #include <err.h>
 #include <sys/ioctl.h>
@@ -47,6 +49,9 @@ bool mshv_allowed;
 
 MshvState *mshv_state;
 
+static int pause_vm(int vm_fd);
+static int resume_vm(int vm_fd);
+
 static int init_mshv(int *mshv_fd)
 {
     int fd = open("/dev/mshv", O_RDWR | O_CLOEXEC);
@@ -80,6 +85,64 @@ static int set_time_freeze(int vm_fd, int freeze)
     return 0;
 }
 
+static void mshv_save_state(QEMUFile *f, void *opaque)
+{
+    return;
+}
+
+static int mshv_load_state(QEMUFile *f, void *opaque, int version_id)
+{
+    return 0;
+}
+
+static int mshv_save_prepare(void *opaque, Error **errp)
+{
+    MshvState *s = opaque;
+    int ret;
+
+    ret = pause_vm(s->vm);
+    if (ret < 0) {
+        error_setg(errp, "Failed to pause VM for migration");
+        return -1;
+    }
+
+    return 0;
+}
+
+static void mshv_save_cleanup(void *opaque)
+{
+    MshvState *s = opaque;
+    int ret;
+
+    ret = resume_vm(s->vm);
+    if (ret < 0) {
+        error_report("Failed to resme VM after  migration");
+    }
+}
+
+static int mshv_load_setup(QEMUFile *f, void *opaque, Error **errp)
+{
+    MshvState *s = opaque;
+    int ret;
+
+    ret = pause_vm(s->vm);
+    if (ret < 0) {
+        error_setg(errp, "Failed to pause VM for migration restore");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int mshv_load_cleanup(void *opaque)
+{
+    MshvState *s = opaque;
+
+    resume_vm(s->vm);
+
+    return 0;
+}
+
 static int pause_vm(int vm_fd)
 {
     int ret;
@@ -454,6 +517,15 @@ static int mshv_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+static SaveVMHandlers savevm_mshv = {
+    .save_prepare = mshv_save_prepare,
+    .save_state = mshv_save_state,
+    .save_cleanup = mshv_save_cleanup,
+    .load_setup = mshv_load_setup,
+    .load_state = mshv_load_state,
+    .load_cleanup = mshv_load_cleanup,
+};
+
 static int mshv_init(AccelState *as, MachineState *ms)
 {
     MshvState *s;
@@ -509,6 +581,9 @@ static int mshv_init(AccelState *as, MachineState *ms)
                                   0, "mshv-memory");
     memory_listener_register(&mshv_io_listener, &address_space_io);
 
+    /* register custom handlers for migration events */
+    register_savevm_live("mshv", 0, 1, &savevm_mshv, s);
+
     return 0;
 }
 
-- 
2.34.1

