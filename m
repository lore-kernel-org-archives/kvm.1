Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85602D6E58
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775699523; cv=none; b=lHSk03yxH1kOhRx7SOWsVeEqVTycS1Vng3rKtCWCUAsT4/PzBqI6zFeGuvd/HEe8PcLcd3K24lHG8SsV+mSAyPWtS1I+kE+OAWzY3Lpx6cozIgnGqjby7X5fGWnrM1cS9LCi4tT7kRKWXH/EyFAnC+hyxR7Uf0JU68ZpXDLU2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775699523; c=relaxed/simple;
	bh=guVUo2Cwnwa+kL5K7NoDxZu9WS2iHeUqrrW/dgWavO4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pf0fxDLU7eRzgirl7pbQ67ZB5VdCQPbXVd3NH1+ZYfNuCQvRgQrEP7HNDICu6/YfJ3VCVp3B65NXMGAH/oyhiYemd1GRVBm+CLMBOoP0nTrNo7HLV6Bzz0t5hxNEcqq01pvcKt7Al7Xyi1/JOLhVp4aASfeUq68y/bFLNyFKueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBFUhTnG; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBFUhTnG"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7424d91b2dso370718a12.1
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 18:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775699521; x=1776304321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CoRX83w9uMC+lyD0NCTQGQP5G19CTg6wgCWZNM28fVM=;
        b=KBFUhTnGO22+hPMWCr/WjZH9AaXDB46XgUoIop9AgskK6QOPw2aEVR6iYiB9/G5Tx4
         fmYEi6hUz/QBjyQefd4NXBqTXc7PkJxw74oHcT8UAQilQjdHvEagkCGkEwvGVnT03bzV
         tZxRCwsKtpETISIvBl+02hjwmd7q1b3LdWEhyMeRgtOqVPB/A/9yF0EHCium5s1wDGM0
         KzNfzCt38e5fkkTfR4wheK7vuHQZOqLPj7xDNk7Np6bCmcjSyfdouWICwgRqoBHWf90p
         77pnCzrfsZyOMFVFFWedIKw0ySJ5j2kk2BYt18jFhSa39/k6TEZnByqXtOWxO/jl4tad
         VO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775699521; x=1776304321;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CoRX83w9uMC+lyD0NCTQGQP5G19CTg6wgCWZNM28fVM=;
        b=ObTBrJApkW1YdceeW2x+1MKf7p+TLWI0BDznh/mrbKkgrc/jTkWshudh/emxu6Ta+5
         Qsfe9F7Yn2Xso+FXHJ/Mf9SYkXk6J5xDizid94FPWIm+Mmtsos2m3StD8ioQOBA7ZOFG
         276vYwAAMmw2MUdJmq1mc02rpU3oRJmU2w0wGrsYbonNGzNWcGYTdx2OA+dEwvPUnFqW
         H7KejWIZmWNMBjO/qqIy0DTXKYsMRpdocZbrW3U2K/gocjKoUHs1FK2rz58QvIDfDXlf
         o9uEWGIMN+Uz2k+LtuakP9uE44y8jKBFatl2O0v3Nx6O/omR487+tPsV+SHKOQJrZEn4
         4Aow==
X-Forwarded-Encrypted: i=1; AJvYcCXt9znZwRaagGHHie1wGS4ErO1KCX0vQ1fwrK7yx8hOowkvxo9jHrM/aPFD5Twht8M8Neo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wWKzDbNBGlVK1KIX87zuntK8mjmOmfLR/mFHxV/rQ3xvpt48
	w+pCU79TQY3TDNfOBf/bgogyau6towZvobH1bsimBzUkoY+GQSSsqnqzyw3LfKlVSU0wnjvZZHd
	8rVAIv4pi
X-Received: from pfbcn4.prod.google.com ([2002:a05:6a00:3404:b0:829:a3ad:9925])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3010:b0:82c:e76b:c68c
 with SMTP id d2e1a72fcca58-82d0d73f532mr22906776b3a.0.1775699520862; Wed, 08
 Apr 2026 18:52:00 -0700 (PDT)
Date: Thu,  9 Apr 2026 01:51:37 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409015139.2800185-1-jrhilke@google.com>
Subject: [PATCH 0/2] vfio: selftests: Automate finding/setting up devices for testing
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

This series introduces two improvements to make setting up devices for VFIO
selftests more user-friendly.

1. Add functionality to the VFIO selftest setup script to find devices on a
user's system that are compatible with the VFIO selftest framework (i.e. devices
that have a VFIO selftest driver).

Example: 
  $ ./tools/testing/selftests/vfio/scripts/setup.sh -l
    Supported devices:
    0000:6a:01.0
    0000:6f:01.0
    0000:74:01.0
    0000:79:01.0
    0000:e7:01.0
    0000:ec:01.0
    0000:f1:01.0
    0000:f6:01.0

2. Modify the VFIO selftest setup script to try to find and set up a compatible
device automatically. "Set up the device for testing" means unbind the device
from its driver, then bind it to VFIO. The user is no longer required to find a
segment:bus:device.function number to pass to the script (though this
functionality is still available through a -d option).

Example of automated device setup:
    $ ./tools/testing/selftests/vfio/scripts/setup.sh
    + echo "0000:6a:01.0" > /sys/bus/pci/drivers/idxd/unbind
    + echo "vfio-pci" > /sys/bus/pci/devices/0000:6a:01.0/driver_override
    + echo "0000:6a:01.0" > /sys/bus/pci/drivers/vfio-pci/bind
    Successfully set up 0000:6a:01.0

Example of manual device setup:
    $ ./tools/testing/selftests/vfio/scripts/setup.sh -d 0000:6a:01.0
    + echo "0000:6a:01.0" > /sys/bus/pci/drivers/idxd/unbind
    + echo "vfio-pci" > /sys/bus/pci/devices/0000:6a:01.0/driver_override
    + echo "0000:6a:01.0" > /sys/bus/pci/drivers/vfio-pci/bind
    Successfully set up 0000:6a:01.0

Josh Hilke (2):
  vfio: selftests: Find devices that are compatible with VFIO selftests
  vfio: selftests: Automate finding/setting up devices for testing

 tools/testing/selftests/vfio/scripts/setup.sh | 63 +++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog

