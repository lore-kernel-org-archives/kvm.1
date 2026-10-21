Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792556769;
	b=N1mcxKeYQRQsIzseVAVlzEDwXCdy1Wt1nl9jPn42nOrGnsk0cvv/oOZiVE0LX/lloI20
	 E0IGKZV/nBgjbELdws5U7i5UFqQCExN0rPnuh48k55WSFZ/0wjGPtn4pEC8JU/+NBmzv/
	 Cam5fe6EfebrL4gSoljNcvajUnRHejaJfI2o3GFRz4nMynHZ2oPWoEdPQXtkpWi2tPCZ0
	 Dpa+sfFVTNCYnU4uTlHDUyj+2yuHvBV3+C/hBiz70RfyjJo244oQ8HhBgvxaq5jJA79fQ
	 20YPrI37zYttiKalrA5wG+r4e7PN0FN/yZYco7cVGBNz9Ux1NQ+6pVLg8/s0hhlMc4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GjO69g/qQtk0fhS+p3Um2hWP5ehoABiLkMaS6vGdYSk=;
	b=hFLY3YBw4PyQBPjP7Bcu3/w0xt3IHgppY4RlVAp+SXZFCqe1ZqmC63r3Js+czr0cUlBT
	 dqV4Ykpz/aahelY+2uyZMgs0GQn9rcbm822nRiMABUzJe0p8qI6727rdvhdFeTiIgtpdE
	 XkYQ/55i2zwsrYMeVlCx+xK+s0NF/Nm74wy0jDI6pEnT18vrpeGZy5q8bnmAr2fZtMukw
	 JRB9x2bdcJ0hj2ujCFpFwZpFnvTMAC+LtK9sWGd+QH1tU0zIENlMAaImKp4i5NN0wKlac
	 he50tWumhlH0Apr2COQtZWy48OCvY0ad9txkLurQTFlMySbR846F9te2vPMflIQnQgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LpkwTUjo;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EDB606A31A
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 04:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90EDB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LpkwTUjo
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so177614a91.1
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 21:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792556768; x=1793161568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GjO69g/qQtk0fhS+p3Um2hWP5ehoABiLkMaS6vGdYSk=;
        b=LpkwTUjojXhv/QKYxnvHgu9CcdOQChvgNEt3TbKxXBBs9a9SnewO1wDzwOTWlq9fHf
         RqnEJJwgeQj9KW5q35dZ6t0BGC8MmVtuExz6zfDAbgbYmIOfS7AR8O1UcTXotBuMF03C
         dD0QrN80hRoM7/KffonT5PAvoOJr0+bvK0i3EEubMJAagn1irbtUsLTX0Tx5MIYBzisD
         Z67AbktIajf2DRG/wgQ82UhP+PBjloEUDVyQucty1UAcIb41jLqNWJDrkDKW2DkKbzac
         Pwb0e2EClsN42tY3zLf7VCKSJL5Q7GFvUBoSBZEIZF11v+f5Az8RSFdpvUnYIqVKRivV
         HJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792556768; x=1793161568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GjO69g/qQtk0fhS+p3Um2hWP5ehoABiLkMaS6vGdYSk=;
        b=vV68eXss5+sTk//DVnKL5piEvUJsHaxLod4IzWIIkKZawBCV7e0PhNqeAHpRLz8mox
         E8+EFNMWE7dGcPGNqgyaiz50k52WC8nYiNRujNO+MIxOG1VxxOH+5JEXn6wH2NnUJwEa
         PANBn0qXxlhY7qlkrfyw/Oce+kTJOQUBtTSmBZmZHN/AmTPGDoFCsCUIixmN2lSGr1vx
         VH4JJJmmMwYLqDLXO0maSGIpK3lAxSsu6+uFrch6czl0Lm9BVTlRVk7vUiauDHDbxyKF
         sZEOa3c50Rovs4T7jmae9isXZffD8OlZpMoiN0DJCHcYDyXa8RxfzL2vzVSuc116jcIH
         y7uA==
X-Gm-Message-State: AFq9FYLQHdbpeu4B8cichNs3g1KjOgn/qw5irCDjVw3QFlT8uQsFvDL0
	6RN8+aq+DTmqYwr4yWvSw27KiT16Ta+peculF5P+TUo3yktIyXeFvBFhyu6k9g==
X-Gm-Gg: AYBFou21ab1S2PJ4RICMTb7D8fzYN5Fi0WDVE917CFbv8osaQE8Koh5Zq2BcD7Y/Q5u
	bGjO+yTcVrqBLXLNKREulmoZVGFwWmEedKAeAD/4W8OCHNIMsR9FVTTsMXV1a9nF+cN8ZvB25WP
	rh/V8SDE8mYxssrgW58fLUWXcN+844kWNN2Ts8QEGcEBFmxVCBolQjWtgUlcSnN6veNepz++b6X
	x+G1fUkkP6zWb0dKGPK6m/uv0xaLFrQQf0YqBVuekZ3GzFKEsYOtPhExMM84iYVyhUJECAz47Dd
	aKP/mFQQO/v7eri6gjGSlm0OPli7IvV3qnBtQGlqhopaCtZxxB/g5PRqtZCy7cv86WT3bvWy5CY
	faTpLsvk3n+Y1+aXBChga/N7xLa9fiz/q4ZTQ+R1fE5XD37cQhwgpf834HqNDZXc7vHv/A6LXkJ
	kA6lHNIllw4SttyhYWH/1g8rTPIlqTNQsJxx6FLAsJrZ7pcI2J8NE7lYTG87nb8/RaDdh0K3EZ9
	iiLCsCvsOn8ZS+lLrJTQLCrLXcW9A7Mds1z/LQ1ud4dEC/ABtsUzK8gPZwE8S9r26uy3oeWw9+V
	UgJC4v0YSBN7YRlBvEL0wIk+w/tJS5B5XzC5ZNWcgGsdGM8cNU8=
X-Received: by 2002:a17:90b:574d:b0:3ac:af8d:c839 with SMTP id 98e67ed59e1d1-3ad86edd525mr820650a91.35.1792556767866;
        Tue, 20 Oct 2026 21:26:07 -0700 (PDT)
Received: from monk.. (border-p14.nat.sfu.ca. [192.75.244.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad80219f83sm2355155a91.6.2026.10.20.21.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 21:26:07 -0700 (PDT)
From: ma.mandourr@gmail.com
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Subject: [PATCH 0/2] KVM: nVMX: Don't clobber VM-Entry instruction length on soft INTn exits
Date: Tue, 20 Oct 2026 21:26:01 -0700
Message-ID: <20261021042603.608292-1-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mahmoud Abumandour <ma.mandourr@gmail.com>

KVM writes the length of a soft INTn that L2 was vectoring at the time of
a nested VM-Exit into vmcs12's VM-Entry instruction length, an L1-owned
control, instead of the VM-Exit instruction length.  Patch 1 fixes it and
patch 2 adds a selftest.

Found with a fuzzer for VMX isolation. The selftest patch was written with
the help of an LLM coding assistant (Claude Opus 5.5). kvm-x86/next was
run as a nested hypervisor under QEMU. The selftest passes only with
patch 1, and other nested VMX selftests are unaffected.

Mahmoud Abumandour (2):
  KVM: nVMX: Don't clobber VM-Entry instruction length when saving soft
    INTn
  KVM: selftests: Add test for nested VM-Exits while vectoring soft INTs

 arch/x86/kvm/vmx/nested.c                     |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/vmx_soft_int_vectoring_test.c     | 105 ++++++++++++++++++
 3 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_soft_int_vectoring_test.c


base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
-- 
2.43.0

