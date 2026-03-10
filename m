Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1D736D4FF
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186531; cv=none; b=VNmbGI9lyIs4gNaVycwsegmAd9nWqibVb9QoA8RoFguYeFn4r7JFNd7MxNxhFdlleLXdQawMUU0w/34LlGBl0qwFHLGLv3L4uiaF+G+V2bEslihvC+D1bOogjOH7GHA2XIQT7yu0Ln39YiCkJ+kSeiMiDuMZ5ZrTD1abXAeMtr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186531; c=relaxed/simple;
	bh=I3L4f0GVjyD921aN1yvrqvHsXqt03nCQtScrvSoRo8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PWLcqPyLLHADA5S3uHBoXEJ1tFhiXw1K1bPYv5FAeQ4VzOQxyYgSM6wWPTN5Z1I5EM9xmrg+uL3xYb5qOHpBFxzLva8YXzShWrC/h/rdNWuJoVzkNtGDYkG52SU8LL5pJYZi4QYNTJ+X/oLdEBz4/T+PynbLHA/uiQTrgWrL8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ax3t30Xo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ax3t30Xo"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so8420645a12.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186529; x=1773791329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zJpZVYlklFn/XNcFTpm87RMPwls9psijPGNAP7bKSe8=;
        b=ax3t30XoXrxsYbI8R6RrwrFiA5MdI3jD2421sENCp5zvPE/UDsC+zfSAdSuVRy5iv5
         Zv0xClc+aBRiQJ1pJE737H/u1bgnZRiRBv9Ju6FiYjWp2JbnBOZMY72284oqEXcWYGhb
         GuWIsO99/ZqI4m07RDWVFl9b7WGKjrBVAdUL9ALIrPEA70Go4ekeemvgK32PwDWXPWNZ
         SU2HuhwbRdAc9+gUiO5zTyrB83CFYKfdI6mK0DCx5HtyAwmvhlrpEkKj4DhEAYErttRi
         9bWVR1rVV+bDvrwliHvufc1XVySHVrDWwhlvAtJ/mB10/Iz+426Ya5Z7IF2+FpS2KD8g
         JY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186529; x=1773791329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJpZVYlklFn/XNcFTpm87RMPwls9psijPGNAP7bKSe8=;
        b=HGGc64FnV4xyPschw59RosfO9V6g18f06E7TM+RVLS7g5sC3bcqyxHZQWZ1+00oKz0
         LNYM8j5JjtSvoj84MIdzwqr3DYd5Qnhdq9MUNGjU87YKo2ZVSrOD9ARVq4671HPc2VNG
         g9fZHZ2pyeCMo7LTr8SWEzWMiur03hw2OVo7wVXq9sQw2iKsKQdBUGnIUgBwOIfp0a3Q
         J5A0pvidRBLxZ7W6H/tPkTp1Ysxo05foe0ZaHCf2GKUWCA+039TSqrBZik7tmctzu9Ny
         2/qqWslrssH/3XsTo5O/AOQDoqLtPiDlZaTdAkjROVV2zew7SiA5WnUYWXXTtWURrAN3
         MoTg==
X-Gm-Message-State: AOJu0YzrJOGFV7IVXCotCcIPd9B14jDca3mETDi58tU0IaKn7bLTu2oA
	A+MCbP7AttsCvCRs58wHerw6Q2TYGcJ5zAlpj2kez39td4deI2Xn9C89s90NNQah8C64yA57f07
	/3KzyqA==
X-Received: from pgbq9.prod.google.com ([2002:a63:5c09:0:b0:c73:91cb:fa1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:700d:b0:398:9466:2eda
 with SMTP id adf61e73a8af0-398c5ed605bmr325143637.19.1773186529314; Tue, 10
 Mar 2026 16:48:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:16 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-9-seanjc@google.com>
Subject: [PATCH 08/21] KVM: SEV: Add quad-underscore version of VM-scoped APIs
 to detect SEV+ guests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Add "unsafe" quad-underscore versions of the SEV+ guest detectors in
anticipation of hardening the APIs via lockdep assertions.  This will allow
adding exceptions for usage that is known to be safe in advance of the
lockdep assertions.

Use a pile of underscores to try and communicate that use of the "unsafe"
shouldn't be done lightly.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.h | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 121138901fd6..5f8977eec874 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -370,37 +370,51 @@ static __always_inline struct kvm_sev_info *to_kvm_sev_info(struct kvm *kvm)
 }
 
 #ifdef CONFIG_KVM_AMD_SEV
-static __always_inline bool sev_guest(struct kvm *kvm)
+static __always_inline bool ____sev_guest(struct kvm *kvm)
 {
 	return to_kvm_sev_info(kvm)->active;
 }
-static __always_inline bool sev_es_guest(struct kvm *kvm)
+static __always_inline bool ____sev_es_guest(struct kvm *kvm)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
 
 	return sev->es_active && !WARN_ON_ONCE(!sev->active);
 }
 
-static __always_inline bool sev_snp_guest(struct kvm *kvm)
+static __always_inline bool ____sev_snp_guest(struct kvm *kvm)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
 
 	return (sev->vmsa_features & SVM_SEV_FEAT_SNP_ACTIVE) &&
-	       !WARN_ON_ONCE(!sev_es_guest(kvm));
+	       !WARN_ON_ONCE(!____sev_es_guest(kvm));
+}
+
+static __always_inline bool sev_guest(struct kvm *kvm)
+{
+	return ____sev_guest(kvm);
+}
+static __always_inline bool sev_es_guest(struct kvm *kvm)
+{
+	return ____sev_es_guest(kvm);
+}
+
+static __always_inline bool sev_snp_guest(struct kvm *kvm)
+{
+	return ____sev_snp_guest(kvm);
 }
 
 static __always_inline bool is_sev_guest(struct kvm_vcpu *vcpu)
 {
-	return sev_guest(vcpu->kvm);
+	return ____sev_guest(vcpu->kvm);
 }
 static __always_inline bool is_sev_es_guest(struct kvm_vcpu *vcpu)
 {
-	return sev_es_guest(vcpu->kvm);
+	return ____sev_es_guest(vcpu->kvm);
 }
 
 static __always_inline bool is_sev_snp_guest(struct kvm_vcpu *vcpu)
 {
-	return sev_snp_guest(vcpu->kvm);
+	return ____sev_snp_guest(vcpu->kvm);
 }
 #else
 #define sev_guest(kvm) false
-- 
2.53.0.473.g4a7958ca14-goog

