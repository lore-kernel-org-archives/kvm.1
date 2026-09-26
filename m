Received: from mail-dy2-f14.google.com (mail-dy2-f14.google.com [74.125.229.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588E736167F
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406209; cv=none; b=TgLt8ddffMrIv465Aq8XwdTnKdyw/+2LrcrxPOWdNCod+Bi8fsiu/rSXKn44Y85QhEgBDUfsqeIrhcndVBOw4WbCAQLJYhy04ObHzTr8rYV8Fv4oICvj+nk1dATCupvGpmOdsKQwt3J6gTkGYQaev6jH73J85eoSL/dzlOSrk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406209; c=relaxed/simple;
	bh=F1BU/hVA2uy4u/aC0nsFJrQNfleF23KPTNz79rZcgVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRRVtn9FCS2/4m9ZlaiVxaX50wU93KizLmvQsEWDYVroJsGtwIpTMKyDfL5jYhZ8FhaujFw2GAiflP9LGHt3WlHDHCU+jBXcPy+5csxUcMqCOOFp4SVnxmDjBm+34HlaDvDGL/Le2sy6BjIf+OBcT2F10TPt4UTqZXuUjCqNqRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFCRd1Bo; arc=none smtp.client-ip=74.125.229.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFCRd1Bo"
Received: by mail-dy2-f14.google.com with SMTP id 5a478bee46e88-328664b7528so1430779eec.2
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406207; x=1791011007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BiL+h4U+/0i4V9PGKop4ONI8GOLawX2pYUUOBevWvkI=;
        b=dFCRd1BoTnzKZDs8jo04D3zEhNDyc0zs7QnpVstNNxOkLvNUD0TgJ9d7fpUPjXb3Pp
         usvV++1IqNcfNVMbeMUvzk/vTZE1JWWZKEDg9o1tIddYVk+/8PX5xyAHTtv03bAnm53H
         EhdR2jL9tgj2NuE4ne1q066BnoGusZj6hgUJ76TsjO/WV4oQzI56wYro2VeEI2BN1tGt
         Rvlltzepp/Zx/rGKHBBj5FHLua7t2LZnqfPsN4xf5tPNZ766NG1tyfY/BBYoy4GiAXv3
         l1UT4SjjXWksox+D75dDtxfFswMI82z7fARPtQqoOdkue9f0rjjP2yimSpI7xM1/mfrh
         8XUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406207; x=1791011007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BiL+h4U+/0i4V9PGKop4ONI8GOLawX2pYUUOBevWvkI=;
        b=2R3egOovAribp07s+BM/Uf7rnTtPWK3Y/bZa7X+a/8XsmXucehqhjJ6RWfTtBqSkWs
         5DIhldF/2AbhuuOwMdu3xEfi07Q/OiaFnlT4pv6osiSyddeeVqBgFmUmN9hXOF0JYC9L
         F0iUE35OnbTsC43xEA2YEWg31O+3DL8Nl2MClb9EggUb5yaB6LM0KsxBblQLB/ahPcNx
         ZLJCq0eKFjAuMxF1eNqXTtwZsjBKmWR+j/rA8sypkspE+P7ApCVKlcCKc9mr0NTX/gxR
         nz9Ci9fiE/Rmu7AgGuvXOIXzbnBFqweq4wEvQZUCfkWtSvK3YlD9eBvLlDIX5KUoeMJj
         uCOw==
X-Forwarded-Encrypted: i=1; AKwUvByHMgvtZH4iqmfZuyx/+K/3hQIFcFgqrq0FQZDq7n2sp6ZB7mFecQ8qWE6aWLNzq9xnILU=@vger.kernel.org
X-Gm-Message-State: AFuF++lJewBFoDG/8WpPp+2sKdpE4MNeSeQ6i1pL1s7d1sNT5AkBAK7N
	s8KbAwY/WEFTNOZ1KufvDVqeKKvu62pxdEZg1a6Nfo6B4Hc+BH4or/xQ
X-Gm-Gg: AYBFou1CIyx/eDqvj7snMNd+AxtQIVpipDV73f3INKfC7ZGV8q84c5LCPoIVf299yeR
	5cfz/bajec0QQGDIq9Z/FPrBLaDohiN/MPM3TXNqvsmrbDxkv3AATVRbXGcBF3fvuyJTdsp3ZhK
	PL1C3rEXota1gWd/TrlZL+WTM7cuK9vAwpK0R3T6LGPJzOaH6wHmUEpgJN1dWYCc83jwoSH+DaS
	HIfLmkh2DOk4hY1HhttCf1GZpEv3wINPjbP80ZIkFj48dUrZzulz5uJNZHh2LZ+44XSrCda0RId
	LubtiEywqYivI4rbGoE8TmWKklsbSJbPQTPZ+VeM3Hse80QucbFYpg8bHtVMy3EHqIVdKXgPK24
	IwiX6TzbG5gTO+60FmhpHN5u19cuYXIWJBkPkpziOq4k7J8Kl0kLD1aG+EScjeqQH4E2VgAf5T9
	tq9EEbpmzMNrcNybzjxeX2Ky4HW+C8fVTVp7OiQFlGmLvujcsU0/J9BWrnw1QAMAG5X05rGLOv1
	xGYgm229oXxTrAuMylzncwt02y4fBY=
X-Received: by 2002:a05:7300:f282:b0:33b:fa13:61bd with SMTP id 5a478bee46e88-34272853c94mr2057256eec.31.1790406207220;
        Sat, 26 Sep 2026 00:03:27 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:03:26 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 36/55] exec: compile abi_ptr.h without per-target cpu-param.h
Date: Sat, 26 Sep 2026 15:00:35 +0800
Message-ID: <20260926070057.1234-37-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include cpu-param.h only for user-mode, where abi_ptr depends on
TARGET_VIRT_ADDR_SPACE_BITS. Softmmu abi_ptr remains target_ulong,
and its format is PRIx64 when COMPILING_PER_TARGET is unset.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/exec/abi_ptr.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/exec/abi_ptr.h b/include/exec/abi_ptr.h
index 2aedcceb0c2..7e8a78bc980 100644
--- a/include/exec/abi_ptr.h
+++ b/include/exec/abi_ptr.h
@@ -6,13 +6,12 @@
 #ifndef EXEC_ABI_PTR_H
 #define EXEC_ABI_PTR_H
 
-#include "cpu-param.h"
-
 #if defined(CONFIG_USER_ONLY)
 /*
  * sparc32plus has 64bit long but 32bit space address
  * this can make bad result with g2h() and h2g()
  */
+#include "cpu-param.h"
 #if TARGET_VIRT_ADDR_SPACE_BITS <= 32
 typedef uint32_t abi_ptr;
 #define TARGET_ABI_FMT_ptr "%x"
@@ -26,7 +25,11 @@ typedef uint64_t abi_ptr;
 #include "exec/target_long.h"
 
 typedef target_ulong abi_ptr;
+#ifdef COMPILING_PER_TARGET
 #define TARGET_ABI_FMT_ptr TARGET_FMT_lx
+#else
+#define TARGET_ABI_FMT_ptr "%" PRIx64
+#endif
 
 #endif /* !CONFIG_USER_ONLY */
 
-- 
2.52.0.windows.1

