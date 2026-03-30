Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4F3A8733
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857520; cv=none; b=AscHmHaKF+OcmzExN34ElkazfI3Lk1e2t9yP9LzEa7KFl2HobgqkREICot1TOM2/CzhsooRbsqP6TuTmMaiAhrPqJfrDs2gbD0cSlmVso6Yex1JrmMQMXaRUsMdkEVSA3n1QRbeWva0X6t8Q1qv39qlMa6giD9UQHt5ByP8q2CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857520; c=relaxed/simple;
	bh=zEZGwGF3sKc0G9zq1ffG0PV9TQ4YaNhIAp7e0h+68pU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ejif+T045ZmcS1xgbUWlGE4c0sR9CFKFAv1F5Vs8bcm8coZg4SW1ea6w+M1U45D0ItuHX54jthwNAgXCYUtgQd9w6Rfv2hSfiUDHoPp+/mcaOqz0AN1siuQwmjO7XBQFiCYAWleFOMipxIaX457lLS13ifpydV0igyJC3wy61Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUXXfz5M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=snK2Ns/c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUXXfz5M";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="snK2Ns/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774857518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I9UHxN7TKiM+B8XGIaW8UV2fs43HChjHFnISdi8ej/0=;
	b=KUXXfz5MjhsQTQwbOTY35MEN17/zCDxj0tpasDhApEKJBXK1FPjSV6jw9uiaKDooHwaKpA
	5fFY9rpV7vIarDkueWw4lNph1yd0UjlIC1zDac+O4RtXB8G5e/zMpTensMyNt8Nm754WeE
	Khd4iyQtm9hMi7nMUOvD2dd+30aV4dk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-ZUIB1Eg1O-mRoqG0tFu68w-1; Mon, 30 Mar 2026 03:58:36 -0400
X-MC-Unique: ZUIB1Eg1O-mRoqG0tFu68w-1
X-Mimecast-MFC-AGG-ID: ZUIB1Eg1O-mRoqG0tFu68w_1774857515
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b93781cb8so3930834f8f.3
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 00:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774857514; x=1775462314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I9UHxN7TKiM+B8XGIaW8UV2fs43HChjHFnISdi8ej/0=;
        b=snK2Ns/cMIQbzd3fAvTfGWy2J1uhkaxgwxvE+sZxNsCSwKrWvaKoos3+SSnueadsGE
         n8xh9SUUw7cSNOVbP1Pc7hFzGI0u/4NukHXkE/IutV+nn27UOI7rhgJP97Hxc2MsAg5N
         jovKvIfxX207ao8z7IllRfAq46ddajgwBAHJqd5If9Tx1czy9cQoikx37s40Dht+oQr5
         mxbcXfJy/9V4a/YgWHjCZJi3fjnAI0m9n0lMGGpTXfh9SMEkA6gjlqnEdIOmerqT/elN
         4FUttZ5wMvYxkjh5B08CU5s74FvbLuXjWPmNHH57O5aekRCocI8QkTNlThf0o/50FgiP
         kUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774857514; x=1775462314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9UHxN7TKiM+B8XGIaW8UV2fs43HChjHFnISdi8ej/0=;
        b=LCKjK9ADlx8wgYvTO6Q3WiAAf2cG/yb5QnG5LWjvtCrsYgkJrc0y3WiYYJJ5nsEygi
         e24eF8WrmvN1w30/tQ8a3jZBDJyxr4FwCOV57vVqtLzbHaOuDcSg5zpIOWwhe1gA4lBx
         KxUxW3fQ6+DGGnf7HfqspC9XJweRec6t6I8+3sp4F0qcdUVrKaOwcA3B3RUk5+2QWqBB
         dR4uNaZwbCB1VGIYWTxxpUYUcN7QeTF1CF0YKsWb2fyalv7HuZ5m6dWL/Z8VnbLxLr2t
         wY4XQVcIeeQKRosYRT59QG2g0898GO1BSJ8WAllb9mFscJ8lTvrOmtpZZaPetYcjs+nX
         adng==
X-Forwarded-Encrypted: i=1; AJvYcCV57VFqE004H9yPGXCKnXvf4ukUMu1lEntqItILjKoBUWCW9WCt1OSZz+vXWfhM1d4Vfac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaoBfNI0Te7dcV9rAQd91QOo2b0tbiLFg9vEJXxO8VmMB28zfy
	D0lFg3JWEOCVAuwhkWwovk5mQzDGi95jVB1mrphNyv5eEXrQ1i4H4PlVpBqkWssiqGREF0sqJF4
	Ja4ahdYyU0IIde91pMBBZ8n8QQcRYcqL1qZuiCkhRN73J9c7zyGoP1KeEd45CMA==
X-Gm-Gg: ATEYQzyaSrRrlEo7A7VOl8NpFgPyx9JKA7undBV0we+P3kTD5/MUALOuuWNBrG1+iCQ
	Td7m70/2TUEQ0x7eTkckejQlNyDIN+1q3jVDX1whvDO2uk+TsowfPwuYszE1orVVCgECidfiFju
	w3enNR9oeA7Ml2hc5hvT4IJZFbKhVLlaxDxf+lKJK6cHvkPeMWqkZuLWbNv/+3jVXazBFB2XmHy
	4vu4HF1xlK9XxAaeRSThFqJc9ySrsTzzcuJM9iy1kNdruWdcm3zeu4E0QmK/TwaDscnH5OFpf5i
	1Zzzau3TJjPIZ8bzeMDM5LJpXtPbuYOVTPgFBuq3IyAhJTSBJfKOFiZj30JkzijnaHm5G4HzmI2
	w9x5AkHIMoH9Om/Q+3R5Oh9l2gITcF6jeVxQUVACI97fU0X+02BpV/m4XGyyZmvOcNsMGloSNey
	HleM2KuzWBXgz005IdBypMYi0j
X-Received: by 2002:a05:6000:2307:b0:43b:3d02:7806 with SMTP id ffacd0b85a97d-43b9ea4a457mr18934814f8f.28.1774857514331;
        Mon, 30 Mar 2026 00:58:34 -0700 (PDT)
X-Received: by 2002:a05:6000:2307:b0:43b:3d02:7806 with SMTP id ffacd0b85a97d-43b9ea4a457mr18934767f8f.28.1774857513811;
        Mon, 30 Mar 2026 00:58:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf24739easm17845984f8f.30.2026.03.30.00.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:58:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH for-6.1] KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
Date: Mon, 30 Mar 2026 09:58:31 +0200
Message-ID: <20260330075831.153407-1-pbonzini@redhat.com>
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
 arch/x86/kvm/mmu/mmu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 04d060f37053..a9f24eeb4477 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2814,12 +2814,6 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 	pgprintk("%s: spte %llx write_fault %d gfn %llx\n", __func__,
 		 *sptep, write_fault, gfn);
 
-	if (unlikely(is_noslot_pfn(pfn))) {
-		vcpu->stat.pf_mmio_spte_created++;
-		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
-		return RET_PF_EMULATE;
-	}
-
 	if (is_shadow_present_pte(*sptep)) {
 		/*
 		 * If we overwrite a PTE page pointer with a 2MB PMD, unlink
@@ -2841,6 +2835,15 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 			was_rmapped = 1;
 	}
 
+	if (unlikely(is_noslot_pfn(pfn))) {
+		vcpu->stat.pf_mmio_spte_created++;
+		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
+		if (flush)
+			kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn,
+						   	   KVM_PAGES_PER_HPAGE(level));
+		return RET_PF_EMULATE;
+	}
+
 	wrprot = make_spte(vcpu, sp, slot, pte_access, gfn, pfn, *sptep, prefetch,
 			   true, host_writable, &spte);
 
-- 
2.53.0

