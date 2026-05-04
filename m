Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D353876BF
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934573; cv=none; b=nqQenG4B3daWLW8RprjpucqGCbKJjYIcD6vq98u7Oh+txOFp6RCqlJ/jm4nYQRO+sH70voFvizs0QmO3s8ppo7kVfSvdKI+mCdWF2NUh79tVsiRf2YmLOj39UlG0UkHuUlT3ruAcz9vUfUpkXb1Dp/HzNwlHdnnOYsTIq+AZKxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934573; c=relaxed/simple;
	bh=InGnsmMXyUKk5UR+us+b7DjwbtH0DDKd3A8oEQN+NKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CIVL1NluEqMoeVAOE/Pf3f9jPMrVqww/tEDrNDXwsRnXghj42niTsd54vB7XshKj7Jy3LY9NI1e3bmJKf1OaqdDkF36+k9POYL529clpkxucH9fjewuvxP9uIBGNifvyB31AmEeUEH9cQBrCkmpQXkcv6cxRN4eUVb1mR8cnPqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIb/YPc4; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIb/YPc4"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso45691365ad.1
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777934569; x=1778539369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vC+QCMBPXdQWF+dL8GXMYzl+k9Np64sK2GTCcOrjhPY=;
        b=vIb/YPc4eQY1R+pTc4p70eHlPon7UkycR+sBD/1Q2Ite094bGPk1I+2seC9L6++opt
         PZJO0MA916CAcPQ2PjbHgCz9VWeFAsHBw/itVy8JQkelSTcZBVg0W8j7q4JvVCVzCBQc
         IZ+nevL4B8wX/dGI3A4PdW+Sd/e5eZGzr+M/IgO0cYuj1GysDg8GIY6dQkvEVZyF34aI
         9XxIZ6D/oNRiX4zQ/LFUM8oGcRGdESwx7v8aSL2zoFNEsjPPtvfHUhnr543oFvT8nB5m
         R2se9oC+VoaRmckyk6M+86xtJXoLyKwp9Gfwz6HmWcWJI27Ri6NCGg3F9mM9lAXg8vyV
         m56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934569; x=1778539369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vC+QCMBPXdQWF+dL8GXMYzl+k9Np64sK2GTCcOrjhPY=;
        b=PChs6anT1Dw5L5cvnXetBPKjKTQ+z+jZ9TMHP5jicllClBXC5mCPZOJufaQEuaWlLv
         vQTY0vcbbTks648rzLJAmwKCqSruwhgsGC0JHEs5A8GgOKYiJKGbUGrxpmtDgBxOE5W6
         UqEDcj0q8fQSb45hKbSXNoRiqx7rCrVWn3iep4r+IOV8SOlcPX+k2vdXicwXurbk8Vbe
         swJfpixzTUh6AIlbouoBdo2C8RxJV+yJ0i9fp1JPVBurtMOVQCZb93jI8aFSzqUx22bZ
         5sIgtNV8IQxAXSnzmXRUmgUxam0W0gTX/2ljtUf7Vj/kioyqIE3dNoiTWgLJL+abhO3D
         Irvw==
X-Forwarded-Encrypted: i=1; AFNElJ8Ev6PRdkOOgyuaqMBRBHiW7cgjYFGEvOU9carvaR8UBI1BO+c/RsoVV2kCW7T+LqnYso8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5gJACB0OjUSwbM7mxYJ4JVpBzo+r3VLcwjn3UTHCyyAyFQImf
	buK3A2SbStVaQ13oJal/rYlY73ii40fUCeH69TuITdwwwIbeN/t2L0+KsxZCk+g8pEk3qJmSO4P
	mnh+TGFzZoE0kHjJIuQZ1Tg==
X-Received: from plmx11.prod.google.com ([2002:a17:902:fe8b:b0:2ae:3bca:37a5])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4b0d:b0:2b0:6d33:e7c0 with SMTP id d9443c01a7336-2ba535e2df5mr4309355ad.1.1777934568708;
 Mon, 04 May 2026 15:42:48 -0700 (PDT)
Date: Mon,  4 May 2026 22:42:11 +0000
In-Reply-To: <20260504224213.1049426-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504224213.1049426-1-jthoughton@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504224213.1049426-5-jthoughton@google.com>
Subject: [PATCH 4/5] KVM: Hold MMU lock exclusively when calling kvm_arch_flush_shadow_all()
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Sean Christopherson <seanjc@google.com>, Gavin Shan <gshan@redhat.com>, 
	Shaoqin Huang <shahuang@redhat.com>, Ricardo Koller <ricarkol@google.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, James Hogan <jhogan@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

All architectures that non-trivially implement this function grab the
KVM MMU lock exclusively to prevent things like double-freeing of page
table entries and caches. Do so generically to somewhat simplify the
architecture-specific logic.

Without this change, it is possible for kvm_arch_flush_shadow_all() to
be called on the same `kvm` at the same time: if the `kvm`'s mm is
destroyed (exit_mm()) at the same time to the final reference to the
`kvm` is dropped.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/arm64/kvm/nested.c  | 2 +-
 arch/loongarch/kvm/mmu.c | 4 +++-
 arch/mips/kvm/mips.c     | 2 +-
 arch/riscv/kvm/mmu.c     | 4 ++--
 arch/riscv/kvm/vm.c      | 2 ++
 arch/x86/kvm/mmu/mmu.c   | 4 +---
 virt/kvm/kvm_main.c      | 3 +++
 7 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 977598bff5e6..ba2e6c98bd45 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1190,7 +1190,7 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
 {
 	int i;
 
-	guard(write_lock)(&kvm->mmu_lock);
+	lockdep_assert_held_write(&kvm->mmu_lock);
 
 	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
 		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index 5dbce9b18e1c..120001da26e4 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -486,7 +486,9 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 
 void kvm_arch_flush_shadow_all(struct kvm *kvm)
 {
-	kvm_flush_range(kvm, 0, kvm->arch.gpa_size >> PAGE_SHIFT, 1);
+	lockdep_assert_held(&kvm->mmu_lock);
+
+	kvm_flush_range(kvm, 0, kvm->arch.gpa_size >> PAGE_SHIFT, 0);
 }
 
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 463b6c4aa62c..4ad9e21a3321 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -180,7 +180,7 @@ long kvm_arch_dev_ioctl(struct file *filp, unsigned int ioctl,
 
 void kvm_arch_flush_shadow_all(struct kvm *kvm)
 {
-	guard(spinlock)(&kvm->mmu_lock);
+	lockdep_assert_held(&kvm->mmu_lock);
 
 	/* Flush whole GPA */
 	kvm_mips_flush_gpa_pt(kvm, 0, ~0);
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 2d3def024270..c1b9333f17eb 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -558,7 +558,8 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
 	struct kvm_gstage gstage;
 	void *pgd = NULL;
 
-	spin_lock(&kvm->mmu_lock);
+	lockdep_assert_held(&kvm->mmu_lock);
+
 	if (kvm->arch.pgd) {
 		kvm_riscv_gstage_init(&gstage, kvm);
 		kvm_riscv_gstage_unmap_range(&gstage, 0UL,
@@ -568,7 +569,6 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
 		kvm->arch.pgd_phys = 0;
 		kvm->arch.pgd_levels = 0;
 	}
-	spin_unlock(&kvm->mmu_lock);
 
 	if (pgd)
 		free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage_pgd_size));
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index a9f083feeb76..f704a64bfc48 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -38,7 +38,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	r = kvm_riscv_gstage_vmid_init(kvm);
 	if (r) {
+		spin_lock(&kvm->mmu_lock);
 		kvm_riscv_mmu_free_pgd(kvm);
+		spin_unlock(&kvm->mmu_lock);
 		return r;
 	}
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 892246204435..6e6f94046b3f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7352,7 +7352,7 @@ static void kvm_mmu_zap_all(struct kvm *kvm)
 	LIST_HEAD(invalid_list);
 	int ign;
 
-	write_lock(&kvm->mmu_lock);
+	lockdep_assert_held_write(&kvm->mmu_lock);
 restart:
 	list_for_each_entry_safe(sp, node, &kvm->arch.active_mmu_pages, link) {
 		if (WARN_ON_ONCE(sp->role.invalid))
@@ -7367,8 +7367,6 @@ static void kvm_mmu_zap_all(struct kvm *kvm)
 
 	if (tdp_mmu_enabled)
 		kvm_tdp_mmu_zap_all(kvm);
-
-	write_unlock(&kvm->mmu_lock);
 }
 
 void kvm_arch_flush_shadow_all(struct kvm *kvm)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 89489996fbc1..f5affd3bfda8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -340,7 +340,10 @@ void kvm_flush_remote_tlbs_memslot(struct kvm *kvm,
 
 static void kvm_flush_shadow_all(struct kvm *kvm)
 {
+	KVM_MMU_LOCK(kvm);
 	kvm_arch_flush_shadow_all(kvm);
+	KVM_MMU_UNLOCK(kvm);
+
 	kvm_arch_guest_memory_reclaimed(kvm);
 }
 
-- 
2.54.0.545.g6539524ca2-goog

