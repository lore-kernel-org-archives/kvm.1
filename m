Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4DE3A758D
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549068; cv=none; b=LEE0sve87Rzx0lJPpEBOelxJiSOJYU8XFmGTLrBmi5g1RIOUwKEQScxfrOAlpY1QTVxNADnaJ91q2Unarum4x2NCxdRKPgBBGJdDjs5REBrdfocpCDSNXDpve3AYRuVo30NTuddYEv9OYuOHhY/aQj37816RL9jk3UlHyUagNKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549068; c=relaxed/simple;
	bh=C3056jeL2T8VZuCnAsJAFXdeOS+u5HTlm+hZkzVz0xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEcBThUkBBEo6ArCoKpEr+cc28MkgQck+dKSfQJdXnJ4AaU5umhLQrY2Be90ZyQ01RdpuCg/Lysl7LunT76GXFThj1sUPms6aLEoAImZcOeYOZJ7q8+g7jide7emwpSIav8jvYoQ8IvtJDACAZcVAJuZvVns8DgRpSoz4zbVygs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cv0P47WR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1qcyjcR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cv0P47WR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1qcyjcR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1aF2Xc1/2U0HH4M9V6/k6D1Qk02VU2RtFjLbY3oaWo=;
	b=cv0P47WRrp/Hiu6k6/Dmdsuy4CAG9k17qQfbZQI/zC2EXHTWSF6GtlOCTJAHtxm+Jzj5P8
	Gw0s7KdwUYb0Bh8Ct3JX+cJ3mfx8E6QYlqazjpJLcexz/mFLPT2NayjGjJM+zLxwVAnEBw
	WtAvrpedP5iyOiFdFmHgc5W1VIyilFM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-WeNYuQ_KMICfyah7NqsmEw-1; Thu, 26 Mar 2026 14:17:43 -0400
X-MC-Unique: WeNYuQ_KMICfyah7NqsmEw-1
X-Mimecast-MFC-AGG-ID: WeNYuQ_KMICfyah7NqsmEw_1774549062
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-486fe36cf73so12854575e9.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549062; x=1775153862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1aF2Xc1/2U0HH4M9V6/k6D1Qk02VU2RtFjLbY3oaWo=;
        b=I1qcyjcRLlMoRW/Xfzzch6JWpeA0ljlVgGIRNKosqyfdpw5I+ExD2XR2q4nRLgvN58
         AiS7DbzRxes+AH1oqWjk9PtuIxPwK4Cc2dkrp92xLjOjEgWHl1aM/+Go6RppDfqfITb9
         r5LbCbuYhyRr3iZA9L1xVO48irUK6PxbE7ZCvqTxJdHqWWe4Js+A3oym3otbDpWUgSSV
         j8SarEO4+OofAn+7sx5VviPDTzUr7iRJz5Y8toXNBcgCHDnJHPIz9LUuGJsDhcDXmO/C
         Ncf9TP7UcMY0SWRMx9VmoFbzS/wt3FoMVMc54Ouor0fYpCcTKE5I3whUuWngDldf3YI7
         UcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549062; x=1775153862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U1aF2Xc1/2U0HH4M9V6/k6D1Qk02VU2RtFjLbY3oaWo=;
        b=IKeUV1YsGyUbcPu/Ib3OeQUDyUrNHm7JfBbi2lTtv7Bho1G2N5w8DSILX/3omJ33cu
         dkizjN1rl7o0fzI7roNtxtfrdZY4XkDJFjs0K7/HQG9cAaD523P4oxXBKGVELmyRzSxS
         r8sXe6ST3KdcTpFrRNm0Psr/dhz23xlb64nQkbQmGIaKjE9DSypWG3CctRcImfnPio/U
         5xsxOgcOHnxvtCwt/JNyeIXgnkN6Xd5IsONGIL8gTEkR9z0OzJgnCurMf5pYG/rrQkW6
         6afc4trKyWVlUZQjRoZybyFZB/wkgH/R59NjwnQnAPT4ipfyFQJMITeP137DV6CjPlbp
         gLQA==
X-Forwarded-Encrypted: i=1; AJvYcCVpDDpRktNhXbfkmbDuX5GJY8vr2agQYCLkj12609fQ9uvXPAp0cG4bDYXMNW2qJ7EIiYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYcovs0LEccCcYpPdQBkivfi/UBApelSrwFi/Q4WaA0IIpzYE
	P27ecoBrVAwn10KzyLqD32UI0k5AJ0fXnZW3+xHOLaV23CR6BYa0Mj/fPn0KAXi+o1Hwc6qHuyv
	RUvHNf/F2mSlRY7+E2YLingY/5cFWB12iY+cl28l6gcYj6yjnB7fR7A==
X-Gm-Gg: ATEYQzx+OQw5PXNSlZpn4VY8YHrUDoQWjp0scysjYmd9DMEej/1zSdpwmZPUrOursNv
	KO1Civ/uq8otHo6OI/aK2C/K6+oFjkLH58Sr0az4z68qjv7hwrIHQgy+NUxAzI4oYt7MeRkSnr3
	8EB6KgdHpaKpBXS1JRkt06435846trK6HjrIX7VJr/uMSVyO3NtbMcSzuBmERWpKC0mh0Nmz37W
	lN1YgS9Tvs7VbYvxnqUuiQ2hHkRbfm4KF5RAOk5RsgyKbNX/bm3+rrbkPlLf248jMl6drOilPyJ
	1sykQ4vVbKVyykH309+bLKVDPlXO+A5U8iEn3LZ+MBVJsR8MdnCPjHFvBmBzeilOnBverIJ19BW
	mC2wyXxYzSRRhk1imICrGRqqpULEMInuIGR2l1UMEyCkQXm59oArEuZoWKj1woqXzCRB3mVVw+3
	QeOAj2VtXOLs6d8rtmkaMIb+p7
X-Received: by 2002:a05:600c:a408:b0:485:3f58:d9f with SMTP id 5b1f17b1804b1-487160a24e2mr98477125e9.30.1774549061879;
        Thu, 26 Mar 2026 11:17:41 -0700 (PDT)
X-Received: by 2002:a05:600c:a408:b0:485:3f58:d9f with SMTP id 5b1f17b1804b1-487160a24e2mr98476755e9.30.1774549061407;
        Thu, 26 Mar 2026 11:17:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9f58fsm75854345e9.11.2026.03.26.11.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 06/24] KVM: x86/mmu: merge make_spte_{non,}executable
Date: Thu, 26 Mar 2026 19:17:04 +0100
Message-ID: <20260326181723.218115-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the logic will become more complicated with the introduction
of MBEC, at least write it only once.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 85a0473809b0..e9dc0ae44274 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -317,14 +317,16 @@ static u64 modify_spte_protections(u64 spte, u64 set, u64 clear)
 	return spte;
 }
 
-static u64 make_spte_executable(u64 spte)
+static u64 make_spte_executable(u64 spte, u8 access)
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
+			child_spte = make_spte_executable(child_spte, role.access);
 	}
 
 	return child_spte;
@@ -379,7 +381,7 @@ u64 make_huge_spte(struct kvm *kvm, u64 small_spte, int level)
 	huge_spte &= KVM_HPAGE_MASK(level) | ~PAGE_MASK;
 
 	if (is_nx_huge_page_enabled(kvm))
-		huge_spte = make_spte_nonexecutable(huge_spte);
+		huge_spte = make_spte_executable(huge_spte, 0);
 
 	return huge_spte;
 }
-- 
2.53.0

