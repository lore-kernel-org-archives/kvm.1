Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B98D2367D9
	for <kvm@vger.kernel.org>; Sun, 29 Mar 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801386; cv=none; b=bm6YJazei6qXePg5OT7n/PonedsgkuSg/0OgbpOpre55D9KPCU/Qm5uRrsotekfjI/n8N2zj7qju7UKzh8cjXtMpurz6YSVVElcVD14knPJt/3kRmEF54B6caI8laVtvPKzt8gbqybKv3BN2286wF123qj5Y/T5FNYqdZeT6dy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801386; c=relaxed/simple;
	bh=4ATS/w5ilyTZCGdNEt11O3ZPqSdhk07QwetqwZRQn/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=upugibShxW3vC3B/47YYwu3C1SH8vLzkgtW8oNJSBT8CCRGtYi6QMcn7F7h8XBz/uY5TP4azDpd1QOXlnUPv+1WbC8HZgR49+YfLa4NP6OafpuvO/jqW6D+hdrFJQ45ek3OfD8zPKn7e+g9RE9G/wUWOo4G0qNAK3Y50nP4hcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FUzJKqjl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfzDQYUi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUzJKqjl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfzDQYUi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774801383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7CkbaMckWtOu+BAt2/YNvYUDOoVNDTgPUoFz2iLggDQ=;
	b=FUzJKqjlDokIkxrkySNMTeKYmPngac8blWMtG2zFX4he/pQ+Kzfi6CB/6QFV/TQZFsfuHa
	AnLM8aWVLMA2OkYeNtoecxexPStwerS6h2NmUocVfuY983niao0ju3N70xqioThiRhTSzz
	QMC4/U+KdV4frreJpncJW+2VDFDgDDg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-3xugR3CINvS9UZP506-Szg-1; Sun, 29 Mar 2026 12:23:01 -0400
X-MC-Unique: 3xugR3CINvS9UZP506-Szg-1
X-Mimecast-MFC-AGG-ID: 3xugR3CINvS9UZP506-Szg_1774801381
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-486f89b7f69so30786595e9.0
        for <kvm@vger.kernel.org>; Sun, 29 Mar 2026 09:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774801381; x=1775406181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7CkbaMckWtOu+BAt2/YNvYUDOoVNDTgPUoFz2iLggDQ=;
        b=NfzDQYUi+50qt2whROP24nNZ7e/ath/9LckgM+BGTMPKuXoMLtHyJ5m0elQzWZq2oi
         RZFpULq7rGBjYR3eVBGT2Re+/7RQbftym7M+trLtBr9Kaga2ib+Awq37LXQPgtvjMeTT
         qeFjTBqBGNSf7o2/lc6XJGY7NDTk303OzWSlqeCSPDir7qG+O8jM4iRSIKoXyKhqZrHx
         LeyPT9LbNJenFeEwoaum3wloMoBIkSb0t6Mh3elGm1jQjcZFRGHgi0jEs4i4/iqwiGJB
         KcHdF49a2+A5Hg0WqaaDBlPKWsKWV/2JtuqtfWzBYhHS8jPKez4tRy6Z84QfdXZYgjj+
         3zNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774801381; x=1775406181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CkbaMckWtOu+BAt2/YNvYUDOoVNDTgPUoFz2iLggDQ=;
        b=PbEz6nQ/fBMc2RG4bCV+iCqj7LN0xemPqCeEUjmRjcdf6HHXxpZQhJTa7jkR1COgRo
         ZXpuGU8caio3XU5ZOHvmrxrocrFUSTrIjiaQjxsGjkWDXBPGiErT95v/8xJlKJqL/7dA
         zWdZmdSuBIPpAEc2dcxrF6oO8PKBRJ5aIyk1qbGCsQQmRMoTX+2yQZ/h1BwBspKmMxLj
         j9TruviE4rrdfttJQC8eaSnDZSg30LmdxdlK4hBA7YVVAY4tifvKCkJFnfQebKHJ5FM9
         mcCexWfvYivY/cRVuwz6fYvTNAEAUoCCit422vuZz3LyCOZPTlOp4ZOhE7cL4Xxa8QLr
         91tg==
X-Forwarded-Encrypted: i=1; AJvYcCWIMwkrY+U5AdNI10XcBK7Yfu2rHk5rjon1DgnL/dlYnCTw/Bzys/SFzgQfnhOOJB1RciA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQyR7mQmHL/4fc93vcFvxvAtCTvnTtKsMmHhjgVv2jr8R/QWAR
	tkdrVvWrVJEYmHHzkvscnlRs/KV5dY8L2q1UBalhd7OcJe+Pfe3sBPN4vsA4sdOJ6+UuWujcZ5F
	6GpT8nILEX9AEPu7NHAN9pbCimWPZkBeQp7nXP5dI7wvn/KyiZGPTkg==
X-Gm-Gg: ATEYQzzqJlGIC/tiBb4QNRylW4BFe7d+Phh4Pa2HInQ7t9KCljDJ0/gWzFj/rSA/SLl
	VpfE784JPGf+CRlmMpiUipwqJR7zAejfLBpOLKHktXP97alxFso7zlNK/g/5WWRtghZSUqqAn31
	a1kl5GwxzfWdQLLYySrzXp2uEAf3wnxQYBqELLlhD4fgCTtCNMRi6TRIa7CRG8BWKjFMlndwgsw
	kLGZ/j+xi4p96SWtkojaXUC4ADOrJYfs2lCb24WMOlfFUUqzkwO4Spz4tK6Y/XX0tw1jM59lyTE
	Jcyg2Csxq2R/qs++MynAi8OYsVVcFbFau+ZzxKNmvCODxij0AIHJpmhx1V71Ue1e6dtzxvqg6RF
	3EJBQDSioG6+pqGi2i0YS/bhuK3BOoGJKMoVt54A0h8ssbg939Tgp87ogRM63BvtGH3Ztf3duxu
	LfHUyUpn5VX3Y3wKImteW7++5jG3FMLkL7JXQ35cu+Tfx5Qg3QI/m+HcNB
X-Received: by 2002:a05:600c:64c8:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-48727eb7f4dmr158844435e9.19.1774801380563;
        Sun, 29 Mar 2026 09:23:00 -0700 (PDT)
X-Received: by 2002:a05:600c:64c8:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-48727eb7f4dmr158844125e9.19.1774801380099;
        Sun, 29 Mar 2026 09:23:00 -0700 (PDT)
Received: from [10.242.181.123] (93-44-53-42.ip95.fastwebnet.it. [93.44.53.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48730628efasm198566045e9.5.2026.03.29.09.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:22:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
Date: Sun, 29 Mar 2026 18:22:56 +0200
Message-ID: <20260329162258.106549-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

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
---
 arch/x86/kvm/mmu/mmu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b922a8b00057..98406d6aa2d6 100644
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

