Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD74A4DC540
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528044; cv=none; b=Ji4JELnbr8Rn0YB6bZWYlj3mxHDA/VTaF1GcdW3q1HmYs7fe8Gku17i3FWBf7BD9JlQmSEtfjznUqgfUcKQsnZPtqFUFYs0xqbON+b2/9n8jyT5b85xNllJoDGFngMCYIYYCq13IMeRRpZLdyMNbJYrG5ix2BwaLeQxXHy0TyrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528044; c=relaxed/simple;
	bh=PZ7XjrbH9m8+YOmUKJ0OBFcX3Uz+SJLiZmTymmSfvX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uq+DKWvI0MzWOU/yGgQhmOAR2nFz5I28KBp2+zkNILUDA8k8xd8bps/80pDSC+DZWslWGQWeG9k9BqJjDOO9FdoSeBHYhc3Anp3XVC20omt6MafEkIQ59zBVDEit8pVA/Kwldk7rrLvypsjEnQQBvZTjHnRRswy9AKwEhiK4AMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tIp4wPRk; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tIp4wPRk"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f24dcedso83194b3a.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 16:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780528042; x=1781132842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=WIw0X6vfjDVj5H1oM8jPHBHflGwYlG/paQQ4qHvt6so=;
        b=tIp4wPRkn+nh62PbRLjkM+leBwv2cardu1mLN3BRwbEb3IZcYhm6D0LU2nRUY71FKW
         CpGjti6cilt1naj3s4BKFSIyyFvZ5notyqkZDOXdm4mcxe+ehPWYV7UwT4YUfC0J7SQt
         JmNzZKi1MLeNY2zAHx0fIdF2XWWGMk22q2vHWmM4pCGLc2t1+RdLLBfBnks41U5E6Xg/
         VqQDAp/emGiSjpmGlSQe2vB4Ldlcx+xlt3u1XBncaHJHA23Em+NKCmfmTJGF/IH1XGg/
         4FKt/RLgVTSTCg3uoGSn667wB/xrs7wCApR2H8Zh1scCj1xsnGVUXLV/drvzWGHVSiMR
         sJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528042; x=1781132842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIw0X6vfjDVj5H1oM8jPHBHflGwYlG/paQQ4qHvt6so=;
        b=EAvl66r73PL/TCim+h+ZHg4WSq4UFgWfY3K5+MoRzktlRqvR+479kjum7tcQrKxfsq
         mJpBU0tzePxJzHVL9HYAwUP0syxdbpenNfSsr6uaXzZ7letY2zBYxl0PVSTRG3cOj5A5
         oqkZVCAFVfukPts8KEYcHdR4ThekqE7nRj+VXVW4bKrTE2p+NJ+F6Iebrgcr6cK1gS6D
         xx/DS7laYQrpUvZGC6orlVxamKjeRhC1m+X0IH+uiBHGw2eg/XM1iu8pImGhZGjWEzkS
         iSbDZqNM0ucggZdhp+kpXeDQj3A/zFkdY5Nzl38GejNd0oMLqWj6uCyeOzkNSqo0Df8V
         YLVw==
X-Gm-Message-State: AOJu0YwUL15Zm/+7uco0g8RBOUCKWBe+uVm05yp0D71r5VbIEFmsidpN
	Aex0nK86bCjbipp3SKNgIqKl/kGcJrO/srgt06ZQtIj3+mrf327Iuewrc4jDxFZiHwMfEaAHFpg
	RpveVdw==
X-Received: from pfbic3.prod.google.com ([2002:a05:6a00:8a03:b0:842:55c7:d8dc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a257:b0:842:4fdd:502e
 with SMTP id d2e1a72fcca58-84284f2ab82mr5207659b3a.48.1780528041992; Wed, 03
 Jun 2026 16:07:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  3 Jun 2026 16:07:14 -0700
In-Reply-To: <20260603230718.1733483-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603230718.1733483-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260603230718.1733483-3-seanjc@google.com>
Subject: [PATCH v2 2/6] KVM: x86: Prioritize DR7.GD #DB over #GP due to
 illegal DR6/7 value
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

When emulating a MOV DR, specifically a write to DR6 or DR7, treat a #DB
due to DR7.GD (General Detect) as higher priority than a #GP due to an
illegal value.  While neither Intel's SDM nor AMD's APM says anything
about the relative priority, empirical testing on Intel and AMD shows that
the #DB has higher priority.  And for VMX, where the instruction intercept
has priority over *all* exceptions, KVM already treats the #DB as having
higher priority.

Fixes: 3b88e41a4134 ("KVM: SVM: Add intercept check for accessing dr registers")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 75cd8b6136aa..4484c5fa19e3 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3854,11 +3854,16 @@ static int check_dr_write(struct x86_emulate_ctxt *ctxt)
 {
 	u64 new_val = ctxt->src.val64;
 	int dr = ctxt->modrm_reg;
+	int rc;
+
+	rc = check_dr_read(ctxt);
+	if (rc != X86EMUL_CONTINUE)
+		return rc;
 
 	if ((dr == 6 || dr == 7) && (new_val & 0xffffffff00000000ULL))
 		return emulate_gp(ctxt, 0);
 
-	return check_dr_read(ctxt);
+	return X86EMUL_CONTINUE;
 }
 
 static int check_svme(struct x86_emulate_ctxt *ctxt)
-- 
2.54.0.1032.g2f8565e1d1-goog

