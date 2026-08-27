Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3F22BEFE8
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 05:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808968; cv=none; b=Na0/IXk2U10mhQEuApWr9BNF3vQ8m88xBmKH78+gJQcY5IwSpn2lGLp1QU4fw+bMoajEh4Suhemx4Haqt2QuoZWP/LNxB/7FuDeYqsRGev/cQLzaMEEJqOeSXpk9Qor7AudV6YiQOXTeenoj3QPDORpWK0wMKN35rDpAyKKEHMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808968; c=relaxed/simple;
	bh=QuSeOhB49u1boRy0wxtSXZ5hFk3JjgNa0yT1RXrusdc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B9VbdzxZJyfve3TVcHo0FLA5SxzSVj4WjHgfAgccPg68UxrlEVajGh2djCxUm0TWDu/XTx9s03pXAWpSUIIscZbp793cf7Wt+h9eQGDf/KTN98lmlOWvOn0toQ4L8I4yd41I8jcZrltoQfWU8ETMjEX/kNbcoKTIT0/5aVkCrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Jbi61/ao; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Jbi61/ao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=x2abyHBH4jYjw8qeNJ17aZnh5T5Nw240VAgfC+VVGak=;
	b=Jbi61/aox4L8DTG8gvux4gBZ40Dqh8Ow2UAQZEbkr203cMDyO3nwPi1sIHiXmo
	E49spdxVBJdKBWPpigQtkLYYr0dcIx6ADWPIwRimhs0avqS2qtpD6iVH4Kj6IakI
	o5oneZkfgQwnaH0Echz2eLC81NjvBOzJnIvkkgq5oYvTs=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3H5GzzI9qJaoXSQ--.42701S2;
	Thu, 27 Aug 2026 13:35:48 +0800 (CST)
Date: Thu, 27 Aug 2026 13:35:47 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH 1/2] KVM: nSVM: Restore L1's debug registers on nested VM-Exit
Message-ID: <ao_Ms5alWwKa30U8@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CM-TRANSID:_____wD3H5GzzI9qJaoXSQ--.42701S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1xZw1kWw47tF4UKr1DGFg_yoW8Gr18pa
	9xAr4vkws29r1SqrykWF15Xa4xua9Ygr18Cry8G3sYqa15K3s3tF1IqFyUXFn8Zr4kXrZ5
	ZryvvrWrZa4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uqsj8UUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+hTe0WqPzLQhFgAA3L

From: Hao Zhang <zhanghao1@kylinos.cn>

Restore L1's DR6 and DR7 when emulating a nested VM-Exit from L2 to L1.
KVM loads L2's debug register state from vmcb12 on nested VMRUN, but
currently restores DR7 to its reset value and leaves DR6 untouched when
switching back to vmcb01.  As a result, L1 can observe stale L2 DR6 state
and lose its DR7 state after an L2 VM-Exit.

Restore both registers from vmcb01, matching the rest of the L1 processor
state restored on nested VM-Exit.

Fixes: 4995a3685f1b ("KVM: SVM: Use a separate vmcb for the nested L2 guest")
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 arch/x86/kvm/svm/nested.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 73f37b050d0a..e7975ac7bfca 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1427,7 +1427,8 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	kvm_rsp_write(vcpu, vmcb01->save.rsp);
 	kvm_rip_write(vcpu, vmcb01->save.rip);
 
-	svm->vcpu.arch.dr7 = DR7_FIXED_1;
+	svm->vcpu.arch.dr6 = vmcb01->save.dr6;
+	svm->vcpu.arch.dr7 = vmcb01->save.dr7;
 	kvm_update_dr7(&svm->vcpu);
 
 	nested_svm_transition_tlb_flush(vcpu);

base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
-- 
2.15.0

