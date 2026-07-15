Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C7643B6D2
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110084; cv=none; b=VVjHPN3hhOdaYH7XzRPqtvvPkqWqyC4BPuS/ospYatpCJ2spkxSYvxyp4SgnfpPvkrhmIS4a8MWMc1E39+yAo6uYpp1kFBK98rtYYSpPpff+GBJIm3Wh1cm4NbCRao2NM46lhORsPCxxudpaldKIYdvA1T672a6MZVWlE4sfPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110084; c=relaxed/simple;
	bh=jwL2VVOUYGADmSgZcAaNYMGdQm4xwKzF1Gf0glTzcGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTZ8Ep0FbTvaQ8nrs6uKSondWt+jU1x3SOcRHyLNSv3AQs/fpIxUf67FepFkQRVnYjfk/iY/7XlnZSAugwTIr1c6fc0Z60ufORV2hRSdXIDOaoo2mPhUyqqUSYre0E+HM5badC8imzUTKlDtMsBj5BQXuYmdv33layrFbgDLmag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DM5sOdSA; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DM5sOdSA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784110078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5qVLCZa1c2w+E9hBDTxNVuxS7FTqNEweZ/mKnccpyY=;
	b=DM5sOdSAIjIRmvvbRpqpAQH5cFOM6xaEcS6mgqu4dnYWJ9zTMrso3AFA4Tqn0vCeIqoxKo
	YAlPOXCTkoV6H75fLJB2hcYQnS4fCx/JVAa7RRNHDqyPfm11VHirBK3JG9SUJSkP8t5l3o
	hu4UEVsKxoP+oXownQAOxYaNc+tQ2XI=
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
Subject: [PATCH v3 2/2] LoongArch: KVM: Prevent division by zero in periodic timer restore
Date: Wed, 15 Jul 2026 18:06:40 +0800
Message-ID: <20260715100640.1454413-3-cui.tao@linux.dev>
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

A guest can write CSR_TCFG with the periodic bit set but a period value
of zero.  When kvm_restore_timer() later enters the periodic branch,
period = cfg & CSR_TCFG_VAL evaluates to 0, causing delta % period to
trigger a division by zero and crash the host kernel.

Clamp the period to 1 to avoid the panic.

Fixes: a5857b9ff6e0 ("LoongArch: KVM: Implement vcpu timer operations")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/kvm/timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
index 96f33e34855a..524d4096bac0 100644
--- a/arch/loongarch/kvm/timer.c
+++ b/arch/loongarch/kvm/timer.c
@@ -135,6 +135,8 @@ void kvm_restore_timer(struct kvm_vcpu *vcpu)
 		delta = ktime_to_tick(vcpu, ktime_sub(expire, now));
 	else if (cfg & CSR_TCFG_PERIOD) {
 		period = cfg & CSR_TCFG_VAL;
+		if (!period)
+			period = 1;
 		delta = ktime_to_tick(vcpu, ktime_sub(now, expire));
 		delta = period - (delta % period);
 
-- 
2.43.0

