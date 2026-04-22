Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A7329E79
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852649; cv=none; b=cT9OqfHm9tBR720ZctTUxk0swNy9x8hIpCXyNhm+Jl1yRVs6Ott/UjjVfNfmNAn15LpWauwf6pEYSvvp/KeigmI+RlWzHkAuWVXc+NAvPInTqTurOLomY9RJ5/lG1B1aAaOesgJSRULBgGCEuX/KA62Jwu4gyCK+wwnd/guAyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852649; c=relaxed/simple;
	bh=Z9NWyWL9JOOvhxh5mnlri7v+AoE1g/nH29G+RCJX778=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lYDLYa3YykdONElXRY5090cSFFlxAOFb4ccv/jWW4v1fcVXtckDGPHZso3B5rjEbUy1gG7CHQJ7ZoLdFMCXxT/VS2L8SWx8LtJ+bmMs5eZSSg0gAbLGtu6i2DknwwV6/KngwK6myQJPivv1mfxxU6cRWOmeAbnXqpfWJT4oc+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LbE7TrBi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbE7TrBi"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ba67b332bbaso526053566b.0
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852645; x=1777457445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qTC5LhoRkf6ve0e8Svdu6+rIAu2GnxjtZscQzak026I=;
        b=LbE7TrBi1ij4dJjEcZuR7M4N7+I4mTAsnkaheNPIDN2oLsigrRLP3CjQAhjpUuaoy/
         baZ39wfT3COTu/hdxIfLieUq5rlgbSaGCXNywhjGYteu8imsHnjaohV0jVmv8aXJA8LL
         A+y4d/Dg/DG9cN2rMoFWOztD++2uLMDVGeRqX8aMMEm+VoG/C6MeMDtavzT9zy3cVmmM
         s38ZBo+v6l3y+GK4BtKp3seNL60K49Daiu+UrOrETaQkk49Qtor97RaZfFVEfS9a8vPE
         ANxXCRL+WTVSoAqYWUKVtVBWgQlAckrWFNT6uqyRtLTqJPZDpNZk45oRdocUqDaQJZQk
         sehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852645; x=1777457445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTC5LhoRkf6ve0e8Svdu6+rIAu2GnxjtZscQzak026I=;
        b=Fyq3r2aiXpFTN6b0NSW9wo7IE3RD6Qc7qpN9GUyZjFK7lo+FG2fkx7O4F8Auokk7DI
         Y+X/xrWf0mvkpfxS0iuMWkbX3MdpzBVpbFW+hbBQtHk8aD9tp72WzqUTdT7s6g1H/4A0
         rzhK5yblMaGEkKASTrTNJ8tuxzRFxweV9QpGtOOtOLvgJ4JsucKfu3pbV2r31F4Jd5iS
         QQAUf/DJ8MbMNPoaIqRCIpFMX/EhXtZs7GewK8g1WLNo2j86iMkElvyu5MwVyXjHtAha
         GX3Z+JZdgLVb9Y3Mvv21kk9VLdW7AveYT3Xb0J+Ehu/1UPphymOrR+cCUeT5nVqoh9Uv
         vmCA==
X-Forwarded-Encrypted: i=1; AFNElJ/6pUxL9SaYKsbaECfeR40DCUjwWD7/6yXOBNK0FSL9nCiRWTev517CLTXBrbKLw/IsDIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxXarZNAybVhRCWyG+TPrp55rbQC7JB8lvEhTgJFI/LNV461k6
	kwFYbg16qHL8zYH92TMFPaDmZEasF2eaczJHVJCg7IynHaZhpNrFd4jEtTuwcBPd5YWwtNZ9Db7
	GFEVQPNs=
X-Gm-Gg: AeBDieuTcrRr8O4rAecM25TNrFHTnygzZm5HrR5Tg8paYNtcz569c5ZivM35zMXjxF/
	pNp5Mljn2lLEBhj3QpFcVc6h9zqe0dNu4AlHKfsnjpJWuFS3azau2gZnCrrujf7HcBnX16nxJO2
	5x9vYiA2cEUpeOgVtsSV9mie7K7ewq9g71OiwO/HF6jJu+bznLfWXibqVFMyGdfUgjgoHHFeOEH
	Q4DRsxlg+WZhhhQJ/lKXo3XR2O8qtm/dXc8gsa5F7YiRMHvnVH4FWAAuwWAX2QM/2bEsWOQeGHq
	cThrXk84+mNVpQF+Lw/PoN9uh2kVOU3QkOgbGggKeOiVXKk+DwLkVAzujyIjMUB5WC+s89XLsEV
	wNaWXps9QDRNMKdty4zEfg4qPP9y8U2nt9gPD4WnVEtA476gCMx92TwZYvpUXtGNHJrBeCCO38R
	hUoS4T7Fi1pN9gdozYdhiUNtqunGVriJtPDw==
X-Received: by 2002:a17:907:da7:b0:ba7:62f:9fa4 with SMTP id a640c23a62f3a-ba7062fa21cmr624513366b.6.1776852645250;
        Wed, 22 Apr 2026 03:10:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb135asm48912309f8f.6.2026.04.22.03.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 6E5A55F93F;
	Wed, 22 Apr 2026 11:10:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 00/31] target/arm: fully model WFxT instructions for A-profile
Date: Wed, 22 Apr 2026 11:10:11 +0100
Message-ID: <20260422101043.1234229-1-alex.bennee@linaro.org>
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

Alex.

Alex Bennée (31):
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
  target/arm: implement WFET

 target/arm/cpu.h               |  27 ++
 target/arm/internals.h         |  31 +-
 target/arm/syndrome.h          | 595 +++++++++++++++++++++++++++------
 target/arm/tcg/helper-defs.h   |   3 +-
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
 target/arm/tcg/op_helper.c     | 216 ++++++++++--
 target/arm/tcg/tlb_helper.c    |   6 +-
 target/arm/tcg/translate-a64.c |  58 +++-
 target/arm/tcg/translate.c     |  33 +-
 target/arm/tcg/vfp_helper.c    |   5 +-
 target/arm/whpx/whpx-all.c     |  13 +-
 22 files changed, 929 insertions(+), 200 deletions(-)

-- 
2.47.3

