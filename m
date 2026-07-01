Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A93E6DFF
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895855; cv=none; b=BHNMZ7ioRrQX3e56ydJJE8KNQQ50mzbLP4SERlqB8jnqnVaAI91n5FVyRhxyEZli97RJTaVUrqi4HGPQGXS6Tz11/ckZkuxaGvS5M3NSd4ue9D3+pLJ4Ppp4CDAERIxThtaz6ab8u/N6f5uXDUoDAo7cPdQYwdUKPU4PHZt+buw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895855; c=relaxed/simple;
	bh=o1ImjVrSN5H7HUaDEIUYF/9vRF+ec2T0rm7EZKA/deQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rF4nLi4RPFxKVV58pFuZx8BPNC+s48vBIs81xVhsiJkIauljXDugur+pWfUKqPhuyf99xlRJUf87eFLbwufbY93nMgNKF381aSaX1lvYuTmWVHn74FUCTIgqTBzLN1sytUzgBtCxjafgQJyaO7UNXKBB42Ysc+AGpmAusbHhHb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtNA9p/J; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtNA9p/J"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-380a00aae61so294702a91.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782895853; x=1783500653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sq6xhPxioPByN8YmUNTYsI/Wb+4488jJwlA/SYfNZdg=;
        b=BtNA9p/Jz4d2cbI9cKd+ksufzRE1JDSdIvOt1Pn6JF79ZhK7yOB7yjwFYaNB1WhJ74
         zrUuPQLMHZKPk7wL60dmGJKWRIUwBbCTq3lsP6RKXhE45kg4e5u2ikEwSFEdSyG6tR0q
         HKdbn5wx4VjktFGylbxjNWy61Qtla0ufnPZeGIGVqfiyAn3NjzBfbgg1kvdsmHA2Mbzw
         172o67qfdk/+bHTpFRQq90qCIPP8vmm0p7FMSgnBPwuxSVI/Um4/rn8MxZo8UpAzn8qE
         P8mCWEz9TlNuMl+9nB7FznUMN1N5FJ4+k8aZInG1M9nxYN9gANY04wuQrOQMP8stgVJ0
         l18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782895853; x=1783500653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sq6xhPxioPByN8YmUNTYsI/Wb+4488jJwlA/SYfNZdg=;
        b=jxLiw8WbwB+kNGTnVvtxCxUye8P5zktACT/hryvuEMOa68aDURVELVMOAbw5f9ZYB8
         DSi7BCKHs6sfjkC4cT1SkYaJ6lese1Eihu/TKlt+N16Ep1kUioBPie4ezw+Y3YrgusFM
         KcJBdqDzNbzO49OsLpyKZDD7cYgGQmg68He5QuJBIEchVsImYVL6Pf2VRw8tGW7dH/W9
         gwXWFMCKe1Rn/L+xAAr+SEGlv0vYTCGRF4CxsJO6Tt5p4FdpvQpe46W1wl7GIXeJpR6M
         ReH97A6/Au//j2uY8kFpBOVXgbigg9H/nWDaS4yE9Pbv70BshJK/MabprY0xD0SqWghk
         roTw==
X-Forwarded-Encrypted: i=1; AHgh+Rrhv18NXpTs8qLh2Ynf+Ad58QZrR/kgpTkONhZx11h4nfdeJ+zEpiZ58lNhlmP1wkXnJIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ogVU2OM0MAlUCA1E3vzLGsf0sDL6u3pZv2Lo7yFPaFsFWES0
	kyWT1DDh1SUcKtR0NneRFkyAl178J63sdXBPgLIyx61Kz0jhpShZ3Q4R
X-Gm-Gg: AfdE7cl2zt/SlcQyDy4PXN5bOamyPUOF/Ipb8bdtsrQDQx+J/fQDc9vV6ph18F7K2jq
	3VWF1F9Fc32IYpGnLTVSXJkHrEx0z6B881mtT3pxKDHbAeOSxSOZ342NB3+CzxT1J1Rc/3u73AH
	O4sJ7KtF+TdF/N/iVevuCXE4BgT2M7qDZdqoxK9sN8UEd07M0oGoIMwNW4Wf/pAthkEuf6DOheM
	HLWx0A/YlhN9NXdPyCcu7GlsqpKPdJKxWQ1DKnkfKipfckoJUyiFu0yFdH4b8FCyvQIXtPVxI66
	ODmfODFOS90ZNj0cls0HXRG9OpZTmRnN2yFzve5Nyt9rRA6LG+6wh4hjWpsKBwvnOpTLYegA6Xg
	C1+iFj5EL/yioS1LXp16RNoF1ZkC+td9Y6xlAqlYcSs9fFMel1ssryVGJU/nWoUhOdzMQZsGhlQ
	8FNA4Knl9saLQ67ERNR0IH
X-Received: by 2002:a17:90b:562c:b0:37f:9ce3:ca97 with SMTP id 98e67ed59e1d1-380aa20e0cemr685220a91.32.1782895853475;
        Wed, 01 Jul 2026 01:50:53 -0700 (PDT)
Received: from wud.bbrouter ([2409:8a1e:9473:9f10:5de9:783b:c249:18c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38097ba48d0sm550782a91.1.2026.07.01.01.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 01:50:53 -0700 (PDT)
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
Subject: [PATCH 0/2] riscv: ptdump: Refactor for KVM gstage ptdump support
Date: Wed,  1 Jul 2026 04:50:28 -0400
Message-Id: <20260701085030.124579-1-fredwudi0305@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors the RISC-V ptdump implementation to support
dumping KVM gstage (stage-2) page tables via debugfs.

Patch 1 moves the pagetable walking state and level definitions to a
common header (arch/riscv/include/asm/ptdump.h), updates the attribute
parsing logic to use per-level bit definitions, and exports note_page()
so that it can be reused by the KVM ptdump implementation.

Patch 2 introduces KVM gstage ptdump support, registering a
'gstage_page_tables' file under the guest debugfs directory. This
allows userspace to inspect the gstage layout and permissions, which
is useful for architectural debugging and memory management audits.

Testing:
  - Booted on QEMU riscv64 with CONFIG_PTDUMP_DEBUGFS=y and
    CONFIG_PTDUMP_GSTAGE_DEBUGFS=y
  - Verified /sys/kernel/debug/kernel_page_tables output unchanged
  - Created a KVM guest and verified gstage_page_tables output: 
0x0000000080200000-0x0000000080209000    0x000000010c94e000        36K PTE   ..   D A U X W R V
0x000000008020a000-0x0000000080223000    0x000000010c9af000       100K PTE   ..   D A U X W R V
0x0000000080229000-0x000000008022b000    0x000000010c978000         8K PTE   ..   D A U X W R V
0x000000008022d000-0x000000008022e000    0x000000010c844000         4K PTE   ..   D A U X W R V
0x000000008022f000-0x0000000080232000    0x000000010c846000        12K PTE   ..   D A U X W R V
0x0000000080234000-0x0000000080238000    0x000000010ca13000        16K PTE   ..   D A U X W R V
0x000000008023a000-0x000000008023f000    0x00000001083bd000        20K PTE   ..   D A U X W R V
0x0000000080242000-0x000000008024b000    0x0000000106975000        36K PTE   ..   D A U X W R V
0x000000008024d000-0x0000000080252000    0x000000010cb54000        20K PTE   ..   D A U X W R V
0x0000000080255000-0x0000000080258000    0x000000010c164000        12K PTE   ..   D A U X W R V
0x000000008025a000-0x000000008025c000    0x00000001036a9000         8K PTE   ..   D A U X W R V
0x0000000080260000-0x0000000080275000    0x0000000107917000        84K PTE   ..   D A U X W R V
0x0000000080276000-0x000000008027e000    0x00000001078ed000        32K PTE   ..   D A U X W R V
0x000000008027f000-0x00000000802bb000    0x0000000108986000       240K PTE   ..   D A U X W R V
0x00000000802bc000-0x00000000802c0000    0x000000010762b000        16K PTE   ..   D A U X W R V
0x00000000802c2000-0x00000000802d2000    0x00000001083fd000        64K PTE   ..   D A U X W R V
0x00000000802d4000-0x00000000802e0000    0x000000010790b000        48K PTE   ..   D A U X W R V
0x00000000802e1000-0x00000000802e4000    0x0000000102f74000        12K PTE   ..   D A U X W R V
0x00000000802e5000-0x00000000802ef000    0x0000000104b9c000        40K PTE   ..   D A U X W R V
0x00000000802f1000-0x00000000802f2000    0x0000000103778000         4K PTE   ..   D A U X W R V
0x00000000802f3000-0x00000000802f9000    0x000000010377a000        24K PTE   ..   D A U X W R V


Dylan.Wu (2):
  riscv: ptdump: Move pagetable definitions to common header
  KVM: riscv: Register ptdump with debugfs on guest creation

 arch/riscv/include/asm/kvm_host.h |   6 +
 arch/riscv/include/asm/ptdump.h   |  42 +++++++
 arch/riscv/kvm/Kconfig            |  15 +++
 arch/riscv/kvm/Makefile           |   1 +
 arch/riscv/kvm/ptdump.c           | 178 ++++++++++++++++++++++++++++++
 arch/riscv/kvm/vm.c               |   5 +
 arch/riscv/mm/ptdump.c            | 102 ++++++-----------
 7 files changed, 282 insertions(+), 67 deletions(-)
 create mode 100644 arch/riscv/include/asm/ptdump.h
 create mode 100644 arch/riscv/kvm/ptdump.c

-- 
2.34.1

