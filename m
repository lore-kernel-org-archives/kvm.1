Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D697130DD1C
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778103318; cv=none; b=eClAA1XsLr4OwupTKJcRWWmaDu/ckgvMAgDNcle4lArybgM9lVBOoenm086UJD5A4yPStbakgN6nNByI3cr8MYakVZdP98JCcuY9DATOjb71dVvKXp4oOaUMB2NAr+2bh0kCP8B/LjfPUu19qmxbbCCwBsrYO36LeNbt2IEkxWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778103318; c=relaxed/simple;
	bh=mRYi9mrv9cJ/0m5kJMz2jJ6Ide70vERZrEr/M6NkFzc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bYojI/+4LyCZRL4aft2biCtrxPTvWv4kurjHDiwHzIpy1CKmNYOY6YLVttGeucWYD+ecHZp1nAnIx0txtsaIvGs+EWhKtbwMWetMUKgRJzjiZhZsD21KiMoqCuuHd7SxMf57J20repd5r0QH+wQ+xm8WG2vRkhHwVA7y84dKgD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpwzZKqG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpwzZKqG"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-365c5ca76fdso90254a91.2
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 14:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778103316; x=1778708116; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EepvVW/fxw9kc/G6WG51HwpIETRUCz4dkY8OYOWR/38=;
        b=OpwzZKqGIWmBVKnbhtilQ7vZegrjN2dB0zYiSG2K2k3pihiDX5Yl+kHtHpK0/jnsXm
         K8yRQofnsXtdIgFlb/5QUY+xxBTJkX5rImOxEQVQpc0Seclyd832Bq/+lRxNG3qbujvr
         3Kltf1ta1jLa+eBLpN9FxyEO2eoRgG98AhwePA0/mt4/MNKqAziveIhZ2Y9DKyp1qLsZ
         C5CvxeMy3dSDM01FEeZCTaxffCmjC0ZYQRvGY5p6EQl2Hh7jJPzeLk7NDVlgvKfBYDE5
         ueqUsxY7DWoeVepI3Xvs7WbN7zN+onhL4OvlgAtPcLmT3MtclHZg5r42pHDWw3k5NAl7
         2yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778103316; x=1778708116;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EepvVW/fxw9kc/G6WG51HwpIETRUCz4dkY8OYOWR/38=;
        b=a/5l5e9gWNy93zu5d9i6SjeVIxG3/Lqkm9thFMs6zyL+buRMxP09cUTXewKjSTqoi/
         baN8HXCZvFDQpTNPiQeIVf76dgC1nOOiwf1SxZb2FsqwIkUj2xu9jSnBZbquLxHiwjMJ
         VL8m6VevXcQEVIMEWOLoCAJkY7tgZ4KUp2ag+SmHmDjZJEHQHG9u2RLEtjk4pv/mtCs7
         E7D+zEeEXtxkFwqlo4GCyopD3vRpjJfIKHPAg0r4ZUqa6S+YSbFMF1kFUwhSxIbl8eYB
         FoPqPlEnIjFDPMnWu7skQ2P4BVHRGKWdTTH6PkjVxdq6m6z119DWYSCr6IoaRWPivVqJ
         hSKw==
X-Gm-Message-State: AOJu0YxdxjN5Tcuvgeho0J3faQ1dNSk44Osgu47PXV/1iuUlHuny6bPT
	r8ZJJJwxcjfXzvap8ZVLOQNZcB+kGs2+UUrve8VPiSFaCZwZFqTqPRrWhLWled9ak/JVdAFqO8L
	ngYktLg==
X-Received: from pgch29.prod.google.com ([2002:a05:6a02:509d:b0:c80:ca29:73c6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b12:b0:365:b93a:1ebf
 with SMTP id 98e67ed59e1d1-365b93a2061mr4136615a91.4.1778103316110; Wed, 06
 May 2026 14:35:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 May 2026 14:35:14 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506213514.2781948-1-seanjc@google.com>
Subject: [PATCH v2] KVM: x86: Swap the dst and src operand for MOVNTDQA
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josh Eads <josheads@google.com>
Content-Type: text/plain; charset="UTF-8"

Swap the MOVNTDQA operands, as MOVNTDQA does NOT in fact have "the same
characteristics as 0F E7 (MOVNTDQ)"; MOVNTDQA loads from memory and stores
to registers, while MOVNTDQ loads from registers and stores to memory.

Per the SDM:

 MOVNTDQ - Move packed integer values in xmm1 to m128 using non-temporal
           hint.

 MOVNTDQA - Move double quadword from m128 to xmm1 using non-temporal hint
            if WC memory type.

Reported-by: Josh Eads <josheads@google.com>
Fixes: c57d9bafbd0b ("KVM: x86: Add support for emulating MOVNTDQA")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v2: Suck less. [Josh]

v1: https://lore.kernel.org/all/20260506185510.2723091-1-seanjc@google.com

 arch/x86/kvm/emulate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c8c6cc0406d6..8013dccb3110 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -4481,7 +4481,7 @@ static const struct opcode opcode_map_0f_38[256] = {
 	X16(N), X16(N),
 	/* 0x20 - 0x2f */
 	X8(N),
-	X2(N), GP(SrcReg | DstMem | ModRM | Mov | Aligned, &pfx_0f_e7_0f_38_2a), N, N, N, N, N,
+	X2(N), GP(SrcMem | DstReg | ModRM | Mov | Aligned, &pfx_0f_e7_0f_38_2a), N, N, N, N, N,
 	/* 0x30 - 0x7f */
 	X16(N), X16(N), X16(N), X16(N), X16(N),
 	/* 0x80 - 0xef */

base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
-- 
2.54.0.545.g6539524ca2-goog

