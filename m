Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DDD4F4049
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666035; cv=none; b=sNietqZLSY4bYs8rEFfHvbKynQ/+p4ESyJUhAbPLqrotbH+xkQaKaIpTjBc88hQYuvf9Z+/9cGQEl4/L87h3dOwz3RPHDh9cGYS3SOj855vjoua3vixJ+SI8tuvwIxrvqIunAwu4KwCBQ7Ygpvr1OvzxgrrWfjZwVpB+0I994p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666035; c=relaxed/simple;
	bh=0dFIc1P5SspHIbcKl55NBr7eN3RMWTBd1gplw1ToFVI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=udCO2VI3IjLgVqLpomWwLv6GR+ZhUvh6yIT8/9wZ+2+2Mf4LdeaFAqayucmPlc8xok9CT4iFg8WQA3nRMcnvXl5HolFDgO4LpO0PrH0UfSjHNJSicuGyX2siA6/rfPVBj8O44VswpRDfUsND/dFJjp9CXj1zQzBlWjDCX5WrE1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmcrey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F95bx81S; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmcrey.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F95bx81S"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39d865b11b4so1446132a91.3
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789666033; x=1790270833; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=grk7eKklEDZuGU4DO+mElUf9TxeDf2UBTPbgXb/BfTs=;
        b=F95bx81SBRfb7bMrzEu3kfU/h5GulJRwM1LOcoqYDT9KnVm7a6NOuTG/HzsGMVJEXF
         lCIjXaHgJ6HEr/r+mpgJ8msXv8DIz90UwtPa/ktGCkPgXhakEZw5B3wydzKP/YmfBuLH
         uZTCcOkTF5lcT4BL11702VFiFDLFCHm1K1oR6LOcDXXTNfCsrqAu5kKF3SXuOio00Sum
         1AAZi8kzcBrKxwo0TPC7+c3V2eJjT9pWJyAp/oH8z0dGo1FRONxIVBflCT+dWJOuX5tn
         EKznbqv1Lg0FhDCPkVmqv/CxHyXo6DwdtzIXvWzYW4qHo6HSE/OeOEehoXCncosHapwi
         ngLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789666033; x=1790270833;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=grk7eKklEDZuGU4DO+mElUf9TxeDf2UBTPbgXb/BfTs=;
        b=jzbmP8ect8bj0B2q2qXWUme5v1Bv63kGdsUhrNNhWRhhl5/yAB2Raszjblk4TUOdkr
         O2I+GgjSMqJdlNAwQxAFq4Pb7qd1GZ26UB9CgCkXCdVfMsOGy7eFwQXN2KlwLYd54QaD
         JgeE/eS/DSQafNRcGKPdlK5CnlNbLrryfHML2/Mgouc7InjZrhKl80Bs67+DNZ1EXCLA
         p3t1392Mth4k32TRW+MbGK+7G2+/c4zAn7tavVq4j6OnLgnBedpq3Hre/ApavOOaB7ji
         uJUQ1athE3pwT0/8ClaKFewmEH0AVWqor2zM2Idid7kbttvzwuWu9xE5v9SXObWUdSqk
         WN6w==
X-Gm-Message-State: AFuF++k4emsn5iQTznZQ0g0XBni84lBTNZWBM6p1YoDmgQ6vvwQvvCGQ
	NNVQazfy3teTWgq7Xx2ogaygue/Dzz2AhCwUIsFceNUonhOmyf3u1aOM5pQF3i/5UdgaPwqBWEQ
	4mI+C+7722v2dgIDSKYitRjduS0+RM2ZB9+K9KYxpKSszj6isi/zIes4jpmCWmsjWb/xBzhrqXz
	MiVQOU7YSE/Z71oY5tKqDdAVrsJbccWnbf
X-Received: from pjbbb12.prod.google.com ([2002:a17:90b:8c:b0:39d:926d:83f4])
 (user=jmcrey job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:274a:b0:39e:131d:4510
 with SMTP id 98e67ed59e1d1-39e1e484999mr16683624a91.13.1789666032530; Thu, 17
 Sep 2026 10:27:12 -0700 (PDT)
Date: Thu, 17 Sep 2026 17:26:51 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917172651.3322899-1-jmcrey@google.com>
Subject: [kvm-unit-tests PATCH] x86/msr: Disable PMU for MSR tests
From: Jeremiah McReynolds <jmcrey@google.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com, Jeremiah McReynolds <jmcrey@google.com>
Content-Type: text/plain; charset="UTF-8"

QEMUv11 introduced a check when PMU is enabled to ensure that the
virtualized CPU is the same as the underlying host CPU[1]. The MSR test
always runs under GenuineIntel with the max CPU model, so PMU is
implicitly enabled. However, when run on AMD, this new check in QEMU
causes the test to fail with the log: "host doesn't support requested
feature: vPMU".

Explicitly disable PMU on the MSR test to avoid this failure.

[1]: https://gitlab.com/qemu-project/qemu/-/commit/4c7f05232cd1db5db114d36be2b210d24f1b9ad3

Signed-off-by: Jeremiah McReynolds <jmcrey@google.com>
---
 x86/unittests.cfg | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index ae731a93..06fe92f9 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -174,9 +174,10 @@ arch = x86_64
 # Use GenuineIntel to ensure SYSENTER MSRs are fully preserved, and to test
 # SVM emulation of Intel CPU behavior.  Use the max CPU model so that 64-bit
 # support follows the host kernel.  Running a 32-bit guest on a 64-bit host
-# will fail due to shortcomings in KVM.
+# will fail due to shortcomings in KVM.  The max CPU model turns on PMU, but
+# Intel PMU registers cannot be virtualized on AMD, so turn it off.
 file = msr.flat
-qemu_params = -cpu max,vendor=GenuineIntel
+qemu_params = -cpu max,vendor=GenuineIntel,pmu=off
 
 [msr64]
 # Same as above, but with a minimal 64-bit CPU model to validate cases where an
-- 
2.55.0.1082.g2b9226bbc0-goog

