Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9303A785E
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856959; cv=none; b=TAoXO/LueYo89ggHmImfotg7dGRdkscsRMSYMTuh+37U+J/f7tdDVVUJdR579eE6zUWZoEMOV5SPtyccF3U4B0IINeneUplVmJWhdPccsJ6eNgrAulKfvXeqVYBewt3k/fXb1wKHpBiFpqSSrhP4EHMwaZ1fH0WcbpfyBfP0QG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856959; c=relaxed/simple;
	bh=PgD3o0jwMp6kDXwgJ79jkjmidrEPYUAbk5Dd5GJ6mE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cwR7cNGmp4MUgcka77RmxVTUBudSgajGLFqgEV8+OWh9bnxnTGpliKWzgZOQaQRpGPyj4v0J9FpHjIeSVhleF0JpBPdSzwvhl+DzN+5Z62bmUJE4GYDS3LQQXi38yjtr8pH6RmdR4rkUKdGaZXgONkRFsTOJq9T+sOEhQOfzw+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtscpV1n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDJxOLAU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtscpV1n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDJxOLAU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774856957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JVY6xwa07Prh7BoAXHjyZRtVv7vEWGmZ2sCIyoIQnwc=;
	b=ZtscpV1nTMNtvG/BBLiyCDkNNfDVLZW9IO7BGqSmbmI28Lf3rImwio0FBVYpM0UOdAifAZ
	g7pq1jWYe8141WiYsZmAaILj2H4WhPPqr61gYwZWE2S8wM4DY4hp4GEXvqVy6R1oApOv0x
	+xnbAginK7wk1QmJV08e76L6zNpymRw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-nBLesAagOmi1lwXr5kFfrg-1; Mon, 30 Mar 2026 03:49:15 -0400
X-MC-Unique: nBLesAagOmi1lwXr5kFfrg-1
X-Mimecast-MFC-AGG-ID: nBLesAagOmi1lwXr5kFfrg_1774856954
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b95f9f837so3351554f8f.0
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774856954; x=1775461754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVY6xwa07Prh7BoAXHjyZRtVv7vEWGmZ2sCIyoIQnwc=;
        b=VDJxOLAUdFVmZFfJcUrJWCELk0XJmPkp8bKsuKEbcJyvNu8t7Owda2G6dnY1N53giN
         BSQpEdKK+o5ytG7//vGF3mM5yMYkJcF5gOuTeqTRtRNYCRee003LooiocV5xhN0/lYep
         7lPT2P1i2Wavzaa2q/Bu3z5lyOpXznOWb2XHRC5A7mP5L/yp0jlpcROkfR/TpFOlku9X
         Pgm/oL2/0jn8C4yl+3EfXmrCF1X8q0f7vU74XstaMkYWdFqFDMl3+URj5cugwGAUnAUD
         eoOJPYBoP+CCASHBvcILSRVWyUkVxknFJvi7BBhAfK0KRkho+tPn3PtiZRd0JZVWs37s
         iZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774856954; x=1775461754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVY6xwa07Prh7BoAXHjyZRtVv7vEWGmZ2sCIyoIQnwc=;
        b=UIYCv5GRyCiVluEk8IC7nsc20qjdkmySmSxHxedwCp3Z2HNoggreNThyJ1iiSGB8gi
         eCYPApcVNQh/c/2+BKK2v6WCLTv0Q9RspK4m+PNyrdx9DCMoJ5zYOXrJH6fRWHdRZLDV
         7UW6Vq/IHMrFo8QOSqAZNwOzlmVzHzPrWg9v4lLkx5Ko/s6sCitcoDC3zGrkRUQYFDZL
         LI/1rGI69HD8nj2jKFFvd9ZJ36fnCn9ZqLL8yFyFneWXT2NjyMrycYeYMBwyHyut9iLG
         /U94N1KAFe/CgNETE1+ScziArdPqHY03/NkzyE5I0VyjFmRO/RZbHEopdTg4aFnenxKM
         VW1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVD5y5H3wTNOQEK5VWTgqv3KG1AosdfcYg8Q6vFhBUMPRWSPosxGbZvNTUPxZVLZEmyJds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFb/F4Vvh4gKUBMTj8zxcnpxiVFVMo4HgEVwZvoUpAG4VENCmF
	gYAnyiOdhI9GlvbpVd34CQSf+ZaYK19kTSwgB3wikpWAwWDqVqU2oXXT7cPKDqLTwPpR4MACzAK
	W6tmkXpQqKLY4hTWuyrRUxJcgByKYDEJID/KcDh81F65cw2Qq+8JnmA==
X-Gm-Gg: ATEYQzwM2cZ9zuDS/0gfbuvd8jOtNkmSfMu1m4JNFw6u+SvA+q4ClCiLWz8UXue3Y3b
	pgpnUAeMmkB71CO5faOEEziqAPxqiYvbSVJkMIP9kL82mwQcUvRoL1/pQxKDRUWce5Yoj2bdpxX
	ZyGDwWpv67F5sCx0TEyjfnvWsEo5WFVpMKbtGyMo0sOt5sCydr6nEaqZ6gVOZXo8duafLseF7hu
	YY+7QcHUocTQgsWtCk1eGJV/8BGeUkECuW12HlwPMtLa+kx0o5jkX5Bssc966PJPPSdCdrUqtBd
	p1LDvgXdFOGWNWNNivRVBilSOaPtUMKS0ZOsiMZg/gSlKzsFaJV173yt5L5l6WP6yPhxBFKY/XU
	CXwEWpKM2HY90EBuxo/uXgE54ItVuGhZ6bqHcvUw0/dkPuT5Pz+7pmBRJ2HKYzPYrvB4gHWwr2E
	0KX8/KszrfbAVIhwwjiE156GZe
X-Received: by 2002:a05:600c:c493:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-48727ef5571mr181061385e9.24.1774856954313;
        Mon, 30 Mar 2026 00:49:14 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-48727ef5571mr181061045e9.24.1774856953875;
        Mon, 30 Mar 2026 00:49:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d23679sm489316315e9.9.2026.03.30.00.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:49:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH for-6.18] KVM: x86/mmu: Only WARN in direct MMUs when overwriting shadow-present SPTE
Date: Mon, 30 Mar 2026 09:49:09 +0200
Message-ID: <20260330074909.140480-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit df83746075778958954aa0460cca55f4b3fc9c02 upstream.

Adjust KVM's sanity check against overwriting a shadow-present SPTE with a
another SPTE with a different target PFN to only apply to direct MMUs,
i.e. only to MMUs without shadowed gPTEs.  While it's impossible for KVM
to overwrite a shadow-present SPTE in response to a guest write, writes
from outside the scope of KVM, e.g. from host userspace, aren't detected
by KVM's write tracking and so can break KVM's shadow paging rules.

  ------------[ cut here ]------------
  pfn != spte_to_pfn(*sptep)
  WARNING: arch/x86/kvm/mmu/mmu.c:3069 at mmu_set_spte+0x1e4/0x440 [kvm], CPU#0: vmx_ept_stale_r/872
  Modules linked in: kvm_intel kvm irqbypass
  CPU: 0 UID: 1000 PID: 872 Comm: vmx_ept_stale_r Not tainted 7.0.0-rc2-eafebd2d2ab0-sink-vm #319 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:mmu_set_spte+0x1e4/0x440 [kvm]
  Call Trace:
   <TASK>
   ept_page_fault+0x535/0x7f0 [kvm]
   kvm_mmu_do_page_fault+0xee/0x1f0 [kvm]
   kvm_mmu_page_fault+0x8d/0x620 [kvm]
   vmx_handle_exit+0x18c/0x5a0 [kvm_intel]
   kvm_arch_vcpu_ioctl_run+0xc55/0x1c20 [kvm]
   kvm_vcpu_ioctl+0x2d5/0x980 [kvm]
   __x64_sys_ioctl+0x8a/0xd0
   do_syscall_64+0xb5/0x730
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>
  ---[ end trace 0000000000000000 ]---

Fixes: 11d45175111d ("KVM: x86/mmu: Warn if PFN changes on shadow-present SPTE in shadow MMU")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a8fe777ba274..dad7abb1112b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3060,7 +3060,8 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 			child = spte_to_child_sp(pte);
 			drop_parent_pte(vcpu->kvm, child, sptep);
 			flush = true;
-		} else if (WARN_ON_ONCE(pfn != spte_to_pfn(*sptep))) {
+		} else if (pfn != spte_to_pfn(*sptep)) {
+			WARN_ON_ONCE(vcpu->arch.mmu->root_role.direct);
 			drop_spte(vcpu->kvm, sptep);
 			flush = true;
 		} else
-- 
2.53.0

