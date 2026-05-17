Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A10361641;
	Sun, 17 May 2026 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032287; cv=none; b=Je0kMWrI20AZTCjEMXs1OGqik33oHZHPzS26GYmw7J7JfXi5oS/DnTQVKTeD0EKQ3aHKFHBGRNQC8hHvyju72oaZe0Vq4pRenmHymIQO2KEKGaWKIi+/X2r3FgwEM3LKlpPBgs2RwtphKRY3oVJvZMxX7z1XpMTk8ZCgCXJgoYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032287; c=relaxed/simple;
	bh=vqjXwYpLlPN+Svh0Oey3p87ICSbjWxqO3PUBylIq1UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3jfaFplz+z4wdVHBYFiooMJLIfKMMXkSyxYGeOOJYWTBBFCBCa1gqqSBEzzVqkdrVj6T1GZyvR5vgfvb65hqvKXzYWank6Xww2GPU3By3olb7TW5A3rlVSBVPLQDl2hIvLig9pPPmsW/XIMeBNrCatdSDK3FE7hTHus3CkmoVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ag3HJO3k; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ag3HJO3k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Js
	QLXeUloxPxSDxUurZ8XAjjViIbjwSl2vEzwM1rPDs=; b=Ag3HJO3k8B2qchnUoR
	9HXK3xEF+q/x78VQ12mLVpxXO8uIvXu82vwdwcH84Je4028gRVJ3/vXIkH4HvaMP
	I1qxKZFHcNOBlOgUYLOHkfazAD6ypzCHTyDMvYT3pNapRJsdkDZISK/NYz5pWEnc
	/ccQVlqHy8hFx3GraoNcGFwQc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wA3ylwO4AlqyKW7Bw--.10227S3;
	Sun, 17 May 2026 23:34:41 +0800 (CST)
From: Jinyu Tang <tjytimi@163.com>
To: Anup Patel <apatel@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Jinyu Tang <tjytimi@163.com>
Subject: [PATCH 1/5] KVM: riscv: Rely on common MMU notifier locking
Date: Sun, 17 May 2026 23:34:23 +0800
Message-ID: <20260517153427.94889-2-tjytimi@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517153427.94889-1-tjytimi@163.com>
References: <20260517153427.94889-1-tjytimi@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3ylwO4AlqyKW7Bw--.10227S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4fGw1xAFWxtw1DAF4UCFg_yoW8Arykpr
	WjkrZ0krWrXr4DuFyUt3WkZryj9w4vgFn7X34rJaykJrs0q3s3Ga4vqas2gF15Jrs5XFZx
	ZF40q3WrCry5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piaFAZUUUUU=
X-CM-SenderInfo: xwm13xlpl6il2tof0z/xtbC0BEZkWoJ4BGw1wAA38

The common KVM invalidation paths call kvm_unmap_gfn_range() with
mmu_lock already held for write.

For the standard MMU notifier path, the call chain is:

  kvm_mmu_notifier_invalidate_range_start()
    kvm_handle_hva_range()
      kvm_unmap_gfn_range()

kvm_mmu_notifier_invalidate_range_start() leaves range.lockless clear.
kvm_handle_hva_range() therefore takes KVM_MMU_LOCK(kvm) before invoking
the handler.

The guest_memfd path has the same locking contract:

  __kvm_gmem_invalidate_begin()
    kvm_mmu_unmap_gfn_range()
      kvm_unmap_gfn_range()

__kvm_gmem_invalidate_begin() explicitly takes KVM_MMU_LOCK(kvm) before
calling kvm_mmu_unmap_gfn_range().

So remove the local trylock and make the common locking contract explicit 
with lockdep_assert_held_write() like x86.

Signed-off-by: Jinyu Tang <tjytimi@163.com>
---
 arch/riscv/kvm/mmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 2d3def024..0197e41fc 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -230,18 +230,16 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	struct kvm_gstage gstage;
-	bool mmu_locked;
 
 	if (!kvm->arch.pgd)
 		return false;
 
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
 	kvm_riscv_gstage_init(&gstage, kvm);
-	mmu_locked = spin_trylock(&kvm->mmu_lock);
 	kvm_riscv_gstage_unmap_range(&gstage, range->start << PAGE_SHIFT,
 				     (range->end - range->start) << PAGE_SHIFT,
 				     range->may_block);
-	if (mmu_locked)
-		spin_unlock(&kvm->mmu_lock);
 	return false;
 }
 
-- 
2.43.0

