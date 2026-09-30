Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CA151DDFB
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803283; cv=none; b=hB3w6hg7ScmKiEu0zHulTOptm5+EDwX+fuRZUfT5ZTORBo9yU/sWR4XOrYqYsB5u5ZHI1pnXmvJuy/29WV5sY0QOKyfch/U38440T+8krIPYWarO4UlPpGj8DUOegaZZpFEeJ0Wqjy7OesmjpFmb3I9U3/84mzQ7gH/3o1JhBf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803283; c=relaxed/simple;
	bh=KhzCmk5WC8AOQA8Ul45nUPC1/2N85vtoaJQNQF67U3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LRgUPaUQS3p9NZ2dAI8XNkuCVxncFK//q5y94ZDX577kz9gcarWFJ0ygW5mdtCXfuR5zd9/IA8sUpvRrAJbuj/sKSl4cN4trCNTPEuqdptLLxEYIJrELdkRAgx7xXj8p9d5SaSHOQ1H22dYJVFpUCSm/reqPnNp6LrP3/yu85js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=boqixBvu; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="boqixBvu"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a4aa263a4aso2188149a91.1
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 14:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790803280; x=1791408080; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=StSfMMKa3bvOgPVEPrc0vegrNiPAcw8xGz3Rd2c57Ac=;
        b=boqixBvuWFssxpwXlk6D3mNWYlU+ykWOPDVR8xagxGq3jWglPsedXkZc5urJvVrrJW
         HpInrYFcOIAxYgtWCs1wq85DnS2CIW7NY70mMwJeSRMs6uuIedNcoDLNHlYunG9YmW4H
         yinX0O2+om5S2OrTKOQ/zgUZ2t8SBwc7YMzG8XzprEwRJ87aNUPsgy6BnPjVSRLjllKB
         w0RdKAgHHn6yYHFg39cUknVYEtzDmTo+eocfHbFC1Ok9sVfXA3ubepIGkeajUK2nL8D5
         ipaAqH1Yfmsxe39UHhM6toEAxtUIxbx1x4jw+9k6Iib2r8ySynWp3Lu7w3y/iAabxoOU
         9upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803280; x=1791408080;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=StSfMMKa3bvOgPVEPrc0vegrNiPAcw8xGz3Rd2c57Ac=;
        b=cnvcvHX+D3pf2lsRSI/WIL7REDq1selWgRx/D9SlAkxH3CWh8wKQSi/AMc8N5WJKup
         Sdvad4GzghHqaf88nMuJBWEubAIczFyd5zjTx/Soar4qN0NdHSE0K3gReQYzf8W4iekV
         a1gJRt4prLOycwfsCO9/C6YsYqI5olQOvcREV2fe6wedyPypqlGrlsBOA8+q4nxHlTYP
         lVr6DhjKKg30hv2sFb3bpRZM8TXDwPkfK47B4NptE3OS0pEVsxgKEc64foo3ir9d+ta6
         63VuNUa6wkly5XwCziRlabzLfTzX2jWn0Kmdp2erhgJUyIQ0nvh+zCQZx/UBURnXHUce
         a2DQ==
X-Gm-Message-State: AFq9FYJm8C5CDpj5dcDd+26MKLFOZUuZCA+ICo6DBEfbpuF5NQI9OYUD
	/3qYDz1qGjquoZACKf050JAvw0jD+mbcaNxECULVagLLui4Btl+4ThlLuMA2U77yzgIekm4F+B6
	5FvNs+Q==
X-Received: from pgce11.prod.google.com ([2002:a05:6a02:1cb:b0:cc7:84e2:5dfe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2243:b0:3a0:7d97:37c1
 with SMTP id 98e67ed59e1d1-3a4d1937927mr1979096a91.59.1790803280115; Wed, 30
 Sep 2026 14:21:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 14:21:12 -0700
In-Reply-To: <20260930212114.3500045-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930212114.3500045-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930212114.3500045-4-seanjc@google.com>
Subject: [PATCH v4 3/5] KVM: selftests: Rename svm_nested_clear_efer_svme to svm_nested_efer_test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

Rename svm_nested_clear_efer_svme.c to svm_nested_efer_test.c so that the
test can host coverage for other EFER bits whose behavior is tied to nested
SVM, and so that the name matches the svm_nested_<topic>_test convention used
by svm_nested_pat_test, svm_nested_shutdown_test, etc.

No functional change intended.

Assisted-by: LLM
Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm                        | 2 +-
 .../{svm_nested_clear_efer_svme.c => svm_nested_efer_test.c}    | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/kvm/x86/{svm_nested_clear_efer_svme.c => svm_nested_efer_test.c} (100%)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 96bab7002d39..2554464d8b96 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -117,7 +117,7 @@ TEST_GEN_PROGS_x86 += x86/state_test
 TEST_GEN_PROGS_x86 += x86/vmx_preemption_timer_test
 TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
 TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
-TEST_GEN_PROGS_x86 += x86/svm_nested_clear_efer_svme
+TEST_GEN_PROGS_x86 += x86/svm_nested_efer_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_vmcb12_gpa
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c b/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
similarity index 100%
rename from tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c
rename to tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

