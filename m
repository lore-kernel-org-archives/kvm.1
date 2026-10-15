Received: from mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4680A3F1ABB
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108019; cv=none; b=kEXGNYKj+lHVb8t6c343oVaSRoEEU+WnyN1o9gqbnzvc5SEY4Gwm8x8p6AVOLXGyeJ76bPvAEMP7GAEexQNIn2A6hbbV4krgQ/jofNI70T3Dv1Tii2TL4HRiPjRQgqfwNitt/FyuxiNJAvroTvPEXXI7K13pHQjh5xWwBo3SWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108019; c=relaxed/simple;
	bh=+satW2wovK5/sccsFx3tJk63vH23Jrh2NuQe+3IpqxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tc3dU5CcdhiU/C5RldP6bIGYdr0vqem6GYKIBTidRoeXqbcCfZa4qJwftKU7Ji4UT7ab3goDcdg56vq19kmU7eGdyQvKM+95pmZNJvLG6o+Iqfvao3SwWER+HolnphDaUOMUNSScodbjOTxktVb+GzkslW0YVADZYFhTc9c94OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qEV6YY1+; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qEV6YY1+"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+satW2wovK5/sccsFx3tJk63vH23Jrh2NuQe+3IpqxU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792108016; v=1; x=1792712816;
 b=qEV6YY1+2wVAbhHM2Kt/WDZPB8K3dfAD8UB91ZfawOCWZAiOFTpTbG4ivqeitVR+DWVdnycm
 lCsRwqSPfoFqdI70FoUwlLmSWQsCgqjd5BEAN6NZzPrYVU2DO4QjuEpR7x1hB16zm8dDuiuD3QE
 2eLMwU9pxPzUjEMmTjzlc6Ec=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 614af069329469ba;
	Thu, 15 Oct 2026 23:46:56 +0000
X-Mizu-Trace-ID: 614af069329469ba
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: chenhuacai@kernel.org,
	maobibo@loongson.cn,
	zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@xen0n.name,
	nagachaithanya9911@gmail.com,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v4 2/3] LoongArch: KVM: Propagate real error code in kvm_pch_pic_create
Date: Fri, 16 Oct 2026 07:46:37 +0800
Message-ID: <20261015234638.1077815-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234638.1077815-1-cui.tao@linux.dev>
References: <20261015234638.1077815-1-cui.tao@linux.dev>
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

