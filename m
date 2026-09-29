Received: from mta1.migadu.com (out-2.mta1.migadu.com [95.215.58.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C3F50EC14
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677755; cv=none; b=OUxOv6qOdmLQl7brienBiPElwHZOgnXpSLT771zEZQWZFIx4C6bZOOVrdq3CA1rymqGIgv0Y6PR5jLqwOY6EpyZ1/KrG4SJK0XvWiGdfprYDYwkJ2AKqZidgk4IfOb9bZ5I2p78TL2OVqwYYTzDdDZx9a60MB46aoPUrvqaEshE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677755; c=relaxed/simple;
	bh=8NLvOLnj3DbAAT+HBXadUZCHdDaLMqxODYIHGQTXStA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3u72y//iF3oViFRGJAbRAk2luj0Vxj1fKbrIFr6UleskmrZZVkRx508Ye4cPdkKhYkdy743tPZCsokaI+KN1GBE4KtX5eTQdPj2gR1rtTNvXM4EPJCG9xiexnCLegUFR3wi1QgYNgXDUFPM3hO5G5FNlCCktqZ5K+RNsdeZSjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I6DEcExZ; arc=none smtp.client-ip=95.215.58.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I6DEcExZ"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8NLvOLnj3DbAAT+HBXadUZCHdDaLMqxODYIHGQTXStA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790677735; v=1; x=1791282535;
 b=I6DEcExZ4PszoHBe9A3n17luQIZ8u/p7vg1ET5qgK+ySRsE4eMpqKxsqNpfG4mUo4KznPJwi
 1lWzaVTKMBiNft1UCTzk4KB6SS+ePJMC2dP8fVxqKv48Khw6UQCORll3j7sZ5OtCFDFxZMg8k2H
 k2jJ3ICDfTgkqp+2dYiBQhU4=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 863aecb5a1889c6f;
	Tue, 29 Sep 2026 10:28:55 +0000
X-Mizu-Trace-ID: 863aecb5a1889c6f
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: maobibo@loongson.cn,
	gaosong@loongson.cn,
	zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	nagachaithanya9911@gmail.com,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 3/4] LoongArch: KVM: Propagate real error code in kvm_pch_pic_create
Date: Tue, 29 Sep 2026 18:28:20 +0800
Message-ID: <20260929102821.36112-4-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929102821.36112-1-cui.tao@linux.dev>
References: <20260929102821.36112-1-cui.tao@linux.dev>
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
index 30a8c65c7609..7a704f18880d 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -445,7 +445,7 @@ static int kvm_pch_pic_create(struct kvm_device *dev, u32 type)
 
 	ret = kvm_setup_default_irq_routing(kvm);
 	if (ret)
-		return -ENOMEM;
+		return ret;
 
 	s = kzalloc_obj(struct loongarch_pch_pic);
 	if (!s)
-- 
2.43.0

