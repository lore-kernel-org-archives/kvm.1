Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7D43AE70E
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274389; cv=none; b=XslY0/jE2we/269M+L9A5cI4cnS1xU7CADOZpfxpTRWRRVP8USmV+/ApPzPGApjr/mr+ZZtkMCP+/kJ0fyEZogW6HZIAmmzeSZYEZc8IhLAFIWMgP6qVgZBr1IPSMvmryYxsv4EPn8uz6WCaShv9NMI3N/JOoGclWZkqN8EPNEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274389; c=relaxed/simple;
	bh=K+oaLrsW51i9112q3bzzdvW9E40CnbVsgFO4CHM9NXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWUjMyyQqZfd3qx4pulNSjzz0MG4zt96gOIJKfq/u51g0qo2JGHYerq04aF8hwbIvvhVXkaRkctX+JUvoPFdh3yD2wCTtAk+nMOM0GV5AKEh8Zzd6qO4fML0mhuIWF+chOdvRiyT48vsoa02Is6Fc9nOkW7s2fuDxzo6hYoGk1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MQP4it7X; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MQP4it7X"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id 263DA20B6F21;
	Mon, 23 Mar 2026 06:59:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 263DA20B6F21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274388;
	bh=z5pOF/uzO+7evYgTyZgR0PS2QiZuE42WF+kRFN/Qu/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQP4it7X9kjqgaHAjWwpRdEqThg3YMJoToaoQvka51y29N8Ugk20eIlhJC5YTwPIM
	 bxHknKSLeeuYASMTxJ1IgWzKolt5GcpPcNmBBgaTDQbGAfckyodyuJytvoBtHziXvn
	 wbTt6GXiLKzkF9TPxqm1MJpyyEZXat0HH774cp/g=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Wei Liu <liuwe@microsoft.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 24/32] accel/mshv: introduce SaveVMHandler
Date: Mon, 23 Mar 2026 14:58:04 +0100
Message-Id: <20260323135812.383509-25-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
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
index d1bf148bb8..365288b901 100644
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

