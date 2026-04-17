Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648543AF67C
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423426; cv=none; b=Y6KBdpG+jz2nWzufx1KIhCxjUP9wNAjEm9iDIIUlwfRjS62TGgRc2B0JvF4kRjramPFvdABIfWmN8PNy8SbhLlJKOCpDGjOX89R9Cz/QB5P1ZHcXmoSlt05XIOy1L7aDvv7fw0mlpnPkGhrwemBppyHvMDiGqUm6a7tSw13LlQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423426; c=relaxed/simple;
	bh=1HSwpCpew4TQLeMRiLUmOHlQlTqLxCGtve3NDAQjdhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PA9Qe7TmZM8JXVqXqeBQs8vQqWsdVDDfhGBLlWWsSf44/yu8VRZlKnCwEaJJiEUfWvUKSYn8j9uuXbOFbaaB6Y4y1GLMsPxKWxdUeSywikGmUfeup2fuwhMNJV3ZkztArtExbPc+oA1wmEZqEGfwa2OGUj3GOCydXZaVVWqnoO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YXOysCp9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YXOysCp9"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 50B1120B7129;
	Fri, 17 Apr 2026 03:57:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 50B1120B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423425;
	bh=+449kqpsT3rs/26cTO+xTXYI56NYmCzZVttigepvBaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YXOysCp9b2cic8VB8v4Yk2Kt0mt2YtL+E/6nLHunSHSEYj3cA2B+xd7+PBnJWsjr4
	 8pn5T9CE2Ju4HSP9UOqxrnVeqrMMCx10cy6bMw+0wikb1tEyueQiN/kATzK3WEakLr
	 56S076zZmobUTKRnZgHFINObZhFLjI2BfpPW+1HE=
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
Subject: [PATCH 11/34] accel/mshv: use s->irq_routes in commit_routes
Date: Fri, 17 Apr 2026 12:55:55 +0200
Message-Id: <20260417105618.3621-12-magnuskulke@linux.microsoft.com>
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

In mshv_irqchip_commit_routes() the entries that have been accumulated
in s->irq_routes are committed directly to MSHV's irqchip.

The old commit_msi_routing_table() fn will be removed in a subsquent commit.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/accel-irq.c       | 2 +-
 accel/mshv/irq.c        | 7 ++++---
 accel/stubs/mshv-stub.c | 2 +-
 include/system/mshv.h   | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 0cb3ef78d3..4303e10e40 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -55,7 +55,7 @@ void accel_irqchip_commit_routes(void)
 {
 #ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
-        mshv_irqchip_commit_routes();
+        mshv_irqchip_commit_routes(mshv_state);
     }
 #endif
     if (kvm_enabled()) {
diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 990ce34620..9ba837f0e2 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -394,16 +394,17 @@ int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint3
     return 0;
 }
 
-void mshv_irqchip_commit_routes(void)
+void mshv_irqchip_commit_routes(MshvState *s)
 {
     int ret;
-    int vm_fd = mshv_state->vm;
+    int vm_fd = s->vm;
 
-    ret = commit_msi_routing_table(vm_fd);
+    ret = ioctl(vm_fd, MSHV_SET_MSI_ROUTING, s->irq_routes);
     if (ret < 0) {
         error_report("Failed to commit msi routing table");
         abort();
     }
+    trace_mshv_commit_msi_routing_table(vm_fd, s->irq_routes->nr);
 }
 
 int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *event,
diff --git a/accel/stubs/mshv-stub.c b/accel/stubs/mshv-stub.c
index dadf05511a..8b69539a85 100644
--- a/accel/stubs/mshv-stub.c
+++ b/accel/stubs/mshv-stub.c
@@ -28,7 +28,7 @@ int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev)
     return -ENOSYS;
 }
 
-void mshv_irqchip_commit_routes(void)
+void mshv_irqchip_commit_routes(MshvState *s)
 {
 }
 
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 2033beed70..0c9a4f927c 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -62,8 +62,8 @@ int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint3
 
 int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev);
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);
-void mshv_irqchip_commit_routes(void);
 void mshv_irqchip_release_virq(MshvState *s, int virq);
+void mshv_irqchip_commit_routes(MshvState *s);
 int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *n,
                                         const EventNotifier *rn, int virq);
 int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *n, int virq);
-- 
2.34.1

