Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E51E7C2E;
	Sat, 25 Apr 2026 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777078796; cv=none; b=TLvn5MqNzMbXgHqrp56Cd0zkBF7HmZEFEXOX2Zopq0pHtN24uBfANAxEz/Mhar11y9805YNjYNXdvWW2sy2WIixxpJCN+cH+XRDcAX3E9gCMKkQyS6ALRI+xSLHwxl5zjFxoy7iOKJmhrXZbhbFwAJ9ZA5wdM0ozDeCUGsRNc9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777078796; c=relaxed/simple;
	bh=7uQ0gjeqEPD6nPlkRBOxKlYHRuy/F0gDZ8rMmS8aYzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZO2q+CpXGG8TzXhz0mjjlzckOuzlpfZx+GuZHJFn2nf2JyqFYferv6YIbCRMrZbAsKz2/HTefq4hVJgokqk4mm2upcf7ld6+rVCf3LiZlNI48mrKCFgW7AMAzS96059lIvIIad7s19uhwJfQGT2tksxiNMN2Omcf4VjBMZHPd40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVR8FtSh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVR8FtSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BAAC2BCB5;
	Sat, 25 Apr 2026 00:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777078795;
	bh=7uQ0gjeqEPD6nPlkRBOxKlYHRuy/F0gDZ8rMmS8aYzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iVR8FtShNzdaxPaI5u0kaR0SDRKtyeuyA0azvOPHDlNXRRDcCYZ1WMk4SzB4nuyN2
	 ScIpNayyJLSYkFEXP0qIBwGRCGQ9Yufhp7UBtIzYj7wg2PFsLM7N84fRIA9MaIp7sz
	 mxHKuswu/FhIDWcGI8fTfF2cACfGiCOd/e/nxbSMNWWhitRTRX5UVPoJzWDo3N+dZX
	 SJB2sjmMlGggVJE1HRZtx41I/j3Cno1cGW4aCwxLQkSJf1uaIOd7RcaDlbPLFtb2am
	 6V5TXLmroYqxvjDheBh7EN03+Zelu15yyfHmSUL00bBUecK/8lp07xUb4lxU/EhqnD
	 caINHRMDPIQAQ==
From: guoren@kernel.org
To: guoren@kernel.org
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	cp0613@linux.alibaba.com,
	fangyu.yu@linux.alibaba.com,
	gaohan@iscas.ac.cn,
	inochiama@gmail.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	me@ziyao.cc,
	palmer@dabbelt.com,
	pjw@kernel.org,
	tglx@kernel.org
Subject: [PATCH V2 3/4] irqchip/riscv-imsic: Move nr_guest_files to per-HART local config
Date: Sat, 25 Apr 2026 00:59:15 +0000
Message-ID: <20260425005916.3321811-4-guoren@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425005916.3321811-1-guoren@kernel.org>
References: <20260425005916.3321811-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

With the recent KVM AIA per-HART HGEI conversion, the global
nr_guest_files is no longer appropriate. Different HARTs in
heterogeneous SoCs may have different numbers of guest interrupt
files.

Move `nr_guest_files` from `struct imsic_global_config` to
`struct imsic_local_config`, and compute it per-CPU in
imsic_setup_state() based on the actual MMIO guest file region size.

Update the related comment to reflect that KVM now uses the
per-HART value.

This eliminates the last global assumption about guest files and
completes the per-HART conversion series for RISC-V AIA/IMSIC.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 drivers/irqchip/irq-riscv-imsic-state.c | 10 ++++++----
 include/linux/irqchip/riscv-imsic.h     |  6 +++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index e3ed874d89e7..f01525362cf7 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -878,7 +878,6 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
 	}
 
 	/* Configure handlers for target CPUs */
-	global->nr_guest_files = BIT(global->guest_index_bits) - 1;
 	for (i = 0; i < nr_parent_irqs; i++) {
 		rc = imsic_get_parent_hartid(fwnode, i, &hartid);
 		if (rc) {
@@ -910,23 +909,26 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
 			reloff -= ALIGN(resource_size(&mmios[j]),
 			BIT(global->guest_index_bits) * IMSIC_MMIO_PAGE_SZ);
 		}
+
+		local = per_cpu_ptr(global->local, cpu);
+		local->nr_guest_files = BIT(global->guest_index_bits) - 1;
+
 		if (index >= nr_mmios) {
 			pr_warn("%pfwP: MMIO not found for parent irq%d\n", fwnode, i);
 			continue;
 		}
 
-		local = per_cpu_ptr(global->local, cpu);
 		local->msi_pa = mmios[index].start + reloff;
 		local->msi_va = mmios_va[index] + reloff;
 
 		/*
-		 * KVM uses global->nr_guest_files to determine the available guest
+		 * KVM uses local->nr_guest_files to determine the available guest
 		 * interrupt files on each CPU. Take the minimum number of guest
 		 * interrupt files across all CPUs to avoid KVM incorrectly allocating
 		 * an unexisted or unmapped guest interrupt file on some CPUs.
 		 */
 		nr_guest_files = (resource_size(&mmios[index]) - reloff) / IMSIC_MMIO_PAGE_SZ - 1;
-		global->nr_guest_files = min(global->nr_guest_files, nr_guest_files);
+		local->nr_guest_files = min(local->nr_guest_files, nr_guest_files);
 
 		nr_handlers++;
 	}
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
index 4b348836de7a..13e8bd7ff4b4 100644
--- a/include/linux/irqchip/riscv-imsic.h
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -40,6 +40,9 @@
 struct imsic_local_config {
 	phys_addr_t				msi_pa;
 	void __iomem				*msi_va;
+
+	/* Number of guest interrupt files per core */
+	u32					nr_guest_files;
 };
 
 struct imsic_global_config {
@@ -68,9 +71,6 @@ struct imsic_global_config {
 	/* Number of guest interrupt identities */
 	u32					nr_guest_ids;
 
-	/* Number of guest interrupt files per core */
-	u32					nr_guest_files;
-
 	/* Per-CPU IMSIC addresses */
 	struct imsic_local_config __percpu	*local;
 };
-- 
2.43.0

