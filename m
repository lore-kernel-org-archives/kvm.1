Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C02637BE7D
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 02:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303955; cv=none; b=e3RhdLbuHFsp2l26aKRcbja2tS/sXOQ7VYgGk3Ybp21GwEDa4u6x2IGWJRiuL+3yjmuj8aaRpjsMdl7NIUsMcRvZF5GFLGJu9BqvhYppEVbJYlIJoe4+gueiz084XmVeGKfTnPoIV4N4Kj8tncc3mglKKc2XVD48yDGCgD/6rGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303955; c=relaxed/simple;
	bh=05P3bfYmYozImTHPZvcX6u6NlLQxW0ibCDIkTOp4sXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fuHd46VHjr81wukeoX8airZ8fgrpxvGCwvxUCxQeE0vSps5jE9IKne6ujoys5Ocb4/TuN5JFXQckAvrOGzzyVG0nYh4cZ1HXzlXenkYxxB021F8y4KOn/F3oH9SLN1U+1g2xyyD91nND6tFibvrEnavblffX8vMxVBucW62asR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWgAxUg1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWgAxUg1"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso1336797a12.0
        for <kvm@vger.kernel.org>; Sun, 05 Jul 2026 19:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783303954; x=1783908754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dIh1n7XhPeXmjid24h9f0o5uRyG24o7+K7i4gn1uk1Y=;
        b=cWgAxUg1AI9DgeSUNl+EzYQFzafZS04MrukqMpbgtKtMuu97M06UdWyXDJF0b5qmAx
         YKeaj4gcJfKoG86ocPSWBxNfHbsH8cWyPTU5AhwcjfwyCOCStg/gF9mmdUAnKwJefszV
         IeQv4IlLGN1ezY55ImmvejzClZyR1knh+n5PYdj9Dfa2E80qt5WS92pSV+9jzKmPKTxq
         eRFiVvMVYU5Adp67iVzb6UBftq6oO7IdFTfeHQkrIJ+mfwp4+xvxU1BJXdvtoeAoMEUN
         N4QIttDgA2htG9fNHndeuxpLFTzuwi3TZTVzvKw3ZBH3a9JVNaDRXld65mmuks5rrFx5
         n6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783303954; x=1783908754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIh1n7XhPeXmjid24h9f0o5uRyG24o7+K7i4gn1uk1Y=;
        b=QCx/m5x9U+dmilHBNdtoE81C59orExLh6R8KwcindEuICWcsKgkfBhDtO4T9b/zjJl
         5S7BprhdtVkc4HGq2cZwLriBtFQOfc2SETg549KsB+fn0Z1NAv8dKl1Pbq472Ka6GY4x
         La27mIDtdk2uPh1stTxNC/Q2SSUdD8v5Sd+eAlBEgMxjlgpIDrIQREptGsTzsOdj86xg
         Vhu+wmn+f2MyxSkwmE4PIT0qf/bzBEGVnoP3gvISoO8YYTCF5xnlJ+LzloCm4CIOFz9K
         AH2KXvyJEbx+b4ZuHiM20Joa+xMmrIvQlvtM5u1pyteO4fRgGCuXczoAeyQdKyFlXbKD
         y69w==
X-Forwarded-Encrypted: i=1; AHgh+Rp8UK8JsJCMt3kcqpaFDeWL+3dxtKqwOLCQmyTgXFmdoSSeV/2xjcN93jRkrLryb50GjzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMbT+QbOPjLor6QD6ywku7IbXx4cuTbAsyL4UNZ3DhDf5mehaP
	89S/L3phE+8DjhCahzqGKCrP+6w0YW54slYw5q6kGJFmw2m7iP+8bYw8
X-Gm-Gg: AfdE7ckEoWJ5C11qt4TB2HTRibvI8Zp/mHd3KGwOqtra3sXavUcROJL2Ccqfw440yyJ
	Pcw31P8Yno1B58zRO56F0AY0VotHcUZNW1vy90+4+EXmfPVh7zh+5g1LJu1TDdz7zG1WBBcMl6V
	m944g9r5+Q4kVRxOkXV3JVwoBr6SLadnVxeXpOpc8kuqdx37vEtXxHp+UwuNROXyccl+5sNQ7cX
	UJiPxMl6VQgcHvRJykQeXnmTXcj5V3iifMnUIWZylKF+t8UqdIy7XdlyH1WoYcPxY1Qq+fTjmAV
	IpWf7gKr387JLryM8UTVbxwytWVgTMZf/VsJ2aOK0+M+cZ5+RRITvqHzmAMX6BHEl8CMIwrzeuA
	EoNfJamlX/T7sViUbkRCNT1XmJkpQifJr3J1FAMZvk8eo1v77qZZRJ4y5/raPydNW
X-Received: by 2002:a05:6a20:3949:b0:3b4:a0c0:6cb7 with SMTP id adf61e73a8af0-3c03f789afdmr7377836637.11.1783303953788;
        Sun, 05 Jul 2026 19:12:33 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e921d28d9sm5091574a12.24.2026.07.05.19.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 19:12:33 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 0/3] RISC-V: KVM: Cleanup SBI extension status when disable
Date: Mon,  6 Jul 2026 10:11:49 +0800
Message-ID: <20260706021154.210289-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM SBI FWFT extension has multiple internal state can be programmed
by the userspace. However, when the FWFT feature or the FWFT extension
is disabled, the internal state will be kept as it is, which may cause
some side effect for the vCPU, cleanup these state when a SBI extension
or FWFT feature is disabled.

Change from v1:
- https://lore.kernel.org/kvm/20260701094731.1022163-1-inochiama@gmail.com
patch 2:
1. Check support callback existed before using it.

Inochi Amaoto (3):
  RISC-V: KVM: Add SBI extension validate callback
  RISC-V: KVM: Add SBI FWFT validation support
  RISC-V: KVM: Reset the SBI extension when disable it

 arch/riscv/include/asm/kvm_vcpu_sbi.h |  4 ++++
 arch/riscv/kvm/vcpu_config.c          |  2 ++
 arch/riscv/kvm/vcpu_sbi.c             | 33 +++++++++++++++++++++++++++
 arch/riscv/kvm/vcpu_sbi_fwft.c        | 25 ++++++++++++++++++++
 4 files changed, 64 insertions(+)

--
2.55.0

