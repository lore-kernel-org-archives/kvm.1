Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C0329E7B
	for <kvm@vger.kernel.org>; Mon,  9 Feb 2026 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770676868; cv=none; b=E/xIYuGDzhkMDCqOVwbNvq1iNYOFlaZPIDc5drWaSNGVvLzMVFpeApq0uh+rqwpyxgorAcUHD5gY1hJ7PCaRrynJigkhjVgwDhMHn+aJD9wTXV5Wdb4kMZOE5GWjwHJAQXCUaoVJFQhDCwMEWTkzkyb4qlKLaXuUt6R+dI9pp28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770676868; c=relaxed/simple;
	bh=pKWQ8eiEG2mrdGJZiqdIDMjf5MzF6cSVZ2+ozjk63zY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=blC080q/cYPd9uXXHZnXUzh5M98uPXx8wERcXJV1KqVlK3uSr6aFlvzXuEX5ANecR615RFmLE7OaInp12dIt4loQ8aS3Ae8yUtT1ZJmwwFWzNO8FU9uuDjdoC/ZPgXuC1n4lFuHSgZMBam4QmfiP5AcjvpDaQw4SM8dGm3+fcQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F3rWxAhy; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3rWxAhy"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-4094c2f62f3so15450654fac.0
        for <kvm@vger.kernel.org>; Mon, 09 Feb 2026 14:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770676863; x=1771281663; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N13aFr3ll/bgxK3rlveFMtlg5cOY53+sxi39a+VtEUU=;
        b=F3rWxAhyu4/fpcC5n73l7lwudmeJlqrVt4V5wMoVxWD0SYq4ffjrkiSfRnFXsxHnY0
         tmjWL11DgLX04eUPWDCmAMDVQKJwzbs+zHadBh+sm4yrYqs6aRJDkMlTYjqU2Z9BoPau
         Q9+tZYpERgaZ5uusWrAdaRkr6WwKHhvEZ7woRYMvOpH/LaNrrbeA7GgmbMfKri7a/DUg
         5rC9FeHh8xL7wODmaLQfTQtg5bltYkq5ozqVXz0ms645Z91AqkJkxnQVMO3cv/naVqDl
         G/KIm9i9BpAeDADIfb7kae64uDEszdQ1Eu8FyPBYoUueepSNJ4jaA/iCYGR1x3ECbJNV
         tRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770676863; x=1771281663;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N13aFr3ll/bgxK3rlveFMtlg5cOY53+sxi39a+VtEUU=;
        b=kRugce7PabD9S2L85VHCUeoIKT7oMSRHyUkYnJZgjhuVCOmUBzZTLLhi9GaeSzK5oX
         uD3c7d0pTHu2nuFb9omhcntRKEOnPkFFKb/9s3PiivBKLlvpo1vXIq66nLc8wG82PGGv
         c279xliUCb1wzxSFP8DvJJFtRNNEAnxHM0+SR6BmKV3cl8P3m16WdMloDhxchNCVHxKV
         aAzt5cJMDqVHHJ1qN2M1FwMAAsaWA+G7WZo940ts9T6dkSf3rqKXiZv0xG9mZGh4rIAM
         f9PRaUTTxLKNGKWhSS3XMSGFnAwFFoA8seIguF7YblsnCvOIKT8CqZXJhCP2dk2HjJt4
         IQDw==
X-Gm-Message-State: AOJu0YxqLBd5yKXItFnlVTg3f+oRRWQWePFUEeBz/jcn7qy3ewOChZad
	gRVuwl/PpRMmGkc6s1SCIQAnStfen/BSYu4Xx4sIP+65vvoovlOKResgVbMCM5QhpRC26p/69kG
	yypC6zkfsIhpi/DoNR4Vt7RqSoBFNETKyDvFD4twfM5BprZF6w+EXd2x56aL+xh5qbScVFcBPMZ
	EagpFLHu3aduXS/R5hvHXZhbvLap/UTvEsnRG2TaYt8GzilxSYzNw0tfEoHUA=
X-Received: from iobfj4.prod.google.com ([2002:a05:6602:644:b0:957:6f27:bbe0])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:4b94:b0:662:f452:648f with SMTP id 006d021491bc7-66d09dacae7mr6166360eaf.17.1770676862961;
 Mon, 09 Feb 2026 14:41:02 -0800 (PST)
Date: Mon,  9 Feb 2026 22:14:12 +0000
In-Reply-To: <20260209221414.2169465-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209221414.2169465-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260209221414.2169465-18-coltonlewis@google.com>
Subject: [PATCH v6 17/19] KVM: selftests: Add find_bit to KVM library
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Some selftests have a dependency on find_bit and weren't compiling
separately without it, so I've added it to the KVM library here using
the same method as files like rbtree.c.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm   | 1 +
 tools/testing/selftests/kvm/lib/find_bit.c | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/lib/find_bit.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index ba5c2b643efaa..1f7465348e545 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -5,6 +5,7 @@ all:
 
 LIBKVM += lib/assert.c
 LIBKVM += lib/elf.c
+LIBKVM += lib/find_bit.c
 LIBKVM += lib/guest_modes.c
 LIBKVM += lib/io.c
 LIBKVM += lib/kvm_util.c
diff --git a/tools/testing/selftests/kvm/lib/find_bit.c b/tools/testing/selftests/kvm/lib/find_bit.c
new file mode 100644
index 0000000000000..67d9d9cbca85c
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/find_bit.c
@@ -0,0 +1 @@
+#include "../../../../lib/find_bit.c"
-- 
2.53.0.rc2.204.g2597b5adb4-goog

