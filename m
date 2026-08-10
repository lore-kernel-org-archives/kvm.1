Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C7C2DEA8F
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376095; cv=none; b=Ly/Ms8gb8Bv1XYkh3EmxPcVG6WiSQLbN4tDD0VT2JuLlJsN5DF1UDdceFyiFOKdZIwejMMgN62oyJ2wzqBDvgS8MpgKvjskprwY8j6zA47kr20XV/Yc5SU55ZF7cYLwU0xlNUxO9DFhC08gJBnqTqzI1j9aLGf26vH1TwiP1z6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376095; c=relaxed/simple;
	bh=hKPX+mOjfHOBQZDisLrPxYD06+lONZjwhisWQ4vKDf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NLV5zM0BUOmVPgrd2fnhA+yx+kXZ0SLwmG7sa/BERmHLvIIu3EXxNWROd7qAn51WTh4Ir7dicHAPT1vmRtLZMl/lU0V9vwu7pw5hwJIgB4Puu1L3XbQFEdCTaSz48z0JWeGXi3qtqZwxG4czN8GHTYeAKl+/rO6tB694mFTM9EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=upuiGS22; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upuiGS22"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-498012a61f6so81865e9.0
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786376092; x=1786980892; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c33LbTJSjGuCzeDqGkQ4pNDET5O6ipd+Vg7r1pAYbeE=;
        b=upuiGS22D+34+VfWZn2ONubQ99sLIS1FpZhUQCGHbobcfBvCP9zrIMMfnB/bWG1IA0
         hxh/tSc4DFq4oCoMjoXQ4SbGs874kybLhhtw5zZYjJYD0MfmSl6CW9Me2INrGB6AAd3b
         aHT/ITOzKRBssEqnVuRTNpwF5Tke1AVOqTupEeuc8eT+aVYJdUx/cYPI9go6eP3QCVTa
         j4ilkhDUKlVQNYUMw4m6Dz+PEAhVyuBxh55gD2wN7C39Fj4XWPd7gAuVf/v7aZpc1O3u
         E58SDuSJNcsr33Sef9+GW5/bgn38iLY2OzYX7QcO0mL8Jj4GsVFHCqbvJZPDE+hIbwkv
         Ssog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786376092; x=1786980892;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=c33LbTJSjGuCzeDqGkQ4pNDET5O6ipd+Vg7r1pAYbeE=;
        b=NI0tFXGH9bxLHHfYVI0plTJT32v7WdIi56Tbc3sogsswB3kpip0+myAWT1lDOBtVOW
         tt6tRwEClBox87sRiW+rZR8FG0vAdOIU2hF4+2MVPmNbwutqrnODLd11CsdRQzsKRuBg
         vPZPjza9/lAARpcqMuY3u6EESWFeqe5+klbBa26uUsIdPAfzjEHDJZFJC14SST5FFPf9
         Vt/V652FZg6ErEwbF1rwSkDBhr6RWBR2JXo4GBBXobbWkKdqD/TxZM56opvyQdQGfPhM
         poLGA8n4MxV6YivNaH4W+EaKU2rUIT1qjgCzQP5LScg1UmkP7Vaw+cIZtxDdOuxn5YkT
         9lyQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1LcnUryiG8Vl9WYIaoK40pXR1Lq2XKbWHOsV4sjO29MoodhGZvau47iTJiQ4xlgPelPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJm8skc70luM3RF2IzEtWjubBK6ealdT1Kf/jtJLMajsOocr1y
	0uMOlOqOX0PRu8UZg12aBNPSwoaQDrErtLKRoFDVrQ58D9ULWGbOVL9O9vVDKOtsRBAmypSKSdE
	Mo6bq/mth
X-Gm-Gg: AR+sD12OL8uO5kAEPOLkrssWqU/RyB6XhPKHRs4YvbbVGOLDPfHA028GDWoBBr6SQ8E
	aSaayZafJ/taFwAVYERKyh53Ydd5+Sg7oc2wCJoA4rprDQ9T0Buff8nuw5iUSJ9f/7F31OW2aSY
	vx1xSMthx6bFS5JwB8hYdj5TpNlhri0TE3jN/Si6TYy6kv2D2Mah0Sg6+FlkMOHBqoIwPkzA027
	ssQ/LU1wEQmjmclw+RDIzhexfAp8pzB3aAhQVMnR4Bp53DHqRKZIc31BIx15pwlxIIoU2wrG0Ny
	GGB2s147Gx+SF+I0vqtkpg/iWEgqPvZHnMHxivks+lqg6xOGX3ZL8jREpEilwv7IanoDosGA8zi
	iR+fPQLXlSoRDDq6hI9hytr1tbW5AI7m4Zh8qLd++1Bs6zG5ICryZaQ7D6Fsc+dWDzR0IGMcYoD
	iPJF05PrkVlEjp0InQ5vjDb63eVa8BHMTo3dBGAFjIC1dQ0t1vT7Rwz2ETvlaW4mkTvnq/KdLmc
	qEn7zCDb3/7M0HfrhjtDkO8o+NIPh/TCAJo0eKjL+CoqE0=
X-Received: by 2002:a05:600c:6b18:b0:499:5f00:4cb5 with SMTP id 5b1f17b1804b1-49962474b50mr3053625e9.0.1786376091576;
        Mon, 10 Aug 2026 08:34:51 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:5c4:b02b:cff6:9cc6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e7b3fsm38648521f8f.20.2026.08.10.08.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:34:50 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 10 Aug 2026 17:33:59 +0200
Subject: [PATCH] KVM: SEV: Fix page dirtying in sev_gmem_post_populate()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-x86-kvm-setpagedirty-v1-1-85f180892d4f@google.com>
X-B4-Tracking: v=1; b=H4sIAGbveWoC/yXMQQ6CMBBG4auQWTvJQEiDXsW4KPAXRyOSTiEQw
 t2tuvwW7+1kiAqjS7FTxKKm7zGjPBXU3f04gLXPpkoqJ00pvDaOn8uLDWnyA3qNaWMvNepzEOe
 CUE6niKDrb3u9/W1z+0CXvi86jg99tTZAeAAAAA==
X-Change-ID: 20260810-x86-kvm-setpagedirty-a04e49f066f0
To: Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786376044; l=1657;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=hKPX+mOjfHOBQZDisLrPxYD06+lONZjwhisWQ4vKDf4=;
 b=DAc5cALWvZ0LC4ly82cuSkAgxL7iVz6jIR4TGMX0mdPah0bZec/7Vb50vrR8t9+B8mkkkel+c
 0Cz8Cfdsz9ECiAaOXHws0PHZNXFSRrBRdpghVt+SJxDKLblMxdaXSsd
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

set_page_dirty() requires that the caller holds some kind of lock to
ensure that the page's mapping does not concurrently go away.
That is not the case for a random page we got from get_user_pages_fast(),
so use set_page_dirty_lock().

Fixes: 97cd21d57e9b ("KVM: SEV: Mark source page dirty when writing back CPUID data on failure")
Signed-off-by: Jann Horn <jannh@google.com>
---
Note that I have only convinced myself that this is a UAF bug by reading
the source code, and I have only compile-tested this patch; I do not
have SEV-SNP hardware to actually test this.

This bug was introduced in v7.2-rc1, so if we can get the fix in before
the 7.2 release, this won't require a stable backport.

For context, I have seen similar bugs (set_page_dirty() on a page from
GUP) in two out-of-tree drivers in the past, where this led to UAF.
Evidently set_page_dirty() is a bit of a footgun for GUP users...
---
 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0f0ea7896af5..49feef14787a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2389,7 +2389,7 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 		void *dst_vaddr = kmap_local_pfn(pfn);
 
 		memcpy(src_vaddr, dst_vaddr, PAGE_SIZE);
-		set_page_dirty(src_page);
+		set_page_dirty_lock(src_page);
 
 		kunmap_local(dst_vaddr);
 		kunmap_local(src_vaddr);

---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260810-x86-kvm-setpagedirty-a04e49f066f0

Best regards,
--  
Jann Horn <jannh@google.com>

