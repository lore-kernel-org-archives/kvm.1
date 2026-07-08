Received: from out28-131.mail.aliyun.com (out28-131.mail.aliyun.com [115.124.28.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EF437EFE6
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518100; cv=none; b=JiQuIvLKSrf+4eDzw7WdX7h9o8wMzCILwdc2YWNakB++dke65KgY0rRrZoR7P9OigHjwtYjs5JAuV1lRey77WsSp3XsiMaG+/KOWKfNp5xGYQqS+Rr/8tmEmiW9fGILdA5p5CIWigiUqaxJ2Zt+H3z+PNUPPlXS6QpFZXVCJg38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518100; c=relaxed/simple;
	bh=aNyPmP++pQqtAuS55yBRnVe0KwBArFB0DS08rBZ0lVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0PtulRxcjRSFI5+B2czJ4mkOxwlbEJBPt+czWoHHgNqNkmU+Ggs27CnGxL14vH+I1LraRx/3JBegmvYrGDFIfqXu2+1mJUEAFLxauNgT3kk6TGxkk3ZoCIhegj+D9Jl7+hLt3QTcdyDxbjf46HrFJ1DJtPegzW5mm3btiJDk5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1664336|-1;BR=01201311R211S68rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0143639-6.15022e-05-0.985575;FP=5475021831384483071|2|1|2|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=jerry.lyu@open-hieco.net;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.iGQHCg-_1783518092;
Received: from localhost(mailfrom:jerry.lyu@open-hieco.net fp:SMTPD_---.iGQHCg-_1783518092 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 08 Jul 2026 21:41:33 +0800
From: Jerry Lyu <jerry.lyu@open-hieco.net>
To: seanjc@google.com,
	pbonzini@redhat.com,
	joerg.roedel@amd.com
Cc: kvm@vger.kernel.org,
	Jerry Lyu <jerry.lyu@open-hieco.net>
Subject: [PATCH] KVM: SVM: Do not warn on IGNNE MSR write
Date: Wed,  8 Jul 2026 21:41:01 +0800
Message-ID: <20260708134101.1073574-1-jerry.lyu@open-hieco.net>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Booting windows server 2025 on top of Linux KVM results in host kernel
warning logs of "Unhandled WRMSR(0xc0010115) = 0x0", which is due to
"IGNNE MSR" write in guest hyper-v. According to AMD APM volume 2,
section 15.30.2, the MSR is "only useful if IGNNE emulation has been
enabled in the HW_CR MSR", while currently KVM has prevented guests from
enabling it. So change the warning to a stronger check.

IGNNE is used in the legacy MS-DOS compatibility sub-mode of X87 FPU
exception handling. Intel SDM volume 1, section 8,7.2 describes the
details of this mode which applies to AMD CPU as well. The CPU selects
this mode when CR0.NE bit is 0, and will rely on two pins (FERR# and
IGNNE#) for exception handling. AMD later introduced IGNNE MSR to "set
the state of the processor-internal IGNNE signal directly" in order to
support the legacy mode without the dependency on IGNNE# pin.

The current KVM implementation does not emulate this feature, not sound
necessary as well. The commit 82494028dff648c29e3a ("KVM: SVM: Ignore
write of hwcr.ignne") clears the bit-8 value in the guest HWCR MSR
write, making such field always zero, then the write to guest IGNNE MSR
can always be safely ignored.

Signed-off-by: Jerry Lyu <jerry.lyu@open-hieco.net>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ef69a51ab27f..1100d9a66c2c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3196,7 +3196,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_VM_CR:
 		return svm_set_vm_cr(vcpu, data);
 	case MSR_VM_IGNNE:
-		kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
+		KVM_BUG_ON(vcpu->arch.msr_hwcr & BIT_ULL(8), vcpu->kvm);
 		break;
 	case MSR_AMD64_DE_CFG: {
 		u64 supported_de_cfg;

base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8
-- 
2.43.7

