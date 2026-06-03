Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4DA4DC53A
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528046; cv=none; b=Eb7NeB/69Jg5DcAYQoVJTsngKUaAjjJMpMGWn3few9XQLT2TCyIROq5mA+zun4m8OXAnTAzfoaBlM1jniInH0dJS/sfp9lRHqXslLKtPykgJnG2+JBkFcgQRUxdvuV/OhaSfSCl8X0Lvu+cAgh9Je73U8j2CL4d87Cj9OhP/AQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528046; c=relaxed/simple;
	bh=zvLZFUC8kt5SYBz7pPfHBF6oXjTl1YD9FgGc8bCW94g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=igmvfnJizZfCXluesZZrcmQBNeI0pdNyLCg15OKpKSrR6xZIRDhU/4KkIDb05GfO8ZdmdHR7fdhaBO7wSEkiDeSg6IR+E+b4tGS3bYpcjC9y/B/Y6JdIFGv7jdfLUnkT+hiBd8Pw0wAdyUKgZCbWe05BV5g/uXWrZ6uhskJnLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TuksNok4; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TuksNok4"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c36f1cc0so1589485ad.3
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 16:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780528043; x=1781132843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=J9jXkbLbsiQYLu/uZAeAeFQEm+TiK4gDJq2dRu+/ibQ=;
        b=TuksNok4JVdeY3MpGUb4579U+Brv5hK/Ue0M+wQBQefDQJSGxV4k4ztYSxru2Qf0Qd
         fN7tbdRd3YpTTCtUzllkLt2qDO7dQ/9AMfknAdAdyAdBhw1pmKwQA5XXBWRFgivkUo9y
         uWx6EzBvsF8fZ6QWlpvYfn+OFJ/uMmxuWfquitKaKm0OisaAMYeYTeY8fLPcyW7td6+f
         QSBMKwEl/G5a2qGske4xBaWDcS1lWk/9e3n+INv8/tmtqaB6N3uy0H1eOkzg0pPG09ZP
         J/W2hsr2x9MrgewRbBhdImD52USdE0lJXwMZuYIhyG1zwGSGCNFb2CYP6CztdY//6nn3
         Iciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528043; x=1781132843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9jXkbLbsiQYLu/uZAeAeFQEm+TiK4gDJq2dRu+/ibQ=;
        b=TSo+z+gFgs4/MklUG0T9pxbzva43fZ9uZUHkgfIyYo0v8B4xIsmwSGxtKZcoYiNxLg
         6FPT3yDyL3tXr9gDIUJlqwuCxeWHvA0/QEngBbIYzVsXD2TqnjfKuxT7W08SOGjThsl3
         n8KQQOXGONBehIgjHqV63Xot4+pfhZbSatMCqKU02kcUSMeauako+mg3JZz/uEKYaXoO
         weMH0aWY4/0cYFw3Eq4C3UFnPdriFSYVUKm6+mS/1Kj2hS3+2cQkd/RHwadJ0gc/Pcim
         cSHfkNby1NGcMpNrVTlwTnK0KBJH07m2udjQieHRXteI08kksg8OUhjY6QE/NWTl7p3s
         mlJA==
X-Gm-Message-State: AOJu0YxPeVWpN6l6EjH/fSHBnWoGgDbqt1EMnD1tV78kYG83AmGm1KcN
	h5enKejBylfHZnSrE7wBiHGLfZPs3h5PBSXgjPMC+LHfhLkh78yhN5t05HxuiZSbs3JeqXzaMLf
	J9QPqCw==
X-Received: from plble15.prod.google.com ([2002:a17:902:fb0f:b0:2ba:39b8:446f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:234c:b0:2bc:eea4:83c3
 with SMTP id d9443c01a7336-2c163fa4889mr55162265ad.25.1780528043207; Wed, 03
 Jun 2026 16:07:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  3 Jun 2026 16:07:15 -0700
In-Reply-To: <20260603230718.1733483-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603230718.1733483-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260603230718.1733483-4-seanjc@google.com>
Subject: [PATCH v2 3/6] KVM: x86: Manually check DR4/5 write values to fix SVM
 intercept priority
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Manually (pre)check the values being written to DR4/5, i.e. the DR6/DR7
aliases, instead of relying on ->set_dr() => kvm_set_dr() to signal a #GP.
SVM unfortunately prioritizes all exceptions over an instruction intercept,
i.e. nSVM is relying on the emulator to perform *all* exception checks
prior to attempting to execute the instruction.

Fixes: 3b88e41a4134 ("KVM: SVM: Add intercept check for accessing dr registers")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 4484c5fa19e3..a1bccab0eefe 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3853,15 +3853,23 @@ static int check_dr_read(struct x86_emulate_ctxt *ctxt)
 static int check_dr_write(struct x86_emulate_ctxt *ctxt)
 {
 	u64 new_val = ctxt->src.val64;
-	int dr = ctxt->modrm_reg;
 	int rc;
 
 	rc = check_dr_read(ctxt);
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
 
-	if ((dr == 6 || dr == 7) && (new_val & 0xffffffff00000000ULL))
-		return emulate_gp(ctxt, 0);
+	switch (ctxt->modrm_reg) {
+	case 4:
+	case 5:
+	case 6:
+	case 7:
+		if (new_val & 0xffffffff00000000ULL)
+			return emulate_gp(ctxt, 0);
+		break;
+	default:
+		break;
+	}
 
 	return X86EMUL_CONTINUE;
 }
-- 
2.54.0.1032.g2f8565e1d1-goog

