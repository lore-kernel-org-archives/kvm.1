Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB99B2F7F19
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209559; cv=none; b=kVeICb+EOCIssQlulz0NrQX9PeKrRee6bMNj0w14wC2C+CAk7c9hIfvG2McXc+J8iDc0F0OzlfzPEeikdQNB45mkCbNkyulVij0sPUomtatE/G75OGM2uKd4Amj73OITRrclhxHtt6z7KCZENbOntHSEHuCcjDJNEtLzw4WrA9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209559; c=relaxed/simple;
	bh=je0dnkfFNKk+uoQkxx/XvcJ1dcav2J5cIsKIcj+09fM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pYkwh4EObO2RnB0ztowme8tiGSxImHhuKCtygKQKDZvpKxEPUtG2F0pu4Kgo4tH4niykslJoe7N6p16xCmwBUpy+x/H/sTUj4TJnMiQKCVfiaZVozJ5Gk9LfT6iOK8Uk7IfqWfQ0qE4K99mM1InKyV1gtHFtfPYtuu/INblfljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jfYUyMfK; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jfYUyMfK"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2dd53f2b27cso13692725ad.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 17:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790209557; x=1790814357; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rWvEr8HcLzBvZNb2ZaMPRoPvjV6bscZy0wkTIfmsztY=;
        b=jfYUyMfK+jYXpAVEdQvmv5EN1XahFjNUqqYd/3ncM3OYOky83e/GfH1D10ij31b/F6
         FmVviRK4qfMjIEyu1ocphuZiB2TTyJhok9It8EweEUYzNGytpnltM0ktWsB7mdadGtzK
         8Z2GxKD6gJzXlRUFSq+h6WE1djTVM/jcvVHNyQM3mrfALwcP9vOtFnYDsYc+8hYddlQ2
         yxgDFu1vSFMZje9DprCnMRoCA8g7BIflNIpDpAOmHbuzWmtm3g25Zm2mP8DkwX2irwHx
         hOgEH+Vp5Z08RyPaKniNFX3TOmeUbBPNHyJPeMedExWgmUiTqZY2Aq7ZHeIa5I/EFZrA
         T+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790209557; x=1790814357;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rWvEr8HcLzBvZNb2ZaMPRoPvjV6bscZy0wkTIfmsztY=;
        b=J58iOctDXDR08YSCHfxtsnDqVZ/tIdwffaNdhTfNfMbYaWOPMLoACKn14D3OtIv9uF
         lCHJl7Ul2+qWHW6VRiCFGdA8eIz6bzRkSL0e4rZzaFtqJWkU7EnHNXm7u3SLsri5e/4P
         8ESFqNf8+JS0Lhjq0Bb7YnLNa3Xzgh3Z+W2sd9izKZb87UKeQkEF5khUWecmoClrTpEK
         M/uDmc8Gr0i1bUe6jW+R+/8dLHtmAh38eGFyL7HSKzNcmIqFkuk0hDWzYmoM1OMlTUMF
         y33pogiP/7su8ecPg3wIT1WEf1W/UKpBcSM0CDA5ZaWSoev4j6Pphj2/rT0teIBf9f7E
         zZxg==
X-Gm-Message-State: AFuF++kpXds1Yp6XAR2bkODCGhiT9DA0fC6WLX4L+ADZDYqcqllou8Yn
	b57FqE9veNm//3g4Aq1GFQBbsAUHKT/PHfeqj9FIgwXCGI+cd3ussygRpzCqwesaYAADZDJAdrK
	gRO2hBEwh7lvqUg==
X-Received: from ples3.prod.google.com ([2002:a17:903:2143:b0:2df:527f:374a])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fda7:b0:2dd:c053:d73f with SMTP id d9443c01a7336-2df7dc37ebbmr6151175ad.38.1790209556802;
 Wed, 23 Sep 2026 17:25:56 -0700 (PDT)
Date: Wed, 23 Sep 2026 17:25:44 -0700
In-Reply-To: <cover.1790208413.git.jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790208413.git.jmattson@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <babf7e9ef2f54a5c01bed5f0c0976fd819c3b344.1790208413.git.jmattson@google.com>
Subject: [PATCH v2 3/4] KVM: selftests: Rename svm_nested_clear_efer_svme to svm_nested_efer_test
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@amd.com, 
	yosry@kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename svm_nested_clear_efer_svme.c to svm_nested_efer_test.c so that the
test can host coverage for other EFER bits whose behavior is tied to nested
SVM, and so that the name matches the svm_nested_<topic>_test convention used
by svm_nested_pat_test, svm_nested_shutdown_test, etc.

No functional change intended.

Assisted-by: LLM
Signed-off-by: Jim Mattson <jmattson@google.com>
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

