Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBAB3CD8B5
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792719; cv=none; b=f0wctM3zct6UzWmsMuszDu9FvlAtFmie1MNJsu7JTeqC7OOFjbgzLG1TDdimr+5sKj2VacyygbtWAV/GIzVZeOIISyhiY7GHjXkjLj+0xsa5LStnUm64lOZwgMozv5ZXygeWHOFl+pdn4rvNUL7N6rXUusiILFLHp45HV74lvqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792719; c=relaxed/simple;
	bh=2MZhcI1ktBvNp6E87lEw1JBEHuJ8PY5UUZuEgTFsOmI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hQXmj8FrgJiQe1RbiSWgmuIP8j5wUyukwPFxnHyiQpavTF72mwSXBIY09i65NGUBnL4lIpWS1VV8HDvQDaSrTlOT/8v7ATiG78gkUuaFuiRJF5d3cSczFdyStLo0oxaX2+Oe/3QparyyU71okjHMsvrgZLnn82sZuNTSS20EgNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vpPmsUYp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpPmsUYp"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa2165c3eso5731435b3a.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792718; x=1779397518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DBr5bftNcAftsCE6y5TtSEZc6p5eK9tIGUhK58/91qo=;
        b=vpPmsUYpHOLIvSB8KxVTVtYCmRU1vyYxKWt1R0EJr/C4/ogcRXISVxOBYEtXsokm/V
         4ih5WHBJi5O4YTYJmAU/MpgQ3vRAijMU5m1dsw7h+q4zZMfUMq7Ck09xR8c8LvvUauH/
         QsB1W0OS52UEV3H6xBvoiuot+5BkIvpIOh/O5xXxBgK8GLloo66xN1CyM095U0MtKkzE
         X6AevMAN+9Wi4yJRrKc9v+kzhlEyLNZkrDx7VH92UePtPuzrVAO9Rl32CsBKYe2chf/f
         LC2PdlW4kHzB/b5EoJFAoD6N8XASzKJAD0C9ng7Mz3+PnBL52OtfTt2M814fviAUh6lh
         RVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792718; x=1779397518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DBr5bftNcAftsCE6y5TtSEZc6p5eK9tIGUhK58/91qo=;
        b=OwwlRm1j6hKf4wpDI7u+COKS+FUyoirmnciQQjyM7iVPSNozWdY4mNmy5OGq5Qe0FW
         Vom8Y2v2ISXoGqXcJbJmWIKGAo62JdyFwkLZG8M+drnjWq8oiwZjFtVDxoFYdIxv3xuC
         Q/RTngqBresir4jcfIgMaFECBNus4T6Ndm1O+dwLCXDrIcj2sOyE/D3lC7pS+oGeaEm0
         rEsjCOVy7dTm0CzBDY1IC10W3/R/aANebunjR3RqcIdfvviL+ppdj7sqWo+jSIvynZfR
         wxYisODT1dD57q6V0WB/6l+RDZYtrkompznweLWh2uIvHLRNK12fBcTl8BUJmWEYnWRj
         iaAw==
X-Gm-Message-State: AOJu0YxC1hzVfzw86IMRe7l05yso5md7vIHH+bFvkkQPUJBRHlfN0+j5
	ol4bJOZahT7Jsa/OL23ZL8kS3dPgD7X9GiZcaaSPCIzSOZ+IG+fBoAbbJETt8MetWPhEktR2cBR
	qmtEtag==
X-Received: from pfbml25.prod.google.com ([2002:a05:6a00:3d99:b0:82f:a2bb:a7cf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a1b:b0:81e:f1c3:89df
 with SMTP id d2e1a72fcca58-83f33de1258mr1079104b3a.50.1778792717758; Thu, 14
 May 2026 14:05:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:53 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-14-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 13/20] x86/vmx: Initialize test stage in
 SIPI test *before* launching AP thread
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

From: Mathias Krause <minipli@grsecurity.net>

Initialize the VMX test stage in the SIPI test *before* spawning the AP
thread, as setting the stage after waking the AP can result in the BSP's
write of '0' clobbering the AP's write of '1', ultimately causing the test
to hang because the BSP thinks the AP hasn't yet entered guest mode.

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
[sean: write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/vmx_tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index effd0c59..6161f451 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -10285,11 +10285,11 @@ static void vmx_sipi_signal_test(void)
 	/* update CR3 on AP */
 	on_cpu(1, update_cr3, (void *)read_cr3());
 
+	vmx_set_test_stage(0);
+
 	/* start AP */
 	on_cpu_async(1, sipi_test_ap_thread, NULL);
 
-	vmx_set_test_stage(0);
-
 	/* BSP enter guest */
 	enter_guest();
 }
-- 
2.54.0.563.g4f69b47b94-goog

