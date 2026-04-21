Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1279731F99B
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792622; cv=none; b=YEuM/rldAfpJqxRg3d5Ik6BROxDGa6qiWSME1k/oshmPCv0UXkHI/+kGSnJtxY6N3/+dw0wVbOxNMEyUj7CDoSR7k/nlR98xv+ZMbBvnkwKLWYDGRpm3Xy1crwJJ4EPmMXV+dWw7aCc/RiI6Ur3we2EmQz3JYNTjCXtqqCQQSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792622; c=relaxed/simple;
	bh=dspuxqTe419FD+lEMwkgisODXMHd/wKMI0WUc//Nifk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7QJRA1PudXu1AIz3m+6AUBvHTZFih8UilPNNO11khrmFVuhHjRrhA8uit57flXmQbvhcPmzZMIgycPtNUQzBeD0nAMQs5sgNTRWPBU+iRU2RoYTf3mYAwF6nINtEzosOJVcEuLkNshZKn6fL8IbP1DUrzs55Ob7w1s5BHfhgdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBT2W46A; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBT2W46A"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ba51e69988aso559152866b.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776792619; x=1777397419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tWn0gXFXwrRfN5iJsoKTIypDbNwmF/nvBWNaZZ5XE+I=;
        b=gBT2W46AV1I1wRnab/Rqz9IFNLyUeVAKx58wXTbQR/Tb2/PEjVkQK61TqEb6Rtgka9
         SkAfwEiPFT96cRQWE9wLVRTH+3p29cMLaw9PhwwyTlby2yMNn8sbm3UrTsHjI4r22DZe
         7SeaINNJfSuOnGwtrYreR+84s7proueTFk1qvgPVUG21khYd0FWPns+poUWroJbYJ0uh
         dXsPoqir3uMzWFdITMWysl1g4YeZWXjc8QqyJiF83vYhRdIfgvC36cIftBmHiOR+ajZT
         yjixrZmh1nKXpzEpjXG2ALOJV2+h+jQI/BU20RjTdarfKuU6OEFTFJ9lytbqa/i+pnnP
         kUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776792619; x=1777397419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWn0gXFXwrRfN5iJsoKTIypDbNwmF/nvBWNaZZ5XE+I=;
        b=LrwJqfO7YNn6IOQZXdXdanHli2F+yjox7blNiERRgerYOWg+0E9kr5eQ1jzPtW+3im
         VhO0BXkhQhDJH5+k4FVaMH1lushCs8F2gzv0jDGeU7xe18SLamyb8m1zltWAsLSpKl7Q
         ioYoaqcUapxsAvo9fDl8kBuusoqOzLVdDTYEklKGRzYxrLePAhhcs0B1zOVtcm/IGKoO
         TpBzK3u+GnpFi4p2Xp3GqTG4CpLeR7ILVKoH3mqoPvmXi0/01Tv4+FeoFal5jzNiOUGo
         SByoxpmeVDu82+xWgN6bSId770hK/VtJSXZtQnTdaMuviPqWUaPfw+XIvloXxTQU4BJ0
         kxDQ==
X-Gm-Message-State: AOJu0YxlltOM0Ch68Bvz9U3SusV0cXyedqXyBIniVmY8zzyLQl308x35
	Oel22pcXNvMpX8sg0oPiNbCL4CuWkiY1kWywcMVCS9lDQpTXwTcqngk37VFdcP8knSk=
X-Gm-Gg: AeBDiesBZZvtX/NcaWgwZFV0+I0qawwRll9EenVkNPZVy+kbY9mRZokSBu4rs9Ng1/U
	e1X6+7TvmMiinAV8y9KZYwifLFaBHp5keUiV352aRsjhFYRST1VsVG6cTB3P/J6SJqkepQm+Hgp
	1HRiq3Si9zsmB+ucEbJB+cutUJ5o58z6F5V1tg/tYKnUH6uqfg9BvsszNH9Uo/2lksit7Zc45mH
	PlOoanxFGHKpCzjKgX5SImgJIs5kaV9opGeM44gM29ATiAK1R3fgVab7LIJji4mmsp+FKxgfHGC
	Ac+mgSU4TvmM/BVPFGpa3UqOriA23nWQEK1NwaWNM23jx1GexZtpc+zU1G3eRkA9KHl1PbZ06Sn
	r59d0SrZOieVscUK6ePNUphQjz0dvvKIRLWD60vQfqbmqacCCgkwOGzJsmrNK/zXLO0dO/ILe6K
	lWhfN391I+p046A4mpthXX+U+oa0hH7wkqyUu3LXPLJEPx5g71/CLtotNQs+nMB2XrL3p7oU0SF
	gMdoU4WF/hrJjpl4uDaRBIpICWEd+UVznQEUw==
X-Received: by 2002:a17:907:9629:b0:ba4:94f8:4df with SMTP id a640c23a62f3a-ba494f82009mr829389966b.17.1776792618257;
        Tue, 21 Apr 2026 10:30:18 -0700 (PDT)
Received: from arch-piotr.tailb7ebba.ts.net (226.55.classcom.pl. [195.150.55.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4517ec776sm475683266b.16.2026.04.21.10.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:30:17 -0700 (PDT)
From: Piotr Zarycki <piotr.zarycki@gmail.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org,
	vkuznets@redhat.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Piotr Zarycki <piotr.zarycki@gmail.com>
Subject: [PATCH] KVM: selftests: hyperv_tlb_flush: replace NOP loop with udelay()
Date: Tue, 21 Apr 2026 19:29:53 +0200
Message-ID: <20260421172953.191345-1-piotr.zarycki@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded NOP loop with udelay() which was added to KVM
selftests in commit 6b878cbb87bf ("KVM: selftests: Add guest udelay()
utility for x86"). The NOP loop is CPU speed dependent while udelay()
provides a deterministic delay regardless of host CPU frequency.

Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
---
 tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c b/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
index c542cc4762b1..68ebd790ff41 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
@@ -141,15 +141,9 @@ static void swap_two_test_pages(vm_paddr_t pte_gva1, vm_paddr_t pte_gva2)
 	*(uint64_t *)pte_gva2 = tmp;
 }
 
-/*
- * TODO: replace the silly NOP loop with a proper udelay() implementation.
- */
 static inline void do_delay(void)
 {
-	int i;
-
-	for (i = 0; i < 1000000; i++)
-		asm volatile("nop");
+	udelay(100);
 }
 
 /*
-- 
2.53.0

