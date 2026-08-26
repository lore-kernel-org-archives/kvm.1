Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316143803C6
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779129; cv=none; b=A3XBhrGT0BOEtS/KCp/QVJ6qA7zi7Gyn+7cWlr+TyvC94gmbGWeJWrLSDKIaYOnDAKcY1r4LlId0x+3p/mw7eDp36RWt0HXkbUiMjPAnWBm26+cak0lsSxIXk2eIZTjQa5YQGh3cZ0pZFSkSTXToWGnmPI/ENK+f6GwK3gOHD/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779129; c=relaxed/simple;
	bh=6sCSVbTksTpzUfz2Vygg/QdEYlpQa3FDKHZ/LkAuyec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NJ98OH/irGB2OOlJhkV7tROunbFcnOAJ3QSgkPc/IqtTE+vLZYB4rUUEUtalLyFybTG/rF6wG5Z2S2kwlAhOxsAziljGUksC490VRztMGF+VSQ/29/8+YAjzLEi/oJSX+3NE442mQRnFIm9JivDrbYVenMiajlqo9ab7VF0ODXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWgn+1rS; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWgn+1rS"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca8aee88725so1741356a12.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787779127; x=1788383927; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YdQOf/sgj3pcH0YMGOZwkO4ah2h30JX4XXRsNdNb4bg=;
        b=RWgn+1rSikEO9GnIR/AX1nK2tZrovo9tfMf6ZDoIs8qerRCqfo/EXy1RQEXGmU8PHb
         dTY1MFqE0sURmihsk1FAPTF/eCdD//OMYC9u0BS/XYoBxR/ikz6AKqcJ2glxIzw9DIPT
         +ftLJWwAQSwyyv9bX+d9SP4skgy01vYzyYFXdktPP6IFThBb6QqCv1uTO60F65XYKRpI
         +YTMkm8eGKmcaNpzA9aWdQDf1+lYArvitNS+9aFiTurdq0/KU0UybehZCXnJqt1y0nGO
         yC72aTe818PM3NpPRz24C0SmguduDYsV0cQsp10ya1D5YlfRg0IiqJO4ilsgIaUMnlJo
         /KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787779127; x=1788383927;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YdQOf/sgj3pcH0YMGOZwkO4ah2h30JX4XXRsNdNb4bg=;
        b=GNEmyqDnYlMobR75YI2jQVJjoXLeKtfQcMaByZlcNDyjCMqeKQ1DpTVLS0gz2vJAgp
         P5NkVgaQGro4ETSN1RYRjrkvD/DhdvenzkwzNnziUiPVC2K1hIdLBY3iXhVTdic6ZZGz
         3XEYnFO5/iIQ5QdJSgNrl9ihm6GdAVWYaNf6CAJbI7XbJ97k+7SViYGS9GufUckodIQN
         vUsgX5izyl4TcS9w4hckodh70j6RxGZ4bKgU8SmHxD1TSYmLqYSNKOOOvOv6pZEzLtDm
         bWdOY0nMlMqgB1fAvAm51eOwJDBK4B+DSZC2nWHKTSNq+2UmlX2nl9Ptsc2lpHvM8gGQ
         pK4A==
X-Gm-Message-State: AFuF++kbojNVF7mEmaOA9J6BypMh8Om+rsX9cNk7e75iCYQy+Ifepi0C
	bXuM2YehL9gs0vh66/BO/Li82Rc2sSHmpsaEnNupUEIokmTWLp8fC01YLgpIYR7+q0Cnd3s+lJJ
	h7bZZog==
X-Received: from pgab135.prod.google.com ([2002:a63:348d:0:b0:cc1:522f:464c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a95:b0:3c1:fbf:1e2e
 with SMTP id adf61e73a8af0-3cf83b22768mr20870291637.10.1787779127361; Wed, 26
 Aug 2026 14:18:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:18:41 -0700
In-Reply-To: <20260826211844.884951-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826211844.884951-2-seanjc@google.com>
Subject: [PATCH 1/4] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has
 EFER.LMA=1 && EFER.LME=0
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Reject KVM_SET_NESTED_STATE if the incoming L1 host state has what is
effectively an impossible EFER combination of LMA=1 but LME=0, i.e. if the
state says long mode is active but not enabled.  Unlike VMX, SVM doesn't
have an explicit consistent check for the illegal combination; presumably
hardware simply ignores EFER.LMA if EFER.LME=0.

Unfortunately, KVM doesn't ignore EFER.LMA in this case and consumes the
illegal state when constructing the shadow MMU for L2.  E.g. if userspace
also clears CR4.PAE, then kvm_calc_cpu_role() will compute a role with 4 or
5 levels of paging, but shadow_mmu_init_context() will wire up the MMU to
use the paging32 template, which maxes out its levels at 2.

Note, the "real badness" is effectively the same as what happened with the
nVMX bug fixed by commit 112e66017bff ("KVM: nVMX: add missing consistency
checks for CR0 and CR4").  Unfortunately, the sanity check added by commit
72e2fb24a0b0 ("KVM: x86/mmu: Bug the VM if a vCPU ends up in long mode
without PAE enabled") doesn't work for this case, since L2 state is active
at the time of the page fault, but it's L1 that has the bad state.

Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
Cc: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 73f37b050d0a..49fb10ad1f9f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2028,6 +2028,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(save->cr0 & X86_CR0_PG) ||
 	    !(save->cr0 & X86_CR0_PE) ||
 	    (save->rflags & X86_EFLAGS_VM) ||
+	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
 	    !nested_vmcb_check_save(vcpu, &save_cached, false))
 		goto out_free;
 
-- 
2.55.0.887.g758fc8c411-goog

