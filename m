Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114483AF65A
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274348; cv=none; b=Kh38T9lPHauDyfGVMh6SQ4DnB2dQTJgv6snqwskVe0EBHg9cbn0S6jLdNJmYiqvkHOdFcvvWyJ1BeBAXVYkEFzfZKKDZi5IBumeH/nNoAII5hJAGO82tAKem/G9gHV6+OG9+U/7tPa0FJ8/7CBmvXAbYE9IqDcLaEbyJEytA0pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274348; c=relaxed/simple;
	bh=XK/jh1RXdtDvlftYo1MDR2aQ/iPwWV2eoASWc235BmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NhIJW3mbLF0uRcgwq32i08nFaFZ49HHqPCgfUpBSUTouLGMFrBcg+RwAwOPIi7q3OqyzaW6xu2SC3XlJdck/4aFe3cgti9A2TB8KhgFlJt0eS0BoVoNz0Mklx9uxUbkNsBQ490pfoPHk2gTiKaQXBM+5oxg12fDk3RJqHXajtkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=k6q8KWt7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="k6q8KWt7"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id ABB9020B703B;
	Mon, 23 Mar 2026 06:59:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ABB9020B703B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274346;
	bh=57Nxf0HUrehtTgIAOHD4gvpLgPO803KCA3BRX10c6L0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6q8KWt76IFtPQRx4EoxjLyHAczwTAFAwykWgBnbrySJ5CVrdRKhDXqe6Cew6CL3U
	 ni4M+EKnPKg5GVjHoRek7pE+EXgM93XwPqSJrr/ujI+4kQykNENxVPRIsWFJecihSi
	 oztEOE7VsjSEq7kc9185RWpDVYSXqE1oC9zJLSdE=
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
Subject: [RFC 13/32] accel/mshv: remove redundant msi controller
Date: Mon, 23 Mar 2026 14:57:53 +0100
Message-Id: <20260323135812.383509-14-magnuskulke@linux.microsoft.com>
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

The remaining MsiControl infrastructure can be removed now

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/irq.c          | 11 -----------
 accel/mshv/mshv-all.c     |  2 --
 include/system/mshv_int.h |  3 ---
 3 files changed, 16 deletions(-)

diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 52b8ac9479..4828ac51ac 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -25,17 +25,6 @@
 #define MSHV_IRQFD_RESAMPLE_FLAG (1 << MSHV_IRQFD_BIT_RESAMPLE)
 #define MSHV_IRQFD_BIT_DEASSIGN_FLAG (1 << MSHV_IRQFD_BIT_DEASSIGN)
 
-static MshvMsiControl *msi_control;
-static QemuMutex msi_control_mutex;
-
-void mshv_init_msicontrol(void)
-{
-    qemu_mutex_init(&msi_control_mutex);
-    msi_control = g_new0(MshvMsiControl, 1);
-    msi_control->gsi_routes = g_hash_table_new(g_direct_hash, g_direct_equal);
-    msi_control->updated = false;
-}
-
 /* Pass an eventfd which is to be used for injecting interrupts from userland */
 static int irqfd(int vm_fd, int fd, int resample_fd, uint32_t gsi,
                  uint32_t flags)
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 08bc26713f..056b19b3b8 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -426,8 +426,6 @@ static int mshv_init(AccelState *as, MachineState *ms)
 
     mshv_init_mmio_emu();
 
-    mshv_init_msicontrol();
-
     ret = create_vm(mshv_fd, &vm_fd);
     if (ret < 0) {
         close(mshv_fd);
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 9bc56e70cf..7af5bcf022 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -118,7 +118,4 @@ typedef struct MshvMsrEntries {
 int mshv_configure_msr(const CPUState *cpu, const MshvMsrEntry *msrs,
                        size_t n_msrs);
 
-/* interrupt */
-void mshv_init_msicontrol(void);
-
 #endif
-- 
2.34.1

