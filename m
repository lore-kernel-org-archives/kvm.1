Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359823B7B7B
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 05:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499255; cv=none; b=aBpxmvn6ZdfsO4d2OXdWwmuHzt78KK+pv4cU12ACJPmyv6wO+ob0w/NKHhY30OfgXvpWpiKS/RwDIs0CIm6icxjgCFg0u0JyHPWMZhu57+n7fbB6aWnm04Dw89GN5cu96GvAjZZ3uK+PcANa6lEk3jhvIXtQ0qjtO8VlXwB0L4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499255; c=relaxed/simple;
	bh=1efYk6YAdTzdJ9YjN9WoZ1h5m8a3Ae6k8ZyGafuKg7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J0ZbLXeBXYPWrqIaN3rWcnzaweNozeJ5DZTxrhOb/RiHzppOI7bgZA6Icgy/8M+x5hh9OiRqRYk0UaKzWWOaGDU2AMk19HILmLOgBXgpydhT0UHmbHsSKtSoIisTKGIxtSS+bLRxJhnmhjzbPU9AFBd3OrJoIT31Oivy9f50/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXiGgXWc; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXiGgXWc"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-398c1101c1bso581725a91.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 22:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788499253; x=1789104053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N8nhx59l8O2wS9fd/hyLR2KGFd79BQ0LWN0fdxxg7Fc=;
        b=cXiGgXWcimrbc1bTpiRxfsx0ny0B3yblBCXXHNuRZRnnxTQ1JFEny78Fd0y2EMTWKn
         TL/oh88LPszb+A2IFDIafKss9GxKvRjxOMqXkD9vU9xbjcF7pZCHitz1rucTIrtiyqzb
         LM6vlrGuJDuNsdvozd6xsFs/UQMKs6SUUhTBmI0u0GUux7yCACuGJcWxu631oEzvABH3
         mUR43MawoezdMyeEnOdYoFdtXmuN1kdi2QfpD6ulbsQzoM+IYq2kz5SVhRgTyrstPs7P
         dF+NBUBuq2UuPFfqaTFrKXpUcLqatcqTbibwEpwWfHzgIOY1gMCiJ/UJ1i1GkRVhZy7J
         CQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788499253; x=1789104053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N8nhx59l8O2wS9fd/hyLR2KGFd79BQ0LWN0fdxxg7Fc=;
        b=DyyF25ioGzVSbaJe/N0ROSD7AIwjgfWk+p80iop1nKusjsq+n3tquFDflHm0TNCs+E
         gDLJ6woL1Msr3/ldfJeD+lvXZWKtwnIAAikxobXgqKsybknHWxLKHuC0Dkztl2RcoiYC
         kuMNJr1ra1QWgSFpe438WI666urfdRe1tophVnXVjzSH4Bg2heWqOAoQ9dBxX+tBBe3O
         /h9UT6lfS+f/hTU4xIH2MdJCxMSNySmbzL/GXK+F87HDS7NQrTBbV/py7ezn45cU1lg7
         IHBgTe6hl2k+R0q9iXjqDO1JuoPg/4pImd4IoseJ3r059QGq4UaOzU+ayOuYkWORTvn1
         7POA==
X-Forwarded-Encrypted: i=1; AKwUvBxyJz7cPaXGznKpp7Eiet/tYmjfYwrp1BHw/e6Vmhz/29Ygg2h2Zi5n3ix1cUcAlV0+KOg=@vger.kernel.org
X-Gm-Message-State: AFuF++kMRoAm41nDX3nfp/rc5vZc+QZCtxYTOa1mRuDMdDAhSsEsKd97
	G6Dhvk6K9qNXoLidzYcCEknFMztjuMbOjh77bPUhNXfgi0FlOWKWmFe4
X-Gm-Gg: AYBFou3d0C+lDLWtUvDlwm8NXMafF0auTXx2ykPkFMxxDk3ip+o/atDxb32LCIqKDqE
	a0XRgZpYgyVujyKtYJ01ENrXnsc4zjHzueA+oS2sikdPZd/0jaZxOpziRxDHRjy7hxMiPMinIxu
	26KTrZGqwxBc+gWaW3jDkTVbiwgeOpWWmrQMsIBzWtiCxjZzF28sjnOmNi17NP278C/RzNtX8aB
	FipMUYZB6plCXDTCH694HJSZF7vZlBqOEOCzRGNvU/+pIwVvyD39b1a0ufMb2pgu6e14Nt2qMyl
	E/SFeW20DtQ34Cxf7aS4Kl6CtsnYHG7oAkQcO5tPkb9S2vJejDtU4m40MWkbjwUSMwz+8zKjO/9
	Y4gixtqcxU1WIzY7t6isuT+Czb5tLEp0US4bj5XAO/sQYWtQHXymxrhrEFJy7JAwIlBdZSEfEDT
	cCiOlTCJdB5czoNFxkttnVrdAd4yOy0Q9UDniGfsVDq5oaW/ajzpVWwELmiUpctIz1g3sC4QDXB
	w==
X-Received: by 2002:a17:90b:3b52:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-39b26101d25mr5197743a91.8.1788499253348;
        Thu, 03 Sep 2026 22:20:53 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324356931sm5952481c88.4.2026.09.03.22.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 22:20:53 -0700 (PDT)
From: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: shuah@kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nagachaithanya9911@gmail.com
Subject: [PATCH] selftests: kvm: Fix transposed calloc() arguments in the uffd helper
Date: Fri,  4 Sep 2026 05:20:33 +0000
Message-ID: <20260904052033.3648259-1-nagachaithanya9911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uffd_setup_demand_paging() passes the element size as the first argument
to calloc() and the element count as the second:

	uffd_desc->pipefds = calloc(sizeof(int), num_readers);

calloc() expects the number of elements first and the size of each element
second. The product, and therefore the allocation size, is the same either
way, so this is not a functional change, but the arguments are misleading
and GCC 14 diagnoses them with -Wcalloc-transposed-args, which is enabled
by -Wextra.

Swap the arguments to match the calloc() prototype.

Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
---
 tools/testing/selftests/kvm/lib/userfaultfd_util.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/userfaultfd_util.c b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
index f7ce5a6ddcc2..49eff05b7d39 100644
--- a/tools/testing/selftests/kvm/lib/userfaultfd_util.c
+++ b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
@@ -119,13 +119,13 @@ struct uffd_desc *uffd_setup_demand_paging(int uffd_mode, useconds_t delay,
 	uffd_desc = malloc(sizeof(struct uffd_desc));
 	TEST_ASSERT(uffd_desc, "Failed to malloc uffd descriptor");
 
-	uffd_desc->pipefds = calloc(sizeof(int), num_readers);
+	uffd_desc->pipefds = calloc(num_readers, sizeof(int));
 	TEST_ASSERT(uffd_desc->pipefds, "Failed to alloc pipes");
 
-	uffd_desc->readers = calloc(sizeof(pthread_t), num_readers);
+	uffd_desc->readers = calloc(num_readers, sizeof(pthread_t));
 	TEST_ASSERT(uffd_desc->readers, "Failed to alloc reader threads");
 
-	uffd_desc->reader_args = calloc(sizeof(struct uffd_reader_args), num_readers);
+	uffd_desc->reader_args = calloc(num_readers, sizeof(struct uffd_reader_args));
 	TEST_ASSERT(uffd_desc->reader_args, "Failed to alloc reader_args");
 
 	uffd_desc->num_readers = num_readers;
-- 
2.43.0

