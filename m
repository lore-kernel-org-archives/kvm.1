Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58F73F5BEE
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811548; cv=none; b=StdbF4DUurDCsviNa1GXXYz+JlefVOQMjs1KrwW2u5nicgvnIp4p8Io4Gti0lmMRD4KFiSREepdRfpHgecIYTh79X5wwzSnj6BQu/LufmnJx1bwfiLGbEr9gzJzZYB2Lkhq2VIli1oFx4JnmGHr/4yZiZsQAdKcKpRTrc6bhtYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811548; c=relaxed/simple;
	bh=/L0JztPl1fAH1NKvIkHQ2Z8SbljQvBWmCee1fQtoXjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ilu9DCvbawsF1PgsBGmCQ4ZAhV4jk+ItBGuom/JrBkp8xuwSWwBU4pH96jy3GT5BzB8RBwvNCHdZDCh8XW7h2CKwxF+R7hrVA9YKycioaOHW6ddT7h5/ZTncNZkKw5+koL3wt8+Ht9vIhS717QNNSlM6ueHY7Aav7cnU3LDnou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TVrvLyfQ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TVrvLyfQ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-463f1165e16so4310104f8f.0
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 02:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782811545; x=1783416345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mWXuvrdGO01kY7ek3iU/KtbfaHe60/89WOqzzwryweQ=;
        b=TVrvLyfQwc3+F+jRXnep9Fg7/SFkJEXOu+8FIABM2thMU0vNZpmwtdrSA6XgAlVa54
         k2X278Zt4Fio54NQ0qp0ByXGFhXxRaB5gxCPSZo8UQvHTrMI0V7nQ/e9B+PxwZyLDlD7
         2bWeYh7opx9+iu5n6ynD33Xg9Mg9Ypb5KPk79JeiWKOwN4QZ8UG5jF8bFr3ugtaup1+f
         lNVrygSGPYt/bRg4LU/bO1GbjXxctFFHTh8MQdI0uBMWthmCVy6gjW+00f0Ptegou8MW
         pe/dFTy+OVGppovYsN3TivEjBO8+333ScyORHJ2y41nP90SntXHcEK7mdn2hbvF2R9Iv
         Eg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782811545; x=1783416345;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mWXuvrdGO01kY7ek3iU/KtbfaHe60/89WOqzzwryweQ=;
        b=LcK5TmsluN/EGMlaIqzrfpqvFM76D5J4Gb6v76YhUqZ1SEcMDTQl5vIwlPKwpFPbZJ
         FV7x9TW7mEpzFTU2/i6t4vB6d6aM4aCuAxi4V9fy9hL8Yj76MKzEFT8VJ6LUWZWW0wO6
         tFtTrOuKjPkbkfZKZp7LuzTZ/DF+eMoRPEl3dCb9U16/3kNW2feD7JTW7EUxSgAZT+I+
         MpEgnaaWYeCi+t0yUFazFX6d/N713/msYN5SlaD7pq6kG85mZscNgCwfMBGvJmX5OHqz
         XS5oFMTjIhQEKzdN01/9IxVI0mca3W4aj3On6Dt+Z0eSd515jzV/gjfknQOc2l9U8yJI
         dfHg==
X-Forwarded-Encrypted: i=1; AHgh+Ro0pbCW96M3Obdc2PxkcuikddlDlkuihOE8Dc9RlfTaE7l13Hf+c6bkG5YhMlJSAVFNkTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOXxGZF5/tJWFtJQW+pxwMqS+LqVn0ivbT+w6QCr+LXz3DDMtO
	anjWOsKNwrfTmPWiNn0gZROdvuHRY9huz3OIiOUhfaSrsMIVRmb32srz8BXwalCihKU=
X-Gm-Gg: AfdE7cm0MRvPOfpJYeIeNY86wghyOkD98g41QCBbFLW+VMB/sC6v1b7YtofowMSwFey
	MSocAf/YNLLGdBrXrQi7mwHVO9m/t7kBAGHih35Fkq+cRSx28KP/64NM8z/7Sxz7OH4Ya4YncUT
	hwp5G9ss6bwdy38NEOlPutDDhK4bI91AlI6/s53g1WiikXt97Ws5u2vGXtMn1U2VWxaAYAKo7ls
	QrY72J0Djvlch8dQn+oHoPP9SkqZqWuy1XCl3ASMmcJAYsNpMu2hSqnxvjF4biombawfXM8plBu
	wKkHYZzpVSuY1oG+HRCBapmujJiRUkeSIXwQUdIH/acd9vIfPi8Cdi1sd3BQ2j8rM+1klrzFmgf
	v4UHgXHSHMfcgj5GKuFN6WwhXPlbZ4Umb1K+9cSHaL/p0vp5q82NzjSyyNFHawwUVWt5LDAaj9I
	UhBhksQURnIDSivakON5Sbg40iciesMz/r1Lt/x6zlU6wKhuGldOFgotBmljN51r/zWQ9p1++tD
	OBX
X-Received: by 2002:a05:6000:430a:b0:475:2171:ac1 with SMTP id ffacd0b85a97d-4755297271amr3571604f8f.32.1782811545165;
        Tue, 30 Jun 2026 02:25:45 -0700 (PDT)
Received: from localhost (p200300f65f47db042c439d749f38355a.dip0.t-ipconnect.de. [2003:f6:5f47:db04:2c43:9d74:9f38:355a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-475671d0403sm6335542f8f.29.2026.06.30.02.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:25:44 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v4 13/17] LoongArch: KVM: Add include defining struct cpu_feature
Date: Tue, 30 Jun 2026 11:24:32 +0200
Message-ID: <052feec0e04ea8f5b2706a19a5b236679eed0aba.1782808461.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782808460.git.u.kleine-koenig@baylibre.com>
References: <cover.1782808460.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=/L0JztPl1fAH1NKvIkHQ2Z8SbljQvBWmCee1fQtoXjc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqQ4tpQQNXJcLb2chDA6Rfwf/Tlj5ry8+TBqXEf yRqVuJ/alSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakOLaQAKCRCPgPtYfRL+ Tn3UB/9dZ07ubgytZcCLAH8wn9bojhx3+qaDHyC3ka2A956syohAPk4ZTqew39mkqYPxnq4uFWi 1ME/nf+U6xtadYh+K1L1irdpQa1bYXgaMk3MIhNLmqtlqBIdb/KPgYEQ1vyhmE6dns0DdFNdonc R+1PMNywpGP+Z8d7ZejYO3tKP1JE55BeyNAMfRpx/dmcmnVUJ9kWaLxGKJ/lnBoBMHxHcf1EhtA rX0bScMIfWHIcFnQlIjHH/tzZXOcPVULstwVrUU9+7bfDRW/67PGP91QfB9yySiFKep7POcfrpq NgiiMoeJlsJn2SUVDOLwxkAtFkFr4nqwTyxE5ArBsxOsyb6j
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Traditionally <linux/mod_devicetable.h> was a header defining a plethora
of structs, among them struct cpu_features. This was split now with the
objective that only the relevant bits are included.

Currently <linux/mod_devicetable.h> is transitively included in
arch/loongarch/kvm/main.c via:

	arch/loongarch/kvm/main.c ->
	<linux/kvm_host.h> ->
	<linux/entry-virt.h> ->
	<linux/resume_user_mode.h> ->
	<linux/memcontrol.h> ->
	<linux/cgroup.h> ->
	<linux/kernel_stat.h> ->
	<linux/interrupt.h> ->
	<linux/hardirq> ->
	<asm/hardirq.h> ->
	<linux/irq.h> ->
	<asm/irq.h> ->
	<linux/irqdomain.h> ->
	<linux/of.h> ->
	<linux/mod_devicetable.h>

To keep struct cpu_features available once <linux/of.h> stops including
<linux/mod_devicetable.h>, include it here explicitly.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://patch.msgid.link/dd99dd31bbdb74884b27ea940e76872913b6dc1e.1782682124.git.ukleinek@kernel.org
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 arch/loongarch/kvm/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index f105a86143f5..aa0fb4c90d90 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -5,6 +5,7 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h> /* for struct cpu_feature */
 #include <linux/kvm_host.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
-- 
2.47.3

