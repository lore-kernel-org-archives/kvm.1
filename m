Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E02E762C
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 06:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786169986; cv=none; b=NIzIQHjwIcMlk0gCjyo9F4YIf+pEW0dNjRxIFFD5yrffH1yGH/R6DP1f3JZfencHXFVuzEwZkmZAWEXbDpUO8/gRaw9j3oKBdJSoAKiYRTXu1Mk6I0PyI62IwkHl95pRy06JsOUAgjPXuavyfGaIRceDX6o/gavKlZsppj72jWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786169986; c=relaxed/simple;
	bh=W11b7zco+e8P2IpKVXeEYVsW72hZWQbixLyrhVbiIaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JuCnCDA74YVb91n7R1m0VfxS4MwXe9+0wF/+zXSdfn7VMYs7Y7BnKZQQBtg2LIazSJadH4zuDp85yzzeL6k6u3w5qbo1HMbLLfLxMXgB90oaIoKhiGJduA6YWIfHqt44LnApfV80xoWUFyHFrNDmYK6uZT+pk4Ob6aIyxjFIrME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV9zj4J/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV9zj4J/"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso2254075ad.3
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 23:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786169982; x=1786774782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tf+JFvFnkhWNzBxADsggU6iInPDRTBZiIUNUWTJVRg4=;
        b=jV9zj4J/Ukrkomz/YXWucF1b9fRd82lGh3gwQmRuqRXDEu+5snYN0q90w+u6cFACin
         i7htb69Zrg2b53XQ7czQKl3JHPRcYswe85RhEELkcvgchaIMXQlsZXLb0my9ZHBiNs1s
         hn2MFyn/Sv7b3OTiXYGoTX83UZM7ptG80iv/jH0JYfRIB4NzjJO8ldP4kl1eExxQPg9p
         shV82j3A49TsqD9CuOuZVgta8y0ED+Y84ULwW7LnV9VOE2hWvbAM3bRLIERDtSdbvugk
         bGaz9Reswz0fMUvve/kk2ij4JhTPXqn8Fi6V2k8heR4xZaYuGGTB2HOwihvFYCs3V3kn
         G0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786169982; x=1786774782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tf+JFvFnkhWNzBxADsggU6iInPDRTBZiIUNUWTJVRg4=;
        b=jKyAM3d4XATTaEbwLtCXTokGABwNA3osvaoYr+XwJEkm26D0hbXFotvVdf/qt3y0vN
         k3atUHlQgC6sTYt/WIlrcd3A6BmMWR+pYmwWk+m3jgW1uDjr5eOa/tiduaCew4XjY/lh
         SnXbgbBO+rTalEo/t4TSvlkdVEX2vPEupkYmKSEQkdMSB4jWCsIQUKQS7J5JBuPJvZ6P
         o2wy9U/nc2odur0esGsuZmiM1Cq85LMqCKzB661sx4aJ7QLnLk7/pcdyA9pbU6Aem5Dr
         qUKvl6XDUDYhbgcPuLXMLpQS02+tD6OxmcgLkzFNuSucV/+UTsSixyvJcZJcd944s+8B
         7xxg==
X-Forwarded-Encrypted: i=1; AHgh+RoBRoKyXzCDDANHLT2NyXtCrvot0qx16nEO2zF6WoptaVjqEhjbItEPTqg/ffnni/qJUZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAUFykR9xid27s6alWktFxHV1NSoOAtWX6C8D20smLgM3pwx4o
	9WnR2xfDY2Onv/aUdNXAnQbBmZGXQ/Fp0OWIr4zUDSi4RUNy0K08YhAa
X-Gm-Gg: AR+sD13nf8T8Wh9GAPnX6XVfWRCMlL7Wb0z05fIRCIIy7TV3Z893UyCDUaE5oeL3uuT
	WUL8HU/nfm41PpE5jZA0pzeAJvtt3MdNJfmNXvkPrGdWxDNRZ3N0jyE5j8M5IsgO4StLjDXsXnR
	G75iALHsbkeHa5w2ZbM3VUwSmZIs8sOi07JlCZeEGvLLN5U4CcEQm10FH4l8EA7chsruCowQXLT
	X2Vbfn7GEdjLR6AREX8yJvYAUSlyzusAMp+iKBpTVhDKbZXyiWeJN+7lbxsA6pyAsj6OCz0yeUF
	OHeeIKunwdtwPbBZOAR11VvCqmpTxzRGPsH8WzMHvPXVSWDbb96U29c2xGTkUnVfI81kNO8RRTp
	GVlCGpyENG+D1PBELD8l7SJrPulsbaZf5wtZySgMnKf1tox2CbF51r7FbrBWpWUq4htG+kiNZzn
	juMY5THeIJdD9zFOrsyelXWRX4X5Gcnpl+/KUTT9y+49/V3ZIp+v0zTB23qHJaE70T3DsqOSpAr
	A==
X-Received: by 2002:a17:902:fd87:b0:2c7:f12d:5d37 with SMTP id d9443c01a7336-2d2a8d55b6dmr79068905ad.17.1786169981975;
        Fri, 07 Aug 2026 23:19:41 -0700 (PDT)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebdf796sm14356280eec.22.2026.08.07.23.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:19:41 -0700 (PDT)
From: Gokul K <gokul02k@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Fix the bounds of the SEV debug dst buffer check
Date: Sat,  8 Aug 2026 11:49:34 +0530
Message-ID: <20260808061934.400892-1-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

validate_dst() is passed a starting offset and a byte count, but bounds
its loop with "i < nr_bytes", comparing the offset against the count
rather than against offset + nr_bytes.  Only calls that pass offset 0
check the region they were asked to check.  Every other call checks too
few bytes, and any call whose offset is >= the count returns without
checking anything at all.

Of the 1990 validate_dst() calls a full run makes per VM type, 740 (37%)
check zero bytes, only the 29 zero-offset calls are correct, and 62% of
the intended bytes are checked overall.  The unaligned offsets the sweep
deliberately picks to exercise partial chunks are precisely the ones
that end up checking nothing.

The bug is latent today: validate_buffers() runs first and compares all
of src[] against dst[], so a genuine {en,de}crypt corruption is still
caught.  That is presumably why this went unnoticed.

Bound the loop with offset + nr_bytes, and rename the parameter to
offset so it cannot be mistaken for a length again.  The caller already
guarantees offset + nr_bytes <= BUFFER_SIZE, so the corrected loop stays
in bounds.

Fixes: 6edd35e77a42 ("KVM: selftests: Add a test to verify SEV {en,de}crypt debug ioctls")
Signed-off-by: Gokul K <gokul02k@gmail.com>
---
Compile-tested only: this host has no SEV (kvm_amd sev=N, no /dev/sev), so
the test SKIPs here rather than running.

The figures above come from replaying the exact offset/size sweep of
__test_sev_dbg() and test_sev_dbg() outside the kernel against both the
current and the corrected loop.  Injecting a single-byte corruption at every
position the check is supposed to cover, the current loop detects 62% of them
and the corrected loop detects all of them.

 tools/testing/selftests/kvm/x86/sev_dbg_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_dbg_test.c b/tools/testing/selftests/kvm/x86/sev_dbg_test.c
index eaa8201b937d..0277e38e3556 100644
--- a/tools/testing/selftests/kvm/x86/sev_dbg_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_dbg_test.c
@@ -14,9 +14,11 @@ static u8 *data;
 static u8 src[BUFFER_SIZE] __aligned(PAGE_SIZE);
 static u8 dst[BUFFER_SIZE] __aligned(PAGE_SIZE);
 
-static void validate_dst(int i, int nr_bytes, u8 pattern)
+static void validate_dst(int offset, int nr_bytes, u8 pattern)
 {
-	for ( ; i < nr_bytes; i++)
+	int i;
+
+	for (i = offset; i < offset + nr_bytes; i++)
 		TEST_ASSERT(dst[i] == pattern,
 			    "Expected 0x%x at byte %u, got 0x%x",
 			    pattern, i, dst[i]);
-- 
2.54.0


