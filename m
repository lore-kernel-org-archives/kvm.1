Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E63D38E8BD
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780239227; cv=none; b=gNJFyDJv0lOpK2dL/7QCPu1uG9g1ckzTeh6rlxEfi6EqrL1kmZe26o8fa9l9uBQ5coMqQ1xCBPzRkPq+RKUUITujbDPuqflu165cNZTfYjrPkcCv+Wnq23+iou5KiS3+FbFGw3JudkXps2+g4NpV3aGGdCclUDtV/nvELlCcyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780239227; c=relaxed/simple;
	bh=XK51geeL3+peWDyqzG1dtEA1t9N0Y1/v6t0z4dZe6eA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnQR36JBcGgbWN7ZMshTW+ZDRWQtHr+1qLQU2Z096jBx0Hg31g60dL+FtAqxf56kuzM2n8S6b05HLkL6ZYON48ltqQNbbtpfDJxe8MHauKljQWf0tjkIsxqFw2QUN3i2NmV5DElELg2hwDLGnBZolGSkKb7MVLuP+QyfDOQNaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Saow/BR8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Saow/BR8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490a7876f8cso4143515e9.3
        for <kvm@vger.kernel.org>; Sun, 31 May 2026 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780239224; x=1780844024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cFQehZMTwDLdoBhXrsPY8v0PLCjeGjVTdtI7THwMy3A=;
        b=Saow/BR8NSyqvKaQWIzsTHW7f1LgOJ92i0jflT+Xlvl6nE1Jqmg0nb4ZaVqFzG6mjR
         R6anqEJKi07bTKLlpIHZGSY0Rdv4oDBrP0HP0I/cRmoT2H57EiKddAyX1jYikiYTcR6d
         5qQwkekUZNQ4yPkIMX3RjYYc36NtTxQ3xznoH4AGbZKDAqxIszHjUvrOqna9M75OBaZ7
         BGAUHYIABUaNsdukFnPaxubj3sY4+AZh7I3q9YXsf44NXzl090s9YwHKFeMUfGS15iTU
         LgSnPCeX1ec7AMVFt+jH3WqLBUDUo/v40dMxUMv594+1/oHeqdV5rIZz1DgwPC6Pu5tN
         EVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780239224; x=1780844024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFQehZMTwDLdoBhXrsPY8v0PLCjeGjVTdtI7THwMy3A=;
        b=ddvq9hTbBvdiFTf4wLXPhNkuj76UH/l0D64oPKGD4AZ938RyI/RtYAHiQ1cs4eOxXK
         Soki9TfKOVNLXwUMVM3jlExX7JPXx3JPJ1jfcK9e/Ct+Ex+wAkBDZlxEGt4HWH9D5jUL
         BxRGj3pAhdf8UH6/X1P/2pDim2lKFad24EIFcUAgZgP1hU1Qbvu5zU6QGjrVmq2Zh/pQ
         lLehyHkGgdw5pPLeUCQr9deyVF9vM6oQ3MQvdH1UUyT6q5FLCOO/+ol8rEeNrkh7IDo5
         5JnweYilskF8SvXstYe1ksy+4HKBD0nBG5HI/p6JS2+QHZcdJHwMg7PbohsVIFkGwmvU
         9rcw==
X-Forwarded-Encrypted: i=1; AFNElJ8KnwnLVZ1CrMbnHHvlyogYMF1Npj7lKfAf1UQFCu0VfDlaez1UXXcBOwVqe2Sapicv4mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZQIZBkoXpqJF9mZ0o1Zha4NEHhg/4aAsSdsJ3C4xx2CGIxJt
	FohW2EakJe3V41dyz2p9wNHXmFQZr05D8SYhX+n931ZpRboOHtAU+wIP
X-Gm-Gg: Acq92OErEE+BqtFFmOlD5JdjzVHTgFoE/9qiIAZkMxpFG7J3eY/7SbFGENPE91LuKxg
	CVE8fipPhgoFgWumwF3GA/qCQerOsR3Y0Ua7K9+k5zdQYU1KzeSDy5ObbMYuwUYnKBE3L0Tts3S
	mJBYn1/JoAQdxwOPghWJCL4H6wRY1ycF+Ts29saD2II1mBMxsSp8rv+nW0XgZVkp+/XZopRgVqh
	IoD0+GZQg3dRap+V05TSEFKan6qfKD0lZkDy9Jk6AYSJiptB5XAJt45sI2LBELUTiO06/Y3fcrX
	DlPRNn3UKt/u2ZpmC8XPwEB1+BsmX88pDZk9inCqDcypCpamDYBpPTIKeYmsKcrPHi//7NznTJW
	eJLbRQgqNRw65aDzCJiKm50yVqXti3wV2wW1qRVirc/PBdSHJe5JWHivv0oj0Kko+5gr//v4OLx
	QmIvW5fuYnWHiCu567rPY0U1s=
X-Received: by 2002:a05:600c:4f89:b0:489:e696:8362 with SMTP id 5b1f17b1804b1-490a292ed68mr133428765e9.13.1780239223323;
        Sun, 31 May 2026 07:53:43 -0700 (PDT)
Received: from hisam ([39.40.47.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0ad269sm59217195e9.11.2026.05.31.07.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 07:53:42 -0700 (PDT)
From: Hisam Mehboob <hisamshar@gmail.com>
To: pbonzini@redhat.com
Cc: seanjc@google.com,
	shuah@kernel.org,
	me@brighamcampbell.com,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Hisam Mehboob <hisamshar@gmail.com>
Subject: [PATCH] tools/include/linux/types.h: add ulong typedef for musl compatibility
Date: Sun, 31 May 2026 19:49:36 +0500
Message-ID: <20260531144934.403888-3-hisamshar@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building KVM selftests with musl libc fails across multiple files
(e.g. memslot_perf_test.c, cpuid_test.c) with 'ulong' undeclared.

Under glibc, <semaphore.h> includes <sys/types.h>, which exposes ulong.
Under musl, <semaphore.h> includes only <features.h>, <bits/alltypes.h>
and <fcntl.h>, and does not include <sys/types.h>. As a result, ulong is
not visible through the current selftests include chain.

include/linux/types.h already defines both ulong and ullong in its sysv
aliases block. tools/include/linux/types.h mirrors ullong but omits
ulong. Add ulong alongside ullong to close the gap.

Signed-off-by: Hisam Mehboob <hisamshar@gmail.com>
---
 tools/include/linux/types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index d41f8a261bce..ccc90dd4baeb 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -42,6 +42,7 @@ typedef __s16 s16;
 typedef __u8  u8;
 typedef __s8  s8;
 
+typedef unsigned long		ulong;
 typedef unsigned long long	ullong;
 
 #ifdef __CHECKER__
-- 
2.51.0

