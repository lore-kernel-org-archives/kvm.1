Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EFE3603EE
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776763513; cv=none; b=YnVYi3s/37cZPgX2rRDSHhPKdZNAX2pLsqH1GOjVA8tl4BkHneFAck9cGkXNH4o+suStjjdjKJVSXuxD8WELhimAYM6e0qu8qtZQFlh2oY/btGnTpNt1rIuinFW+ItiCJnz4q0VqRfDzhqnRe+w0s1q1I4xQLZ0Ab5ytjtZZ5y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776763513; c=relaxed/simple;
	bh=nJwiGFl4TjH5C8Mw3Fm+cxT0UutDEaY57xKcpUJmn84=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=MTz44ZogII4gxlfLssfhPoARKLN/TDotFgRoLOQ+ItKGt9nYVf9Dbj4o7ekDnF0A8E+fRHAxEcf/9bVkq/AHecy91qP0OZoBzMUTBuD2GTMoEZ0SRJinrbvEmjjTFnsvHWfO1+mB1iOwb8xiNM727m4hji6Oxq+L1WTAAolfknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=i6GdwEp0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i6GdwEp0"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b2429f98d0so22380895ad.2
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 02:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776763510; x=1777368310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TYfKwapVQTASKc189TeQO1FVNxhT1wLsuvJTPgVY/gk=;
        b=i6GdwEp0vkUVEscd8KRSDlOwXOjiFOF2TFeYYt5FO74sRtwInYg6o6LmbhrhF/d2XW
         ytf0l7BycADWJ97Cs5AuPLQTp0GJaX9Fgtgz8lSDrkoAGIecUe1RTzuHl0s/gG+yOohh
         sgjSYikWwR31bJNO3ivBjXF6DGfT0Mg+ejNl3pQRDUFTnt5adQh5ehqiIytsfwIUJroI
         nMjoYIYa/XDLYI+uZQKklKWzBhGfNksYLIybZw/JRwL0K/87J0sjOAfV392KsVbfTGQV
         L9nXbwokqZFrkI9TAF1Tu6m4RLy/PwMtGjb3v51Icy5LH/r4sRTbe3cV2G1B2xVC2gij
         nhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776763510; x=1777368310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYfKwapVQTASKc189TeQO1FVNxhT1wLsuvJTPgVY/gk=;
        b=jZUx3Nnz291rszl42nKQTV5tGG8+OmgE7tiABdjLBbp0MGVZ+fslqKX1PIc62OBRsm
         7/4ZjhKsmpIxvyqDTCF/gc7qAXSiu9ljfzEPdIyzxnhGwFePiwMQthBI8AHw+inWUh3g
         1s4dYv6hqHkr5oufMFXhWFtCdFSafN0juw4hghAhw1uxdLowKF4edJUdQNZvsOpVdxH6
         8wgUQ5uMIYm165a1XApc5QXtHyy5DnOIZd2U8tTGpkE2wOUlsREFBOvk4Z4FlkOELVPu
         A82XZ2rRo3ALOt0Tuig1iREFujatzEKvAlF8VuzqqpSzkxiLqalNIojlK+KKyqyVAIzA
         HI3g==
X-Forwarded-Encrypted: i=1; AFNElJ/JiE7fOp0kC3oGSpigCFANC2twWebTq0eFZcSLmXR73O6KDPLipNzF9dkCBUtaNPOky7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4cGg03LpEPQxXZlAPnkTgwLz4CCVSkZ+QLcpzGnmCDly4T7s0
	i0332ZXqWfc6HuuthqVT2Ujewl7VcTrVv38U0nV3VbZrAfMGDZfX2AcKZfkLQNajo+I=
X-Gm-Gg: AeBDiesg7RIEJBDM31x2o5G7ls6oy6qxz1dHF56LHthuRruogy2++90IPoYxOcU1VZc
	zJF7HoKBYgvqO8c6IBfb9hLpWjH7K8KtgTjCEaQHK6jWdX2dI90a8xhWT5CJwbsFfwtFI0GPwuf
	MKoZC1lHOfxWPw+T8tpK2XpdW7/1jKHy09ee0GPZ5q/FVMJUArZgdyry+ydkuY0Lt2IB8SAaLF4
	vcvjq3563hC2D8CR76Tqa20o7+OuwSKjSgxk5L6ysfoGbmwnmiddzuace96eY61ogEMGLZjmRxx
	kPwic8e6JETAvh/qFeM6ORb058CWLQrjS26k3hVPZpNVaU8onl8vax2m6M7VptJG52+OLCpyOHh
	qurmcCVpAz8ImCjeKbD3qoHa26C+KQHepaaDpWudTl/XppuEjL/nQhsr4qrm4xXofyqZfizgq/t
	64but0Cv+i8AiyqjGRQyHTGQjZyC6qpUQP7LrZCcdh6WkL3pC1ZQXERlTKGSQevxn1fT/KKMD/9
	OV003g=
X-Received: by 2002:a17:903:1ac8:b0:2b0:70c8:ccea with SMTP id d9443c01a7336-2b5f9eaeba2mr175964215ad.13.1776763510266;
        Tue, 21 Apr 2026 02:25:10 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff39csm131965105ad.4.2026.04.21.02.25.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Apr 2026 02:25:09 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: akpm@linux-foundation.org,
	alex@ghiti.fr,
	andrew+kernel@donnellan.id.au,
	andreyknvl@gmail.com,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	apopple@nvidia.com,
	ardb@kernel.org,
	atish.patra@linux.dev,
	baolin.wang@linux.alibaba.com,
	cuiyunhui@bytedance.com,
	david@kernel.org,
	debug@rivosinc.com,
	djordje.todorovic@htecgroup.com,
	dvyukov@google.com,
	elver@google.com,
	glider@google.com,
	ilias.apalodimas@linaro.org,
	junhui.liu@pigmoral.tech,
	kasan-dev@googlegroups.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	liu.xuemei1@zte.com.cn,
	ljs@kernel.org,
	namcao@linutronix.de,
	osalvador@suse.de,
	palmer@dabbelt.com,
	pjw@kernel.org,
	rmclure@linux.ibm.com,
	rostedt@goodmis.org,
	rppt@kernel.org,
	ryabinin.a.a@gmail.com,
	surenb@google.com,
	vincenzo.frascino@arm.com,
	vishal.moola@gmail.com,
	wangruikang@iscas.ac.cn,
	zhangchunyan@iscas.ac.cn
Subject: [PATCH v1 0/7] riscv: add Svnapot-based contiguous PTE support
Date: Tue, 21 Apr 2026 17:24:50 +0800
Message-Id: <20260421092457.37649-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

First of all, thanks to Ryan Roberts for the work on mTHP and
Contiguous PTE support on arm64. That work provides a very useful
reference for reducing page fault overhead and TLB pressure for
large but still PTE-mapped memory ranges.

This series adds Svnapot-based contiguous PTE support for RISC-V.

To achieve similar benefits on RISC-V, this series introduces a
Contiguous-PTE-like mechanism built on top of the Svnapot extension.
The intent is to preserve the core-MM PTE semantics while allowing
RISC-V to transparently fold eligible base-page mappings into
Svnapot-encoded contiguous mappings when possible.

The series splits the low-level raw PTE helpers from the public
core-MM-facing PTE helpers, so that:

-the __xxx helpers expose the raw hardware PTE encoding,
-the xxx helpers provide the semantic view expected by core MM,
-and Svnapot-aware handling is centralized in the public wrapper layer.

Performance results:

-Compared with the native 4K base-page setup, the mTHP + PTE fold
scheme improves overall SPEC CPU performance by about 2%.
-The native 4K page setup shows higher memory access latency, and its
memory read latency is about 12% higher than this scheme.

Yunhui Cui (7):
  riscv: mm: split raw and public PTE helpers
  riscv/kvm: use raw PTE helpers for G-stage leaf PTEs
  riscv: mm: add Svnapot-aware contiguous PTE wrappers
  riscv: hugetlb: switch NAPOT mappings to raw PTE helpers
  riscv: add contiguous PTE range clearing helpers
  riscv: batch write-protect contiguous PTE ranges
  riscv: add Svnapot-aware pte_batch_hint support

 arch/riscv/include/asm/kfence.h  |   4 +-
 arch/riscv/include/asm/pgtable.h | 455 +++++++++++++++++++++-
 arch/riscv/kernel/efi.c          |   4 +-
 arch/riscv/kernel/hibernate.c    |   2 +-
 arch/riscv/kvm/gstage.c          |  48 +--
 arch/riscv/kvm/mmu.c             |   4 +-
 arch/riscv/mm/Makefile           |   1 +
 arch/riscv/mm/contpte.c          | 650 +++++++++++++++++++++++++++++++
 arch/riscv/mm/fault.c            |   4 +-
 arch/riscv/mm/hugetlbpage.c      |  55 ++-
 arch/riscv/mm/init.c             |   8 +-
 arch/riscv/mm/kasan_init.c       |  14 +-
 arch/riscv/mm/pageattr.c         |  12 +-
 arch/riscv/mm/pgtable.c          |  58 ++-
 14 files changed, 1222 insertions(+), 97 deletions(-)
 create mode 100644 arch/riscv/mm/contpte.c

-- 
2.39.5

