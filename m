Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63733EEAD0
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882207; cv=none; b=DdT+TXqCfvIIAuqXgDaxPPQHKqfLb5IT/nNjwwcePelzmwBwu/isioGuBRf0UffkgivF67pNIXwOIpHWfksgYwWEm4JFCTaEErFgCrxIhk2DBFG4IJLVEnNZ4g0LdFepojsX7YMtA7JRCXMlcE+4gDkBwX7PtX5/+bo4kWHgwQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882207; c=relaxed/simple;
	bh=pJ4W3l2cfftQx53uPgTKLgVG8ehpjcVvnjLKRCQDGE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SReWbN1dWxG02VaCiOHTaKwH8P25/6tbcOzg2VQmqXQsc2OEicOKtp/GeJ3E52mkcYqwRNjzK7tzTqH6qHbSuE0oQAwGg+R5QB954nz55QHdYlpBoCHJgUgqWhAupnfX9gMVTgmG0p/fjipQvWR2pd9juAhLteEmr5/pkgXViUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bPADWELO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPADWELO"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49048e043e5so40285155e9.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779882203; x=1780487003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IDYcqy+lALeYVl8Mkv8O83zszmMK8AJuHWXrTl78/K0=;
        b=bPADWELOYLPV+BRJV9h6FQ2V0YUFNa98wMTYr3C5MLYq00/Xlvw6hTEoZziyMKrCAn
         MBthjrUCcMzLuEkdwHOOvVuQWNUvF5OeLOICx5riVxNKR0en8EeBN7CUzd0WjcMXClyU
         H9rVT/5EAY/m0SnMFvgaOThwi5j3Sjw2vSLLgdZAQlMaK9sWnXqaT0o0JDhnZ+F90SvS
         RanQe9lqm8DhzcvVBGk2qXagCsNRSCyg9/GE8zmMoM8EQHGQohPM/3GcqmzgJz2uaHM8
         cDFSKBOnMN+FplF57pI31BgrhRJMF6EYRHIXoJy9wc0DnuIVqKdob2ITl//woruR++WO
         tyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779882203; x=1780487003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDYcqy+lALeYVl8Mkv8O83zszmMK8AJuHWXrTl78/K0=;
        b=MbyclmEKkcvvhU9ipWmMBrtkkoBOpoNjROwdyDMaNtY49jNBf1VOF/fHUoDktCaOjL
         0i6tHQJrGu4bqL8dQMJplaM6TDgPccNXa9D+MyPRA6SgANRpEZ4JMWndSyoVzg/7yN/4
         BhtdQcUSgYPAz/40tPACdPrZjTn7NJ1MlUCYw9fjya7+qXNoekQi49KkPeHEDugrkA0a
         g2lEHVrjEJbbHzS2jkGrLla8icASdI7YOxE7vbKKYlPxafDCb/O0RLJIRjZjMX5fhoG/
         VgiPrQVeqTbDw/5rOG3Rac2CtPNvl8lhLbzR0oBh2v/TU6SIGMr0jqqVLOfROYvjKllp
         AvBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mDnIZ20ur/02dC9oIyq6Wpy5OU+TDFm+gKXQ9GGDel2KL+nKSpN4MfiwoEu2Kfv6Jc+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjSjJ8tkdJmAbMB+EfoGvYyFNQ1mZFcHL1qKwI/WybhHLqGHGr
	dz+PcPupCsuYU/b4UfbtiMze4LUnE7N7XseuekNw1RbTjZuqLDwWh3shvt20G7DNxyw=
X-Gm-Gg: Acq92OHYQtK24wZBmep8a/U4dgYSM4F6Pfom/eaChVfJDepDUrSPFhIackRBynvdPxS
	yE4TR9YE+Zk/kPXRLXPxXr6Fj3HNJnJWmQ3kwKvWaumHFIJ1JJ4RMNNdcruWvvYJa7NJmrRkkiB
	pGHT+7I2Zqe7gojmL3J+G31Vz02qZ7q64pJMmcIysVHQhoR1jFW8RgVUsBliGkt5BTpHxPala5n
	QPFsL4Uh9HeU9KMYfjzCKAT4VOKVzhLdFmzT2VjCRWcXnyTYh8xLrvo+v1iQGMGkh20g1bgiu62
	KOkhwDTxxkzbT0aT5TuELue5PXCYPMnENAXgnvC/5VqbpTJSHlH1jmOX2asiI1eoO9p8c6X+/Za
	fwMWYtMcDp8HbFW1hznynVKtwoFF1urJoMkVlxkfeGbTr/Au8o60GhAejBaouCw1h5qdxQ3u0qH
	TROwT4nAIwnEzSzCy6w6uBdrc=
X-Received: by 2002:a05:600c:4f88:b0:490:50eb:b777 with SMTP id 5b1f17b1804b1-49050ebb9e0mr346140385e9.5.1779882202494;
        Wed, 27 May 2026 04:43:22 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454b1ab3sm441824325e9.14.2026.05.27.04.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 04:43:21 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id C902E5F7F0;
	Wed, 27 May 2026 12:43:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 0/8] target/arm: fully model WFxT instructions for A-profile
Date: Wed, 27 May 2026 12:43:12 +0100
Message-ID: <20260527114320.1581552-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This series fully models the behaviour of WFxT instructions. We
already had support for WFE for M-profile but we left off A-profile as
it has more potential sources of wake-ups. The main one is the event
stream which includes events from significant bits of the timer
ticking over.

The refactoring from the previous iterations of the patch have now
been merged.

I've dropped trying to fully model the global monitor in favour of
taking advantage of the architectural flexibility to have an IMPDEF
event wake up for any reason. We treat the setting of exclusive_addr
as such a reason because it indicates the current vCPU is in a ldstx
exclusive region and we don't want the guest to deadlock. This does mean
the system won't sleep on WFE enabled locks but people shouldn't be
relying on QEMU to model real world sleep patterns anyway given the
efficiency of emulation compared to real HW.

I've written a test case using kvm-unit-tests:

  Message-ID: <20260527111822.1563679-1-alex.bennee@linaro.org>
  Date: Wed, 27 May 2026 12:18:21 +0100
  Subject: [kvm-unit-tests PATCH v2] arm: add wfx test case
  From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Only the following patches still need review:

  target/arm: enable event stream on WFE instructions
  target/arm: fix WFET typo in syndrome

v6
  - add typo fix
  - addressed rth's comments

v5
  - addressed rth's comments
  - all but one patch now reviewed

v4
  - precursor refactor patches now merged
  - dropped global monitor emulation
  - addressed other comments
  - tested with check-tcg and kvm-unit-test wfx tests

v3
  - fixed the WFE exception handling

v2
  - I've kept the tests separate, see:

    Message-ID: <20260417164328.1009132-1-alex.bennee@linaro.org>
    Date: Fri, 17 Apr 2026 17:43:20 +0100
    Subject: [PATCH 0/7] tests/tcg: more capabilities for aarch64-softmmu tests
    From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

  - tweaks to global monitor behaviour
  - STLR/STL will also trigger events to avoid deadlocks
  - see under the --- in the patches for details

Alex.

Alex Bennée (8):
  target/arm: fix WFET typo in syndrome
  target/arm: teach arm_cpu_has_work about halting reasons
  target/arm: redefine event stream fields
  target/arm: ensure aarch64 DISAS_WFE will exit
  target/arm: implements SEV/SEVL for all modes
  target/arm: enable event stream on WFE instructions
  target/arm: handle the WFE trap case
  target/arm: implement WFET

 target/arm/cpu.h               |  16 +++
 target/arm/internals.h         |  22 ++-
 target/arm/syndrome.h          |   2 +-
 target/arm/tcg/helper-defs.h   |   3 +-
 target/arm/tcg/translate.h     |  18 +++
 target/arm/tcg/a32.decode      |   5 +-
 target/arm/tcg/a64.decode      |   5 +-
 target/arm/tcg/t16.decode      |   4 +-
 target/arm/tcg/t32.decode      |   4 +-
 target/arm/arm-powerctl.c      |   6 +-
 target/arm/cpu.c               |  53 +++++--
 target/arm/helper.c            |   8 +-
 target/arm/kvm.c               |   5 +-
 target/arm/machine.c           |   2 +-
 target/arm/tcg/op_helper.c     | 253 ++++++++++++++++++++++++++++++---
 target/arm/tcg/translate-a64.c |  64 +++++----
 target/arm/tcg/translate.c     |  31 ++--
 17 files changed, 395 insertions(+), 106 deletions(-)

-- 
2.47.3

