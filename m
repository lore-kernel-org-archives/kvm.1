Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A556B3CAE8D
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226259; cv=none; b=JCDlALIe12Og2h7BzO+ZUI8/nuN87hyHRDEF0SWkfpr5ZDTi+O8EqZ1yXyYYPyVgA1aAEr+xqitXF+BF8pwJGn1Q94iC14ipEQfaxAltSWNoiVjMiOHeJBVWx5U7+aawvGSdXUKmIS41tnfFWaQRPOu2ticrSoWUQH3O9Q/RAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226259; c=relaxed/simple;
	bh=nxhU3u3/44UIWGv8Z0joiYCgy1yhL4yxlOFfmkafIgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q/8oZwrQsb2i6ZxJ4J3YOGNK/YZucmb33cwq4mwPbXonSEAypn0HeuoEQ+hqs4GJXah+i9GJSSLmJoeh+tt+vu6uBZZkZ4fzwnsFOlVfzyR8u7MPvdNJwPx2kJI4pbA0yRmS3SDT58BUW29qMzh/SOmNHWZLfBS9Ga/IPYZphdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=CHyh+lYy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="CHyh+lYy"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so7837550a91.0
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1773226257; x=1773831057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RLRAIJS9+xmUqJ+a2ICFLZwCy9T0XK2a/x2w50jOsh4=;
        b=CHyh+lYymMK1zhYItuyIq8rUbAV1Bc8ykujz20TieZM7BMOhFZ3r0oJ/rR+WrMfMwl
         MV71IRvg4gZIzEJN99FoUThOVA2rPTjsk6vsFBaji8HUwyycOkBKdA8vxUOZTVEPLoUl
         m8Qhsf/XWayjzL472uRI7fjGQ4mcXSYwNv2jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773226257; x=1773831057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLRAIJS9+xmUqJ+a2ICFLZwCy9T0XK2a/x2w50jOsh4=;
        b=O6Gc0rJZ6k25GrUT75koiam/V5zPxUNPz4Y5ivt6CfsxXpJGH6p2KxMrnifC3rAT2a
         g/NbubI+d52LZTE0D+arIpBGOUF5wZspbEdG7Nlu65XvUwmbagDdJKYfMWYPwq9/+upV
         ekfSkeaTm/l5JNAY/4mbjqi03Kgu6hEBrED/VG/fSycmCee1SFXxNuCc5nG4yhA8fORG
         dvcLzXA5rtKoGaXGgboY91p0dXCCdIn+HCkMSVePn62CiepiWwKmyBmC7YzVF+0UKiN6
         k75puTZ0tktCGjFMooYdGPjlaLlqDiJGhOVIeFRXgpkoSv3atbhPKJptMKJaAA9g0G17
         2/vA==
X-Gm-Message-State: AOJu0YyMPs9YRaJicWi9mQfJMWfKJGNKsb8X+mehEht+hbuxhgKBakfF
	IWlNujSeUjCsUoSBmgCNNKIsJOzdM6XZoVJzk7hkka/Ufc3ERaRWfIKgni/j0BD6d6f0VFMQgDS
	v/FquUcI=
X-Gm-Gg: ATEYQzxiAQFfoDItlnWhFvsPAYG3lwh2ziN4o6Uv6E5KEO0ygb0a81lW0GJspCuss3Q
	wTC1HLoGnowPEBlmEejKQcNX+i+dZM1OXGlIHprX5sTHIo841kl1BYY/NehmzpUo5uuPr8h+aYO
	LnXzr4wV7vog76HUO1ijNANpC2e0Xg0LFUWfGikiH0CPfa3TyvvxQOURBRlv/8t2jD5qHFXrKBz
	sL5xPeEIzSpJW0GHeMzkuUoTL69c2oExbtznoUcDYS800fVGoisJR/XVoPhJE97WCfVSLaKTGhl
	dCOHv27S4WjBuyYbvmbZgC91RimOhJebavNDizygz7DqAEWwgpn0H+zWfX2WxPFmlCaDq9AL8lN
	cNeMp9san2JYlTOJwKozzl6ruFK4tYMLPx1bRFEy0hQlX7q3a7Nnq9QPEkvj59tvEOWVU5xOvdk
	GppB700IFbACK0aPEvb6e/nAfUrBQOpeUECHqIJXYNEg==
X-Received: by 2002:a17:90b:3d4e:b0:349:7f0a:381b with SMTP id 98e67ed59e1d1-35a01201723mr2197767a91.8.1773226257570;
        Wed, 11 Mar 2026 03:50:57 -0700 (PDT)
Received: from localhost.localdomain ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f05ee51csm5684401a91.1.2026.03.11.03.50.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Mar 2026 03:50:57 -0700 (PDT)
From: Taeyang Lee <0wn@theori.io>
To: kvm@vger.kernel.org
Cc: Taeyang Lee <0wn@theori.io>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	KarimAllah Ahmed <karahmed@amazon.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: clear map->gfn in kvm_vcpu_unmap() to prevent stale validity checks
Date: Wed, 11 Mar 2026 19:50:47 +0900
Message-Id: <20260311105047.18517-1-0wn@theori.io>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_vcpu_unmap() clears map->hva and map->page but leaves map->gfn with
its previous value. This creates an inconsistent state: callers that
check gfn != 0 as a proxy for map validity will believe the map is still
valid when hva is already NULL.

This pattern caused a null pointer dereference in the 6.1.x LTS branch,
where vmx_guest_apic_has_interrupt() checked virtual_apic_map.gfn but
dereferenced virtual_apic_map.hva unconditionally. That specific call
site no longer exists in mainline due to the gfn_to_pfn_cache
refactoring, but the inconsistency in kvm_vcpu_unmap() remains and could
affect future kvm_host_map users that rely on gfn for validity.

Similarly, kvm_vcpu_map() does not modify the map struct on failure, so
stale gfn values from a previous successful mapping survive a failed
remap attempt. Clearing gfn in kvm_vcpu_unmap() ensures that after an
unmap-then-failed-remap sequence, gfn correctly reflects that no valid
mapping exists.

Clear map->gfn in kvm_vcpu_unmap().

Reported-by: Taeyang Lee <0wn@theori.io>
Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
Signed-off-by: Taeyang Lee <0wn@theori.io>
---
 virt/kvm/kvm_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7a4fd1dbe0d7..88fc8b20aa8f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2887,6 +2887,7 @@ void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map, bool dirty)
 
 	map->hva = NULL;
 	map->page = NULL;
+	map->gfn = 0;
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_unmap);
 
-- 
2.39.5 (Apple Git-154)

