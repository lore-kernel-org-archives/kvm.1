Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D87A25B094
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481483; cv=none; b=qSL3dSekArM/sni8wECCvQuSwZ0UFqEYbZ495AHKVz46pYHU89jJf6PwdUf62gIH9kVGhl8SSv4HtQ49Tod89O+K2UgFNYg06B59htFKYMekAnr2PufGmiT230tz4tpRmonMV9Axn1ieVi7n0rSjsdhznzYc4bOWmN14Ja0B/RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481483; c=relaxed/simple;
	bh=TzyTpIZvX8nCrYGQ78u757hq1EFVtnC4d3w5LisdstQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DaU25OAY7WnHATWW6/qCA8P8lDWhJzrodr27WFZBk+sFwiSGADFvbN4RiDqXQVi94NEnSgVuQhBTBizcf3u/m9U/hLyvjzTDrL2gRSVGNzkTAhwfXdMvDFJHMxWeY/JVamwFEJEbQs52U9Z2PRrMSI3v8Hq8/7wQnBcRzPcxDN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bAJLsUrT; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAJLsUrT"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e048a801dso453204b3a.3
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481479; x=1789086279; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ctpiOwQNgtLo4mnzlgvrJK29bFr1/fYhEIoXwvr6TRs=;
        b=bAJLsUrTsHY0eU60SzvZDgtmXWPIpLSX2+qQM0q0NMW1uUQDswu+JN9NXlxKnUZa1R
         6w2P5EeRnUZLah6v7XR1lKxR7ysDQOXBzfHproaWBt9gG12W5fS2Cgq6dF/eUy9NVEGr
         7vGzLRnNp+70XZHpBJp40RUhvXzTZf7VYQJYIzJUCzcECxgEf9dYvZRdNOkMbjs8TFOh
         RQz5kwQbfwy4kt9tFzpZlU8Tk/cx64rJGM84z7ZNkriXgvCwD6KUTzt9X5Mkx8Iu1NwG
         y9vxvp1lsMGp2fvUPpcaRWona9wbw46s8oX1V6zv5ObunL3D4e5cNEjJQDekaNdoFKRY
         QuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481479; x=1789086279;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ctpiOwQNgtLo4mnzlgvrJK29bFr1/fYhEIoXwvr6TRs=;
        b=KMS0UPAt8FSJMn63Rup2WO2klR1bJUPxDy6fKeyYfRJgKcAPv1btpKWpW0X9Br7+jt
         JJgz4iFk8vWYwHBMk0j4YY7dyrvw5+Yl/sc0hB7KnU4ht7qPZG34Q63ABH5yp/+/Pn1L
         7agCzR0JnWV3MiJgY+8eem7Pbg0DMqjrINXEsmJXXRyDl+IJfvTmUW0+SHlEsn8kB3gJ
         Bb4Yq6z0PN/Y9RGzmLbhJaoHAlOvrV574GJCpik2ai7N1IqqpLOzfFl882AOpAlwgeFi
         GlnfIx/EsbYSkdrbyGb2LDj8tG9nPm6r+P+jB2UmhSDieL+3Xnqbg7OsH2YIjHcjpGl6
         WGZg==
X-Gm-Message-State: AFuF++mDpf0vdmaJrFoBUeTXKDaiNiEqIm+CfMzccf/NWSl6p+oHBWFt
	wY0NE9i6pWcSd5b98RDPEDGYmAFa0b6NMi3RgxP9fyT1O1da+xx9KhAytkyLa8zCPr5AVcishAY
	O2xXdnQ==
X-Received: from pfjd1.prod.google.com ([2002:a05:6a00:2441:b0:847:a13f:28e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c8f:b0:84f:5cd7:e3c6
 with SMTP id d2e1a72fcca58-861662d4ce4mr3977869b3a.5.1788481478472; Thu, 03
 Sep 2026 17:24:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:24:17 -0700
In-Reply-To: <20260904002423.3154436-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904002423.3154436-12-seanjc@google.com>
Subject: [PATCH v4 11/17] KVM: selftests: Add macros to handle simple VMX instructions
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add macros to build helpers for VMXON, VMPTRLD, and VMCLEAR, i.e. the VMX
instructions that take a VMCS address as input, and don't have outputs.
Getting the params right is annoying, especially when using KVM_ASM_SAFE().

As a bonus, this adds non-asserting double-underscores versions of VMXON
and VMCLEAR for "free".

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h | 71 +++++++------------
 1 file changed, 26 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 5c46ae95c4c3..3def8df902a2 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -313,58 +313,39 @@ struct vmx_msr_entry {
 	__GUEST_ASSERT(!__r, __stringify(insn) "[0x%lx] hit %s",	\
 		       __pa, __r < 0 ? "VM-Fail" : ex_str(__r))
 
-static inline void vmxon(u64 phys)
-{
-	u8 ret;
-
-	__asm__ __volatile__ ("vmxon %[pa]; setna %[ret]"
-		: [ret]"=rm"(ret)
-		: [pa]"m"(phys)
-		: "cc", "memory");
-
-	__GUEST_ASSERT(!ret, "vmxon [0x%lx] failed", phys);
+#define BUILD_VMCS_ASM_HELPERS(insn)					\
+static inline int __##insn(u64 vmcs_pa)					\
+{									\
+	u64 error_code;							\
+	u8 vector;							\
+	u8 failed;							\
+									\
+	asm volatile(KVM_ASM_SAFE(__stringify(insn) " %[pa]")		\
+		     "\n\tsetna %[failed]"				\
+		     : KVM_ASM_SAFE_OUTPUTS(vector, error_code),	\
+		       [failed]"=qm"(failed)				\
+		     : [pa]"m"(vmcs_pa)					\
+		     : "cc", "memory", KVM_ASM_SAFE_CLOBBERS);		\
+									\
+	return vector ? vector : failed ? -EINVAL : 0;			\
+}									\
+									\
+static inline void insn(u64 vmcs_pa)					\
+{									\
+	int ret = __##insn(vmcs_pa);					\
+									\
+	GUEST_ASSERT_VMX_INSN_SUCCEEDED(insn, ret, vmcs_pa);		\
 }
 
+BUILD_VMCS_ASM_HELPERS(vmxon)
+BUILD_VMCS_ASM_HELPERS(vmptrld)
+BUILD_VMCS_ASM_HELPERS(vmclear)
+
 static inline void vmxoff(void)
 {
 	__asm__ __volatile__("vmxoff");
 }
 
-static inline void vmclear(u64 vmcs_pa)
-{
-	u8 ret;
-
-	__asm__ __volatile__ ("vmclear %[pa]; setna %[ret]"
-		: [ret]"=rm"(ret)
-		: [pa]"m"(vmcs_pa)
-		: "cc", "memory");
-
-	__GUEST_ASSERT(!ret, "vmclear [0x%lx] failed\n", vmcs_pa);
-}
-
-static inline int __vmptrld(u64 vmcs_pa)
-{
-	u64 error_code;
-	u8 vector;
-	u8 failed;
-
-	asm volatile(KVM_ASM_SAFE("vmptrld %[pa]")
-		     "\n\tsetna %[failed]"
-		     : KVM_ASM_SAFE_OUTPUTS(vector, error_code),
-		       [failed]"=qm"(failed)
-		     : [pa]"m"(vmcs_pa)
-		     : "cc", "memory", KVM_ASM_SAFE_CLOBBERS);
-
-	return vector ? vector : failed ? -EINVAL : 0;
-}
-
-static inline void vmptrld(u64 vmcs_pa)
-{
-	int ret = __vmptrld(vmcs_pa);
-
-	GUEST_ASSERT_VMX_INSN_SUCCEEDED(vmptrld, ret, vmcs_pa);
-}
-
 static inline u64 vmptrst(void)
 {
 	u64 value = 0;
-- 
2.55.0.979.g7e5102b832-goog

