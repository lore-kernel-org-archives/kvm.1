Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5F23D7D96
	for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848527; cv=none; b=Fjjy/Amd0bNZoKdu6DP/f1VRUczSEnjpjtVdVM3nWwLmf+T4t8+GznAok/hBPbHjEjQcpeK3x8gNGtlguKVjhSy4+X0kw2CeDi29eJ+kiashq4DpGWCO5kc/iUz4x0WzA0TJ1ajUhmGmbSft8kqBT2JU53/cKcGCQQ5qg/hUpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848527; c=relaxed/simple;
	bh=B5Xcdzm9rOjlFbpQtswy5UwwyFJJafpCUiEFad4cPDU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HQ2PeUjvFq5XK1Ftm5/WZwQM15S3Mzd3pEBMBHWkK44NNDQBJHcoI8eYgzUkC/yP00cXRhf18LtqNpCItEQ2jcM6CAwiHSA+a9S1h68gWFsvpROQnxWWS2Ayy51VNRX+Fyxvo5xACt8Aoa3lWxRpsMHLWfI7k1E7t540c71nFWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exWYFW0X; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exWYFW0X"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-356337f058aso51303a91.2
        for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773848523; x=1774453323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xZB6T5P4ZfsWiu6e60wiJZ/8Nby/ffgeDCBI/Kt8HM=;
        b=exWYFW0X5zQns+ZKl6zq//gO+CRXgNQtDmRansi0B9SbF0n9+HIVQ0MuSNjYpvJJvL
         lCd7BsKVUkXXUw77jJe5dcRAWuoQHMEmgsAwIqc0ppd85v0T3xIbKvtFq7nrs8sM7FlN
         UOMLbvBPqOMVPVV6x73hktf9Zz3B8RIP4fSwpUtJZ7QZTMfLkfVUvAJPJa/xACkRCCfI
         34Rv3pZ6WBMzSLD2MCtdwMUv+X6AmAjw8ZTgJwrwuMo12ATwyK3wWJqSfIa3/Nx4qUFy
         DNDKhNKoPohA1aLluQavXT3mDeyMCmd0c35IS/KyBuFCepXQe+0LlemlKDIO9MFqI7bY
         skhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773848523; x=1774453323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xZB6T5P4ZfsWiu6e60wiJZ/8Nby/ffgeDCBI/Kt8HM=;
        b=LCVmf1XjPyK1JdOAxrXepmCeE5r9bM7BWMTq1Zadi1Sl/TQripM+mbbd80cR5MRdGX
         i+OSFiA4Cqpz+3R8aEm1XTF0y5i7bTPyGN1IY2VLBoSdgiK7GJY4Yp3vX0xLzyxvOyUW
         UvkZ9Sd3aktT/kM7/r29GnaepSrjwbxbzEY3HhQ1bqkrwbweecblsu9wGD2CFUIkLccD
         kwNg0htuMj3LKmqyoJins+BexDn/tiqI/GGrzFCu46HjSZQJCwiKHzGLyTsJwPWqoAZn
         diNwXvVsDlZj/pP2NVJ7Osd1OGdTuVBkgqIBe//fOvjsgJAB7deIE//5EI+paFpU1jce
         6Y/A==
X-Gm-Message-State: AOJu0YwUEN+4VkyL8p36HIvI+ALXsI7TYN2RPK8IryGSNh94PxXPxw8B
	jeOZYHNIUD6e13x9rsvA6tHEwSTihXCY8FZ2OUbnnbv/qOAEynB/ktRPxH6ft4X1MKpFwEeZ
X-Gm-Gg: ATEYQzysRLmGMTy1Lxz/07y2Qm/OHDHnxlEEPMFjG0+R1/jGm7BIiYR21gzJEDWM5ri
	tjGtWvlxDHIf3POaJPC9s+7mh+X5/w7WpBJM3UUwcuErNB7AUVh4n3RwqICmk9odRKX3z+BB+J1
	1o4kj7nfVNCEg5VmhxBf+tJK4czSEjg7zrqsqknUPAVApBKw1xT4Rzy2MzX37qV6PRCoDyyhLsX
	5MWsxGDn4UGTf0d6nxK/hexm0vt6PAc7GeY4lT1DgQJL/YvX6XDrGs3BoZfaIkVYr+BorwtiRCf
	SczNkI4daYR8EBp2EYUD6M/D6nTERmLSM0G9WmlVkN0IDwbhS2JHjTtQOenReaxgkSjYKCjKOfP
	k/y8N8LceDZlMEreYu/XVojlw+hHIHAjTtzck5bRbCZGKww/b5C367v8NU78i6yGEWxjcGGjEhL
	I1Bg9cejvkscM26GC5mi6+YPt5AEde5xF0YX7e3n+TT0D+wQ==
X-Received: by 2002:a17:90b:35cc:b0:35b:9cd5:232e with SMTP id 98e67ed59e1d1-35bb9f24ea7mr3304200a91.29.1773848523417;
        Wed, 18 Mar 2026 08:42:03 -0700 (PDT)
Received: from lwfone-System-Product-Name.lan ([112.28.134.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc60117basm28826a91.5.2026.03.18.08.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:42:03 -0700 (PDT)
From: vince <liuwf0302@gmail.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org,
	julien.thierry.kdev@gmail.com,
	vince <liuwf0302@gmail.com>
Subject: [PATCH kvmtool 0/2] Add GDB stub and step-debug support for x86 and arm64
Date: Wed, 18 Mar 2026 23:41:54 +0800
Message-Id: <20260318154156.2064989-1-liuwf0302@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a built-in GDB remote stub for kvmtool on x86 and arm64,
including packet handling, architecture glue, and integration into the run loop.

It also adds documentation and basic test coverage so the feature can be
validated and maintained across both architectures.

vince (2):
  x86: Add GDB stub and step-debug support
  arm64: Add GDB stub and step-debug support

 Makefile                        |   13 +-
 README                          |   29 +
 arm/aarch64/gdb.c               |  744 +++++++++++
 builtin-run.c                   |   13 +-
 docs/gdb-stub-architecture.md   |  142 +++
 docs/gdb-stub-security-notes.md |   73 ++
 docs/gdb-stub-test-spec.md      |  191 +++
 gdb.c                           | 2090 +++++++++++++++++++++++++++++++
 include/kvm/gdb.h               |  138 ++
 include/kvm/kvm-config.h        |    2 +
 kvm-cpu.c                       |    9 +-
 term.c                          |   18 +-
 tests/Makefile                  |    4 +
 tests/boot/Makefile             |   10 +-
 tests/gdb/Makefile              |    8 +
 tests/gdb/test-x86-gdb-stub.py  |  178 +++
 x86/gdb.c                       |  573 +++++++++
 17 files changed, 4223 insertions(+), 12 deletions(-)
 create mode 100644 arm/aarch64/gdb.c
 create mode 100644 docs/gdb-stub-architecture.md
 create mode 100644 docs/gdb-stub-security-notes.md
 create mode 100644 docs/gdb-stub-test-spec.md
 create mode 100644 gdb.c
 create mode 100644 include/kvm/gdb.h
 create mode 100644 tests/gdb/Makefile
 create mode 100644 tests/gdb/test-x86-gdb-stub.py
 create mode 100644 x86/gdb.c

-- 
2.34.1
