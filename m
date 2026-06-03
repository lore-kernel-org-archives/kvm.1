Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E494DD6C9
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528046; cv=none; b=i6kSozAj/9wf8KG4ai2LqPTpbvGQYFvZFF58+4XoV6uSgkQ7VYsakdBV7baOc2jIl+5mjmUCE/hNiutUyyZarwrinVLHCDa6v4PqzGXYU8O301s3iCPt5DkwB+uwS69mSS/pnaiG6vE6jGVXf7TXNp+3mwOcV0M/8xPwuBXNsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528046; c=relaxed/simple;
	bh=bHzLLdTCb+VxVJ3+VJQO4wCCyjKFKuVLfk1jhmZ+WeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bjKOniL8dmX+ZJ0NixBV14tcDSoqIiU4ydWx4i7LSLB5ZvcLKgB6n4Phv1GqWtXzfSnesNpZjfsMV/PDV8dq6aCMy63mlnCBOAtqZtvGvdY8SI7TSD4itTj7TRkrU2aw6N1ItiSM8IdCPUT8gobYN0NK0aUNpO3EVa4Tz5h+bHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F1fkQDwv; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1fkQDwv"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f3e4728so40835b3a.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 16:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780528044; x=1781132844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ezUSvHHU0F8Pd5Mai5Tb6QADKDnvgIyBgfFvIrwmlEA=;
        b=F1fkQDwvgni1nRcXY01pgS5FW2pKlXNgkoqvsBQXGjYeWSXNp9eiMYK6XBErzuCdFg
         9ROcn7+SYnRln01LMMaIHWLyuYjPUc0IbnlZkH5Ar8vl2ojhb7gnkiP9HMJdgT53R7IH
         NeZYf99w5IdYPENReokxvI6f/LuxD6DDlMz2KN0ZtzdRKICPzONBNyhxGCiKTGmEqjoo
         qGLeKlCL/YdwZo93gp1sDs4pYeNZl1spBhEulI+vL0WqwXePuMlQB8zsP7JyXkg1XuLT
         GiN+DRMWkgwUHM+ofILkm0ZLLVjv/4xfQzyejBTY2q/LMvSrZgtlkpj6Km0UiLHSS2UP
         nIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528044; x=1781132844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezUSvHHU0F8Pd5Mai5Tb6QADKDnvgIyBgfFvIrwmlEA=;
        b=PQbirNVHbp9griyPwbH/FAylDIPbKnFOKXjIxpSbz3fRfMpSxR/eGl3LGMI4pXp/As
         ICqnmLs12VV8u0CHT/Y0S5jbeeorUiDIyRYMiyg2HQcaZBMaWnQI2CE6ZGlWZWxP1x/m
         56ouCFquta3SX47VsNarZMPF44qslOhaVBZssthS7WpeHmk1JVcRGULYc1nw30MqA6fF
         8UgYYTQ6G+P3nw3bjQw2rBQ9tMPWSOmYcZPmvcJrGLPGHTwzDgUDWG0Bt2elrjkp+ZyA
         CBIn5LG8zpW6bYvAE4e4TbZCb/lz8W0elBFO1r06c946NQMcqod7PGhlBIdWgg0gMgJE
         eXxQ==
X-Gm-Message-State: AOJu0YytXYsIRCYxSNM/Ca5F4A2sct/3Kh+5+06wsIYb/QGUREEESzHm
	uYj8r7ZRo6ZZMfJzSON5ZAG/DiSUY3BC04oKgVMb+Z/kWe4CwrsFRO0dG0S8R6dZL0wuWuqZWeM
	mvhN9zw==
X-Received: from pfble1.prod.google.com ([2002:a05:6a00:4fc1:b0:842:3fef:b24d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:338e:b0:842:6c02:2fa1
 with SMTP id d2e1a72fcca58-84284f34cc8mr5211256b3a.39.1780528044287; Wed, 03
 Jun 2026 16:07:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  3 Jun 2026 16:07:16 -0700
In-Reply-To: <20260603230718.1733483-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603230718.1733483-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260603230718.1733483-5-seanjc@google.com>
Subject: [PATCH v2 4/6] KVM: x86: Use kvm_dr{6,7}_valid() to check DR{4,5,6,7}
 write values in emulator
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Use kvm_dr{6,7}_valid() to validate the incoming DR{4,5,6,7} value in the
emulator instead of open coding an equivalent check.  In the unlikely event
that the behavior of DR6/7 (and their aliases) changes in the future, using
common helpers will hopefully make it less likely the emulator logic will
be overlooked.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index a1bccab0eefe..1df2dcfd8bef 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3861,10 +3861,13 @@ static int check_dr_write(struct x86_emulate_ctxt *ctxt)
 
 	switch (ctxt->modrm_reg) {
 	case 4:
-	case 5:
 	case 6:
+		if (!kvm_dr6_valid(new_val))
+			return emulate_gp(ctxt, 0);
+		break;
+	case 5:
 	case 7:
-		if (new_val & 0xffffffff00000000ULL)
+		if (!kvm_dr7_valid(new_val))
 			return emulate_gp(ctxt, 0);
 		break;
 	default:
-- 
2.54.0.1032.g2f8565e1d1-goog

