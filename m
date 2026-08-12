Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4C37E5C1;
	Wed, 12 Aug 2026 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513195; cv=none; b=R+9uL2bPV1j+L69z/MKxG/iQ47AtnQJx3y3vYnAQk3C75tx6etvlPbqhmI2jG9WRo6q4dzRQ4lS/tMm1mvVzHTQSo+52NpaKGW8qXBJwDMrNuJmH/TxD394UJHz6chat0lq91/PtDipp0s9XRPCbvgDundyYYgeipK52//4Ag5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513195; c=relaxed/simple;
	bh=Jr4Z6sgLlVb9caSScKKMkmnG+uFQNhv8VG+KbHjSXYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajCTNx8fXE04xLvePvSNT8JbJ3B+EDZ8I7KDiSjjNkjvZjftSw9GnQxOn3wmbWdoOBtQ6JBFxVaw0Wzuc4owPg5cDua+BVcwqipnmmumUD0kMMBEfTgp9cT7l4jtTBaGvyE22P2L7Oq3oXMxDyUY0CdNQRXFMZEw7AzR+8OFHuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-05 (Coremail) with SMTP id zQCowADnVD8UB3xqybQxBQ--.41533S4;
	Wed, 12 Aug 2026 13:39:36 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Guo Ren <guoren@kernel.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] RISC-V: KVM: Disallow GPA-width changes after AIA init
Date: Wed, 12 Aug 2026 13:39:32 +0800
Message-ID: <4852f3b8985c353811fa065e4701d76dc9a7f086.1786512671.git.pengpeng@iscas.ac.cn>
In-Reply-To: <cover.1786512671.git.pengpeng@iscas.ac.cn>
References: <cover.1786512671.git.pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnVD8UB3xqybQxBQ--.41533S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1xKFWxWF17tr18XF18Zrb_yoW8Gr4xpr
	ZrWa93Zr95WrnrC3yUAwn7Zr409an5ursIyFyjvFW3Wrs0yry0v3ZYkw47Jr17XF4F9FWa
	vF1Yy34rZr1FkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxw
	CY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
	AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
	A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
	0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

KVM_ENABLE_CAP(KVM_CAP_VM_GPA_BITS) allows userspace to reduce the
stage-2 GPA width while a VM has no vCPUs or memory slots.

AIA initialization can still complete with an APLIC and no vCPUs or
memory slots.  In that state, the APLIC MMIO device has already been
registered, but the existing checks allow userspace to shrink the GPA
width below its address.

Reject GPA-width changes after AIA initialization.  Both paths hold
kvm->lock, so the check also closes the race between final AIA address
validation and publication.

Fixes: 7263b4fdb0b2 ("RISC-V: KVM: Reuse KVM_CAP_VM_GPA_BITS to select HGATP.MODE")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/riscv/kvm/vm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index a9f083feeb76..66edfaa86243 100644
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
-- 
2.50.1 (Apple Git-155)

