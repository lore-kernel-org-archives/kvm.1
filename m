Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DFC3B9922
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496912; cv=none; b=O96RPRpfvlaXxuq76m2AKQxDBk6JWX2b3uZPliNzPTDgYLOLCeToZ8TYqt8VXJWZCoJ6ZpSbA9gT4AAAjAC+4/lZS96/gR7QGiQQseg/XftjMbmLC2LCTZEpZOrLR3ow5mUSw0NwEYegQdAQgm64kTKAhSErUEI15fCzmDSrvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496912; c=relaxed/simple;
	bh=aA0A5I2lDTZ+3fuKrSnqtIKoZ5aG2/MOhsZpVD8zJV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCSpeCRCqvOt3VB+ANvmQpM0PUG9XGDgbIoxwB8jQQAzGXvPsMzTS7adzth4NnZM+k5u1Wq4CLHhZ+UOcUHCSiIoUPv1aRyI5DJWyo0V2Y7J9FYUW8KDxAk+0OU09Ki7zJ2wafh76SFyDbDfablO7/egcwf+mCpUWNxvD8nQn1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=cN9JrMHH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="cN9JrMHH"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-463f1165e16so1250223f8f.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782496908; x=1783101708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2RX9n3O90HDR3KKKfuve+ljOjDu+EQUCUgCqbYAMF1E=;
        b=cN9JrMHHWExW1yjI/6LOQslEIKUy31cY1xr4d2bt9zNsT8MI0XCkcCy6kDSO9kGOKo
         krsERaCt40JmlXh4S8rhg+Ku9G8aZ03JqvvKIm0qhyH+E9ioi1+OjajYVqeiXUEj06rY
         jvyy+2sflB89vV5M+ocZWpxWxcIs2c2G6SSGfiCP0ePKK3Gufro+GJYR0pcOejSYoiD6
         yze0NDpDudvZQnaHKus2OF792MNWlVVHUOL4IQdFKVgMWcEOH1bPiW7jzFlHDmoTNbQQ
         HM1VtyScAmkfVcyI39xvulzn1co0EhGcEwbfx6UF9u+8SmS86NLzn145+xTFqa7H2Rr5
         nm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782496908; x=1783101708;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2RX9n3O90HDR3KKKfuve+ljOjDu+EQUCUgCqbYAMF1E=;
        b=Bd2v/+mxT2jCpaM6EGvxk23/kCI+nhv2P3E8Wrldt+gS0mFoh3OhIiDvCbelFfZJNN
         5wOcZoZchYHOpIGZ8HV+ERmeo7mfuX/0wuthvxgMJyDsEyvphG4qrI79HYYbb6hit/63
         98v2LxQNU7iPBIIpukDSAGiNHnEL5wgOk6sFNuiCTmv3oBciGhUSeuZdr+pKzXHiW29v
         GmKUyVfOAH55hHE9/azX/oZT1sVp8GbLDSvsQMBhu71uVvUbUsSkj21yM75//tZyDvfl
         FIg0SLMh5G+SfAOaXk9fllkbLVO8AANgpaZ+UK+Yv6X8XG20YlIaik2qt3APF/4yJNpc
         rEFg==
X-Forwarded-Encrypted: i=1; AHgh+RpaBZLCk0nFh3L3Fj8ONlMZVeGzOUy0N+cv9H8qnBIYu1MptZrg3KjP/EYt6K/nh7ZG7vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOdj4JaC5/ca47fbCHZocvTdnLF3vlQ2DJKN3qEMwxBJwnOq2m
	2okMUsN+pB2DhCNDesrG7UMszEmBDjkZUAwlrKgJNadpSklA2wc5yO1tCh3pJQhN9+s=
X-Gm-Gg: AfdE7ck99aLczRp25WGloTzB86kU9+K40N25eLz/XYQj0jd4igF+ilEJE6v3aRLqavL
	Bh7PrDDbMV10AiYJPSpOjIDkXbPJxmdfbklHxAr3SUravcsvCSATZLodgb7+dwx8BgZWRwS8mBS
	9PW5FNxmsJTKLTI8GrMR6rizslz//H6vkJIkCUe2P5mFxubE77MuLUb0lVmnipghqv5h7w8gsCW
	zAjsACY1eQIi5VNbAQOT9vN/roX/5XUGruvZzGUQ9DxCB7uk1PyRwsnYClfjszdsw27YgQfvYFM
	89NEdOnuLPl9z/GwzuPUEcHEmPYPTLKz5cQqrm5X7IB303ktdx/JTjHIheJP6rQr0+8cpG2bY75
	J0eL989IHVqLr8y39aB7VS+LdLfKdiTqBB0WLI3M9Jyjo/AWKO9IbpRozTHS7OnP7bK1w9YMX7W
	7Eh0MWG8L5P4DeK5QrYJP1PP4voFzVOsaDMe59K7NncrYPJY/Dx0uDr8XHWnkbT6d+cZMn/wXhM
	Y8uaYPKkas8wDE=
X-Received: by 2002:a05:6000:2512:b0:46f:f12b:e45a with SMTP id ffacd0b85a97d-46ff12be583mr1368867f8f.23.1782496908406;
        Fri, 26 Jun 2026 11:01:48 -0700 (PDT)
Received: from localhost (p200300f65f47db04b3606a871f5f1c38.dip0.t-ipconnect.de. [2003:f6:5f47:db04:b360:6a87:1f5f:1c38])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46f86c34d76sm3712060f8f.3.2026.06.26.11.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 11:01:47 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/17] LoongArch: KVM: Add include defining struct cpu_feature
Date: Fri, 26 Jun 2026 20:00:33 +0200
Message-ID:  <a6e37d1e4abc0d86ef53b763cbbf1f7cf9898d13.1782490566.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782490566.git.u.kleine-koenig@baylibre.com>
References: <cover.1782490566.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=aA0A5I2lDTZ+3fuKrSnqtIKoZ5aG2/MOhsZpVD8zJV8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqPr5ZOhBqzGUIytUOD5ZGIN1r+oKkcY9L/deLX uIj9VKfRLqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaj6+WQAKCRCPgPtYfRL+ TqPRCACs7sMhF30wJXTkHgak8YFIcMgH1Fnp9mip9T3hT6j8ONZSkwKfpSItmZW5WfDx9fsKnEo TplXVIffJ2ViqeEqXitjhzkEmdDXsPonrbGEexNSnl4DH9mq6Vf1VvPxzYTyDOdGyY6OTP+qQ18 ehyl0jShHvjpx54maIABQRC1S7LnREKiXXsfslJwnAzirRBlMxaHLq7mXjuox1xU1TL0MbadVj3 EitUzpL+808folx9RkqnZiUPd2+1IJOOgMee/ovEm/b8uBrL9go31dgL4YjpLM5I5RA+HOFjgkO 4Irh3U2vosSmxP337PkIM7kffPKH4IXohqVQgAmYXXpIfSRR
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

