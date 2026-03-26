Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF81E39B978
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547418; cv=none; b=JazWGISUJ/B7yf8uOR/4nmGGZ7MSOegKCAKIFouV3lvxZJSEmGcoK2GEY3a0DdM9PD4k8J+TwkagbO8FP2A61cucpMTHxXjZht74b+fO/l4iwRC5JhJ4CDaNTp38hGMxuugp0dsP+Guwhpog/J/5rmWmikMlt/9NZTWoo6dzcT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547418; c=relaxed/simple;
	bh=Y9rMXPhwhSPq2CcDwI9mgpPoQnii2Yurx3TfkOypRiU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jn917aJdAyW+SLJVpKGdcUzgdKodbvZLCPHcFO8a7glQp6gUSz5akvF5uL5zy88t5HW6l02U65hI6UbAUovtGvG9IlnXPzFWp/GiTWtcngK1QjwL64HuVed36aorrefxKtT9TprTgFKF0mPf5p2/4mvT6xYFNePqBP6o2xzV8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pkwfwd50; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pkwfwd50"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35b8f351debso1707700a91.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774547411; x=1775152211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jfn2M6k7bFpE7gypyjWrhFKs9Q/vfTaHTPk+frkTN9U=;
        b=Pkwfwd50S7d58+AQ4f3JKRAZCtl3E0VEqrqDH+eHc5x+6Av6VPxYRATHZ/gB7jNiUC
         SQpCPP7WernkPLo6fj4BSXJcpXhtKPrARPfX7/AJz4u8jR7C8NG31Lmolq+irL3aouBP
         Tx33Q+m0vnTSLocBonGLVBGRfiOe1H/2s4s8zxqtamw6zRd66M1sktLfowbXGnb6+K+y
         srn3w4DIdCdQpK9GhSXaC75IKXBGUuMCkcyHZ+Y09nWofZsAUfWeG1oWKUctMPH56cQL
         h/hvvLXEg+We3LLx1iEvSme7PIZrbtVsA7/L9HYO8PJH+OZBsMZzFhhtLe0BA5m02s9a
         VY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774547411; x=1775152211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jfn2M6k7bFpE7gypyjWrhFKs9Q/vfTaHTPk+frkTN9U=;
        b=FbQyg+XfBJWG62cteJTMZVl8LN8c25vNRV/LPNJ03G2kYUeIYdyWCNtjJUS7N4Ru5F
         uaJoCKmWaTLqImL3dH/EGT/1xkqhIO7cNuksKzphgthN5fCiczh1uAR777ZrHqNx/4/P
         LOGCexPPUXPxTaeKYQWMKY61AVvz9znCxh5eNcN2BieZid3tu+Ygolm/m3mszY/OGysB
         xhfKEgMcyEYu7DZDeAq342gC9fmugZTLyYaC/uhvf6lv0yRR9F9glddPMFldtio6YdON
         kYd2fS3nRlnDvtTF48g3JDAS+6L+0fZEy9xww1FeoKU5KkW2a2x0pzEih2b3tmHYWqRV
         lMiA==
X-Forwarded-Encrypted: i=1; AJvYcCWj6LDesUJdlLgcLeUT0j4oPu7RYdKwx4neJam2UpY3vx4LRS9tP18/7vPVcXlTtGYn/P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDYAwPmI3NZD40fFrPM8V290Lxhry/d7LeezBPPCr+CgM3SNUi
	aFLaw0cf5GOIHHjt+9c1TDZzfvhpzf+Bkex/vXKze0NmI3FYgeaJVmaZsy9FR7W7w/5bZ+Zjycu
	Ef4KNwMldBY7VJg==
X-Received: from pjbco11.prod.google.com ([2002:a17:90a:fe8b:b0:35b:9314:520d])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2809:b0:356:22ef:57ba with SMTP id 98e67ed59e1d1-35c0dce8c1bmr8443122a91.7.1774547411019;
 Thu, 26 Mar 2026 10:50:11 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:49:25 -0700
In-Reply-To: <20260326174944.3820245-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326174944.3820245-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326174944.3820245-8-jmattson@google.com>
Subject: [PATCH v6 07/10] KVM: x86: nSVM: Save gPAT to vmcb12.g_pat on VMEXIT
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
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
index 14063bef36f1..26bc33322a87 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1242,6 +1242,9 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	vmcb12->save.dr6    = svm->vcpu.arch.dr6;
 	vmcb12->save.cpl    = vmcb02->save.cpl;
 
+	if (l2_has_separate_pat(svm))
+		vmcb12->save.g_pat = vmcb02->save.g_pat;
+
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK)) {
 		vmcb12->save.s_cet	= vmcb02->save.s_cet;
 		vmcb12->save.isst_addr	= vmcb02->save.isst_addr;
-- 
2.53.0.1018.g2bb0e51243-goog

