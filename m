Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF43B994F
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481791; cv=none; b=HFJFLy4PBoeBk7F9wUg9+1kq5ichaJ78bYSD5/Cqg1hhS2ne2fKBXX+VJK+N7APQNEGTWMg0vYXaHoF8JCIZkAatDcK6o91OtqOTeDqiAfqvRuK0URaMXOcDycWPZaN5k2JJknxpxcsE6vQPKY3vSaR51+Inho3LP2kvF4visJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481791; c=relaxed/simple;
	bh=1tICEVIvaC4ZLr/Ax7sSaci3FTAyWazsJABtM7N8+oQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dTfIVFZXhFC7m5IP0otyVTgf7atSUS382sN+1aNqstn6+VpB1EA/MDJzPbnGQrYOgwhqrgnpHFXpIqoA/laXhF0c1buBA9qMEVxGhfKVSDSjTlWVS60yx3uFOBywCejNy1P68WfougTUNGMCIygytYAlx9qc25KbRg+WNQl4DnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQdEABsf; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQdEABsf"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso268664a91.2
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 20:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783481789; x=1784086589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Vl1jMHF6Mz50lVaHNGk62U0kiVIW8sN4jisG45xdAs=;
        b=FQdEABsfK1wFFcf+1jwBPa6x7DkVDzKux6mLoL5krPkBPomwVVTk55i0hLMIe9KyPq
         pHCfs5QffhTKBYYmrpXt/vpV6iz3kImqoWwXZZeatvt5Yr5EQVD0OLKtR7w9WHyEjbO1
         OMlXWb0c/U6+aZWRdjtqyPEbmrQGZZyQjroC8qjy/Ty8ZnlDPq0INQgng4UMW1OW1B5M
         zikHc6THyeWCTNS6eaZcerI9r9vsQMvzISirVkdu0VNA1vkJ6n0f1fL0qZwPju2djtsA
         cDr3cudmATK3yGkGevOrhdmWW/xv5brlSE6N3yccWgNGLz9Ee3tvV75KT3Rr3bKYzB/8
         Si/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783481789; x=1784086589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Vl1jMHF6Mz50lVaHNGk62U0kiVIW8sN4jisG45xdAs=;
        b=VqTcqjS6c4yHaf9Df+hqFyjtaAP8bhKz8OoGezBp8mxv2euyot3Rz/T0IAYJYVdBVz
         1hff15+2fKZjZ0IFmYqLyA8GHW/wZTBTZDA1yKnafypyeQ0e8/kNDLK6TlWkKEF+ZcIR
         vgpnN4RRtUi6JImQErbQiQwB73KZzQReG2UFCcVdvLa6BNZAhvo9Sp9/GkbG+12KbBPj
         VChKLcG52IQMq+Ia2XXPERzZ6jSYEuuc3DyQW5Tzxws0GuQOcf9e8ujXGKTFnKhgTC1m
         4M+LwUiVBFDjlVCtBQKQ9KwvsIkZqdkQT3fjAzey46jmtgLTRfgWVM5yfVBzer0tXow8
         8AuQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp2tGEuF0aEStKdsHF5n/bREQ+fftnf197ykE/+NOjhmqvr6jcDtqAJ+xfq99/0HsKj3pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsGMonKJw59ID2iW3qCAgQ1KXbITghJE+6J/9bQTUDpD8IFi2w
	GEDkPqt8TTEASsQWGuNOUi9bfHjWOf96DnfnhSFdY4ivTRJ6Vf9GxtFH
X-Gm-Gg: AfdE7cnZoOcJOSLrcXND2TvA9917wT11vaXvUQfGxZNjn6lYARxKAJ91uGs2oxYFMMf
	alRg8jZpJPcDLBEpPAcC7f6qcHtXCyFxbta0UaVNZTjl+zySvtxcMpZLPmLZpTtrY/3fVX+9bP/
	sQuBn3F1VJddSLCtll+oUe2V7qKIYqLwxdxQjgvMfbsgqKhYwynIeZ/EN/QFtR/X8xtHvAY8kID
	4nvYYassgcPFKE2cNxr4DJRcEJ2KCKm57kzCuXPPBYze6vQ6H6vKiahlmBbaGIVYGSUtVNuQJRa
	MjsKxh89YgzjpOXr7lqY2818hFnMND3nBSMwcFUMQS4sRCdAjEQ1ELNge+chPCkjLj4FnP3u/zW
	9CsUePfgPwjhkmabzkwJ4uZHcEKNuGIcLWWw+FRQxMc6je1ySxkif5ge5FaHrQOYejLu35uN+Zu
	ALuOd4VIjdbTkH4lAR5nSliRqbHqxjWVmUCTglRGX5b+XVEuzusA==
X-Received: by 2002:a17:90b:4b81:b0:387:e0db:3d8c with SMTP id 98e67ed59e1d1-38943954dc4mr623537a91.39.1783481789129;
        Tue, 07 Jul 2026 20:36:29 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accae5sm21092850eec.29.2026.07.07.20.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:36:28 -0700 (PDT)
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Date: Tue, 07 Jul 2026 20:34:29 -0700
Subject: [PATCH v3 06/17] riscv: cfi: Use generated instruction headers
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-riscv_insn_table-v3-6-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
In-Reply-To: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Nam Cao <namcao@linutronix.de>, Alexandre Ghiti <alex@ghiti.fr>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 Jesse Taube <jtaubepe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783481777; l=1198;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=1tICEVIvaC4ZLr/Ax7sSaci3FTAyWazsJABtM7N8+oQ=;
 b=Po1xRMgYDA5PIVVjKPxjGPmEu+M69/hx3ymY++n6Om1HumSakJPKNAgz3tx1U5lGTyl+yk573
 kGum7EZxUnEABIJkspZZYr9uErQy5kunYsr5p3GGMpMq3eU7v6ZVH+f
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

Migrate the code that is decoding cfi instructions to use the generated
instruction headers.

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

---

This function generates the same assembly as before.
---
 arch/riscv/kernel/cfi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cfi.c b/arch/riscv/kernel/cfi.c
index 6ec9dbd7292e..e38d5f863747 100644
--- a/arch/riscv/kernel/cfi.c
+++ b/arch/riscv/kernel/cfi.c
@@ -40,16 +40,16 @@ static bool decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
 	if (!riscv_insn_is_beq(insn))
 		return false;
 
-	*type = (u32)regs_ptr[RV_EXTRACT_RS1_REG(insn)];
+	*type = (u32)regs_ptr[riscv_insn_beq_extract_xs1(insn)];
 
 	if (get_kernel_nofault(insn, (void *)regs->epc) ||
 	    get_kernel_nofault(insn, (void *)regs->epc + GET_INSN_LENGTH(insn)))
 		return false;
 
 	if (riscv_insn_is_jalr(insn))
-		rs1_num = RV_EXTRACT_RS1_REG(insn);
+		rs1_num = riscv_insn_jalr_extract_xs1(insn);
 	else if (riscv_insn_is_c_jalr(insn))
-		rs1_num = RVC_EXTRACT_C2_RS1_REG(insn);
+		rs1_num = riscv_insn_c_jalr_extract_xs1(insn);
 	else
 		return false;
 

-- 
2.54.0

