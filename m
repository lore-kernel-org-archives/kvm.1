Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD25259CA9
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857712; cv=none; b=HFbgjHO+TpPygPjcecNHPaVAW83BfUL4k9JYRRC4S539iHoIa4mM/uRcPHoSr0pTvKqZlv7aHo1xE0BGvm1Gs6kRxQz3xBA/dtS4KZyPjWk3dPUeOnI4Pm5Dn41SAJHK4d/u1YxiRmac+MkvtexR433vZjIBpj79/SXBRjQ1RTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857712; c=relaxed/simple;
	bh=woHof7wfkrzWjNOrAi7nzaTttmXDmDaMclAa0u+1qkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbqF7PTTsbxodHj1WeuzFWmVoQ17O/NpXRfAAUT6ACqpkqFCSsAl8Zf6xYdDuHt7k2YsIZzX+TwwxPb3AAvMfcKT+I7zgr23VC+MCjT18iULAEpUAfzzNMJ1254/KulkWbdWErmaT1AVhgQ+BArnbBrYiZWZsznRCzJSGt5rL9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2FbehJZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKL8TGw9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2FbehJZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKL8TGw9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774857710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZMEDTog/V2EbiuJTJRgUNGd1J4MxLV+lIo/zs81mrgs=;
	b=G2FbehJZjs2EqJNJ191uU4m1jZPX8E/JJGn6uutdga4yWMw0kZvjzxd5ZKXFOCjY7TaBGg
	4cA+Xdc/wjVHuYBzEwvjQNcjrtbQQZ6FGgPdZpaWrjnFCkDIcUB6LDa9WuOIk62WFi+PQl
	PcqyovUShOpy+22mQ909MX+ooyaIqks=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-4BGf15gRNSKNEdquPKXrRA-1; Mon, 30 Mar 2026 04:01:48 -0400
X-MC-Unique: 4BGf15gRNSKNEdquPKXrRA-1
X-Mimecast-MFC-AGG-ID: 4BGf15gRNSKNEdquPKXrRA_1774857707
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b96365ea8so3940446f8f.2
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774857707; x=1775462507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMEDTog/V2EbiuJTJRgUNGd1J4MxLV+lIo/zs81mrgs=;
        b=cKL8TGw9JS13WZEJGUXPN2Sxu4TfZMBm+1JOZIjSMPvRd/2uYVirj3QeDh79TkD4tz
         sKfyH2b8lt6/4bBV54aTmXeNp0XIPEhx/fKl9yFK3+cTRiD63FV2Lxg1y02cmfVeNnxC
         IGqJ1g0jEXVrBYgm20sf5VDOp0TPih6u3LFOl/EX6rZoCipKLQ3h4oaIcXgCpBl8ktob
         kz4sPq2AoSfcYdaEjVeIU9mHqe1sEC55hq/qytxZ5yj1Zj3JDg19MZiFbgL0uI7+p7S+
         HGMwgvhFixbZDlqxZOGmq4ZPWh20BkxaNMojGlDFTVL2S7IsCLbbCF8wRyZfSg8SqSMv
         P0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774857707; x=1775462507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMEDTog/V2EbiuJTJRgUNGd1J4MxLV+lIo/zs81mrgs=;
        b=R2bHf3Hv2lk+HAYiXc92g47N+vtoMgYQ4nXUxRE857cl1XwwuppKqsa1t4rnEGhVvj
         wgCzHi/KKFifqWudq26R3MXJR9/QS6LPfT2ws+OGbnj3tyGYWEvnaiqo5gAj+jeTjDhi
         4kbKBYTDuk2PT16MhDUwbBGUy6dnTv2A5bncXAM+9AK0e4cAoqVIBl7HX4gz6NoVvZMp
         zUE6hSO+6Ck4BB6afarRPjSmtHtFP8RvyyxoAwjQFCYE8RqYIiblo4LE8cG8O6+Vf5WK
         BxfXhHKrGKjveF1UqOc7GUhNzsmlWjtT71W3BjkX5KxYWd7iEwxzS2tOmmYuCpzZFfwP
         nFRA==
X-Forwarded-Encrypted: i=1; AJvYcCUOzYteN3MlLHMc1MsmbSf9sHGxtDPcoDwiioMhgx5PyJguMEI0rAElg7m4jTPzr3x/dFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPjaoIabeqUNIU8108Tm1K3mQm1rw3jIlldtG+KWZfIPaTppd2
	fmFoO5tWnkl3MxSh8lK6bxPW4Xy8Ihg21HtTpiSkPxPZzoteVOsqx4KnVfeVFJnc84TRi6n2JNe
	QvQJcYvB0CqNkiZ2JB1JzG/MiWPPx+txF1oJ0OQjRNdA0PVS50QMBCA==
X-Gm-Gg: ATEYQzz/cValTrY3lRVQXvNIPcYojj+k6JkIG263uttxFXd2Mh+gQ0dItwjOBA2Bom7
	0Z3rYVKgKPuPOBtp99MCrgmzcHKXJSseo8s/kuIGZhglalD22TWPOtc17PlzdKrvZd37AOdftWI
	UreIfsiNDyqnjFHjvZTU+eDrQhzt7kcESrY0xicycUOiHlnsY1FiYo07sDN2Fph7sIkVMKMI4Qj
	Jpa4f8JWd00wMYRPW6/+WLcqXDvdJFyO2Noaiy6Dui94yNKIIyZ40L3iwkmbJfvVRmEXdUftWqF
	NaD3QvT4E+LkjCLnJ7twcERKuFS9aRP9MjDsZ1lIZcALLr1pTcuEt2gn6w4TmrU6uUhixT6mgu9
	g5JWmKO4TSCOMlqUbU+MALSfcLvDoJ/vyupGsX+gBvcSwBfgmmb/osj6EyR0oj/uti3xblMHIsG
	37gMqgzYJceFCGE0GEvs1+njmB
X-Received: by 2002:a05:600c:529b:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-48727d84100mr178013615e9.15.1774857706998;
        Mon, 30 Mar 2026 01:01:46 -0700 (PDT)
X-Received: by 2002:a05:600c:529b:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-48727d84100mr178013245e9.15.1774857706436;
        Mon, 30 Mar 2026 01:01:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873069d469sm150150745e9.14.2026.03.30.01.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:01:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH for-5.15] KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
Date: Mon, 30 Mar 2026 10:01:44 +0200
Message-ID: <20260330080144.158592-1-pbonzini@redhat.com>
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
 arch/x86/kvm/mmu/mmu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index acb9193fc06a..3a705aebb52b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2717,11 +2717,6 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 	pgprintk("%s: spte %llx write_fault %d gfn %llx\n", __func__,
 		 *sptep, write_fault, gfn);
 
-	if (unlikely(is_noslot_pfn(pfn))) {
-		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
-		return RET_PF_EMULATE;
-	}
-
 	if (is_shadow_present_pte(*sptep)) {
 		/*
 		 * If we overwrite a PTE page pointer with a 2MB PMD, unlink
@@ -2743,6 +2738,14 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 			was_rmapped = 1;
 	}
 
+	if (unlikely(is_noslot_pfn(pfn))) {
+		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
+		if (flush)
+			kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn,
+						   	   KVM_PAGES_PER_HPAGE(level));
+		return RET_PF_EMULATE;
+	}
+
 	set_spte_ret = set_spte(vcpu, sptep, pte_access, level, gfn, pfn,
 				speculative, true, host_writable);
 	if (set_spte_ret & SET_SPTE_WRITE_PROTECTED_PT) {
-- 
2.53.0

