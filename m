Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53132BDC32
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777646766; cv=none; b=jCLNUDqsYJ/nufdWDCoGQAUml3dqR88ykf3BXsVNyBOr9CVhAKV1qMHD01PITCwUyOSv/VJav6pEz99hLarIQEQQ3N3/WZ6N0fusFNYwr+XUu5e4yqF0sa7tbgvQ6bIhSQeEcA8VVRoSfMDMNRGK1Jw35bAZKvyODzKfQQ0FqQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777646766; c=relaxed/simple;
	bh=8+SYuy3/V8HogtLO+S7kYhDAmArGFSu0qCRo8mG2p+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNEeMwzhqavlX9YFJhJRYo7pkiVWe9g5whCu36jeVm5kPFWQGwwdoDSVxUEDiSNLrEyef0BDx/x7oo8T3agkj4cw3CY6QnddrUNYfJ+rlTr7V8DaELZsnQwGK4DaOffeTRLrv2FYp7dm7dlJWBh3x1jKCMqeOCSSglNERw3uVMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORDo+SaB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORDo+SaB"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b941cd869cso12224355ad.1
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 07:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777646765; x=1778251565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WemtiGdq+I+K//LbOUkC3ojvlcJlzW/WyY9SxNsaYiE=;
        b=ORDo+SaBYgTq31CkzVPhszsAHINiECUWzqv+Mf+R+qXHgbBxlfJ+QPvvCNYlBBDpMe
         Rvuh47G3OzB72/PhR7XXX2JPBEa0+Bi1U+i0QHjO1pwzKLZYXDkMxEajaAtcMq11gB7T
         i+iiQ9+NbJOL2ArT/6kELXtKRATOn8W8GrUblxaOi7BdVgBXqnAyWrod9va111yplBLW
         wSFSRaWBd3F9JfRdwQGX9U4AHnWW2u5Y9y/JrBKCi5O9fhczaKfwLENHbF5T7Q1lSmDI
         XZP/asudV+JLFKz07fz0UXOtSVrEQ+HF2YI+HC44mcQuUmCy0U2pmvzqb9H8zufE44gP
         9eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777646765; x=1778251565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WemtiGdq+I+K//LbOUkC3ojvlcJlzW/WyY9SxNsaYiE=;
        b=oyonssINLQVgirB2fom5qCqUi1Okl2wq5GEbj2zKpd+oRGVlBXGeblsMpvvEuUgQ1p
         P/7eFad1LXGXEsVcNvPVCGXtAR9HbNfSOvsxjfOPwigECaHeviNG/iPr515pVfWLMdAA
         3KEK4iJdLmgzUk/YiRILW0Iq2Xl21lT11KZzCfSnYXvViFVwT27FtWDQvTc2lurzijF+
         POky7RPDDwm9w9n4e9DO8bS2QLb+JG8mMTrh95sF9VAln2ah9nD+c/U3p+Dzy7NSAani
         sC+9y7S52JTMTq3RxHqfGjspok25caXCk6nfyrJ5YcfKbkIHcoAaFXeq17qV51zDBmbI
         bPNA==
X-Forwarded-Encrypted: i=1; AFNElJ/xdVUUszTBMDafWD+HqYwySdpxVCMoMsde4DNf/wSP0naxP7NMQCdQ/n51VbjNyHllUvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQh7NE4mQAH9JL3IlbHPmLuZRm6vs3tOJnjrg/I0r7bcQTw3ag
	1uJePnnpPlSS7aOhQZp41Qb++KmNwsMsArpKBvX3qqtYYdMwhMnIe0bi
X-Gm-Gg: AeBDies2TypcsT+cdd7us5ZY0eC9WiWHw0AkjE7ceWdAuBBtF0HrdQbbJGHdh6TvKtY
	YFwr36s4M8dqNkdud3IwO5nwckCLOFud7mStVFbAiHQ7ud57Y3dlBQDPzs7Vu0UIV0jjxWJ1Loi
	oryDW3lhqoqiTnKuaZ4Fec4HR7C1Os4xmrwH2ToojDI67hwhpfDmob4oDGDkGVbAAHuTE6bJZj3
	ZAtoQQYCj73pnJMgwEL2QVffPYu9SgPRFao5G1RIfAKK+iirJmq0/cG8mnY0RJ4un50ZzW89vH3
	8CCXjJK3wSz1yyRS7R7uDD8r4A5WvjillM9C6MCNlOx4Jmfkeo5ap9WC7LOannmRtKvWaBXrzfQ
	Myej9nbhOg04+bR04jsDyyFKUi8HaeTLR2RG3TyyiZ747eyUZVzeeXQl/TEDcFbbuE/99JG0YN+
	lhleDqU577+Tl1Ln/tenZVZzNW5h+3CK77Am80+Kv1F++vlLaHgoC1/PZum4En4E2YvD3K9sqbF
	Zf1VtWAwzgc
X-Received: by 2002:a17:902:848f:b0:2b9:547d:ce1f with SMTP id d9443c01a7336-2b9a253e0cdmr49989415ad.37.1777646764898;
        Fri, 01 May 2026 07:46:04 -0700 (PDT)
Received: from jiun-HP-ProBook-455-15-6-inch-G9-Notebook-PC.. ([222.99.195.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caac6e7asm23710195ad.30.2026.05.01.07.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 07:46:04 -0700 (PDT)
From: Jiun Jeong <jiun.jeong.cs@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Keith Busch <kbusch@kernel.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiun Jeong <jiun.jeong.cs@gmail.com>
Subject: [PATCH] kvm: fix typo in call_once.h comment
Date: Fri,  1 May 2026 23:44:13 +0900
Message-ID: <20260501144413.49419-1-jiun.jeong.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change "succesfully" to "successfully" in the kerneldoc
comment of call_once().

Signed-off-by: Jiun Jeong <jiun.jeong.cs@gmail.com>
---
 include/linux/call_once.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/call_once.h b/include/linux/call_once.h
index 13cd6469e7e5..1625a9d6ff5b 100644
--- a/include/linux/call_once.h
+++ b/include/linux/call_once.h
@@ -36,7 +36,7 @@ do {									\
  * it returns a zero or positive value, mark @once as completed.  Return
  * the value returned by @cb
  *
- * If @once has completed succesfully before, return 0.
+ * If @once has completed successfully before, return 0.
  *
  * The call to @cb is implicitly surrounded by a mutex, though for
  * efficiency the * function avoids taking it after the first call.
-- 
2.43.0

