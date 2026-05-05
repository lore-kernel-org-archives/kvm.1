Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0183C197F
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010771; cv=none; b=N3BRWTMpL8KDKvIj3hoiwYppDSfUcymtJuhpbXvam17LWzX84YCJ01vTAFFM2u4phmbKcQanXVDj3/g6e35Xlp2gAFdAASRzkQvV74+dADJ7Eqn646+C73LVVJyIjBcBRuvmnDGn6gz56SjOHpR5jUbdksuP9fpihUPdLsimxoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010771; c=relaxed/simple;
	bh=6KNQirbx2Vihou6DaVeh7jHQnbN8YaGebFopG1grF8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgXaanJV95tDr2X1UjcG9tUtiKAsYIbgMUIXnzx1lVAY+2x6sZB9oalsKYa9s8F7TjzXdAS6hj1h405EHqy3nl/JSqCxrx1PqPHTsIltsiSSB40kgu9JLAKIU2KQ2Wvwl6FDo6gvt5ABA0c/cJnQCNVsgvbdDhKgfmoD4xVkRWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VCkKDDov; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C0CeIc2G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCkKDDov";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0CeIc2G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PYNfAaEV38buKctZeF6dh10BP+mDAO9Hnu887EwhKQ=;
	b=VCkKDDov9NB3/BxDZ+rthJm0D6f25gvli0ivYuQbACvqob6il2L5hnFLe2uGx/eRqVKCVc
	QpZ08SF90O+2/qZ/h9617vTMhIr+JXfxleWZW92t0HKEKU8siT4YKJg3tTnr0OkcdPEH/z
	zmbE08eTntPBNJzNRLv8L60Gdgo+Wuw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-aJHCrdzjN_GDvB4tyXfZ_w-1; Tue, 05 May 2026 15:52:45 -0400
X-MC-Unique: aJHCrdzjN_GDvB4tyXfZ_w-1
X-Mimecast-MFC-AGG-ID: aJHCrdzjN_GDvB4tyXfZ_w_1778010765
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a589c7879so1249215e9.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010764; x=1778615564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PYNfAaEV38buKctZeF6dh10BP+mDAO9Hnu887EwhKQ=;
        b=C0CeIc2G33zxtmldOXlZAMniqeTCWxhX6SppB9SXw2BUZ1pE39UypxnhFZYhewcNeM
         HJk9Aik+ZPNdUmuy9Rx5r6Arn/Lp1JiXSitm51u4XCdtHduATKZRWdWJpCAlazGgxhl1
         C0tg8dHRln1r6eUqyKF1Pv8Z/DUOQJXTP3x4Vu0xF6FREPFrzzppkdzELr1pYZGi1Bi0
         5bwlc9xlHRVZf5hfATBCKjcQGJrpCPACKcCLkEz5kanCzekuPrZzlRGuB2VC9BbTpN8u
         HvW3CshSzKCJPHkQoPDKOny+TntmBfgxdlgmvCKmVFPFvmkAtDMt2QOYNKYJ5Y2TqLJK
         xr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010764; x=1778615564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9PYNfAaEV38buKctZeF6dh10BP+mDAO9Hnu887EwhKQ=;
        b=NdhAAoRT6oXjKrNz/zxIERvsJ7dFVyIT81VbcR1U+cYqOwbKIK8F0gP+i3UyFjEY1c
         +Wcrb6Ke90CCZ8TiFSxZ4/tbRtGRoKKAejSIxie8Q/BaZfINTWONOKBJWteWmIb2jVgY
         Frmbj7T642L8/bb9TnZaeodB3Ic1s18l20HzJPTaJIXyfQnw+y2oKes7qX+74HVHGarP
         zXbDtOyu+mOS1VMTgqjE0IJTlFMdgC7oEK5sRqcMrC2sESfZKNUIP1QUlgL6CQGkRXaj
         92jbED5pKOpjFanpDZEXyDsOm4En6wD3Zhae5/da/m6QKM681YLqf5RcfCpfDxh1GnCr
         JR3w==
X-Forwarded-Encrypted: i=1; AFNElJ8ChtwgMQbnUjVj1utvOkydJLRn777CUUWhhG2rsYAX2MV8tw0GKakTXSk+jV/wmwd1DiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKQj8qfIIf/1SBETHu0ToNJG0S0vEXLCC6pYrKCeBe6DdEQtfO
	YsgmSXvRmHFC7LS43w6bofkV6axGKZE7JxqZRS/cSKmqEvvxqDBYDdKgBwT9KDQWsUYP4Bjz08m
	nQXYt05bTk66BZT16fFQWKDXVlaw6q9dB49PQRqgjezYEsll77gdmrQecGL6dZA==
X-Gm-Gg: AeBDietUuZlrrBNwWPJPwv1gonr6rHZ5ffnvry/y0KHsjNxgiCshp34a4nczIe1JnYw
	/Jr9CIivwbQfHvxhZHq+XN8N06NpzGqdAnMFUYnSWQCIQtxT4lzNCG+7YXXS6BuTMogEMKnQay2
	ER9jya3CnD93MYM63JhgnDfleQqlNI2cvUC+jb3VYBkYXrc3YEVIzNzPi+pqtGnyZh1OrVknkNS
	/tNORCqWlv5vYnRSfsFdIoWDQ1yveQOc0JYJ8sfA1sw4UlvaR2M/4VxSKtUOdE5f+LkMEJ5f0zb
	GvoJVU14vVVQs3SslPtQvawRZ00oYUwn/DdA3sy3nAFsnEkEbErRCWjP83JvbB/0y+R9aiNgfF7
	plHoDK/1rl0WEfdoYwg1KZslMHOulRrsmYMk2VgY7GinLmgIGlUhJK3DY75+/Qixjnd2QiVaAYa
	v3LOMYYOTEUjJS+D7xXEOINzReecgpizM6JKHw+ak=
X-Received: by 2002:a05:600c:14c2:b0:48a:65ab:8059 with SMTP id 5b1f17b1804b1-48d142725a6mr61497105e9.13.1778010763688;
        Tue, 05 May 2026 12:52:43 -0700 (PDT)
X-Received: by 2002:a05:600c:14c2:b0:48a:65ab:8059 with SMTP id 5b1f17b1804b1-48d142725a6mr61496915e9.13.1778010763358;
        Tue, 05 May 2026 12:52:43 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505238e7c0sm6115716f8f.3.2026.05.05.12.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:52:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 06/28] KVM: x86/mmu: merge make_spte_{non,}executable
Date: Tue,  5 May 2026 21:52:04 +0200
Message-ID: <20260505195226.563317-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the logic will become more complicated with the introduction
of MBEC, at least write it only once.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 85a0473809b0..849a1c1c92b5 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -317,14 +317,16 @@ static u64 modify_spte_protections(u64 spte, u64 set, u64 clear)
 	return spte;
 }
 
-static u64 make_spte_executable(u64 spte)
+static u64 change_spte_executable(u64 spte, u8 access)
 {
-	return modify_spte_protections(spte, shadow_x_mask, shadow_nx_mask);
-}
+	u64 set, clear;
 
-static u64 make_spte_nonexecutable(u64 spte)
-{
-	return modify_spte_protections(spte, shadow_nx_mask, shadow_x_mask);
+	if (access & ACC_EXEC_MASK)
+		set = shadow_x_mask;
+	else
+		set = shadow_nx_mask;
+	clear = set ^ (shadow_nx_mask | shadow_x_mask);
+	return modify_spte_protections(spte, set, clear);
 }
 
 /*
@@ -356,8 +358,8 @@ u64 make_small_spte(struct kvm *kvm, u64 huge_spte,
 		 * the page executable as the NX hugepage mitigation no longer
 		 * applies.
 		 */
-		if ((role.access & ACC_EXEC_MASK) && is_nx_huge_page_enabled(kvm))
-			child_spte = make_spte_executable(child_spte);
+		if (is_nx_huge_page_enabled(kvm))
+			child_spte = change_spte_executable(child_spte, role.access);
 	}
 
 	return child_spte;
@@ -379,7 +381,7 @@ u64 make_huge_spte(struct kvm *kvm, u64 small_spte, int level)
 	huge_spte &= KVM_HPAGE_MASK(level) | ~PAGE_MASK;
 
 	if (is_nx_huge_page_enabled(kvm))
-		huge_spte = make_spte_nonexecutable(huge_spte);
+		huge_spte = change_spte_executable(huge_spte, 0);
 
 	return huge_spte;
 }
-- 
2.54.0

