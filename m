Received: from mail-dy2-f14.google.com (mail-dy2-f14.google.com [74.125.229.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56951530DFB
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169728; cv=none; b=nIPC/fWJVICPFqu4CWwGFQIrycKktaF2SfHXw3X7T3vGOfmPCf4Zi3Brj/+mF++Kx0Id8C4juSDY8Zv0ZkV5BJBSGwH+5gAkXgWI5Wcr++dOwlw1L3ul+7fUmMeylN43hZr64BlW3qQBWphMPO6YmXDO4sry9BJ9CqHkXenEKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169728; c=relaxed/simple;
	bh=FePWrwfR4h/38X2wlZ8Cws5lbIqJBg3t1JAJGWAzQTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6GSZeG9gHhsjVs7AmmJqu7wwG0N7V8bdkKnRHCe2jUuGnTkZZeJvHab5hCa3Rph6KE06r4YIR0BcE13wkP9vnnXPnFNRqaqvKvjskiMuKdwnlZPfM0o+/Uqj/e29HIt4HozjzlvIM1xFzqaLrgDH47SWNjyHIbM4W/VUpbWIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgCyYPcn; arc=none smtp.client-ip=74.125.229.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgCyYPcn"
Received: by mail-dy2-f14.google.com with SMTP id 5a478bee46e88-328664b7528so678736eec.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169726; x=1790774526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4msTpp+vR3Q9A3d1BOVyjzK5nl0nVEODWOwLdHYYFFk=;
        b=TgCyYPcnwUPxrO5OcSojqLMT8MOUWoRIL8RD2oDHECOFShEgJSFUjQlyeNNjti8kEk
         Iq2Ro1cQ5D02QYHkNBH5HbWGbTJQAmH9sHHHVisAmQxrhyUEN0gzHchLNnRaOnNDSWrF
         DQCiMmaXBBRQU2sbtzKBKuYMw8BUNBLSesq5FSGvb/Tw5FDUmMulEivMrsJpOve8RNTM
         qD/uyZmoAQHqG0iKxw9NGgYtZ39yBxgtvrF9T4LzkRwb8XGP1UZx+dI3qgwbzg4Q22/P
         IHFPuwHrKpinc2WAkjDfSBaKnlHsjd2q1ItcbVXVaI8PPzdxX6dagPDUIFHrxZOy29Ac
         z3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169726; x=1790774526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4msTpp+vR3Q9A3d1BOVyjzK5nl0nVEODWOwLdHYYFFk=;
        b=KAB/ZbRkNyjkKu7pVJs0uYMxVKXw0TXlD5JTC02CXs+AEBSxnfRvs+1u7uLr+D1ctn
         S5a9Mc1ZXeDkRldwVH9kzEZloqtaL5Nw/0//cKL5qersevvT6makSjcD3mA6mu5i787B
         FiCfl1z0DOVxDHCANwR65xo9K3lUWyQtDqsBJsCJ0ohbFHCbYBiXpfd3UN3iVc+8Tsji
         vDgHd+LdNMtaolyu6k5sLJLKa50aL2MVjZSzPy8GLQjHf5z9EbbkdFDC9IUBzE+keGDE
         GJtIgd1ER2/WOVy+XaZ8EfZr8Oy2A3mLjcqHt0JexqMdmVajwb4qG6T9mh9ed909+rZQ
         jNbg==
X-Forwarded-Encrypted: i=1; AKwUvBzSgxZl2Tp2nHc874KIDxwcL+3oaCL8eQN2h30ffwD6QyqwLZUVasLZFjFCh/6TdkXUpis=@vger.kernel.org
X-Gm-Message-State: AFuF++l87D6BtolWr7iyzcp2engUmSjsmu9sXRFtGcowUAaeF5zj5VbZ
	8EuYH3jXmpG7qTNAvwLeN7cr60ieFifayZTDYUJYqA8JgTgr3N4w1qnh
X-Gm-Gg: AYBFou2itS7nrV3dwZKUKfkf3akPSLXzT6iavsoDatQ9lLfl3PGe7a2AcdIke/Nnb36
	Z+8q/wUAnMNH1a4w/Zi/vWTBIJblCEn+Lfge9oH6arF0r2DMmdbw3XRTNfCh/I91UCjvYAcvyXT
	GhkPo9yqLe0vEVzEG5jq0zf6EEjZH462ZXUsaA2Ai+24VUkI01Aee06ECWubXJUpQ4G9dHguXm6
	dibxD4AqeKKS+r+j8oMbSBwu5Bp0uv7HZSUvcZY+L5QigBcfdwcFwTySNkq5b+vpJTLuFPpJydc
	HaRFgpNpk7GWbics8MRuryZS9FfFWL/Q9HMFWUWiUkFjniLfsBU/NpW7wTxNtDuBUMNE/4GTcn3
	4T+fCuvDFES0sFOJ6C382/810yZJ5UGFh35h6mTn0lpTXo/qD3PkyQfEzOgGPkvoZkofy/JPpml
	GzwQGBZ0rC9G9ub5ErWS+x0w4PHV2sg5ohg+DzWIX4+317Vw6TzvbNqoAcX/Jk7tFbZR0XR93LY
	vAbDKHqhKrnNMnwesv9Ei+3FnYJTFg=
X-Received: by 2002:a05:7301:d595:b0:33b:e55f:68c8 with SMTP id 5a478bee46e88-33e8d8d21e3mr2659104eec.26.1790169725708;
        Wed, 23 Sep 2026 06:22:05 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:22:04 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>,
	xen-devel@lists.xenproject.org,
	Chao Liu <chao.liu@processmission.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Fabiano Rosas <farosas@suse.de>,
	Xianglai Li <lixianglai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	qemu-ppc@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	David Hildenbrand <david@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	qemu-riscv@nongnu.org,
	kvm@vger.kernel.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Song Gao <17746591750@163.com>,
	qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 031/114] tcg: fix off-by-one in helper extend-free assert
Date: Wed, 23 Sep 2026 21:15:05 +0800
Message-ID: <20260923131635.1894-32-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Allow n_extend == MAX_CALL_IARGS after filling extend_free.
- The old < check fired on a valid seven-argument extend.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tcg/tcg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 489df0e7386..6d55cc284df 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2599,7 +2599,7 @@ static void tcg_gen_callN(void *func, TCGHelperInfo *info,
         QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
     }
 
-    tcg_debug_assert(n_extend < ARRAY_SIZE(extend_free));
+    tcg_debug_assert(n_extend <= ARRAY_SIZE(extend_free));
     for (i = 0; i < n_extend; ++i) {
         tcg_temp_free_i64(extend_free[i]);
     }
-- 
2.52.0.windows.1

