Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780D83603C0
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255327; cv=none; b=L5wdTr50vjB+mCPq0fOjE+BeCmxtZ3xWjm5SrfKDZBqWQswDRL/Zj4ts7Wehaxa26kz1CFi8dQizyXOGB/lzN/ZBdqRHWwwgAWPQm/mUqbvnNB2vp1YwaN/y+9q4k9PPi2+r/XDRMdfe7nVzdNNOl3TAyWqxW/BBuEFv1/vKQWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255327; c=relaxed/simple;
	bh=VzkbFNmui1o1RkyT7pZxd3/cCpCVHwlzyk663pgzHr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOtXyOskrDREh5dSsQgBxolIlK155xO4s7jS2+c7h0cPzPLYAwFRWOhkMdEM9McWvc1soMToqLPTz9Ht2mMk0Sk5CWXfgKvSOB6KFztqLEZSwYlAZ4TRO2u6bvTfdYiCsiFU7DFDNffOqlgpTD0aQ+6z+HEjPfJHrkdkM43Imvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsvAXoLD; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsvAXoLD"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-383390e7584so1931a91.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785255317; x=1785860117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvQY85JSs1DQ7oy04X11i3pK8UnfzkNAg8LAaOu6/1E=;
        b=fsvAXoLDjCtXlkghHm1WLn82WtZlpdckexMI3qpIVsClOQHi3VnCbrZmFJ+m5TMdeX
         9QlaMb8DTfGjl4f5r8cjyIbqQfyKaY4OOzcAmq57pl9KDd94fkefGJclzi0ki77WkigR
         L/QGMOXXIsD7qyQ3ohhhJQmr7NHFVTGnCLj/GwJCaeSgilg4JCyTnPwuoBMLMLDNO5Ye
         kDZyl9zeICjOCQj03R4FXRMDUrQC0gPKY8BsLAMs/gg9yj/cCFl3Kf8Wv2rfGmx2AV6A
         8bSl73UogeETC4rij7OLVFNv93kXwxpRA1amgursE7TzZ/F82jmt0aB1CmItUD14i6e5
         R6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785255317; x=1785860117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZvQY85JSs1DQ7oy04X11i3pK8UnfzkNAg8LAaOu6/1E=;
        b=b7EbxFQLDvbrcklCDSh/pw20VOHdMxZRqE/YrG8ueFrieyadUeIRgfyrrY3xS8v4KV
         tJGhawOvvKRmrH42iPJcOE4Y8bOECQ+vfd7yMWnt8aIzw425t4pu7FoLBXGrUUCRhvZG
         YNyGTAAPFCdFlPN5VLHD8KbM2XNTeeFUPaPjR46FaeP8oj99UCEgsOaMUPTfmgyFmrin
         no2xk/o8OBV1hkG1ac7rI4EGkD7+Lr5PHlLPfazOs5pxjTa9ZzGaXqROOgiz5chDOXbR
         Qa2VnA3xhnej77DQtiDsA2u6aqfVUKo5K+0A4M8jtQ7k1u5brruu5ah2RZdlon9DhNAY
         QCsg==
X-Forwarded-Encrypted: i=1; AHgh+RrjuSDA6LM4OEemBjuX0A6541J19mDCAY7NkDjAuanyWis13QdOY24CZL77rEDfIdyTm4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv4GmMfjB+sJw93WZtlNJBAfktUzJHw9w1i4DogJP7nCvLtggk
	A7afPFErYtE7Cywq9PQYAQXmB0ParY/h2uPsHjcVPlYcKc8/vriwHI8aHJR9gQ+EBHAS2A==
X-Gm-Gg: AR+sD12wdw3nHE1y4PyvN8Glh6HJ0QsHVauWUlLYm2FDOD0l6wY7rE1+dEuLBPKUahU
	1qNB9tgVC7QZbMwiBxMOunGFutS5eS3IJzrkoLT3+Qctj1J/GV9k4SvfvcrIcVLPFUt5jVB0JR4
	Hls1U9s3nMmpLNU4Wwp52h6Y9ctclsP4PZsvGnWLcqBVGk9JjzqVXlAjG3C8KC/Gl8id6DX7vp5
	ZfXb2H3e49jOE8erzzregQF06OG/G8K7bfLji8aqZzH0IZyd0UbEx8hvcyVjXJBhIW1DhqJ0olY
	CacXe9IAVPGStz4friUYfqIGdcG6Hl0/zHQbV643lmMaTlDTM/1AI/ojKGAH1IMEEkzpDPLG+1T
	PGd/igdigIt5hpgvQxgEa1qXcqO4C39+QzqfnnHfIUWRBXTyhk9p4NyJ+Jn7AaTylBKcqH1E=
X-Received: by 2002:a17:90b:3c8a:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-38f6a24719fmr2890912a91.5.1785255316861;
        Tue, 28 Jul 2026 09:15:16 -0700 (PDT)
Received: from wud.. ([218.194.32.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f292b06sm161141a91.10.2026.07.28.09.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:15:16 -0700 (PDT)
From: "Dylan.Wu" <fredwudi0305@gmail.com>
To: paul.walmsley@sifive.com,
	pjw@kernel.org
Cc: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	anup@brainfault.org,
	atish.patra@linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	"Dylan.Wu" <fredwudi0305@gmail.com>
Subject: [PATCH v3 0/3] RISC-V KVM gstage page table dumper
Date: Tue, 28 Jul 2026 12:14:46 -0400
Message-Id: <20260728161449.190058-1-fredwudi0305@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3bb2f519-c70b-6c35-c404-6fbfe8adbeb1@kernel.org>
References: <3bb2f519-c70b-6c35-c404-6fbfe8adbeb1@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for dumping RISC-V KVM gstage (second-stage)
page tables via debugfs, allowing inspection of the guest physical
address translation setup.

Changes since v2:
- Split the first patch into two as requested by Paul Walmsley:
  Patch 1 now only creates ptdump.h and moves declarations there
  with no functional changes (structures moved verbatim).
  Patch 2 handles the structure renames and per-level attribute
  bit parsing logic.

Patch 1: Create ptdump.h and move declarations
Patch 2: Use per-level attribute bits for parsing
Patch 3: Register gstage ptdump with debugfs on guest creation

Dylan.Wu (3):
  riscv: ptdump: Create ptdump.h and move declarations
  riscv: ptdump: Use per-level attribute bits for parsing
  KVM: riscv: Register ptdump with debugfs on guest creation

 arch/riscv/include/asm/ptdump.h |  43 ++++++++
 arch/riscv/kvm/Kconfig          |  12 +++
 arch/riscv/kvm/Makefile         |   1 +
 arch/riscv/kvm/ptdump.c         | 177 ++++++++++++++++++++++++++++++++
 arch/riscv/mm/ptdump.c          | 106 ++++++++-----------
 5 files changed, 275 insertions(+), 64 deletions(-)
 create mode 100644 arch/riscv/include/asm/ptdump.h
 create mode 100644 arch/riscv/kvm/ptdump.c

-- 
2.34.1

