Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113B26F293
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776208192; cv=none; b=ogQhcrclsTNcKdop9BnkJDb6eROITcfp04tvR0TyNLrr3Gue/7udhnxcmAF2NH8y7IvmMHhRIEilpPaYcbXjgbDNtyTvhKagONdKgtQeWleYI2jjgQCZ3GlWOGEM8oZ5T8I491TuIUmC5qvxvmsheYabvtazCi2gQaypejHxQKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776208192; c=relaxed/simple;
	bh=mSn2+CdkzvVugFjulIZ8rGM3uGs2RacYe8G6a3z1KlU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bJcs/DB+ggcqs6vs9EoQhg3zWsuqw3IDO7lf8m+YCXfOBj23LPpzbT2SJQged0I4tbHA2kAAYofUoJJkfeUwev+282bgYyeLJFVIn0tOnLaW9cPrfGY+C0T2X/Yo9BVz8iYV2Jc6kWGUcHBTzFwC5/kFmkiWS591uSiiwR9WKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFOag27/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFOag27/"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2adc527eaf5so43940005ad.0
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 16:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776208190; x=1776812990; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ShBtaBHkFnQMUJA+zqLc7ojYj06qndTGZpGoAm+7NGo=;
        b=IFOag27/0cnw1pvkg8WPF5nW5YZ3XIPZj3r4xGLPmC72chUm+j6SpcYlRwangqX7oi
         hvYZdHwO41QNJ7h0Mp/lSuehroWY3BQGL5fNtBTKl1SDntrIfa/MxB0UYomaJ2q05tuw
         Cy6wQ2CRL0HH/ZaeSoyLCEw5/6KwEtdEMY+r79Rpf9qUOMAXC1RTpuoZ+0QHQR3gu3e3
         LUzunCihfwDqppXs/Bdc55lNS46lECmENcxckHKkqNN5AvP0lpL6IQwPxk4TtN1Drjwp
         QpqPTJ35IBKINROCdL1ZPfP6zxxT8ueouYJq9C13bSPfkkdtBi230gRmzneRWIOkFew3
         aoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776208190; x=1776812990;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShBtaBHkFnQMUJA+zqLc7ojYj06qndTGZpGoAm+7NGo=;
        b=PprA7Asxrymz4bMmrEO44xj9pMvD2Z5i0HjQ1pdhPVZ2upt+7Kx3nmHR8AukrqID4V
         MzjbkRFpjWG8EipPw5y0cpQYqiSF9iJ6bBukXQhwcmMPMEGiITOz3x2TMeK6uApCnxdT
         ocUGWl/ZXARG3jAGvg0INi0b2qOxNOUTZhhy8Ag9h18HxU3sgecyKWGCyyZcTFqORBnF
         +aUQG5B0dSdxgFouADh99JWWqDtOgq60QqwyQtbaRMFBISluuZtcNC5K42ezQrWJPW2Q
         xessbayd9LD3raD9uePJmYPhDyTur94PtMKs9wtbGYQOD1V5XYgLenc/JR8/c12CbHC+
         hdUg==
X-Forwarded-Encrypted: i=1; AFNElJ8H7ECIEIVrvTh9pTANuxmuQhlRHmvvEFhEjHRA8A47yzKMfCRyrjhzRE2U+mGwat74ct0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwM3urPx8t4/sVlB8SxIyCadLWyQUtYZObR6hKSn3EkvU1ojAF
	PyXR8VSKN8xLfVGFLb57YIlgfTFpO6+ZZs2NyylqB5GDsmJ0XIz5MP8i+hKhG7CD82qPtxdgqHb
	Drp2rOQuM
X-Received: from pfjd14.prod.google.com ([2002:a05:6a00:244e:b0:82c:70d1:f303])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:638c:b0:39f:27ab:2454
 with SMTP id adf61e73a8af0-39fe400f914mr16515463637.49.1776208189989; Tue, 14
 Apr 2026 16:09:49 -0700 (PDT)
Date: Tue, 14 Apr 2026 23:09:42 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414230943.41198-1-jrhilke@google.com>
Subject: [PATCH v2 0/1] vfio: selftests: Find devices that have VFIO selftest drivers
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Sean Christopherson <seanjc@google.com>, David Matlack <dmatlack@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

v2 of this series is only a single patch which adds a new script to print the
segment:bus:device.function numbers of PCI devices on the user's system which
have a VFIO selftest driver. 

Example:
$ ./tools/testing/selftests/vfio/scripts/list_devices.sh
0000:6a:01.0
0000:6f:01.0
0000:74:01.0

The devices are compatible with all VFIO selftests. Other devices may be
compatible with VFIO selftests that don't use the driver functionality, but no
gaurantees.

User's can automate binding devices to VFIO (which is required in order to run
the selftests) by directing the output of list_devices.sh into
tools/testing/selftests/vfio/scripts/setup.sh.

Example:
$ ./tools/testing/selftests/vfio/scripts/setup.sh $(./tools/testing/selftests/vfio/scripts/list_devices.sh)
+ echo "0000:6a:01.0" > /sys/bus/pci/drivers/vfio-pci/unbind
+ echo "" > /sys/bus/pci/devices/0000:6a:01.0/driver_override
+ echo "0000:6a:01.0" > /sys/bus/pci/drivers/idxd/bind
+ echo "0000:6f:01.0" > /sys/bus/pci/drivers/vfio-pci/unbind
+ echo "" > /sys/bus/pci/devices/0000:6f:01.0/driver_override
+ echo "0000:6f:01.0" > /sys/bus/pci/drivers/idxd/bind
+ echo "0000:74:01.0" > /sys/bus/pci/drivers/vfio-pci/unbind
+ echo "" > /sys/bus/pci/devices/0000:74:01.0/driver_override
+ echo "0000:74:01.0" > /sys/bus/pci/drivers/idxd/bind

This series is based on top of the kvm/queue branch.

Changes from v1:
---
- Move the functionality to discover devices from setup.sh into its own script (Sean)
- Omit the patch which automates binding devices to VFIO (Sean, David)
- Change title of cover letter (Me)

v1: https://lore.kernel.org/kvm/20260409015139.2800185-1-jrhilke@google.com/

Josh Hilke (1):
  vfio: selftests: Find devices that have VFIO selftest drivers

 tools/testing/selftests/vfio/Makefile         |  1 +
 .../selftests/vfio/scripts/list_devices.sh    | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100755 tools/testing/selftests/vfio/scripts/list_devices.sh

-- 
2.54.0.rc0.605.g598a273b03-goog

