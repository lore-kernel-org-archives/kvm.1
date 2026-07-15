Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A735B3921DD
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 03:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086154; cv=none; b=ZfYlqwVKP++U5lmliUkEpHRx3qBFc1a1yJWaBkhP38w4a5FQ07c6cMmil4bqbVXUrxCvAo9TGVSFu2JfP3vrZ5N5kFlNETk26UXDtSGwkfR00G/w9KdLpxcLEnaD+da57Xmca4PnK1ZsY1oMBg4DPiPvHbGAnPsZ43gxFT4hA7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086154; c=relaxed/simple;
	bh=rU0w+jylpN2mCRzJY4Ddettjtd03hHqfBZQrGD+GsVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ECJtvNXMmGQK2L8Lcp4LfaD4ZMZUFVNKeq+ANrUUYlWV+ufsK5BPY1fnNFIWorok+V5j13caHQf8nkYY+FjWpRFPERrXiZ767V/mnaRehoo7MUTmoTDhdyS1ugEfIGdsUqKXjZqpVNwd9gnnRb2pb+CnGTxCvlM3jjwV+HZzQY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xt/LZEX9; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xt/LZEX9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784086140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mJAHNja1Dyni0b073WazBMCRSGk8WsT3dNZNvskXmS4=;
	b=Xt/LZEX9DFueuVx1sQ1IhTziNwElv176QJqn95twtqPyQbV7hvqQkW89J6V1Gs3aMvpMIq
	5qcvjn3H1NDZteChdB9dGR+m3woWrlup96L7LT90fTwYOpKY0g1ginRsBQdAWvY+dH8Vr0
	n7g/M4RXK9ulSFsg5IRVTf7dvf3Lbf4=
From: Tao Cui <cui.tao@linux.dev>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn
Cc: chenhuacai@kernel.org,
	kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lixianglai@loongson.cn,
	cuitao@kylinos.cn,
	cui.tao@linux.dev
Subject: [PATCH] LoongArch: KVM: Reload one-shot TVAL on migration destination
Date: Wed, 15 Jul 2026 11:28:31 +0800
Message-ID: <20260715032831.1411664-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

kvm_restore_timer() rebuilds the remaining timer countdown from
vcpu->arch.expire, which is host-internal and is not part of the migrated
vCPU state. On the migration destination it is still 0, so for a one-shot
timer that has not expired yet the computed delta is 0 and
write_gcsr_timertick(0) injects the timer interrupt immediately instead of
after the remaining time. The guest observes a premature timer event right
after migration.

The expired one-shot case (TVAL = -1) is already handled earlier, so only
the non-expired one-shot path is affected. When expire has not been set
(i.e. on the destination), reload the remaining countdown from the
migrated TVAL. The regular preempt/resume path on the source, where
expire is valid, is unchanged.

Fixes: a5857b9ff6e0 ("LoongArch: KVM: Implement vcpu timer operations")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/kvm/timer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
index 3829f35a4070..57f53d19a00a 100644
--- a/arch/loongarch/kvm/timer.c
+++ b/arch/loongarch/kvm/timer.c
@@ -132,6 +132,14 @@ void kvm_restore_timer(struct kvm_vcpu *vcpu)
 		 * during injecting intr async
 		 */
 		kvm_queue_irq(vcpu, INT_TI);
+	} else if (!expire) {
+		/*
+		 * One-shot timer on the migration destination: vcpu->arch.expire
+		 * is host-internal and is not migrated, so it is still 0 here.
+		 * Reload the remaining countdown from the migrated TVAL instead
+		 * of firing the timer immediately.
+		 */
+		delta = ticks;
 	}
 
 	write_gcsr_timertick(delta);
-- 
2.43.0

