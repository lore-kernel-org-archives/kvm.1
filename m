Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD054DC559
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528050; cv=none; b=fw5PwS/KNoNZENQ+djFmV+PiWsVfMEa1077iJV82VVkprP19zBq94I0icbbmEV2orIC113TcXFA7bauPJeKKIigaynqrfKnpyupKB24IY61h2OOi8mz/byPLNd1nvuYcQwsglzufcND05F2yQ4TrX7P7TY2vE1MVArU3T0mljGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528050; c=relaxed/simple;
	bh=ijOJa1YRccXO777/NADb2uI8tRHYflIo1wWvnI4VMLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nuDPy9pztwb/UpBNFIe0hhgIZNM/qmQ849talWoNp978mahWI/9hMEHT1Zo91umpHwIdk3LaK7udQdXKzUK/npHwIybJX0IlPABwWUqy6tZV7X3ovRKaadgjkWf+9r7TWXV4OG4BbVKNzIFkj4NDHj6M8SfNc6GLlHd2c/sL+Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QJXh2lJz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJXh2lJz"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8582b167f7so46589a12.0
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 16:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780528047; x=1781132847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Sg1wkBN1TKAiYwuao6GiE5gx1mbV1smbgcHOfPXa7ng=;
        b=QJXh2lJzhM6w2z9RyymAhZujjgq8+55Qwd2fCYMdlJjuGrjDXFEQ7InUKbqQOya3kH
         OlwCWHKEJgy1CNZEpqRO8UCMCLuLzyuf4sloohZ8fWOFxZocXQkoaS5MgGXzPZixt4M0
         C8Dd4bm9mru71IvM3LXpnwZoa6beXwqZFSDrvZSopws8f2yDnbmorI1bFGV5b1OUhyVm
         YdGKUoN1jbdzd78hr5XwQCl0LFyC98STjh1OA+Gdo044t0hNQXpvfqqQtbn0misjv5Nf
         PvvT47jLqGkhCbqdU3sACM70RCbo7V4TwH0/cORoASE7A73vsnImbIO2axruoTJD4kU7
         jxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528047; x=1781132847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sg1wkBN1TKAiYwuao6GiE5gx1mbV1smbgcHOfPXa7ng=;
        b=gThKl/GH5PVyxOWUnNRJ5YpvPHyvgfV06ZKnUJ6dsPkrXmV7UOm4jXPSDiF5rmECmp
         EbG61Jk9GjfnOKaDiajvxXBEVAfMi1LWeQhPzqNO7jl0HrrDYNpsmcsVxJZpinx3Bhq1
         zkWFHD73Ve2UNDlYPRg/SllUQa9t6H0OrZR5d18AtfRIXxgTddAAGHFASet0n4uo8ZmF
         d4Cs+t+wbwpD0It2L0R8Dxdva9FfWtriiPIvw2AMl2iNVG217HIcr+u2fKWfgIRiERcX
         6+ujUx0GOoyxvLyAni3NLNCmX/YCR4LNc8IIxfrAWzimEHo+Okp3w6e2RQOCfWDi00KN
         AMjg==
X-Gm-Message-State: AOJu0YyFrJ0kzN7iec/NfudWZ51lZIsSajdV/4/y9EaZ5bOb4ZU1jKVB
	ihwCiGfefnUS6SYMy9NXlFuErT9pPIHGSv1pSuQJl9UZ/inVGPKImMC6TL/3xhBafjJFsZzTFEh
	EbHSu/g==
X-Received: from pggh22.prod.google.com ([2002:a63:c016:0:b0:c80:26d4:20ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a95:b0:3b4:904f:c9cd
 with SMTP id adf61e73a8af0-3b4976a6b12mr5867976637.6.1780528046564; Wed, 03
 Jun 2026 16:07:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  3 Jun 2026 16:07:18 -0700
In-Reply-To: <20260603230718.1733483-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603230718.1733483-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260603230718.1733483-7-seanjc@google.com>
Subject: [PATCH v2 6/6] KVM: x86: Read CR4.DE in emulator if and only if
 accessing DR4 or DR5
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Micro-optimize emulation of MOV DR instructions by checking CR4.DE if and
only if DR4 or DR5 is being accessed.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 9d345ad25ac0..37f3cee4358b 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3839,13 +3839,11 @@ static int check_cr_access(struct x86_emulate_ctxt *ctxt)
 static int check_dr_read(struct x86_emulate_ctxt *ctxt)
 {
 	int dr = ctxt->modrm_reg;
-	u64 cr4;
 
 	if (dr > 7)
 		return emulate_ud(ctxt);
 
-	cr4 = ctxt->ops->get_cr(ctxt, 4);
-	if ((cr4 & X86_CR4_DE) && (dr == 4 || dr == 5))
+	if ((dr == 4 || dr == 5) && (ctxt->ops->get_cr(ctxt, 4) & X86_CR4_DE))
 		return emulate_ud(ctxt);
 
 	if (ctxt->ops->get_effective_dr7(ctxt) & DR7_GD)
-- 
2.54.0.1032.g2f8565e1d1-goog

