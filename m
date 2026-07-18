Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262F72ECE91
	for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784388991; cv=none; b=h08KN+udqTgeCbOJ9ToIvKmM5lwjMuP+OroKmg+nsjusV0mAuRVyYM+jA8Phs24I6mXe/TbJ5AyzIsyBaCkyXBhek0x8T1L71GBIcjRxbS7aYelFgYKtTuIKSI8y7AA7dNMi3kKDx15HFnmI1z07PZs1J2sND8dWWVQRcYto714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784388991; c=relaxed/simple;
	bh=kGZ4oHn4O2FG8AC20CYrnU3QKzq63ckoS+az9lGJO4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i13Te2WQTxKOEArbPWSVlIJ3pkh3FKC4kXGvSjLxWOzggLuG13f78Ubmk0NIYUbJZVIX016t+Ij1jmOuOZLBRto5heoU5/Qewv20yImxCsbsOW1y+KIHM66vwWLmTApaLsf3Lgm+9CwAd+wW7s24FGeqy58EB1S/4FLFxYYJ7hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLyNhLU5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLyNhLU5"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso5808071a12.0
        for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 08:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784388988; x=1784993788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vo3O4C85dd8u4rAF/3VjEGqMnG6FGHT5+qn329tDhDM=;
        b=fLyNhLU52WM9qm/6cG3LjzZ7X5N5WNhMEkcX0Rj5JTiQJuPm870F+43x0P+oCJpOzl
         m94AZh6W3IWlEBWrQNuS2z7Zbc4myu0Fdm7LU5sfpRxQF1jM7iZctB8X1WTsg4L+QimN
         GQJzgPApOwcWZgUkzPtCcI3zybrh3bgdQv59eEhNGpJtJOSa4jC074oRqTn/R6Frqidc
         YsYiYjInzK+IYvTYOU/yg4rmTvGy5FCGNKUnHXthIPxmVq8hYkyMjPrNJm5pf2Y0IOm5
         7Q6Pi3/EiGhy+NVzbcGR5GyN42BDhWcfA+kVpRUIraEV8e/71P/pwZb+qhd33AdtAqYB
         s5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784388988; x=1784993788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vo3O4C85dd8u4rAF/3VjEGqMnG6FGHT5+qn329tDhDM=;
        b=czQu6wzYe24NQletW2CmwXRt48QLG5mA+3uzktjdQQvs7dW9iZkaMQsRY5bzSqM+bR
         eQCT7jVs1oXRKk6b+mkMvEyV9SzuiUoQCy9CrMNCWWGKKgIjXVbc6M2EjWc/zdmasXvm
         9wybOxnE4MyD5uXhr8u0XUJI0tjQogrbLflzW2Nq3EwROVI/Hgs0RC76hH5TLKfyXq6R
         wS4zW6FQiUZUEleEBTHRYOWJcro4XE1RlQ4kcZlzbz+3IxRT163Xi6fEPhyiorPJ2bTT
         FoDsLU0t6xZkQIsDavusLgGlNnnLX9TEFhsYNqmoPrvtRmso03E/iPtMelLKb0b0EJLi
         Ratw==
X-Forwarded-Encrypted: i=1; AHgh+Roo2OvqF7Db7EcEeHNCmOp1XI8T/oa209Viyqa6VfAtstbnkLyX8osKr3SoBys6ENiLnw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvxWNi6IS0zbNP+gFqGmr5Iz7VtN601284MInsDd3tDg2rhAFa
	7wjthgdFAU5JnwHlbXHPCtGIGYsAsPzWFv6PaZfaPUFJyvMAvv3f4osN
X-Gm-Gg: AfdE7clKr7J5LlWKZxX4unSZTsjGblhrADnbZ6IPFSZx5TG6j0TAvBSjqccH1VfDhRV
	BkeE6skSKdlJ4K57Ldy8dgH2rN3gCH2U2U+ZqfVrXmPf1SM48EDYbKyOr0AClL0G+XPcuhg2aJZ
	1d7VboNUnZztP/bw35dV06XiMcYSV8MkaVjNxq/IiXsT40bWcmhhuhrDSmpUA6jLZ7FmsPqnD8s
	zg5xqxW09Wp5qQ/7BGEHi0J+L8k72Zj0KDI0Pzf5v9i22H3M6epeJ4HIT+U/qy23VtMmkk+2J6b
	CdnzbHGJd3m9LgOVfW00mlHszx9GEavb9IPkNMBaOk3NPWuUZ3UuCjs0jtUDcOJFGtytA1NdwpN
	gRd6ETQxy0bubgITqnHFKkPKqnsko4jrDMLkL6JcjvQo1LP4QnWtaav2cRzvae9huazbCgHxs8W
	bnWX3tvtVIxMI=
X-Received: by 2002:a05:6300:2703:20b0:3c3:bb40:790 with SMTP id adf61e73a8af0-3c3bb4015femr4507067637.66.1784388988414;
        Sat, 18 Jul 2026 08:36:28 -0700 (PDT)
Received: from 2045L.localdomain ([36.112.122.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb5159b11a5sm2235615a12.0.2026.07.18.08.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 08:36:26 -0700 (PDT)
From: Guidong Han <2045gemini@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guidong Han <2045gemini@gmail.com>
Subject: [PATCH] RISC-V: KVM: Fix PMU event info array size overflow
Date: Sat, 18 Jul 2026 23:36:20 +0800
Message-ID: <20260718153620.829378-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SBI PMU EVENT_GET_INFO stores guest-controlled
num_events * sizeof(*einfo) in an int. On RV64, num_events = 0x10000001
makes 0x100000010 truncate to 16. KVM then allocates one entry but loops
over the original num_events, causing out-of-bounds reads and writes. A
nested guest triggered:

BUG: KASAN: slab-out-of-bounds in kvm_riscv_vcpu_pmu_event_info+0xa4/0x142
Read of size 4 at addr ff600000074d46b0 by task init/1
Call Trace:
[<ffffffff8006471c>] kvm_riscv_vcpu_pmu_event_info+0xa4/0x142
[<ffffffff800690c0>] kvm_sbi_ext_pmu_handler+0xca/0x268
[<ffffffff8006779e>] kvm_riscv_vcpu_sbi_ecall+0xec/0x1e6
[<ffffffff8006008c>] kvm_riscv_vcpu_exit+0x48c/0x540
[<ffffffff8005ea0a>] kvm_arch_vcpu_ioctl_run+0x37e/0xc80
Allocated by task 1:
 __kmalloc_noprof+0x19e/0x4b0
 kvm_riscv_vcpu_pmu_event_info+0x72/0x142
 kvm_sbi_ext_pmu_handler+0xca/0x268
 kvm_riscv_vcpu_sbi_ecall+0xec/0x1e6
 kvm_riscv_vcpu_exit+0x48c/0x540
 kvm_arch_vcpu_ioctl_run+0x37e/0xc80
The buggy address is located 0 bytes to the right of
 allocated 16-byte region [ff600000074d46a0, ff600000074d46b0)

Store the shared-memory size in size_t and reject multiplication overflow.
Reject sizes beyond KMALLOC_MAX_SIZE to avoid triggering WARN_ON_ONCE_GFP()
for an impossible allocation order. Use an unsigned long loop index to
match num_events.

Fixes: e309fd113b9f ("RISC-V: KVM: Implement get event info function")
Cc: stable@vger.kernel.org
Signed-off-by: Guidong Han <2045gemini@gmail.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index bb46dcbfb24d..8b489fc3051f 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -12,7 +12,9 @@
 #include <linux/err.h>
 #include <linux/kvm_host.h>
 #include <linux/nospec.h>
+#include <linux/overflow.h>
 #include <linux/perf/riscv_pmu.h>
+#include <linux/slab.h>
 #include <asm/csr.h>
 #include <asm/kvm_isa.h>
 #include <asm/kvm_vcpu_sbi.h>
@@ -479,16 +481,21 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
 				  unsigned long flags, struct kvm_vcpu_sbi_return *retdata)
 {
 	struct riscv_pmu_event_info *einfo = NULL;
-	int shmem_size = num_events * sizeof(*einfo);
+	size_t shmem_size;
 	gpa_t shmem;
 	u32 eidx, etype;
 	u64 econfig;
 	int ret;
 
-	if (flags != 0 || (saddr_low & (SZ_16 - 1) || num_events == 0)) {
+	if (flags != 0 || (saddr_low & (SZ_16 - 1)) || num_events == 0 ||
+	    check_mul_overflow(num_events, sizeof(*einfo), &shmem_size)) {
 		ret = SBI_ERR_INVALID_PARAM;
 		goto out;
 	}
+	if (shmem_size > KMALLOC_MAX_SIZE) {
+		ret = SBI_ERR_FAILURE;
+		goto out;
+	}
 
 	shmem = saddr_low;
 	if (saddr_high != 0) {
@@ -512,7 +519,7 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
 		goto free_mem;
 	}
 
-	for (int i = 0; i < num_events; i++) {
+	for (unsigned long i = 0; i < num_events; i++) {
 		eidx = einfo[i].event_idx;
 		etype = kvm_pmu_get_perf_event_type(eidx);
 		econfig = kvm_pmu_get_perf_event_config(eidx, einfo[i].event_data);
-- 
2.43.0

