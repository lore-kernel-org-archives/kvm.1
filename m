Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F71346AED
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184089; cv=none; b=njCP1XjGO7w4J/e4bJcG0Ftp69pQgtGVaaLfjRsQQhlNbeD6ygSlVXaer0AHe2unIj4D07xn/mipWwheCZEGubX31fEcl8/j4NBcpQRj2jDRJlzPR4B4KaA6/6woDijFslhK4C4nq2fJFlbOwtp6FqJgfCVqFLvwkkwn/Yfy1Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184089; c=relaxed/simple;
	bh=/4BU8arNUNZfouOCB+UODh3cg8IoJjaLIwqVJU7YozM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UOP5jbLMJAAnqzp0aMWFbarpwH9G4ZaIjpqOwCavXOEokvqvXr5VwdHIu9zqfDAsfYyoh8VRVqn4oiIuj9LIyNECTOtBbWiuJDPDFfc+x7kZcN6vT63+qimoOCrMafhAKSQaDOfpIG9E6VPmOgzbudqXp5SEFcW0txzcA9zvsFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4SXdA98; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4SXdA98"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-845c92bc464so2852449b3a.2
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 23:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784184087; x=1784788887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rjQuW5mlyWifimpzaOD1tTXEImiFatMtZy5sO/KVJYY=;
        b=V4SXdA982OuC/b4PycWpoWp1r9lwvcKY3qjTDuilqIWQfblfVs+qRX+hsMJAkYnfei
         YP8yxxAoiOO+Ci5NvNcmErHfC+rSs0Ys/a02hrarGAVRSLyiHG3PNlEB2F+bJywUusBg
         oKC9wWnZpf2zr7Feb+NwzxUpDt7YGbD3JQvmfKF9oZahUTdlPaZ9LlJnPEDsHUDpPe8Y
         02zZmWhKxTA4Zgh47X01RI03Jif8RzIyE2zWAWBaINdQMqcLhF+ovKeWyP2htwaHmMRY
         ns0IOLcrYBnB9BvOLRD8fhb1OFbG1UrQc32mdatHWGamrlZmyy0ojb6UIUWa52uTa0He
         dExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784184087; x=1784788887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rjQuW5mlyWifimpzaOD1tTXEImiFatMtZy5sO/KVJYY=;
        b=MtXUqwFnhbAmQHx+gBdJx2+GG66QGJl31cUILfZhmMVKkUtEO5aS9s5RcuYD4zA036
         C96LNhATZVYOxbziovCs2LzcFgxRx0xUDnUbeDxXOHFzZ+JLCBYKo3RwTXC1hPV22zVv
         NX3Fk+gpn7qUPYP2UxFuyFjp8LOocI9RqyylljjzAQqm0e3EIrmoelhGPeKpE2kCE1Li
         3BA+t9Xc8dy/PK7Ph9TiscdQ4N76B2klWnxaXnNLBwDtBq/ngbb+3fObgk/HEWu2mNiF
         PakrZ+tc45t+YWX7EIuI9eRZSW2n1EtT0wqgx8FTsAvUFzQSvXIcX609Cj4Ued2v0fi5
         sB6Q==
X-Forwarded-Encrypted: i=1; AHgh+RqKudMmujBqdRBAb8FD3L6CkD3pRmMm8y649KL+VaBgQXvUNx/0PDPz9Xvhsjqsxy2AbI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwqHLdwCdWDMpagwEwbB2iUxaF0kab+5lnmZ5RPi4xdWVWgJO2
	jV11iakGjG6o7NFeR8iSJExZPoftiL5Tk0FPHNxbs5e78p+RO7u20XeU
X-Gm-Gg: AfdE7cnuSuoAxCzAZCkcRK2OvmESHQzU+5+bS+38ogvi4UOeHqMK0YoOJDdK7qmumHr
	waXJyZtWI56/sUCIwkonkQhC5pNcc7buMVF9FDnmXTbGhYTpCiRN+w2K01t+xNY9TT2grMGhtvI
	uT8aqOnMODoNP4spA1fUCvTWllxEVPfYw64Afg+pIwuESjmY7wOC3IfdqH9nET0kE53QbSZoUop
	BsUCNisRbiw7Rt7WlCXmryunXyVL5DLWD9hPKymia54UeaHJz9fV3BGWqoiyjqgqgbm1BgFOTYw
	wZaknOWNNAHEBMZJo2SsqcRUQHpEQlNAPzmVrBf5GqVkzYx5/FbVwZ2U4NK9HxHeARDQjdOTMc6
	S4P8KK9tCcqN1QIeoBOXlQK2QfPaJMBznggGTsXww+nm+T1/QqmImtRPqs12q6qaLmcnKzyquCe
	0InxDLEAsSRgjKhun0DeNLDsXuLdWEfBs=
X-Received: by 2002:a05:6a00:2991:b0:845:dfef:75b8 with SMTP id d2e1a72fcca58-848895db49fmr18808064b3a.15.1784184086792;
        Wed, 15 Jul 2026 23:41:26 -0700 (PDT)
Received: from cyh-System-Product-Name.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258ff402asm1254719a12.22.2026.07.15.23.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 23:41:26 -0700 (PDT)
From: yhchen312@gmail.com
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Yuhang.chen" <yhchen312@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH] RISC-V: KVM: Account VM-scoped allocations to the VM cgroup
Date: Thu, 16 Jul 2026 14:41:12 +0800
Message-Id: <20260716064112.2387938-1-yhchen312@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yuhang.chen" <yhchen312@gmail.com>

Charge the per-VM and per-vCPU allocations (stage-2 PGD, APLIC state,
IMSIC context, vector context, FWFT config, PMU snapshot) to the
allocating process's memory cgroup via GFP_KERNEL_ACCOUNT / __GFP_ACCOUNT.
Per-CPU module-init allocations and transient scratch buffers are left
unaccounted.

Measured results (KVM guest run in a memory cgroup; VM cgroup
memory.current after guest boot):

  VM cgroup memory.current    1044480 bytes

Assisted-by: YuanSheng:deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Yuhang.chen <yhchen312@gmail.com>
---
 arch/riscv/kvm/aia_aplic.c     | 3 ++-
 arch/riscv/kvm/aia_imsic.c     | 4 ++--
 arch/riscv/kvm/mmu.c           | 4 ++--
 arch/riscv/kvm/vcpu_pmu.c      | 2 +-
 arch/riscv/kvm/vcpu_sbi_fwft.c | 2 +-
 arch/riscv/kvm/vcpu_vector.c   | 4 ++--
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kvm/aia_aplic.c b/arch/riscv/kvm/aia_aplic.c
index 748107c347d9..be902ea6480b 100644
--- a/arch/riscv/kvm/aia_aplic.c
+++ b/arch/riscv/kvm/aia_aplic.c
@@ -581,7 +581,8 @@ int kvm_riscv_aia_aplic_init(struct kvm *kvm)
 		return 0;
 
 	/* Allocate APLIC global state */
-	aplic = kzalloc_flex(*aplic, irqs, kvm->arch.aia.nr_sources + 1);
+	aplic = kzalloc_flex(*aplic, irqs, kvm->arch.aia.nr_sources + 1,
+			     GFP_KERNEL_ACCOUNT);
 	if (!aplic)
 		return -ENOMEM;
 	kvm->arch.aia.aplic_state = aplic;
diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index d38f5de0834c..507d82e5bc88 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -1108,7 +1108,7 @@ int kvm_riscv_vcpu_aia_imsic_init(struct kvm_vcpu *vcpu)
 		return -EINVAL;
 
 	/* Allocate IMSIC context */
-	imsic = kzalloc_obj(*imsic);
+	imsic = kzalloc_obj(*imsic, GFP_KERNEL_ACCOUNT);
 	if (!imsic)
 		return -ENOMEM;
 	vcpu->arch.aia_context.imsic_state = imsic;
@@ -1121,7 +1121,7 @@ int kvm_riscv_vcpu_aia_imsic_init(struct kvm_vcpu *vcpu)
 	imsic->vsfile_hgei = imsic->vsfile_cpu = -1;
 
 	/* Setup IMSIC SW-file */
-	swfile_page = alloc_pages(GFP_KERNEL | __GFP_ZERO,
+	swfile_page = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO,
 				  get_order(sizeof(*imsic->swfile)));
 	if (!swfile_page) {
 		ret = -ENOMEM;
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 082f9b261733..9b1d809daf2c 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -669,8 +669,8 @@ int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
 		return -EINVAL;
 	}
 
-	pgd_page = alloc_pages(GFP_KERNEL | __GFP_ZERO,
-				get_order(kvm_riscv_gstage_pgd_size));
+	pgd_page = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO,
+			       get_order(kvm_riscv_gstage_pgd_size));
 	if (!pgd_page)
 		return -ENOMEM;
 	kvm->arch.pgd = page_to_virt(pgd_page);
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index bb46dcbfb24d..e5018784779d 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -452,7 +452,7 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
 		}
 	}
 
-	kvpmu->sdata = kzalloc(snapshot_area_size, GFP_ATOMIC);
+	kvpmu->sdata = kzalloc(snapshot_area_size, GFP_ATOMIC | __GFP_ACCOUNT);
 	if (!kvpmu->sdata) {
 		sbiret = SBI_ERR_FAILURE;
 		goto out;
diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index ab39ac464ffd..4984d3e54e23 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -377,7 +377,7 @@ static int kvm_sbi_ext_fwft_init(struct kvm_vcpu *vcpu)
 	int i;
 
 	fwft->configs = kzalloc_objs(struct kvm_sbi_fwft_config,
-				     ARRAY_SIZE(features));
+				     ARRAY_SIZE(features), GFP_KERNEL_ACCOUNT);
 	if (!fwft->configs)
 		return -ENOMEM;
 
diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index 62d2fb77bb9b..d748e7d825e1 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -76,11 +76,11 @@ void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx)
 
 int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.guest_context.vector.datap = kzalloc(riscv_v_vsize, GFP_KERNEL);
+	vcpu->arch.guest_context.vector.datap = kzalloc(riscv_v_vsize, GFP_KERNEL_ACCOUNT);
 	if (!vcpu->arch.guest_context.vector.datap)
 		return -ENOMEM;
 
-	vcpu->arch.host_context.vector.datap = kzalloc(riscv_v_vsize, GFP_KERNEL);
+	vcpu->arch.host_context.vector.datap = kzalloc(riscv_v_vsize, GFP_KERNEL_ACCOUNT);
 	if (!vcpu->arch.host_context.vector.datap) {
 		kfree(vcpu->arch.guest_context.vector.datap);
 		vcpu->arch.guest_context.vector.datap = NULL;
-- 
2.34.1

