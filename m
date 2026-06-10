Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E7388868;
	Wed, 10 Jun 2026 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075164; cv=none; b=V3+f1c35nEO95iAnlo6hukndxERagq0jhUc31ZH2MrbJVVxrEw31lqrwiTjrNQiVPkAEyKpHimuv6NOCb1NIDuTnVVu/oUKLQEmO2EPAFwysA+M3YNj8l74TVVeYmcFSrFf4yPe9ZjQOYrlBKosDeUTMylj2GGQcqzI2EQn1NvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075164; c=relaxed/simple;
	bh=sObZv7no16cEocysFNZp2gbSUeFIxkDn/LkizdkVTb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UIJM811/q+Ku7DS+cnTkZDnirgc4dXnr3xIndPzqIQVFAqKFlIZzWOn4+QHC1XW1ZHHU9mtexGXrevJMXTL4KU2O64ilJfozmRH7HnPtvQjtvJOl13YtZyFw5f9Pc4HgT4YAAe8Pe7NBkesbWXVTwB6JIpKSZuegFyrrg4cRBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KoP8hH2Q; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KoP8hH2Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Hf
	FJe0MqonfQnym7z5Rv6QCMJe2GN62r9Bmh1e2CkTo=; b=KoP8hH2QM6PYEuCHwA
	YKFpHiGLA4vw69FQOezjnqnU+UiIIXIlYApzhsy4mlLHRbq5gA96liqLD6B/2dl3
	ChWU/tlX+sRQCd612pv+m+1nrkLbuoosypy7e52ufVFQjsLYnW6TjdgI7uRLEYe3
	CN2IgeLf5CeFlZCK/nOXZkBpw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAHCyKrDClqpIKtBQ--.7345S2;
	Wed, 10 Jun 2026 15:05:15 +0800 (CST)
From: xin guo <m18700951735@163.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xin guo <m18700951735@163.com>
Subject: [PATCH] KVM: SVM: Clear dummy V_IRQ in vmcb01 when deactivating AVIC
Date: Wed, 10 Jun 2026 15:05:12 +0800
Message-Id: <20260610070512.85463-1-m18700951735@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAHCyKrDClqpIKtBQ--.7345S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw17Zr1xKry3Cw4xJrWrZrb_yoW8Xw45pF
	ZrCw1vvr4qgasay34DK3WkuFy7AFZ5CFyxCFWvkr13ZF109wnFgFy0yw1qvF15CryrWr18
	Zw1Yv3y5ZFy5AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRR6wJUUUUU=
X-CM-SenderInfo: jpryliyqzvilitv6il2tof0z/xtbCwgwTWWopDKxZmAAA3m

When KVM requests an IRQ window via svm_set_vintr(), it programs a
dummy VINTR with int_vector=0 and V_IRQ=1 into the current VMCB.
These int_ctl fields are documented to be ignored while AVIC is
enabled, so the dummy VINTR is harmless during AVIC operation.

However, avic_deactivate_vmcb() only clears AVIC_ENABLE_MASK and
X2APIC_MODE_MASK, and does not clear the VINTR injection state. Once
AVIC is disabled, hardware honors V_IRQ again and injects vector 0
into the guest on the next VMRUN. Windows guests observe this as a
spurious interrupt and crash, e.g. with STATUS_INTEGER_DIVIDE_BY_ZERO.

Fix this by also clearing V_IRQ_INJECTION_BITS_MASK from vmcb01's
int_ctl in avic_deactivate_vmcb(), so that no stale dummy VINTR is
left behind when AVIC transitions from enabled to disabled.

Signed-off-by: xin guo <m18700951735@163.com>
---
 arch/x86/kvm/svm/avic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index cdd5a6dc646f..b042c3f5f90e 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -257,7 +257,9 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
 {
 	struct vmcb *vmcb = svm->vmcb01.ptr;
 
-	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
+	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK |
+				V_IRQ_INJECTION_BITS_MASK);
+
 	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
 
 	if (!is_sev_es_guest(&svm->vcpu))
-- 
2.27.0

