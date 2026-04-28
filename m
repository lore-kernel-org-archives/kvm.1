Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A7239DBE6
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418835; cv=none; b=iZHQz/t8fC+0L5DHKklgOxEYrfPBchxl2KeS8T3bkwUVXIL7c/9CTQiQKFDkgDRInixIhnKWIFNL5O7BfWiXz9qpLR1Uzqfn0EJ1G8H7Xz7FxJEr6WuYLO/IRy94sGbRu1ovCztn4tCd8INn1NtUk+Mc4bo3f2m3zKcv7i1Il/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418835; c=relaxed/simple;
	bh=7y7W3gxpmzQz1hiasjRf2DZeaIf/c4efp3xC4UDsjzw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JdJbfhu1cOtNWDvOqVRfvVaASR0YfEuoF+gYxf002NOmMG855DvMPy+q6nd2TQr7Lig+HAZPwnc9xnUtbPi187YedyFD6lalTZuhflhqPZiTaaSUhypdNPNwKUYBLW23uAqtWzF8AsUyJltnS8VIC2s8Y3+KuMWboaY3Kv4KVfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U9BtImIp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9BtImIp"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35e59791605so13063842a91.1
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 16:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777418831; x=1778023631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7phDv/pQWSM7X6O/hsO/CGo6GRlLKm+dH4N3lxKr+ww=;
        b=U9BtImIpe1Z0/FBBrkThwzc/vGkemLVi+L8BrqQEc0/kffmImib3dEnod3n+Qwmcrl
         NT4UL3fP6kJhwSMwn/sPuLw4i5XLOj0dpiX1zeEsRx5BiEgecFKdOd1EtPH1UNAAON7J
         8XSobb9sSrGK+c9lE4Akwlt7SEqpVBFIq+bOMuBkG2Hxeyo+rvwHlT1v6O4ScmF3gzlD
         8xyiPJ4XYfxwAomiFtOdk/2bHm2bEeesEV6OBfKNXqzpS+bC3ae2xC/+GRkzNghBU1DK
         jdFsM3JcM9nvqY//EMSi01OqzkAhKrqX18V5ByaL/p8JJhv6371hoFOaT51/9wem+Uot
         AjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777418831; x=1778023631;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7phDv/pQWSM7X6O/hsO/CGo6GRlLKm+dH4N3lxKr+ww=;
        b=omLQpNxHX2v7hTAlIR7qH/JAIKt3iH/wakBLYhuzLl8Liaal3Ge4ewn7yEQsEoulXt
         46FFy8ZWZNWuCO/tWZ8pCgbgdBkfWsmvAng68mywJ/vOxd8j7HHAEl85bVhw9qfBVGUW
         cLQ9FQzBzbWGAVhyrBX2CAhPt7C7jxZHWhWt3MiTwDlxuJf9uaapE2XSqPuAPxayZKXO
         +r6x4Mn+Rnoxu2MPtvYIUmXDalkPijVrVX6uNA9oU/HjVe4C22SlEozcgcm7ULto3Y23
         IyZbbfSKHbkhubxls3SEr8RdVQlA3ZGwnR4NIvYLu7Ifx3YgIU09sxlktDx3Y+gsBI/Q
         2aXA==
X-Gm-Message-State: AOJu0YxC6jttpOWwznHak+bYvh0kjTgSY5V5aYm4AFfQ8E3LpzKUCY13
	2meNhtd2gp70KNcu0q2Rap/Lp92Q7SHSK+BwT9RapDd6lWDPXtI7C0Rqw92R6HSpaD0Lhwip+Z2
	o65/T9EMzu/J3hyosMh6B7iTjd80Zf+mEZNDVpN9LJs2TGPkrtJguc/hSP2c2hIh955Z+/hqmQZ
	BjAhp8aYxd2oFDRLwvxu3zbB9T/wOUbN4KMdOK1IXmJQo=
X-Received: from pjbcf17.prod.google.com ([2002:a17:90a:ebd1:b0:35d:9018:737])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3806:b0:35f:c729:de9f with SMTP id 98e67ed59e1d1-364921abbddmr5232859a91.27.1777418831246;
 Tue, 28 Apr 2026 16:27:11 -0700 (PDT)
Date: Tue, 28 Apr 2026 23:27:06 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428232707.2139059-1-dmatlack@google.com>
Subject: [PATCH] vfio: selftests: Allow builds when ARCH=x86
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Ted Logan <tedlogan@fb.com>, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Allow builds when ARCH=x86 since the top-level Makefile can set ARCH=x86
even for 64-bit x86 builds.

Note that ARCH=x86 could also indicate a native build on a 32-bit x86
host. However, it doesn't seem like anyone is building selftests
natively on 32-bit x86 hosts these days since KVM selftests allow
ARCH=x86 and fail to compile on 32-bit x86.

If someone reports an issue on 32-bit native builds we can harden the
KVM and VFIO selftests to explicitly check 64-bit (see the discussion in
the Closes link below).

Fixes: a55d4bbbe644 ("vfio: selftests: only build tests on arm64 and x86_64")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Closes: https://lore.kernel.org/kvm/20260427231217.GA1670652@nvidia.com/
Signed-off-by: David Matlack <dmatlack@google.com>
---
Cc: Sean Christopherson <seanjc@google.com>

 tools/testing/selftests/vfio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 0684932d91bf..40165d087a0b 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,6 +1,6 @@
 ARCH ?= $(shell uname -m)
 
-ifeq (,$(filter $(ARCH),aarch64 arm64 x86_64))
+ifeq (,$(filter $(ARCH),aarch64 arm64 x86 x86_64))
 # Do nothing on unsupported architectures
 include ../lib.mk
 else

base-commit: 2a4c0c11c0193889446cdb6f1540cc2b9aff97dd
-- 
2.54.0.545.g6539524ca2-goog

