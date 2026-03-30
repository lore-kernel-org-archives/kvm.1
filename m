Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A0924E4B4
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857318; cv=none; b=tE35Gxz7Qa85aGdUZPhR1rqvLIEI6o+fCTGfC/3bRHR3V47daPEwWUbi1mD5qw7fctRjcF9+rqZAwuGNUOfU23eNp961u1L53pz5U1cnAfhSp5+vS5cDCD4x4jrYbnS/JrS4uYJywZuZBgAP7Mqzv6/x8lr0d+DLeS3F7dFgmpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857318; c=relaxed/simple;
	bh=T+HmSjUn6z8OZZRxZT/JFBxpd0V4CB7xIFG8EfORfvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CV3YIbzXBxHb3gfP6NjtB52dId9tZ7IutUXQ6+9F+0T3L9Va4BTie3VbK8KEsqvCvBvTtgBia3oVdox2s3GuDDFDEhuwuQwSvkjr3I3vbuz1TvpgT5wXXTYsfpUWlXyNksxkT19YFwGznWNNNK7bMEgIGFZMvEiKy291o7v0u8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/47+u+B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s+YBoMjc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/47+u+B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s+YBoMjc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774857316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KOkZ7WrFrzNMDpXbyrtubTWNgppCw3HrcM7a5zUN2j8=;
	b=U/47+u+BbuaeXmYe0V3yXfjYhqCp9V7qMyUbDFC9z29MURrjI2uFpQhTVnOF4i+rOPGfkD
	LMz23KnJZul2Odi6jC8RC4Hiyuu7r9RGm/8k2+kc2WzIzvNnVzYga0HBinZfEJnZTozlE5
	sBD5Vr8LNHwgIQ7eXCk1DHWf4K4lwKM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-dDIyImO7M9KIh9NETppmVA-1; Mon, 30 Mar 2026 03:55:13 -0400
X-MC-Unique: dDIyImO7M9KIh9NETppmVA-1
X-Mimecast-MFC-AGG-ID: dDIyImO7M9KIh9NETppmVA_1774857312
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so37732315e9.3
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 00:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774857312; x=1775462112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KOkZ7WrFrzNMDpXbyrtubTWNgppCw3HrcM7a5zUN2j8=;
        b=s+YBoMjcxKzbtp9EDhyA7HM8FvLfS3ghUHEI9CFrx32j8BtBjT1QbRBYeU74wT5igC
         9V11p1oFkOv3X9Faf1ghm6kqq3dCfGGRavpHtetaTEppmPj+QscFICt792V2kq/F2L2l
         SgQpDXSfX4PwZxr1E4+MFsP84374EsFpWnXVo7sZ+Ftxdxj8vL9iago+ObzDeFefa5jo
         h0WfAlN1Ba3hoSyOYBnDq6IX/pHABa5ZyhmhcPMpqgynMvTncilOAgEC6Sda+P9j03FB
         TBz0JCSkPdibwdt3sut4xT1Icxmv7SuOAciU3veTzkNv9bFRBcVbNZp1zpA16po1CedQ
         kQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774857312; x=1775462112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOkZ7WrFrzNMDpXbyrtubTWNgppCw3HrcM7a5zUN2j8=;
        b=C5XAYF18tpK9Xf1NTMutsgj1MmDWamS0xYvp9pdKC0ujkeoCpe08LVBgZGWDlIc0fM
         n/CkSeRhBeev+r7bx7YyTwVOuXb8KQOn+VS4pWbDvCptZ+d2DxcnwX0S+6SQhPjErZLR
         pTQKIXGx/whW/bX/VV9jJOrAeoo7HeS9NXdKFAezba2bjJeYGP/TWDpS4eea3r6s+tSm
         iU1XMLOlpZJTf8lmWdIy/TNnHd67nvGpCkdOxFXQ9uJW6pZ7MpqVGsnezIQ5zLjd0Jnz
         Uqs22nGf7Jzb2dhEUvI6xlhQ+l3ye02/WkLL4ctie6eqP8J9Uj0LeYA8LIgBwsLuX4Uc
         xcrA==
X-Forwarded-Encrypted: i=1; AJvYcCVNBwhERFkSDHuYKhQCIrtjnnfWHGu88nczOXjiB05bRHR5dvdJX2ZCdTVbBuEsc/5RwkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRrbrnq0ALYCou0XdCSxKdIyLFJ4D3B6rEf87R+pZlrvFsQEmh
	R2dZOXCkEqqDHJUxGXuo+Nfg7mP9+CMyVXnOQL5IKhm9C5QjBVl2M1QPN7Yjc4Z0u0RLTqocZHS
	C3GVKe8SwOfs5dK7tfYf7QKyemKc+Eoid2Yha7aFAqd326objKGT6Cg==
X-Gm-Gg: ATEYQzxNYlJ95XdkVb8XeY2jWnv7pH5iEM7JNdWoBxjZUF8sVlUWvSBQb0t1gRKswFu
	kAs1HqWsjPtuo1d7gFikPLMwS0B9agMdQWIRk6lJ1+kRbv2dyq8lL7GlmgReTEozA/FuXqsoam0
	9LbwnLLngjUeaoAULpQUiykA3315ZYS0vq1EQWbtJySpH224MKLcILbV2zK2OeDFXJwwD7Tw4SB
	H6HU/h8bghzihqbIS0jWhC7vmdALdrwrBwOxLPECpLMO8+5Cxzz4+yjh0e7y9+gbAK4XQAN3ofF
	GWFg30quU0whiI16sgwtSZj4/rXa7iyWuTm2QdPUibPRXKgyT7XEWgng8iFrdIGa2yJxAECc+DL
	XgJ9j6XYgqCbuSm+A8Xbpj6oo6mhybfCFX1cKodOJacbL7ZW7XBruZLsm6ApdTOYk8bja2kKJrF
	klfcJ46T65XTTMowwg1rLyzQ6t
X-Received: by 2002:a05:600c:3d87:b0:487:2092:b2e0 with SMTP id 5b1f17b1804b1-48727d5a246mr189674105e9.1.1774857312346;
        Mon, 30 Mar 2026 00:55:12 -0700 (PDT)
X-Received: by 2002:a05:600c:3d87:b0:487:2092:b2e0 with SMTP id 5b1f17b1804b1-48727d5a246mr189673785e9.1.1774857311868;
        Mon, 30 Mar 2026 00:55:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48727bfc5ecsm173559295e9.1.2026.03.30.00.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:55:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH for-6.6] KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
Date: Mon, 30 Mar 2026 09:55:10 +0200
Message-ID: <20260330075510.147430-1-pbonzini@redhat.com>
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
index 04b9b919235e..0dc804149b0f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2914,12 +2914,6 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
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
@@ -2939,6 +2933,14 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
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

