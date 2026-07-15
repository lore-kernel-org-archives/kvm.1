Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F033C140F;
	Wed, 15 Jul 2026 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100636; cv=none; b=b6tNTR/nb4nY3OY7Z2dHlaUAiqxeHe2ysYNQQzX7tRrvtusipEQXGTw+O8peGgMSoCVUxYUe0isIA+EhOvb1fbs2LAnIXfpMSHE9FLcSujINTA0fftR2j91AWb5q5M9383CCD6zjR2xYHVa/yfPZT609kGyizwU0PEREg1kSD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100636; c=relaxed/simple;
	bh=HUWPQqrAg4GAN1ssTHrrHq+Snkvb4M1tCYOKyJij9Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FijCdg3F5sizZ5KMs5AVqG+0D4annHrUalgWUtncVCUx+ZXR6WhJEe2xQ+QDbzCRdrBRJ24/83fyjA/CBgAHcRgjsQ0DKNswSC/GpbGpd/2DsD8g/MsxkXAgUsUMO1n8DSiGtWU4TazS2M6Xqw0E4WlEGR+Y3q9EMhGLwB/hv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YediSwNP; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YediSwNP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784100621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uYCTfFe4DS/mxZ1jEMMuLq6qG0NAu/+hUJw4bEZOCzk=;
	b=YediSwNPLOr8UddFmY6mamkXwscW4v4AT6RnW3sQpgPNxByu+IHdKSCwgtppNJCyH0GuNa
	dsXn7IVHZXT1PSU+7wIEGkS4A3DAspg8P/W5aYPFlQ8U/+xQGGHkvvRniHEjWCEiKH5up3
	BjB9/oSLe30LdV4gmPq4YvnzG4XtHDI=
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
Subject: [PATCH v2] LoongArch: KVM: Reload one-shot TVAL on migration destination
Date: Wed, 15 Jul 2026 15:29:52 +0800
Message-ID: <20260715072952.1433171-1-cui.tao@linux.dev>
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
after the remaining time.

The expired one-shot case (TVAL = -1) is already handled earlier. When
expire has not been set (i.e. on the migration destination), reload the
remaining countdown from the migrated TVAL. The regular preempt/resume
path on the source, where expire is valid, is unchanged.

Suggested-by: Bibo Mao <maobibo@loongson.cn>
Fixes: a5857b9ff6e0 ("LoongArch: KVM: Implement vcpu timer operations")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>

---

Changes in v2:
- Move the expire check before ktime_before() (suggested by Bibo Mao)
- Remove the old else-if branch that was one-shot only.

---
 arch/loongarch/kvm/timer.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
index 3829f35a4070..08359a612bde 100644
--- a/arch/loongarch/kvm/timer.c
+++ b/arch/loongarch/kvm/timer.c
@@ -119,6 +119,17 @@ void kvm_restore_timer(struct kvm_vcpu *vcpu)
 	delta = 0;
 	now = ktime_get();
 	expire = vcpu->arch.expire;
+	if (!expire) {
+		/*
+		 * vcpu->arch.expire is host-internal and is not migrated,
+		 * so it is 0 after migration. Reload the remaining countdown
+		 * from the migrated TVAL.
+		 */
+		if (ticks < cfg)
+			delta = tick_to_ns(vcpu, ticks);
+		expire = ktime_add_ns(ktime_get(), delta);
+	}
+
 	if (ktime_before(now, expire))
 		delta = ktime_to_tick(vcpu, ktime_sub(expire, now));
 	else if (cfg & CSR_TCFG_PERIOD) {
-- 
2.43.0

