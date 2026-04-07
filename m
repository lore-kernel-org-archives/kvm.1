Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD58137AA83
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588642; cv=none; b=h6FIvTooWHIgqjWKZmh/50ymUpzBkp80KNYrr5egK8XtMP9hJcySmdrDBvz8w2Kf9+sJ3fucjZMBXSaowqHVD3zskAV6eae0XAyC3xgZbEHoMDiDirdi9+XGjLyh/Dn5+JXWeDhd8OIExUHPrJIp1CFKIbzweRI9IDlvAFn9aRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588642; c=relaxed/simple;
	bh=DDTnOH7NwcOC069gyrRBOx/hSJ7etBIE2aq6L/7kopw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WaF3mvPNKhln4/e1+B05209cHyIzUzxl88NdBLQlsm33hxHqrBFvThtMveyZmvSFExZ1BgQqRYbfkMwU4fnjeiyEsY0Qa6HDhWWtz4vQZ7KwFs5Swep6hZJG+8j2ltfc4TPU70Elo8sSQvIF0Gz6SHDptOLd2vkUckwE8tQU8QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c3/g4F7l; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3/g4F7l"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82ce0a9e558so3681910b3a.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 12:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775588640; x=1776193440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/hWp5mdQZYGSnJF78QkGkcqqA60B96zhUB/JDrQy94=;
        b=c3/g4F7lNF8sI7pvKIe3kMjhXocaG1s8FIW1XOwSYzMLI2kw2HAOcN4qtCtoW0vbmf
         JovYQZnFyMnfjTwKI2Z3GMQJfrybRv5nardWLh/Rw/A+4D4npAJp5Vfm2cZN/+b8UM/m
         ycL30ycVH1DBtxpGgjhpjcLZrtFQONuOBDcktVnCWYVk88L4lH4y9g7z1MqRFhIC4ldE
         wrRxIf7gbQv6nML0x2c/rbAyYT7dnhtrTD8JL7HkLaUeEjXNjJK50aTeaINbj5ueZYT2
         QdkskxYFzUHxvx+uE4Qy3ZPnQOW/J3N+bOwxuWmKP1ikOcBBij6w3N1WuUyO5u2A+EhN
         ASVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588640; x=1776193440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/hWp5mdQZYGSnJF78QkGkcqqA60B96zhUB/JDrQy94=;
        b=QUJWpA+Sr8GcO6hmUzRZFZ4JZpl0HG3Nh9gjhi+C77JPquX+JxO7L/rTHSmIcRijyb
         DVSN0JmjTdAb9FQ0P7VCBVxMGMKM12xRkcrX3lco8CfbCRlPye5LjnkLfMydF4rMDibE
         danMAZt0fpVMYp0k6HRe3/Q9kUoQEsCJM7IaplWHLZXsk+ru3HU5hEJXnhzOm5qzMekA
         yC9+ztwDslgUe5rRQ95JRhH03cgq/nefyOJsE8ZQRBFS7YDY/ZWLsqb16ZyPO4sA7iBC
         WdVkI6IpTOoh67mutWKmr0aR8ymfrrLKYPSLl+TXCppW38iYf6ZaepHnxa44OFDg5CXP
         kEwg==
X-Forwarded-Encrypted: i=1; AJvYcCVl8snbRepUmQlW7oDzxokj0j56QyzVYar9Yvjm5c9sB2+gmo1jmgwagZmbaw6o/mrYMmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzogmLjtkDdchHrvoQiKOUyRTaIsoXt/vgGR7VgDNpE1aboSFP8
	RF8IePQ0lT7sEgQSWXvHSr33cR5xvJ3t6sBN+aHeG0CWc31PKAmFaDgXhk/ETBgpVdKiWlhMXSr
	sgPVI3vaDgRTtxQ==
X-Received: from pfbjc13.prod.google.com ([2002:a05:6a00:6c8d:b0:821:8233:7400])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4193:b0:82c:eb46:acb9 with SMTP id d2e1a72fcca58-82d0da8c458mr17805265b3a.24.1775588639882;
 Tue, 07 Apr 2026 12:03:59 -0700 (PDT)
Date: Tue,  7 Apr 2026 12:03:31 -0700
In-Reply-To: <20260407190343.325299-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407190343.325299-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407190343.325299-9-jmattson@google.com>
Subject: [PATCH v8 8/8] KVM: x86: nSVM: Save/restore gPAT with KVM_{GET,SET}_NESTED_STATE
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a 'gpat' field to kvm_svm_nested_state_hdr to carry L2's guest PAT
value across save and restore.

When KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled and the vCPU is in
guest mode with nested NPT enabled, save vmcb02's g_pat into the header on
KVM_GET_NESTED_STATE, and restore it on KVM_SET_NESTED_STATE.

Host-initiated accesses to IA32_PAT (via KVM_GET/SET_MSRS) always target
L1's hPAT, so they cannot be used to save or restore gPAT. The separate
header field ensures that KVM_GET/SET_MSRS and KVM_GET/SET_NESTED_STATE are
independent and can be ordered arbitrarily during save and restore.

Note that struct kvm_svm_nested_state_hdr is included in a union padded to
120 bytes, so there is room to add the gpat field without changing any
offsets.

Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 Documentation/virt/kvm/api.rst  |  1 +
 arch/x86/include/uapi/asm/kvm.h |  1 +
 arch/x86/kvm/svm/nested.c       | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 0a2d873ca5a3..d6bbb7bad173 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4965,6 +4965,7 @@ Errors:
 
   struct kvm_svm_nested_state_hdr {
 	__u64 vmcb_pa;
+	__u64 gpat;
   };
 
   struct kvm_vmx_nested_state_data {
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 3ada2fa9ca86..1585ec804066 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -533,6 +533,7 @@ struct kvm_svm_nested_state_data {
 
 struct kvm_svm_nested_state_hdr {
 	__u64 vmcb_pa;
+	__u64 gpat;
 };
 
 /* for KVM_CAP_NESTED_STATE */
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index cf6356c775e6..9682099193d4 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1868,6 +1868,9 @@ static int svm_get_nested_state(struct kvm_vcpu *vcpu,
 	/* First fill in the header and copy it out.  */
 	if (is_guest_mode(vcpu)) {
 		kvm_state.hdr.svm.vmcb_pa = svm->nested.vmcb12_gpa;
+		kvm_state.hdr.svm.gpat = 0;
+		if (l2_has_separate_pat(vcpu))
+			kvm_state.hdr.svm.gpat = svm->vmcb->save.g_pat;
 		kvm_state.size += KVM_STATE_NESTED_SVM_VMCB_SIZE;
 		kvm_state.flags |= KVM_STATE_NESTED_GUEST_MODE;
 
@@ -1920,6 +1923,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	struct vmcb_save_area *save;
 	struct vmcb_save_area_cached save_cached;
 	struct vmcb_ctrl_area_cached ctl_cached;
+	bool use_separate_l2_pat;
 	unsigned long cr0;
 	int ret;
 
@@ -1996,6 +2000,17 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	    !nested_vmcb_check_save(vcpu, &save_cached, false))
 		goto out_free;
 
+	/*
+	 * Validate gPAT when the shared PAT quirk is disabled (i.e. L2
+	 * has its own gPAT). This is done separately from the
+	 * vmcb_save_area_cached validation above, because gPAT is L2
+	 * state, but the vmcb_save_area_cached is populated with L1 state.
+	 */
+	use_separate_l2_pat = (ctl_cached.misc_ctl & SVM_MISC_ENABLE_NP) &&
+			      !kvm_check_has_quirk(vcpu->kvm,
+						   KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
+	if (use_separate_l2_pat && !kvm_pat_valid(kvm_state->hdr.svm.gpat))
+		goto out_free;
 
 	/*
 	 * All checks done, we can enter guest mode. Userspace provides
@@ -2022,6 +2037,10 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	nested_copy_vmcb_control_to_cache(svm, ctl);
 
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
+
+	if (use_separate_l2_pat)
+		vmcb_set_gpat(svm->vmcb, kvm_state->hdr.svm.gpat);
+
 	nested_vmcb02_prepare_control(svm);
 
 	/*
-- 
2.53.0.1213.gd9a14994de-goog

