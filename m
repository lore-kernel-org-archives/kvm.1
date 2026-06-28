Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFF13C09FC
	for <kvm@vger.kernel.org>; Sun, 28 Jun 2026 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684013; cv=none; b=u/WtDkcnKvFGv1OzqzLGMiHeLQGBdlBur4iiIHXAioADEq0CbNth4bDZABe+dxIeI/oIKFNctU3pT1Ac5U5LEsOYUzlbjfLHyBNNiyhp1G/eo2Dly5XLuLu0tYCsdd1QFwjaU4hwUZJ6v+MgHcn8+g4E25qbpOy+Kv/cWOB3Bs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684013; c=relaxed/simple;
	bh=Oc6R7UQM4qh34RCqEZRqOVjz1IUFMNkzIANhoWIPBZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLoVjSGntp74ClQDnf+KQlfw1O87Sr2oiVTlTju+DARQwVubO+zkLFq8DWZzFqcHrfB04rSDLnygDB2o/qB7pyUEY8ULEF1qjG/VWx+c0ugMxg/VK9D8RvQlE3rc+DDLpI+aWDz639gI7lod+NFLQ6sdo/6SEyUF3J6N79O/DVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Gkyd1S8f; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Gkyd1S8f"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so24182835e9.2
        for <kvm@vger.kernel.org>; Sun, 28 Jun 2026 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782684010; x=1783288810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AS+EdeDaEwImrWWy2E0ShIJW/2Io69CWq0mFP0PBS40=;
        b=Gkyd1S8fx38R0PWMI95ghq4JCrw9T8j0iEXt1nwe0n3eY+4bQd5ajAJYj/H5iQ1+as
         iXUdzueTTyFDFObwPT6UFo2iPuZZAHEPypgdrgRCvnTaYqy5OafUNx6+eEi5dyftiH86
         L7YutCVeROA1bsPGr/T1rldeCtQOscUxCBwCbbN+BYOSq8bIwD4BsW3d1YY2FQrYBlT8
         KTPXUba491igWe4B8jOUKfDaYLjPNcHqErOihOR1O/1LJk5YuqUDyFjTb8HW6z8fdiqW
         wGF+9yUCpPoV/A7YZSUHDNW9VgL7SST/A00eoFzQp198b5FGUDopExJPWjVW5+HrXwh2
         Jf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782684010; x=1783288810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AS+EdeDaEwImrWWy2E0ShIJW/2Io69CWq0mFP0PBS40=;
        b=Q0E9C2y078RzMH0G5rKyqbXmNkGgf0aeVG1YaZQlzelUA1qrr/aWgxJvSlMsjg3BQg
         kVGqg2vrBIg/nSYxw04pPZbJD+qeeIvYdMDZktJhhmU5DpORFA7cLIB6x4ndNsCLSAfn
         9YoYNpixMOnECCm9leeogErPKfFNDQnpmy3asdSi5JaxV3fTOsUaxytNm6EieYkBWkF/
         J038+h4HywQTmrnarIHfjfm90iQ0pdzHKj5ClhOUFT37wDILnZ7DZBxEuXhTXBtls1pu
         Y9QnNzt7PKZiMOTrHo23kT98dEe4pkrCnlPskGTyH3BT19Na90Ac9eM0h5rJKPCIa+x2
         pxMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9a5VN1tFOReXmZvCEEJmVEsXXeEsdYpbUD3AvsAiwKXhwcusHLsOkxRzVPu9zi2HRMi48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNuxlGnWkqO5pXdhIa1/ZRl6v8tt8C4jvYgNCmHRAAu/g6Iwc
	B7aWPUaN6CuvIsRtkmZjIkQ4dXX4gO7n1cnTKu9aB4n1sSHjyxUO5DhwQ27moYUZnsM=
X-Gm-Gg: AfdE7cmVmQ4Zwiq1TBOZL0JcYS/2tCM5yubfc34yIZhehq97q3Flxh63KsnjHoZSi75
	CH0+JezbkHlk59pjhkO0hOPq7XTzasiBJxqcIuj2KiGj6Amxxd6jdR8RnOZfntL+7CzJ0UX0zZU
	DeEhf3IAwCuJVT366dp6SAh/z2KzeUbJKghRJ4sd037JevQCFjdVS6NxG2gnqMPMiipLTQpufqW
	fdMS1COsuh6FviOwy744UUjDYOXSYRKkDiTkUNNyMpgK34voTd19jlGv14lnTRpJj4GYxKpKuJR
	VqaKkVylkHSNuKde+w/g/by558aO2s9D0REW+cAz8Ftootm8Zz9w77328sNaUB8gBMb+SCAfoan
	u9GmUXGv6hz4QtdxwnLQ2JHbQLrUq/IKaY4eLYRSpw9FXtEP3Tuz0Z61lnMc+fsa25VRTjtku2o
	RO0QmRfIDn7ZAnXWIvrQ==
X-Received: by 2002:a05:600c:8b88:b0:490:e974:e006 with SMTP id 5b1f17b1804b1-49266893312mr215389855e9.29.1782684009710;
        Sun, 28 Jun 2026 15:00:09 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49268fde98csm279002625e9.6.2026.06.28.15.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 15:00:09 -0700 (PDT)
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
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 13/16] LoongArch: KVM: Add include defining struct cpu_feature
Date: Sun, 28 Jun 2026 23:58:48 +0200
Message-ID:  <dd99dd31bbdb74884b27ea940e76872913b6dc1e.1782682124.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782682124.git.ukleinek@kernel.org>
References: <cover.1782682124.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1416; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Oc6R7UQM4qh34RCqEZRqOVjz1IUFMNkzIANhoWIPBZE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqQZkyY6dxKuRGgpwtBcHnRi0GpzDaQgf8tazVa ctnH1YtHneJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakGZMgAKCRCPgPtYfRL+ Trz3B/95QuY+r6h4EgtXofXYOb8V+LmxmbXKiJ4MMxH0YTY/T4NHKPqQJv33FVmIQfpjVpcObHc LOCSvX4/fXum5e6qfqhTWhEFv+u9DbDjnjjgkq22QD4Ah2q6LKT0E2jl40W9vvUl3dhtVobogn8 sI2mBVkhjlQBCQNd/aSd+AWK7AsBKV+5bWPALiT0h30SS/oj04CVHi4nqNBnmVfcTJ3hWl2VlkY gCWygCCoh4wFZ2uks8bKYpvotoe1KXCCkWyuxgef/eoTGtR+O5ZT1r/SgZSOyLZrFsk0w8JbPWK rbI3hbbUEJ6HjNDzbXfh8d7XV16SXNMjzVipV+772NXO1h/8
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

