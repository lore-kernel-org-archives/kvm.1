Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7463A168E
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381829; cv=none; b=e7dUp20e5GqTzZYjuMjLD0/gog/4/CjqoFz0vOZSXQOU7enWKtG3nOBTGDnFovxw+KWwcVua0WmlVy48hiTDfM7G3BNPsLO6E9MAbccwEgwg+izwJ7+xLoifVuXLf1ROsWMfLOWIOR+fSR8iVgABz7uNJXISzwZCkgiV3VVwavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381829; c=relaxed/simple;
	bh=o/KPCcv0d3ZIO//tblY3V4eqnr+bbXLhDZG9zf54a2g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DkVq7dL3waW6IqIQaJ6NZjKvbeJv+CJM0ZPY8lpsn62uTtCjZOlCS20zT0lfEe4fuUxCMo5LwAkq3y7f9pwdk/ZdzUMz5ne9inHBlPBlqIJ0jxA8eHuSV45qiBvQqerD+jh1btSAyNH0NxbdVoxlAumJZe0MbH3QC4NvbOupq5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RDa/fCXm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDa/fCXm"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b249975139so1743115ad.0
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 16:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776381826; x=1776986626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=e3Dmu6K5niFFPRiSYNEdPEZTFH/H4F7a2yY+viQuAo0=;
        b=RDa/fCXmpQkVDmUOIYcNscMe0P7EuFA/BtR19DNd6ZfALS/hbYV7YCrbIe/KHCnVHo
         Wxb4b67PY3lKZ0o9SpWNGyn/TVA2hyF6sWo4TY90YGPVEX3KaC1ouYg2VTWWNJOCwVvz
         keS7UJ+l6bpWmJf/nZRz4Bde/WY5GhZkWl0/qsMIrH/RBAMq3yGAGtjDzOkglDJDLxEp
         W92No+ja6HVgyIvEae2HW76Xn1eA3SdYx2e1T/gLRhOjG0Z+ryjknMay1fr22xrxLKir
         +vvvbMYMgI8D6w22BzARnrxrmGQeWDhnr+KTYYptrdOMGVnJIgEIniIw5q1ymI141kl5
         oNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776381826; x=1776986626;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3Dmu6K5niFFPRiSYNEdPEZTFH/H4F7a2yY+viQuAo0=;
        b=hbmCen+UuX6gDTn2qX4jlHOBJ7DekAG39cYKnD/3hPT6X4VtSdR1XP1Qv+53lWWn61
         yNKxP9BYsMEKdfpZUnYIFdPzKxUfNNwjwoEfql0zkPxs6STwwxDVMyZfHh8SXenGUcd9
         thapvLWoK+AagourKctLcsh5YXb3Rf1Y3OMOzAYE3P9EZC1z6i08QU6sK8gbkisuQYKW
         IQFZZrDNyEHYPIWp1iRNFbp+RZD26TVQ7jpyelRaQcRnL12owtTWj9ZLUBukNbUka8I6
         kCmP/8ESgv/dr8ZEQ/njHoTg4HTogSciPxv1v7Ox/UXibAAmnOWy05pUrI6m5JIRcST0
         yZvQ==
X-Gm-Message-State: AOJu0YygzGOC4334QDYYzUiRQ3MT8i3yV51B6EO4d9jS/QO57xLR6VCq
	1yN+CvtbQEwxHordEVoefTHtgymfFaRX+z04LvmKH8GDiUsfTiKDG4hPlQhVBrljRj+uRyO+HaY
	BVnyFkA==
X-Received: from pgac11.prod.google.com ([2002:a05:6a02:294b:b0:c63:55bd:18f0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7354:b0:398:8002:8033
 with SMTP id adf61e73a8af0-3a08d9362d0mr332172637.49.1776381825229; Thu, 16
 Apr 2026 16:23:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Apr 2026 16:23:26 -0700
In-Reply-To: <20260416232329.3408497-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416232329.3408497-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416232329.3408497-5-seanjc@google.com>
Subject: [PATCH v3 4/7] KVM: SEV: Consolidate logic for printing state of
 SEV{,-ES,-SNP} enabling
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	John Allen <john.allen@amd.com>
Cc: kvm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Tycho Andersen <tycho@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add a helper to print enabled/unusable/disabled for SEV+ VM types in
anticipation of SNP also being subjecting to "unusable" logic.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index ea4ce371d5f3..dfeb660b8f5d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3050,6 +3050,11 @@ static bool is_sev_snp_initialized(void)
 	return initialized;
 }
 
+static const char * __init sev_str_feature_state(bool is_supported, bool is_usable)
+{
+	return is_supported ? is_usable ? "enabled" : "unusable" : "disabled";
+}
+
 void __init sev_hardware_setup(void)
 {
 	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
@@ -3199,19 +3204,15 @@ void __init sev_hardware_setup(void)
 
 	if (boot_cpu_has(X86_FEATURE_SEV))
 		pr_info("SEV %s (ASIDs %u - %u)\n",
-			sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
-								       "unusable" :
-								       "disabled",
+			sev_str_feature_state(sev_supported, min_sev_asid <= max_sev_asid),
 			min_sev_asid, max_sev_asid);
 	if (boot_cpu_has(X86_FEATURE_SEV_ES))
 		pr_info("SEV-ES %s (ASIDs %u - %u)\n",
-			sev_es_supported ? min_sev_es_asid <= max_sev_es_asid ? "enabled" :
-										"unusable" :
-										"disabled",
+			sev_str_feature_state(sev_es_supported, min_sev_es_asid <= max_sev_es_asid),
 			min_sev_es_asid, max_sev_es_asid);
 	if (boot_cpu_has(X86_FEATURE_SEV_SNP))
 		pr_info("SEV-SNP %s (ASIDs %u - %u)\n",
-			str_enabled_disabled(sev_snp_supported),
+			sev_str_feature_state(sev_snp_supported, true),
 			min_snp_asid, max_snp_asid);
 
 	sev_enabled = sev_supported;
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

