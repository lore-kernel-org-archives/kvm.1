Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00D3955FF
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787610644; cv=none; b=Zew6F059LG5hpwlgS7SwvHZ/Vxuv7p0JTBDyEx70MwpX3BZO6iFkFJaWbK8uYpMmv6v8Yp4Dh9wt3nKoyTrf26uXr3lNmrk6vcHBBMujg9furH5gP1LapYPZggO9DVfAM7Z/9ELwYmp25QKEHqeaBq8JiDVW1P4KaHHn+o/Du/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787610644; c=relaxed/simple;
	bh=46PX0FlkGlV536K0GKo1yzcpkUA04/z+e0JSVcYfBMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HWjPj43GxcObTpTti9K/qBAdN9zXx6uqWPbDu4zzJ1wToVA/bBXne07AqwbtDVoefTzKHjtEgnK7lGxz63c0h002ROLyBkrHSCYcjDbPz6EA4NZMu/VruPVaflS/fGxJSjpzBvTq1FCcLxqeUbSSgTgalu64OoQ9nLUofFA+TwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPzePrLU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPzePrLU"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f6609c657so1693564f8f.2
        for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 15:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787610640; x=1788215440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ji4BxHAWPOY00GQuR7X51Lc07RsBjSGz9WKxTKhJHKg=;
        b=hPzePrLU+Llj9CkWIKV/PKcERUdcq3tq7MItUD+rrj2MSRzqxcG63SmoybwQf+QBA1
         QZ00pG3BS4BBC29sREDeC2RI+JwJSWKXsWxehynzmXpG0zWBSRTB8LYK1u/nG8+XiNje
         HpJrqgjYfA9mY1TjGEe49SbhRj2fZbeFcU5CSrRD/v0j/hBc8pCyvuF/AqrlLtGhWxpe
         hXJ72xZINMzJoPO3pD/2rebImF/DCSD1ObgO7hEgNNTVdp2DHxveU2i7SCylmf09CcZ9
         K5gLX5y6umy/At7A6qMFR66ZX+AWDmJh3bdZHkNzAL/vSyqKdTYGeZMCczPtVInYglyi
         Urng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787610640; x=1788215440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ji4BxHAWPOY00GQuR7X51Lc07RsBjSGz9WKxTKhJHKg=;
        b=ZJQlkFjtsZNYQoqi0UwZz0ZUARJKGj/L3SmVNOEqae1IjiYUdmzOsTCO+goFSTUR37
         z4IGkYyI3nnQZp8m2v2AVaExISQ6Ogy8mag33W8PrYjxJcLCMWAgHm+XCWwmFc/zuCTb
         rwL3uZfQe5pvDaiDIfTvZp7Z/ff3nFIPdw00TRXl/J5UAAzGI877JOrbC3M82yx83et5
         M6SkuYfeubxRz0brLjq3358Ip97mYTcjvqQV/ORyxT9NH/m1jbsQRFhsQZzmBgYRrZ9z
         RSvX1sMug2rPkCoO0kiD309wJQr7ruWVPMPVRWnufHSkoQuWiZuxqRCCVffNQ5JzD/tH
         MByQ==
X-Gm-Message-State: AFuF++kaaxMXlNyu13s2hi6aloxhvMiBewWuk4gsFUQWH6vbgJk7HBTE
	TNHpo+myaeOAn2+uUbeNmZ64NabJEquSOdOTDupEhNpwhUkEFn0R3BCJzdU6KWJbG+Wc0Q==
X-Gm-Gg: AR+sD11D3K+cRAXitoN9sqiyboFDGtNzbDLJwRHXRHBZOuKCTNK+VZLNtnGyCdmqo+k
	JN4sxLKvEN508RwEKUFmQNi1rdkPeEHud1qGYSu/bFiZ5Fsa05O6OlsaNGUEY1SXg8g0/WNA6QT
	UeM7xU5ncDuBS8iK+tuZOqlIEqUaJ0z8aQYQjCv94RaEI39RHznEb4xEf81n7WF90r8Qa2YOPEi
	S/Oerx+EkpBsLAU4GubLhI+D0/X45X33HC34wlshdK4cdL7WACXGMi1+g/Nsfz6BX4ipqAPYdqT
	weSNSx7KGLIJ7+3nlkxGobV8j+gn1IDwJyAicTD/xt6xvNdYlpZMdNrRRXTOSObsEoLYeCkW/9q
	WMdJ3WIfK6YbKk3u6UkUl7muHjhCajL0VRxAvVSWs3/Efn8FSkCOBOoAb6FmDCVXF/pMT9VA3nx
	sbh7LmJfbTgO3O4yiyZ4Nz9Pdww3ss3ApvhGpR9vDzlrXS81f3IrxdIlgKsRO4SifRyjZ4TGaIR
	7AqN45OZ7l1
X-Received: by 2002:a05:600c:138e:b0:499:d366:f572 with SMTP id 5b1f17b1804b1-499d656bb71mr19576815e9.10.1787610640333;
        Mon, 24 Aug 2026 15:30:40 -0700 (PDT)
Received: from hisam ([2407:d000:508:2027:836a:630c:55cc:a9e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499d63669e6sm9049155e9.13.2026.08.24.15.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:30:40 -0700 (PDT)
From: Hisam Mehboob <hisamshar@gmail.com>
To: kvm@vger.kernel.org
Cc: dmatlack@google.com,
	alex@shazbot.org,
	shuah@kernel.org,
	seanjc@google.com,
	jrhilke@google.com,
	rananta@google.com,
	vipinsh@google.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hisam Mehboob <hisamshar@gmail.com>
Subject: [PATCH v2] vfio: selftests: Include <libgen.h> for basename() on non-glibc builds
Date: Tue, 25 Aug 2026 03:28:47 +0500
Message-ID: <20260824222845.459181-3-hisamshar@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs.c calls basename() but does not include its declaration.
Glibc exposes basename() through <string.h> with _GNU_SOURCE, while
musl declares it in <libgen.h>.

With musl, this results in an implicit-function-declaration error and
subsequent type-mismatch errors at the callers.

Include <libgen.h> so the declaration is available on both glibc and
musl. This is safe at both call sites: the arguments are local writable
char[PATH_MAX] buffers filled by readlink_safe().

Link: https://lore.kernel.org/kvm/CALzav=fs4bqMM7BXNPXqhtbqGzA+LW5fgx2-1Q5=sTN5+krYhw@mail.gmail.com/
Fixes: a262fc49e0aa ("KVM: selftests: Build and link selftests/vfio/lib into KVM selftests")
Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Hisam Mehboob <hisamshar@gmail.com>
---
v2:
  - Changed subject prefix from "selftests/vfio:" to "vfio: selftests:"
  - Added David's Reviewed-by tag.

 tools/testing/selftests/vfio/lib/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/selftests/vfio/lib/sysfs.c
index 11415448b2e2..daf117a299a6 100644
--- a/tools/testing/selftests/vfio/lib/sysfs.c
+++ b/tools/testing/selftests/vfio/lib/sysfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <fcntl.h>
+#include <libgen.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.51.0

