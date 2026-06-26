Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C0F3E9281
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466717; cv=none; b=pCF14Arzvr5Y+UggokU3yIcR4uFybCcicM6H+JxHbLY7OfekaeRsZL7AV7LMq9HS5gaZGUI4sR5Vnav+I8kSnKCk3z7ltarTqm//O1SWu2kEvwlNcEOAbyOFDZDXZsYlFcJWjC70YjFdKTpQaX/rNSne/M8F+vzomxOzZVL9qqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466717; c=relaxed/simple;
	bh=VCtdpA7YF5advtu0bupY3qxS+FfCYS20j33S3YKJEL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJpCNab6I8SoEPMXmkxRgzZZhN8+zmwA4cVVi7ccLoVhDHY1Er3RNwB3gj78SPlzX5CEtNpk/y0sQAnqjtCK+BqjPomfjetVKS80lxhA8h/YPqruNuwbmMDod+HtP78L5Y7jb4CxfbrqZpfmgs0wQxcnzmhSRQ0AmH3wkedmMLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DWVJSL6g; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DWVJSL6g"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1363fe80fe8so1681700c88.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 02:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782466713; x=1783071513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k8TjMER5gISFlQ4SyOMczlZr2aeQOkgr25LHVZl1LkM=;
        b=DWVJSL6gfBmDK5biTcal08+00sEyxE+jhEihF0N7V3Dr9vszhHCpylSyVcdgAQwwoW
         QxR5St6rpam3TkmXQzcETI39EBK/SMqHhPxD7ZJ5GpYRpMOdT2laQHo3mnI+l6WYsU0w
         m0FxMBQSY2uWnPoYrV6IJIlyIj4RGRrDip84lDrIHvJ2mDJJbMPEAyXxPK+8rvUS/6uu
         nXvupE8HQW9HJT9MWYwInK8IvFMFrTsj/IxECzqqQ2BMbh3LxKjJoqYpmrRNEGa1mA80
         2HnbG4dYga2Gj7IiAUQ0/LnupBdCa2d680W97u3hsSi5ZuiBuKRf6b++1h/79GLRmg+Q
         fJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782466713; x=1783071513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k8TjMER5gISFlQ4SyOMczlZr2aeQOkgr25LHVZl1LkM=;
        b=e03Lh3IfIBNT4D7XqMadA5EJHRpKcimpiM/m9WDL1ZpkQQhLjyiVmAdE6FZm6H2ct1
         93PprnFO9bIs9DQqjipADqdCVMh439TaHei8H+bBjQzx+KNlFk5t7W7K1Q8LlZmslxu8
         w8SIUQRDIUpbutxdtXn7AUB8BWSlvR094iV4U8gsp3XyMMG5kNboHVo4iUjUtK6SNBdD
         mV+iAibH41EtapMIe3YnWlxv4bpbEai/viUJSNjZCnKxOz9ig6oZLcstLioDyc/X34Cn
         KGCMtFRxCSYOkQNFrGSEw3DwoBJPVr6R84jVCD6Xf/iW/TNpn1VJSABtwGwcDdaXYfZn
         5QIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8EbwjtesexUxo4WuFjQp9niiBvk+LLWXNmdJYoxCQY/FRLbEUru2hD9aMqjtnuk89gzOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1aNX3R/rwU1DefgYz3CIW8rlCZ5oIP/IBkag3BfXmAPkYpvd
	fP8JE5xqUl+bFGiTRj8lx/LiNrg9/xY4mFFfd3JM7Zk5T88R8DGZuApRL82IRWoe0ds=
X-Gm-Gg: AfdE7ckFiZfqo4CCzFvc5VRjz6BoDTzihaaUSHzgUL8WcIsqfZ/bUlpdxTM5aPEq6HC
	p7h7qvTja+koqyL+r2WPp4b7Nd/pPyICW76L7nGj1jekwJPE2kRZnHUGllxdyX35uVRxe8K6apn
	l8WGoW1N8pLdgYAf8gkv3WUBhYTDO2GWS0YnMzRY+AaDjgum/ZwO0u8NJaBE/n7QKI99Fan1mTR
	+KN9FoVNGF4zXQNaAB9cN2rtTbCA/nvF6nJIxR5E/b6ZRwQGKBH8C1cEsCzVQZORwrGZh0VGT3z
	O/eu0mqgbsrDcFCYNV9DO2qDBxVvpNnfqeoPiLYChwh65+txMjrv25+IbUvQWbcBF+euwcen5Qy
	ZSUI08ctOMAWhFhlbsjRAcMe6fuBBOm+1PEvNfXEJam+9isddU16mSB3WSt7si16+JWxT4lGkgv
	W5SdhHj2PGBnkW9HkI9rShG77ezyqu+fsA
X-Received: by 2002:a05:7022:490:b0:138:56d:27e8 with SMTP id a92af1059eb24-139db9e5f9dmr5069305c88.1.1782466713362;
        Fri, 26 Jun 2026 02:38:33 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d90e95c6sm24350302c88.11.2026.06.26.02.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:38:32 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Fri, 26 Jun 2026 02:38:29 -0700
Subject: [PATCH v3 1/2] KVM: RISC-V: Clear former VCPU cache on
 virtualization disable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-kvm-cpu-pm-v3-1-be051aafe9ba@sifive.com>
References: <20260626-kvm-cpu-pm-v3-0-be051aafe9ba@sifive.com>
In-Reply-To: <20260626-kvm-cpu-pm-v3-0-be051aafe9ba@sifive.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782466711; l=2593;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=VCtdpA7YF5advtu0bupY3qxS+FfCYS20j33S3YKJEL0=;
 b=gABi8lzOetGuxw51Lf0uhej0g392dXy4e7CM6VbjOU/dkev0xdI8lX0iGGOxQIdNqovdvGyZn
 l6zDJEOHmzPAfiH5032VomfJS8xfQK2kmgcDwpwJDD/1yQNuV5o7R/l
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

