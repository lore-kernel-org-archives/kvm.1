Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2722157B;
	Fri, 22 May 2026 04:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422444; cv=none; b=JLJoPAo18RplABCNaIoUcWFl0K4V2HWt9Lo13j1Ma2rxlFHuXb//sYDOVE2YYSvtg09uwBi7tina3fU+MaWEf3TwSsVgbL6BuE2Gr9AZdZ58VpG2D0F0hJxpq3tX1wJO3UqiT5ku9P9PBK2paGTjYy4OzzyfiluaEglSf2vGYvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422444; c=relaxed/simple;
	bh=QbZUKjdjRuQXtzg05CzVoq/5DiFTpb7F9GvwPGCiV3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KfOHfhN/jVMah8V3dKqjdH8VnrnuXiXttOyzeodf9UdFOsSwxvKYa4DkonGz4Lt5M6y6Kr0lJwGxWT82pOtPUmzNSpwMich9g533JRHcW3n38+BuDvjw6GaD+xpmgIzN+96/FtjWpFxmjndaNuPnNMBM3H000PC+8G0pMN2T+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2013519|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.091802-0.00767594-0.900522;FP=8872141843517162851|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.hdi.OM-_1779422418;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.hdi.OM-_1779422418 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 22 May 2026 12:00:29 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	mlevitsk@redhat.com,
	naveen@kernel.org,
	linux-kernel@vger.kernel.org,
	Tina Zhang <zhang_wei@open-hieco.net>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: SVM: Disable AVIC IPI virtualization on Hygon Family 18h (erratum #1235)
Date: Fri, 22 May 2026 12:00:14 +0800
Message-ID: <20260522040014.3380201-1-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hygon Family 18h CPUs are derived from AMD Family 17h (Zen1) silicon and
share the same erratum #1235: hardware may read a stale IsRunning=1 bit
during ICR write emulation and silently fail to generate an
AVIC_IPI_FAILURE_TARGET_NOT_RUNNING VM-Exit on the sending vCPU.

The absence of the VM-Exit causes KVM to miss the required wakeup of
blocking target vCPUs, leading to hung vCPUs and unbounded delays in
guest execution.

Extend the existing AMD Family 17h erratum #1235 workaround to also cover
Hygon Family 18h.  With IPI virtualization disabled, KVM never sets
IsRunning=1 in the Physical ID table, so every non-self IPI generates a
VM-Exit and is correctly emulated.

Fixes: 8de4a1c8164e ("KVM: SVM: Disable (x2)AVIC IPI virtualization if CPU has erratum #1235")
Cc: <stable@vger.kernel.org>
Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/avic.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index adf211860949..993b551180fe 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -1300,12 +1300,14 @@ bool __init avic_hardware_setup(void)
 	}
 
 	/*
-	 * Disable IPI virtualization for AMD Family 17h CPUs (Zen1 and Zen2)
-	 * due to erratum 1235, which results in missed VM-Exits on the sender
-	 * and thus missed wake events for blocking vCPUs due to the CPU
-	 * failing to see a software update to clear IsRunning.
+	 * Disable IPI virtualization for AMD Family 17h (Zen1 and Zen2) and
+	 * Hygon Family 18h (derived from AMD Zen1) CPUs due to erratum 1235,
+	 * which results in missed VM-Exits on the sender and thus missed wake
+	 * events for blocking vCPUs due to the CPU failing to see a software
+	 * update to clear IsRunning.
 	 */
-	enable_ipiv = enable_ipiv && boot_cpu_data.x86 != 0x17;
+	if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18)
+		enable_ipiv = false;
 
 	amd_iommu_register_ga_log_notifier(&avic_ga_log_notifier);
 
-- 
2.43.7

