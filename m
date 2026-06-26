Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A13F8705
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473238; cv=none; b=qLVnYf8tRj1QqXpE4LPvbz8EYGwHpbx9uY8xsDxHfW5CvL7YRSpfN0ElitBloCuPrl2mroKX3OQRwS6A9uhrtMGmMdFZBEAop4o4/sLVXmEm1859/ZBklrOAD+w04kRNmMxJpsvAeU0ek6w07dk+Tl2vWyK+KFMOaPUc/U5TSHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473238; c=relaxed/simple;
	bh=2DLg9jc/WkFVoQBTSVRm/gj+d811yECfIGYi1C2vlAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMlauwmuDUWB9VntwcI/UqxmO3OcWcn5bPKTL2Dxm7WIvzSeGouphyLG10SjKf7ntarYF3NK9W0QfR2rPKfs7vRLH6x/fb5nxyBNMeZa2948PnJiM+QET9z6ePN7GsS+o9FSQTgY9S0whKI6UAgs5WDqFGGIap8ZjQEX2ve/EXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+b1qInk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tfvV8n1O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+b1qInk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tfvV8n1O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2D8lHy1EHGZTyo8zoJXSeb/nhL4XSNnc7/kx0wm3H/k=;
	b=R+b1qInkmRNWmLVhXbO0opnx0w8mgSDXRsMkk9a5Gl558zGl0jYZUN0XSRVYzScksC5c5B
	Fei33TxFlj+OjwDRXGgXPVflkhK6If6m+b3AW6Ktst2zchyW+feIDE1sGwttfuR09WSRxy
	VPO0QbsyqQ2QxUOzEh1nGeEtSgJBvB4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-1CmujiqqPK-IHPA6no5iEw-1; Fri, 26 Jun 2026 07:27:09 -0400
X-MC-Unique: 1CmujiqqPK-IHPA6no5iEw-1
X-Mimecast-MFC-AGG-ID: 1CmujiqqPK-IHPA6no5iEw_1782473228
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4924a7ae480so7387925e9.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 04:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473228; x=1783078028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2D8lHy1EHGZTyo8zoJXSeb/nhL4XSNnc7/kx0wm3H/k=;
        b=tfvV8n1OEUn6jMhvUygwgYfH9IYwg1gwBoYGbDRUtoomrrcYpQW1+Ezw85VsvgXPwS
         CW8BVYYUlBoJ6bqqFAJYrvSeBXYB+ykWNoDesgxVHjlknnpt1qirFzZWJj8+NZNZ/C/y
         ERG2mxcCyCoVdOGDtb+jLtSbS4q7NVDkpLUkZUeapD9O3hZEh4tP880dmInDoYMclWt8
         1W9xDJ+8nzmJJpeachobED10Y9dXU0TIN42FDxgrOPmo7v0g64i3VBBohgaOn7dlufM7
         +rgNgpnR0kUrPIvPaN6dOhbiTWgdetFjbeTbNQrLNxB614uvZCSeGrJaarT/rltSLweS
         w0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473228; x=1783078028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2D8lHy1EHGZTyo8zoJXSeb/nhL4XSNnc7/kx0wm3H/k=;
        b=LIN2eK2dIRjTR2VVcDSSQU98sOQk1iefHJovjU+cfhA7GQAGJeGS1mqqsPmSUThk8n
         cXpAHWAoaGwnSJAGaFSVSOHpw65XrWF7x0OFnrBwG1bWUCaPKFQKut5xgVyoht2WlH8k
         Sr6/Iiwcc9zVXN4K3PGoesZoEbKF/l9Azjk21jURKyboYecpLD/RMBTPodPYyvns11sn
         eaVrEHW2IXxO9if//iRKAg9N70JKL1tvGSlsE2Nw5AjqjYdZLPFpVOyPGJ7+6MMiXcVn
         VqaScrfCJBlngsBfqJ9R+upXGsbhiyMoCX/ur9eIlXClivx9FqYOco369XLqLz0iyma+
         bM8A==
X-Forwarded-Encrypted: i=1; AFNElJ9JxNjlk7wEaHQ9rHVtlS3ecKpt+q+FRTrJhbWK9WLI1XFvtP3vwk7Sd0dlBXWMxyPJg18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkwy7RXb4gBLGZTmYJRSxeBnSYO6oZI3d+JSAOdCc+hxMlm0hu
	WnchuJeATEJC2bcpE3mt4G6TXRCYmZ3GFl/9zX3J/SOQ4XAjXXQZKFkYPoWGVuGsvzfDJNZRudS
	NAZJCXe+H4YdaAfDayoI+KvSITPOdmpk542tDNuo7NjdR78dm4KYt6g==
X-Gm-Gg: AfdE7cm0AgaTnpv8DIKWDJkSs8pWEN5gxpKka7kOnJNIsW2WzD98t1jUjSUrk7leM+a
	/SHjdDIRi+fCJNtdzY5x/BcxS0oTDdJojrJCMTDgKUPcdXacG4Zg/iLZVsb0xW8q++1LZ0cvcl3
	J84NHWQ7/WoD5ZiKTf+1lKnOpNHomGfbS0a521wL/P4DJvySyNH4HkPT5gfekAPGpqx2kty+lYI
	bw3z9ogKQ1olNtTU9dYKbL7FJcAYJxrj6cN1N8zyyhs2/Mjfog9iSBY4ZSe5kAMpgmDD8TXi65u
	JAxzaojDqWDGW+nemdpvHsxRhqS5qY73TaHMqWFnvlvbj+FnaJFESlMc/5bi2fCNKjAmY5qDqrV
	YzpN8FiRVwghSN/pNBUiQindskz0IRV+8dtyh+Pt4LWZX7FIEEi3+LZU7/NwYk6Dbd0o9GnwCp3
	CkhQ1gQIOQslEA56iE
X-Received: by 2002:a05:600c:c0c3:10b0:492:69f9:1314 with SMTP id 5b1f17b1804b1-4926a713d2amr31598345e9.23.1782473228214;
        Fri, 26 Jun 2026 04:27:08 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c3:10b0:492:69f9:1314 with SMTP id 5b1f17b1804b1-4926a713d2amr31597935e9.23.1782473227718;
        Fri, 26 Jun 2026 04:27:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c2954efsm32015465e9.2.2026.06.26.04.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:27:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>
Subject: [PATCH 5.10.y 11/17] KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes
Date: Fri, 26 Jun 2026 13:26:28 +0200
Message-ID: <20260626112634.1778506-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112634.1778506-1-pbonzini@redhat.com>
References: <20260626112634.1778506-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 7f49777550e55a7d6832cbb0873f48f91c175b9c upstream.

The quadrant is only used when gptes are 4 bytes, but
mmu_alloc_{direct,shadow}_roots() pass in a non-zero quadrant for PAE
page directories regardless. Make this less confusing by only passing in
a non-zero quadrant when it is actually necessary.

Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-6-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e4759156a2dc..76d87da1d071 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3263,9 +3263,10 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
 	struct kvm_mmu_page *sp;
 
 	role.level = level;
+	role.quadrant = quadrant;
 
-	if (!role.gpte_is_8_bytes)
-		role.quadrant = quadrant;
+	WARN_ON_ONCE(quadrant && role.gpte_is_8_bytes);
+	WARN_ON_ONCE(role.direct && !role.gpte_is_8_bytes);
 
 	sp = kvm_mmu_get_page(vcpu, gfn, role);
 	++sp->root_count;
@@ -3290,7 +3291,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		for (i = 0; i < 4; ++i) {
 			MMU_WARN_ON(VALID_PAGE(mmu->pae_root[i]));
 
-			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), i,
+			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), 0,
 					      PT32_ROOT_LEVEL);
 			mmu->pae_root[i] = root | PT_PRESENT_MASK;
 		}
@@ -3309,8 +3310,8 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	u64 pdptr, pm_mask;
 	gfn_t root_gfn, root_pgd;
+	int quadrant, i;
 	hpa_t root;
-	int i;
 
 	root_pgd = mmu->get_guest_pgd(vcpu);
 	root_gfn = root_pgd >> PAGE_SHIFT;
@@ -3357,7 +3358,15 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 				return 1;
 		}
 
-		root = mmu_alloc_root(vcpu, root_gfn, i, PT32_ROOT_LEVEL);
+		/*
+		 * If shadowing 32-bit non-PAE page tables, each PAE page
+		 * directory maps one quarter of the guest's non-PAE page
+		 * directory. Othwerise each PAE page direct shadows one guest
+		 * PAE page directory so that quadrant should be 0.
+		 */
+		quadrant = !mmu->mmu_role.base.gpte_is_8_bytes ? i : 0;
+
+		root = mmu_alloc_root(vcpu, root_gfn, quadrant, PT32_ROOT_LEVEL);
 		mmu->pae_root[i] = root | pm_mask;
 	}
 
-- 
2.54.0

