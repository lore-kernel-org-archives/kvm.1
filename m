Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A733AF665
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423433; cv=none; b=TIHWt9ccn21HpKPR23+UfWws9Omx3p6uEy4/RiC/xcK6F6wixsZRX02ceoBuoxXUy+eIUgErCDQKSG0J5Ya0Ww1menqHpWbCPnyH6aCi5YgtyrVWBF18QBVJdyPPw4gz7XbtyoIZEuqZwB2gyPgZb4mCEb9IPHNF/OQSkgYS0FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423433; c=relaxed/simple;
	bh=XK/jh1RXdtDvlftYo1MDR2aQ/iPwWV2eoASWc235BmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M9SRV1eAUVDFZyaHJeMxWxNiScMoIFgnZnQJcAEEM9kaF3G+M8fttlDqE0xNRZArjvTeXEVQ7VBSBvY9fo4vCDQuGEevHGdTLz5nfjOAinbIq/ExV3t6ewKq9sGuhpfEq6deBvRaUJjDGdSb4PheWwfhHrYmSBhQjsS3Khi3FqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pAohccAu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pAohccAu"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7548220B7128;
	Fri, 17 Apr 2026 03:57:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7548220B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423432;
	bh=57Nxf0HUrehtTgIAOHD4gvpLgPO803KCA3BRX10c6L0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pAohccAuvrGyGw1H7N5OtFhjCbUVJyEyhFaxtACBiaFcYfyKDiw3Hj91mPdvBenvz
	 UhHOChFo5jUjhNGfPnsAfdh/SyGY9yBCma+HDDqEin8a/ehTkSAADo+vkYlBxyM3pB
	 2jL6k6KrKtn7kzYPCzM9eGj5pyXXYfcrbrTqqUpg=
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
Subject: [PATCH 13/34] accel/mshv: remove redundant msi controller
Date: Fri, 17 Apr 2026 12:55:57 +0200
Message-Id: <20260417105618.3621-14-magnuskulke@linux.microsoft.com>
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

