Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F423EAAA
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481471; cv=none; b=AslPaMPqAvjdhY32GAXWAyea6kdKNCw9eRG78vTooh1phBI9ZUi1+5gqYFWSAeG6WeVTHibF9ED+itBESZ+8d2V3AvedM+LJpqPG9W6K/O+B0jrFGMQ3vsHlV907xPq/gmrERteA1HIzcjO/Y+u6a9gtYEelINt2XEbi85FDGF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481471; c=relaxed/simple;
	bh=yAXXfMiQDDT+TX3uVpO3MhOalO1RXt+3/lszMXnkOjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X8glrpfxeFSg2C9dofDPEg62LFMecNBMMP8f8XyBD1F4oAzDKWTCWKoUtCeozgb8WSztGqHsiqpatYElsxqo4jAaAccl4wmvxoJVrSHMvlz1yaMbdDl/qCcbmlGlmzQY/JNTcdQcf8DnQYDHs9KkKrWDb9kblA9stvMDh1s5oHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fljm5cKn; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fljm5cKn"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e01a62d99so502617b3a.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481469; x=1789086269; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IBzhRz5zfoZi7n8bMbtw4lvWtqjJET4EFYtEvAZvYHA=;
        b=fljm5cKn/+ViheH4hkiscrw20vRDyiVts7GGDRLO+2f+rjxPdqe8UBtLWmDOxRSld0
         JhPbwclsNtzANp1XkrcMLdRb/zmJfPZwXq5adGSp8mpGhMccDt38T7V7j2qzkvFpArzl
         oGLJdmeXR3KK18A5xF1zhqBfsVSmpnGABi6n2+CcrJ7dQfsuEbz0jT8xa9PCdgZJ4yJ3
         6OZXlOhl1KIJLBkCdjC/XBFjGz+E9K9G1BfA3WBRwaDH447a7q2eJV2IluI8SnwmnV6H
         W2MtzHT1J7/r5E9wqUboJ5RiyHZiX4GldYTF+ThuMx7R5+8d1V/rI3mfYN6VKlnfTgUx
         Wv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481469; x=1789086269;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IBzhRz5zfoZi7n8bMbtw4lvWtqjJET4EFYtEvAZvYHA=;
        b=WZIXSs5Nno0ESXgz1qQKasTp4TlsKRYH0zwAuEx87Z+joDqsH6DTwgQtUNBJUCsWtD
         oCtqV1iKXNzMWjWX3OzQFn59QZGs8sAtcy45MaWTx+bO5jd4XIb42cyl1Zpx4fquY5J/
         C2O9JHLWz5WqhCwoztkcHipiTTqGWfh93DKqW1bvgRH7aTrrsBh+Sim+QjgvU0K53MOl
         dfey38g+cwThV3wFGXGDPlgomJdFtMfFZKWjLrCDrBf7y9UnQDE0gcz9hwezj80XgG4u
         KQJ07fEl5ZjD1m3DaN0eYNq6YS8qZYIQQAeYEJyl0VUHNkyxBg2cKa1AX3lvx8eGOMbp
         lNFA==
X-Gm-Message-State: AFuF++nSOJxuSObIs5Th8/Ay+E+hZ+83iuhGqyeVyuKSHTBCVCsfBZrf
	br4PzK++mEtozHQIP6oYo0os4NXEkeeLPCVAJduqKOUHrAvI38OGQhzTCo4/5f/Ld13cOm0PsaS
	Xy8YYOQ==
X-Received: from pfbfy3.prod.google.com ([2002:a05:6a00:8283:b0:84e:2400:dc7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c83:b0:857:72ba:ff11
 with SMTP id d2e1a72fcca58-8616b967099mr4010021b3a.25.1788481468362; Thu, 03
 Sep 2026 17:24:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:24:08 -0700
In-Reply-To: <20260904002423.3154436-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904002423.3154436-3-seanjc@google.com>
Subject: [PATCH v4 02/17] KVM: nVMX: Make VMPTRST return eVMCS GPA when it is used
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Vitaly Kuznetsov <vkuznets@redhat.com>

VMPTRST with active eVMCS is currently forbidden, however, returning 1
without skipping the instruction will likely result in L1 getting
stuck. While TLFS does not specify the expected behavior, genuine Hyper-V
seems to be returning eVMCS GPA. Implement the same behavior in KVM.

Reported-by: f734222792@gmail.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221841
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ad3726fd4fda..3058efa65c82 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5964,7 +5964,7 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
 	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
-	gpa_t current_vmptr = to_vmx(vcpu)->nested.current_vmptr;
+	gpa_t current_vmptr;
 	struct x86_exception e;
 	gva_t gva;
 	int r;
@@ -5972,8 +5972,16 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	if (unlikely(nested_vmx_is_evmptr12_valid(to_vmx(vcpu))))
-		return 1;
+	/*
+	 * Hyper-V TLFS does not specify the behavior of VMPTRST when eVMCS is used
+	 * but genuine Hyper-V seems to be returning eVMCS GPA.
+	 */
+#ifdef CONFIG_KVM_HYPERV
+	if (nested_vmx_is_evmptr12_valid(to_vmx(vcpu)))
+		current_vmptr = to_vmx(vcpu)->nested.hv_evmcs_vmptr;
+	else
+#endif
+		current_vmptr = to_vmx(vcpu)->nested.current_vmptr;
 
 	if (get_vmx_mem_address(vcpu, exit_qual, instr_info,
 				true, sizeof(gpa_t), &gva))
-- 
2.55.0.979.g7e5102b832-goog

