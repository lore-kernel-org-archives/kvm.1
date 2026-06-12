Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52D93DBD54
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305288; cv=none; b=ov1039pNJar08bDou9bfHur9SRmN3hlNKNcG5YudWz5+hlG5e1f2KRTf054tiIQ3Fua9EGVtTam8McZWJmnt5VGaE6Owc9/o5kKQLcvnnVKj3oRowuuT8FivsHKHOW3LvKlCDtLxcF9S27O3Ww2wjb4CP0yNS90KjnnjiaNdXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305288; c=relaxed/simple;
	bh=Q9K77eGGM9I2REDPfv9K19X6pSTVgczobVG8OpBUsRg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mRXB8TLouU1/q/yUj0QZr+60oaGsM3TRzEf6ZmT+T8tOp1c9D5YRldIyU19djykPOVZzpKfLYbLOzIB2Le7X8wELc5bJgZUdE/M29AA0Ogr6t0NxsQnpcvrkEQRK+5L/Y65nviC/egUoyBiCI71nEbSfnE+mdhhYZzx46XliPns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WeeUKPF4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WeeUKPF4"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8421ffff8a3so1852288b3a.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305286; x=1781910086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja0tTQOFI084wPpYUPnA/DY+w7ijThIGwQwj3331wkc=;
        b=WeeUKPF4iEPtl1nedMsHrr/cgDm8S8t3vTTE4HoMjYYhzwO3lgi+XuwrGMeMJXeizW
         FoT7FL0LJHxpmK0zmdz6Sv5f993JIlPpHmwPa0cvvXDmoTBG8wF035Ub9x1tj51BYxF5
         eMqqJzQ63xOLF/FEtHjexjnZ6WigufT94/sUhBgZ8DXVcKHFDXdbENBHww6CElHAv05Q
         eQ0waNcLYutE71lSSZaTVjd9FNPZDif5OCDcbBu78PXkk9mEHkn0/iEfoqP/Gp4B8sr/
         FwGlZpsTiCB7zSahenxivs43eFpPgZEShNuQU6FuwbTv6sb/GzRpAuKCiSg0/TPoNBbB
         JjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305286; x=1781910086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ja0tTQOFI084wPpYUPnA/DY+w7ijThIGwQwj3331wkc=;
        b=oBPrgHv6LFgvX3W/cgJuhf3OgQ8pCsGpKVoJAw6PDpbR3rG54CPDbJst444gy0+zMj
         gurAuKKNLjccl1j+0PaOwrG1Ugi2012CXbNMnA/EAQD+GNzJoZsbLp2JksK/zNjcBPJT
         ZRcwWyxjODbFYc1l4UlsyI9n0Arifb6Mrzt5Ca6W0UBXi4e73DXLoloBePURitTmqMRF
         ml2XApV8txogqI0+j1ck8gr62zsBKxlAuRdPvQ2IaW43PDW++T1uwrqSdh+Gn+/2Gck7
         aAiZsyMJQUt5Xl+TIGj1g5nEQd+im4nuepbzPMdc+zo7rL9b1b61JEd1+7GoUXZ+Gnph
         sJ5Q==
X-Gm-Message-State: AOJu0Yys/5ZrR/jF+q6a1FmEVRGcOyswF4OjZkRqVCyu8Zx7NHuHIopx
	fShfnZr/lM6wJdeiwuKYGzQEIuUZdgWADo+z2oOgAMsN1S7FNIwbKUdtoWdofGWNkuXgT2P3kkm
	SAMxgjw==
X-Received: from pfbgj12.prod.google.com ([2002:a05:6a00:840c:b0:842:55c7:d8dc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:130f:b0:837:e9cc:d474
 with SMTP id d2e1a72fcca58-8434cc156d6mr5104109b3a.2.1781305286124; Fri, 12
 Jun 2026 16:01:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:01:12 -0700
In-Reply-To: <20260612230113.684301-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230113.684301-8-seanjc@google.com>
Subject: [PATCH v3 7/8] KVM: x86: WARN if MOV DR emulation hits a "too late" #GP
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>, "Maciej W . Rozycki" <macro@orcam.me.uk>
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
index b1799ed01939..e030ef9b9744 100644
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
2.54.0.1136.gdb2ca164c4-goog

