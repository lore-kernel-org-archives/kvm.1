Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F211A6834
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297054; cv=none; b=hn1SkIx1aRcbvtol8Mb1qqubaWSAur6y7xEZqCT4r1CxY6udjSZFaRWcyIqRXCu1IndbyI9UkauH/ItBChvPdbtGrzlzWlVuaoUK7WRq6/PgYlWr7FeSYnZ/7JdUYKn+gdp0ee2mUVpQYWZwlVsR+N1YFgwRtS3rHDVg84mPqlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297054; c=relaxed/simple;
	bh=kYZ+vHdxLeMo7nsfK2AcyCv7/wRYgJGD6ctJJMBj9ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SBxJMm4kEdya9kWd3wp/EV4czFUI9JV3IMwtI/8cZ/Z7shFNJvLXG2J4ZWmuFO+4DZEyTD62lCu4ql09A8SlGhPd/Ga6rk1iLLth7502upF3ClBxLegZszZP379a9OLlnE68b7TWL5P5T4xKSOVQTxY+Q2FeJX/Qc7959j38YHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k7toBi/M; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k7toBi/M"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso5700285e9.3
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 03:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782297051; x=1782901851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4foWnUUsHoQzNgijWabhWw8cNCRzvy2qg6qho+Kaiqs=;
        b=k7toBi/MrftDHstTkR7LzszQjmQ9+u2+ov770aag7VZ4uXQrB1rC54dbLM9ATgEUns
         xyq7Uq4dJiPvF1CL4YR1rFtgc0WQEZzY/ZsEcGZl1CplmcRfpVlULT6LqLH2k3NWO0fM
         HARsa8kdaT8KCNkXMRrExuiS5ByKI/7FSY9WtF+rf2WlNKbcEkqSAgYvbaafI7IYz+Mb
         6dU60iolOHvZkPi4eDgZs9FfVZihLvIMuN64GCac8E7yhfR/MD5TSRAZs8nBJuT5gke8
         Hjl7j/biepmjcgJ0ngYMGeiZ44YXlsERwZrorkqcgVJoRazzDveOS4WEp2Q0chi1vEaS
         XOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782297051; x=1782901851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4foWnUUsHoQzNgijWabhWw8cNCRzvy2qg6qho+Kaiqs=;
        b=luUzh47VaaEx1MUes2qkMz1wT6ZrUL+ySHR+ykuByYZxGXxX9zsXN0hyTI86k6IW2w
         9mfaWgRR9wabu82rMhm9N7nNwUiXl6BdwYW7/lew+jXC0b5coGEy+drkfgz2WJtfOvCb
         fXr2Uv1fCszKhLGLF/oU9Va4mvMesoAYM5DjpV/xUFcc25yYmfQ/0nG/ZJYzRR5ekUOl
         NogL8p+Pgbg2koOOb9xCJely8GMyNuUBmuuy3XWbCMBKXYe+osB9uuISvaYI27MV/YMf
         fpsfafGTOz3g0kd9+H5LguZ/sKI+oR/IVcoN70tz4t4WgXq9K6YswuW6pOW9sxmJ782m
         TJzg==
X-Gm-Message-State: AOJu0YyVq1w21ZuH8jZ+42LSDP3OlPQDEy5uhE6qyHtAdtiXeIwmv/e3
	tv9+Fqv/cEhZqi4KqUfZK1u6MXc304CsVl3KbzwzFTHHvFM3hbNBxbK2yifpWcCSDA8=
X-Gm-Gg: AfdE7cnhtnEiqmvkbdlKIs9gUTUP++bqYlVWo4u1A4Y08XBKUMqOiOgxrNOHAkt+4Ok
	pkkCOuWNee51wt+6Nnta23oNRlZYYe6ZvFJFNoCrSkd4oReSHmv+Y2P4OgmGKN5qVPiXbsL6uiI
	8lDpwW8ZTZ1y/JrUQEQGL5lL5ogHqojnRcOx5SPXnRAqnMK4LAtey3HTbxIMq/K3phpkGjnu3w3
	lauQh8HXt22RPY0kY4xzi1/gQ7GT9+2EQ+4mCywclijOv+E/57Ux4zd40Kn5uB96A2v1csTnZPD
	jLAN2ozziIrRXxEqxJ/LP7Xi1XGpNuhb1YcRTvdOJgdjip/lx6f1PXTAlBzOxPKIp4UIjSCfTYx
	40tY0eCODahcQjTjBALsqTaNbos7qFY7J7hw/Pq67gEwl6CgHLXycQPohOqa5XFqqBAiQTAhAiy
	k5pu2UiDnNp78h
X-Received: by 2002:a05:600c:6097:b0:492:4a56:68fa with SMTP id 5b1f17b1804b1-49260872e27mr37291705e9.24.1782297051210;
        Wed, 24 Jun 2026 03:30:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494496d8sm360072015e9.9.2026.06.24.03.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 03:30:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id B262C5F803;
	Wed, 24 Jun 2026 11:30:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Troy Lee <leetroy@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Hao Wu <wuhaotsh@google.com>,
	Kane Chen <kane_chen@aspeedtech.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Steven Lee <steven_lee@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	Jamin Lin <jamin_lin@aspeedtech.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tyrone Ting <kfting@nuvoton.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	qemu-arm@nongnu.org,
	Alexander Graf <agraf@csgraf.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v9 0/7] target/arm: fully model WFxT instructions for A-profile
Date: Wed, 24 Jun 2026 11:30:42 +0100
Message-ID: <20260624103049.884930-1-alex.bennee@linaro.org>
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

The only remaining unreviewed patch is:

  target/arm: ensure we create the wxft_timer for all modes

v9
  - add more r-b's
  - only test arm_feature(env, ARM_FEATURE_V6K)

v8
  - Fixed quanta-gsj model SEV errata failure
  - Update the aspeed_anacapa test case
  - Ensure wake up events for V6K/V7 and plain V8
  - merged trap with implementation

v7
  - more r-b's
  - extended comment for typo fix
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

Alex Bennée (7):
  hw/arm: use cortex-a9 mpcore base for CBAR on npcm7xx machines
  tests/functional: update anacapa-bmc image
  target/arm: do not clear halting reason in has_work helper
  target/arm: ensure we create the wxft_timer for all modes
  target/arm: implements SEV/SEVL for all modes
  target/arm: enable WFE sleeping for A-profile
  target/arm: implement WFET

 include/hw/core/sysemu-cpu-ops.h            |   3 +
 target/arm/cpu.h                            |   2 +-
 target/arm/tcg/helper-defs.h                |   3 +-
 target/arm/tcg/translate.h                  |  18 ++
 target/arm/tcg/a32.decode                   |   5 +-
 target/arm/tcg/a64.decode                   |   5 +-
 target/arm/tcg/t16.decode                   |   4 +-
 target/arm/tcg/t32.decode                   |   4 +-
 hw/arm/npcm7xx.c                            |   2 +-
 target/arm/cpu.c                            |  23 +-
 target/arm/tcg/op_helper.c                  | 252 ++++++++++++++++++--
 target/arm/tcg/translate-a64.c              |  42 ++--
 target/arm/tcg/translate.c                  |  34 +--
 tests/functional/arm/test_aspeed_anacapa.py |   4 +-
 14 files changed, 328 insertions(+), 73 deletions(-)

-- 
2.47.3

