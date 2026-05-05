Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3CC30216D
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980019; cv=none; b=uPimrjl5xGqEEpeDSevZproGcCPls9AxXmpbr/B5P414tqA0EjXhEOLdq8xFByAYVx8VAsh9x33OdGuv7wOmlplmGFvALd3imt1kdhz8bduIi1TKlCfdAfGfnLqvIGbKX3ARq32+P1BiyenxgiVO+Ut5t6ncyc9h5fcZ2FE0eZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980019; c=relaxed/simple;
	bh=mnsJSAROUR/wjVgj8osu2BXXQpF0UrgvEJRClOqsiRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VehwJ9CVSRJr7C6Eytm8a/aMJbt5i/RzAyk72ifveukkkGXfSfkT0DlAwEqulSL5G0hm7sAB5zxR6ZBTQN0tMP+xlIepWmnhd22+4xsNeZ08qdUT0Es4r2AjxhpqAXghgGk6MJh4sN1KyDMS4EFkmIH3v8j9XBWvPn2NyHGlje4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cTB2xQEj; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cTB2xQEj"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so1014373f8f.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777980016; x=1778584816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AoNkPdfNYcUACJXAldjc8yWRMq0hFedw1nCez7xbQqU=;
        b=cTB2xQEjhUc74HnDnQk9NAY5L+gt8KBih0reYTf8yXY++ixRlq6ptOmv9ovDn6mfDE
         juCe/Codd5XR9hioLQuykDvNBx+4l+7pVMoQg3RSRvdSIfPH+9fGJTmnAz3TorrAQu9Z
         jlHH1jTMyvrQXKxhJQ9IzLFqRU1xv+fEBPNh3WxDkYwFJ7AZstC/CHcRFik6QseJs8om
         va+lNurG+PokiQhr3/y9AqBiDm/Ft/CU0YjSAfWU0sa+TbiuJz4Bg47NqigRuOGk5dpO
         GkmTOWr0B8YpzTNeqxKFmhSj+Nr06jZ53xbX+z9HFaZLt5AoZEt4HO1dfPqxblRMRiH7
         UVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777980016; x=1778584816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoNkPdfNYcUACJXAldjc8yWRMq0hFedw1nCez7xbQqU=;
        b=XMf3nWtqhF9MqhkHh0vEZt5TXLPEXPkTQTwRIUriAJ2T+uG3s2Ge10cV1Oj7JhDpEk
         jqmeqtdxIskYD2BwyUvRAemhlMPciUwAIO8iv8aeMqH4l/9NShYuwIHrR9JCDQDkxfvS
         yrnLF8FYisTeLYMv6fxKzm664uJUhWxiksILpiwjKOy6aAhCiv9ItyWrx9fC6Mit7V4N
         hczw6EbxqHlUiRxJTfTRnNBJJne2EWfCBTC6OrX0AbZ9s+C7pOWTGz6R+BAVvllNxCOp
         QyIK9ZZab/UbdPtr7Gap6nZwQJF4L3bw4EZgptrHkEKR2imFPxpF44PUGwV72nGIxTXb
         PN2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+DCu2RuqvfbJWhHi4hTXdLRzq9jXNHBTzwaMuHauag64swxCDAe19gHE25884qS1X+UO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpZyMcEQd0GKZanGM0P0iG9wJDvhlmuHcqVmn47v9YUU5OFRBu
	3i3MVAP/HLaxCzuODxeSiYIF9j5g/j5/3puzhY1hnkT/j58TsZlIwpF4XTq08b9UXII=
X-Gm-Gg: AeBDieuzgpGENf6Mdk0KGyKy/PEph5lEk8hD1Jq4ZJZZIf+LEu1V6IR9953glr61xLV
	M92GjrFC1d0DywfO+7ebjDyqNxA7rWcRjV9TSZ0NrGlzpAA8M6BO5qozH2Zzgjmi7kg5xwh8sIM
	kfdcxmEXg+25DjTGXPgbV4dLuLG9G/oLyNIGo/VD2VpPv6Sqx9uzqc12F/VsMcN9CdyeU0ApZsL
	eDP3gSo5vPYTZ3DBJeFv+6fRDVMhTqUXUHhwPHFVEM1TDdGysJeYtaEsXR3/JWazkttkZAXOk3K
	lv+kpwYvP0HhuDN8EfV4rBmYPGG3vQCL0dNpRZskTDmHigQxKY3gZkULo/pFjrwjn7Vnnx95Ila
	vmsKzkL14FVinc1THYJXDgT9pv5pSsyNiGOKIgxs0bW1vJd0aa2KEeTVk21umD846yUCkUs/WWy
	TaXYXwIvrRJss8iikg8nmZ4hg+RMA9WgVAjg==
X-Received: by 2002:a5d:6a04:0:b0:450:e5fd:e1a1 with SMTP id ffacd0b85a97d-450e5fde1cbmr508966f8f.3.1777980016391;
        Tue, 05 May 2026 04:20:16 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055d36dacsm3723597f8f.32.2026.05.05.04.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:20:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 497815F8E7;
	Tue, 05 May 2026 12:20:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	kvm@vger.kernel.org,
	Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v5 0/7] target/arm: fully model WFxT instructions for A-profile
Date: Tue,  5 May 2026 12:20:06 +0100
Message-ID: <20260505112014.102993-1-alex.bennee@linaro.org>
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

Only the following patch still need review:

  target/arm: enable event stream on WFE instructions

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
 target/arm/arm-powerctl.c      |   6 +-
 target/arm/cpu.c               |  53 +++++--
 target/arm/helper.c            |   8 +-
 target/arm/kvm.c               |   5 +-
 target/arm/machine.c           |   2 +-
 target/arm/tcg/op_helper.c     | 254 ++++++++++++++++++++++++++++++---
 target/arm/tcg/translate-a64.c |  64 +++++----
 target/arm/tcg/translate.c     |  31 ++--
 16 files changed, 395 insertions(+), 105 deletions(-)

-- 
2.47.3

