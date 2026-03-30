Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219DF3A7597
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856957; cv=none; b=UjHVx+OITB5+wzWGdD/z7IJwbjiZriW/KXTXg4PB5hUHXVeo8ZvswQHZzhDLMYg7wyvDPzhKtRNK6LwyGS4WiwOTZvmrD/Uwf+3BT5I39U1dCaIh5oBd21b4+C07qM20ZCsNFjfC6uUBfjT3JSWMMbUiI0aQQZ7mBdebAlFpGbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856957; c=relaxed/simple;
	bh=trMSWKJiFjetMp3AqPFcz4zqskMkgPRMGKygU1o7Dn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dh1bvQrIcnbfcOCGsRz+c/NHVoOM7CNTcg/rMdIsDCiA72ziaVg3FkDKNntjS0am7AVTMQwgnLlQi5CxaJ2bDtZG6q+vTIiaE2vGe1SS6ZyGS+n+IeSbthwQuZmAd2EfDwwGTbuRaEmbIAmcrY0TmmhcYakbqUgZNGpdE/Wvu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YkisgKuU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6DhZv7H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkisgKuU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6DhZv7H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774856955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HdWbI73l5k5XBqdSB8dPfIfDNyc/SaWv7SXcZeEOjhQ=;
	b=YkisgKuUl4CSe9bWg6ToU/Gng5KK9d6HN8SragzkxCYSmjeVLeKg2/4kwlHXt0Ld4pIGRe
	5U8Zh17PzX6kR+U6ADaZ0xBbbAdJEA6+QSKAIy4lJOLewjtk/H717+520jcOqAGkyiawK/
	WMogE/iazy6xn5oHCVAH9Os56wBal58=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-cftqBKCiPN6zx49UrMQETw-1; Mon, 30 Mar 2026 03:49:13 -0400
X-MC-Unique: cftqBKCiPN6zx49UrMQETw-1
X-Mimecast-MFC-AGG-ID: cftqBKCiPN6zx49UrMQETw_1774856952
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-486fa35b005so51786865e9.2
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 00:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774856952; x=1775461752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdWbI73l5k5XBqdSB8dPfIfDNyc/SaWv7SXcZeEOjhQ=;
        b=V6DhZv7Hr/hMxKzSI90Wpz7uKKRUc+r2/XAXgKt10HuV9D02/bsfLxruD8G6P7IGT8
         hEnGH3UwRO+5b/SIWJ0nleJwwtF/Yu6tQlG0c+LnQ1euu591CfhGBadqfoCqVOhJj016
         /R/zr4Ls+boSrzTkZ9PyXGi8eY0o+NTOTnbMD27/qSbPg9dwn49MbxorMFmEyljsQrZ2
         kxzHrRS0Dq4TEPdufroYggq/rPKb6zQQo2ZUoKKVo7SxvOV8d8X9vbdAcNGuyc+r/+ka
         Xz05PS58V+uFB9Bssw72ViRraBFdfwVhOxVSCBe+rydXJ9WfvN6nNRPCjs76JfDKx6VU
         OTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774856952; x=1775461752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdWbI73l5k5XBqdSB8dPfIfDNyc/SaWv7SXcZeEOjhQ=;
        b=Ki3/pjKFvvW9blsS3ZrR4nkgwTYckMVfLwVmNkW1uZuNaF+Qq+rkRryix1iPKNlViI
         /jXJ8vRxm4RE+zv1c8sDxYIeXLhtie87+JDk7ppAhmuHp1rg0JjCRZohmZ7EEM45w/cY
         BbkZYB0dLJmCLlsqEnXpZLKghFX5uWNtcCfxX5l66u/MEOOj3qvx+H1iQT+SH1E4DInL
         dfwHpz6lGb4WtYA7dWrMOufnuqIs0wM1zd0ktLUa9Z8mc5xYIpxxMFWVXDgZJsXOK+sD
         Lig/qB1JOpMwNn/gkx/htaF3KF2Zq//Ef2hT2kVF08kk+Wk4uPjRlJ+hSIQLM0V8Gowz
         tTWg==
X-Forwarded-Encrypted: i=1; AJvYcCU/JnZFns0vJeUty1zegESzq4xAdCqt37aefMY5aGnYkFTMspJSEMXBoEj6FifpXqWMp30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWmaQTJ2wc2u6aRoFU60H7K3MNBJbXzu8QYV8iOYBIxn5qli0
	3NypH06QlWe4tba2pOVSgAKGxLeF0N45t69sEIjbyX50yCGS1mYe0DUCURazMmMPHBoh1eIL0SD
	4tG+qKCffW0wgXKN+Wk+Q30B8v5bbTlsEjoFTGyc8H1lx6yzum9Hm9A==
X-Gm-Gg: ATEYQzwmq92vJdyYWFM24m4t8yTrRd0bNUnZ03majFF+Q08QRILBBKBuQBJYY7Bu6ck
	WHBaZ/C3oAXthuVhygNjnCGxAZmNH5Wf0YL7SkGIYpFhfxDP9MeLphCTqdVzlykQXgRCRdAPLnn
	uEyFSwMgyjx2cxiIa9Tr/sh69+1mt00ilQvdYbAvCHOwccbuWltBxhdlhHx8SNEhFwKzZSVfSfJ
	c6sajggTvt8RZgtMDgBPwNEXufGW1zHPCqzxYT1Gxp7bqvxKsUppc8DhUjYYB6YAI9j85biwW8b
	yqSCRubuDYs72NEeE4XtjIbJBZJV4q64OU+lnFhOCUW6IpYa6BfAeZhy9TUKr+vozjaxkUEr1U5
	xGqOx5Hlyi2MTDj1yY/DJOWh+zwo3KCrIZQ6rDMe53jS1EOcWB+njA+aN2JzjQ/8J3fmVGA4VA1
	+hblUmrgY9MDYl8e7GMidSUvY0
X-Received: by 2002:a05:600c:a00a:b0:486:fcc7:d6a with SMTP id 5b1f17b1804b1-48727ea275emr178546305e9.13.1774856952118;
        Mon, 30 Mar 2026 00:49:12 -0700 (PDT)
X-Received: by 2002:a05:600c:a00a:b0:486:fcc7:d6a with SMTP id 5b1f17b1804b1-48727ea275emr178545905e9.13.1774856951674;
        Mon, 30 Mar 2026 00:49:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48727bfc5ecsm173139175e9.1.2026.03.30.00.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:49:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH for-6.18] KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
Date: Mon, 30 Mar 2026 09:49:08 +0200
Message-ID: <20260330074909.140480-1-pbonzini@redhat.com>
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
index 667d66cf76d5..a8fe777ba274 100644
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

