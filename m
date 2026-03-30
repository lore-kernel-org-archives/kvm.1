Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C53A8733
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856883; cv=none; b=Q48EyLSaBGJl24FZ3PIwt0ofg3NgsiniSNFur/OXl0XdrZ1bp5uy9Z3nJbWcA8YNsQ+x8l2WtDUEuXW1haQ/L9zI/0JUEPNeR2cKBlHXOse/L4D5UwBgqEu7YDZrWuv7B0jVzop2x75kTz7L1HAGxhfM+SzkVuGtCNkjGKsTe/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856883; c=relaxed/simple;
	bh=7GMzw0oRiafV0eMb7x9aC5ZHTmc/GWR5ESfda8BEsAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAZ6x+kCTUMwm/JU3F2v/arPHqgnf+S7UznZJEYqhlZX2QOAHcz7Sq0OIxbjq/+GknF+fjyY1nyTij6rA00d3Ty7ZOFRmgX8e3NrGsyRG2N8nQvFY3N8ywAKQl1pouYANuiKVh1XrfcTiUbBkHFsWGzEh9Z3NFzZimBt61QtAqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2mzn1qN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lWhdLLEt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2mzn1qN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lWhdLLEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774856880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qg0u0qRIxbfnVPhgM3unvPlEH448ub4jA5OeQ5LRf0k=;
	b=B2mzn1qNuewpZXw1Bx+ruMyCz7cvayFl6t+217k2euJ+M1gO6wJLaIVljVXT3QRxHphD6x
	rjjEN0k//sloDHI1MQqVkB1OwjBwclHCa8EzGCgZYWTtfPkbqsrkfdiedVcbUWDNJeg2ST
	82YGemU56FxIewnte/+10+NRle2g3Ro=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-EgNkTWJAM1qpNhIjhDuDxA-1; Mon, 30 Mar 2026 03:47:58 -0400
X-MC-Unique: EgNkTWJAM1qpNhIjhDuDxA-1
X-Mimecast-MFC-AGG-ID: EgNkTWJAM1qpNhIjhDuDxA_1774856878
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4853466655dso24905115e9.3
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 00:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774856877; x=1775461677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qg0u0qRIxbfnVPhgM3unvPlEH448ub4jA5OeQ5LRf0k=;
        b=lWhdLLEtOc51DcthOQqW66KiGMwCfPEnh1otj1+EBE9XAtdKPF4dc8XOZGbNhtLALR
         rmgCBjfKc1OL50Mo2yKnVAg7wQ136pV86wABGpbquiimWM5jxlEJZcVJXoIAKby+w4Xm
         bJFD3gipgVMYNPBqzT2IaQ8G8NIFxnfr8t3R3npNU8MiG+fX33mIpyMTxtjQWPZhnpln
         n7uW2+Uk/4oxo7cOE96t0IhiAdpWFlbPuthpjC0TzpCPtuQ+DRHJYbhc5tHao0OyPWuP
         Ia7bruZOQKeh9KrK84OjnD0gj8ZN29jG8OG8RxZEKsW/UM6n1bbBUyq/bnZEj1Tbfdu4
         dtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774856877; x=1775461677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qg0u0qRIxbfnVPhgM3unvPlEH448ub4jA5OeQ5LRf0k=;
        b=eEnM3nl/bYlaCzIX60G7vQeVmXsj8qLWUUYhbu9LdlkCubqMFihoaaTEbciXpuz7qd
         4L4vA64xCOHeIusMcONUe55vHOIuwDwxLz1R5Y0Z8TqlIEunFBukH2hjeYx9R/8DqA3e
         N8uW8Rj+vyLoMuAX+61OaZYdfkdbNGzsVvPVOTtVDbfC9I0LgB0xZnmjGrovqHL/27zp
         y5K2Lc8OxyrhH8Ks2tNmA5UhBMH668zUqzWNGZA7WO/niaEEq13zg+FHIPNZWefUP7U3
         vwaOrLgx8slQWFbz2C22FC9P11QTvqb6TEsRFK+3Bv2pDOUS1zDrU+7+UI/UDd05rYSN
         +9+A==
X-Forwarded-Encrypted: i=1; AJvYcCXaQgsUBJrOwHqqSrD99xmXVCqRUj5NX+YrA5YiEX79pfy5s6ITC3KK6QAABZI9ffvIR1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+4KT7LNMJkMI9GynA2L804DkXCUafWpYOsn3il2Whlh6MlB4
	BwsORHy0rRIPCuKijynA/5kQAvan4Fqyxs6SyOhy6elgEu/X1Xy0Wqb58hDYqSi3XA/7Po1o9jm
	JqNtQDlp+CenBJTdiWrUG61rwX9Zzv31l25sTO6MxgKilsWNrJOQxCVTvS/sOjA==
X-Gm-Gg: ATEYQzye3T2kdmssPF7RFHgSqHZj+aGOQE4J1svaA1pov0GOpVObr77bhzkAUFGJNAf
	vUK1DUOxKnICSkZuP7uBDN6eBc0C/hK5x/VSe6COmyGIL3LczcwCYX40DfSJdpuMeIw0EgA7mVb
	Q13hXjbMjQCE4f5rq1N2GXB7TCwbZ7plrrz9lTLxtgte74Fj4jZFZURX6wqD1Wj2viJYDScrJDj
	hQeG6Jp43IiRvYwcwZMw3786ob3eFMntR+wogEIeQJCXYDJQzK/sgJock7BymzfQPkBx1Lkapv7
	FLfJqRgkkG7Ijlv0p0u3pB/v06vPVPMksozsLE8n3Edb7N6H69ySTleKyJXEaTDfl2Q9IS9J9ht
	uH0P6xBa8QMUk4DfqmSYsVMR+8MxD2vzT/87Lt2IVp/r8vr5yvFJzuNy6LRDDvI5TsZT2QdWTkc
	LdvX66HtvB5pCYKAFU92tawQZ6
X-Received: by 2002:a05:600c:4f53:b0:486:de04:5906 with SMTP id 5b1f17b1804b1-48727eda749mr187072315e9.19.1774856877176;
        Mon, 30 Mar 2026 00:47:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4f53:b0:486:de04:5906 with SMTP id 5b1f17b1804b1-48727eda749mr187071945e9.19.1774856876706;
        Mon, 30 Mar 2026 00:47:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9506dsm251858425e9.7.2026.03.30.00.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:47:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH for-6.19] KVM: x86/mmu: Only WARN in direct MMUs when overwriting shadow-present SPTE
Date: Mon, 30 Mar 2026 09:47:52 +0200
Message-ID: <20260330074752.136232-2-pbonzini@redhat.com>
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
index 01e159941434..440e3d9fc689 100644
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

