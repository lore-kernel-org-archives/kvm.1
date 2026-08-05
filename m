Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C16433E93
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927880; cv=none; b=V+3rhkYz84gJ2ngjAURuS6yslONx3jtrNccBQkva7r8+C2J8a0tWoOe6tMigwlHmR5XT2uHEGLzbSyqWfnquwb6IfJINVIp8YIzmbXrKc7LoXqGOIEefGYjmNFOWE2SHfRBd6C7y7+msdFHNY97MsI26J1eYondnngsI3i7t8/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927880; c=relaxed/simple;
	bh=kyngnl31kCnMznl2NSccL4sbfaoSuvg+5AxG+DD2dVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jl7zP9ltulaVIyo3nwHB1NLZNYNEkp5uyNYJqkwjTq+o8RNH7WUJvW1p72uSwQz/iUsbNGRWURo7k5AoEt8RP/tt9JUM7IJXZtbLfqYMo1Z9U60Ew/p6XYyg0nMv1DY5P5CvLwA6xEizlNS44FqbkXzKw6/rNxO4QSyA/UCnWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=P2C64b5o; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="P2C64b5o"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0C6B920B7169;
	Wed,  5 Aug 2026 04:04:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C6B920B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927858;
	bh=2Lr3z941HXJaQ18Cjd5S16Yzqdy/e1fawMbuefz9a3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P2C64b5oh8gvtnqw/fn3FIlU9TIcefbqXyc3HB47Dqukunlt6YGQnN9tze9G4q+tT
	 8ehEW1bT18v13xqQNwdUi9VWwMJs2Mm6m858EgfEoRbMlW9GS237DV/FTKVGJU/1vR
	 rVe6gUUAhvVZfzIUSwWDYNQnWyjIHpVPeBUSMiD0=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH v1 5/5] target/i386/kvm: read plane config via address_space API
Date: Wed,  5 Aug 2026 04:04:32 -0700
Message-ID: <20260805110432.25167-6-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110432.25167-1-snambakam@linux.microsoft.com>
References: <20260805110432.25167-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Match the vm-planes-merged integration result: read the guest
vm_plane_config/calling-area through address_space_read() (with the
address-spaces/memory/thread includes) instead of the
cpu_physical_memory_read() helpers, and pick up the kvm_para.h
whitespace from the header re-sync. This delta originated in the
integration branch's merge-commit conflict resolution.
---
 include/standard-headers/linux/kvm_para.h |  2 +-
 target/i386/kvm/kvm.c                     | 23 ++++++++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/standard-headers/linux/kvm_para.h b/include/standard-headers/linux/kvm_para.h
index def451c43c..3094d70c8d 100644
--- a/include/standard-headers/linux/kvm_para.h
+++ b/include/standard-headers/linux/kvm_para.h
@@ -27,7 +27,7 @@
 #define KVM_HC_MIPS_EXIT_VM		7
 #define KVM_HC_MIPS_CONSOLE_OUTPUT	8
 #define KVM_HC_CLOCK_PAIRING		9
-#define KVM_HC_SEND_IPI		10
+#define KVM_HC_SEND_IPI			10
 #define KVM_HC_SCHED_YIELD		11
 #define KVM_HC_MAP_GPA_RANGE		12
 #define KVM_HC_VM_PLANES_CONFIG		13
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 5ac7962e61..b8a68a1c56 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -21,6 +21,7 @@
 #include <sys/utsname.h>
 #include <sys/syscall.h>
 #include <sys/resource.h>
+#include <sys/mman.h>
 
 #include <linux/kvm.h>
 #include <linux/kvm_para.h>
@@ -36,6 +37,8 @@
 #include "system/kvm_int.h"
 #include "system/runstate.h"
 #include "system/ramblock.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
 #include "kvm_i386.h"
 #include "../confidential-guest.h"
 #include "sev.h"
@@ -47,6 +50,7 @@
 #include "gdbstub/enums.h"
 #include "qemu/host-utils.h"
 #include "qemu/main-loop.h"
+#include "qemu/thread.h"
 #include "qemu/ratelimit.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
@@ -6665,9 +6669,12 @@ static int kvm_handle_hc_vm_planes_config(X86CPU *cpu, struct kvm_run *run)
         int plane_fd;
         unsigned int i;
 
-        cpu_physical_memory_read(plane_gpa + 0,  &load_offset, 8);
-        cpu_physical_memory_read(plane_gpa + 8,  &memory_size, 8);
-        cpu_physical_memory_read(plane_gpa + 16, &entry_point, 8);
+        address_space_read(&address_space_memory, plane_gpa + 0,
+                           MEMTXATTRS_UNSPECIFIED, &load_offset, 8);
+        address_space_read(&address_space_memory, plane_gpa + 8,
+                           MEMTXATTRS_UNSPECIFIED, &memory_size, 8);
+        address_space_read(&address_space_memory, plane_gpa + 16,
+                           MEMTXATTRS_UNSPECIFIED, &entry_point, 8);
 
         /*
          * joergroedel plane model: a plane has exactly one vCPU per
@@ -6685,8 +6692,9 @@ static int kvm_handle_hc_vm_planes_config(X86CPU *cpu, struct kvm_run *run)
         }
 
         memset(cmdline_buf, 0, sizeof(cmdline_buf));
-        cpu_physical_memory_read(plane_gpa + 156, cmdline_buf,
-                                 sizeof(cmdline_buf));
+        address_space_read(&address_space_memory, plane_gpa + 156,
+                           MEMTXATTRS_UNSPECIFIED, cmdline_buf,
+                           sizeof(cmdline_buf));
         cmdline_buf[sizeof(cmdline_buf) - 1] = '\0';
         memcpy(ps->cmdline, cmdline_buf, sizeof(ps->cmdline));
 
@@ -6899,8 +6907,9 @@ static int kvm_handle_hc_vm_planes_activate(X86CPU *cpu, struct kvm_run *run)
             return 0;
         }
 
-        cpu_physical_memory_read(gpa + (plane_id * VM_PLANE_CFG_STRIDE) + 16,
-                                 &entry_point, 8);
+        address_space_read(&address_space_memory,
+                           gpa + (plane_id * VM_PLANE_CFG_STRIDE) + 16,
+                           MEMTXATTRS_UNSPECIFIED, &entry_point, 8);
         if (!entry_point) {
             error_report("vm_planes: plane %" PRIu64 " bad entry_point",
                          plane_id);
-- 
2.55.0

