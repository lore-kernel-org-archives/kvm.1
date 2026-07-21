Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA44C9552
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630140; cv=none; b=tpMl+2CGrZBXubWQb68z/FV/VG0qA/nMVeqCQoQirllo7KBldePtjTG2jRqsgAqsjtCDs5gut9nC3Cb6Nib4fCa+fqNHxmE4bYWELQwA6KH1JOulg6rVue3j32KD0DkvJbjlSIcd8O/dlNdm9tvGJYennhVsQA4Cbcq/xVhLe4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630140; c=relaxed/simple;
	bh=nVrRFr7SXPIbywSEEfW3Ni8u2i1dZH0gp2i8DA7u3d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFCbZct+F1jjcvLbfHrMHYFa8JRmMlcXuk74Zhw3xu0kO4QQK4mvxClN4JvaWUAZ4bwMZxnReI8VZxZuPam19ORRSinaPasLN1EkrbJNixJNepVQ50WRMANmQYKiW8Rbo3nYmCffa9v8ct2NuJzEjd9svcFWEQsGShc4RShU/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcYpCXqV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcYpCXqV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so71893525ad.3
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 03:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784630139; x=1785234939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xyu85tVI7qhkAhG73qiWVn5ZsmTezNl/fK8tiEf0dEU=;
        b=JcYpCXqVhmbhUPRfEFlQsXu4Hr3UQ/x4hvcuX/9UoxgZ1N+INNc6Tq+i50P3gT+bxq
         kMdDnZzrjL+tG8+2B8XbQG35Q8GRn1mQ3xDcMwWEKJR++Y93RfBNtBo32pan0xnUqrZu
         Y2zEiYKLcxxFlHJITPf3s6iUwOrhroNMQH+m+FkqgYWKLf6RihrGlX+OniMmBiHG/jG5
         9dlgCtAJh14fL8GUpHxCnjZiSpxG+ZXv/EqRZaJCS6Wb2XQKSlgF8UqUNJAjKV6A+SbH
         HU9WAaLyortIctXTIHP+2q5e3XMjq5vs4jV/DuC6eTTv/EWzX16i/Tx0zOkKo6J/+LZz
         DmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630139; x=1785234939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xyu85tVI7qhkAhG73qiWVn5ZsmTezNl/fK8tiEf0dEU=;
        b=kI1WJ99feY+dl7w2o9Ad4mthPP6nmclcDxO7ek4RrGBCCsFrK5ZMZcC1fX2P97iqbV
         233jZU8r6D9D5jOdnEqUOxpZ7L8Orj1eVBBZUjjVQBGoQuozoJ6SkRsg+lsZEhh8prZP
         UZqp+s/DNh3+cG+3+GArExmMbNAyv1NI5Ig9kzw3wJBf5xmbJDNwAFlLFWiiwWdza5U+
         ++sazPX6axQ38pENMPkFKetCj2eqWJ5sF4cPUGV3XceDolMZ+0fChLHlGq4NTcsxlnEb
         vTqxoiOZ7vQyVPIfmRRJen4rgNm2WiwAPx0EhywvgAOvueaoBCI5U12CEZMg5xmOswn+
         mKGw==
X-Forwarded-Encrypted: i=1; AHgh+RofMedtlgD7frheI+FvxwfRiNRL76q9XF9kNuLpfjv3mA4PlhDjlm2UREtE+WZzG19btTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPG3t8Q1125sa+rBCgJ0Vwcif2ijv/7GaHkstbzaZNhOT/vR60
	TPkVtZj0L6Y2HMKmMaNq5iuaBmoxvJ8Pfe5x2hVtpvGw95ijVg8tkGXE
X-Gm-Gg: AR+sD11r1i/6k5KYXXDTujUbNilfP7Q739lt08MJ9fXHdOHuxiLgKJO9SOlH16ruyjq
	QyVhb1pcixD11obeS7tkYt/6vHO18UuwGHiBTfw7YA6CQBppuXx2oj2DZygVttStqiQ6AoAIZTS
	EhskK5/wT6pave2Mudzc2gFb47ojCfAq59BODWoyGl2hhr5I0BfJxYjlN/rCcr7ATOQNA/qor+r
	4KE/lvTt7xuLBtGKClzvB7mqtuwmk3XF+jhzudSqjKvY6trvA2k6rzdbvmoDFYYVYGpN04SlbCf
	a4yGCbPvoxP0uQHvAEDB/gOeJ2ay9ogY4+z2GUwirtJiYnsCSKg4FFUjDSRCXQUT+pgqYahMPmY
	rxfxzdYZzA4sU/X7JmE4emXy1WQUFvGbbCsgaOSxgR5ULnD+CfXdRx8otIuHPLjyFMlLX2c+MgM
	IBRyy98ZePIrXIrlr1rCgyOw==
X-Received: by 2002:a17:903:2287:b0:2c9:c517:d070 with SMTP id d9443c01a7336-2cf348366bfmr182616715ad.3.1784630138721;
        Tue, 21 Jul 2026 03:35:38 -0700 (PDT)
Received: from localhost.localdomain ([124.194.218.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3476ba24sm72240715ad.75.2026.07.21.03.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 03:35:38 -0700 (PDT)
From: Jinu Kim <kimjw04271234@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] KVM: x86/mmu: Check all address spaces before skipping unsync
Date: Tue, 21 Jul 2026 19:35:12 +0900
Message-ID: <20260721103512.2136240-3-kimjw04271234@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721103512.2136240-1-kimjw04271234@gmail.com>
References: <20260721103512.2136240-1-kimjw04271234@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmu_try_to_unsync_pages() skips the shadow-page lookup when the
supplied memslot allows a hugepage, because a shadow page would disallow
hugepages.  But hugepage metadata is per-address-space while shadow pages
are shared across all address spaces.  With SMM, the other address space
can therefore have a shadow page even when the supplied memslot allows a
hugepage.

Check the corresponding memslot in the other address space before
taking the fast path.  Skip the shadow-page lookup only when all address
spaces allow a hugepage.

Fixes: b3ae3ceb5569 ("KVM: x86/mmu: KVM: x86/mmu: Skip unsync when large pages are allowed")
Assisted-by: Codex:GPT-5
Signed-off-by: Jinu Kim <kimjw04271234@gmail.com>
---
 arch/x86/kvm/mmu/mmu.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 7757f0ad65c6f..1db6750992546 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -725,6 +725,25 @@ static struct kvm_lpage_info *lpage_info_slot(gfn_t gfn,
 	return &slot->arch.lpage_info[level - 2][idx];
 }
 
+static bool kvm_gfn_is_lpage_allowed(struct kvm *kvm,
+				     const struct kvm_memory_slot *slot,
+				     gfn_t gfn, int level)
+{
+	const struct kvm_memory_slot *other_slot;
+
+	BUILD_BUG_ON(KVM_MAX_NR_ADDRESS_SPACES > 2);
+
+	if (lpage_info_slot(gfn, slot, level)->disallow_lpage)
+		return false;
+
+	if (kvm_arch_nr_memslot_as_ids(kvm) == 1)
+		return true;
+
+	other_slot = __gfn_to_memslot(__kvm_memslots(kvm, slot->as_id ^ 1), gfn);
+	return !other_slot ||
+	       !lpage_info_slot(gfn, other_slot, level)->disallow_lpage;
+}
+
 /*
  * The most significant bit in disallow_lpage tracks whether or not memory
  * attributes are mixed, i.e. not identical for all gfns at the current level.
@@ -2972,7 +2991,7 @@ int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
 	 * write-protected (see above), thus if the gfn can be mapped with a
 	 * hugepage and isn't write-tracked, it can't have a shadow page.
 	 */
-	if (!lpage_info_slot(gfn, slot, PG_LEVEL_2M)->disallow_lpage)
+	if (kvm_gfn_is_lpage_allowed(kvm, slot, gfn, PG_LEVEL_2M))
 		return 0;
 
 	/*
-- 
2.43.0

