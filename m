Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88C73F6618
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473219; cv=none; b=A3ag8YOoAuLgRMcTCSqMy6j1kXsJHov9BCVTpqTyVnblJOS5VdOTHR5x5rANQoTMM4AYztV3k5+gOtdLZPbu02fZa3Rhdkqyuh3lQVg5FRQpPi6HbrPCsjwWRxdqinJqmyMs5MaUh8uUm7l3G93ieW4XaAdr1l1YU2hPsFZGPbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473219; c=relaxed/simple;
	bh=IsMFqh5lCzslhR35A+TpAigK0yuuYqvptTFT8QA/wU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMQSLBSk2bMMdvUssR/Z5D6bWr3OPZrS2GnNechfDtnfEtruTEklk0zuEE5wl7QIAC29+GIJmoBQBQtwJ8i0Lmjr1EVz0othUX6cV9sqLZFTlrYZ+ux3bfbE/IroyC8Ymvdn3iWAHf036g/tjkul0Suj8wdYVYBtIEJVgGgcFlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8kUYZaX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=izFO1jjY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8kUYZaX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="izFO1jjY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pL854WDCy8UICjVgQlEGBttHpjAaK87n93leEJVa9jE=;
	b=N8kUYZaXoOKoMpOlz1T1eEeH+IALBAVTMxJI8Kg3roBIm9xd90x0Uz7umuJ4h/N3J/qx3/
	KEzE3yxeyD6U309B3OjDr8a9V6xcCzKAnJJeX3+tbbYtlmQDY378HuTCCYQYxGVXuYme8b
	221gWX6ppMbe63Yq5oatHTz93dnRln4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-V2h_sG7uPmOVIlbhUBgCSw-1; Fri, 26 Jun 2026 07:26:52 -0400
X-MC-Unique: V2h_sG7uPmOVIlbhUBgCSw-1
X-Mimecast-MFC-AGG-ID: V2h_sG7uPmOVIlbhUBgCSw_1782473211
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767b782so6614755e9.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 04:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473211; x=1783078011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL854WDCy8UICjVgQlEGBttHpjAaK87n93leEJVa9jE=;
        b=izFO1jjY86fxlhwcgV0Sg+vlXEQUyfAUhpmM20CJQtbHpqytXWHlao2ZGwLwa39TLm
         AzdKJNbP/6li0n70HavRSJ2ICXUgYWy9sWnvr3LMuMsC6qCMbAotgM4C42VIiFmd+xJv
         dSs9Rgv6O6lV6N0t1oqrW5Ucaicju7rnU/7sjyoG2HHpV8MQJ3hcVKcBRxWLJ4WgQ7V2
         zHng/CX6EOUEEy0zy4h/QhBDSD3L+ub6OXHgLML8IKfPnCeL8/WgKwhIvQMBmS2XCX/9
         YYnUEJbFmvb7C4i4bKCJ8+8hy6mPCjBzwCf4XkvaNeZU92/ob33gIoiVkisHV02gydQf
         tF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473211; x=1783078011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pL854WDCy8UICjVgQlEGBttHpjAaK87n93leEJVa9jE=;
        b=P2T3wXgTzoNnmJodDWJOGtD2WLgaiZvN0SCz+olyHNZHvl95bxMVzEGx5AX8z6kNfP
         lEm7u3yzmB7wQUCF1WVoRI9F2aNPZifU3sNsEhdyt+mHKJCstiMVFG9K2K8gFGiSjDKH
         rzeJf1ccvHQZ1jeYf4Lo8inL1pZouxKFLEM0Be2TjuJBS6+fr0j9f6UT+d+wJQq7+XEy
         ennvWkHmBdIr12kRCUh2COMaGiZ3SHFDMccK+wnj9YMo9JMi23IwRWGXZic/5qy0g37l
         A8pGP1QWl1mMk7NmuqHvfij6uMFE0qjw3Mggz2Q2hEt75Y1MmvqtMPqsQhVU4moncn+b
         //HA==
X-Forwarded-Encrypted: i=1; AFNElJ9XHNasg1vm1eLsPVaWtNTuqRtMYTSQhv/7I+LNvagrPKiyqFL6QyC0ePJHjwXAw33uFD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1CMpK/LljMQ14VlRuFdX8nCDkzyz6SDg6kjZtN5GW1cuQUme
	PpDJQEhOYqRRqodR+zZF1WWVaBiIMhMUiV0GUpkAIlIsHBmx0wyuniN6hCEyLm9beuY6Gu5X4U6
	0y5ONnnxRrXTJ0/t7WjTvhR3l4NHGojRTqFdBXRmJKBnkSKM1zHuRJ25Gp0umDw==
X-Gm-Gg: AfdE7cntt7EjGmgtVgRAnLyHMz5Ii2BpfUjcZUmw+R2STzcIF0taeBHpo38y0XVA+Y0
	c9j6KqTpGBH1p7jr3LFrA8VaClqpx7d/QREw8r8bAe4G1VqETg+7CM4al4xmVHbM3VlcjtDT3Vk
	e/zH0FRBi1hQthupPyRhQJluIGY+YysyuzVZc/VeBIJlMa5xChMalcUub0t4VXbWGJepygMzOiM
	fixZ8FkyUOnuT9tWu8DbcDItV5sz/4bgrD+JJGdlmACHxWhpsTVdEhNaCbgOJcWZOpdXDqe7/jX
	ku0L31spSzyoDelREywg0cT8Cvgh8CXAl5PzbNmbba6KQJgSXevY/HcKwS0th14rrpA8RpRXwBm
	TLVr7gd6f5s/x1aFrHQd5l8KZjkvM2JTqE3Xx7SYQXzQVlnHDHbL+0BwJAkm07m+o/FI+Nbz8ws
	a/1ozuCaBGEdhhIXv7
X-Received: by 2002:a05:600c:8b4b:b0:492:2f5b:7ed4 with SMTP id 5b1f17b1804b1-49266892555mr90504675e9.36.1782473211172;
        Fri, 26 Jun 2026 04:26:51 -0700 (PDT)
X-Received: by 2002:a05:600c:8b4b:b0:492:2f5b:7ed4 with SMTP id 5b1f17b1804b1-49266892555mr90504355e9.36.1782473210815;
        Fri, 26 Jun 2026 04:26:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690168d5sm97634785e9.14.2026.06.26.04.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 5.10.y 06/17] KVM: x86/mmu: Stop passing "direct" to mmu_alloc_root()
Date: Fri, 26 Jun 2026 13:26:23 +0200
Message-ID: <20260626112634.1778506-7-pbonzini@redhat.com>
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

From: David Matlack <dmatlack@google.com>

commit 86938ab6925b8fe174ca6abf397e6ea9d3c054a4 upstream.

The "direct" argument is vcpu->arch.mmu->root_role.direct,
because unlike non-root page tables, it's impossible to have
a direct root in an indirect MMU.  So just use that.

Suggested-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-4-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 97705c28a97e..b168b804ac7f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3224,8 +3224,9 @@ static int mmu_check_root(struct kvm_vcpu *vcpu, gfn_t root_gfn)
 }
 
 static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, gva_t gva,
-			    u8 level, bool direct)
+			    u8 level)
 {
+	bool direct = vcpu->arch.mmu->mmu_role.base.direct;
 	struct kvm_mmu_page *sp;
 
 	sp = kvm_mmu_get_page(vcpu, gfn, gva, level, direct, ACC_ALL);
@@ -3245,14 +3246,14 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		root = kvm_tdp_mmu_get_vcpu_root_hpa(vcpu);
 		mmu->root_hpa = root;
 	} else if (shadow_root_level >= PT64_ROOT_4LEVEL) {
-		root = mmu_alloc_root(vcpu, 0, 0, shadow_root_level, true);
+		root = mmu_alloc_root(vcpu, 0, 0, shadow_root_level);
 		mmu->root_hpa = root;
 	} else if (shadow_root_level == PT32E_ROOT_LEVEL) {
 		for (i = 0; i < 4; ++i) {
 			MMU_WARN_ON(VALID_PAGE(mmu->pae_root[i]));
 
 			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT),
-					      i << 30, PT32_ROOT_LEVEL, true);
+					      i << 30, PT32_ROOT_LEVEL);
 			mmu->pae_root[i] = root | PT_PRESENT_MASK;
 		}
 		mmu->root_hpa = __pa(mmu->pae_root);
@@ -3287,7 +3288,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 		MMU_WARN_ON(VALID_PAGE(mmu->root_hpa));
 
 		root = mmu_alloc_root(vcpu, root_gfn, 0,
-				      mmu->shadow_root_level, false);
+				      mmu->shadow_root_level);
 		mmu->root_hpa = root;
 		goto set_root_pgd;
 	}
@@ -3319,7 +3320,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 		}
 
 		root = mmu_alloc_root(vcpu, root_gfn, i << 30,
-				      PT32_ROOT_LEVEL, false);
+				      PT32_ROOT_LEVEL);
 		mmu->pae_root[i] = root | pm_mask;
 	}
 
-- 
2.54.0

