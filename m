Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548751;
	b=ua6QmZB3wvlm1mdhAE59iAG66fIt5TKpZO4aDUQNRySNi1UWrI9oQJZFT2444NQfKJ1q
	 2AR1GrYYdcpB3zRXCTIxXfUV0pHAS2hijkZeVUInEw9tTU8kj0jILtxMLltzZuQ9J8nhi
	 NQKfRLV8lwrunL6vMRldExXd8jnbMMpZrsVMBUNWy+JD5eDFtvrOyGTNWsYe6x8F6JXPY
	 5+uGu5cBSQUAnM4Uc8q01kD2fwomm+SyYr9KGzALLr20MlX56hAH4Gwy5p18OQScRI0jj
	 XKH87gIXVnplBY76OVztnlIDSB6tKfqyd4JZ9h7cUmJCSuU8i3JRgvxWkbGIPBAvZ0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=LM3zXXEyrs1k6iikZyGFv5HI2GOa7cTFeTDBek3U1qE=;
	b=UmaXe3lf5WBxOq6NcBYkPzF+9lIZArtBQWTtmlQGv27L1cER49Vj47Fc5Qiv48CstOuI
	 aChksEB7OaFOKRq/gZJYYmxBtOtm7KOgupCtZpujZyPmaDCJVB4Imu/MMkO4oAcL6QS8j
	 qbnfdHfHl86I7xTfpcInvvwKX9qabz5+x5wges0UtmKKpYNorEsuAa/CrR2xfrj8UAsBq
	 HTtkHsktq8h/OZ4Boks6+57nO7LffePS+lc81M00nuKJkv0sVVO3Mk4aXpHjXmD8xQXeA
	 rchtYgXYPFoN0pJafWIvIWtHs9zwvWgS0J15Pzt748nxf1rejDnGbH/8QcaHYAcEqRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fMu1ySdm;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23E9606A319
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 02:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C23E9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fMu1ySdm
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3aaee1fc104so393872a91.1
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 19:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792548750; x=1793153550; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LM3zXXEyrs1k6iikZyGFv5HI2GOa7cTFeTDBek3U1qE=;
        b=fMu1ySdmKczYVurWwRxucpMNpuFCzKTBtLPq1eOEyqTkETBtmQwuLv0iM0GA+FQbfD
         tiDfoFf8jXxeEl1PBK7MWgBoKp3C68m3EyMvWhzkfVLH8W941S8H8IOZv54egwQhxV2a
         zNgOnb9IoS3+PR7ankyuxnZZUknQdR6kX+cRptdznh88kvpg4AhAfOucETHRan9RV3DN
         acY+ogOaCktWPGKQGEmGYpW3xhSrNlVWwWkhU8c1VlaACVeKmkb4L2FN5reRGRnV1s/j
         +H9jOTK36MO+3buvLjxTi0pzlgsfIO9TmgPajhbAYDIOj58VjxZnpicWAIfuFhdnDXJ0
         d2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792548750; x=1793153550;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LM3zXXEyrs1k6iikZyGFv5HI2GOa7cTFeTDBek3U1qE=;
        b=bLAuZUuMztcWAb2qlmmUsQQKYBtVLvv6fMgkEvJyWL7a3lzWHgYLiEvHfqEtQUSGQR
         ebqTn2Tz4VXmZHmg4Z5u3y94kQfbf/nuO2v19+ZtbRAsm5hV8WnigAGsYu4xZOcCKxyt
         PFVrl7i6+rbpr2ftXZ9H+PsSXVS4W/OMxfOkOiXHZ1Tx87g5F7pEHMNCzAEylOAzetWo
         30sC7gWP+jhkak8DQBhIVmGozODwZuGn5jzZlcA+MG/JKj1b/w+qiKzBAAUQxgSxRgBr
         lp6USJJQxpf4Y0di9y2x2zZOVpZt7MhyEkICd1VF0wwbLEhTNtlq1y0sJmyJ3hMUzySb
         5LTg==
X-Gm-Message-State: AFq9FYKrRHeO5v7QGBfVlFF5NlDnmgYGAQA/trK7VUI/O6Ed6DYmuj74
	l92AOJ9CbzvLujrLgL8pmcwDUXFMSnKtbGT9ImmAWQ9vHNV3skDSwpEB/BTKTdY7D3ZwlXbQA40
	nv7X+aA==
X-Received: from pjbhg5.prod.google.com ([2002:a17:90b:3005:b0:3aa:ab59:7e2e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2786:b0:3ac:acf5:6daf
 with SMTP id 98e67ed59e1d1-3ad8707bffemr601484a91.66.1792548749874; Tue, 20
 Oct 2026 19:12:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 20 Oct 2026 19:12:21 -0700
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
Message-ID: <20261021021221.1703700-1-seanjc@google.com>
Subject: [PATCH 6.18.y] KVM: x86/mmu: Preserve nested TDP shadow page tables
 if they are used as roots
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Hyunwoo Kim <imv4bel@gmail.com>

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
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 205d314a7583..1fa251ca4dcc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2630,6 +2630,7 @@ static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 			 */
 			if (tdp_enabled && invalid_list &&
 			    child->role.guest_mode &&
+			    !child->root_count &&
 			    !atomic_long_read(&child->parent_ptes.val))
 				return kvm_mmu_prepare_zap_page(kvm, child,
 								invalid_list);

base-commit: 2ff600d29ee478d0a8d46ef8a58afb5e038fe692
-- 
2.56.0.218.g1ec904b173-goog

