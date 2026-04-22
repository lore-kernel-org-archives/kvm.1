Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C93D1CD4
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862376; cv=none; b=VhzLVOAnL0I6P90vXIy5KUxw7Ua6/oJ5+LuAMdTh+7SlEtfyPr+eDGT4UTEbNGkB1AcqJ2IOH1dkmxPcpI9e0762bazz8WcONvR3JPNbCdvsaCD9fbiA6m+BwpBJWUsZLxb/2RgX1zNSYojqbzwWvMFz2UOVEBfoatg9QmFi6pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862376; c=relaxed/simple;
	bh=X9/RRoA9b3W8qY7OCmICDgLRjCEUzLMntYTnmzGnLps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rkgSLtmn3vOaDMCa8kMCayWvvQbeC7IRlPrar3DXGTYQfBJTh26FrwrUdYQyvF6iCPxgBesiWHY9hTK3rBnudh/saGhr7Mz6sK/BeKUIbl4hk1jI7oOF/J5Q4tU1tY72mmNCnxz4//QjNInzBf5uvYGYPxHrBWRZbHoDg6RFDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UDusLFnL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDusLFnL"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43eb05b1875so3208172f8f.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862373; x=1777467173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ktzBmtKkhkyE1Vd0Grjue/ltXPVNaT34cCAvQG/xXlU=;
        b=UDusLFnLE3rkpWqlJDFdQ/CFHQz24bwffyO99nQ0ikiw8VCjbNVSfcP3n+wgxUgctu
         GTaFG2pdK3762fe1iPIleraKsR5s8OFFNarCZijsmy3ey/Hhq94Tbizz1QwTCko4rfqj
         OyekPwiz6b4K6CBdfB0akhvq2AAdVsYZTA0lhlUaavZwbjhwmyXvKbW8wZc5GIwY703K
         igRSIbvR5GJATSKH6w01ggkkAIR/YyYA6t4LyElVSDNU7Ps7h4/Jh76j7CvIzI46xmM4
         DhKLzBTZ9jA7V700JDqiZgmdq311lxwmZXzfAxUue0mngf0lArVHx3L2ecDOg/UcraOE
         wWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862373; x=1777467173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktzBmtKkhkyE1Vd0Grjue/ltXPVNaT34cCAvQG/xXlU=;
        b=nobcspLtJjAP7V4WET3yQcehZ5KDVNZMQUsKuN4aJaKNeZ963hpeLwBgs9I7EJYU3N
         3agJmpIq7Ctk7X3z4nL13eTMB1Fd6fahVCKoDWr3pZ6uyL6LlgI8k3/CtLjtvnDw/WrM
         BVrV1DVobQm5t/9CAra2OIc42An02AL4kstB1y1zjrKmiilbDCoQXLDkUSgN9nsZ77iY
         SLWY5/70jPAMWsZJCepNGtQ4w1qxFo8xSwxGb61vuswPdP2PhBnuFLac4V1pYoRnL98m
         Ogk74KnFUyvMofe3xxizpom9GmKtehviay4T+0+t+jbFHVYktLZkcDnXGU1b2OTBzo0v
         7IuQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+bScHHqCiMo8C6DZfaLgk9lR85fefsOUp1H5mH+sLvzurYdS2pq2Iz6uY8KCmmGoMrmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRratthqiiobQ1435b6/PPro8YBeg3glGbXaBZXjbLvGmv8Swx
	eKtos32MFeCxEGB9rgZ/pYXu6P/d9/Jad5TswuhBFA9VsY46IbvTm09jiATQiM8yNY96A3fEPkw
	rjME70EE=
X-Gm-Gg: AeBDies7iL97DBHqYaEUlYEy7HIybvuNzJiZIjqFWFdQk92zfB96Ga4cGy9JTTGFVKT
	xrCupAUzft5nTvkacy2/O060DrsGsc3CrY2sksHN19CNh9WAZx3htXf/j+j8mIOqj6pW3HUhg1a
	H05/hPyFlNDhTDL+8CBSUqhatH+VGHvZ2Vx1SwgqZ4fWAKMm3vO1eHNt7X/SE9lEKdbm6w0pUiU
	VNjg76P+pDI8UVhrqFeF8YZo8wiEDa9WbsQv80jPreRcHpZXcSaNAgDs4e1Aj0pRRnV8X9N/+jg
	UofuizLSvcf1dnAhQJMDbV8usmjAG1uRt3zE/yQdv4tkf5FwUzl+LRMEnQ/vU7RAiFT2VZQBa7B
	Xtmpmxpa6WfBW57ReuEhyuRQMSxrlUp0FurUsWBYcylaupaV/BduK1rNs1Z4I7rQj0QY+EBxo9M
	cWO4GGfO8/UZLZjeupcm+PPuoTdw+a+RQagA==
X-Received: by 2002:a5d:4b81:0:b0:43f:e721:76ca with SMTP id ffacd0b85a97d-43fe7217864mr20097852f8f.45.1776862372992;
        Wed, 22 Apr 2026 05:52:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1405sm45127565f8f.4.2026.04.22.05.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:52:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id EE4F35F93F;
	Wed, 22 Apr 2026 13:52:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 00/32] target/arm: fully model WFxT instructions for A-profile
Date: Wed, 22 Apr 2026 13:52:17 +0100
Message-ID: <20260422125250.1303100-1-alex.bennee@linaro.org>
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

The series starts with some refactoring of the syndrome register
helpers to use registerfields. We then expand the WFIT trap handling
to report the register used. We then implement the event stream events
for SEV, global monitor and the timer related ones before enabling WFE
for A-profile and then finally WFET.

Note on AI usage. As an experiment I previously posted an RFC series
with the help of Gemini. This series however is a ground up
re-implementation which takes some different approaches on modelling
the event stream. In particular rather than running multiple timers we
use the same wxft timer and just compute if the timeout or timer event
will come first.

v2
  - I've kept the tests separate, see:

    Message-ID: <20260417164328.1009132-1-alex.bennee@linaro.org>
    Date: Fri, 17 Apr 2026 17:43:20 +0100
    Subject: [PATCH 0/7] tests/tcg: more capabilities for aarch64-softmmu tests
    From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

  - tweaks to global monitor behaviour
  - STLR/STL will also trigger events to avoid deadlocks
  - see under the --- in the patches for details

v3
  - fixed the WFE exception handling

Alex.

Alex Bennée (32):
  target/arm: migrate basic syndrome helpers to registerfields
  target/arm: migrate system/cp trap syndromes to registerfields
  target/arm: migrate FP/SIMD trap syndromes to registerfields
  target/arm: migrate eret trap syndromes to registerfields
  target/arm: migrate SME trap syndromes to registerfields
  target/arm: migrate PAC trap syndromes to registerfields
  target/arm: migrate BTI trap syndromes to registerfields
  target/arm: migrate BXJ trap syndromes to registerfields
  target/arm: migrate Granule Protection traps to registerfields
  target/arm: migrate fault syndromes to registerfields
  target/arm: migrate debug syndromes to registerfields
  target/arm: migrate wfx syndromes to registerfields
  target/arm: migrate gcs syndromes to registerfields
  target/arm: migrate memory op syndromes to registerfields
  target/arm: migrate check_hcr_el2_trap to use syndrome helper
  target/arm: use syndrome helpers in arm_cpu_do_interrupt_aarch32_hyp
  target/arm: use syndrome helpers to set SAME_EL EC bit
  target/arm: make whpx use syndrome helpers for decode
  target/arm: make hvf use syndrome helpers for decode
  target/arm: use syndrome helpers in merge_syn_data_abort
  target/arm: use syndrome helpers to query VNCR bit
  target/arm: remove old syndrome defines
  target/arm: report register in WFIT syndromes
  target/arm: teach arm_cpu_has_work about halting reasons
  target/arm: redefine event stream fields
  target/arm: ensure aarch64 DISAS_WFE will exit
  target/arm: implements SEV/SEVL for all modes
  target/arm: hoist event broadcast code into a helper
  target/arm: implement global monitor events
  target/arm: enable event stream on WFE instructions
  target/arm: handle the WFE trap case
  target/arm: implement WFET

 target/arm/cpu.h               |  27 ++
 target/arm/internals.h         |  31 +-
 target/arm/syndrome.h          | 595 +++++++++++++++++++++++++++------
 target/arm/tcg/helper-defs.h   |   5 +-
 target/arm/tcg/translate.h     |  32 ++
 target/arm/tcg/a32.decode      |   5 +-
 target/arm/tcg/a64.decode      |   5 +-
 target/arm/tcg/t16.decode      |   4 +-
 target/arm/tcg/t32.decode      |   4 +-
 target/arm/arm-powerctl.c      |   4 +-
 target/arm/cpu.c               |  53 ++-
 target/arm/helper.c            |  12 +-
 target/arm/hvf/hvf.c           |  14 +-
 target/arm/kvm.c               |   5 +-
 target/arm/machine.c           |   2 +-
 target/arm/tcg/debug.c         |   2 +-
 target/arm/tcg/op_helper.c     | 231 +++++++++++--
 target/arm/tcg/tlb_helper.c    |   6 +-
 target/arm/tcg/translate-a64.c |  60 +++-
 target/arm/tcg/translate.c     |  35 +-
 target/arm/tcg/vfp_helper.c    |   5 +-
 target/arm/whpx/whpx-all.c     |  13 +-
 22 files changed, 946 insertions(+), 204 deletions(-)

-- 
2.47.3

