Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1DA23183B
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856880; cv=none; b=OxrxWjm8DPdlqvB7k+aWB2WZ5KjwWn/DUqZnGnQ0hqGEvMLRohwxQ7ysU8ymH/P45H4k5YECZIGoedGumBe2gU3Qdv5zdomqdPeD5qVa+dQizV0QavmltH7JWiAYp1iw/9q8hcy6RSFzx6108Yr9xGuqSrKtg1Q3C7OLqCXvi1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856880; c=relaxed/simple;
	bh=k1bITzSqw1ZFJDT+lcziOHSVt+l678M6zhCmLGBLavM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SKGjkwczLTQNToj0qr/LheX+kBWR/jYbZeCtunsDUixCCzCWWZinIWWQK4DeC/G24S/NRTeHN78c69xuJIBQjh99bAy1eckYI0DHnaE681hOWtQjhnIjGiteqoRZIwzWEDp3iSfPsA4aedE9SFHZ0vHySjZOfFhfCRW1ETkx8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5qj9Irt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJd9BQ0i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5qj9Irt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJd9BQ0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774856878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ee7WfC4ao1ITQjnVMBY/T1x8jIUaoFThw0bW/nGasZE=;
	b=S5qj9IrtFNeSQlEylT9O2cxxeM/Qo9wSW8x46LPBbyj7R3J0SoshCDcUku9zA/dhgmizK8
	4F4nBtV2vkkvSSpvTKuotvI+y2w75ChynO5GWqRp/KNatz64GqgeGFhVmbb25yNi4ryhvp
	ucLrb/T7JZu/ajPuzLxCpNgIyMcy75A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-iw8M4HUYP36dS6E63qb_vw-1; Mon, 30 Mar 2026 03:47:56 -0400
X-MC-Unique: iw8M4HUYP36dS6E63qb_vw-1
X-Mimecast-MFC-AGG-ID: iw8M4HUYP36dS6E63qb_vw_1774856875
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43cfcbf37a2so603680f8f.3
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 00:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774856875; x=1775461675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ee7WfC4ao1ITQjnVMBY/T1x8jIUaoFThw0bW/nGasZE=;
        b=JJd9BQ0irY5hmLXlCQCUfnbK7CaKGomBzrTipGgiOprZ5zmtHhXONcUFzhCu7fadV0
         TZUvjlA41ZwD3bQxrHIW/GI/KYTzQTlZPt9tATS+vacjKkEsvukDIdkwgl70u3+RSmry
         zIxtji2CKR229It7B0nwZvK1NIuB4g1ET4ylST/FykNHJ/zO6hT2XHSk+UAAQWLmMpmi
         9b49UuRP53VtSlIBeajgYiFC6oSSCizFJvqTs06GfLhe5fXnNKJJQx+4oLxbuJFeHfow
         zmuh7YcXGQ3jLeJnkOhPW/nRGQfpdZJh0XjdpaIZmFS3FK0gzgdImH/tyr2hG+1E6z7i
         FA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774856875; x=1775461675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ee7WfC4ao1ITQjnVMBY/T1x8jIUaoFThw0bW/nGasZE=;
        b=pvZJOvn0/77CcS9xI91pXIjpNsN7cb0nMAF6xwzENU5evxCRnUHrUIYsXufltmVM6w
         B0ddHmejx7gFqjwEBLcc8XLNrwiokDAL019j+6nLkYMLIwP3xyuxVpcpBP27u74ONHak
         +XneuH26r+6c3vBczKS2v9BpYZ4w1Yj8r8K970CrS7CEjEy8ZieN4Dt+rvvIbGW16ewT
         mjl1HYW1U0xgECW0U7lR8zjhESe0eBcg+zwa/BYgsfTBPjj9EccnsdRswRRjt/vl8/6n
         Lvh/Uag8y8FlCWzWJpUbTHKtzd/Z+9lTBvy8a0tGo5unxJ0jMOsp5h4rcV73yKMlOlWC
         gc4A==
X-Forwarded-Encrypted: i=1; AJvYcCXSl5sc9T3mhAxllHfK3AcbVxH2Uo6XC5Evo15pMsO49Zyym9/LQlTgy/s56AB8rYB6ctI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwT152MSx6XOIeKd1chNssfny7X3Af3UzRUZDgUhsDJXHjeJlF
	76MohIsUIL10m5mLdJxzgMQOU1z9C5cbQhs1bADzp6c5iZ4c1lQHgDn7GVnv5UAt3dSPewHOIq1
	cea8b2cjxYR37GLx7DOraE7dIwzPBuxqxzjDjJc40Zm/a9YufM/ntxA==
X-Gm-Gg: ATEYQzxyCIuMotF9sYeXiopzuNDfk5082w3YiQs8tCHF1O82XcIPgR6aagHf2ZDwHGE
	j3mnBXeg6teajKDiTaflZmbdUcpafSRD2oT9p2VPuwh08Z6qZxrBe5CN01Lzv456MOlZTxNWDfj
	IMgnHkdR9kKbmDjOWY/3sfVhuyZTAgU46De5RryYvUqD00Ye4uD+0sdGyxNK4dKDmSXy2nX1k9I
	QeLqnBtU4HfYz7FUndjSRL7l+paO+15LOpu/xfg3DnwcykTXMRNgQPHjwImpG7IezXUTc95ZQkz
	oswpq3pDU3oDw/HgkOz2GhUyah9zTGSc2PmTxvrskMkqVOJRNFFyohXtU69LwIHPoDpaqRRserB
	9NOZuU+7T3ZsZulFAiWDTT7Uvd0zLVuoXtJIByueAeegA48d+wEYMT+7Q9s+UDdgDIW0EGGneeH
	RdA02cXCm9CZ41jRwoU9vQHe/f
X-Received: by 2002:a5d:5d84:0:b0:43b:4d2e:a004 with SMTP id ffacd0b85a97d-43b9e981468mr20214697f8f.10.1774856874767;
        Mon, 30 Mar 2026 00:47:54 -0700 (PDT)
X-Received: by 2002:a5d:5d84:0:b0:43b:4d2e:a004 with SMTP id ffacd0b85a97d-43b9e981468mr20214656f8f.10.1774856874299;
        Mon, 30 Mar 2026 00:47:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245ebafsm15438543f8f.21.2026.03.30.00.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:47:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH for-6.19] KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
Date: Mon, 30 Mar 2026 09:47:51 +0200
Message-ID: <20260330074752.136232-1-pbonzini@redhat.com>
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
index 02c450686b4a..01e159941434 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3044,12 +3044,6 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 	bool prefetch = !fault || fault->prefetch;
 	bool write_fault = fault && fault->write;
 
-	if (unlikely(is_noslot_pfn(pfn))) {
-		vcpu->stat.pf_mmio_spte_created++;
-		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
-		return RET_PF_EMULATE;
-	}
-
 	if (is_shadow_present_pte(*sptep)) {
 		if (prefetch && is_last_spte(*sptep, level) &&
 		    pfn == spte_to_pfn(*sptep))
@@ -3073,6 +3067,14 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
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
 			   false, host_writable, &spte);
 
-- 
2.53.0

