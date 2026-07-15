Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CCE43B491;
	Wed, 15 Jul 2026 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110077; cv=none; b=f+oguM/dlK5RalFxQxK5OvUidB9IIxn+XWT0JdPEf+96gtWBo2niFWr8J7PaZyh9ZldyiOpYOiBGFPszJPow2TSuGG0kFqzHhT3QTDDv+fs8/tw8el1MLfEqvQok1xqbLb4e/29MUSbUt0rld2+ZGo39xSlmk6HlouJ5vV6xgBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110077; c=relaxed/simple;
	bh=zaA7OdCUzLoiUyzJ6WpyD5E74PUenSftdecj7aPIY6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAkVyLteIJbY6UEVx2XlKj0CGo+h8u10XK4uTJscxy9is0SOBefRi2R0JYPvAF/EKxd8WV2VtBabpZVIEIb/MjihCSBnPPJX3DeQ0qaggkccv86gqrA1rdPXEQadeslSUIjnwQFZUM7KXZmiPGzOpJz5RZoWEQxqGXheNXyA2tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f7MAtujn; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f7MAtujn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784110073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xAoPsHa9NGlk8EddEQFkn1GqKcBgQkpv2Ti86GFuf7o=;
	b=f7MAtujnmBEZbL5Prt/A6smARaOWUo8+SmTb5mbPKNG0ygSZVurDjoKQQ2JOkzb3SFXf4m
	teyzDJtr3G9/QQO8qf7gKdgIH1T3mZIIUMD22xXixefUVC7X+a8263tRWOOSST8ANuTOwu
	K6Q2AKPBSSIBNSiR0KwGGXFHM5G3fMg=
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
Subject: [PATCH v3 1/2] LoongArch: KVM: Reload one-shot TVAL on migration destination
Date: Wed, 15 Jul 2026 18:06:39 +0800
Message-ID: <20260715100640.1454413-2-cui.tao@linux.dev>
In-Reply-To: <20260715100640.1454413-1-cui.tao@linux.dev>
References: <20260715100640.1454413-1-cui.tao@linux.dev>
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
remaining countdown from the migrated TVAL. This covers both one-shot and
periodic timers. The regular preempt/resume path on the source, where
expire is valid, is unchanged.

Suggested-by: Bibo Mao <maobibo@loongson.cn>
Fixes: a5857b9ff6e0 ("LoongArch: KVM: Implement vcpu timer operations")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/kvm/timer.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
index 3829f35a4070..96f33e34855a 100644
--- a/arch/loongarch/kvm/timer.c
+++ b/arch/loongarch/kvm/timer.c
@@ -119,6 +119,18 @@ void kvm_restore_timer(struct kvm_vcpu *vcpu)
 	delta = 0;
 	now = ktime_get();
 	expire = vcpu->arch.expire;
+	if (!expire) {
+		/*
+		 * vcpu->arch.expire is host-internal and is not migrated,
+		 * so it is 0 after migration. Reload the remaining countdown
+		 * from the migrated TVAL. This covers both one-shot and
+		 * periodic timers.
+		 */
+		if (ticks < cfg)
+			delta = tick_to_ns(vcpu, ticks);
+		expire = ktime_add_ns(now, delta);
+	}
+
 	if (ktime_before(now, expire))
 		delta = ktime_to_tick(vcpu, ktime_sub(expire, now));
 	else if (cfg & CSR_TCFG_PERIOD) {
-- 
2.43.0

