Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2783B8D42;
	Wed, 18 Mar 2026 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826234; cv=none; b=GndeLOhelqnQkD3IqHupsR8Dbg3sFLREVoi/mGoOK5CEp9rnjaNRSGwdWAqXj/IvLJJR1KOqyxOZe03qCF/ThRGwYFdat0p0tnkYYTAUPFT4pTF5wKO1umJ0Qz2RY8lXIehzqcUyI/PWFNeM1L30O/keinwpK6uSj/pZDaIGCng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826234; c=relaxed/simple;
	bh=gP20Z4l9iYvIO1L5sxgpJoHbOuJCnKY0e1Xl2+YPMtY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nKLxLHuXJK6sHqUQds8CI+l857KNtpCa6Xy+yBjkEO96NMeSQBegKImGTkIQNx80zhqNtV8AXijHrVTh2cscKWUApWlZ32rX2zgX1AaDSXMZIplfzNZ+PYRRvOxMgV44tqNR5Igc7XKg16U/kYuy/BfoKLZXKXCg1kUcPu2MxAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowABnieCVcLppXb4CCw--.589S2;
	Wed, 18 Mar 2026 17:29:57 +0800 (CST)
From: Jiakai Xu <xujiakai2025@iscas.ac.cn>
To: kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: [PATCH] RISC-V: KVM: Fix double-free of sdata in kvm_pmu_clear_snapshot_area()
Date: Wed, 18 Mar 2026 09:29:56 +0000
Message-Id: <20260318092956.708246-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnieCVcLppXb4CCw--.589S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF43Wr1DArWfCw1xZr4fKrg_yoW5JFy5pr
	WDC3WkWrWFyFn7K342yanY9ry8trWYgrn3Kr1DWFy5Gr13KFZ5Zw4v9ryUWry3Z3yvqF9a
	yr40kFy8uFn0q3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr
	1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbyCJPUU
	UUU==
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiCQ4KCWm6Z5gnFwAAsY

In kvm_riscv_vcpu_pmu_snapshot_set_shmem(), when kvm_vcpu_write_guest()
fails, kvpmu->sdata is freed but not set to NULL. This leaves a dangling
pointer that will be freed again when kvm_pmu_clear_snapshot_area() is
called during vcpu teardown, triggering a KASAN double-free report.

First free occurs in kvm_riscv_vcpu_pmu_snapshot_set_shmem():
 kvm_riscv_vcpu_pmu_snapshot_set_shmem arch/riscv/kvm/vcpu_pmu.c:443
 kvm_sbi_ext_pmu_handler arch/riscv/kvm/vcpu_sbi_pmu.c:74
 kvm_riscv_vcpu_sbi_ecall arch/riscv/kvm/vcpu_sbi.c:608
 kvm_riscv_vcpu_exit arch/riscv/kvm/vcpu_exit.c:240
 kvm_arch_vcpu_ioctl_run arch/riscv/kvm/vcpu.c:1008
 kvm_vcpu_ioctl virt/kvm/kvm_main.c:4476

Second free (double-free) occurs in kvm_pmu_clear_snapshot_area():
 kvm_pmu_clear_snapshot_area arch/riscv/kvm/vcpu_pmu.c:403 [inline]
 kvm_riscv_vcpu_pmu_deinit.part arch/riscv/kvm/vcpu_pmu.c:905
 kvm_riscv_vcpu_pmu_deinit arch/riscv/kvm/vcpu_pmu.c:893
 kvm_arch_vcpu_destroy arch/riscv/kvm/vcpu.c:199
 kvm_vcpu_destroy virt/kvm/kvm_main.c:469 [inline]
 kvm_destroy_vcpus virt/kvm/kvm_main.c:489
 kvm_arch_destroy_vm arch/riscv/kvm/vm.c:54
 kvm_destroy_vm virt/kvm/kvm_main.c:1301 [inline]
 kvm_put_kvm virt/kvm/kvm_main.c:1338
 kvm_vm_release virt/kvm/kvm_main.c:1361

Fix it by setting kvpmu->sdata to NULL after kfree() in
kvm_riscv_vcpu_pmu_snapshot_set_shmem(), so that the subsequent
kfree(NULL) in kvm_pmu_clear_snapshot_area() becomes a safe no-op.

This bug was found by fuzzing the KVM RISC-V PMU interface.

Fixes: c2f41ddbcdd756 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
---
 arch/riscv/kvm/vcpu_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index e873430e596b2..ac1b9a91a19db 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -441,6 +441,7 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
 	/* No need to check writable slot explicitly as kvm_vcpu_write_guest does it internally */
 	if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area_size)) {
 		kfree(kvpmu->sdata);
+		kvpmu->sdata = NULL;
 		sbiret = SBI_ERR_INVALID_ADDRESS;
 		goto out;
 	}
-- 
2.34.1

