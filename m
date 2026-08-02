Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1BC3B8111
	for <kvm@vger.kernel.org>; Sun,  2 Aug 2026 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785678296; cv=none; b=eb2QjDtuWCqhjGxk0ZqYDDnTrrdYT+THb/0L9v3SVyZfSm1oDQVaDso008YzXrV5rYxMW6VDfHtrc7HN4L113oGln2d0kC5kUIivBBPajlltIi4S8Y9wAf00WEouN2XSOaXWia57GvGTJUjACpyzFp+D+wYp3+dN0eEY52ZUrWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785678296; c=relaxed/simple;
	bh=ocNLif/0rlmf3UctRPXm5KVBq1hdZW3njDekld5qclc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XwiF6SHCu0HDczehnZYYw3vvkDPX6A8bSsLTx623d2v4Ws6+oGO6AtX1CZ1mdISP404DAzhstuQYon22afsmyBR3Dt9l+6Wg9c2hmvsbffQZTy2aVOF1Zc0BcSb1Z4rMrXORUfRqD09N4kTqm2wzDhJGkxo1dlb8BIFJ7zCulJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SATI3I82; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SATI3I82"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954c08a7c8so1760895e9.3
        for <kvm@vger.kernel.org>; Sun, 02 Aug 2026 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785678291; x=1786283091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gx+lrTmOnbSyTafGzP658UcqNuptTVpf6Q722e+7sx0=;
        b=SATI3I82IzJCctUQYII/S8cCAQeEAA1Xnl1cU/mh3hZNPcKFQDuYa0+8S5JG4GjoUn
         4CcGTZotbia+czASqga/DmG2N8RWGGpz3TYD3H4huHUAYxRuojqKbhOzxfxNF+DFVQMJ
         RmIo4MC8rufUCeMHOoWClJtM2TuRnMfLDUZhr2qllXYVjE6uXLMo3RI/as7oLfr0CjbS
         pz0SUzjx0w6PpGMIVc7nuW/dJX/1fnGOAMPTvmrs/7IAYASNM/CF1V3KarQT/J40p4nG
         osGoGwngPPIgA/DTDh1oEr3eNLxqURRsVcH9SK9N0CHdgxx3SSYUXrXHYH8AZzHlDoq3
         hx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785678291; x=1786283091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gx+lrTmOnbSyTafGzP658UcqNuptTVpf6Q722e+7sx0=;
        b=J5cf0cARto2Osys2v9r8+S3nAxt+3EjfJVFp6rjdPLP0viSU5tHTD0tDIoeUuOt76q
         rpYugk73RYL+57Et/0x1fNC2vty3EvG4Ohf4X68pc9xX2s1i2vBFnuPHcSqNAlr/os6O
         WuKRNMW996bZUNRTSi7edj6iY2LjtJun3DoUlvovS9AvjbHXBrawkwOHist428k51kA/
         1eSUCYjHEWXB3EOhUFc2UPj9gjNucocHxOS5A1/ZFUwhp0gyI/KNzo1EgrsgIPhovN0g
         pBEiEhNOsD4D8B4H9z+VeViDVgWty2jSzOpzyYLHGmZRsnB4g5iQerQnlx8yadQhA81K
         Tf+A==
X-Forwarded-Encrypted: i=1; AHgh+Rp7DdCo9HeTbse7+DtH9u9cOh1fYRagnxpU2PaHuNKtC+F/MovxevqzlZhZtH032mjsOiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgagFX1C05XwkBwDnHA+w8BdTxBTU2erpvsPSDmaL4Xvgd9tDu
	yfvbR55Fq5dP9ihZCGjf3End7WVt6+spwpgDcxG0JeHGd8nlKmCMnBaF
X-Gm-Gg: AR+sD11X7a4/TE0k41TAgaor1/tVFkY75OxnvQ0yBSowMU2ot4NhDqCUCFcWAUr9/mj
	54CxvKr5wr/Q8ad4+uDnVfh7I6lD9UhD110EoPHsjqe5xvT7sTWr1fXXQ94k77tP24D301uCLZC
	y2uJRQlZHCdRZASjCnbAEU3WGjsD7G1nzlvG0j+BwzwRmMNY9na7QNy2qNl1U4x2Nzm9FdJFD+d
	OYmT4UW2HHmlMOG0/+Q0NDFAoRXgPu+wTh1+C1jmDURRTzlReagu/GDT40OsXEmov/EJEAYE7pl
	sho4rs9B/vlq9XaIvHgN0/dUdaw8aBrvpCEGJSe7eiYmsQRjc0qecd1MtR5wawe+0l713bWVsD/
	XYIxjGVlnkR1eUQRwWzScGgZS1J2pnOnmaGsnkkcjm3qNdy96zuv6t67PaADqzqOcOBI4Dtlud9
	Ith1TwQNySMLnTtrzAPKoPJktOTCgak+MT0do85sk6WtHXIR9/UCddHk4QfgaGGrSGdpgmv6wQg
	0jrbmeX7fU=
X-Received: by 2002:a05:600c:1d21:b0:495:6713:9ae2 with SMTP id 5b1f17b1804b1-4980c66d99bmr81513185e9.1.1785678291242;
        Sun, 02 Aug 2026 06:44:51 -0700 (PDT)
Received: from lima-kdev.local ([85.99.180.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807ba8032sm112278855e9.15.2026.08.02.06.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 06:44:50 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kayra Cizmeci <kayracizmeci@gmail.com>
Subject: [PATCH v3 1/2] KVM: x86: Fix sign-extension of the INT n vector in the emulator
Date: Sun,  2 Aug 2026 16:44:27 +0300
Message-ID: <20260802134428.69252-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the INT n operand use SrcImmByte which translates vectors
above 127 to negative numbers. And this negative numbers gets to
(vector << 2) and from there vector are handed and without any
warnings.

Use SrcImmUByte so the vector never translates to negative.

Signed-off-by: Kayra Cizmeci <kayracizmeci@gmail.com>
---
v1: adds IDT limit check to __emulate_int_real(), link:
https://lore.kernel.org/kvm/20260608123503.23298-1-kayracizmeci@gmail.com/
v2: fixes the sign-extension of INT n, link:
https://lore.kernel.org/kvm/20260608134642.25849-1-kayracizmeci@gmail.com/
v3: rewrote commit messages, split 1 commit into 2 commits and rebased
onto current mainline.

 arch/x86/kvm/emulate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index b566ab5c7515..ec3138801bb7 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -4314,7 +4314,7 @@ static const struct opcode opcode_table[256] = {
 	I(Stack, em_leave),
 	I(ImplicitOps | SrcImmU16 | IsBranch | ShadowStack, em_ret_far_imm),
 	I(ImplicitOps | IsBranch | ShadowStack, em_ret_far),
-	D(ImplicitOps | IsBranch), DI(SrcImmByte | IsBranch | ShadowStack, intn),
+	D(ImplicitOps | IsBranch), DI(SrcImmUByte | IsBranch | ShadowStack, intn),
 	D(ImplicitOps | No64 | IsBranch),
 	II(ImplicitOps | IsBranch | ShadowStack, em_iret, iret),
 	/* 0xD0 - 0xD7 */
-- 
2.53.0

