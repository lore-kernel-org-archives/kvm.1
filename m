Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3169337F308
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105182; cv=none; b=McX9nvo5vzN2R+X3FdLdf9CPDHFZKxNPZa5Xe8azRVst/7m9PAUWATRomkLIEuSTj8lLm0zuUbv49AazYlI2Wu5aLaw+2cuNODsNddh2T6bklL8VoK4Ovxb2mKIOgguOUoNP7KSusCZFhkrRfzgNdGnd6rMhlZ02oN8utFFbESM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105182; c=relaxed/simple;
	bh=ihOJq6l9Cj+7DUpiJKP7YmYON3LsP9u94GcSeu5dSYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c0ZpYuiIv78aY+4NFGVPIKkPZwqU8v1sL5jp8X6EruX88pJLCbjwwhkdTsZYzBmjNVaK5bb70pJZ9fF0bYoBZxMXtzB1x4XaLC+W0nJRH4QCDIxVkTY/zhl5VgzmbBXIoGNQlCyhxqL683nL3FE9Rfd6EqGaHPzmrH8sO2oWvhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScCI/uMn; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScCI/uMn"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso3835330a91.2
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 05:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786105159; x=1786709959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5S2Yi1PtfONzTYQiYQ8B0Y4yVeqMzjuNtG6qFuJj4bY=;
        b=ScCI/uMnJQFLU5/JqdrccZEn/BAjJ0XMA+g52rcKZTE+G5GrNurpGwJGKlZUMqYHkl
         bP2l4V2kBIJAkIcH222y30KEEkntAFGzajRM05wI3XKdovaDVBposB9Tml3D5Gkf2qN9
         ywdL3sbi6+NcodXKDjFZCJYPwjmGPBVARr+KBm8GkRZ4xuaJtWLp8M67GNESu4O6HlDJ
         J/6xNVRBPIeaYjs2ptizPQJX6S54XE/uSEUCeX3rbVmY5/qoOA1rjlZVVQ3x4yHdWGr7
         Oq/i3Auj66U0pNZgw/ycVylCppRrE4iZVx9y91fPpXKg7JSuu2vP86pPF+2eN1+9aahc
         K9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786105159; x=1786709959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5S2Yi1PtfONzTYQiYQ8B0Y4yVeqMzjuNtG6qFuJj4bY=;
        b=HJ54jIPk6N4sjhPKe4CnydHLEEfBE0uQrszBMxFmw60wa9jr4fQARS4UDuuw05b3yK
         +688a4xLVAsLN2q278splQiBITB+0lp1LixMtOXVko1Ios3VhvN37eGq0P8NHwwMY2KX
         R+8RZoUFeHJb4c/0/aitnZcCl7VfOrpryVkZxP1jBc3awCl1pHecmFD8QQcPQXJUajdy
         n3RPOSjprXSoW38JvgutKMbhF4/Q98hIc7Chj5rwDQ3VFBptI14KeNV0ASXb3jn3um65
         +9oFSxliIu+dZWdgLUUTONjeHPFbi9/dXIh03vMF/g+aJOOv60jQQHTbcxXEAAuxOQzd
         x4nw==
X-Gm-Message-State: AOJu0YylNyYNU1Gol71n/4rjZoS2Rjj5IKA4+Se4zhXZ5Ti+Ci4nDTm/
	LY6xfPCNIIxlwBPglQtkumXZWDdNBu4De3Y5Cf6Qgb2lUDIwy5+Tv7Gv7o1ICA==
X-Gm-Gg: AR+sD10+l6LACmTCf6/5O2KrWHyKB6tHiknUrgkuXsTVHSKZ8Td62guOdGf0E6FVhgQ
	iy8G4aK0TipzXgU11itQLAWk0C69NJ69MrI6qhpLr7hxIubBftc8ErC58MET3UJeDuJREfaEIYT
	nAVQzbTbK9XFfYrDIRirSU32e7kXBHlZXyhwW8uxPbF5FkLmivV/5x4jYWaEEALhuL/Gm5WyqLo
	Z3E8VuR+IbcgbHtgnOzQ9ri6Sl6nZ6N7mvzrSv9dmI1I3Dy+EZZB6rSemB/zT9AWJcixJUAw+BC
	lqRZvcUvf+tFZN+CKChn65xQ1ypy2C30+pO3FfAeCiH0Hhi1L+QdxI8rsmgS9Qr51t0jMBTIFyM
	Mwbs2OeLrYI7Kgru74gAXMWoEAZJ2/AidqBBlENvr6h1RAcRhe2g1qd5mhdC9A+kAtyYmsyUCsR
	xJccU1XB9qdMbX2sTD+MlHln6tlPErdGwtoApWSOPCK82cfzDCieHPyEZi9UjqTAHUv4fCRKfNp
	spT+LT4hOIiUsQ6
X-Received: by 2002:a17:90b:57c3:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-3903c5589e0mr24831764a91.1.1786105158389;
        Fri, 07 Aug 2026 05:19:18 -0700 (PDT)
Received: from volcano99fc-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebde2e6sm6893197eec.21.2026.08.07.05.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 05:19:17 -0700 (PDT)
From: sai madhu <suryasaimadhu369@gmail.com>
To: kvm@vger.kernel.org
Cc: dwmw2@infradead.org,
	seanjc@kernel.org,
	pbonzini@redhat.com,
	syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com,
	sai madhu <suryasaimadhu369@gmail.com>
Subject: [PATCH] KVM: x86/xen: Use read_trylock() for GPC locks in hardirq paths
Date: Fri,  7 Aug 2026 17:49:05 +0530
Message-ID: <20260807121906.925704-1-suryasaimadhu369@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi KVM maintainers,

This patch fixes a lockdep WARNING in kvm_xen_set_evtchn_fast() when
called from xen_timer_callback() in hard IRQ context.

Bug report:
  https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2

Observed crash (unpatched):
  [ BUG: Invalid wait context ]
  (&gpc->lock) at kvm_xen_set_evtchn_fast+0x1fb
  context-{2:2}  (hard IRQ, from xen_timer_callback)

Fix:
  Use read_trylock() on gpc->lock and return -EWOULDBLOCK on failure.
  The existing slow path (timer_pending + kvm_xen_inject_timer_irqs)
  handles deferred delivery safely in vcpu_run context.

This patch is based on David Woodhouse's May 2026 series (patch 3/7).
I reproduced the syzbot C repro on x86_64 with nested KVM:

  Unpatched bzImage-b69053dd: 1x lockdep BUG at ~69s
  Patched bzImage-xen-fix:    0x lockdep BUG (same repro)

Tested-by: sai madhu <suryasaimadhu369@gmail.com>

Thanks,
sai madhu
