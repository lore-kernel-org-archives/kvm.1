Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C0C3D9DD3
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305284; cv=none; b=frmFuZbUh0AwEGZHIzIwq0PuN0TqL0GajKdZ+mpgJHgzvWAR9++9RswE4buyYOA5hpOilm4BsEDmOufNiVpMJMRc9MHKn9eWcGrmiD7DZzsIPbTAs22fzTUWig5IjrkvIWbDAItxOe7hhEHPQ9TxToFp18AT843qmjAp70pzE+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305284; c=relaxed/simple;
	bh=jET3zGBXVLORsA5nK427IY1DdxvIcOt1VLC3QzIyoYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nY83C0lKTnpDd/Q9v7gy/dhGSFvjNiP0hxpN5BSyrCEyAnIb/Fkgxnv7TEdaOk02FD31/M8JhjmR9teQoNhF3XKf14r6J1ZU6G0KN8mZ1Cmfh03RGooUJg9QK1SDSQWT+j5ICznLob1yfefd7VHey+dXVy+gfVMQN/m0Nkq6wk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vML8+ELN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vML8+ELN"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bd4146cb2so1621733a91.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305282; x=1781910082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nbzwg2ugE7/ZKE9vn/vv5nJiHWHiLa6SVdUeBOOXYY4=;
        b=vML8+ELNbCCoGWIxjYohM/NB9MkjSdydiYNb2qXChc9EVD94z8cxHud8LagoUtSWdF
         e8Tf7kbO/SLszckymKHBj6KY40ZcjRaHibQsh2t3uLw0sfOHLgbEQZa7fLgLQeojNopA
         YX0fc3faU/tcI8mwjwq6QXaWyGezVq/J8ICbjxRvOQBSPzkE0U2BzLNPCLrCIIreZ1hY
         ss3P1DypTn5xLA2JL08CZde3vx+L5UnHOl2YPp0gGIIcyfQpGoaSfeTUqMV0Lzngb5l3
         06iEynGcFwHWHsd1ImfQ8RaPWAElu1c+pn9onUWZIK979sRWqsep5n5Ji+N2VbVuW2Bs
         lVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305282; x=1781910082;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbzwg2ugE7/ZKE9vn/vv5nJiHWHiLa6SVdUeBOOXYY4=;
        b=H1chOxCUxyoU8Mx01E/GHYLOE8adDTzjZbJv7wutYXnMPW7oAKUC+oMWmthOncVORV
         OBNmBlfac7Bt2qEFkkZQ/wH/8vyaBh43rDR3+DaSmY3dMZwDsZhrwKpMjR0UqtfiyO2x
         sPlCCspEL8h1nASeB7TakGoBJqrcch0UyNEpJqohFKVbUQkKn9WIvi1lgwMRkpUM4v8d
         3fIFkJWzVRdKJ8N+dgSZ16o2H4Bws2Lj+zRr5yqnLZAZKDim+EPJKY+SIkq3fzGu9nfM
         naJ8P4c/YKsa7SkvCbKn04G4BqDlkYWpFJuk1pKAfFnJKU5alvPbLKWezByL0Ax1VfGm
         jtMg==
X-Gm-Message-State: AOJu0YzE60s4CDBc3Onc/dmrNJkZqw+hnGEjtbG8qiyhoq2Ls2IsLSxg
	w/6HKjjOiScaGDYCTZvLJ6cBUeVicHRaurNQpfETUHg3CRwxF8Xm0abc2DkfaENCerVyn4wWsei
	NMbjcXg==
X-Received: from pjbmi16.prod.google.com ([2002:a17:90b:4b50:b0:374:e2b3:6e25])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5824:b0:36d:c138:e0a0
 with SMTP id 98e67ed59e1d1-37a1d730d23mr3367959a91.2.1781305282041; Fri, 12
 Jun 2026 16:01:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:01:09 -0700
In-Reply-To: <20260612230113.684301-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230113.684301-5-seanjc@google.com>
Subject: [PATCH v3 4/8] KVM: x86: Prioritize #UD on MOV DR over #GP due to
 non-zero CPL
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>, "Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"

Manually handle the CPL check for MOV DR instructions instead of using the
Priv flag, *after* checking for #UD scenarios, as #GP due to CPL>0 has
lower priority than all #UDs.

Fixes: 1e470be5a108 ("KVM: x86 emulator: fix mov dr to inject #UD when needed.")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index a1bccab0eefe..127a21eeef66 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3844,6 +3844,9 @@ static int check_dr_read(struct x86_emulate_ctxt *ctxt)
 	if ((cr4 & X86_CR4_DE) && (dr == 4 || dr == 5))
 		return emulate_ud(ctxt);
 
+	if (ctxt->ops->cpl(ctxt))
+		return emulate_gp(ctxt, 0);
+
 	if (ctxt->ops->get_effective_dr7(ctxt) & DR7_GD)
 		return emulate_db(ctxt, DR6_BD);
 
@@ -4380,11 +4383,10 @@ static const struct opcode twobyte_table[256] = {
 	D(ImplicitOps | ModRM | SrcMem | NoAccess), /* NOP + 7 * reserved NOP */
 	/* 0x20 - 0x2F */
 	DIP(ModRM | DstMem | Priv | Op3264 | NoMod, cr_read, check_cr_access),
-	DIP(ModRM | DstMem | Priv | Op3264 | NoMod, dr_read, check_dr_read),
+	DIP(ModRM | DstMem | Op3264 | NoMod, dr_read, check_dr_read),
 	IIP(ModRM | SrcMem | Priv | Op3264 | NoMod, em_cr_write, cr_write,
 						check_cr_access),
-	IIP(ModRM | SrcMem | Priv | Op3264 | NoMod, em_dr_write, dr_write,
-						check_dr_write),
+	IIP(ModRM | SrcMem | Op3264 | NoMod, em_dr_write, dr_write, check_dr_write),
 	N, N, N, N,
 	GP(ModRM | DstReg | SrcMem | Mov | Sse | Avx, &pfx_0f_28_0f_29),
 	GP(ModRM | DstMem | SrcReg | Mov | Sse | Avx, &pfx_0f_28_0f_29),
-- 
2.54.0.1136.gdb2ca164c4-goog

