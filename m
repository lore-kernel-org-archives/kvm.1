Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07BD36D4FF
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186522; cv=none; b=qcn3D17H5g+AJB81QfUI7wFhBMCkjRo6R5UhsNjb8toBWcRdj1S7nFDZVzDq1X8Ws8ZZgAsc3OvpHgky2j3yOEkOMOQ3tgeb7mfqLzf6I08h1fgzJGhbKC0GFxbhrM9YQefnZx3q398W5OSBcNYNXzrWAU1NdRNL9L9zk3NvvDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186522; c=relaxed/simple;
	bh=1XZ4DTiRFNCLSF0qVFNepkPxCOp+jc//PliIM/VALRA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b2Cx64TuxGTBJr7KIuVv0OJ1TmUK93/YQoCUyUXqWWORygu72Jgc0qaj2Y/RHKiXnqbjzwcR3lxF8/givO1P2GLOt1q/5CJDgbMqXIsEw4DMMTYlSAPC7vFaNDnAUzumey/tIqvrmAd6rseFa3QmcXC0hqDXGlC7ILp19Y8Sjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EufFisZo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EufFisZo"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae50463c39so96048055ad.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186519; x=1773791319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KWj8o4bF94Heu5AMNW4c6J9rXL8cTQ+SLdFWvNrb5Sw=;
        b=EufFisZolAmoA7hsiENjiJgialdrP6ZtgNNzrjXtamU78dOhZxwDmSKjPYfpHelShn
         rrAgve/jmCLk3pDMNE2oOJ8njzH9xhacyoyX/Pf2zkYnKz8e5Fh8/qQhOjX8Sb6AJhaK
         t2vLKRGgqSz5nWWEn+sQjJI1XdumTZQpElOIR7nNKBPQJ1Ndce1BebY0yPx2V1RURTqv
         Uz6k6eU67eNgz98+YyJojojsWCkTF2eTDIDqAaGoGok+HQPpv2+0zkIrDnzrIAic79q3
         ahAxyrFdgTQISf1ZVpB8m1SNBcD0O9tt4NvbYAUp8azH0KSdShZw3os3OhKniLtjfSyg
         3Tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186519; x=1773791319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWj8o4bF94Heu5AMNW4c6J9rXL8cTQ+SLdFWvNrb5Sw=;
        b=SPrPqXcLX9YyW94uoBKJIsO/WS/tIz/9QhIjkyasgWBLCmVoo4e33TDVyWP2aO/PCU
         IlCNmdCI1wPLulJ/NM0tFO3FvVljCnjrERSAP4OWICwUaRvR2/QvL/oWgdOOKJkcFb2M
         pqnyO32sFcroXGHofaCtgW2zGk24HWhBNv0O4pNcQ3TmAtiJELGcnM1EcNG/LTTirqQa
         S70JudB400x9NJTEfY1wXZWT6AfRVe6qZbXr9tpRAG+eG32sJGSk/8FsVfFQbBEyDlBI
         2yafjGyQZ3SF4WN09NwuMUnH7Gk0WabNKVsnYee2rXKFmM2gyDF2kDFKmEgTrQ5xKgIu
         tInA==
X-Gm-Message-State: AOJu0Yymhaii74ahCNswHJNTW40TBidPJP4FC5BlsCRSIxhXRvuJ3DUM
	neW2dhC5CZJ/Gvj7RWvCbaY4mkjihufldo4QChvIYCxITh0P5K3HGXCv8uJRXPKlF+pXFtpfwIA
	drfO54A==
X-Received: from pgbdo14.prod.google.com ([2002:a05:6a02:e8e:b0:c73:9919:c4fd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6016:b0:398:bda8:d8cd
 with SMTP id adf61e73a8af0-398c5e6cc31mr354274637.7.1773186519300; Tue, 10
 Mar 2026 16:48:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:10 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-3-seanjc@google.com>
Subject: [PATCH 02/21] KVM: SEV: Reject attempts to sync VMSA of an
 already-launched/encrypted vCPU
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Reject synchronizing vCPU state to its associated VMSA if the vCPU has
already been launched, i.e. if the VMSA has already been encrypted.  On a
host with SNP enabled, accessing guest-private memory generates an RMP #PF
and panics the host.

  BUG: unable to handle page fault for address: ff1276cbfdf36000
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x80000003) - RMP violation
  PGD 5a31801067 P4D 5a31802067 PUD 40ccfb5063 PMD 40e5954063 PTE 80000040fdf36163
  SEV-SNP: PFN 0x40fdf36, RMP entry: [0x6010fffffffff001 - 0x000000000000001f]
  Oops: Oops: 0003 [#1] SMP NOPTI
  CPU: 33 UID: 0 PID: 996180 Comm: qemu-system-x86 Tainted: G           OE
  Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
  Hardware name: Dell Inc. PowerEdge R7625/0H1TJT, BIOS 1.5.8 07/21/2023
  RIP: 0010:sev_es_sync_vmsa+0x54/0x4c0 [kvm_amd]
  Call Trace:
   <TASK>
   snp_launch_update_vmsa+0x19d/0x290 [kvm_amd]
   snp_launch_finish+0xb6/0x380 [kvm_amd]
   sev_mem_enc_ioctl+0x14e/0x720 [kvm_amd]
   kvm_arch_vm_ioctl+0x837/0xcf0 [kvm]
   kvm_vm_ioctl+0x3fd/0xcc0 [kvm]
   __x64_sys_ioctl+0xa3/0x100
   x64_sys_call+0xfe0/0x2350
   do_syscall_64+0x81/0x10f0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7ffff673287d
   </TASK>

Note, the KVM flaw has been present since commit ad73109ae7ec ("KVM: SVM:
Provide support to launch and run an SEV-ES guest"), but has only been
actively dangerous for the host since SNP support was added.  With SEV-ES,
KVM would "just" clobber guest state, which is totally fine from a host
kernel perspective since userspace can clobber guest state any time before
sev_launch_update_vmsa().

Fixes: ad27ce155566 ("KVM: SEV: Add KVM_SEV_SNP_LAUNCH_FINISH command")
Reported-by: Jethro Beekman <jethro@fortanix.com>
Closes: https://lore.kernel.org/all/d98692e2-d96b-4c36-8089-4bc1e5cc3d57@fortanix.com
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3f9c1aa39a0a..fa319a66938c 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -882,6 +882,9 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	u8 *d;
 	int i;
 
+	if (vcpu->arch.guest_state_protected)
+		return -EINVAL;
+
 	/* Check some debug related fields before encrypting the VMSA */
 	if (svm->vcpu.guest_debug || (svm->vmcb->save.dr7 & ~DR7_FIXED_1))
 		return -EINVAL;
-- 
2.53.0.473.g4a7958ca14-goog

