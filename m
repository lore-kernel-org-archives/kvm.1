Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395291;
	b=GyPdmDdD9Ak1IqMPGPDU3T/KRel7+1wBJi0abN1Ty2eQPyyFhaoqUBifmqAMiPYGFO/I
	 SpvZUJ25UTUnUxhptjDKWCe+3KTgX+V1vf2YNknNJaCyAMFzfX4KPABFiYFk64Nj7Gk9i
	 Hdt4KR0CXS2a1eTmDhX26vrXAYIh7A31WOp4LyyCiQsJpVWwpP1tyQjluFv/9WKByEbQb
	 rc15io7mnJ8wRyZCO6yJo2TfWZAxPM+K+vucOJZ3bix9YQy9K+v+/odaOrThYawihKjJf
	 DzvnG/l379htkB4EOhBfl6juqY3OPCFOeO/UqGyz+FssxZSU6YFNX0KbswK075AZGkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=cco2nkq82iuQQ+19T+wEIhTi8zWX3dqm0jybMBLyVmQ=;
	b=OlenaZrady3AeKG6ZZOwjmcqWWdb8xHLOeaDlh/On4LteMsjy1CTfze/ft869FNYvWdF
	 vuRw8n4KMtVcEA+x3ab4Bx1sIU3Drf5Rjs9/ZA+o/wX8Zx328NoiDppOeM70dyLSL1eQE
	 QM+9JfoPm441ZGiUxBoV6i7YFSS3eWn39yeHQF2gFne9yTwmpEgXVTGWnPLuVEUEXzLt0
	 Inw2gxo40SzfNtSwwub1u1vzHdd4MDAp9Vhdamfo4UigFytCz/ExtSqjmw0ijsLF1jbbt
	 dXIscWhJoQRMas7So1Wr3hWTSB6x7cbkbpFnZVCxRoWWEgc/yiECzycowwUUOYMRxVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lafWTZ3r;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBBE606CE40
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BBBE606CE40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lafWTZ3r
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3adeba76cadso824914a91.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395291; x=1794000091; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cco2nkq82iuQQ+19T+wEIhTi8zWX3dqm0jybMBLyVmQ=;
        b=lafWTZ3rwfneIbpzMFY/3F+jqzgYFkE6hIaCSdll4Av1BdxKoENPt66N1/zNuFndPf
         kvdHRa5vTnRTP/LG+zXDLsvPyzGQPRN+zf4Mo2V+1M1e1SzUV23hdkrHo78d9SmhiXs1
         wME0IUUzJK68fWP0nV42AoNV1ODjJx/3vnvPgO1GXQEEo+RH5oT+3FfnN6PDTKDWeBIR
         aWi80Q/0gyN+o6k6v9ixBxlqaIrzjxpTPzV6DAOSW1BQ7pPT+qjVmCqecxcPv6sg88ts
         RZXAbkHKhTurh0zhvmTjMWeFJyb7RD57r3K9ZRVr264K6fni4sU4LqVfvod18xNos8qS
         v20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395291; x=1794000091;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cco2nkq82iuQQ+19T+wEIhTi8zWX3dqm0jybMBLyVmQ=;
        b=XCULjORT+Lq4dC5gWQaSmpTaBEP7PeVb68nCIb8rLkiwJAGZnybax/B7uVkNgBmfs8
         8ISw8vDtKWTKLjlVDQBuEJ2rzoWOfawpoDQKh3bGgwdFOIAp3HLhRcEbRDHJB7N/GT4R
         H/GPW5qF9YJxFjQPR55tp6JCXCIkr9+4MpRzfDXtLIKptuyneFLZ603daqLptX1pfy58
         iGWJbKLGfWn5/Rz4mlgsupSj8ywa1BtgBMZiUJiNZtxsyjCUCRxZFO85+1prU8GROfXj
         0OigCaPO3CVrSDXkLOVS3SAa2u5vixeFi2jfE2eiLbE2MNY3vIoVHauCbo4YE58OV41J
         VILg==
X-Forwarded-Encrypted: i=1; AKwUvBwUkZrgLzl12a4BqZj6UXhI6STj90hAawSNXPUKt9C0VnUEuUsc9JfJSoLG17wE1DdJWJI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJreRaQm7ZDN8LrbmsvVmTwiFxbjCPsiGFy+UJTI/JjN/AEofRl
	x1H1vc0o66Qha/LsqkHnjFCRTBKjwLdnPm8eOooDhIHex1GUpIHrn1VegQtdTNnlTzLcYTbWv67
	LN2ibrg==
X-Received: from pjbev16.prod.google.com ([2002:a17:90a:ead0:b0:3ad:fc31:f458])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33ce:b0:3ac:450a:fa22
 with SMTP id 98e67ed59e1d1-3ae89536c44mr2992819a91.2.1793395290671; Fri, 30
 Oct 2026 14:21:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:02 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-15-seanjc@google.com>
Subject: [PATCH v4 14/23] KVM: WARN and reject guest-based uaccess if VM is dying
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

WARN and reject user accesses to guest memory if the associated VM is dying
even if the current address space happens to be the correct address space.
Accessing guest memory after the last reference to the VM has been put may
be "fine" from a safety perspective, but it's still a KVM bug.

Reviewed-by: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f3f59bdf7e18..ba8ea62b7304 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1355,7 +1355,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 
 static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *kvm)
 {
-	return !WARN_ON_ONCE(current->mm != kvm->mm);
+	return !WARN_ON_ONCE(current->mm != kvm->mm ||
+			     !refcount_read(&kvm->users_count));
 }
 
 #define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)				\
-- 
2.56.0.385.gac671c819a-goog

