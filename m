Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185540;
	b=aD0buPN/CZib6mFH/Vu6h3ZqdqBcpa+DKyzf2uWm/m01aSBWQeH3yRCmWCBLqfX9+f7C
	 VGP9VR4AAiqsyGqoz1SzGF5EwWdoxecumcMYYM46A3NYpu292izzE8aGTvtzfafieeurR
	 2MxzAjSvDCZGh4QOd80YeK7BzLSzDF35pC1uDNqMO9dfVFgr8dvjqvsl9qUT84RJWAbx+
	 /OfLxbQh/uCg1PUn1mxUSbDUnr/pSgyB/H4CeDSib2hP2kLX2gWmSmhoF6SOhcPxhfRsB
	 ufv6D6CeA57a2BYDfnkol9Gd8rpg5d4uq3QMPH3GgBv+gm6Ze/kUnpjBKqRu8abmYfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185540;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=RD/JwSVMdYCkTqN36PUhFUFbXpufIIjTnS0XSwKWXaU=;
	b=NF3bK6ddFthFYDeCBtaxcozXHREKyhPxqrSWn/ec1YKwTVxcP1eufUz90zkoY1Cv9Fvm
	 f1JvejBJM/2VGS17ucEQi+UrzwJ/diVa4SSd4zvPH1CHJVLET7GfUxT7eov0O69v+rVF4
	 xxx9H7AIGZ1IqLVO9/eTjbUNxty/LMP5o2lAO2lTR64k/dOsqLDvYrN+4sWyW69EL1k7U
	 QiVc6+SR0gr8pmmOB1vlkIRJp7jD6ZQnXSli21btRI+IiNBTf3Cw1yXk2ZC07dXY2b6fL
	 iTzUNj3AkVgoWnfmAXsw5eRHXxlzfLNbLrDlniAM9DC8frUw4AcA44gC/c7jyS8JocA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kjd00MDm;
	arc=none smtp.remote-ip=91.218.175.135
Received: from mta0.migadu.com (out-135.mta0.migadu.com [91.218.175.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C0606A325
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 14:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A9C0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kjd00MDm
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bb8afq8xtL/vMdBAzmEQguclD73wS9FLs8xAh3tR7mo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795185537; v=1; x=1795790337;
 b=kjd00MDmBkPyoJr3LkxkLjrAiwy4y/zyj5li4Ot/YPTsFUKIdmwf4jrFnjdkTvJSM7mRpjVA
 KEmHVja0TizmwDNWkyQlRdkUV27H6/kcXZlfCyH/eA7IO5PCD4S+ppABBUZDICVbLCt3PPq3T6V
 ZfahDXjARkJrlbDUHJnlkkQc=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5380d9ba85e98829;
	Fri, 20 Nov 2026 14:38:57 +0000
X-Mizu-Trace-ID: 5380d9ba85e98829
X-Migadu-Flow: FLOW_OUT
From: Andrew Jones <andrew.jones@linux.dev>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH] kbuild: Regenerate asm-offsets when headers change
Date: Fri, 20 Nov 2026 15:38:26 +0100
Message-ID: <20261120143826.1428887-1-andrew.jones@linux.dev>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The asm-offsets rule template expands $(CC) $(CFLAGS) at eval time,
before the top-level Makefile adds $(autodepend-flags), so no
dependency file is generated and header changes leave stale offsets.
Escape them so they're expanded when the recipe runs.

Fixes: b9423a4fc5a9 ("kbuild: Allow multiple asm-offsets file to be generated")
Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
---
 scripts/asm-offsets.mak | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/asm-offsets.mak b/scripts/asm-offsets.mak
index a5fdbf5d6d6d..1e38897d081b 100644
--- a/scripts/asm-offsets.mak
+++ b/scripts/asm-offsets.mak
@@ -35,7 +35,7 @@ endef
 
 define gen_asm_offsets_rules
 $(1).s: $(1).c
-	$(CC) $(CFLAGS) -fverbose-asm -S -o $$@ $$<
+	$$(CC) $$(CFLAGS) -fverbose-asm -S -o $$@ $$<
 
 $(1).h: $(1).s
 	$$(call make_asm_offsets,$(1))
-- 
2.56.0

