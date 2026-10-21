Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551062;
	b=DuRRKT5G+K9h10wfMB4Ewfej/NkunkfkO7bDK4BCEsUTmf17vQ3z180yI1ZQZJgAqokq
	 2c5PhOpRoe53tFFACuxC2Mlg2cJf/JReMlwG3yxGPCjXNhZJgt6CIkAH2iwH/NwGsw8Lc
	 GKxnuiGcFOH+mYlObhC+5uoTgiTJfn3icvqoEh35GdXPV+KFxo8BOH1/LEoYaUqnMxfsU
	 dtXB10+cO8GKY9pUy2ay2h5XPa7gFmdk0bZkwvmYARaB7ZrXCa6hAmo6hwt9IeRdqgTH1
	 BGB4NHU5ljL3RH35PHcY8woL9G88RgRiH4qwx4vtXy4ZTD2ta/SkrSkORdK73FL+wUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=TRrUu+6otZ1MrISxoN37o96DSURfs40tWglYbeE1Glg=;
	b=xk0nrJlTi57FZrcnN3nylYVGgrqDvvBni9GjbFg9BcwOD1ejJ2jT166u42EEOMmHECs7
	 mHadBgZmPmv/4y8I8lypZn9enk4FPvoIOx4SHZFdLVximbM2s51FgV413L9Cwh/pKQNIT
	 38tEKcFgv3azxB8uUwwlCRdn+UAV1YvVl+CuIb1muytugH6D0NWoGGF+UMpqYPJ4DfrKS
	 ubtjyIT3y9wjqb1vd0rQyWQUXNrvzaCDcZY2Mbyb08UDxPM1BjVmY+4e4sHslsBM52IA/
	 x39U83gX5MHE2Ynto5/EmEVbYkJK4jkEDu9Evx9N6gKT6aKGf/FR7ev3AdjW6dZo4Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XIQjfX32;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE2606A31E
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 02:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0DE2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XIQjfX32
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so463339a91.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 19:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792551061; x=1793155861; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TRrUu+6otZ1MrISxoN37o96DSURfs40tWglYbeE1Glg=;
        b=XIQjfX32oJFj/ebKgzHO6OhbnSMlESzNivhvsQ5Nn+s3FCLO+894uYKuNslrFC1K1X
         KCayLxDollMC32NA0B3G5opyOmkTPMBV+qnwuBUJMNAWrCik+i1x1FoS7yWNReYfr4Kz
         YMJR+rUCn7ZR+mgyfUNFvrNS4nPuEGoeudG2bCeriSU2z6Jqj//RYeDtJceKcqt7QB+p
         0tfxEkR2gxjNCPaD5Lkgow9OeKWGNPVIeuH6mANwIPR0Rwk9auq/Ot2Lj1IOaxNsNrod
         cuJnVzpRPvHHTABc5SA/sjG5j18VMUgGQ7NqfvCrqu1vCd7JnCr0C1XFybXxZJWO5dlW
         Vxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792551061; x=1793155861;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TRrUu+6otZ1MrISxoN37o96DSURfs40tWglYbeE1Glg=;
        b=au6CCI3c1BL93TvOJs8KhHoivdUE0wqqMRff4vX0qeqrnPcCrw91nw2QXbQ4JjyNft
         GDb87NVxtOxXN2M2NcWrU7Ui+dbNM0i0iJ5jVyZvXwMMNQwbjAK1mFTr92ZLumr+BABf
         hb5QOTjZ3wIsGBZ33P270Gu23f3xVbrMimQA/xK/u/i5ppp9INdyJTzM0EFuDRPUgNWG
         gh3cshsJ62RaGzAJ6e2RfrGSrqsXRKvTfYRiUmbmdK01/AstQhUBivtfkmW9ZqVbyvK1
         gonM9vKG/eHoUhf4g2qVxkkTXMqml5BxHz8wG1uulOsye+qMoB1dnmug/vMzSN4Yhqgv
         G8tA==
X-Gm-Message-State: AFq9FYLzbA9+SouB+KwQmhRB8MWu4ZDk5p3ZjqCnCRUoCPFZz0BoFan/
	OyK6z2PF3Igu4OpEpeyCInBBZ8t66/3ReypaVA0QfVK9kmiUMtUxbwTKv/oIdVm4jUcYCJMIE8b
	vVpDwYA==
X-Received: from pgp5-n2.prod.google.com ([2002:a05:6a02:62c5:20b0:cd3:da0f:775b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ba06:b0:3ad:870d:1bfa
 with SMTP id 98e67ed59e1d1-3ad870d1c45mr410921a91.23.1792551061087; Tue, 20
 Oct 2026 19:51:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 20 Oct 2026 19:50:59 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021025059.1736339-1-seanjc@google.com>
Subject: [PATCH 5.10.y] KVM: x86/mmu: Preserve nested TDP shadow page tables
 if they are used as roots
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 7a2c70e777a00c32ebafd376a6fe31ebb91c5b20 ]

kvm_mmu_zap_oldest_mmu_pages() excludes a shadow page whose root_count
is non-zero from top-level reclaim, because such a page cannot be
freed. The path in mmu_page_zap_pte() that recursively zaps a parentless
nested TDP child has no such check. As a result, a shadow page can
be zapped even if the page itself can't be freed; as the comment in
kvm_mmu_zap_oldest_mmu_pages() notes, zapping it will just force vCPUs
to rebuild the page.

As in top-level reclaim, do not recursively prepare zapping of a
nested TDP child whose root_count is non-zero.

Fixes: 2de4085cccea ("KVM: x86/MMU: Recursively zap nested TDP SPs when zapping last/only parent")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[sean: resolve minor conflict due to lack of lockless aging in 5.10]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 13cad4becfba..d2428c76d940 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2237,7 +2237,9 @@ static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 			 * avoids retaining a large number of stale nested SPs.
 			 */
 			if (tdp_enabled && invalid_list &&
-			    child->role.guest_mode && !child->parent_ptes.val)
+			    child->role.guest_mode &&
+			    !child->root_count &&
+			    !child->parent_ptes.val)
 				return kvm_mmu_prepare_zap_page(kvm, child,
 								invalid_list);
 		}

base-commit: aca95a35f1bcc0626c4fa4d1252bf2d4c990a1a2
-- 
2.56.0.218.g1ec904b173-goog

