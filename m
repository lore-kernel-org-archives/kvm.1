Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2EA37BE74
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922127; cv=none; b=PgCd3XuRlBcZbimcUugpFSwaSE0+FIQj0Adv1ecexLm7N/NQX1uV6kgvY5g6exZv/al4bKvXnVey38luv1d6abqitQjiMsV0vEA9/4dmztp3MICQ+Q+Hrvpo62n20/njzMXl1QAQFEiHJy0n6GNU4kVjEmFhIbFJJGJj5WQz3E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922127; c=relaxed/simple;
	bh=CYYDWqyVN6rQRyrhyeSFNbNRecXMfXc9yaACOsDkXqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onz55sZmKGI34EXI5twqTAQj6AhxJp5syzXI32xEeHoi86PSTDq44M8oeD7EyuV6QkLVanOXzXgp4gpJM7yr6Y/C9WdWLs0/6dEIhCQRJAxyhDqs3CWKCWAAza8OO61H4WP6HNio5eh4hvo5EJy9uEtSwB4CAnwJQcwJw3VYHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTLQIxpO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTLQIxpO"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bec85f03e14so63098966b.0
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 05:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780922124; x=1781526924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z+NDiLOfcXQ8JmuQqrk6+Ji+NDT4+3lQ7MCKUmz9FTk=;
        b=BTLQIxpOdMFfv+Pdqw+8LaWLszo4ixaRviwDSiFdY/StYWJD+FZI5QeMvjJkRIeoX+
         qpp+uWHRJ3eihuvJnkp4o29fMRhWfCKVeuruZ/bkvfmw8TtiZvnLoiD1FMPetgBeoMYn
         aMKvSclolACR47NR+uX+F7UYFopf3Fiw1nb7mh7kwZ4VHw0J2HfrmwbpCHRWJwr+LMLQ
         Ygfy12luNRy75hV+4qwH1PjKiFxDYzVs9hQOIRlbE62GGkeDiG4NcmFDyLNGo0W/SnBQ
         q6yYPdfqjFGwDdsZ+wyNwoFz2IsmIJllCUKLZu7iQIcX6OQ68AA4JdvdcnuG/Z9NgoLE
         XFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780922124; x=1781526924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+NDiLOfcXQ8JmuQqrk6+Ji+NDT4+3lQ7MCKUmz9FTk=;
        b=eYwDXCAp3lVQw4FgMz1Bko6w3v5MsvldwXbwBNqHOgxr1hG8mgeBFJgZ7OmbI9/xRi
         GUlV7ZZc753CaGSJvRqymG/rDpHI9jRsdDgQBzN5e/F9b5AIw9AEfgbNkYPR8M/B6FZn
         5FVNGUYM5wubu1UW+aDlsKgCjJ95O6gAh82LVLaZBRAW2QZ84sbkaRlQ4oZt0OK/ulcU
         tATmUuuj2JCMN85cVbJ3Vyshhoy6t2R6PGWfh4Cd6byEqgpqU9sRuuo9ILp1JWYhqJWj
         c8bWg9rC//ORtWftHW/B/c84Y4M+hBTJNJPFPSxbpTTDjjM4AL3U5gMd6Yp3X0PpTm2U
         Id5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8XNElWlCBHjzE9Ce49ebuUaQ0oDT+03maR6amk/nrUOAHPfFSftBqLeBIMRC2lVZp+G3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzufb1cRk9hcavGQ83VSZKA+PCzt7M5p+OqHU/WYdmc+aLsKeVK
	CP6iDo85YBVC7LsPiEep6qiv1609FtRtYf4kVT/O0g32MQ3gUaWnRgvp
X-Gm-Gg: Acq92OFVvZMRR6+L+KMtzeN6nuZboTj6OXEWGdlE8xiNTQA+lUte15tcTWwKoo0DQt3
	NkDAatCpgTlIBeGRSUQl0UrVydXIgtgZm0ToXwKLGd4+lHHWvnSKU0+4AAk08NXm9zDADtpxOrM
	cWGDrceyVXfJmfox/oXOvIujsWPlVh3QbuVkbvxorGEjqg2AQxYc++HNiqcpg1mrDx5uY8iJWbI
	pJSxkCG6a9yXIkXE0EKg+wkWd4ROyKIBJ7vDr002FhCP7QT1cSOKqPQduOVhuc+huNvRRVLumvC
	6fsBeb/vExdBQiOBhZoyUCd5j0c6VdfSYy2qyWg5NKMu3MD4OT8KRwoJoKK22v7v4eCPUbWIQvh
	iRwZhyPPmK21ROX4sdmoVd95gSaTdPI6GdssCh5QRnTjiddLCsrEqqUl09hnJxRN5p1Y8MXwGcd
	6+0rOC0sFDbuY7qSiiXaB9RdDKwd8h5o6fhJWiZO7llM0jCV/1QWk/6b30CfNtCISPCu1U
X-Received: by 2002:a17:907:971b:b0:beb:cc42:eaa8 with SMTP id a640c23a62f3a-bf37076c08bmr353336766b.1.1780922123939;
        Mon, 08 Jun 2026 05:35:23 -0700 (PDT)
Received: from Kayra-MacBook-Pro ([2a00:1d34:85f:fd00:89b:7f3a:f691:1b4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf3e39647c4sm485107366b.63.2026.06.08.05.35.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Jun 2026 05:35:23 -0700 (PDT)
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
	linux-kbuild@vger.kernel.org,
	Kayra Cizmeci <kayracizmeci@gmail.com>
Subject: [PATCH] KVM: x86: Add IDT limit check in __emulate_int_real()
Date: Mon,  8 Jun 2026 15:35:02 +0300
Message-ID: <20260608123503.23298-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During real mode interrupt emulation, KVM currently pushes data to the
stack before checking IDT limits.

This patch fetches the IDT early and injects a #GP if the limit
is exceeded. This prevents potential corruption.

Signed-off-by: Kayra Cizmeci <kayracizmeci@gmail.com>
---
 arch/x86/kvm/emulate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 8013dccb3110..04e6c80bdb14 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2022,7 +2022,11 @@ static int __emulate_int_real(struct x86_emulate_ctxt *ctxt, int irq)
 	gva_t eip_addr;
 	u16 cs, eip;
 
-	/* TODO: Add limit checks */
+	ops->get_idt(ctxt, &dt);
+
+	if (dt.size < (irq << 2) + 3)
+		return emulate_gp(ctxt, 0);
+
 	ctxt->src.val = ctxt->eflags;
 	rc = em_push(ctxt);
 	if (rc != X86EMUL_CONTINUE)
@@ -2040,8 +2044,6 @@ static int __emulate_int_real(struct x86_emulate_ctxt *ctxt, int irq)
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
 
-	ops->get_idt(ctxt, &dt);
-
 	eip_addr = dt.address + (irq << 2);
 	cs_addr = dt.address + (irq << 2) + 2;
 
-- 
2.54.0

