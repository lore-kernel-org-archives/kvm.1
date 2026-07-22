Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29662F5A12
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784699530; cv=none; b=P3pexnfri5w9IFb/6pq3UBaFY5/hVeyDc/mzc4HbkBU9iMOYY5KYUBozHQqspNn2hrqt/u/LvUD3bxWeCu720afGgWqXKPJ8lMGHVLHeZSo7Rqyc+qucZvFzmJmZduOm9VLm7PKhoAKa0T5F2Czcrh59UXT39Ij6NBgVYNKxxDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784699530; c=relaxed/simple;
	bh=VCtdpA7YF5advtu0bupY3qxS+FfCYS20j33S3YKJEL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FZ7N1gMRxRkhN9k4bySJV1znln9vM8wWypIbglYTzPI3okV/fPT5d6f3XhSrR0f5SUpG7tZcSnyzg/VbnMEI1BUttdN4cKMb5/0dghpKUzGM/y/yuqYM5u365PkTj8XocOZKpLD22knvlHO7Miq8Oi2RVBsKvxtKVTfOHfPkJ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OrzUCzXK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OrzUCzXK"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84874b52eabso11616310b3a.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 22:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1784699527; x=1785304327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k8TjMER5gISFlQ4SyOMczlZr2aeQOkgr25LHVZl1LkM=;
        b=OrzUCzXKdkGF/5MZeWvAXPbPQUNMdx0DAeA2hkrliNfEFnQkV8/UFk/ZK6fpLZomoS
         UMK/D3lbxq36aqqxZrL6oaI2sLXzvCCXBMcAjL/62lbCweIlmzBW2jDl/mGXzhR0bdYb
         q5/hJg08sBsVMi80g03nfM2jRXGCw4MrI90I3eRE2TTvvsMXVMwU41yzjJeVDvlxuwr3
         XzwZgF/iROYoKBrG+D8UatQc+8n1ewviWxsHzcPUzx8LB3XXL3dxeTQFykTbz8yzBtXh
         ZFvOr/M4nlItOwxlezB9pxvkwvIv3A/XrdWMe6km7LMAor+sjY8CA6ysYAucV0tAd6hJ
         aetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784699527; x=1785304327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k8TjMER5gISFlQ4SyOMczlZr2aeQOkgr25LHVZl1LkM=;
        b=YlU7M4I7Q0UbLEGlZTPdXEYMAxCPh2NJsHzmtGaPAeD/SZ5TMPVjQkKtl1qi5p71cj
         rnlEZETekko1g1z3bEC+vte+reLuOw4nsa4mPHj16WKJfW2frE7fk+jYgiHXnp8P+VBz
         j3knK0uBhboI0TA4AR/b2rQltJeu4cWqJhzOT7jbc2jfMDPxA1bLFWNQ6udlMNlgVALo
         8wq/DhsJaFjbiPrNauBDCYKKTW4I65s5hqUHSGlHa+uDFZad8O9veE7mJmOh87/BVAWz
         Bebb8tIrewz4GdPWr6f7vXbwgQzLY+DSRYI4cYJP9zbqohxHmTiLjpFGI0A8W5GqCqwq
         sI0w==
X-Forwarded-Encrypted: i=1; AHgh+Rr3djD5eCU61GI1YooCC7v9da7FMqRLAfFyLMUZwjInLIIyv52f+lR1ZuOvVwBXos/G/6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq7kTCto24w2RghWbYUuuoRWAkmqUMMhfrwKBCrucgaBMvDf7D
	x1GOHVEPBqKK5qqmrnEhhyXOgpT942gRAvfuoTdNYMWq+PHRjjLeI11niSxbKl6GT6Q=
X-Gm-Gg: AR+sD12gkDl9ksLEYkqCirlT01H4A6iYU8lFvKjj6APIYrDxV46MLvPxe39+R2l6tsv
	fKU+OvJHDjfnYb2+gPuMqrUQNqfOU88UjRM+AkDd3nV17/Omm2j4vxCEEsmDN6ICTGV9gKdZ+3s
	Q2DOLmroeoViYXEaDVmMn8VVEn82ENQYfjMLlNvOqSwGZMf3Bi4GqqqTSwKYSjIrYoz3tQ3Z2M8
	sJzarO6mFurPavjjlQYfmCjOdNk7w0i03XP84gYVBNdXV/Gq5YppDEdBXL3mJZJjX1gKgPqsfpV
	wdhtWMXsnd+w307BjS0HInxVMdU1HmsTUaRkDHNQ5pSIeSScBAMhe7s2c0m9wX/t2khFnR44Ozx
	P4Md8b44A95nvRjTnS/Tqqlaf+p/L4TXge3XFzAP6AdgEGVd9ft30OmNor4A4DIhKZJDFDl7XVb
	OccWiO3Sz70xJMzqAabWrtbg==
X-Received: by 2002:a05:6300:95:b0:3c3:75ff:95b6 with SMTP id adf61e73a8af0-3c3ad7a1c86mr22612818637.31.1784699527388;
        Tue, 21 Jul 2026 22:52:07 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e081985sm5133138eec.23.2026.07.21.22.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 22:52:06 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Tue, 21 Jul 2026 22:52:02 -0700
Subject: [PATCH v4 1/2] KVM: RISC-V: Clear former VCPU cache on
 virtualization disable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-kvm-cpu-pm-v4-1-146bf942547d@sifive.com>
References: <20260721-kvm-cpu-pm-v4-0-146bf942547d@sifive.com>
In-Reply-To: <20260721-kvm-cpu-pm-v4-0-146bf942547d@sifive.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Nutty Liu <nutty.liu@hotmail.com>, Jinyu Tang <tjytimi@163.com>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784699525; l=2593;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=VCtdpA7YF5advtu0bupY3qxS+FfCYS20j33S3YKJEL0=;
 b=JVqpzramZxn2NBonw83b4SpU8QHsxBwc5n13yl9dz3mE7zfum5e6pHLRs/HTawKeBJnVx9mIq
 jRg8U/NpPlIAX207kgtiWv3SWtVQJ5M8q4R3IGkTs1fF02pBhi3t6i3
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

When a CPU is taken offline or enters deep idle states, hypervisor CSR
state is lost. The kvm_former_vcpu fast-path optimization caches the
last VCPU that ran on each CPU to avoid expensive CSR restoration when
the same VCPU is re-scheduled on the same CPU. However, if this cache
is not cleared when CSR state is lost, the next VCPU entry will
incorrectly skip CSR restoration, leading to corrupt hypervisor state.

Add kvm_riscv_clear_former_vcpu() to invalidate the per-CPU cache and
call it from kvm_arch_disable_virtualization_cpu() to ensure proper CSR
restoration after CPU offline or system suspend events.

Fixes: 1323a5cfe52c ("KVM: riscv: Skip CSR restore if VCPU is reloaded on the same core")

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 arch/riscv/include/asm/kvm_host.h |  2 ++
 arch/riscv/kvm/main.c             |  2 ++
 arch/riscv/kvm/vcpu.c             | 11 +++++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 60017ceec9d2..808b4ee1bd10 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -319,6 +319,8 @@ bool kvm_riscv_vcpu_stopped(struct kvm_vcpu *vcpu);
 
 void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
 
+void kvm_riscv_clear_former_vcpu(void);
+
 /* Flags representing implementation specific details */
 DECLARE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
 
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 0924c75100a2..350e4f097d6e 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -69,6 +69,8 @@ void kvm_arch_disable_virtualization_cpu(void)
 	csr_write(CSR_HEDELEG, 0);
 	csr_write(CSR_HIDELEG, 0);
 
+	kvm_riscv_clear_former_vcpu();
+
 	kvm_riscv_nacl_disable();
 }
 
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index cf6e231e76e2..e48338f907f4 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -26,6 +26,17 @@
 
 static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_former_vcpu);
 
+void kvm_riscv_clear_former_vcpu(void)
+{
+	/*
+	 * Clear the per-CPU former VCPU pointer because hypervisor CSR state
+	 * will be lost. This ensures that the next VCPU entry will properly
+	 * restore all CSRs instead of incorrectly skipping CSR restoration
+	 * via the fast-path optimization.
+	 */
+	__this_cpu_write(kvm_former_vcpu, NULL);
+}
+
 const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, ecall_exit_stat),

-- 
2.43.7

