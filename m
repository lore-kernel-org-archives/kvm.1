Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0365A3A1693
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882425; cv=none; b=KS0qiBkZ3wsEJTiD6B4l8HL0maVrA3ecabbLBrgfUu/e5gArTUAcmAfjcVuOwNBFVcj2zh98KTM3roeUtxm05k8io0Mu9L+grJsZtdPcx3BtreoCCHO3JuZ5RGR2sIR91dM9MPOe7qAyDMDld0fos4lFUTQNiWbG4N8RX91gHT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882425; c=relaxed/simple;
	bh=1M34dB+F+4NOCUNtLseb2COv4EBQQaUsu85Zjt21i+M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZH5Zr9DZe5lpKmW5ghAWGGbxz4ZJDqD/a9XesJVxhiwuEJQr7FYnLSJthLTgt5wC2ZxX1OnJLoElaoCAlr1Zzvl6z5I2iFghXpm0B2NygJSnXDyccUYsGymtCoW/12lOZWf8joMGKKkKvvo0DMuqehmzfZmQRxLcTyDxxFAmBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=su4bzAbx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="su4bzAbx"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c2c98c1be2so20562285ad.0
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781882423; x=1782487223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dF66luDSUMXDxVr+FGh32ifY036ndowleeCCncNFG60=;
        b=su4bzAbxyJnS5Zbl5LpLbNZBPO0JzQ62BgbGY3eizXCtuXueE3ll5pPnoxuyvfn73q
         EWdREEplANzvohxR4ZZFGkJ4OR4pMk2/QcWdtG6n/0EMfr3DWKowJ0pVZjlTNBRIIjAg
         H89UmQHfHON1gU9A87F6JtLSSu+WR34BHHEioqAG8KqJZOFJ89yfQN5Vk1Gd4m/MZujz
         p0ZmM0kz9ddBh4dE1fBWP5Epm3d9nW+aQAtSqp7ieA+Cl5uQi5x/fjbzxT0jalR0uj48
         J6QGlnLNYO6L9VJIdmoAk4qkyEAycXT9B4EUfvwtUEzWTLjq7+L9t1rHXkovw39LcdkO
         g8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781882423; x=1782487223;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dF66luDSUMXDxVr+FGh32ifY036ndowleeCCncNFG60=;
        b=gvaeJi26SsOWMUp1WbMzkLrjMeaD1POJRZu4pkP1S+VSdXY8OgdH1lerqdhU8IzRNL
         6bqWQUWqHUwV8zyp/U6NPy7TuEb8LiXpXe/B6Cb+6M5fTqeOkHMnCFZi6DwRby/18tR4
         vl4dxUYl30gMxQKX6+AseiLlHAl9+e88W8dXsd51XlqoOyLMODZmhEzPbN6HCU36IbXA
         dQvuTjfeWqJKrayIkuU7IMJJrH5UoBRyktInDH6GBZzkcYLGXUOWFJlrEfP60t+Ai8FI
         h9XEZ1yqnVe0YMorlm6maHMmxM6OB7UnZxOx/OnjqLJezGsclS+kGHU95Cg6ti8W/tyS
         VhWw==
X-Forwarded-Encrypted: i=1; AFNElJ90QT/4NeebMAHEMSZG+PiwXYSrdJv33wbKcGAr71tsYkRvHay6fiB5gMYU3NY7numWKWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/2IirxUoQmXlsvA5op1m6wG9A64eeGr7EnbXT1cDB1JWr2nV/
	7xG3CC7DUZhyVp3WGIj8bdVRU6bCW22KY2Tpg9CqUnjLDNTIh+qDONdvtUxbmAxbJ4QaluT27Uj
	btMFNi987EsTESQ==
X-Received: from plbjf7.prod.google.com ([2002:a17:903:2687:b0:2ae:c829:83a6])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d2c5:b0:2bf:195d:21d2 with SMTP id d9443c01a7336-2c718cbe1c2mr49543545ad.16.1781882422839;
 Fri, 19 Jun 2026 08:20:22 -0700 (PDT)
Date: Fri, 19 Jun 2026 08:19:23 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260619152006.3684428-1-jmattson@google.com>
Subject: [kvm-unit-tests PATCH 0/5] x86/apic: PV IPI robustness and subtest selection
From: Jim Mattson <jmattson@google.com>
To: pbonzini@redhat.com, kvm@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

This series improves the robustness of the APIC test suite, introduces
generic subtest selection, and adds a new test case for a PV IPI boundary
condition.

1. Robustness: Skip the PV IPI test if KVM PV IPI features are not
   supported or if not running under KVM, preventing false failures and
   potential #UDs on bare metal or non-KVM hypervisors.
2. Code Reuse: Hoist the command-line test selection helper from
   x86/vmexit.c into the common library (lib/argv.c) as
   argv_test_wanted().
3. Subtest Selection: Refactor x86/apic.c to use this library helper,
   allowing users to run a subset of APIC tests (e.g., via QEMU's
   -append option).
4. Refactoring: Extract the KVM PV IPI hypercall inline assembly into a
   shared pv_ipi() helper.
5. New Test: Add test_pv_ipi_sparse() to verify PV IPI delivery to a
   vCPU with APIC ID 255. APIC ID 255 is a key boundary condition (the
   xAPIC/x2APIC transition point, and the MSB of the 64-bit cluster
   bitmap used by KVM's PV IPI hypercall). A sparse topology is used
   to verify KVM's handling of sparse APIC ID maps.

Jim Mattson (5):
  x86/apic: Skip PV IPI test if feature is not supported
  lib: Hoist test selection logic to library for code reuse
  x86/apic: Support subtest selection via command line
  x86/apic: Introduce pv_ipi()
  x86/apic: Add a test for a PV IPI boundary condition

 lib/argv.c          |  14 +++++
 lib/argv.h          |   3 +
 lib/x86/processor.h |   1 +
 x86/apic.c          | 133 ++++++++++++++++++++++++++++++++++----------
 x86/unittests.cfg   |  12 +++-
 x86/vmexit.c        |  15 +----
 6 files changed, 135 insertions(+), 43 deletions(-)


base-commit: afcc98a30a84aaefc1f0d6783ffffec16c736717
-- 
2.55.0.rc0.799.gd6f94ed593-goog

