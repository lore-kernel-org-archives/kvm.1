Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB133BED42
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785308886; cv=none; b=d8BcohXxOmFSBQCNsv/UQeb6iAHczsW53E7CgvvyVP9HvO8vnrP1yQO7m+mUd24KAO4u0TcqLqpPKM+FPUQ2hPaLx6MRSXCqwuRTqTc3OtPT3AQd8Q24E2cCMZNbY1dWfqOPeMF+6cwpvZ1HWo4c6K0PCCnbMWZo1qaDA0/MT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785308886; c=relaxed/simple;
	bh=SsdaLCBhfc9q+NwsQ9Mq9LtNazpr/xt1goUIO6J1tz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u9Fvua9OViDBUxvsBCk+pGMAUHauoQ40GGLIsGjV9d+zFj0T9PI/O/h/PF+pR0L1SF0up33cFTOV8S9DptE2CXYVXTRfvWOPuYbhH2d4uAnzvxZVgSewn61HXr/9vvMONF88w5+lCcTXK51nGQMbTHx7hjoRv4qCntctpXu44vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awkirnrd; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awkirnrd"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-38dcd98e5easo346504a91.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 00:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785308884; x=1785913684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X3JdpARdvO6SntweUzlxloeUTF3+X8KQZf2BNPxyxhE=;
        b=awkirnrdijVR7kwF9FdRXg2zfdU9NsRkjwJpLwxqhHsFdjObWIIIrogBQ+H0cczfKw
         NbQsr0q5EcZCXp4UQ/4vpxv6cQ+b+eASaRh6KXLCkmanrKtShAVoF/l3MWn4iupn9mnA
         aLBQwO4A9a0fybo2TPZiHS5gCc8rDbQQcSX6Dtm1SvUUXBSTKRmMAYytJKRrWhDRpZNG
         2vyDNyMwfbu/gQhswwzAVBcGw2u5Fwk0b4NsPy50urUdjVWp/4iKHIuO0h+tVwhQY0zv
         7e8jxEnU2au9IL84T7aXkhScQrj95N30fsC34Mwv184hb8qVf4jvIp5vZuQuhwRQBZUN
         Czpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785308884; x=1785913684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X3JdpARdvO6SntweUzlxloeUTF3+X8KQZf2BNPxyxhE=;
        b=Co7mtzq+joxBzmFlmsRHmbQ2vADXzjaBWhHa8bavg4EdMxEWw0EbSkCW0sJVomAV9s
         X2umsggwFI6PkFYnZ32UpmkW1YIrhaLvU8WwhBU8b0C+QbudhhoQSNMxuuNdCQM+c5N3
         BK5ozn/MlY/xof8QYBI6SPhRDPrrR9O2db73L1ASz9eD2W338fixcdsxoOCXqkJudnIF
         dzrRWo5YXScogAQkur//6rrxSxiekmw+gr4yIRyIiu7XFyArs48YODi3pgeZqLZ7WkaH
         rC2tDXDBkruE1JbqeO6btwW/RxRcQoHp+iLp7a1M33xHhpJ7Vfa/00FgdAqtx+gs6bUZ
         tXZA==
X-Forwarded-Encrypted: i=1; AHgh+Rozzot022oL4R3f/9dzMwZC9TlEFFm0MgjhdrwDEZdGiwxN3ru8yojY1x3hvPHXIDKZoBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymRFoY5TDFGFDq7JPprPiR8Ng9U6oPtHybNSJ0PkUJl0SrYkEr
	FgaY1gAMoDcLwGUyFYnRo3PjfKlBdhezxbLsyXmptiZuas2cNb55UUme
X-Gm-Gg: AR+sD13SuLoJnRhHnzL/qk6o+y3sPEiL/wQjEMAdqXK9C66S/Cch9xmPesmICP1qyLM
	xRiTjd02eKKNu+GXThI+bMcYTOklEePucR9Noryy847zajcaw57k+n2yhgUrN+IcxQ+PIG9NXG2
	qPPSJiLrqSPPG585pfcjD79qfZYA++wgMfAk8RTrEu06aAnuCIurNtL0OS1menbvJlusKd5DoWX
	NF/+wLUfmjvxG/Sxo0L2TXJKoCOvge4YrzpKkI+q2Zd+XoERUWCx70pumF+Bqxa7BIrsQeMiZFB
	aP0xoGWqk+B2xOkigQScmmQGAegdPuukCoOmosbTMWhqeard2y11gwkjDdHcMmu2mfmkuyM5DE4
	u8tt6ZcstuZJWFGwuoVM5CEuB4tn+U+9B3UMqgXO1nH8HMsoSxdLQ9rr5pjcLMPwakjcziRTnrW
	l5Hk277CMPOqhS8E73NKlboRQVni++uVXAw4lQ+Zu8PQUpLoGP4AcMV6izQot+a5ermFTsApmno
	vM=
X-Received: by 2002:a17:90b:3c12:b0:381:9028:5945 with SMTP id 98e67ed59e1d1-38f6a44b7a8mr6072575a91.14.1785308884161;
        Wed, 29 Jul 2026 00:08:04 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f292af9sm873721a91.11.2026.07.29.00.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:08:03 -0700 (PDT)
From: "Bingyu.Xian" <shanbeeyoo@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Bingyu Xian <shanbeeyoo@gmail.com>
Subject: [RFC PATCH] RISC-V: KVM: Add minimal guest_memfd support
Date: Wed, 29 Jul 2026 15:07:56 +0800
Message-ID: <20260729070756.730312-1-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add minimal guest_memfd support for RISC-V KVM, following the same
pattern as x86 and arm64.

1. Select KVM_GUEST_MEMFD in Kconfig
2. In kvm_riscv_mmu_map(), check kvm_slot_has_gmem() early, before
   taking mmap_read_lock(). For gmem memslots, resolve the PFN via
   kvm_gmem_get_pfn(), then acquire kvm->mmu_lock and jump to G-stage
   mapping, bypassing vma_lookup()/__kvm_faultin_pfn(). The gmem PFN
   is resolved before mmap_read_lock() so the mmu_lock taken for the
   mapping is never held while waiting for mmap_lock, which would
   deadlock against mmu_notifier invalidation (mmu_lock -> mmap_lock).
3. Skip kvm_release_faultin_page() for gmem pages; their lifetime is
   managed by the gmem inode and invalidation notifiers.

Verified: defconfig + CONFIG_KVM_GUEST_MEMFD=y compiles cleanly.

Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>
---
 arch/riscv/kvm/Kconfig |  1 +
 arch/riscv/kvm/mmu.c   | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index ec2cee0a39e0..77121100579f 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -29,6 +29,7 @@ config KVM
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select KVM_MMIO
+	select KVM_GUEST_MEMFD
 	select VIRT_XFER_TO_GUEST_WORK
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index d2a06a54be17..a9d61d0366e2 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -557,6 +557,19 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	/* Setup initial state of output mapping */
 	memset(out_map, 0, sizeof(*out_map));
 
+	if (kvm_slot_has_gmem(memslot)) {
+		int max_order;
+
+		ret = kvm_gmem_get_pfn(kvm, memslot, gfn, &hfn, &page, &max_order);
+		if (ret)
+			return ret;
+
+		vma_pagesize = PAGE_SIZE;
+		writable = true;
+		write_lock(&kvm->mmu_lock);
+		goto map_gstage;
+	}
+
 	if (is_write && logging &&
 	    kvm_riscv_mmu_dirty_log_write_fault_fast(kvm, memslot, gpa, out_map))
 		return 0;
@@ -643,6 +656,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	if (!logging && !is_hugetlb && vma_pagesize == PAGE_SIZE)
 		vma_pagesize = transparent_hugepage_adjust(kvm, memslot, hva, &hfn, &gpa);
 
+map_gstage:
 	if (writable) {
 		mark_page_dirty_in_slot(kvm, memslot, gfn);
 		ret = kvm_riscv_gstage_map_page(&gstage, pcache, gpa, hfn << PAGE_SHIFT,
@@ -658,7 +672,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 		kvm_err("Failed to map in G-stage\n");
 
 out_unlock:
-	kvm_release_faultin_page(kvm, page, ret, writable);
+	if (!kvm_slot_has_gmem(memslot))
+		kvm_release_faultin_page(kvm, page, ret, writable);
 	write_unlock(&kvm->mmu_lock);
 	return ret;
 }
-- 
2.54.0

