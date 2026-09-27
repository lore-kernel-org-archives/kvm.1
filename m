Received: from mta1.migadu.com (out-65.mta1.migadu.com [95.215.58.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9283B813D
	for <kvm@vger.kernel.org>; Sun, 27 Sep 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790495615; cv=none; b=jtCq3LAPISSzRfFQYawMC6c81DN+nXiwcFrdIgI94iHO0og8wemogRq6bjSWE9P6QL5bhHEQiATpkf5dKsUaJbW8zh7Gw2/myNUIvZ6MmIdBL0+387TMhjXyio9lNCGh41Hn6GQdS3eqCKX2hpbMi47ilqRL7bJUqB5eLKLZtQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790495615; c=relaxed/simple;
	bh=qtJY7IWCF56w0uUwC7sh7QT8uK5937lztchgKm6a5uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQYyunMfz9SQhE0K29rO/31ECa+rQhtWRA93fCI8MW98H8KxyyenLneJq+zlAZTGe+khJNFu78y1gGEzWVrzQ2/H7fn0p+ywcb9Y5RwPba3qj1hJkQn/UYcQkwe1T9oyQ5sReLncb4Y9TAa6rWs/8g/nJDkWu8gdhYBpRe4kGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gsfLNH7q; arc=none smtp.client-ip=95.215.58.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gsfLNH7q"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qtJY7IWCF56w0uUwC7sh7QT8uK5937lztchgKm6a5uc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790495608; v=1; x=1791100408;
 b=gsfLNH7qWxVgzVTbiM8DL2SDJsJfjfDSqbDKKErg2veXZGf5kIY5zh9O3Y87UxTLLs/P2Fun
 90BOlmrM6ESPGrplwBqq9nmmpbMhi9Zj+q3kDzBKNDa5lKNpyEeg8Hn3UBnJ3Sg4qtUmC/PXo80
 Tx+uVdT/HgbQ4APrsdm4p3hI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a70d6da1643d95c7;
	Sun, 27 Sep 2026 07:53:27 +0000
X-Mizu-Trace-ID: a70d6da1643d95c7
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
Subject: [PATCH 5/6] LoongArch: KVM: Propagate real error code in kvm_pch_pic_create
Date: Sun, 27 Sep 2026 15:52:39 +0800
Message-ID: <20260927075240.3007947-6-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927075240.3007947-1-cui.tao@linux.dev>
References: <20260927075240.3007947-1-cui.tao@linux.dev>
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

Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/kvm/intc/pch_pic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index e33d6693c37c..136211f154d4 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -448,7 +448,7 @@ static int kvm_pch_pic_create(struct kvm_device *dev, u32 type)
 
 	ret = kvm_setup_default_irq_routing(kvm);
 	if (ret)
-		return -ENOMEM;
+		return ret;
 
 	s = kzalloc_obj(struct loongarch_pch_pic);
 	if (!s)
-- 
2.43.0

