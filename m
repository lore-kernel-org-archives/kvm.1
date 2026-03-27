Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F813A4508
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774654842; cv=none; b=cQe/TrDFuUjEQw0xxWx1d3YMb8VPVLdt/jjILWqXoRICa8KTTC77YlJXzXRvmWvQg+NzPgLPljwrfvba2KYXaHTJtAdF/+w1LpaocfjNg6+ryAMuv2eYxXwhjE2lI5F6Acijk5jq2vtuh5Asu0hW6rF+AGMPDcm6geVRpT5OVm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774654842; c=relaxed/simple;
	bh=JZ6+GCnob6DoER6tsgVX1H+2aBiZ/Ru6GqazViOYorE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tGzMU6oAK0+s4Wx+AuVpq/g0iCQ2lqcVuKrdKl2GuJc++ylt8SAFb0kjYE+xfvghMu7z+2xuR0GbC9K/58lXKR7lhT+JvbyGoVNTn1nQRxbsW1vu92nzvaxzC44Z92Y6kDLqqEjVnIFk15gVysaAlDe24Jccum4GGuhrs3V06Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qpIhd2O2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpIhd2O2"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b0cac007cdso11129995ad.3
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 16:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774654839; x=1775259639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/5S/h4cOpTQz2572kh2nJElR+n8F1U4MUPv9k7NHcKE=;
        b=qpIhd2O2L0zS4SJogUKVUPAZmgD8tzPVNiNC+3yeI9nHH9s6V7izgeSmbBI6rmI3b0
         SiyN0AQbkxmiohOC0qJc6FwRiBnGa6AQ0BOAuKcZWK7H998U/Uw1F7htI7DqTvvC7wkv
         73t04DeGuEpszXB9Ja7g5WGf/DSAPqhe0X3BevdtS+8uv03kWkzTg8P6sUZIGaVJEQvr
         cH/tRMPADU77jv9xtqJi9S49ekbzpfLQdFapSwob7A0OZihz6yTEPz7JOMs36hMJx9xh
         xbg2m+kK9G6ljCOx9+eA5X6tajDUEVmDbY8Re+0MhO6L61kmRWXzsUJLnRapIde4BZsO
         nWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774654839; x=1775259639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5S/h4cOpTQz2572kh2nJElR+n8F1U4MUPv9k7NHcKE=;
        b=exyFfLKBY5Res91arfeY6Txx73IdyHd7xpDkveqcBos3LXfaBqqkVMNB01CTra+bMP
         6ZgKOMfhLRqSHrPUcJi5xnixBAKyUsXBkjCYGf+lo+qtYr6mA9LCBZB3D+jA4FEQZKGR
         TOb41kfsvwt8HURXZMqnN6XcKNqPtLPQ239qzfPs769djXhWLcFQAv7jIjDoiz/WAH2O
         JsRE0okY7H5Uy5oTDDnwZY6FBOHwYk1QT+Z0XSxG1nuytFrwR6wNIZpKkCTqhoSU9UfI
         7fDJ5Sy7c9H5vta14bpWvvakNL4q0+rmb4Ayd1nqikiltjAXMhLNKxjz90vjpRBkLzgZ
         aVYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXFoplrLalVuA0SPFTtui6/LeuoiWuP/Jx+QNJQCbOUieyxe9sOg9VovkoL31wRiYdO4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZfzxAU/yU1lfr2lDxDIB7GI/wxDlW0+vjnYw3kcpMYv0iYHeM
	EI8FacjA9sJ9wWV8hD/KeHYFChb6kqG7jT/YVJfWjAf1R07zzI2LFDxXewRO96cxiZe8Yl2TvL/
	eWu60VZAy9DJM3w==
X-Received: from plge14.prod.google.com ([2002:a17:902:cf4e:b0:2b0:5cd7:c89a])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2405:b0:2b0:ac1e:9737 with SMTP id d9443c01a7336-2b0cdc3dabcmr45964875ad.12.1774654838782;
 Fri, 27 Mar 2026 16:40:38 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:40:13 -0700
In-Reply-To: <20260327234023.2659476-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327234023.2659476-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327234023.2659476-7-jmattson@google.com>
Subject: [PATCH v7 6/9] KVM: x86: nSVM: Save gPAT to vmcb12.g_pat on VMEXIT
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
index ccc556eb4d2f..add57f2a2d9f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1248,6 +1248,9 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
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

