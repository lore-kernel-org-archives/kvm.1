Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C1E3D7D8E
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787577; cv=none; b=PAch8iq0VsfhvNNhqiqwNvu0MihbeZKwLi1NWi8xFeapxfTObf7nL0FNd+5bzf/xZ5Fk4zCqZfP0uGJmDEomASYCZXTrkwc3RrHWSEXAQKLrGxlLJFJcYSQlYeQ50QvPfuQ/zY0KFxCj9aCSLlxihB3jg1L6DVTWTJLoTiHUNhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787577; c=relaxed/simple;
	bh=mX6wXHMIic+NJOq4AXotoGAmdGRenuNOIkRtcGgvZzk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OtwHXc6x7pL7xQ6S+Ldtqi4t/2GSUeT1Co7Is5HELSyuOiUiI9q21vOzy9jrvYLxKyEO+H5/OHBlbWoY1rGPaL1lyOaC+F59U83fGzSlY55zJfSaFOOC4D8Vjo+UWrHr8Gwqr4jlQFIRWnvqxWbsp44WjHm7KKlpRyimIWTwixI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eSpKjfTN; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eSpKjfTN"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d02df2bf09so1194395ad.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787787575; x=1788392375; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Eyf8YBnQl608Aj3Mcz2kxDmbrzzhdHd7IDHJSrs5/do=;
        b=eSpKjfTN8QCMKJ5W3b1qvg3HIzeYgN7INkhJoOvVAwaE7yoWQcmNrPa22ncYbWWeO2
         Z/y4Gp28Mkr4pUjmL1OlEWa6XnzGacPY+vTdvvPIKX7Z7N9qTyOPEa9rekaw5Pg4v14x
         ExD5li9DsfuXz6ydBIqEdQEK3kK1gEX08T5OrmqnEKxDoIgJYPRSJkhpLFf8ksfXRVUo
         S9gp085iz55SLhLqNyMsuURfvqQDKfcevECbNqkVupD5SwsXoybyhygaLbDHDOka2bLy
         xhju+QPcqRjHYne6LaNW0RMTyYmS1GVihOCwm14RvINQ4RTCxcgq+X/p0/2+YDWzvvn5
         HHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787787575; x=1788392375;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eyf8YBnQl608Aj3Mcz2kxDmbrzzhdHd7IDHJSrs5/do=;
        b=LahJ1zMkZXAHKgauc2N9RSFiDNKh7UekPvcuHSuc+PT6Ty/vb8sHHgrByFf/SN5Fgl
         +GSMjyD5mFFACnsCEK2Uh42/EZk20hXRjjHwKW/0BEbwUyFN7khHAUmnebbb3qwfBHmO
         bitwxq6bkqLqc7ZmygGfJt/ZRa/GBth7R0wMbgd6Z2nRuiPlZlR1WoIyAP6cXmqNGxpj
         AmvnaiQBLkLwf0CrHiYsFEkMUpES3Bi58Ebix9JY4y0MpbHIieMc1M10cMgtSrrOCdqx
         o1nfUBI3bRA0qgMn9VOkYF607rFeu3plzgFXrNiL8l+WouRiTbR62nzf7XfWyn8/fzVP
         nmlw==
X-Gm-Message-State: AFuF++n9VzR4bSgCkW2NmY1RV6jar73Nv2hWUwzQDno6bVesTJa+XK6G
	2ZUcLefv5cX/QmkxCRLEhi1roXQmhrT49ZTkZEtvx9S31A0tcbKszW3nvGfUTPEdm51wPYa8k+P
	D424j8Q==
X-Received: from plbkt4.prod.google.com ([2002:a17:903:884:b0:2d1:1cf0:2039])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fad:b0:2d6:df31:5bd0
 with SMTP id d9443c01a7336-2d707af0cc5mr206518655ad.10.1787787574681; Wed, 26
 Aug 2026 16:39:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:39:18 -0700
In-Reply-To: <20260826233919.998904-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826233919.998904-13-seanjc@google.com>
Subject: [PATCH v3 12/13] KVM: selftests: Dedup assembly code for VMLAUNCH and VMRESUME
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dedup the assembly code from VMLAUNCH vs. VMRESUME, the difference is
literally only the actual VM-Enter instruction.

No functional change intended.

Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h | 74 +++++++------------
 1 file changed, 26 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 3def8df902a2..fa01341e22bc 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -359,55 +359,33 @@ static inline u64 vmptrst(void)
 	return value;
 }
 
-static inline int vmlaunch(void)
-{
-	int ret;
-
-	if (enable_evmcs)
-		return evmcs_vmlaunch();
-
-	__asm__ __volatile__("push $0;"
-			     "vmwrite %%rsp, %[host_rsp];"
-			     "lea 1f(%%rip), %%rax;"
-			     "vmwrite %%rax, %[host_rip];"
-			     VMX_SWITCH_GPRS_ASM
-			     "vmlaunch;"
-			     "incq (%%rsp);"
-			     "1: ;"
-			     VMX_SWITCH_GPRS_ASM
-			     "pop %%rax;"
-			     : [ret]"=&a"(ret)
-			     : [host_rsp]"r"((u64)HOST_RSP),
-			       [host_rip]"r"((u64)HOST_RIP),
-			       GUEST_REGS_OFFSETS
-			     : "memory", "cc");
-	return ret;
-}
-
-static inline int vmresume(void)
-{
-	int ret;
-
-	if (enable_evmcs)
-		return evmcs_vmresume();
-
-	__asm__ __volatile__("push $0;"
-			     "vmwrite %%rsp, %[host_rsp];"
-			     "lea 1f(%%rip), %%rax;"
-			     "vmwrite %%rax, %[host_rip];"
-			     VMX_SWITCH_GPRS_ASM
-			     "vmresume;"
-			     "incq (%%rsp);"
-			     "1: ;"
-			     VMX_SWITCH_GPRS_ASM
-			     "pop %%rax;"
-			     : [ret]"=&a"(ret)
-			     : [host_rsp]"r"((u64)HOST_RSP),
-			       [host_rip]"r"((u64)HOST_RIP),
-			       GUEST_REGS_OFFSETS
-			     : "memory", "cc");
-	return ret;
+#define BUILD_VMX_VM_ENTRY_HELPERS(insn)				\
+static inline int insn(void)						\
+{									\
+	int ret;							\
+									\
+	if (enable_evmcs)						\
+		return evmcs_##insn();					\
+									\
+	__asm__ __volatile__("push $0;"					\
+			     "vmwrite %%rsp, %[host_rsp];"		\
+			     "lea 1f(%%rip), %%rax;"			\
+			     "vmwrite %%rax, %[host_rip];"		\
+			     VMX_SWITCH_GPRS_ASM			\
+			     __stringify(insn)";"			\
+			     "incq (%%rsp);"				\
+			     "1: ;"					\
+			     VMX_SWITCH_GPRS_ASM			\
+			     "pop %%rax;"				\
+			     : [ret]"=&a"(ret)				\
+			     : [host_rsp]"r"((u64)HOST_RSP),		\
+			       [host_rip]"r"((u64)HOST_RIP),		\
+			       GUEST_REGS_OFFSETS			\
+			     : "memory", "cc");				\
+	return ret;							\
 }
+BUILD_VMX_VM_ENTRY_HELPERS(vmlaunch)
+BUILD_VMX_VM_ENTRY_HELPERS(vmresume)
 
 static inline void vmcall(void)
 {
-- 
2.55.0.887.g758fc8c411-goog

