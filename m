Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C434AD4D6
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886183; cv=none; b=jTaTYTv220d2c2a+ZzbconY++k+6RnyFkwCAV3VffghrqRpMrEkXbgMFi816bIrHE3xi/i0Jm6pve69QTyJcynzssDrM2CRHccT0/B1sGOKySm4ghoFzZZua8nmpklPu8d6cyaKzwTGoVKuTNXwk+aiXARnGb91LkPNtJMPAyYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886183; c=relaxed/simple;
	bh=Td1moGbe7IfnD+EkJSryXM5j8XMKKATD8IvqdqYqwd4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qf3SJaxAVFDLOkJEkWXC9Ttu1U/rsu/avbKT5PsLqKMqmIWwY+0MGc3AUEj5lXn6rTyIzBjWrTL5BuweXuQ+lCsfmyAaan32zArow0Ex2UgTgnVOcEioFIAQGaTuzvQqXcGnwatvy98CYdCedKOnLYHmnGRkd1vrNUYAvUrQbEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=awaDuUuC; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="awaDuUuC"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so7269700a91.0
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 13:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886173; x=1791490973; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O1dYN1wI4HG9y2GFEUVnSNvGtGU2lNVK3HnhJ9Mxy30=;
        b=awaDuUuC0jdWOwUuGLjfl+YepZ/7P9QzGUfqS/hSRmkc4DFbmn70SPpqfTjsKVrVUu
         m9mepZU8FlcJLl7TOfqKeNeOkup55NMfxW3m/1+38uunNSld9XF8/5mpwO+22xPK1wrB
         Qot7mKsMvniluqD25cnz/n6Cn3Hn7BxQpp5gnlP0L9JdaaThrInu7DAA79sWTuu20cf6
         WaiJxkWkK8xDPzZJi4OAO87xBBa8wUpA8CLEBHZ/yMDB0o0IeoSnRoLNVAKjtEl0dpIv
         Yt51HekFf8TuE4KBV0uAOGYz67hUdDxjWNs2yPueHrrRCbScdk9zJE09srDr7FvvM+Xw
         5Odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886173; x=1791490973;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O1dYN1wI4HG9y2GFEUVnSNvGtGU2lNVK3HnhJ9Mxy30=;
        b=jg+ubjEXKI2Nh9E9FyuojvxEBG2O4y0vDqUdDsgEwg1EBoeelVsI0BiyvfZOg+HDLN
         FFHJYNQ0/o8MrjDPu70mCMLWxk65E15dqe/gH1Y09+P0mIkZN/1/ynO64dBdpVZd2jbs
         +JSDhsEjXK4m+QYt6rR8g0xdli7HmMAlh7IV+XBnTPorlyA4orzUT3oDEdJZYEVGEQLO
         IrDFNclDLkrENjQrb17RvpvJeOQ8hx2tNCCfWLQugzj4P8mxRHh+Txu6fgAbqGCNCSK0
         o7qzIDSg/KrnadWIYy5duxIJHOYwcdWwNpVTybpvUmO0YNPxI0KmiKH+m0fXjbh/9i2G
         9l/g==
X-Forwarded-Encrypted: i=1; AKwUvBzAiyNYS+rDjA0YM6dL/qOW+mQGbO0LvGD6u4Du9gDcmbksVqAfu+PHyeUoBG6MhLIocxQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxYBxnciXxmMUv7SP7MeWJgB/xA4Y0rKsPkzDPsU6/w7M92qwj
	kZg6PVf2V8YqICZ3A2Dbx6YVRa2wMMrhTQ3C+Q451iYSVUfsWLmwycZNSSQjyXcz77akdDijdcq
	j5J7L4w==
X-Received: from pjbic4.prod.google.com ([2002:a17:90b:4144:b0:3a4:c30b:2845])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a92:b0:3a4:9d98:f973
 with SMTP id 98e67ed59e1d1-3a6ceab2518mr406933a91.11.1790886172949; Thu, 01
 Oct 2026 13:22:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:33 -0700
In-Reply-To: <20261001202234.3794060-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001202234.3794060-10-seanjc@google.com>
Subject: [PATCH v2 09/10] KVM: nVMX: Don't try to load eVMCS12 page when the
 VM is dying
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Don't try to get/load the eVMCS12 page when KVM can't do uaccesses to guest
memory, i.e. when the VM dying, as reading/writing guest memory via the
associated userspace address space is obviously broken if the address space
is inactive and/or has already been torn down.

Hack-a-fix the eVMCS code even though KVM now protects against bad uaccess
reads/writes in the core APIs, as doing so will allow adding WARNs in said
APIs to help detect other buggy code.  Add a TODO to call out that checking
if KVM can do a uaccess for the VM is a hack; nVMX really needs to stop
abusing __nested_vmx_vmexit() when destroying a vCPU.

E.g. without the "fix", adding the sanity checks will trigger:

  ------------[ cut here ]------------
  WARNING: ./include/linux/kvm_host.h:1359 at kvm_read_guest_offset_cached+0x1b0/0x200 [kvm], CPU#14: hyperv_evmcs/27428
  Call Trace:
   <TASK>
   nested_get_evmptr+0x4f/0x80 [kvm_intel]
   nested_vmx_handle_enlightened_vmptrld+0x2a/0x130 [kvm_intel]
   __nested_vmx_vmexit+0xbe/0x8e0 [kvm_intel]
   nested_vmx_free_vcpu+0x36/0x50 [kvm_intel]
   vmx_vcpu_free+0x73/0x120 [kvm_intel]
   kvm_arch_vcpu_destroy+0x81/0x1a0 [kvm]
   kvm_destroy_vcpus+0x9d/0x160 [kvm]
   kvm_arch_destroy_vm+0x25/0x90 [kvm]
   kvm_put_kvm+0x342/0x460 [kvm]
   kvm_vm_stats_release+0x12/0x20 [kvm]
   __fput+0xfe/0x280
   __se_sys_close+0x76/0xe0
   do_syscall_64+0xfe/0x440
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x4a3822
   </TASK>
  ---[ end trace 0000000000000000 ]---

Fixes: f5c7e8425f18 ("KVM: nVMX: Always make an attempt to map eVMCS after migration")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8e31eba4d9fa..07ec0dd014b5 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5091,8 +5091,13 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		 * Enlightened VMCS after migration and we still need to
 		 * do that when something is forcing L2->L1 exit prior to
 		 * the first L2 run.
+		 *
+		 * TODO: Drop the explicit check on being able to access guest
+		 *       memory once KVM no longer abuses the nested VM-Exit
+		 *       flow when destroying a vCPU.
 		 */
-		(void)nested_get_evmcs_page(vcpu);
+		if (__kvm_can_do_uaccess(vcpu->kvm))
+			(void)nested_get_evmcs_page(vcpu);
 #endif
 	}
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

