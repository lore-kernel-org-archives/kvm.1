Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3872737E2E5
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922130; cv=none; b=S1UDZvwYLpepS2CZKOvIullA34BjIZEqYtWYNdpMJXaV7wtdH/Utpt7KtexA1Pmf0XoeVN3+cWwy/8kORjBkZXJH36c9teFwVt0MZi01lgUrF74kJrJkRNY46GKDA8iuLKvgBITD+krkiUVIrxpJCj9sN3LgqrZdFPy6AZXfE8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922130; c=relaxed/simple;
	bh=wDDjiPFpMO+4+MFXsZoHiv0/XrEQ5EIffCpyBDzPI60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sc7hUZaA03Sx6RjffFkj3nEg6U1vYkmxSYv0KIlMdxs5RgxNeUolU//KXDK11XkNpW0Lahx9Fpi+/mF/IRqO6/zgWQNM5bBuS6hpAKTLPgxQLOQGzzHiW8F7RcUBxWnPVkryNQo0117commzp5F6DLpfgxlZoyNPF0YTRXINO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YF9YNrxP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF9YNrxP"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bebde8a0adfso60919566b.1
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 05:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780922126; x=1781526926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Od8acjQH46yIHcWew7v4maQr825FRBX6sALt6TBXWRQ=;
        b=YF9YNrxPn+s/CV4tbr4MepKsKQ8z35U6Y9R8DrPxo8CSDtZmxtWhVtu/LKrdrRNGRA
         iSKPtsr7lE9PUC4Wf4Z7IUY0VVS/QEPp2m2q4poYxZok9y0ON0o/O5S59vaAEMczHWTV
         bo07L4qZ/LEgFsM34kPUgoeoD0/k6jIx8omjwYekeaUB1YleyLOyFDeBMLri0kBJCIWv
         Z8KJhivg1UtxZvJbxwwiw6CywLLi5DSFDMentye4R8IoYIUoBmo4zIzFwI66jL9ogEVL
         MmSRbRZMX5LpjcPyOiy1XQS7+Q3BxYsKIJ+o0EJENOMnkutYzdwC8x6Ja/zHIuCVrv3i
         6o0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780922126; x=1781526926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Od8acjQH46yIHcWew7v4maQr825FRBX6sALt6TBXWRQ=;
        b=SwHwNJl4VGRirb1MxB24za2mxEh6J5P52TqvDjImnLsUXBvZy2aljRr1mejDuQmIux
         BEXyhtrT5M+ZPWZlJUXBQNFm127YFDZ87cvHmriI7iPxAZbXd8qC142jO9aL5ww6y+wU
         GOXNhYx9MxCB2nWDqCQlEjJqRPE0T+CKyaGbjuIpk1NfvlMB5XCBD5bi9K5+Ffwv4Bn2
         f2KwADSw8HRyvQQxMXXhfvrtG+34shogfabBObOEIm59LJKV+ndLLeB9xZphifXegRUg
         Xd52xHnmBcwf3Ncc98ztqDY2R3T3bNPAznk9ijGF6nFSRe5v9gTrhIrhgWab7RMpa2p0
         Uqvw==
X-Forwarded-Encrypted: i=1; AFNElJ+fzsjAUODdNy/O+THqnPSOSBXZP5pFAM8MyJkj6K/hi6BPCCjLeEa+JJo7TihTjkNvyAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwubuV4ZPqGl3GHCLFxnO7KgFDPpEG0G8RPhfd5U6h8e+xh/mhv
	xMrw7RUMeym9pSOEpylQwxvkzSe/4bH4/jDjieR6DEjtnRIhFTxaMg6b
X-Gm-Gg: Acq92OGSttjsr0VM+uX+qRogszH43rD3sktk6SkvjGHbaIG0qa8LQuE7uHKT1qqqZ0y
	HZBge5kK9/zgHTsM18K7uqrPCg9Kj0S4u4OtTmW8iH8ylqQtSY0GIpUUNbazI+AynRvjhHUKF+C
	zpBPRjbgQ37j78w2pz25J7YSYEgUWUQ9WT+acWe0Qk4SOy+HB9nvRH/xh7uZ+c0epNNqLM/7Sgy
	XIKT2fY9p0PlOE36z9eU4HKh8UkFF35fodoytPjYr4PepJZzrBegsB8+p+NgpOEw4+ego3JzTHT
	+swD5iVyox4lLfOyb6bmHkghxEXd10MpKWQKY1oV1vnTgjDSnYOp1z+/9yvlbHmucRtxA52lmCI
	xWzi91TM0FTUEKJa6tyhd7przUV0YrpEflDGzPq22aMXPwZvfCcdb4aWe10y138kgg7xxADyJlC
	O1lWxABoPzIIeZywFCznG+UMPD9xHWLHAbiGGTcyYA3SJ5qPSKmIZ/JcwsF2HySMsF3lQ+
X-Received: by 2002:a17:907:9621:b0:beb:c327:8e7b with SMTP id a640c23a62f3a-bf372932950mr381648166b.3.1780922126440;
        Mon, 08 Jun 2026 05:35:26 -0700 (PDT)
Received: from Kayra-MacBook-Pro ([2a00:1d34:85f:fd00:89b:7f3a:f691:1b4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf3e39647c4sm485107366b.63.2026.06.08.05.35.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Jun 2026 05:35:25 -0700 (PDT)
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
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] Linux 7.1-rc7
Date: Mon,  8 Jun 2026 15:35:03 +0300
Message-ID: <20260608123503.23298-2-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608123503.23298-1-kayracizmeci@gmail.com>
References: <20260608123503.23298-1-kayracizmeci@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e3aabcda1ff7..e156e2696efe 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 7
 PATCHLEVEL = 1
 SUBLEVEL = 0
-EXTRAVERSION = -rc6
+EXTRAVERSION = -rc7
 NAME = Baby Opossum Posse
 
 # *DOCUMENTATION*
-- 
2.54.0

