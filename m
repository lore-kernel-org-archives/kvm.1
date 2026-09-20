Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4446F41DE01;
	Sun, 20 Sep 2026 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789909928; cv=none; b=mcWsfcZT2zm/zWk3OmfksB8F25EckTAxrh30v2GVgsN2eehEr+MBj8vWGHTqc+5azyYHwFXAt5ThkbI0SgNo31ACp6TWLqWtbYoJUmXgBGq0Zw7OxR99IVeoqh+hk/3WhYJm8ovnqYdy0Dv6bD4fcOlbqacHIke6BtsNNFh8HEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789909928; c=relaxed/simple;
	bh=CvelwzH7SVtv5hSxexSzLI2O7jBkoaAFZA67zELhfO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNIzRMJ+SnJnE4ar7nFQrESpTRZ3V5mI/UycTnZv+79Z15YUdXvBWx3s/41olpP6oP09tSHOFWSJOsR8z+I/VszKzD2F8O+31ra7okZuRfP8TBTZc/Elfo2lrdAYTWksDotppwMkY7aD8FoSCWDAcFosdue/IMiBqgC4J1nU4+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jKf1EJuE; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jKf1EJuE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=fx
	xetwQM1IVZM6P54FHuhflyKkC0LojiwyGoiT/nK4Q=; b=jKf1EJuE+KZKaKmcXE
	poYBlGoD53ld9BzWypVlatyygE7j/FUZGXQja3WXLa9jacTBtwZ2eiXuGhx9H1gc
	hQod2ArXlYBJpmGg+a0hfoxuadP2l0jDKZvT04ZpIcS7nFtVaDher80QEs7qVSuj
	vpWQAyrstZpkkT0ncESG+/+BM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3v1cl269qj9S_AQ--.59232S2;
	Sun, 20 Sep 2026 21:09:58 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: anup@brainfault.org
Cc: Pengpeng Hou <hppiscas@163.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atish.patra@linux.dev>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Guo Ren <guoren@kernel.org>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Nutty Liu <nutty.liu@hotmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>
Subject: [PATCH v2 2/2] RISC-V: KVM: Disallow GPA-width changes after AIA init
Date: Sun, 20 Sep 2026 21:09:55 +0800
Message-ID: <fbe7337f6989994ad4dbc4dc03a67e8ebfa61f8d.1789872556.git.hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1789872556.git.hppiscas@163.com>
References: <cover.1789872556.git.hppiscas@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3v1cl269qj9S_AQ--.59232S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr17try7WF45CrWUAF1fWFg_yoW8WrW3p3
	9rGa95Zr95Wr17CrW0yws7Zr10vws5Gr1ayFyYvF43WFs0vFy0vanYyr47Jr1DAan29FWI
	vF1Yy34Fvrs5CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zil4i5UUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7QaGT2qv2yYXHwAA3S

KVM_ENABLE_CAP(KVM_CAP_VM_GPA_BITS) allows userspace to reduce the
stage-2 GPA width while a VM has no vCPUs or memory slots.

AIA initialization can complete with an APLIC and no vCPUs or memory
slots. The APLIC MMIO device has then been registered, but the existing
checks still allow userspace to shrink the GPA width below its address.

Reject GPA-width changes after AIA initialization. Both paths hold
kvm->lock, serializing the width change with AIA initialization.

The issue was found by our static-analysis tool.

Fixes: 7263b4fdb0b2 ("RISC-V: KVM: Reuse KVM_CAP_VM_GPA_BITS to select HGATP.MODE")
Reviewed-by: Anup Patel <anup@brainfault.org>
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v1: https://lore.kernel.org/r/4852f3b8985c353811fa065e4701d76dc9a7f086.1786512671.git.pengpeng@iscas.ac.cn/
- No change to the code; retain Anup's Reviewed-by.
- Rebase and clarify the locking description.

 arch/riscv/kvm/vm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index a9f083f..66edfaa 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -250,7 +250,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		mutex_lock(&kvm->lock);
 		mutex_lock(&kvm->slots_lock);
 
-		if (kvm->created_vcpus || !kvm_are_all_memslots_empty(kvm))
+		if (kvm->created_vcpus || !kvm_are_all_memslots_empty(kvm) ||
+		    kvm_riscv_aia_initialized(kvm))
 			r = -EBUSY;
 		else
 			kvm->arch.pgd_levels = new_levels;

