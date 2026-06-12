Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625403D4101
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305281; cv=none; b=nQxrFlefPm94aj3akK529ODqHtq45BkYYyqN1ITSFB6+6Rw+h8mjacSetFutCt3FF6/niDmh4tSfLtW2bJofwDN9EdzhGXxHe2f0k5Cv3n161caHwnE8ZuELujQ/Ucg8i4WijNj5QxAqdwqk1p368x4zXaIcmygg/XtoiRDD+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305281; c=relaxed/simple;
	bh=cybvwvgY+Yi8QNGD3X/tR04j2hTF1orrUAg6FqXA/uA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MTpqa2qu1RXkUSZh97eso4v1vKFW0R8b3wk9ReO3Xj9DUCJtg9sUJIN8AKvMpvpGw24woXN8mLSoz9lJ+DtrSBUGIf/5IqygG8kSzNyjKLcOttZZMmvMVUB5hYGzr1EGtGyksBEznBJX+MNEvXNEmjXMTBj0207WuTu9Bl62z9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1irmx94; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1irmx94"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf243973c2so10112905ad.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305279; x=1781910079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCzD9DkTttsLEENWkse0eT0ucq+Hmp31Avye2/c+A8M=;
        b=G1irmx94XnRIRb4xdfOhakT1BDTYnpiuMsv6rIsycRW2uSNsPgDnbDXgS39oEvw7Xx
         58FGLe5hE8M6U62Ji17IfR0qGrxb7QjYECLlGb/T2xzWBX465F58TBR+5OfHpj8YiveL
         jAG6WqCnsvFcS3INhNYilsRaGacbQWza5sv0YeHK9CIL4QcYShI7QP+HjCtxIbROExb3
         trZ0eO0Xu1FyT73numD+zogtg1cf5GZTp+kg8WBTwSCZfEAfQnbvQKQIb4rxTmCDX8dZ
         1A9AmiooilbXE92nr2rj4WSiuecaPcOr4W2a2Nl95X5paWvioMkV1GMzTg1WK+2Muzhw
         rIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305279; x=1781910079;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sCzD9DkTttsLEENWkse0eT0ucq+Hmp31Avye2/c+A8M=;
        b=stcNzQFcQmYLhWEWdG+eHXvRzu0Q0taxHHSa6H+GFNDgGAyhIyDa8/xrFv9AABU+ZP
         8V67FndBFPrB48Viz91kz2ABGz2UtK2+YfyvWLxHMQht0MO1UBkWhULDYLQUvbKlicLN
         pQiUo2fgO7OZI8l2V8d5vds2phRmTHQ8n4C6aJ+Xirtb+M761RmAYFvfjSusrIuMiETz
         jTaqQ2LKulytDu57zkK/KnZeh35n2ij5tfQxEaRaODixOE5jZJaw/elWby446Fl62xmv
         outgQmRy7zGJYJunRiXDHav1tOG2zxXe1wcaMd33U8eKfajYg3y4jkM0POO8cnSncDNA
         oNbg==
X-Gm-Message-State: AOJu0YzTOftuJpxMXhSWblxUo1kycsdCbbWEClHP921YX0lJ+8RbZq8U
	doIqg6sGRHYtjs56lXl6N44fVAz/7KxZK8nfrKO/Iwsp0wFRepOW7Bs2dFeo1NWfBQpBA025Ygt
	dWjFBDA==
X-Received: from plkb11.prod.google.com ([2002:a17:903:fab:b0:2bf:190f:f93e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccc8:b0:2c6:6424:c79f
 with SMTP id d9443c01a7336-2c66424cc24mr17748175ad.8.1781305278421; Fri, 12
 Jun 2026 16:01:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:01:06 -0700
In-Reply-To: <20260612230113.684301-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230113.684301-2-seanjc@google.com>
Subject: [PATCH v3 1/8] KVM: x86: Treat any non-zero return from set_dr() as a
 faulting condition
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>, "Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Carlos L=C3=B3pez <clopez@suse.de>

When emulating a MOV to a debug register, em_dr_write() calls
@ctxt->ops->set_dr(), which is forwarded to emulator_set_dr() and
then kvm_set_dr(). The latter checks that the written value is valid,
otherwise returning an error, in which case the emulator is supposed to
inject a #GP fault into the guest.

Commit 996ff5429e98 ("KVM: x86: move kvm_inject_gp up from kvm_set_dr
to callers") changed the contract of kvm_set_dr() (and thus
emulator_set_dr()), returning 1 as an error instead of -1, but the
caller in em_dr_write() was never updated, checking only if the returned
value is negative. The end result is that em_dr_write() does not detect
the error, so an invalid write does not generate a #GP, but at the same
time the register value is not updated.

The practical impact is limited, as check_dr_write() already checks DR6
and DR7 manually. However, it misses DR4/DR5, which alias DR6/DR7 when
CR4.DE=3D0.

Fix the bug by treating any non-zero return from set_dr() as a reason to
inject #GP.

Note, the manual checks on DR6 and DR7 are flawed, as they incorrectly
prioritize the #GP over a DR7.GD=3D1 #DB (the General Detect #DB has
priority on both Intel and AMD).

Note #2, relying on ->set_dr() to detect #GP is also flawed as all
exceptions have higher priority than the instruction intercept on SVM,
i.e. the manual checks need to be extended to DR4 and DR5 (after the
priority bug is fixed).

Fixes: 996ff5429e98 ("KVM: x86: move kvm_inject_gp up from kvm_set_dr to ca=
llers")
Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
Link: https://patch.msgid.link/20260601133320.91479-2-clopez@suse.de
[sean: drop explicit "!=3D 0", massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index b566ab5c7515..75cd8b6136aa 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3299,7 +3299,7 @@ static int em_dr_write(struct x86_emulate_ctxt *ctxt)
 		val =3D ctxt->src.val & ~0U;
=20
 	/* #UD condition is already handled. */
-	if (ctxt->ops->set_dr(ctxt, ctxt->modrm_reg, val) < 0)
+	if (ctxt->ops->set_dr(ctxt, ctxt->modrm_reg, val))
 		return emulate_gp(ctxt, 0);
=20
 	/* Disable writeback. */
--=20
2.54.0.1136.gdb2ca164c4-goog

