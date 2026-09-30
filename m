Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616B4EF12D
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797013; cv=none; b=st5KclwuvY1fFMeShELgEhb7B9tX3112RINsDiAjVEiYGYseU6aZni9qmTyxmfSFHXtIeogKT/sAkf5/j1uE6+RCa/Aaa8zIa7E10NGbxKXhfMM7/6mGwlgGc4GjpWipM1O2EPpweWy4dmCi95o1nsjSgkgAUnnzhXJnHrhLyWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797013; c=relaxed/simple;
	bh=6Aco7EOhkiIqZeH5bR7d9zgidb7xSicYOKVcT78vcZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HUxLnzYgI4k//BhIgrZka4gez8OBE6o/a1fqeWEf4xEZtRQefeiqgHnE4jaA3JMSvT7nOHnPotHAHwK9aIxSEVU1xnLyjizFtg6xExJRUCjiw0tddc8VXfwgxc/mftSe5GnbxXtAw8NxxoDTiOXW9Mj8JCt+6RAoAYEh2ZRHPfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eie2QvbD; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eie2QvbD"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2df375fb9b2so60465815ad.2
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790797011; x=1791401811; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8l2LQZ/K3M62HHlaD3N2qkeE9h03hcQIsVix5OsuQN4=;
        b=Eie2QvbDx03GHwKU+svzkd47gvgZ3Jj1YItZB9CCAL5eP9G0hyMUroK0NN09vFHEwB
         Ww8qV0W0o680ymphxfpagLmghnGdt5114UAXzoArx7ysLVJwR7QF+QGwTSJtO4qU2G+R
         wRALn7k31OCmCn1+/Mz/jajfCu9rcHSXFi98EYX3AaO8mH4XFqZZ/MHAWYyBau0Fc6W2
         8iUcRgJIvLARGz7rkapAr6aPxpVAJ67cLMFI+RdCw+RpTP+rV5Xsn1l6eromLuz0kBGY
         ScZBqpm9ZnenZDYYLTIsS7OztRsDkl3gJOJ+rNVqaVBL7RRikG1nEKjvlzyBnohbRN+S
         PmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797011; x=1791401811;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8l2LQZ/K3M62HHlaD3N2qkeE9h03hcQIsVix5OsuQN4=;
        b=YO9n6qySBpvNq6D+qCXLRuWdUBOcbc7FK2qotErsK2gwdU+gJwyrTGxiP/XrThiI3e
         sNbqVAqtJLtrkIPB8Nl6+QSTUeNAgoY0OKZDPRZDACHXspLP4SLPiRnF1JtFpUZUUTBH
         PbmEVb6VMcNdnneQwV4o3u8dY+YlCc5SutukM5GIxHAxgnfM38O4sGRHieKE1Mt18pou
         hapMzVzTvrb3xtrjrXnjRtpTV53VJMJbdf8CcI5/amtFGFmeoKtPzYs78mdle0tzhtCA
         OCjGtxPQViVcE0oLndZ3+oQHTZpe+5boHqpByU10ESncOtKn2FHAYZJ37aBKGyALyDOW
         L9mA==
X-Gm-Message-State: AFq9FYKD2+IULdG5dRo29U516Ikq+nZ9koVQz5v0S83LR6wk7GqfmqsO
	9GgiSa7pEkavW1dekaAnJWdLoDd+nFSlWenMSQYr/SvYJ/k0/bX82QrRyH6jeme88LimpOAPagt
	WoqstnQ==
X-Received: from plem9.prod.google.com ([2002:a17:902:e409:b0:2dd:b8e5:443c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:234a:b0:2dd:c0ff:e72e
 with SMTP id d9443c01a7336-2e2e4bc8440mr20377855ad.64.1790797010743; Wed, 30
 Sep 2026 12:36:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 12:36:32 -0700
In-Reply-To: <20260930193634.3415089-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930193634.3415089-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930193634.3415089-11-seanjc@google.com>
Subject: [PATCH v6 10/12] KVM: nSVM: Don't assume all active-low bits DR6 are fixed-1
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Shivansh Dhiman <shivansh.dhiman@amd.com>

When preparing vmcb02 for nested VMRUN, force only the actual fixed-1 bits
instead of setting all active-low bits.  The flaw is currently benign, as
the only active-low bits supported by KVM are RTM (Restricted Transactional
Memory) and BLD (Bus Lock Detect), neither of which is currently supported
on SVM, but that's about to change.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/regs.c       | 1 +
 arch/x86/kvm/svm/nested.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 0c76cf17e884..3621f1a47d37 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -784,6 +784,7 @@ unsigned long kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
 
 	return fixed;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_dr6_fixed_1);
 
 int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val)
 {
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index d3f249cd0f2d..c7a69e309a36 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -808,7 +808,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 
 	if (unlikely(new_vmcb12 || vmcb12_is_dirty(control, VMCB_DR))) {
 		vmcb02->save.dr7 = svm->nested.save.dr7 | DR7_FIXED_1;
-		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_ACTIVE_LOW;
+		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | kvm_get_dr6_fixed_1(vcpu);
 		vmcb_mark_dirty(vmcb02, VMCB_DR);
 	}
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

