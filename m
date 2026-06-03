Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFAA4DC53A
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528049; cv=none; b=L0qAB4Za894DZehz9WPmb6hx105Ll+o9r62z0vHtH6Wx1adTKk5krdi2sv64jgNA4/1FQxUGLvOS31MQP6xveW/RmAgj999Xw9LDLQpdQHA3I3YDX+V3zzGN/GwQNOoKzUZ9BGNbmajofsE+L0oVWLvOqfSjWDF0WFg/MHaZQqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528049; c=relaxed/simple;
	bh=vW6gSYA+oMIUIQfwRW1Y1GrCC7Xco5j6nUS8uh9xrCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kl31/DT1CHzD4GLUmcFVyi4qpNNJ7ghRTOIIV1cFF6nSClaW4HeGLH1+mTOtyUbYf2J8YzZA9OMmLX/Hl8q3lw8R5mNuLVcwx1TwizZnqbzhUdnW7zR+jVpuamFOQKGbDanrPiwKbdHa7oOR2OQstVPKyKVd5TLspFQcMrRzWvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPmh9cv8; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPmh9cv8"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8421ffff8a3so91086b3a.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 16:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780528046; x=1781132846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HOX7z9JeCTK9tuG7QRy/Qa4sL7QBPJNUR6KV6hg+L9Q=;
        b=LPmh9cv8px6mo2aZ6mJ25rVaeJoYoTpWak+VVRaUXJlA8hVwPqZNhwlPvahkGmCXw9
         b96sDuTx5Bk12EYkoQDGyokDcWRg8W5WrkRtU92lp0S5CiJVuR15czoOEQtA1Lflwpbm
         cGE8/27yKJtZIrYlXHKJOk1MdDjBOq9ZyUUTRWuI5WLcmtpdwXF6KbJbtAFFOLUXpa28
         2iUaDiK2JhFhBVQBOHNCvJzv+RhUdM6+pQPmuu0TRrmV+KGLKXy00emw0sZpuHxXMIV2
         iMkpLej+TylEVzfw4crUJdjjE0co95DYUt43Wrs8CV7ilsFpP1uJo7MLZ4PRAcUkYbFY
         QeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528046; x=1781132846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOX7z9JeCTK9tuG7QRy/Qa4sL7QBPJNUR6KV6hg+L9Q=;
        b=I/axynU5ZxPaQ0Blbxz+KWmh1eBVvAABvanAYFCRkHgYugAXoeAGb8T8RuQVQOtgq+
         q4MBA1AivgU6ucBY3+v0wXFYGBqwKikftv4KSHJLHGtAzYn/typWOJdt7gNpWenLkmXp
         6KCR3HdUvQ4YJZYfVOkBJKQM0gkcJ+X5KzF2l1xXukNV2jwgKGSjdCA3o/3IZBNzrWAO
         f57DGJWXs3ayVbeKF0pYgpXiaKN0IArrL48X0XSFTCiNjeqaM+2u8B65TEAHt965uLR1
         DtkLKdT89JlmOqjw5pI2439dggsKyXFOkOVjB22/5HkWb+mlYjXTxgl1v9PlFmMruqh/
         /LpA==
X-Gm-Message-State: AOJu0YxSxqwQYgmnS9ebO9uj48aNCUhA2CotAwOG1gqEFzOvzQN5Pzg8
	n81E1Koxj9S++PmYPIED9mm60YxURDvLALgxc0eOfNsb1Vhu9l+ec8d3mfsd3DH5rieABTlnMTy
	XbdD10A==
X-Received: from pfbky41.prod.google.com ([2002:a05:6a00:6f69:b0:842:2fb8:da49])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1151:b0:842:4982:81c
 with SMTP id d2e1a72fcca58-84284dc5d61mr5453584b3a.20.1780528045396; Wed, 03
 Jun 2026 16:07:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  3 Jun 2026 16:07:17 -0700
In-Reply-To: <20260603230718.1733483-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603230718.1733483-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260603230718.1733483-6-seanjc@google.com>
Subject: [PATCH v2 5/6] KVM: x86: WARN if MOV DR emulation hits a "too late" #GP
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

WARN if ->set_dr() => kvm_set_dr() fails when emulating a MOV DR write,
as the emulator _must_ pre-check for #GPs in order to get the event
priority right when emulating MOV DR for L2 on SVM (all exceptions have
higher priority than the instruction intercept).

Opportunistically update the comment as the blurb about "#UD" being
checked is incomplete and misleading.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 1df2dcfd8bef..9d345ad25ac0 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3298,8 +3298,12 @@ static int em_dr_write(struct x86_emulate_ctxt *ctxt)
 	else
 		val = ctxt->src.val & ~0U;
 
-	/* #UD condition is already handled. */
-	if (ctxt->ops->set_dr(ctxt, ctxt->modrm_reg, val))
+	/*
+	 * A #GP due to an illegal value should be impossible at this point, as
+	 * such #GPs have priority over MOV DR intercepts on SVM, i.e. KVM must
+	 * manually check the value *before* emulating the write.
+	 */
+	if (WARN_ON_ONCE(ctxt->ops->set_dr(ctxt, ctxt->modrm_reg, val)))
 		return emulate_gp(ctxt, 0);
 
 	/* Disable writeback. */
-- 
2.54.0.1032.g2f8565e1d1-goog

