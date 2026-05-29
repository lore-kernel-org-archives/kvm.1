Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD43ACA5C
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043393; cv=none; b=eyMQI6qe6eSAM/DUM2Mjo7K4vN2qq5ThI2plFG1aMfMoaSt1INg4PjL8R/zOe0H046HvzgpWaGDD7tBT7Poi7V0NOjznFjvs8cS6jZFCoYgyJDhx1LvTKA3L3dUIppwRUFzH5zlFqHTppsL2MMZtj9asdZoc9uqMiCkYQq5oN1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043393; c=relaxed/simple;
	bh=eTqHObYv6tqbIfC4BBcejv7BpKh9q8P/JwF1HfPtCNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zm/i11zvC5RrTv+4z4BVRSPr0xKN9QofgaQEYoOC9ULh1NcrqWTjChsBDtaKwKBmKxVPRV/j1EgErwSlx+TyWzG4yzPQeOS5/qozwzjs0EBvKds2/EjJwWXgGiUOHcmq8DILpL5daT/Yk29XjIFcoZrp00O/yQbsotnXiIqh398=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ijK25i4v; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijK25i4v"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so77500675e9.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 01:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780043391; x=1780648191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PqBIIlOsJpFHNeGX5mY/Ufew+QU+w61wObkGDAw6TBw=;
        b=ijK25i4vFEiLk7eUx7zHmm11Qv79Ayv0zES7GBDU1VlmYte4sK1iQPKzKi07///dtS
         vYNr7DiaX+SMTakHGnzBjeUPPbpjfJn+LQVp0iSOTsuBZZaT2LSBOKZL38aaRhXNU6Rr
         Eyn2oBNLrUNS93YMXnsp8dKfduME0z0hxtMVNRAuwOmhXvh72ry4q7mMPEc0MojQzlvZ
         G4X2dkKqCRYtHpqMDeTzaEA4EQPhvhZz4imJwoF/Hq2SBkjgZel5JfXX5JUVVmzL/4z1
         5lh6r7Lec8vXQDPEinWkaPb73xZjOr8WBpagcQYbNS6YWSvuyt3dyhxzy50i4D7kqDms
         Bb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780043391; x=1780648191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqBIIlOsJpFHNeGX5mY/Ufew+QU+w61wObkGDAw6TBw=;
        b=K0jiOe3fHWhuKu0INNNojzZrNmq/8BZJep4QEl4sEgjl331dtZjO1UVhW6Ki1/Be7W
         rmGE9gazdD+Ja0x6+zRNjxEk3jMCCa2MaIipY8c+CuZLX2gQkNwSG3XaKdYoJnrZX47h
         wI3tvcEUfUTI9vRzKFLDK/BX4AxaXYDBKREKKScqTQSwFBUT59yDvhgZ6Kg5zN5tqVr+
         WAgCeZewFaQOPT0NbAo4cj7jzi5/Af19fYPPuR4TZ26OnlGGE/4ZI35rgSbQC3C3QRLD
         jUa+i/4ThmNozHYnFw6FyYR4ZybiZH8fiPXnkoJhTa8aGl0ByFAE8exLiQELF6pxQ0e4
         4YzQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/SXmd0MVDbLYS3xgzG7QErGKIf4LXpqaFXo9Ce5NayTFInzs0aFTAbXcL4GRES7m6S0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ0enkK0gjcVlOzl330wqIu1fwt8tAooV5ituFiPflkqS7ukRS
	GgTeJk7BEeNaqyh/VphGs8Z7zjhdMAzdEEIJGyQA1o6FYWLBsHqlWVML5XXCc88t7I0=
X-Gm-Gg: Acq92OEnQhrDNH1rzlkYF6OobxeuB6eCQU+OpA34Wv72cgOJbx9AWnX4pmj7opdoyOC
	vxg0Z2aa3mFb67CQxMDjNhMrhI3X/MrYMMM6YpitvvWHQd36Ig8TeFW3ShsF4VIIV90z9QXPVjW
	1Wyg0CCBjQzKO3O8orb859AqbsxRMOGFdWvFK0UM1Vghiw2M0NlYarCj9etNCtIHz46Jo+V7sUW
	uyuYhuaLB+9iTXZdwrs4LksfL8IAxw1up6CP5+D+YWaAE2eB+5Xtbbr3eTYEv7IYWiJNm2sP6uF
	PwFmbHFKqgErtsjpHQmUlTt8Buy3bAmlxFtL7BmLNWTX1UT99912rucUBqR+lHRmmTWcDu/tgq/
	rBENHBT1mKya2XgvfShpEjHe7k0yf7k4Mzi73dHe9Ijc2eEU8invCIFaYoqZylNugH5A8d46RVq
	WGBbTCMdN5QT5X1vh7euSkeUjxzWw8URRb9Q==
X-Received: by 2002:a05:600c:48aa:b0:490:81cb:d7a with SMTP id 5b1f17b1804b1-4909c0c6b91mr19611555e9.29.1780043390709;
        Fri, 29 May 2026 01:29:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d5f2347sm24497485e9.0.2026.05.29.01.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:29:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 2125F5FA53;
	Fri, 29 May 2026 09:29:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Peter Maydell <peter.maydell@linaro.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v7 0/8] target/arm: fully model WFxT instructions for A-profile
Date: Fri, 29 May 2026 09:29:39 +0100
Message-ID: <20260529082948.363931-1-alex.bennee@linaro.org>
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

All patches are now reviewed.

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

