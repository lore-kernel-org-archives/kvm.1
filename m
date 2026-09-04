Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844AD2512C8
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481472; cv=none; b=G8WnuAzsYL6QhzHXJNo0HteuCwDMaGvHdghmMrqVbTSsuKnuOkwOCPJ13bPRYGgOh6arYGsYI5iNSHqIr8wY2V1heKd5zocCLrT6pA8AtHmeKRBprRhX7nyYiFqSUIqOZTIzH/UDMbU8WxnWZIqpLhboAalOz70M7kS5js9dFfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481472; c=relaxed/simple;
	bh=hieh5Dzmqi7G+PD9/MtPuY14lFCbp6sayQRMAk/bgVw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gIJeD5Zw0gR7do7RRQoly7+z35oDq7ZcXaEQoIXA7hNdI0ztufau+ZVCoZqRplflU7wk3geArKCv5hHWegZ2tvppNAPmBOXfNTwMGLPVTU1BGMaHNs6AD0kGoeNNzmWebCJPZ0Jc6+M/vQqeiyZH0YxudABHg6QLn8EoNdwn5d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CEfL1Sch; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CEfL1Sch"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c89704da8c7so631980a12.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481470; x=1789086270; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nGk7suZHBZq0aDw88ReExCPDyPGdklb10TBqchjRkS4=;
        b=CEfL1SchBXd06uXjglv02WOIFobplX3DdRRxY19oF961MsY+CuzdZsc7L25qDy80/R
         8tezLB8W81gsaRUOaIujS6ViBhxdTQaPgdyQ7lqHL/LZjf5HkPXDTRBGSMLa71Ek8xc7
         utI79zCBKhQWckKrf5hYe+QqqoeBwbn7utmB29SVHfHzaKGQgBWPCNdq4NoXjKYoxJwo
         E0A42HSIQFJq/8+rYE2qw7FBeSiUiYw4P0UQLeW0uqznvOMr7oSSQN4CRXDHJDMgyEVj
         4mm6XvUdD2XYAkPR83Yjba7naB+R3CW56/osWaxMwBij9QQ/kr82DtGPxX/o5WAA0oTh
         dbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481470; x=1789086270;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nGk7suZHBZq0aDw88ReExCPDyPGdklb10TBqchjRkS4=;
        b=jVr7/7bvMdNhA2gjZSvZOc1r+FPloz72ePDNtsZ5lHEJyFZgalUelXekqv6Q8KPxOY
         Kx75pVKOlpZ94JWOmC4MOfpOy43pRwCG5jbfnQYpoYKjF/HFOWrz1+NxUUar6YwU9t5r
         DDfka1orkFpfobxQHQzeGh2I2Y6+kOAbryjY/wmetTa9cAxC+rYWEDruiBtGTmgl2ScF
         Qa8rtgdG1HxLc0NOqFuUZNuEoAdmWpDZAUkF0AQwEjIPmm17plwklQwH4gueEf2LFZwl
         1pqi8giz9FCccT1m4cKYR+BOSZXOdnGJ6PCUy1VkIi6Bi/zhxd/Slc9DAD10q+zOFVRu
         8szw==
X-Gm-Message-State: AFuF++kfkJp6Ca+DzriOKTYHYl0d9ML7tO3gl1FcNHI+Rnj9mxOETWzC
	qcdBWPM3yUWC+74BAbYtGXUXeJ5EAo7H34VM+7zwPBEly94+Dg+SHJ8NLdBe2LlCmGwOk2oKipq
	wbkIzsQ==
X-Received: from pgnh1.prod.google.com ([2002:a63:3841:0:b0:cc4:57b9:2848])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3cc2:b0:3d7:7b6d:4997
 with SMTP id adf61e73a8af0-3da3a16bfd5mr3615765637.27.1788481469519; Thu, 03
 Sep 2026 17:24:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:24:09 -0700
In-Reply-To: <20260904002423.3154436-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904002423.3154436-4-seanjc@google.com>
Subject: [PATCH v4 03/17] KVM: selftests: Don't clobber RFLAGS in happy path
 of __KVM_ASM_SAFE()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Use a straight MOV instead of an XOR to zero R9 in the non-faulting path of
__KVM_ASM_SAFE() so as not to clobber RFLAGS.  XOR generates smaller code,
but optimizing performance by minimizing the code footprint is just about
the last thing that KVM selftests care about.

The bug is relatively benign in the current code base, e.g. it marginally
degrades the coverage in the fastops test, but otherwise does no harm.  But
the bug will become actively problematic if/when the "safe assembly" macros
are used for instructions that communicate results via RFLAGS, e.g. for VMX
instructions, which signal failure via RFLAGS.CF and RFLAGS.ZF.

Opportunistically use R9D instead of the full R9, as bits 63:32 of GPRs are
zeroed on writes to bit 31:0.

Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260818165258.2613603-5-vkuznets@redhat.com
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 6e6f70035508..282b8aaff799 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1318,7 +1318,7 @@ gva_t vm_alloc_stack(struct kvm_vm *vm, int nr_pages);
 	"lea 1f(%%rip), %%r10\n\t"				\
 	"lea 2f(%%rip), %%r11\n\t"				\
 	fep "1: " insn "\n\t"					\
-	"xor %%r9, %%r9\n\t"					\
+	"mov $0, %%r9d\n\t"					\
 	"2:\n\t"						\
 	"mov  %%r9b, %[vector]\n\t"				\
 	"mov  %%r10, %[error_code]\n\t"
-- 
2.55.0.979.g7e5102b832-goog

