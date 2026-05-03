Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF73A63E6
	for <kvm@vger.kernel.org>; Sun,  3 May 2026 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777842567; cv=none; b=JHFTZwhfwpGt9vVyES2nM+pXqnp5KSeR318+An7YK1Sc0YfJUnH6L638x8bJUFBxlxWc7fsokjsvShlSCxI7eX8EDjHWDUXG0BdoM8kXd9V6v4Xqw1XD+oWA/26d9J3C82l8mWdMySQVM3swGfhZfYNcbxYoTZ/9ovugi2XVYYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777842567; c=relaxed/simple;
	bh=0newPD3N/3WFEW40SIqlPKlRbdyu8K9sCI4I1XiRtac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lON2yVZGJaPAiNRljsxVHRdWT3M+YQmrXV4+mXRRfIDK4paOZJaqhZdmz/OMoav4vDalcLO5gmumJWOJQ7BzqhHy+5UQhG5ld28O0h6Qy0EWgPfu6vjQfuQ8aj3tV2oOJ9zYXoh1YTSS2XuA3b9pupzUyUn0K+oKVG9sRnuPEkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DiE3NxpS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKYzwHBi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiE3NxpS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKYzwHBi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777842564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kk2Au5rLiT2XVCKBKjlR9NIFRQn0TrH+r2EEhpbdibY=;
	b=DiE3NxpSR/4JmtxuSaIhLXP3kogUIVvRGn3mvH3nXMkF8weoWAQj3XWlxibK4iZSXJqie4
	SoqLDAC3tYfwWhDlE/oqD9SE/ix+VvPlNTN2fbl4S9MhcZzEUTKcTYqWVUbo+3qJq28Mft
	mv1f8ih8gxSULSdSnup40n4PdfE7w2U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-_CZhstoxN3SCmuPiN7sNRg-1; Sun, 03 May 2026 17:09:23 -0400
X-MC-Unique: _CZhstoxN3SCmuPiN7sNRg-1
X-Mimecast-MFC-AGG-ID: _CZhstoxN3SCmuPiN7sNRg_1777842562
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d0677b5f7so1823615e9.1
        for <kvm@vger.kernel.org>; Sun, 03 May 2026 14:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777842562; x=1778447362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kk2Au5rLiT2XVCKBKjlR9NIFRQn0TrH+r2EEhpbdibY=;
        b=XKYzwHBiNFvaucI8vJy/ldiWYEFWbJaaUCXk/TjW3Vc77TT41Ln4pV78fNYRB2Sdwy
         BatAbiiwQI2iK5H96uM34WOCTMHFGc82o6OCvu/FlxX3BemiagZEKgomhtLdaAVTMrW7
         j8DYuUKoT2MS1+doDEjhp2/XQ4I2eHUiLLVme7VTKVWxPAWusEfDPkIn120B/qua+0i4
         q8/upFoX69nrxVOY4vi9An+NOOYvG0/w02zWKvMsbcjg0ZtGCskK/4IbJTncXkzj654s
         Os56UL3WK4HfaaOza/a0o2YVyt88IQY2J1jFKGgAfd70z029/io5cH/etGCSmeWReHf3
         c+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777842562; x=1778447362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk2Au5rLiT2XVCKBKjlR9NIFRQn0TrH+r2EEhpbdibY=;
        b=cC6BEylYSyS2UIc4L9X6uMUyPp9yAojttUx52ekaD8fhuldKUIk65bhJrqA0qWG/Da
         IoEsHaMZAA/xYbnNveaozQSKHbADnLTIxRUTA/LctCRrhq77lGJvPCQy9zd3JZyHLLBk
         GYs+eGVGCajcjtU64Sg6TK2cxECg9wtM0zHmmI814ZZKZSFUXk2WaKgbelWolHAD1jSf
         pcKmOOe27fVj3iivpnZkmLi0aP5GTJa1/IL8t/9i2guMNxGcfVXdRWPLDEGMP/LsNdE/
         9WU+5Rpm66muHVF0fBybPGORxzMLRUEwuwPpV+boP9fiZurKhVjuhc3c/9JpQc3L/AR8
         zriA==
X-Forwarded-Encrypted: i=1; AFNElJ+QegorSKct4NxVOtP8yXzwSFkQRBbRxq0hiv6uTEIIUZ8fAOKaVH1Ksf7suv3Zm0npixI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKODIAkpEAje0LY9o4g9sWkJ/6YL+HZ5LLlsio/bCaj2a+tSiC
	4RNlzTfhqg6p1sknooHmKDx8Om5Qmk0you4KED88tzVO0O4X5mNQKbawU1KCtDULrdvi3D9mPaG
	D/4OJz/iyeuDVVoFlB+YY0YASE82Yb/But1w2Dw1c1vdORyKzJmWtzg==
X-Gm-Gg: AeBDievfw2yRdh+8bZDkRmELryhhYmSzI33wOH9PP82AosCMiJgPqA23Te8yqNwN0LF
	KXPnddVLyxZXsvkDATwNXi4VP86GsQvAiUCEY+F4wQcD+RuOEywviqAsg7P+w0vN1fPVw9iqUhY
	PbHtH8tTmh95f6jhSfuC0VRmGp6KkGn5joJ0yV0cwP9/KThMtqJhIPaJiXd3spzWSgw/XnXKxXy
	Vzg3mQ4B+UyGfSTSpNb4REs1CktGzTCjKQwb+K4QL+FsiFGa68oSqHHDpf4izNeKIlR+Kk1o29l
	TIM4jpKRLsErzhQObd50KTvR+4IvSPmRr5LWesO7BiGvGG30vZMGdLLb0tTeTxf/uoNYHUp4yMS
	rE27c9Pk8Q60DtGrzu6TwWrfodWDr3JY5FnxV6kDqPXlK0ZRAACXUX20y/GW4zOcHlw1JWPDJue
	4bQN7HBAk0ahd1PG6fBrrfN60wsNPpgxO51fs=
X-Received: by 2002:a05:600c:a402:b0:489:a4:e555 with SMTP id 5b1f17b1804b1-48a9866064dmr90338455e9.21.1777842561930;
        Sun, 03 May 2026 14:09:21 -0700 (PDT)
X-Received: by 2002:a05:600c:a402:b0:489:a4:e555 with SMTP id 5b1f17b1804b1-48a9866064dmr90338255e9.21.1777842561538;
        Sun, 03 May 2026 14:09:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee4db3sm64634675e9.23.2026.05.03.14.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 14:09:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com
Subject: [PATCH] KVM: x86: use again the flush argument of __link_shadow_page()
Date: Sun,  3 May 2026 23:09:17 +0200
Message-ID: <20260503210917.121840-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Except in the case of parentless nested-TDP pages, mmu_page_zap_pte()
clears the SPTE but leaves the invalid_list empty.  In this case, using
kvm_flush_remote_tlbs() as kvm_mmu_remote_flush_or_zap() does is overkill.
Avoid flushing the entirety of the remote TLBs unless the invalid_list
was populated: instead, use a more efficient gfn-targeting flush (if
available) and skip it altogether if the caller guarantees that a TLB
flush is not necessary.

Based-on: <20260503201029.106481-1-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 892246204435..85bec8eeace8 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2541,8 +2541,10 @@ static void __link_shadow_page(struct kvm *kvm,
 		parent_sp = sptep_to_sp(sptep);
 		WARN_ON_ONCE(parent_sp->role.level == PG_LEVEL_4K);
 
-		mmu_page_zap_pte(kvm, parent_sp, sptep, &invalid_list);
-		kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, true);
+		if (mmu_page_zap_pte(kvm, parent_sp, sptep, &invalid_list))
+			kvm_mmu_commit_zap_page(kvm, &invalid_list);
+		else if (flush)
+			kvm_flush_remote_tlbs_sptep(kvm, sptep);
 	}
 
 	spte = make_nonleaf_spte(sp->spt, sp_ad_disabled(sp));
-- 
2.54.0

