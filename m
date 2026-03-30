Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20BA3A7842
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857157; cv=none; b=CezzK0gWe0lUa1PzCENzx81adjc/3r1EDESGyLOOZVks1Ec1JRKW65ha7da8RunJOA36DhmDr5wjz+xuWYimlhRH0E/zUE10NlB5TL9l4n7LyWqN4buC6Jf83bfZh6HxXx7/cEVq65zajcBct/rw9+MkYbMZu0vMOU2TUVTRldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857157; c=relaxed/simple;
	bh=R0ypQUt8X6yI8jZha/45XYs67nBEar1Fy126hFI54mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvH3y98m05jf9orey7YVgs39bV5GYCoqnbVjIFN/aevTmLLNfYWtSBbr78vr22mse0lFHeiqDPpb1RCf8sCYj7mWhjvuxj1NqcsFsxugdERzvLVTzLIZNC3Ofq7Y3o1wGwzti+KogqhXf3iiJrdDHmN5vSMhGH4ZXnxjzOukHgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9irUEt9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAixxqL1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9irUEt9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAixxqL1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774857155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qsY8xAjV+avJ8ATdoTJ48MQgua7vE0epI6pVU69UaJs=;
	b=M9irUEt9ec7ffydIA1w01lf1fpjtdKJVerOes/RaW+2L2yEY7aJM3qmXMfK3D/6Y0pApLn
	pLMqX964IYXX55CZK/AkBSFR3lIfCHzxeS9JpnKVxEiKH6KdqRFY+ax0REqBmqB8+JHAEU
	ThOpZiruie22L6hfm3ObFbamPqFTroA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-gWNbrERQOqGv_fZQuuuR6w-1; Mon, 30 Mar 2026 03:52:33 -0400
X-MC-Unique: gWNbrERQOqGv_fZQuuuR6w-1
X-Mimecast-MFC-AGG-ID: gWNbrERQOqGv_fZQuuuR6w_1774857152
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b8f9374dfso3102768f8f.0
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 00:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774857152; x=1775461952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsY8xAjV+avJ8ATdoTJ48MQgua7vE0epI6pVU69UaJs=;
        b=BAixxqL1AYerB1nmQVXGP806S28a6y4tJHTJhka4XUz1CM/IcsrnhjH9aVrTzjElK2
         6H5lqi8BGONL3Dwnow9pNCvIGHbQ/Ca760A4i7EYmZW0dK+AHCr8qQcTXxka3fsbk/Qf
         TjQfZT1FS6mTm7yylJyRvlEe+YcLSbBg2Q2ozRuvmMq9pvFd27NXyGE1P447DqfLOQuX
         BLVTVcz6LRwSV1NavkvxDNCgPoAvi2ALU8guR7gOJq5ULTJdoQr3aQa7qCEz/+r5ejzP
         LAGRP7BykaVA5K1C7HRYZvkn4mfi3WoBAkzNGtPN//LMl71nyRfSzB+ZzsUWyIEO+OIV
         zOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774857152; x=1775461952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsY8xAjV+avJ8ATdoTJ48MQgua7vE0epI6pVU69UaJs=;
        b=nrbG+DNcDY6C5hjlvtFHEyMY4R14IL/zAGwyZf3pi8T1x12X2sYKGj+PdU9DhH9VSX
         tJITQ/ApyXwfGgRGNnkmWOcseeTbV+tL2qNW4GbHTpgPguAIWQRFPTFszU1TDK2EL6mQ
         v+pILr+VsKgyGvOQTbwyzNGjppLHsK1of1MGpZopNGohMgsbU4x0sDT/OT6U6gcno/qJ
         TnP8XxVgj5/hKc2SkLOv0cxS78ZXgZeFyPRzmhRqjb84iYoQOeIlH6dGBkHad5Nh+P9/
         k6l1S8iEKJYZKmJzOckphxK5RW3C+2G8SEyXCC5BhHj9UrH3V1FiGNp4xgtcLA2UcZKD
         0agQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWZZ7Fta+eE76dKTrhn4tk7+aEmXRLLDdOJnwiaglN+DMLmk2alTP3ZfLWZAHe9uxrceI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk8Bk1y80Ro830x3p8n2nLmH8Ryesl1v1ttorLtxJFckRfq9kH
	6Ej3CkMiPyOXQdAb7L4dKIhirZemV2rip0jEfdzLnlKEzQXU5kWVPkHyJ0R1JiFEDPVrn6O5tVY
	TR0KteaTtadtlVRkzG4v/46rqKHMXOP1EmOy1uNtIuNz8zBF1bc/sZQ==
X-Gm-Gg: ATEYQzyCMzCOQ7JvHdJ5Zmyf6oENNmSkmipLjGibzNKyvaB0P3oRa4JfYJMAXEEZGuq
	1kBsfQFMbBGTVNUN6KjuFHvG2JWN/DoXtQlApT7cFd80bgfwb0Evonm1OzclzvNklwUL+Gwd+te
	ZLssT7zlalBnMdCjEnJyt+jCMxvLnlQDNluNJsyRUL0X9suqnZSzZZgsIF3HE9jl30oBjqihuzp
	V3i0wYuS5QLfb7feR5oWNZRqt4o8QZJ+ZkGeU91o+0Y9fFiZ3U5g6CfIIEmz1G+lZRoOYnaQr8N
	zC4jv+4wNCoquTIwCvinTn7ZWMtVWAl8/Bh0Z1t+Bu6TYJvynEUyfSE1ZPXzsAs4WQ4pEMlM8Wu
	00OjgfOdLxMhRoNjR7c6XX+g2hieE8hugc33+FyG84adQ8qKlCftqGtF/pkIX6si56VaR00ofL+
	kzl4+IzOno9cfssrAA3GcQaX6G
X-Received: by 2002:a05:6000:4312:b0:43c:f67a:5b50 with SMTP id ffacd0b85a97d-43cf67a5d78mr9610880f8f.10.1774857152142;
        Mon, 30 Mar 2026 00:52:32 -0700 (PDT)
X-Received: by 2002:a05:6000:4312:b0:43c:f67a:5b50 with SMTP id ffacd0b85a97d-43cf67a5d78mr9610834f8f.10.1774857151639;
        Mon, 30 Mar 2026 00:52:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf24707f2sm17673863f8f.26.2026.03.30.00.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:52:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH for-6.12] KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
Date: Mon, 30 Mar 2026 09:52:29 +0200
Message-ID: <20260330075229.143726-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit aad885e774966e97b675dfe928da164214a71605 upstream.

When installing an emulated MMIO SPTE, do so *after* dropping/zapping the
existing SPTE (if it's shadow-present).  While commit a54aa15c6bda3 was
right about it being impossible to convert a shadow-present SPTE to an
MMIO SPTE due to a _guest_ write, it failed to account for writes to guest
memory that are outside the scope of KVM.

E.g. if host userspace modifies a shadowed gPTE to switch from a memslot
to emulted MMIO and then the guest hits a relevant page fault, KVM will
install the MMIO SPTE without first zapping the shadow-present SPTE.

  ------------[ cut here ]------------
  is_shadow_present_pte(*sptep)
  WARNING: arch/x86/kvm/mmu/mmu.c:484 at mark_mmio_spte+0xb2/0xc0 [kvm], CPU#0: vmx_ept_stale_r/4292
  Modules linked in: kvm_intel kvm irqbypass
  CPU: 0 UID: 1000 PID: 4292 Comm: vmx_ept_stale_r Not tainted 7.0.0-rc2-eafebd2d2ab0-sink-vm #319 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:mark_mmio_spte+0xb2/0xc0 [kvm]
  Call Trace:
   <TASK>
   mmu_set_spte+0x237/0x440 [kvm]
   ept_page_fault+0x535/0x7f0 [kvm]
   kvm_mmu_do_page_fault+0xee/0x1f0 [kvm]
   kvm_mmu_page_fault+0x8d/0x620 [kvm]
   vmx_handle_exit+0x18c/0x5a0 [kvm_intel]
   kvm_arch_vcpu_ioctl_run+0xc55/0x1c20 [kvm]
   kvm_vcpu_ioctl+0x2d5/0x980 [kvm]
   __x64_sys_ioctl+0x8a/0xd0
   do_syscall_64+0xb5/0x730
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x47fa3f
   </TASK>
  ---[ end trace 0000000000000000 ]---

Reported-by: Alexander Bulekov <bkov@amazon.com>
Debugged-by: Alexander Bulekov <bkov@amazon.com>
Suggested-by: Fred Griffoul <fgriffo@amazon.co.uk>
Fixes: a54aa15c6bda3 ("KVM: x86/mmu: Handle MMIO SPTEs directly in mmu_set_spte()")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 31921b6658dd..2c11819bd216 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2919,12 +2919,6 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 	bool prefetch = !fault || fault->prefetch;
 	bool write_fault = fault && fault->write;
 
-	if (unlikely(is_noslot_pfn(pfn))) {
-		vcpu->stat.pf_mmio_spte_created++;
-		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
-		return RET_PF_EMULATE;
-	}
-
 	if (is_shadow_present_pte(*sptep)) {
 		/*
 		 * If we overwrite a PTE page pointer with a 2MB PMD, unlink
@@ -2944,6 +2938,14 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 			was_rmapped = 1;
 	}
 
+	if (unlikely(is_noslot_pfn(pfn))) {
+		vcpu->stat.pf_mmio_spte_created++;
+		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
+		if (flush)
+			kvm_flush_remote_tlbs_gfn(vcpu->kvm, gfn, level);
+		return RET_PF_EMULATE;
+	}
+
 	wrprot = make_spte(vcpu, sp, slot, pte_access, gfn, pfn, *sptep, prefetch,
 			   true, host_writable, &spte);
 
-- 
2.53.0

