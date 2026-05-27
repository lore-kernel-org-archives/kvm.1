Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC9406279
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886247; cv=none; b=t37nRuDABNDtME626LdSJS9TQne7i76gKkdoo/oym1FLFu1uzWk5JjuxS2SxGsxGBJCGRLPDNoBKJniescw8KYmGYXxnJwVg0CixPRp3ySJ7RhjOpsr01hrm+AGqkISXLTFsl9WCo6LXH2SwBw8hn6leEe5bjx8DTmXBgM/5XMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886247; c=relaxed/simple;
	bh=tXElErZNcBbriw+TyhjxBJkurMB2aoqDR8yZDyyZg3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlGTbW0Ig+/wbvRuf1U776zAY031y4i2/rNzuw3ZlRYytDfDY/B2J9J39Dy9nV/a3rCvlGziflfKEFE/ShtR1PELWt5n8jvO08b2yyOEYNbzDftFPDwERAxRRW2nuIAPy6+vgYbVIyaqM+t1LsJstsYJ+HHIoPPEGgI958yMjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQCVwR6s; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQCVwR6s"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3699cdeec05so5089495a91.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 05:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886246; x=1780491046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mgdd+DnUFLn0dyt4Tw1vt7I7z+j1EUlNtFttHUygxs=;
        b=CQCVwR6sry2Ta1s19MwvxcO/AFhYRq49YQlj6qiOd5QTcUjknZ4jPkEM4r3UZaB18X
         wnYjVuPx8xrnLwF0pFnW2Qyh6WFlJCgoShIRTLgiMc/t9ksgb+IOeJ9gWCtBjGby0J7M
         YiVI5HHbfkXPkinI/f1+k90AotFpL6rUdCC/Yxh3GM7dX/+Gr/0yhnkhPSN8HOVerphv
         58bkzogohRgoul4S+8/gbvL6ZkcT7x6B5c4zE2kWTsBN45vjqJP0X2nBTlVGKJz9ayNw
         5+5RVEYafoUBlwJwl9fpHumFIlFEEqkdObKD5B3QmPXsvOgW/6/+jQulL9NkX30aZWyp
         MmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886246; x=1780491046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9mgdd+DnUFLn0dyt4Tw1vt7I7z+j1EUlNtFttHUygxs=;
        b=bKVyjYBWWMEgNCSP2r1RxqiFeL/AOesah1qozxf82vlD75W4HDZnE8yHOX2uuVWncR
         HVQkH//sgaWoA11I3MsEyngbe8kDc3dec0L2PJxnfOIqKxD2Cj/VnVAmMqlFVOy+Io+Z
         rMGm3fTUnBmkA9iBnmFrZO9gSanl/KtK+LAxzjNgK5+NasLJm9VxC5hFK7S3fwrYR4uT
         ZNFTMDwYpOE9V1Qaul3ySb2Tm/r0g+o9r/ow9hGoASqL3KoMqG44o7CYWX5FO7T6JN+J
         TDFhGgkKczT3lDsYc5+Zj3PN/sZxqu4W7i06X+00Oy5K7fUT/ggBMBYhc+Ai/jvq2ZmO
         MlBQ==
X-Gm-Message-State: AOJu0Yxqju7EcDZXIEOT905P9hZMpo4lUaZAgwxyJgtFI/Q9NdfpJQsg
	65Ofbo1+vhms+YFugjfl4SUcDluFTSzTa9sXHmyHlcF0buVZZVfDU6nw5OV1Gw==
X-Gm-Gg: Acq92OEC0Jp7FDqy5XVtbIc4XqbE7XFC5bZLAY7FJoyaXmFwP59YTb5BEPjF30n86jv
	mU2j2C56Gr/JtG3cUeK/U7ksEaPB6TwOAcNHzwz5qIxIaCLTQ9gTE0OG/7p+sKK5R/P6MmkNHkw
	RoyXeX4qPdNXVH+gkdCA5Dks6f78dNKD7/PyBwJTvOj1ayC4X18WRXiFCeusTjPIQl35UmVHMca
	fe6O5iEAJXaM+04hcrCYSjBi9Gs6/2f7rqTVRuVQRAt2ET+7psDJrVdruqmK0Dew2bYOsh0kyXl
	0jL4oWHDG19/eMntuSURUKwO6kRXzzZH93BZmg/kDb0yFDqesI3xRzYgqH7UBkpXKb23Px2OE6q
	ucXkqY5XJ6MyuR93YIM1QAwKNtz3SxNjlxBOMuqA6X+8wMday8BrrwkrfSjY3bnNeM1WCAi1kWW
	bE/fbjzVjLt2ieBjecu06VCmtHEUwL7ozJD7+HlyvVSV/GPS7JjtJjxk1guwfm
X-Received: by 2002:a17:903:390d:b0:2b4:5e0f:c239 with SMTP id d9443c01a7336-2beb03776bcmr229059685ad.10.1779886245826;
        Wed, 27 May 2026 05:50:45 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:45 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v3 07/10] KVM: PPC: selftests: Use s64 instead of int64_t
Date: Wed, 27 May 2026 18:19:56 +0530
Message-ID: <3384018316098997b673cec914aae501a6359ea7.1779885589.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779885589.git.ritesh.list@gmail.com>
References: <cover.1779885589.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 286e8903aed14 ("KVM: selftests: Use s64 instead of int64_t")
made this change from int64_t -> s64 for all other kvm selftests.

Do the same for powerpc as well. No functional changes expected.
It uses the same method describes in above commit.

  git ls-files tools/testing/selftests/kvm | xargs sed -i 's/int64_t/s64/g'

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/include/powerpc/hcall.h | 6 +++---
 tools/testing/selftests/kvm/lib/powerpc/hcall.c     | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/powerpc/hcall.h b/tools/testing/selftests/kvm/include/powerpc/hcall.h
index f923b3f5e233..21b2bf9180f1 100644
--- a/tools/testing/selftests/kvm/include/powerpc/hcall.h
+++ b/tools/testing/selftests/kvm/include/powerpc/hcall.h
@@ -10,8 +10,8 @@
 /* Ucalls use unimplemented PAPR hcall 0 which exits KVM */
 #define H_UCALL	0
 
-int64_t hcall0(u64 token);
-int64_t hcall1(u64 token, u64 arg1);
-int64_t hcall2(u64 token, u64 arg1, u64 arg2);
+s64 hcall0(u64 token);
+s64 hcall1(u64 token, u64 arg1);
+s64 hcall2(u64 token, u64 arg1, u64 arg2);
 
 #endif
diff --git a/tools/testing/selftests/kvm/lib/powerpc/hcall.c b/tools/testing/selftests/kvm/lib/powerpc/hcall.c
index cd10022572a5..d5f5282654ee 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/hcall.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/hcall.c
@@ -5,7 +5,7 @@
 #include "kvm_util.h"
 #include "hcall.h"
 
-int64_t hcall0(u64 token)
+s64 hcall0(u64 token)
 {
 	register uintptr_t r3 asm ("r3") = token;
 
@@ -17,7 +17,7 @@ int64_t hcall0(u64 token)
 	return r3;
 }
 
-int64_t hcall1(u64 token, u64 arg1)
+s64 hcall1(u64 token, u64 arg1)
 {
 	register uintptr_t r3 asm ("r3") = token;
 	register uintptr_t r4 asm ("r4") = arg1;
@@ -30,7 +30,7 @@ int64_t hcall1(u64 token, u64 arg1)
 	return r3;
 }
 
-int64_t hcall2(u64 token, u64 arg1, u64 arg2)
+s64 hcall2(u64 token, u64 arg1, u64 arg2)
 {
 	register uintptr_t r3 asm ("r3") = token;
 	register uintptr_t r4 asm ("r4") = arg1;
-- 
2.39.5

