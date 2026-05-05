Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EC83D413D
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010758; cv=none; b=grHbRV9iZG559eRJSm18TAt6B7SeJwoT59etCB/W4xi85/buDX2NbZkKzMIBu45Ax89TZwoZx6zRu/pg6BifzEpF0R8Vwlxgu52ZaGHoSZdn2ifNk5Py2TCI64Rq/BthQXddpPcRtxx+cD/suKVIdJjE5QMTJpQUug7KqNDTv4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010758; c=relaxed/simple;
	bh=ayDxRfV5CwivFBrmFKspqPM968swxZlUL5mxa/7llVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bur6nHK+fdsEA1xHzI9Sp52qAJCQlOhvhucAY/1j5BljLdNcs8vEDIE5fjIAxOIuG5MKiJ5AedLE0V8OAblQB3vx/hlZ4b+bQun9TLo4pRYjy0eLWZBEm5VkCiXpNCBjp6AH87IyVOf1PMGV6uEmP2P5J0dIZxzfp0j0UKODb6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StjEd3la; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQqrz7uz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StjEd3la";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQqrz7uz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oD4DN0gyrE6gzDpzR/NyRI1GpMVZtp6Qu59yIp0yUlc=;
	b=StjEd3la+KNBa3kTqOcyCPKWDfsgsrOXJplmfb2j8NLRxtaYBRapd1+7/Vj86dxQBMYJSP
	658UxFluUaHrfXwBVC76c6mInaisrZnhUQ4Xl8Tt2bj9ddjJ7K26S5wKJtsefwu0dEhbJ1
	AnIhzn4bC+nJrv7aTLiCXlLaJBdVDyQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-YqEGl0FlNAC851_Mve1iQA-1; Tue, 05 May 2026 15:52:35 -0400
X-MC-Unique: YqEGl0FlNAC851_Mve1iQA-1
X-Mimecast-MFC-AGG-ID: YqEGl0FlNAC851_Mve1iQA_1778010754
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a7994e8ddso54367515e9.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010754; x=1778615554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD4DN0gyrE6gzDpzR/NyRI1GpMVZtp6Qu59yIp0yUlc=;
        b=PQqrz7uzk+rGGn23SCwtLDo3ug9yuxrqdDBUyS/SgqpVWzXDiKxCxY/Wt/2MIphjp7
         UoBBiFroTkjwDt8dcQbr2CMsXBYKO9vfqfiT1plI04iysraKYc99l6Fb29+ngbYAXjR8
         vkOwhaN1gJdzc/4iRrTV4t9o7f4Lgj3NIqVvqN7EkBFOPVq9ml4ivRs0FdXx7AN5mXxQ
         QHPi2nJ8A8yuB9UuXQ+JtW5zdN10Vk74jalWzSV78pyw7DGT2aj00qiViY/RkwnAe3Nk
         l+AWfAuwS4gQIn23tPGoRn07ss+6lZLoMihq4CFepEO6hUO+ttz4no94aemGoxsqHDdO
         paOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010754; x=1778615554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oD4DN0gyrE6gzDpzR/NyRI1GpMVZtp6Qu59yIp0yUlc=;
        b=Sat33vVYPj3x1dfx0uEZGCbKvePVGR0ElCx+YNOWdlBVTyO8GZN/FN/B3qICy1tVtb
         aJpaOUhRGWjRjaiEvLlqEpoalAzzc5oYKqgPj66jMOeV3Y/S0cX7Nd2eMgcX8P0QgNHw
         HIvLstRIODnCc6HSDHUc9/ER36uZhpezPuWMewFFpG4x3UZpqhIlDIGf0tg/pEnMbcMp
         gF4ajU9FHuRQN63GJPtPiDjic7KIGezxVH356DfTBLIp5KwIomfYTpBqznBhqe3N5Uzl
         6ROlaZ/wYWnboGTFQkS4vHC6WCibBi3V9/AWuPoE2e1hj97AoDTqxIDWtn1Kz60j7pHF
         yOrA==
X-Forwarded-Encrypted: i=1; AFNElJ8F/Gfp3fhwLJGzk4TLoqNUDzE9Vt09DWoREHtGPsylFE0OonBNSlra9dpw9Lzsp4IKKBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4nUmJ9Aywu8tq88xvH1LgvV5i/RRD9eHv2JUE9xWvR4tPTHke
	PnqHD7vwlK2XWU1SlnBxEssdK1p3n5lfJIBgA9y6IqxgqgcFuiVb5Mo34U3tdrFGklNpDBEpicG
	2GBZf/FlI9RhsMzEtHgzlIFs1HQBwGXyYpnCk4gsp4p9FJnS4+nFCaQ==
X-Gm-Gg: AeBDieuTOlmH1U44RtIzQbD04VspXE5p/oilQRIEbiktmn09gag+KmYQK2pg8JFsYiF
	qhZfpiFxKqbndTOdQgREbAuahq4BfGFELzpsm9TLU8mAG8okt73fm3sjePILKHcQGbI+/hfKYw5
	M/FkBVFfjTPcUhkmlPfwRb92t4YMe96l3YSvBEEWRgPZ4AOFwAyBesE4HK1UC8nzp/PYPc9FUe4
	jW84+3HGj/tMP+l07RM1xpzn0wodmjXH5+9MbDjdIEIvnj7DMqjm3tcioNxXQ0M08aG8Tka+XFN
	9DArY8iRx6T0F8AQOSaWEhSmGkyqUSkNFI2mPG3kJ/FfNVBnIzGtqVh+++37z8vHHpqYZoEIVnN
	7mPVZZg8iWQu6hfd3eMZRFoFlJzR/Oz7uqsRH3IFrWfsfZQ1vB9fpuyPdgG7bNLpFgnREjr4bmU
	lrgxQZri/QfTm7YMzLPX2s5BB8+jfk7BERSurKXzE=
X-Received: by 2002:a05:600c:608f:b0:489:1ba8:5be9 with SMTP id 5b1f17b1804b1-48e51f4b0e1mr10185235e9.29.1778010754021;
        Tue, 05 May 2026 12:52:34 -0700 (PDT)
X-Received: by 2002:a05:600c:608f:b0:489:1ba8:5be9 with SMTP id 5b1f17b1804b1-48e51f4b0e1mr10184845e9.29.1778010753674;
        Tue, 05 May 2026 12:52:33 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb3427fsm614539715e9.0.2026.05.05.12.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:52:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 02/28] KVM: x86/mmu: remove SPTE_PERM_MASK
Date: Tue,  5 May 2026 21:52:00 +0200
Message-ID: <20260505195226.563317-3-pbonzini@redhat.com>
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

From: Jon Kohler <jon@nutanix.com>

SPTE_PERM_MASK is no longer referenced by anything in the kernel.

Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-3-jon@nutanix.com>
Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 91ce29fd6f1b..28086fa86fe0 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -42,9 +42,6 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
 #define SPTE_BASE_ADDR_MASK (((1ULL << 52) - 1) & ~(u64)(PAGE_SIZE-1))
 #endif
 
-#define SPTE_PERM_MASK (PT_PRESENT_MASK | PT_WRITABLE_MASK | shadow_user_mask \
-			| shadow_x_mask | shadow_nx_mask | shadow_me_mask)
-
 #define ACC_EXEC_MASK    1
 #define ACC_WRITE_MASK   PT_WRITABLE_MASK
 #define ACC_USER_MASK    PT_USER_MASK
-- 
2.54.0

