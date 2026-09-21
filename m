Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C7C51598B
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025375; cv=none; b=p8Fr1+Qk+AffDVub+Cukg/Vdar0oNPLilPOgcpF5T5Gmh9f75nhAIxx6oO3HrrmjCLTVSnrm7IgJ7mTF0IwqMx6eTOk/fQRfQ+19AD10su55ApBPKiTt6YqF2Um/isWRmD5T7D32ynKpPKfw8OCW0HRbxcWJwHb2elBPLeL+uog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025375; c=relaxed/simple;
	bh=8j/UVd3R9hPZYEQmpaTIM9YhX+5Gk60NqIXL2kiut2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TRL4PRKJmMWGFzLq+8Ba5NtF5dYslqqrVZx0j35Ip1lLLD/E/9FhQkCsoGb+oy6btV+CFRpmAIdE54VdeKIbOuk26jAwr2Q6JP49G0nQzFg5iQx20Acle3B7O7ylgAa7xIkYAmejslJFeNLxmfzEhatkT1+w7egu6Nr5MO0scSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KH/pyQZN; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KH/pyQZN"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc51591102fso4934753a12.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790025373; x=1790630173; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gUPmdTjIpuFQRYNvpR8eehCmbHOJvqsMfaeTcAMfPLk=;
        b=KH/pyQZNRSDTSTS2+6sDBdZZY3nf/MJIMCMxDe4Y1OmroDYHdXknoHGAJsZJESbr6n
         HPl5XfbAXI+Jk4SXvntXwytpLV+Z7aabGGXD67YvPvMLy6d43KztxF5XKzy9CejMekfv
         K/r529E+Xl3uFR53KFzQ8/wvrRFjvCJbNqf3rlL1QQmu6IWzcpj54rRAaTD3lUEby0Zx
         rDjksdsGaHuXIphAneirKwv2J/93zQNYiOUG2eG1P5gNV1Dy44VUGS+J8ZjLtGEql/8D
         Jfsri6EM/sAwiiuvsRHO6BrsqzSv7OqQ251cLxGRUAohcjzuKSZqGR6Ofp5F+s9Gr6hc
         jifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790025373; x=1790630173;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gUPmdTjIpuFQRYNvpR8eehCmbHOJvqsMfaeTcAMfPLk=;
        b=0frL/YDKoJoR4P3BtQ19UbOS7+tXMsV5a7oIJgyQiPXObMR5ZIAu3ej72o8hHWK8cs
         v1kOMPBIwfiG3KqX8yWxj5oJ1SOpFSuM9B6X07z6G64t8cfT6PZzKOpx7U703zGP0o3s
         XoG1LxgEB3Dr3W8ANzEAAmsOpBRJgabRWylRgiu8Z7ncTRqauHhg4QkwvzXSPIXk8oxO
         dsW0YCo3VhWmPX4Hsc3nSMaw9a4C3i5tJr1bLpvuxDHSVSI3t4UeqmcSLiQtYK5zCJBZ
         ePSu63ymN60ehgxGtT2wLSASb3uLGVwbLCQudxGWhdS9BM+GeBT1ZFrNEIuNmR2hIVqd
         vWXA==
X-Gm-Message-State: AFuF++k4HQxdQQvGz8vG+NdRFiIYgCxeA90RZ+/EDHYCo7SsJMdGn1cT
	pKHq7gIvb8ppM77OQL5gXNcukgcw0d2PNjLmAfaqfAHso+QYwgBLri+4SrdOZfa4BHjyL7IoyHP
	NLWBu6w==
X-Received: from pjbkz3.prod.google.com ([2002:a17:90b:2103:b0:39d:9b47:4551])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:574d:b0:39b:3109:10ce
 with SMTP id 98e67ed59e1d1-3a06ae1fd24mr248043a91.16.1790025373221; Mon, 21
 Sep 2026 14:16:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 14:16:08 -0700
In-Reply-To: <20260921211608.1030158-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921211608.1030158-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921211608.1030158-3-seanjc@google.com>
Subject: [PATCH v2 2/2] KVM: x86: Fill kvm_run exit fields in common
 get_nested_state_pages() error paths
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jinwoo Lee <rkskek9254@gmail.com>, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Fill kvm_run with "internal error, emulation" in the common error handling
paths for getting nested state pages, as requiring each check to manually
fill kvm_run is error prone and requires a non-trivial amount of copy+paste.

Specifically, both SVM and VMX fail to fill kvm_run if load_pdptrs() fails,
and SVM fails to fill kvm_run if kvm_hv_verify_vp_assist() fails.  If those
flows fail, the *best* case scenario is that KVM will exit to userspace
with KVM_EXIT_UNKNOWN.  The worst case scenario is that KVM exits with a
stale exit_reason and confuses userspace.

Note, SVM never exits to userspace if something goes sideways when dealing
with vmcb12 assets while emulating VMRUN, i.e. lack of SVM-specific code is
not a bug.

Fixes: 0f85722341b0 ("KVM: nVMX: delay loading of PDPTRs to KVM_REQ_GET_NESTED_STATE_PAGES")
Fixes: 232f75d3b4b5 ("KVM: nSVM: call nested_svm_load_cr3 on nested state load")
Fixes: 3f4a812edf5c ("KVM: nSVM: hyper-v: Enable L2 TLB flush")
Cc: stable@vger.kernel.org
Reported-by: Jinwoo Lee <rkskek9254@gmail.com>
Closes: https://lore.kernel.org/all/20260813043932.3214460-1-rkskek9254@gmail.com
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c |  7 +------
 arch/x86/kvm/vmx/nested.c | 15 +++++----------
 arch/x86/kvm/x86.c        |  3 +++
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 23d29597d6bf..82c49a24dd75 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2130,13 +2130,8 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 			return false;
 	}
 
-	if (!nested_svm_merge_msrpm(vcpu)) {
-		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		vcpu->run->internal.suberror =
-			KVM_INTERNAL_ERROR_EMULATION;
-		vcpu->run->internal.ndata = 0;
+	if (!nested_svm_merge_msrpm(vcpu))
 		return false;
-	}
 
 	if (kvm_hv_verify_vp_assist(vcpu))
 		return false;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 0e5f4d7ce9eb..56fbe73a44dc 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3465,10 +3465,6 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 		} else {
 			pr_debug_ratelimited("%s: no backing for APIC-access address in vmcs12\n",
 					     __func__);
-			vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-			vcpu->run->internal.suberror =
-				KVM_INTERNAL_ERROR_EMULATION;
-			vcpu->run->internal.ndata = 0;
 			return false;
 		}
 	}
@@ -3539,11 +3535,6 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
 	if (!nested_get_evmcs_page(vcpu)) {
 		pr_debug_ratelimited("%s: enlightened vmptrld failed\n",
 				     __func__);
-		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		vcpu->run->internal.suberror =
-			KVM_INTERNAL_ERROR_EMULATION;
-		vcpu->run->internal.ndata = 0;
-
 		return false;
 	}
 #endif
@@ -3915,8 +3906,12 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 
 vmentry_failed:
 	vcpu->arch.nested_run_pending = 0;
-	if (status == NVMX_VMENTRY_KVM_INTERNAL_ERROR)
+	if (status == NVMX_VMENTRY_KVM_INTERNAL_ERROR) {
+		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
+		vcpu->run->internal.ndata = 0;
 		return 0;
+	}
 	if (status == NVMX_VMENTRY_VMEXIT)
 		return 1;
 	WARN_ON_ONCE(status != NVMX_VMENTRY_VMFAIL);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3c5d3e19ec99..e9684abae4d8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8024,6 +8024,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
 			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
+				vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+				vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
+				vcpu->run->internal.ndata = 0;
 				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 				r = 0;
 				goto out;
-- 
2.55.0.1082.g2b9226bbc0-goog

