Received: from mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDC0468C20
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144329; cv=none; b=G32Ue/64MgjSDHzLSyiVFWDsWvL4px/rv6vPj11Avuqr0kOk79ZtwdkZgt/e4QzQ0SBUh2AKw1Hq/N+xSRtCYFZiboT+t8oIjgCTKZCbMX1ezh/XkJ/eBc6/5VY54x89+GASI4hiSZCsm183gjifBIU85C+uwQzCMCdhFso6hI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144329; c=relaxed/simple;
	bh=+satW2wovK5/sccsFx3tJk63vH23Jrh2NuQe+3IpqxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQPVdlJ09uX7Qz2CRQ10l/awyGuyKGonIrXW+0Bxl87oIlQ4W8Mg12wLIFlwyRBiCFr8oXvV2x6s2Q+Ib8Id7Yam6W/oYZFxi1XPP3XHtdxg32zsdSXOgbrzCb5xgnKfyD0PF5OP05an4pZYvy7SwmwdsVFrZtSZ6Gd2YhH1TnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wp00BCAB; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wp00BCAB"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+satW2wovK5/sccsFx3tJk63vH23Jrh2NuQe+3IpqxU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792144325; v=1; x=1792749125;
 b=wp00BCABa9mHrUcSCN9yvcrCrbAAvPTepvLQzj40dmEbUPAxzHJnvpbXluFvn/bTUSUAFF9U
 yrYCSkKUxi5n4F78Hq6N/RYhaE7H71HwYSykmD+OiwHNlNf8K0RmMEtV3emHY07YHcBDgvBRjBm
 OqvcmJ2lFRvwTmsdwFHzjpbk=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f63086e6ddc2fbdf;
	Fri, 16 Oct 2026 09:52:05 +0000
X-Mizu-Trace-ID: f63086e6ddc2fbdf
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: chenhuacai@kernel.org,
	maobibo@loongson.cn,
	gaosong@loongson.cn,
	zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@xen0n.name,
	nagachaithanya9911@gmail.com,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v5 2/3] LoongArch: KVM: Propagate real error code in kvm_pch_pic_create
Date: Fri, 16 Oct 2026 17:51:50 +0800
Message-ID: <20261016095151.1155049-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016095151.1155049-1-cui.tao@linux.dev>
References: <20261016095151.1155049-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

kvm_pch_pic_create() replaces the real error of
kvm_setup_default_irq_routing() with a fixed -ENOMEM.  Return the
actual code, as kvm_eiointc_create() already does; the kvm_ipi_create()
case is fixed separately by "Return the actual error code in
kvm_ipi_create()" (Chaithanya Lagisetty).

Fixes: e785dfacf7e7 ("LoongArch: KVM: Add PCHPIC device support")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/intc/pch_pic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index dab2d3f1b8f6..51e4a6a39dc0 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -444,7 +444,7 @@ static int kvm_pch_pic_create(struct kvm_device *dev, u32 type)
 
 	ret = kvm_setup_default_irq_routing(kvm);
 	if (ret)
-		return -ENOMEM;
+		return ret;
 
 	s = kzalloc_obj(struct loongarch_pch_pic);
 	if (!s)
-- 
2.43.0

