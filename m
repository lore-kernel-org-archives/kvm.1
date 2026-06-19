Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7143909B1
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874342; cv=none; b=SHnSerLQ7REc+rt9RHn3gEQtnRJGSyYuUsdfiFxX1OSdkS+V4zQvuJmBDwcVPdlsQG9H50DJkCtwvPR8+B6S/tnD97Y+5Cc82MQ1vH6tGOAfxCB+NMZHj78GJQqDzDui/UXLnjYQ76+fXRgjGsVKi5nO7WrI13jCzz2EEYj69fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874342; c=relaxed/simple;
	bh=yjAKUp7S4eUEO408rfSFEunzOwU45BmpjwBK9gnKtWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BFZN31Rs0oCUjLSMIyaxoCW+9r3z2N0m6HoRbXE2C0rynXdHv7f8Se3eXOwB4B5qDk3+pxqVKQxcGY1k5YTQ00JZKf/Coa/YNYWRKSON7cLKglUs6/smM26vMk1hNKB/FX4PcwuyeRsb63g9uTpjXLkCRxQlWvvyWFTcdKXK7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QAIH9LHp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAIH9LHp"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so1742875f8f.0
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 06:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781874339; x=1782479139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGWeuLURh979C1kGzuFu7ruukGHfTBgJCcmQRq0kZac=;
        b=QAIH9LHp5ooZUFhjU4lK5YmTFSOEv/8rtHOCIaN3UfBjguWgU8MEw4TlxmpTgpeOo5
         dE0KeyWa1kHP1nWSnrABxQGurA0a7C2BOGzSWpEePLELtlQWLW9bpQQrWIrf+LE9rfh1
         P7xJNCBRexXtsy9lGdXUceKBAL9qV2+0CmU2YiQTpIeI8H7qo81HjJAfC4lakhhZcA6k
         xJHKsI3Bj8y/xyCq2WenLYkWp2FDoDuiA8gUZ3VbMqM2rX2d6wm0nxo5dc53PxcmmZqF
         hTS4cMKENyGaM3dz9XPUNUrT3Bj5nPRrxHK8O+FI+XGzLFjHeVvYIrfGLwzgOMlI0GIO
         hlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874339; x=1782479139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGWeuLURh979C1kGzuFu7ruukGHfTBgJCcmQRq0kZac=;
        b=WVSpmmowbOVnvZ3VANiXBRlqdizfEhQ5o4M6GmZsWItL9Nu1X6PnWz/C67KhuSEMY6
         mCdVlg0w/hSfIouueaj9VHM9V/JyobfDaBS/Mpo0B7qcBs3u3PKjn/f7StzV0zmqrWqD
         OlY/tKJEmkcBAIIV+iX+FJIgPi2c0GP86iQKuwsEm3bUZPuZlYR2tv53ZOmYAQ2qdikI
         vw5Zsyv0evR+28MRUMbqpUQJsPlqJ9qAKRUH3lenbo/jy+buF0tt6nTGBfL1p7j2ohoP
         wIhM7nrRibx0HQ7JUdPi9/bIva/9lcWXFaiH/FVBgAkhgV4yOxUfgSBFzBNovl3rG2Ka
         Hl2g==
X-Forwarded-Encrypted: i=1; AFNElJ8+SuWHdz79wYM1iY7KxZ78JgH6iqFG6sbJoksA20Xv5FdlnQwoP8Jg6x3WNOfKqXET3Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlnTKKPu7QkjqbYlUvbPKSpgjEKsUs8Dntkcxo1cFETR6djVsp
	ttHJRVhgo8skSCpfiHaNokGq3ldLZJubkOqWfkcDyK9mvzuC87yvZcGIaelKQjyxjt0=
X-Gm-Gg: AfdE7clqHBbJp73LTgVOkT10+5HSnLWWicwrHVUXdu7ohB/4vGyLMSJgu4sGEglhwRH
	npXNuawAnRtgMLKir9LnRocUqSailicOl/VuYChi4+O0b3gLnDMaZtO6GSnoOt1Efb3f957FQGf
	mVB2JKdrRxw2AAz03vMM8vKgKmULjzTv/VS8CHfWjN+GIS8fRS6RA17SgFs9OXNdcEwe1GsN4/y
	2AJnAsoM7KfdxaliLauPZmf2pkvT396BIR19wW2wz0I8EfwRK6LA+5/sYMLw2GhuPUQMXxsp5L3
	Y22bxHr6GmaGrGQC4QA05CDX16rPUH0Gud4BX2i7zQJCCt5AmcZMPHtLo/MbtMromcl98iTZl0j
	ugLEwRLvRDrZaBNjKBC8kebSlAq5EARE4kY2MADqOxLPujrIImtlpE2rPS5PP23cgnFGv/4VEVw
	En5UppoVJ/nIFO
X-Received: by 2002:a05:6000:4e:b0:461:a161:8101 with SMTP id ffacd0b85a97d-46500439771mr4937397f8f.11.1781874339376;
        Fri, 19 Jun 2026 06:05:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46508a0546fsm7800409f8f.2.2026.06.19.06.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:05:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 418715F7FA;
	Fri, 19 Jun 2026 14:05:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Jamin Lin <jamin_lin@aspeedtech.com>,
	Steven Lee <steven_lee@aspeedtech.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	qemu-arm@nongnu.org,
	Troy Lee <leetroy@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Kane Chen <kane_chen@aspeedtech.com>,
	Tyrone Ting <kfting@nuvoton.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	kvm@vger.kernel.org,
	Hao Wu <wuhaotsh@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v8 0/7] target/arm: fully model WFxT instructions for A-profile
Date: Fri, 19 Jun 2026 14:05:29 +0100
Message-ID: <20260619130537.820184-1-alex.bennee@linaro.org>
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
 target/arm/cpu.c                            |  26 +-
 target/arm/tcg/op_helper.c                  | 252 ++++++++++++++++++--
 target/arm/tcg/translate-a64.c              |  42 ++--
 target/arm/tcg/translate.c                  |  34 +--
 tests/functional/arm/test_aspeed_anacapa.py |   4 +-
 14 files changed, 331 insertions(+), 73 deletions(-)

-- 
2.47.3

