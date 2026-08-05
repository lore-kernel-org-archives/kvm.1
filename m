Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8511D43FD04;
	Wed,  5 Aug 2026 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927841; cv=none; b=edPvV/gVMDjC61YM++pwPLFpx7SDHC6tv7dGmzA9eXFUYCVGg0uFwsUXXkKMu5ZGHGQFthx5HLw/pcT3rS5FiVDf7G6DiSqxTEK8gMcssqIK9npOCQTqHMwJfArP0Vijym5O94xRw7ghVt+E9TmPNpRaccUbRzN/8C1YOQKFKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927841; c=relaxed/simple;
	bh=D9VOq56B9kZmsm/OCIMpL/keYWy0pJvDDZkuomsAm3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1s95ooSHlrJEUr+ZXfITLQQu6gw3bg7PUHrgWd9EBdGa0G1y10x6qLcIZ68etnBnWGq+ToiCMoqreDfdhJraJr1dWgvzej8GycknXBeibSbhF0LPehJCEAdrv7dlzA1Dez6GAZUP/HmnswMhF08mGQX3kHE8C+2ZJxSTsCoK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eva/5TAa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eva/5TAa"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6854120B716C;
	Wed,  5 Aug 2026 04:03:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6854120B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927819;
	bh=KADTfjk6xMNFkykpB6ZFJP7LLPsxtzvPwQF0sjffH+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eva/5TAa9sagOk/0+z0Q89BEuXl0wyBzL4Le9cVirI9YYNj5FHHoLGc6AhPXOx+cb
	 Luuou3TmfgJIIqTkGrg8AHevoxP2TCNEI5grvaKVP9JzvGteqn798i+O+p+7RRWQYb
	 QWIvok70Cjz2SP5mUqsuA/SnHNDBsiwU6t0J48Pg=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 19/42] Merge branch 'master' into vm-planes
Date: Wed,  5 Aug 2026 04:03:01 -0700
Message-ID: <20260805110324.25067-20-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 arch/x86/kvm/svm/svm.c | 2 +-
 arch/x86/kvm/x86.c     | 2 +-
 kernel/kexec_file.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ce242e86c5ea..bc281fbc54c2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3240,7 +3240,7 @@ static int interrupt_window_interception(struct kvm_vcpu *vcpu)
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	svm_clear_vintr(to_svm(vcpu));
 
-	++vcpu->stat.irq_window_exits;
+	++vcpu->stat->irq_window_exits;
 	return 1;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4b99016fe536..d4210053e6b8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11129,7 +11129,7 @@ void kvm_inc_or_dec_irq_window_inhibit(struct kvm *kvm, bool inc)
 	 */
 	guard(rwsem_write)(&kvm->arch.apicv_update_lock);
 	if (atomic_add_return(add, &kvm->arch.apicv_nr_irq_window_req) == inc)
-		__kvm_set_or_clear_apicv_inhibit(kvm, APICV_INHIBIT_REASON_IRQWIN, inc);
+		__kvm_set_or_clear_apicv_inhibit(kvm->planes[0], APICV_INHIBIT_REASON_IRQWIN, inc);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_inc_or_dec_irq_window_inhibit);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 81cf454ab516..da44bac7df74 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -259,7 +259,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 					 image->kernel_buf_len,
 					 NULL, sig_ok);
 		if (ret) {
-			pr_warn("vbs: kexec kernel rejected by secure kernel (%d)\n", ret);
+			pr_warn("vbs: kexec kernel rejected by secure kernel (%zd)\n", ret);
 			goto out;
 		}
 	}
-- 
2.55.0

