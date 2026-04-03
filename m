Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2728C2BF;
	Fri,  3 Apr 2026 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230234; cv=none; b=WJMA6eo8NAzrJVYv9gpHztRcKuc317fi7+fyzjba7UIWEWKz2kqA9jk+D8Y1jVxvIx4UudAPlus71qFluOX7nDwDHZJJXOAzdhV4+f1XSbEF/DXMFo58hkrl84PaRc3Eh/5bw70QGBIbLZxCL5ARvmhtGw5jEtGvWZ/U0sqr838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230234; c=relaxed/simple;
	bh=1JN9y2YP149Xaa8TAhsR1KGMxhicd7F0xJEbKmyzfVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bnLi0g1ueabaNju9IauLCUZwluLPLbD2yxVRK+96hdzJBC/9OfDQ/NFWrLtFauJqzu/lv/Ju8VJYSpjYjC85Bqh+x9rN+8+iiPYzcnFLgiTucz2lAi4pvUKTkvtzQC075uW9Xt7a7OxJlPBegZWpQt/dOec09eYdB0y4QtQ2Jlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pukBa6MR; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pukBa6MR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775230229; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vAXnuXYy5CVxib+kdtLGkhTwGblq2YVJ173NjMXO3mM=;
	b=pukBa6MR1g4xP7IoEZUsrNMg6Wn8aSRXXhP6V7liMI04Y0wsFRU74FnG+oQhOHexhyDyA5ZrTlchWob2fChjy1GiWoBctaqhXxxLiO7KuOMKHZgik7ixkJMfeaY8pd2aRT61nslhYhUvc5TC3Bfjr/TSfXg4U37lBCmfGQ/pT6k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X0KbxUp_1775230226;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X0KbxUp_1775230226 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Apr 2026 23:30:27 +0800
From: fangyu.yu@linux.alibaba.com
To: pbonzini@redhat.com,
	corbet@lwn.net,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	skhan@linuxfoundation.org
Cc: guoren@kernel.org,
	radim.krcmar@oss.qualcomm.com,
	andrew.jones@oss.qualcomm.com,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v8 3/3] RISC-V: KVM: Reuse KVM_CAP_VM_GPA_BITS to select HGATP.MODE
Date: Fri,  3 Apr 2026 23:30:18 +0800
Message-Id: <20260403153019.9916-4-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260403153019.9916-1-fangyu.yu@linux.alibaba.com>
References: <20260403153019.9916-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Reuse KVM_CAP_VM_GPA_BITS to advertise and select the effective
G-stage GPA width for a VM.

KVM_CHECK_EXTENSION(KVM_CAP_VM_GPA_BITS) returns the effective GPA
bits for a VM, KVM_ENABLE_CAP(KVM_CAP_VM_GPA_BITS) allows userspace
to downsize the effective GPA width by selecting a smaller G-stage
page table format:
  - gpa_bits <= 41 selects Sv39x4 (pgd_levels=3)
  - gpa_bits <= 50 selects Sv48x4 (pgd_levels=4)
  - gpa_bits <= 59 selects Sv57x4 (pgd_levels=5)

Reject the request with -EINVAL for unsupported values and with -EBUSY
if vCPUs have been created or any memslot is populated.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kvm/vm.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index fb7c4e07961f..a9f083feeb76 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -214,12 +214,52 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 
 int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 {
+	if (cap->flags)
+		return -EINVAL;
+
 	switch (cap->cap) {
 	case KVM_CAP_RISCV_MP_STATE_RESET:
-		if (cap->flags)
-			return -EINVAL;
 		kvm->arch.mp_state_reset = true;
 		return 0;
+	case KVM_CAP_VM_GPA_BITS: {
+		unsigned long gpa_bits = cap->args[0];
+		unsigned long new_levels;
+		int r = 0;
+
+		/* Decide target pgd levels from requested gpa_bits */
+#ifdef CONFIG_64BIT
+		if (gpa_bits <= 41)
+			new_levels = 3;        /* Sv39x4 */
+		else if (gpa_bits <= 50)
+			new_levels = 4;        /* Sv48x4 */
+		else if (gpa_bits <= 59)
+			new_levels = 5;        /* Sv57x4 */
+		else
+			return -EINVAL;
+#else
+		/* 32-bit: only Sv32x4*/
+		if (gpa_bits <= 34)
+			new_levels = 2;
+		else
+			return -EINVAL;
+#endif
+		if (new_levels > kvm_riscv_gstage_max_pgd_levels)
+			return -EINVAL;
+
+		/* Follow KVM's lock ordering: kvm->lock -> kvm->slots_lock. */
+		mutex_lock(&kvm->lock);
+		mutex_lock(&kvm->slots_lock);
+
+		if (kvm->created_vcpus || !kvm_are_all_memslots_empty(kvm))
+			r = -EBUSY;
+		else
+			kvm->arch.pgd_levels = new_levels;
+
+		mutex_unlock(&kvm->slots_lock);
+		mutex_unlock(&kvm->lock);
+
+		return r;
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.50.1

