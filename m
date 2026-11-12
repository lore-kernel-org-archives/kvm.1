Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510123;
	b=jK3qGwQLf+DSzA12+vRhhtKJLNSBnr2XdetXVUTzVxcdaxjo9lVGtwDVRrI/jA5C0MhT
	 18YuMSZYE2kpXwxk5lm6EdJ4xlBNFhQh2kTro73nsl6jCzGuDxAMhfMqDeCvxyF4lsRH2
	 y7IPwlXE2UaXO11pTCLVR9qTajjpGvATkYhIJOPClTiiQyaeN3D5QgwCJiZ4HpmWdynPv
	 Dh3jCZjfPDSqNzvVGSiRIJ6QYVQg83544aBuH2OuTlmgA6rU7EM5f0diHRycJMOVZuZzl
	 N83hXzKxklkgZW7ItZTdQC14x0aPT/LQ/LTKqbuaVLUEJdtzGXLaKa23twU9yc8xCsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=0BWRXYU90cf54hfF6Vi8cEaIhhQPo+XnQGMy56cYcVI=;
	b=njHpu/V8dBDp9nOriQ8sBv9un9/XfU9a56BRUGNiH1JpdA3GnotwCfGUewce5mSTehGG
	 QoqAkpcqY7phKxlDnzscQmyOIjP4NPjrpm6bk1auncyDa7iYFezyanXSWqygJ2x0V9aKJ
	 ACg7ApkWJ3DXKtLTUMyuVFfwEBFH2wvl0qW+mtm1R13xPvJRS5r3SR866SmH7hY00ExvI
	 SezfdZCRAYbDbhyTTx7W/URze6lDZVuvp8SHMReGfGVrlRRcA5I0M3/luR1wJQTi+sTUI
	 YkPzDJw9tai/yIjZvmxqTwPV768JSRwrYoxbjdEQ9v+aHzrRb44soMk6L8EicivyPCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=koq6v1Uk;
	arc=none smtp.remote-ip=209.85.160.71
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1FF606A33A
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 19:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D1FF606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=koq6v1Uk
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-464fb819ac5so110810fac.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 11:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794510122; x=1795114922; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0BWRXYU90cf54hfF6Vi8cEaIhhQPo+XnQGMy56cYcVI=;
        b=koq6v1UkHrE2RUIVTilRGCkuyFhhD4dRyOUijul96GP561xavot25rMkohlunoIyTG
         m0mjjrL27uMbJnlW58By1WWdHWi51tWC9M5vRA1pChMJQSYqMuFgTP2FbMo8F2YAKoRI
         0OoTAxy8pIMpw4a2aQUH1yhhEJ5Oo4/ez+ltr8LHLZquWRp0EdAjBSg90fnox37smHfQ
         eHhkJ8iFdclTwJeLT6Ce3Z/B4bya1rgdpiDSj2Z1USzL3W4r+Jwe1CQ6tOVCdtE0D/EN
         hw/CMyKeq+G18nITQIbltERzcQz2klRFCN9VtgA/zZjZOx21wj4fkpe/tRbUOQZjoKKw
         oxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510122; x=1795114922;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0BWRXYU90cf54hfF6Vi8cEaIhhQPo+XnQGMy56cYcVI=;
        b=YmPIDUY1bf+tD/yf6Pw3bG+Bm6Yn6s3MWnachMUJdW1Zx9Aa4OBRsAxYfGBYffyr95
         XiLxey77MJx46J/PUQYJsZBymWmhLV6BXS3We5WzRwR8MLCfgsCRXEj/8YXinFC2i4+1
         EVSRmZyFXtOnZXcTvwP/5FPyVmQV6PtBwn70s6p5sak3OVMTvtZYWnpUVfZY7VUaE7iv
         RYa7aBFX7ChuSEAh3jFjNRCEHUg+zBZBXDiwi8DGzGrjJmkE94QCvZgUQsAB06nGOF6R
         Y1SDacI5oQhC+b8hyDqKMSi63Cyo9t7KK+WbVO0EXaSQ8AxGPPdJ2zPl9lBJaKV+Wg8j
         FZcw==
X-Forwarded-Encrypted: i=1; AL+hErHa3V6fOywvX4gH22eqJ6hBSoSiDkrfOJPaxtKBX5FPJDDcY8qYcc8/7g8sgCQzPrw6F/c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6x8sk8qJseICnDCnk6YBTtxrdOGczAh17jDHl3yk3S4eP54Eo
	bHzmWdLt6XQJa249JT+d9hZyGHhigRa75rFafFQkvkYzaManhqXOUideLAMZaVSOUxFNCKHLW8w
	E5Sw4BusuEsk55A==
X-Received: from ilej14-n1.prod.google.com ([2002:a05:6e02:620e:10b0:518:96aa:6d6a])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:1b08:b0:4ad:5ca8:dbf7 with SMTP id 586e51a60fabf-4afded4d142mr577391fac.0.1794510121626;
 Thu, 12 Nov 2026 11:02:01 -0800 (PST)
Date: Thu, 12 Nov 2026 11:01:58 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261112190158.103091-1-jmattson@google.com>
Subject: [PATCH] KVM: nSVM: Add CET shadow stack MSRs to merge_msrs[]
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Yosry Ahmed <yosry@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

When shadow stack is enabled for a vCPU, svm_recalc_msr_intercepts()
disables interception of MSR_IA32_U_CET, MSR_IA32_S_CET, and
MSR_IA32_PL{0..3}_SSP in vmcb01's MSRPM. However, because these MSRs are
missing from merge_msrs[] in nested_svm_init_msrpm_merge_offsets(),
their MSRPM bits are never merged into vmcb02's MSRPM, and L0 continues
to intercept L2 accesses to them even when L1 disables interception.

Add the CET shadow stack MSRs to merge_msrs[] and bump the size of
nested_svm_msrpm_merge_offsets[] to accommodate their MSRPM chunk offset.

Fixes: 38c46bdbf998 ("KVM: SVM: Pass through shadow stack MSRs as appropriate")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 6298160458bc..1299fdadeb73 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -209,7 +209,7 @@ void nested_vmcb02_recalc_intercepts(struct vcpu_svm *svm)
  * Hardcode the capacity of the array based on the maximum number of _offsets_.
  * MSRs are batched together, so there are fewer offsets than MSRs.
  */
-static int nested_svm_msrpm_merge_offsets[10] __ro_after_init;
+static int nested_svm_msrpm_merge_offsets[11] __ro_after_init;
 static int nested_svm_nr_msrpm_merge_offsets __ro_after_init;
 typedef unsigned long nsvm_msrpm_merge_t;
 
@@ -238,6 +238,13 @@ int __init nested_svm_init_msrpm_merge_offsets(void)
 		MSR_IA32_LASTINTFROMIP,
 		MSR_IA32_LASTINTTOIP,
 
+		MSR_IA32_U_CET,
+		MSR_IA32_S_CET,
+		MSR_IA32_PL0_SSP,
+		MSR_IA32_PL1_SSP,
+		MSR_IA32_PL2_SSP,
+		MSR_IA32_PL3_SSP,
+
 		MSR_K7_PERFCTR0,
 		MSR_K7_PERFCTR1,
 		MSR_K7_PERFCTR2,
-- 
2.56.1.703.gf848ed807c-goog

