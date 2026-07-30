Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3BA3F6C26
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403542; cv=none; b=cxQGxp9s6xxWKX40Pk26Eb8LNz9OUIzH24FTa3h2KQJdgGRkyulNilOAJWAmMXBhX8+aGQmhno198H0DNAlFQfyrtPXqo08FelzF7BzQK+xVP60NooBsZZ/72MN+uHViI6v9dJy52Qi/txXmoRKD1SN1BScaECNfZxM8PnZZEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403542; c=relaxed/simple;
	bh=aPnBQvH+JEQl62JSfQJgrwtrx646x+A3PFWt7CJYuOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GooD83qJQro+LBVnyYlgUfX3zT3tdpfyoA8r8WyV0BedOJAQw/QtweesatawwElv3p2QRnwi/lXhU6P96siZesvhXj0BN9slW9NZq380xr3yPYsrzizI7+GkEtmgry3GjEOazP8iAB0c3h24eugiHC2vnI6SCe9ItOHIuvaUhw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaK/YMOH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaK/YMOH"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848479c9bd5so1643640b3a.3
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 02:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785403540; x=1786008340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O9A8tKmgH/5kniasHlafAxdvgLATzr/Vyh67WvhGtfs=;
        b=QaK/YMOH3AlMIS93DOcpvIyAi8TsXvblFcYyFrxEWsoe8aDPn2MYgeQULkcg01e8+5
         vo9SqHLiR3GM4JwhS8slULp+2sDROSzcsyEIr1C8NxHmNkQwN1fARtNynPfdeIkgzDK0
         6sstqwfSBRt3Inn6P8QyaxRSrGU473MBsIBnkgVuyYK4JHLdQ3v7ZIM/lcltxMPj9ea1
         NHHS3Lk65E+GtaOBNfcClTgy5f80E3+jDzE3kyeLYDp9y2VdkY/oL2qqBJ/0Zb1v1v8c
         VbZwGVUBqEBq5uh7Ev3C4r1oCybYl4TSwCBI6+Ff2IpGdR5iMnbRABc24vyQmkk259WB
         WISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785403540; x=1786008340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O9A8tKmgH/5kniasHlafAxdvgLATzr/Vyh67WvhGtfs=;
        b=LJj8g9e9gZq/ZYlJnOc4oKz0luvmORMnJ0kQKPAhk1Ipsjx7c6Q7S9y+4MchsXgF4M
         fhaYLsC2i+DAudO40tmG6zF1T4xG5ylf444drK+jPP940h92yW/L/b2KA7jymVfIxqTW
         zrsFhbnJEafUBMQO5HzeHS3cMyGBFIzYUVhxYkh3uinUcEQkE5N9TDS0aDeJmXhzSmEZ
         FUD+2fql/B9pA3TzhyLuKCX5SmldketPPlecp8JCqZU64pKuhd0+CGCQR1n5uhzl6BqH
         B8aitB/MAzyNOpcULDkz/iHnAxJEMJbc3aS2sEuhYxHWxMLeLDWrwPerQkWUIMD8MP58
         wwkA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2k3ezdJ0gUfnsbAYqwrdq7YGqjOaQqS+gpuZhkfIuKGAr62XJuUhAZr7EEtnHjm4Klz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOHekXjFLAXV911hR8LBDQfvQYCHyCzauWWec/sry3l7hFj5Zr
	Dysra7nTJNweNssSxuqgMu0pKHj2Tk7k6YapcJZLkKoVEPgPZ2Y6vFqJVrlsKiFu
X-Gm-Gg: AR+sD11qBlrYgvIDSTVY/KRS4Ox2ogJLbe6unbIPDWNpyxIfgAXp5mjnG4xeCRoIb0w
	T2XrmCP1T6mmLB5Spjb676JQAOmEicllIS4Ms1C0MA5+jT9r7uRgqSWrSzmwbjtv7JyxL+a4l64
	QwfdEKuyQHlg8ByWqJGBwF71EsgLe3/cdJ4YIL2UQOV8O6Ui/X/qXIwGFDqja5fiQblyhYTUfC4
	v7ttCaoEwuXSiPXSqQpY3VH1r7QrMBkIeu7x7Fhr2eBTCzlzexI3T5+sVd0B29fAMV50l+PH3NB
	hQOByPKaskOc0jGsbGUeRs5HjOM9RhUTChh65PQx4acMx2e+H8lj8nac/ZSBzA6CYwutlueLcWj
	CQqAbSUcbYhbW0YlUexCDKJvbR33Uq6BOqrMb+/skHWjBQkNYTyhgMgw6HrRbKyJ/9zxR0EACRY
	DZvs2yzaD4V5VkKQ5C60xbu8Qd9CnUERMis/VMR030rWcwEJ3hCImY5QXzA/4j2sX1YB6/abonT
	EGTCg==
X-Received: by 2002:a05:6a00:2e1e:b0:848:2f74:d8da with SMTP id d2e1a72fcca58-84ebc48638emr1624244b3a.75.1785403539951;
        Thu, 30 Jul 2026 02:25:39 -0700 (PDT)
Received: from 2045L.tailb1cd6d.ts.net ([36.112.122.101])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84e9fe2153csm2753324b3a.3.2026.07.30.02.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:25:39 -0700 (PDT)
From: Guidong Han <2045gemini@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Naveed Khan <naveed@digiscrypt.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guidong Han <2045gemini@gmail.com>
Subject: [PATCH v2 RESEND] RISC-V: KVM: Fix PMU event info array size overflow
Date: Thu, 30 Jul 2026 17:25:33 +0800
Message-ID: <20260730092533.1369531-1-2045gemini@gmail.com>
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
Allocate the guest-driven array with GFP_KERNEL_ACCOUNT so it is charged
to kmemcg, and use __GFP_NOWARN to suppress allocation failure warnings.
Use kvcalloc() to allow vmalloc fallback and an unsigned long loop index
to match num_events.

Reported-by: Naveed Khan <naveed@digiscrypt.com>
Closes: https://lore.kernel.org/kvm/178345245327.72065.13249716450708539854@digiscrypt.com/
Fixes: e309fd113b9f ("RISC-V: KVM: Implement get event info function")
Cc: stable@vger.kernel.org
Signed-off-by: Guidong Han <2045gemini@gmail.com>
---
RESEND:
- Send v2 as a new top-level thread instead of replying to v1.

Changes in v2:
- Use an accounted, no-warning kvcalloc() allocation and kvfree(), as
  suggested by Sashiko.
- Naveed Khan reported the issue before v1. I missed his report at the
  time, so add Reported-by and Closes tags to credit him.

Link to v1: https://lore.kernel.org/kvm/20260718153620.829378-1-2045gemini@gmail.com/
---
 arch/riscv/kvm/vcpu_pmu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index bb46dcbfb24d..8e1f6abb84e2 100644
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
@@ -479,13 +481,14 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
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
@@ -500,7 +503,8 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
 		}
 	}
 
-	einfo = kzalloc(shmem_size, GFP_KERNEL);
+	einfo = kvcalloc(num_events, sizeof(*einfo),
+			 GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!einfo) {
 		ret = SBI_ERR_FAILURE;
 		goto out;
@@ -512,7 +516,7 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
 		goto free_mem;
 	}
 
-	for (int i = 0; i < num_events; i++) {
+	for (unsigned long i = 0; i < num_events; i++) {
 		eidx = einfo[i].event_idx;
 		etype = kvm_pmu_get_perf_event_type(eidx);
 		econfig = kvm_pmu_get_perf_event_config(eidx, einfo[i].event_data);
@@ -525,7 +529,7 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
 		ret = SBI_ERR_INVALID_ADDRESS;
 
 free_mem:
-	kfree(einfo);
+	kvfree(einfo);
 out:
 	retdata->err_val = ret;
 
-- 
2.43.0
