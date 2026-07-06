Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DF637F005
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304511; cv=none; b=awJcytUDV5H87iVZFWueKNPPGJG/9Hh4kJPj4Gjdg4IkWMUQ0X28JeLqsToYLYinWoXBmefIbGGo9436OHxV3n9R+UqiVMzps1gilHmb5ehlMfa++S2P9fUDTSgzhc1AL7gmCNQmSMydQoymSQQfyuvAUtw1zH4AeRatIma2d50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304511; c=relaxed/simple;
	bh=gGfxTLPCEXSgUtK5WaUX5O/nHFlYsALwKDZ9s87hSwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVN9S2CVJaY1+OlxHKoF1HxBR36gz1WQydhm+SC8Za8/TARV9U0vyLUUx+tsEPQVWRq27LPk7/JaWQt3ZAkOKEfJTalAZ/Xlv0/4Gp+J3/j0G1MFUzSFlrUg5Lo5HoW4oB9qQtHgNGKyg63UhnBrjpCWm+Fv+LQdeYLbHLb+r78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YECXW1XP; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YECXW1XP"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1115271a91.3
        for <kvm@vger.kernel.org>; Sun, 05 Jul 2026 19:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783304507; x=1783909307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nI0CkxxyoH8k0I7InDiV0iYilFi9jdMMJ7m2xkEZwHw=;
        b=YECXW1XPT0pPjaFaByTY2xjcMd7jbAYEdyTdxo1NuZBumsNa3RODaiueyR1G2t/rOt
         dUukDV/AG6sOOfTMRiUk/aRHySguDmh2hci082z7ItqPr5cJdcxP3mfMDOnWkbWy5iQv
         OeWhAGMJbmKzOIbhryiwrBgEF2GyUb8XUHnEF+NSNZE6UdN+0ySf7Z0h3UcJ28wmYh/c
         RfJXPT9tD2e/IXi5iu9btTJVkSJFDfHMkTIM/Dsk9x/pacBCGXXs590cN9qMjKoW8E+7
         EYhMbBXDmXvMA0adxENsjlKgdUqzaDVKxIfrYcN1BgeQg4iezhD2djnzekHXwGt79kEw
         UEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783304507; x=1783909307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nI0CkxxyoH8k0I7InDiV0iYilFi9jdMMJ7m2xkEZwHw=;
        b=k+1uODjfu55h/CV8Nd7cZrsy4/jaguQJKAEJKMQ1vM8wAZg3xm0sFX2jhMnlt76SeJ
         rcFA177yomWF+tbfa3T6xgoadEo/NbT1c2UI08mSkuMfhOaef+hYsq4jT3BuZwRSpixo
         Xbl0BRI4PVKQdapTtpXKWKTu1zsYxjEu7CS/BhGSFNPhbHbGYhBNJhhV2LLuhCUvZi6p
         DqZzacvFbaNRMnUY2liXifl4FcX5DS8oxN9hc1Nedt7ZZm0dYX2DKmWXORPaiV1DMDu2
         KiDJUR40+zmfju8PIqITpcjTixGCNxzgJLF58yKik/YHMmFSe5xwRrGmxz8/QLBKNtGf
         EOTQ==
X-Forwarded-Encrypted: i=1; AHgh+RrlqiOUygV+R43GyghP29g3w7LP8g7MqDrIiGNWvegty4kD7p5P9GeZTeHvkuzbQZijnK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YycaCUzW25WYDxkFUL5kGV9tf7uBfe4waGXvgHMG/k3LCewUNcD
	s0/vNI/4jkH+xdv71nLDrMqrlHUIDfxsO0goQM9ClO9CRmisaMbOg/SD
X-Gm-Gg: AfdE7claURxvOkfJp6aS5gN9TpUtt4J8iF4iG6XflmEpR2z2WSBACLXrmMmPxmroW/o
	lxjVTjoZ/AW7QgHjW/zbhi3hgxXedjMpC0G2OM7oH1faiWY2D6LPZjKPLFB65+uAinfZhdXR+T7
	/V6AXaEVnzOTfW1TFvFGrvIGSZ9RXpifHAXfDpicgNjlMKLEKXAhKMWaqfXyRfr4drgF7uKdNtQ
	Xsd4G7cI8Ulq+WnP3ZLHKs0E9ukDuHkM04Yjz/Q9k029b0Mz39cK9Mpw+2rMzeJYU+SlsKfjDYQ
	RUqLmJ4DCAj1WwazY1VsSP+QNEzliKwEQDHErGge4LmqB6yYl5ZOaI0Y0g1GcWjl7FpirtQisqz
	KkDaNEMc9eIt13Z8v8ZUcBqz9OxSZEm2QrLYB92ppWZa3XjBgLLcru//O85FZ0HLU
X-Received: by 2002:a17:90b:288c:b0:36a:c4b:76cf with SMTP id 98e67ed59e1d1-3829f00021fmr7476641a91.23.1783304506913;
        Sun, 05 Jul 2026 19:21:46 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3854f03f92dsm1348394a91.6.2026.07.05.19.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 19:21:46 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Thomas Huth <thuth@redhat.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 6/8] RISC-V: KVM: Delegate SPELP bit to VS/VU mode if landing pad is enabled.
Date: Mon,  6 Jul 2026 10:20:42 +0800
Message-ID: <20260706022046.214956-7-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706022046.214956-1-inochiama@gmail.com>
References: <20260706022046.214956-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delegate the newly added SPELP bit from Zicfilp extension to VS/VU mode
if it enables landing pad support.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/kvm/vcpu_exit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 12eebeabdf14..92a3ea7c7ffb 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -154,6 +154,13 @@ void kvm_riscv_vcpu_trap_redirect(struct kvm_vcpu *vcpu,
 	/* Clear Guest SSTATUS.SIE bit */
 	vsstatus &= ~SR_SIE;
 
+	/* Change Guest SSTATUS.SPELP bit */
+	if (vcpu->arch.cfg.henvcfg & ENVCFG_LPE) {
+		vsstatus &= ~SR_SPELP;
+		vsstatus |= vcpu->arch.guest_context.sstatus & SR_SPELP;
+		vcpu->arch.guest_context.sstatus &= ~SR_SPELP;
+	}
+
 	/* Update Guest SSTATUS */
 	ncsr_write(CSR_VSSTATUS, vsstatus);
 
-- 
2.55.0

