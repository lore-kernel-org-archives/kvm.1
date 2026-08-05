Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572844582C4;
	Wed,  5 Aug 2026 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927850; cv=none; b=MRxvoCYxA5lMSAb3KO/vO9y/8XYE7WJ3Re6/Bw8H5hrQJffh6jYoU4/P9XcvVi67jAYxmrcC6djTw6IM4t+tZoObKjZxqHrdW+qdiOzjc4zmWfURlMaZr1kMzKSYjitm092TwzGdE7CiH174qnPFWWDwlu8v+sOO+UzZSvCB6RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927850; c=relaxed/simple;
	bh=Fgr/Agm/bR5/iZn/emRL6wgpHMAmeE9jPpISZ1WSMzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxx6EWhovqJ2flt3AlS/AxTeKM5U81pEGebs/HCJn7zAqzbR/7HAUNjPDjoN9GxFYDW8MPr32UBna4V5Nnos7ZcMg29TSfRbHxoQHLxp2ZEzAFNPPmylClRA4laIv1IRIxdteJOt5V7hhB/6hdFqgKszwWJMRMlboyeAz/Shg00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=abTvn7hI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="abTvn7hI"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8E69F20B7169;
	Wed,  5 Aug 2026 04:03:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E69F20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927827;
	bh=1iNMm6KdlSbQDTIO8LLHIJTEmbz79B7DNWaze903Dfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abTvn7hIQkR3eQoT0aRGituxwLeZ95tOayeGZoUqujN5bVsf2jFviyGcYRU5HQ880
	 lFazccm0XUCJR7LvpHVy9UzUdjskAfMYEoF7OhqP4jawltegNc7tSay5RABdpfafD3
	 XPDXyVB74YAQqTSQ+cqinbxBsdQeWwrmbdD4tMys=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 30/42] security/vbs: run backend probe and HEKI seal at rootfs_initcall
Date: Wed,  5 Aug 2026 04:03:12 -0700
Message-ID: <20260805110324.25067-31-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move VBS backend probing (vbs_probe_init) from device_initcall and the
HEKI kernel seal (vbs_heki_late_init) from late_initcall to
rootfs_initcall, and link probe.o before core.o so the backend is
registered before the seal runs. At this level the initramfs is
unpacked and the VM planes have been set up (init/ links before
security/), but device drivers, modules and userspace have not started
yet, so the kernel is sealed before anything that could tamper with it
runs.

Signed-off-by: Sriram Nambakam <snambakam@linux.microsoft.com>
---
 security/vbs/Makefile | 5 ++++-
 security/vbs/core.c   | 9 ++++++++-
 security/vbs/probe.c  | 9 +++++----
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/security/vbs/Makefile b/security/vbs/Makefile
index e33052ccde2d..01e831e28ac7 100644
--- a/security/vbs/Makefile
+++ b/security/vbs/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_VBS) += vbs.o
-vbs-y := core.o probe.o
+# probe.o must link before core.o so that, at rootfs_initcall level, the
+# backend is registered (vbs_probe_init) before the HEKI seal runs
+# (vbs_heki_late_init in core.o).
+vbs-y := probe.o core.o
 
 vbs-$(CONFIG_VBS_HEKI)		+= heki.o
 obj-$(CONFIG_VBS_KVM_PLANES)	+= kvm_planes.o
diff --git a/security/vbs/core.c b/security/vbs/core.c
index 16b5329964f9..1167026fc7d1 100644
--- a/security/vbs/core.c
+++ b/security/vbs/core.c
@@ -195,4 +195,11 @@ static int __init vbs_heki_late_init(void)
 
 	return 0;
 }
-late_initcall(vbs_heki_late_init);
+/*
+ * Run at rootfs_initcall level (after vbs_probe_init in probe.o, which links
+ * first) so the kernel is sealed before any device driver, module, or
+ * userspace runs.  The secure plane vcpu already exists by this point because
+ * arch_init_vm_planes() (init/, links before security/) ran earlier in the
+ * same initcall level.
+ */
+rootfs_initcall(vbs_heki_late_init);
diff --git a/security/vbs/probe.c b/security/vbs/probe.c
index 292f3663a996..14aa3d59310b 100644
--- a/security/vbs/probe.c
+++ b/security/vbs/probe.c
@@ -96,8 +96,9 @@ static int __init vbs_probe_init(void)
 }
 
 /*
- * Run at device_initcall level: platform detection (CPUID, MSRs, SMCCC)
- * is complete by this point, but subsystems that consume VBS (module
- * loading, HEKI) have not yet started.
+ * Run at rootfs_initcall level: platform detection (CPUID, MSRs, SMCCC)
+ * is complete by this point, the VM planes have been set up (init/ links
+ * before security/), and subsystems that consume VBS (module loading, HEKI,
+ * device drivers, userspace) have not yet started.
  */
-device_initcall(vbs_probe_init);
+rootfs_initcall(vbs_probe_init);
-- 
2.55.0

