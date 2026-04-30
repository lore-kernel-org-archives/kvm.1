Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0479397689
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777545880; cv=none; b=Y9oHTW4h9ZKTUOoyD5VX6shVfgh9ts4bSG4bb4wfvyyNQUKNrDHdPJKyKADmA1quYJ5TtCZ1QYBfdGhMlh0iB31xjUm7ouN5nVp3cmlfrELOm8dCev83CRbDRRp6WgivzOkKEQTHfzkd/7uDW0zMStsW9F28STaQO22jwEdqi/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777545880; c=relaxed/simple;
	bh=7VjE4idv85pWZ/rQ2l2jhHbF6QcCadUVMqGUSNRMcfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Llr15xFfxq6G86gRLJ/DIVSJDTqV+ZpnJ6oXHt9aN3bE0ocbNHhgTHN6ILKSCN+54Z1A5RRGOZyNf90EedrV08Bap5NXGPjER7QNArMJECoTUx0s2VOTyF7VSEe3f5Rg8y8uEu1eMEoHcyZZtBBSUKwUP/n9UGqHbRtSOW/RpIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jz9xKM3D; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jz9xKM3D"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4486b5fcf3cso702229f8f.2
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777545877; x=1778150677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQCxK/7ijLL/t42TsiFPAMhWhZ6B9omgDsTqwxgSxOA=;
        b=jz9xKM3DHkIqjlHGmt8mgK5SgrAcD71p3Zk6hgZlUc3uY1cHBcj7lcmuKz/DMAZBnr
         svvcbEx/bMiZn4s32YKkDBdg6GuyVEo+21peNmd01vvyCBmYCDnn9nMSGNI/BiYM8ZXE
         KfAEyxMNjD2JA2QC94LABLTUiRy2mtvRFeRNeT1xJpXDynvIuMGYx2hI612PRTXVfh1v
         Q4U3kEo9LiB60LfvYfh3ApMuVH7ovo31lA8He+mi8zgovPPwEix46v29BWebRqAePI0W
         CZw1qqHJnWpPfL35DOb6lxeeOV92Dk/L6eVrEzliPreWpMCYsMwmmB0Rh0S+7qexvpdE
         GH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777545877; x=1778150677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQCxK/7ijLL/t42TsiFPAMhWhZ6B9omgDsTqwxgSxOA=;
        b=PLV2FtNRiLWivUhKenv+smZYuiCfDB5MYixwmbHuDFB2d3pshY7+Qug6vVUo5Oz8EV
         I5RORaphc54ZCYyIz3bcr+Js5bT6IxnHk8kq3A/3JQaAU6z0bCZfblpyDIt1Mjt9q0Hb
         icYDsP03mna3vuMw4VqkwFHn+ui7cAR1PmlAudbh+CV2qS6pjQbRdTMPFF0pmGSHqRBe
         ZPt7CCAOULqdjY20CkoB17RTQGSz+qsTN13PolQOC1xiPdRGLyFlFx8iNDk3QVYzbErD
         V0Mwp8/vkMDnpB72J84uuZhLRswxWRcVP8GINZX+H8a/P30HX7JzXEOlFBawIp6pBBOe
         9pxg==
X-Forwarded-Encrypted: i=1; AFNElJ8guWQumF8dW745D0NSfIoCUQ0bsY/6zf0AWBSQgbglf8DKVGiBcgVgygY/GGgvKO3HYWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP4S6vuKf61frm9J0pV/UONc4w2AiWxuqhe6aenyc3B15gWpsD
	NkLcNlrpdsoM62b+azEKMYw9awxc17S/fKlJ/n8KGhi7S6gLW9FvpSf4i7sX/ep9QiI=
X-Gm-Gg: AeBDieu2MAFDkgfEzA/U3gcGtwkXclhMrLoVY2pMTf0e9Y4pC5XIKFw3EJ5WYUwJoWz
	Qph+VxPBEwH1k6KuU1h/dXeiDc83MLceZVMb93H4Y7xJaMgQ+zhrbJya55q/72Emf/FzLJe+sHy
	PaVR+VH/M/zz3UAFJaDmt+I/5Q1bDQMgGaT98bMlUMnt5lL51skR2Xvtd6/jIa/khxWibDpBGgz
	1D9FKcuxcJj2ubOhzAnUy+UqQK3rWGpED4BzF4V42r4Ff0EJ6Ewb08IC/CFH5FKFjZnSRnZboZp
	AHLrKLJIm7cSoEJKTA3QchOBdfPJSs+ZhJYOyGX/4p93aaJdj+6YhLih7tx22ZXdCGoMCj2teke
	WLeGn3UBHAxnVZFzTsRCAGDOZ10Gw5rbzQILSzSg361a5SMvhog9fprHLT0EfFkK/SbU3Mj1SF0
	2SDhVsGh8PbkYHV3/gqaRzzfcCA2iAcXwTiQ==
X-Received: by 2002:a05:6000:2303:b0:43d:7940:f143 with SMTP id ffacd0b85a97d-4493d7f8a6dmr3627316f8f.1.1777545877332;
        Thu, 30 Apr 2026 03:44:37 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-449c576d0a2sm1716971f8f.31.2026.04.30.03.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:44:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id BF26E5F810;
	Thu, 30 Apr 2026 11:44:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
	qemu-arm@nongnu.org,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Alexander Graf <agraf@csgraf.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 0/7] target/arm: fully model WFxT instructions for A-profile
Date: Thu, 30 Apr 2026 11:44:27 +0100
Message-ID: <20260430104434.1482407-1-alex.bennee@linaro.org>
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

The following patches still need review:

  target/arm: implement WFET
  target/arm: handle the WFE trap case
  target/arm: enable event stream on WFE instructions
  target/arm: implements SEV/SEVL for all modes
  target/arm: teach arm_cpu_has_work about halting reasons

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
  target/arm: teach arm_cpu_has_work about halting reasons
  target/arm: redefine event stream fields
  target/arm: ensure aarch64 DISAS_WFE will exit
  target/arm: implements SEV/SEVL for all modes
  target/arm: enable event stream on WFE instructions
  target/arm: handle the WFE trap case
  target/arm: implement WFET

 target/arm/cpu.h               |  16 +++
 target/arm/internals.h         |  22 ++-
 target/arm/tcg/helper-defs.h   |   3 +-
 target/arm/tcg/translate.h     |  18 +++
 target/arm/tcg/a32.decode      |   5 +-
 target/arm/tcg/a64.decode      |   5 +-
 target/arm/tcg/t16.decode      |   4 +-
 target/arm/tcg/t32.decode      |   4 +-
 target/arm/arm-powerctl.c      |   4 +-
 target/arm/cpu.c               |  53 +++++--
 target/arm/helper.c            |   8 +-
 target/arm/kvm.c               |   5 +-
 target/arm/machine.c           |   2 +-
 target/arm/tcg/op_helper.c     | 254 ++++++++++++++++++++++++++++++---
 target/arm/tcg/translate-a64.c |  64 +++++----
 target/arm/tcg/translate.c     |  31 ++--
 16 files changed, 395 insertions(+), 103 deletions(-)

-- 
2.47.3

