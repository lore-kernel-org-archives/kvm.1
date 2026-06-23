Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E481F31ED68
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233596; cv=none; b=qbrlJkNMKs+ruGJcrVUDiMPdq4A3tk4APdKOcwXlWj8LfYTxhuSFDiIXL8BsF+A9aCh9FEhKr0yrgujnqf5eATGQ2/whCSwy3tjljBjCW41KEBtLHvpWe+4teLF1vH9TbGdVUpR6LPgnv5l9MXKquhvulCPk12N85550yk5jRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233596; c=relaxed/simple;
	bh=X/io4ySPfDwb1pkHvDOFfkMN0FkdtRCiADOU2PkFWS8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AJCLqy19s2FxoJoe2v0O6OOgnwgrXAHMWjIdmbYCbmuHXCO3N0KKxC3ZwsTxY1X15La4l/4n3Xa3hZxjhUQ7rGRP1BG86eN0XyBlCx+Rdqjg4cITQ8t5nNZwz7I7mC9fHINkMtaYx2u4lMPz2+aSSoq3o5NxhrXcjulz67LKdy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com; spf=pass smtp.mailfrom=digiscrypt.com; dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b=I118f71F; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b="I118f71F"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso698185ad.0
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 09:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digiscrypt.com; s=google; t=1782233594; x=1782838394; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9QHZ2WaY7evBGc4EkxyidWgi0vek09yM5hajCIFcwqA=;
        b=I118f71FffoTZW/xirIDfe6ToRwutRabbeYoSTltrAA4+gj/tE+spDYLI5OcL5F2dh
         7UPvh9/Z/B0Ciz37NRQss1cUmG/0joaVMqXiwA2xwcRbcNKr8+BZO6kcng9uFbBEGCAn
         FXomMNhlZPwJr0VzfQqooNDdEVDWP6JzbEIDXM2ZhqcBcG7qwppYlorTIr0YrSRUdsVO
         /GXR10Nc1x80+P5TJegbhqzQEh7xK8G7TKbb1nXIeAYnRwHVdCeF8Tw91ScWDgcphIMj
         ESq2bdRVUMAACQOSlprskKorb/53fSEian+hqgsEJFPHN81ftnMaC1mFyGjiGglM+7/W
         +nNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782233594; x=1782838394;
        h=mime-version:content-transfer-encoding:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9QHZ2WaY7evBGc4EkxyidWgi0vek09yM5hajCIFcwqA=;
        b=iJjBNxIc/pUMxkqs/c3sHIAnE72AUgGTNyzCxGH1DnQ9Q4LIYlTGmEdL8AneRHQ2LT
         wJrl0qyandPfraEQl5rVRT0h0bSY+CmIml0kS5YKKQUOe4HjBQqbVuZXsPx/iaBFoe9c
         YxAWDH+YGHrqljGayLdZYYzA+Pb1ZneTfkzF4XzxcCf30ZGMX7L4rFGNOoA0SdWEuRR3
         BwNIsMgsXnC0r4m+00XKGnUylOoDs9YsEn+t6vfJ7b2NKQyHbtZbRzxNqlJQ1KHYr6pI
         bQIVX4GFt2sIUAWgtH0B+GIQXGMXOw26rV1nSCZVMK+cspYXyX5BBJ1yb2Kh57Vmm6CY
         w7gw==
X-Gm-Message-State: AOJu0YwORHqHQbuV0aNzK/KkzFYr+VY8UN3zboWFo8eme4Les4+TppgY
	YydsuTo29QkDyd0Bi2HiP/prTiTUSGHlDSI3BLwW92WeClCaP9eNMFEynOco3MbjXF3/BXvxtuV
	SF1qE8+ezAhc=
X-Gm-Gg: AfdE7clF67z/G5uqXbGpjoQpBOoZ8LwxeG7+UtxzKVzyYb/gBghbz+IAr0OfzojZlOR
	hbdDHpi+VMJ6Op/Iw9cIG3HjmLQba3EasOC4sDvvLw4FfQpmltR13VhQH9L86OlZMlef/8oBEe/
	tZRp6M3RBmF52ZnyrXKLoF0UuDOi2+6M88IkQ2jg2O7NUByPNsJ04dqWLTSgCFPuiktfs9d+HMT
	wufzHAPaqYp7ISkWuMd6ze4o8IJY6tzeE7kyhbg6oGViiiwSh4MkpDu00HeJy1IInsQtE7Y2IU6
	l6dug9Ijec5M1DlsJG51d8g+LyWs8ZZ1wx9ZTNbTNSNdWCG2A9+UAXEb0rruSlMiIJ5z7ka93Ff
	0N/LXpKiz8JFsTBLMvR/87YvewFCn7oFgPk6wW9u2aFIUic8AsFu/tGuhKhdb3EgbkzstcTXC45
	ER6l/jFyusA+lsDU8M5cc1/gFF+JaFIue60OttWjuWepjf5uN6HY81I2+H/Q16mZjlkX18tz1t+
	9BELvJbHumLsZWDfz+nmAOmCqsJBDhvcQC094kOH1k=
X-Received: by 2002:a17:903:3b84:b0:2c6:ad70:d870 with SMTP id d9443c01a7336-2c7c75c1f7cmr44193815ad.13.1782233594014;
        Tue, 23 Jun 2026 09:53:14 -0700 (PDT)
Received: from 3.1.168.192.in-addr.arpa ([2401:4900:1c07:46d8:110b:11b8:fb24:5255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8e51sm126524865ad.39.2026.06.23.09.53.12
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:53:13 -0700 (PDT)
From: Naveed Khan <naveed@digiscrypt.com>
To: kvm@vger.kernel.org
Subject:
 [PATCH] KVM: s390: gmap: protect entire guest top-level table when shadowing
Date: Tue, 23 Jun 2026 22:23:10 +0530
Message-ID: <178223359030.58041.119573473883113694@digiscrypt.com>
X-CodeOps-Marker: cc0b50571a094a86907236bf39c287e2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

gmap_protect_asce_top_level() write-protects the guest top-level region-
or segment-table so that later modifications by the guest are noticed and
the shadow is unshadowed.  It faults in and protects asce.dt + 1 pages,
but the number of pages occupied by the top-level table is given by the
table-length field (tl), not by the designation-type field (dt).  dt and
tl are independent fields of the ASCE: tl + 1 is the size of the table in
4K pages, while dt only encodes the table type.

The rest of the code already uses the table length.  The guest table
walker in walk_guest_tables() bounds the top-level index with asce.tl,
and _gmap_handle_vsie_unshadow_event() computes the table extent as
[rsto, rsto + guest_asce.tl + 1).  Only the protection step uses dt.

Whenever tl > dt - for instance a guest using a full four-page segment
table (dt == 0, tl == 3) - only dt + 1 pages of the table get write-
protected and armed with the vsie notification bit.  The remaining pages
stay writable, so the guest can modify top-level table entries located in
them without triggering gmap_unshadow().  The shadow then keeps stale
translations, allowing the lower guest to keep accessing host pages that
the upper guest's tables no longer map, breaking isolation between the
nested guests.

Protect asce.tl + 1 pages, matching the table walker and the unshadow
event handler.  context.f has room for the maximum of CRST_TABLE_PAGES
(4) pages, so the upper bound is unchanged.

Fixes: abeb7eb57f16 ("KVM: s390: vsie: Use mmu cache to allocate rmap")
Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
---
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 77829f787d..e1e734cbc0 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1287,7 +1287,7 @@ static int gmap_protect_asce_top_level(struct kvm_s390_mmu_cache *mc, struct gma
 	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
 	smp_rmb();
 
-	rc = kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.dt + 1, false);
+	rc = kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.tl + 1, false);
 	if (rc > 0)
 		rc = -EFAULT;
 	if (!rc)
-- 
2.52.0
