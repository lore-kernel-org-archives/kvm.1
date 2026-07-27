Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432334CFC7
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155425; cv=none; b=CJXUUGzarIuECOjS4NdGSsrUwToyv/CIJq5PqEhHfAmC4ZV3k6KTN7bKOI/Fmp3kPj3LNrlNKkSJSaPSkNY+woXBoe+UbUzE2AuoBVyAiP+150lHmmlIbdlC9BCVCVGhNUESq4TcGXnYwdsmPzjgi1aS2vKh7gsXbpl0L6N37E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155425; c=relaxed/simple;
	bh=jaiXBz+l1lRYFhGsZ3IGwEjlvJMaeM8u111+F3RTF3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EbPXWPgTQDVdxALPyDN2ppQEubYuRA2k7UTnmdKpBjbqx0i1uZ6DkP2dJlRPTFqKz0B9UgyJyEkxTc2RO8mdJpHG8GanZdlRBRiNjPBjzrLkY+rwtVZAKz30Q7XaZdB2VbR5Q4G412D56cr4CVAxKM5jFJza1N0eeFKpLR/5Wvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U81BXpq0; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U81BXpq0"
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2ceb5a39c48so9234455ad.1
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785155423; x=1785760223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zZDUuhSz6sxGN/m5AK+s00UCMOMQBfNugawXzRdDcys=;
        b=U81BXpq0dWzYDTh8SrOwmly5GYFoCG2XeTNlqQrpA18vvJjwoBG+izLTkxCkiag1Da
         qz0K+xXkUZqLYJ1UvfLmpbExBgr3r68PhIxmv5iaAhIp/rY0rImozmjgX1FWkx5zshDm
         XjTM87hUY3m0XUOedccAao9gxE/ZHL0ic33lkl4CPy3K1iB1TleSCVrZ+dHiiCgypsJ4
         aNvJCKFmsHutze65Odx8VaUxXdLPoOYM4n8BI75wRpjvnV9Po/1Vo90XCIidN6Gu7YcK
         fTXBKJyjmgxwsapOEwYtHgm02lVetfUj58D1Q0c4LCzDuW7wslgf74VcaXzfYmyRyKzj
         OeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785155423; x=1785760223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zZDUuhSz6sxGN/m5AK+s00UCMOMQBfNugawXzRdDcys=;
        b=KFv++Lh8RCauvhQtbwPN3svtuuYQ92BLF1Y5FMUj1FlVrj9hycUo4IqX3DsYdnvdvd
         fc7rh1KdWl6H2LehwSypwRtWWcrlzIkRE8w0sLCpf/NWy8zobxlUC5dlqO7TfQ9btGH7
         YdaThhJwtn1C2Wd1tFewQhBJcVc9ReZrLjQ21mgrW405TVunfT3ra826Z+z9X8rcEdiR
         6Xt/CsNAQtsd/6gkJNG03moxiowkMEEyWl4qlNGGIQrHGRVOJJ2TB+zH11++fs3Ulo3a
         v3SNOnexNgxyFBcdFogk5GYmLjXBXpHeog99TXnsvS6KJPpzdQfCRZI9pFGQygThvrGx
         VlJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0w3ihQdSUBkbVm5gbRCP1U9n2oAc+teb9S3/kwdDhBedcOqhx9c8gWj7IoW8BfvUwicI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcj+VWKUJbdwsInJ/GGjeQfYxFAVc8fqXwOcU/pbBohmU+eaOc
	b9YsqfQk6sFI7IZPnpKOY/iUwrG1sl/QvoE8M43sm4/V3/4tt2gCc628
X-Gm-Gg: AR+sD12mv7CgaY+kjDEJWGfhzoh44ySnYgTSKkOzHo4N6pu/6FJEgVTJSaxd3FAs6vI
	Hh1cUx/On6J/tWB/XtLKK+QwGn4QZyyLW3SPWovrKYeilCMScXB5V0jg/UjBd1teioOUFCFV0TA
	zvY41H63trCQg2DLIZlWxKaupFNbE0kg5ug+h3K/isFfCtQnnGnxxbPbnUWrFJG0OuQrNc5Mtmg
	WUsCjIR4WQJyDGv2lOgmQhxiiDpilx0TEZyhOAIYhLLNaTUuvqONuFISQBkzW757Z41IrlfKFjR
	xjIOGJGonzB9PfKhX55b1rJ88a3ejymYwjhu+w9gEhwgTtBS8SsjSn9bh1rf1k19SN7DPxlmAKO
	paVXEBoepjW626hVlPb3mVUpk90s4lRKk+KOOF9Y66bc02domnzLfF69cw+FnMPKGT7xaJ5IzPT
	qERzOb7Q==
X-Received: by 2002:a17:903:2446:b0:2c9:97a8:afef with SMTP id d9443c01a7336-2cfde8673a4mr76943665ad.40.1785155422902;
        Mon, 27 Jul 2026 05:30:22 -0700 (PDT)
Received: from wud.. ([218.194.32.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfe1ab9c71sm30679775ad.73.2026.07.27.05.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:30:22 -0700 (PDT)
From: "Dylan.Wu" <fredwudi0305@gmail.com>
To: palmer@dabbelt.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	anup@brainfault.org
Cc: alex@ghiti.fr,
	atish.patra@linux.dev,
	zhouquan@iscas.ac.cn,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Dylan.Wu" <fredwudi0305@gmail.com>
Subject: [PATCH v2 0/3] riscv: ptdump: Refactor for KVM gstage ptdump support
Date: Mon, 27 Jul 2026 08:30:10 -0400
Message-Id: <20260727123013.118984-1-fredwudi0305@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the series to add KVM gstage ptdump support for RISC-V.

Changes from v1 (https://lore.kernel.org/linux-riscv/20260701085030.124579-1-fredwudi0305@gmail.com/):
  - Split patch 1 into two patches as requested by Paul Walmsley:
    * Patch 1/3: Create ptdump.h header, move declarations there,
                 and export note_page()
    * Patch 2/3: Make attribute parsing use per-level bits configuration,
                 and rename local pg_level[] to kernel_pg_levels[]
  - Added CONFIG_PTDUMP_GSTAGE_DEBUGFS Kconfig option
  - Replaced custom walk logic with ptdump_walk_pgd() reuse
  - Removed incorrect copyright headers from arch/riscv/kvm/ptdump.c
  - Fixed Makefile ordering (alphabetical, under conditional Kconfig)

Dylan.Wu (3):
  riscv: ptdump: Create ptdump.h and move declarations
  riscv: ptdump: Use per-level attribute bits for parsing
  KVM: riscv: Register ptdump with debugfs on guest creation

 arch/riscv/include/asm/ptdump.h |  42 +++++
 arch/riscv/kvm/Kconfig          |  15 ++
 arch/riscv/kvm/Makefile         |   1 +
 arch/riscv/kvm/ptdump.c         | 276 ++++++++++++++++++++++++++++++++
 arch/riscv/mm/ptdump.c          | 106 +++++-------
 5 files changed, 376 insertions(+), 64 deletions(-)
 create mode 100644 arch/riscv/include/asm/ptdump.h
 create mode 100644 arch/riscv/kvm/ptdump.c

-- 
2.34.1

