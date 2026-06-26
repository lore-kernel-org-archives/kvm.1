Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0583F6C52
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473222; cv=none; b=q0jxITF/w+siS82fl1iMzvytnHekPD/j4d9j8MTJAsLs92/oefxP3aulqyqh3GTMB/JXqjzR9/QDiH2u6OJr5SSi3kPZECFrUpIuLdgAZXXrC3TYkyeZtoUDfmHNpswVL5ext5LlWdc9xhRT5NYQhzFBvahnqwKsUQd0Pt6v2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473222; c=relaxed/simple;
	bh=weYSUgaYkqSXYwb5X3ty9F+fWEmo2ZS70X7C1+bNYMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgUrT1y9AGR9/yf+LS+h8UYUQNE+FxvfapXj234MQGe8sIo3NuMYsnxKUYxGjmTu2ljrsqrmQK+ManQGPMz0wN+hurgOIRL1iWHh9uq/YDLkM8Ct1C0f8swYEHawsTIEPbYEEVbm6t/9FaDgOyrq7ClZ94vR47/zy+A/vvxvyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+6FPsYt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewUeV75r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+6FPsYt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewUeV75r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6BcOA0+z/i0uW3obMPgn2IQzAL5+x4K+CGN3abb/tg=;
	b=W+6FPsYta9OHeEphRS7jJzmsi5eGGi5klEvt7jHBJbWCmo7n2tqA+u4oUEUgTejgfn3Tk5
	PqfmxHoOwCIleakPwdDJJvgnUoZDBUMLbG7eMRbfyflGTcn1iC0P0+3KunAMXpAZyzVZUK
	+9wjh6FKWSK1U6mgzSi9qqunKgUAPxE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-mWvpHDb5OquOq4g9_5wJTw-1; Fri, 26 Jun 2026 07:26:56 -0400
X-MC-Unique: mWvpHDb5OquOq4g9_5wJTw-1
X-Mimecast-MFC-AGG-ID: mWvpHDb5OquOq4g9_5wJTw_1782473215
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4621b17733cso378968f8f.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 04:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473215; x=1783078015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6BcOA0+z/i0uW3obMPgn2IQzAL5+x4K+CGN3abb/tg=;
        b=ewUeV75rBwCtRpO5pIh5GVMsmn0RTcGtLq7hUgno9+r8DOX7JhEWihrX9mPFVOq8cL
         Kkv7OqVHgt3OYxP1Z87hq58RsTw7O0qLVnXOwTlO8vTbMaR8Tz8OSKi66EK/JxUmHY17
         7SO/G1Hd/ePPe0hQHP/ZHdYgz+O3jLRAk3VETCmpTABXW/4X3PbPfzw/gJ2xk2THG4m+
         5WDTIBiASzk3YGohJvR8HosHTSDcBwhkt6d45vMoyvzPSTSA0flPXzpvVjSB/IuBsf8w
         KrCnWJ45cQkJpOWj5WyTIqKd5oJrokIxA9QD2OPTGvMXlnrIWMi7v3bIZV0BW+8MsB9q
         37lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473215; x=1783078015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L6BcOA0+z/i0uW3obMPgn2IQzAL5+x4K+CGN3abb/tg=;
        b=abcdDxF5tl81CtrH2VAXX7gY5qh9QLQZgTwesF71qrajgKLdLPMJt6QB46rvRqtHjn
         /zgfRsDEv8gVEPXT6GZ4ute0eT6rOARmSuE4MwA3OlI7cKyWTw17fl+XQ94HVpu5JsWk
         rBrID1pe2l/gPYhhfJ8R37WX4vrI20/k4rhuCZZhXiq9TcZorP5zWJQhcS0yYfSakVKv
         ni0HsnQibmKjMdaPWyvDoMYTHIzCTVuBr1zJ+Ef5+YCWG78D6/4dSYLvEsF3cHkn1mQC
         vG9Bzxo6mE6H/24yPFuW9DnTZEgpBxiYQqEiqXjehHxV3qHhap+JBgp0mVuC8xDHy2aJ
         bsAA==
X-Forwarded-Encrypted: i=1; AHgh+RqjeATS0VMgYGymgwSqtbwSombNKWrBfqundA3zGjAWTYBD0dtSIvV0bMagqlv7I28A5e4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw36ec06j95/amfrEUo4YoJWQneHBXDcwPb1VkPABofqgrExH7o
	3kbNT2KYye1RFTzWmAEG52qSDLQshX/XSp1VKdKcJfx4myiGVG3ugPIp/j5UTCMYA4mdIYPTOye
	VyttajQO/d1GLaOku/VWO7TlUKxawPHlLIh4TWQ3hkNia3qTr5jcLKQ==
X-Gm-Gg: AfdE7cn4KBBAySWSUt99o37VrEyHYSipClu7tTynyr5H32KR5P3yBHrxLaUyst4KrQs
	9bA9Cjj8MnRZq2yMumP4J6At5vqF+LzWEc0Du9TL3SWOeYdtgbB0NgOKG8aI8R3tL8YdOiFA5+E
	+dISWUlT92V31mPOIAGD8W8D0yJ+hX4zcFZl68nT5MTw/XC2wosWg0c7bm7X4s8tMHhk2aWU24a
	LD/dcoZHKn6JcJQBq+AiCxu+aGPVt0UeK3TpckNq2ifu5JCASEYd+RllDBqYZe90X0CKssHph2o
	liO7DwP/55duor8aXYoYvXqbL5Y6k8zXUU+zGaM7pyA9PzNFWaTw6qRVt+/IYfFF8iKrQVefMa2
	ZSqjfT1FoVcYvqsvuOmMShd21eQDp9Nx+suTOU1sCl8SMx/TNIxxKRHSnRzVfNH/rAslpC74aUA
	G4vDBemicFGDtnYIXg
X-Received: by 2002:a5d:5f44:0:b0:465:fa66:be57 with SMTP id ffacd0b85a97d-46dc12df7bbmr10285958f8f.30.1782473215063;
        Fri, 26 Jun 2026 04:26:55 -0700 (PDT)
X-Received: by 2002:a5d:5f44:0:b0:465:fa66:be57 with SMTP id ffacd0b85a97d-46dc12df7bbmr10285895f8f.30.1782473214656;
        Fri, 26 Jun 2026 04:26:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46dcbac0c9dsm14175351f8f.19.2026.06.26.04.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <sean.j.christopherson@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PATCH 5.10.y 07/17] KVM: x86/mmu: Refactor shadow walk in __direct_map() to reduce indentation
Date: Fri, 26 Jun 2026 13:26:24 +0200
Message-ID: <20260626112634.1778506-8-pbonzini@redhat.com>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 03fffc5493c8c8d850586df5740c985026c313bf upstream.

Employ a 'continue' to reduce the indentation for linking a new shadow
page during __direct_map() in preparation for linking private pages.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <702419686d5700373123f6ea84e7a946c2cad8b4.1625186503.git.isaku.yamahata@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b168b804ac7f..161e05783629 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2891,15 +2891,16 @@ static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 			break;
 
 		drop_large_spte(vcpu, it.sptep);
-		if (!is_shadow_present_pte(*it.sptep)) {
-			sp = kvm_mmu_get_page(vcpu, base_gfn, it.addr,
-					      it.level - 1, true, ACC_ALL);
+		if (is_shadow_present_pte(*it.sptep))
+			continue;
 
-			link_shadow_page(vcpu, it.sptep, sp);
-			if (is_tdp && huge_page_disallowed &&
-			    req_level >= it.level)
-				account_huge_nx_page(vcpu->kvm, sp);
-		}
+		sp = kvm_mmu_get_page(vcpu, base_gfn, it.addr,
+				      it.level - 1, true, ACC_ALL);
+
+		link_shadow_page(vcpu, it.sptep, sp);
+		if (is_tdp && huge_page_disallowed &&
+		    req_level >= it.level)
+			account_huge_nx_page(vcpu->kvm, sp);
 	}
 
 	ret = mmu_set_spte(vcpu, it.sptep, ACC_ALL,
-- 
2.54.0

