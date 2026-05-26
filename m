Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3EA379981;
	Tue, 26 May 2026 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782293; cv=none; b=BgqfT23AC+vZ79Lr7ICbaBEJAegY+9D1v2mTumArNOSRVHgo6AhDHokNogGLWkHsRfxlqDLcPeHR2jg3cNC49W7lW31SroBnQRVVkL1hXuYf1cfiKzDYRJvixoKmqNMilNqj4JBD3U5sW8krzC7zmQK8oUzq6snsEJwi6Ly6vwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782293; c=relaxed/simple;
	bh=ol1Mkd36jDdUVdjNDW1pq07QJgemf3MNQ/dmBw9Falg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IrkCoCQpaNPsrOb0TFuLukVSs18AvgoZldBiUDIgupzQ63U/WTprLtEaBzC2KRup5bM7ymdHZXVazQhPx8HjwYV4PGSBIt+rDOY23+HfN91zAINQHZgfyX2AhlefGf8rPNFgdRoMsfdC8e6u03bwRgGj1pEX2GtALr//nqjnt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=DnFlhe5s; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="DnFlhe5s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779782181;
	bh=UiwhJn3VYjvIdwS+YrcKQwv+LwDF4GDtkBEy0aj+ECs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=DnFlhe5s4xcd59KHCxi6ariBnc05uYiOQ7BpwOgVuk/O+7dHrHu8ZphQUP8wY52nT
	 JDvxFpnANe3jsFVaq7PtyyahwUD32g22mvR5dR5ku6up1Oc4+1IBjOE5ExrzkCYjtt
	 llxy3rqq3fx96FHOKGL8QUEXjko/A9XBOfw0FH2E=
X-QQ-mid: esmtpsz16t1779782160t4aa77563
X-QQ-Originating-IP: CGFhapbqFt62t2SDAMmy8wPmz78bXl9QfPr+2tphAcE=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 26 May 2026 15:55:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14842016682969413512
EX-QQ-RecipientCnt: 11
From: Qiang Ma <maqianga@uniontech.com>
To: anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] RISC-V: KVM: Fix timer state restore
Date: Tue, 26 May 2026 15:55:44 +0800
Message-Id: <20260526075544.796396-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NEaes6yu2o+m2XTd/LhaqqpYIDlG8CLVa/wqcoYk1tp/p/OryyIRVSel
	Gc8vXUCptpw709bluAgmyuQpCVip9JI/Suc73a5Eqj/h6AMok/YXZsLadipgHRBV2l2VLCZ
	hRk45coJ/vtCO6Dh6eCcVVj+KN7jDE3XXm4r6tglHPoHZRIFcOg58F5kOJ9e8T+j7JihKmA
	+IZ2xFmF0Z7cbhpl+Wb4bQPzM+mT92/SlMOvyTSnLRIrMgd9Bw7GSjGoABuC2PM5lAp3Lsz
	QcczPuR+3Ta3EZybtkx2NMkSv2wwkIaN0Fkszbq/wWC7pbbA0OG6AVlpzAcSjWpfFsEj8Hf
	MrbgG+kTnfY3NSynK/3WZK58lB0Ee1rhIhJj1FW7jvqg9GUW6Xq64jQZgBUXGrkmJcj0yuh
	fMRYzvUn3yzEAK2gf9ta73VDfTKsHo0u6eA05MEtUiKAcE4C/jwy6pENGTwOGDrqOyxxeJr
	Zv3MxWOfeYeQBB7oMioU9eV1IjriCbfzlV0VQseCG4o29eaDQcZo4HMZofgE1HpMEylrvrZ
	hSk9IDnwHKX1Ja87yi7tD4KM0D6ElL2XK3urVYZn/Z5tgqaCRA+0aFMHBOUpIPY2k6ZDtMN
	fKpvFjpbmRQkYHNZGDdXj8e2LfOKTfz2/rg3PJqNg5b15Ph55TyA5Zt1gbSIMO1KbtgtUdk
	S4Fy7U0Vum1tOnsan1K3zQ8JLAvgdteMzMr6mMZeupEncJYR9gDM0SQ6LU2NAmhDFiZ2ytV
	PTK6sS0RGa+ikj1VER0z+NA8JnJCZjYRkgUuCKOVKz5Ji8kdVvw15odGNqULz+O1GXCVpCE
	J4vaip9MtSParGZOUJv/KF5Rjkr+FoV0RNoRMj5ZaaqS3n5mGOI40c6z76eMCqbyI6yXmKm
	y4Qbx8gAvD4GUpmCXdi/FSgN9yJq1iS0ZwHEfQ9FZ3tVC0C5X/BzkSgUCxHbOL1n6tbqFE6
	9UQd5dyq5LhbdNOdu7UcPKFt4yjYR72M8U1D55HD6XT2GGdnorUg8irVmgMqV6mCnb2aHR8
	ulyOr3eXLj8jH8kL5o3SmscwDV8GiKHFKQdq1E3w==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

The KVM_REG_RISCV_TIMER_REG(state) one-reg write passes the value
written by userspace to kvm_riscv_vcpu_timer_next_event() when
re-enabling the timer.

That value is the timer state, KVM_RISCV_TIMER_STATE_ON, not the
timer compare value. During migration or state restore, userspace
restores the compare register separately, which stores the target
cycle in t->next_cycles. Re-arming the timer with the state value
schedules the next event at cycle 1 instead of the restored compare
value, causing the virtual timer to fire too early.

Use the restored compare value from t->next_cycles when turning the
timer back on.

Fixes: 3a9f66cb25e1 ("RISC-V: KVM: Add timer functionality")

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 arch/riscv/kvm/vcpu_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
index 9817ff802821..ae53133c7ab0 100644
--- a/arch/riscv/kvm/vcpu_timer.c
+++ b/arch/riscv/kvm/vcpu_timer.c
@@ -231,7 +231,7 @@ int kvm_riscv_vcpu_set_reg_timer(struct kvm_vcpu *vcpu,
 		break;
 	case KVM_REG_RISCV_TIMER_REG(state):
 		if (reg_val == KVM_RISCV_TIMER_STATE_ON)
-			ret = kvm_riscv_vcpu_timer_next_event(vcpu, reg_val);
+			ret = kvm_riscv_vcpu_timer_next_event(vcpu, t->next_cycles);
 		else
 			ret = kvm_riscv_vcpu_timer_cancel(t);
 		break;
-- 
2.20.1

