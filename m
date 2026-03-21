Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454A1267714
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051794; cv=none; b=fc/bpplCcp7QM4ysIIBI4L4EGw2JZHyIiwKKNCibOxm6DdemEvp0bR4n8TWyZMLjRO0JodK+YUMIcmREAq0SvfiU4JJg1CwFlnt6IgfquKy3xN7ttIL4CE/7tnhL3pCFOoKney3SD32s/sKsNQsMeb8QyAoYK1Px+8FwXPyLwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051794; c=relaxed/simple;
	bh=7NaJbF+V2W5Ta2GDLeEGbucPkdKKkGGF8s6b1G42ECo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URIIS6YmFINzmdbDyKNNWnXl6QOIA/AIrkmt8T5sAw6dcHfTciJcTw/ZhUuylf4CXFG928Q+hDE5nzSRpnjiH872vgj1DqyQVPiDlkFoBUit/N6I9ExA19+BJvuqbD4QR3e3Itu8REx6lb0Vle6uOj5ubCGYcuMEc/d8YjDyCVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acHecEud; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVSM7fAU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acHecEud";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVSM7fAU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBpdMV64mgMJLmufv84JnT4W5g24GEtGQX6G/w72xZk=;
	b=acHecEudkbqStrAmMI4SoKJHFMyNDRGT/E3pvWmQNqa9CVTUYx5lpXNYJfM/y1onnfBFkt
	0ZCY4zVXMDEeuYVizTtC7ZSrBMEgS8DO+JJcNqHvZCdClBIoUAwcOzHst4DQl7mqwMMSvs
	tgruBX1jkkNMoAiYDYyb50W4j249UkI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-zghKpOKUPV2QBZEGF_amJg-1; Fri, 20 Mar 2026 20:09:49 -0400
X-MC-Unique: zghKpOKUPV2QBZEGF_amJg-1
X-Mimecast-MFC-AGG-ID: zghKpOKUPV2QBZEGF_amJg_1774051788
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4852d27f473so13826935e9.1
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051788; x=1774656588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBpdMV64mgMJLmufv84JnT4W5g24GEtGQX6G/w72xZk=;
        b=SVSM7fAUakqXcRmlOu94NTAtvNWl3b84CW72J/PBLOQwXsXl037L2emYA722VzXe5/
         OSCZwbXTTYkP/znpwve1eeCkq++ZAM8KLwh5j1D5G3klGuFO98zuL9Uf3TL6/RvAREgg
         xmEQEc3RxNkZhXRX4lIxD3QSWCX/67YKcsvxWKsC5qIKrZuyidTDjM6BXisVBgmh8qSw
         wfpEqv02yhOdulmC83BZdnb1vyQvMTDcqCxXmaliySxbSPQTbGgsj0UPRmy+WrtNKV3P
         Ina6bWy4uOIaQ+KS0bk0qrX6wEhdc6Wh8buUanwAx9i8W9TcOiuWZ6vWnRZstUpZij73
         JBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051788; x=1774656588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DBpdMV64mgMJLmufv84JnT4W5g24GEtGQX6G/w72xZk=;
        b=ONaLPEJKdyq9g1t3SJ7+fKmGIRq7T3FlNuzGCdZhi98GppRS8ysmgSsWDwKErKonyh
         O2Kx5QWqfRwyFa7KV/6W4J+LiEoMFaBmTsBNf1poAOvWhRYkZGLTv8tQcdEI3vlZMgns
         PDZ2OS1GXP9j12Uon4aHcOovigNLbYxZEr0WMdg8fEC9QymDfCyWJmuuusZXOCfWTaVl
         s+4mZK9bjoIthFlCRIsNjBmnM4rbAj5o12/gdpFjRZ2el9R1dBVqG9FsgMom9reMh4vc
         UTNt1bbt97yeUozbiCUIj8Bs+oHQIuIBIgE5C8gcV8ssF+bGCBG7ytAQHZFOVjlyq2Az
         xKBg==
X-Forwarded-Encrypted: i=1; AJvYcCUzu/VqLqaojZdHYZIB6cBN3bs05aGK8hQlUEeWdAVlGiYZmRoTEvCDwUC2n6m7ZGHnuv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYNgA/Ec1zQpZjANhj/i94CJOtVEbAkkENK1jeXKMyo6yBhP06
	T9OtdFhPr8nzZ1yI70R5DdUtOwg9blaHl2uF6sqz8iKEPZgDau/9sTNKdG++a3wuq4/1M1gxFHQ
	S1pQa2FqnaT1r+l8A172nF1jbNLtERsy3q1m56OSP5o+KrDc2w5AIiQ==
X-Gm-Gg: ATEYQzwvvq/lYE0JxQwH8OTE6NHkDn6ahZ56WhVhtnlfynlY/Hojr76iTZNO4xsw8Hg
	Zw8f/QNTWd4ArHiZAe93tW+hX8UYEfgC5es8hnV7aFErSdSY2+/fxrGQt02iUL8R/ivV2xoMHQR
	m2y9m7Hj7YDZii2INUs9VJmfxCyFEQylyNfzEtH7zkWRW2U7IvzpyZiie/qt2HZH564SYr0eP96
	T2YGUAQbBL6ob0uLAdORTVqtVKfZHiSL4ONHoKdFePah8LuAUHzJRdXDcVVjFwjyhr41nVjMQ8a
	Xw5et4mCEw8falUD/58oEHTnIfIInis+zyh/jGXmldColL5xdV2ygP8LSGHjJCTtXzwpIpme8sV
	N3CEhamRpHC7xlWsWzC1XcfD3OiS6b9MK+RssDRglsurql39Ghfoc8Ceu56aKlamRtFsrmFdgA+
	nwojvPOUfDQLd6YPmz9TzmyPtA
X-Received: by 2002:a05:600c:a4a:b0:486:fe83:8621 with SMTP id 5b1f17b1804b1-486fee1ab20mr57041545e9.23.1774051788401;
        Fri, 20 Mar 2026 17:09:48 -0700 (PDT)
X-Received: by 2002:a05:600c:a4a:b0:486:fe83:8621 with SMTP id 5b1f17b1804b1-486fee1ab20mr57041365e9.23.1774051787979;
        Fri, 20 Mar 2026 17:09:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7d6c54sm236718365e9.4.2026.03.20.17.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:09:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 06/22] KVM: x86/mmu: merge make_spte_{non,}executable
Date: Sat, 21 Mar 2026 01:09:15 +0100
Message-ID: <20260321000931.1947084-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321000931.1947084-1-pbonzini@redhat.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

As the logic will become more complicated with the introduction
of MBEC, at least write it only once.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index df31039b5d63..e2acd9ed9dba 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -317,14 +317,15 @@ static u64 modify_spte_protections(u64 spte, u64 set, u64 clear)
 	return spte;
 }
 
-static u64 make_spte_executable(u64 spte)
+static u64 make_spte_executable(u64 spte, u8 access)
 {
-	return modify_spte_protections(spte, shadow_x_mask, shadow_nx_mask);
-}
-
-static u64 make_spte_nonexecutable(u64 spte)
-{
-	return modify_spte_protections(spte, shadow_nx_mask, shadow_x_mask);
+	u64 set, clear;
+	if (access & ACC_EXEC_MASK)
+		set = shadow_x_mask;
+	else
+		set = shadow_nx_mask;
+	clear = set ^ (shadow_nx_mask | shadow_x_mask);
+	return modify_spte_protections(spte, set, clear);
 }
 
 /*
@@ -356,8 +357,8 @@ u64 make_small_spte(struct kvm *kvm, u64 huge_spte,
 		 * the page executable as the NX hugepage mitigation no longer
 		 * applies.
 		 */
-		if ((role.access & ACC_EXEC_MASK) && is_nx_huge_page_enabled(kvm))
-			child_spte = make_spte_executable(child_spte);
+		if (is_nx_huge_page_enabled(kvm))
+			child_spte = make_spte_executable(child_spte, role.access);
 	}
 
 	return child_spte;
@@ -379,7 +380,7 @@ u64 make_huge_spte(struct kvm *kvm, u64 small_spte, int level)
 	huge_spte &= KVM_HPAGE_MASK(level) | ~PAGE_MASK;
 
 	if (is_nx_huge_page_enabled(kvm))
-		huge_spte = make_spte_nonexecutable(huge_spte);
+		huge_spte = make_spte_executable(huge_spte, 0);
 
 	return huge_spte;
 }
-- 
2.52.0

