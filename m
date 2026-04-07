Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0AA3783AA
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588638; cv=none; b=mKIUoqYZCEm4NIIlD7RDIzE9oP2DFJrumu2+QSeJVcvYATCrh8GiEE/RZS2wX+2tQzIXnVx08fpQnn8lx+qT01B24sPcVc5e1DYr7+j9aI4OtYiA4O1Sx3ah7kQVFf64s6BVpyit0F6ZEcpe4SPySxdKY+xBEJcM+/lDmEjhK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588638; c=relaxed/simple;
	bh=iuWUKvwmq1iLzTnz/4asZIAlh+gQc+x117UdbVL7P2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KQKDp6A1uLVrgIyesdGCmGfsO+sRV3Jg8fBo+rECAWRW4x+nJa9ZyfIjqcPPNsTEU/wSkZuzE/5enUJrn5JKNxh/HYQVJ0VHBtZRY17rFDlHJZVdAiPlsh30pc4FzFVSKJD6gFOpciWGcMFtFpHw6jAScLH+QDLDU11iwnibM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uobZ2mg5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uobZ2mg5"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82d02942266so6757406b3a.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775588637; x=1776193437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5I/y9a0OvTzfaNFmaQXBFw1laTAVH3VYWAc0gKu5sno=;
        b=uobZ2mg5VaRj46Bhu4PEx9uE/ArlsCEGZau5vxbTEBhM79SOOUK8mH4EXEOJQfeL+R
         1NVCLIhFbSt2iJCx94Ioe5j1gubeKdxqndwhdqjbmwceFFslkpigUGmYCkRA80KvdGdw
         jWxTKJq7lpuzHL+u8E2rrtVyFkaFK3NYp/Z6zEHw5EnIHHMrZ5NC3mw6Lkv3Oklt8F1k
         /rzcjQuKm2p8ejWF5TuF+zVHHq35smnv64MHTK3rpVaJDe373anlWbwJIvSiyApQMXHZ
         uBTtKFRuYBy49R7+5W7KmPCam+BOiPyFF0CN4QKs4KtCCMCelXdk3HE7bqYrDbDvMMj7
         HhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588637; x=1776193437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5I/y9a0OvTzfaNFmaQXBFw1laTAVH3VYWAc0gKu5sno=;
        b=GTgOTZY1Vsx8eFtGGijxb68wZiP+Pj8eaDyPKhiCsJcE645LeWEeB0+IKdi0Pv9kc+
         rqXht0t89Oc5FDUDipp9hlcvw9pl7Xt+lF3d7O96PVzlqBlveivY3yErlkyqji24czQO
         11iRWuR+hzWZrEwpIAKb4aVkuec7u0TGueuKJvGUtKFWS1LUaxjG3IMG2TEPQdrlXovJ
         wl64LscHYF7wsIXnOefLpjCiKdyPJ/mOLeciGlws5MpvZiHhS3572QlqIMGMchUFpMJ4
         7XofUqKw9U2EP/KGUFOKZXSc8Iro3k/sKUY988LrBdom42beVx7BbSxavKCdm9pIaplR
         6vdw==
X-Forwarded-Encrypted: i=1; AJvYcCUFWYMEQLiQKicgnJzUfO1ALQRr9SgRfsFpNcjRH9hlmnbl8YkMrus/emXWBYUc01bOYkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzidpJmmUpcvUhhQ8SUS4mwUbytrR+5PS1zhoFQyPs8Eh9k2vWh
	A8VCopsQdhbEGpIRCTNsgDY+fNXOlk1oO+1GxoFLJ5+mtakinaF++j4dLkmGwxRSo9I74yew1BK
	FEogZOUgeYf7B4g==
X-Received: from pfbmb8.prod.google.com ([2002:a05:6a00:7608:b0:82c:9835:bf12])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:18a3:b0:81f:31c3:2e34 with SMTP id d2e1a72fcca58-82d0da90bc1mr18183960b3a.25.1775588636947;
 Tue, 07 Apr 2026 12:03:56 -0700 (PDT)
Date: Tue,  7 Apr 2026 12:03:29 -0700
In-Reply-To: <20260407190343.325299-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407190343.325299-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407190343.325299-7-jmattson@google.com>
Subject: [PATCH v8 6/8] KVM: x86: nSVM: Save gPAT to vmcb12.g_pat on VMEXIT
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

According to the APM volume 3 pseudo-code for "VMRUN," when nested paging
is enabled in the vmcb, the guest PAT register (gPAT) is saved to the vmcb
on emulated VMEXIT.

When KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled and the vCPU is in
guest mode with nested NPT enabled, save the vmcb02 g_pat field to the
vmcb12 g_pat field on emulated VMEXIT.

Fixes: 15038e147247 ("KVM: SVM: obey guest PAT")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 8c9dd685b616..cf6356c775e6 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1250,6 +1250,9 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	vmcb12->save.dr6    = svm->vcpu.arch.dr6;
 	vmcb12->save.cpl    = vmcb02->save.cpl;
 
+	if (l2_has_separate_pat(vcpu))
+		vmcb12->save.g_pat = vmcb02->save.g_pat;
+
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK)) {
 		vmcb12->save.s_cet	= vmcb02->save.s_cet;
 		vmcb12->save.isst_addr	= vmcb02->save.isst_addr;
-- 
2.53.0.1213.gd9a14994de-goog

