Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8E7331EBC
	for <kvm@vger.kernel.org>; Sat,  5 Sep 2026 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788599416; cv=none; b=CqkbTW2NV4RB/msIDbRKVzF7iQv1RDBwiPwTO/UpyeEgF10j2BKENedK9IJ7CIT3VmLZkMbM0msb/6swbgnQ7zOSldJ+xAFai1EAMwUwnzYoaXwcUA9ZfNS8xRa50MamfbxMPm0D1bhDBqgjlPx+/HxWuxGAiEjvPzGNqYEstA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788599416; c=relaxed/simple;
	bh=mY/PHVc8gNPQTEZmwItYyoVwVn/6yyqbTUvlCkwozjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Stx8yBP2quJ2pR3DUcOvg4zFOHwJvuB0EGg20KEnM+hwzPZeme9QcF6lpxCyu2cLlJJokui1G+3fvhUr+Zb3hbW9xzfdBf+Knbjxa+h6FiTgNEgxza3K00DTS4GMSrhvgvjItCscroD5EWLZ3HmLCRQwHcs/8PrJ09rKfaNgrcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rih9HZxH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rih9HZxH"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-482ea739de2so1215314f8f.0
        for <kvm@vger.kernel.org>; Sat, 05 Sep 2026 02:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788599413; x=1789204213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XKDGbOd01tKKN9OyKvpXZgoSU3lxVYKrsE0hqg9G808=;
        b=Rih9HZxH1x/Zgkvel5UNHU60Rv4bciJZyfkr9r7D7h30G+Q4nY6h0Y+qV/os8aUhII
         hc5iqrrFbhUrqxowi0EN7rM8nQRpBNlSeYdIZnlYHUJUnLP6cZbHchZMWHIKrHagx3aZ
         3UdUAv/qFGj3tN72utmSLNUVsf/DRpdpdP3FBYoHX2K77iKmyDxx3S1vH/rs9gemFCAV
         KUrc++aYZKPYgBvZCbMZgDAhYeLQW8dbOY1dYVHBHzut73F2DJ03S50l/ow4R410LaHD
         cvpRDcS99K9/c01fpbK/YX0EeRiQ44bqCW7I7nuID5smOtovLz6ZPxKZ5j35ngikc7et
         RHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788599413; x=1789204213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XKDGbOd01tKKN9OyKvpXZgoSU3lxVYKrsE0hqg9G808=;
        b=tFKsV1v+JLtG3fJ+ge2jlCvG/AmUhV4OpRD6GK5lnwQvMnXcyba4ZLF0hc79CCaaOg
         HETFBiR+wiRBGrjQzcarEbOGfiHhHKPRAMreDUJ7IVYLiwgHGRh54NF6zCzbPw0734EU
         efhx7ZywT4LCrc/B3bS+zsKu/wshnbLSI6NBnDnEDbmOba58aaRvYBbw1sFVP5mZXpV1
         Mv2eYO01msvfhj2/ivO+p3b3ZAuPrXT8A4vQDiqHt56ijpNO1nFDIxqDJ9P0STM91FlP
         qk8NfznQK9Bn9hA7TTIkbDia/zxSZk78qXMoratl60AQRP+rbEtANKf81qiQbMPJ6eSO
         BcLQ==
X-Forwarded-Encrypted: i=1; AKwUvBycMEF5Dv/WGImdCT4X9D7pNkvNJZbQc+KH4j/gEgdXDzZJ6T+CG66UdnVZ6N8nnTyuqJk=@vger.kernel.org
X-Gm-Message-State: AFuF++lzLKgkOtdE06j7yCsC2BicD11Hmg+fvd/gvA3V4JsvUZ+7o8h6
	YbSEL+gE2z1oFqIkp4b094k7m7cIfRNrzKiVu2L7+JbBAzLJYzZSz1mu81PksSx5
X-Gm-Gg: AYBFou1jDYdKwXyspklqNpLasVSnGEW15Lc6P+ZtLysiKlnQj7C+mw43Ut7yb1+8CF+
	eZNJLo0fZkcOg0+QPNLokxbtJuGGxXkpVSdI0DKNy0B3vChuQG276CXapBAZTTfOP3wsdKfXu4D
	1pWav+SnLEvkfk4ObEH3PYuha4dx76aGLTgE7In+pYlLbg5ciTNfJImAk717+1RGQA8E1Q1V3Ul
	DOBheVxejarDEzOahfBvWyMT2vpCTR3v4qp/qbZTWIcATOBa1mvc5sA+4lxzVTTsYihLq2B6pCE
	s56f28mHo5tLs1IRGZa0s9YpMPNmD60W9QqnsFGesjaw55GgjNPrVPwstCJRW3QBcCy6/iv1/Fq
	fD7TvpaSfvXT3VOQYTFutNRSPEVICkovHUCPuJqg9UQ2Zy8TDy/9sRugkr3mlHLpFiFRvhND8dN
	1Qb7d7VhB01FIPXzpdejhjZ6qYQl6+xc0WOf1wmPzcCGZ80CmaVVQSCrD+Xa7z1lpYDw0lhFQaB
	x4+kIrGFgEWLIRvYkuQKWakB+nFdiZnJtEA9xXrum0N5Mp46eEck0p9fU0DX+V6Lb1hs9Z04R3V
	4vuNT2b35EQE18IItF0E5qaFZwqsWMpVkvIm80kBEXY7qva6gM5c8pMXyjqN9QTaGVE=
X-Received: by 2002:a05:600c:4f43:b0:49c:fc6e:a3d9 with SMTP id 5b1f17b1804b1-49cfc6ea7b4mr86958245e9.24.1788599413100;
        Sat, 05 Sep 2026 02:10:13 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6023d6sm217201465e9.8.2026.09.05.02.10.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:10:12 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: KVM: x86: Use struct kvm_clock_pairing in hypercalls.rst
Date: Sat,  5 Sep 2026 11:10:08 +0200
Message-Id: <20260905091008.40802-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct kvm_clock_offset does not exist; the name is struct
kvm_clock_pairing.

Use struct kvm_clock_pairing.

Fixes: 55dd00a73a51 ("KVM: x86: add KVM_HC_CLOCK_PAIRING hypercall")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/virt/kvm/x86/hypercalls.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/x86/hypercalls.rst b/Documentation/virt/kvm/x86/hypercalls.rst
index 521ecf9a8a36..e0b6c11f19ce 100644
--- a/Documentation/virt/kvm/x86/hypercalls.rst
+++ b/Documentation/virt/kvm/x86/hypercalls.rst
@@ -109,7 +109,7 @@ The template for each hypercall is:
 Usage:
 
 a0: guest physical address where host copies
-"struct kvm_clock_offset" structure.
+"struct kvm_clock_pairing" structure.
 
 a1: clock_type, ATM only KVM_CLOCK_PAIRING_WALLCLOCK (0)
 is supported (corresponding to the host's CLOCK_REALTIME clock).
-- 
2.53.0

