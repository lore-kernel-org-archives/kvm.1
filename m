Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6EC3E869C
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186534; cv=none; b=jH+DGf/o56hPvqu40oHF7JGXNOZtjBfcVsLCJyrvU7rpyrAjhQ9yN70KG/xZU+xQ+v9x9+RcVX4isW5DrF+e7Xq4hlQ5JJ6YhMbeqW9YxMpcNIlx8zJsEPblAc+dDUZkuD3+oC3BWC1EjXw7e4smuOnuhUiDCPK/2Oo0zB779ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186534; c=relaxed/simple;
	bh=90O6JzYqbzkgAxXkOD7D5rrxUZpMuuEbxgasWWkKpaU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tkr59iD4KscDCV/1832YMv7mpAwOiPI9l6ZA/jPi9kMmHjDiE2dvim2ghYRZ51doMF51utYr7DLuZdYhJrrpSbCq5IVVu8x6NSa8mjrwg21moY69763Jiht6fA8KH+kHFQ0IXVq+eySQN3QaQjtEPrmBTTgyaNoiRvrNVf286pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MiXd1vrx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MiXd1vrx"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c73939e0314so3006258a12.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186533; x=1773791333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tD4Z1nqIAQC9F2Tarxi6stByrkCrz7QH2uC/2+jh2A4=;
        b=MiXd1vrxLnicyuYiQP2Vqp/LPwGVD9sasjmARKlsaPsFiEt4TWvhVWggGfUOMxJ1Ls
         tHv/p5zqOvqdXLsIrFFrG9vLYMl1SgtzhJwMAT2XoJ2J46u8nNcq9GBPGuqjhtDDeVW2
         nNCKXp1VztwEmrB5mI01JxUp2/qM8nggJBdiYvIIlsmBWLUw4umqs7ybyRbVqCn+wisI
         o4CLh9GK8rMYNM6ZCNgZ7cCRoMr4PIU4FrAyK0E0avNDnZO8Es+1z11AjD6JCgTLeUUV
         CK0NtIZCeWbamIzvYMSiWs8u2vRj/l8+fyuk2f2dx/6h3mttAn4YxDkpf4BY19VmF8k5
         cp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186533; x=1773791333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tD4Z1nqIAQC9F2Tarxi6stByrkCrz7QH2uC/2+jh2A4=;
        b=TCplYZJ11hj3oLmceDSaWiRYWjWTsKELfQkgRpnFdAOMigW+wSlvC+U/gRrZKFeHgd
         MA6RbYy7tE+Izf9maXjYiMciIp5PJeSz20fS7KeQ1s+lPemf1j5m79kY5drBKlPi+WKd
         YFKtHEdYm73yz3CVDlKFMZH8jHl/uTJvisxJDetfNuAsunKouM/A5T7xqTeIIBLTlXo6
         q6ObCYxGbcHSIFzIVYx9a5B+FriD6EHKH6QJmsoXvF2LLXuQar3lfxIb2+WgcU1FsOHi
         DyO6CoJiAGgAmwZk44/fUMcvbf8OgekhfbjjxaiK4VZ9RF8FrjoMHJmLx/GqfcN2Vz7S
         +OOg==
X-Gm-Message-State: AOJu0Yy91JL+4g3t4/OWzVQ5YOJZn6rXXzHBcLck4tl0G849S9ZAW4cU
	m0eLExw1Gc6ySsay8P0sen2n6u9MzC7x053hbw38GNgiTXMwT2PLMcR0HVbwVkuxA6iWZkiQmc7
	OD2DTnA==
X-Received: from pgkh18.prod.google.com ([2002:a63:e152:0:b0:c70:e97b:b573])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1393:b0:398:96c6:b8de
 with SMTP id adf61e73a8af0-398c60dc911mr407994637.37.1773186532623; Tue, 10
 Mar 2026 16:48:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:18 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-11-seanjc@google.com>
Subject: [PATCH 10/21] KVM: SEV: Move standard VM-scoped helpers to detect
 SEV+ guests to sev.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Now that all external usage of the VM-scoped APIs to detect SEV+ guests is
gone, drop the stubs provided for CONFIG_KVM_AMD_SEV=n builds and bury the
"standard" APIs in sev.c.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 14 ++++++++++++++
 arch/x86/kvm/svm/svm.h | 17 -----------------
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 35033dc79390..0c5b47272335 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -107,6 +107,20 @@ static unsigned int nr_asids;
 static unsigned long *sev_asid_bitmap;
 static unsigned long *sev_reclaim_asid_bitmap;
 
+static bool sev_guest(struct kvm *kvm)
+{
+	return ____sev_guest(kvm);
+}
+static bool sev_es_guest(struct kvm *kvm)
+{
+	return ____sev_es_guest(kvm);
+}
+
+static bool sev_snp_guest(struct kvm *kvm)
+{
+	return ____sev_snp_guest(kvm);
+}
+
 static int snp_decommission_context(struct kvm *kvm);
 
 struct enc_region {
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 5f8977eec874..1b27d20f3022 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -389,20 +389,6 @@ static __always_inline bool ____sev_snp_guest(struct kvm *kvm)
 	       !WARN_ON_ONCE(!____sev_es_guest(kvm));
 }
 
-static __always_inline bool sev_guest(struct kvm *kvm)
-{
-	return ____sev_guest(kvm);
-}
-static __always_inline bool sev_es_guest(struct kvm *kvm)
-{
-	return ____sev_es_guest(kvm);
-}
-
-static __always_inline bool sev_snp_guest(struct kvm *kvm)
-{
-	return ____sev_snp_guest(kvm);
-}
-
 static __always_inline bool is_sev_guest(struct kvm_vcpu *vcpu)
 {
 	return ____sev_guest(vcpu->kvm);
@@ -417,9 +403,6 @@ static __always_inline bool is_sev_snp_guest(struct kvm_vcpu *vcpu)
 	return ____sev_snp_guest(vcpu->kvm);
 }
 #else
-#define sev_guest(kvm) false
-#define sev_es_guest(kvm) false
-#define sev_snp_guest(kvm) false
 #define is_sev_guest(vcpu) false
 #define is_sev_es_guest(vcpu) false
 #define is_sev_snp_guest(vcpu) false
-- 
2.53.0.473.g4a7958ca14-goog

