Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6FE331A4B
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 01:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093463; cv=none; b=WQhehEF05j/i3jx3bK1wsJrUKm5cBdsFm9aGQi5cCh/x4dx7VJ4HCcAvS19DqkSSfBPV6D17ku4qOQD02XXX7H013lWu5g9WADtyglm3R0O3aIXYjCnCIZB7wlMDY/zpTTPFTTdE10MfxL9vomgFyzNZkRYi1a5icj1Y7VtQQjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093463; c=relaxed/simple;
	bh=zSbSVhdamoBD253FgsS+Px6BKInD6/VPa/m1giTtbxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qlu6ctldelOzQVcFkK6vkFzAd1O1L0apCdODPa2z8pBjeJR8gAGiD3lNsVvylVtpp38KN1z/3LYeE3jpON/XSYjzArbHTsJHOmwgGGKkHxb2+RWLkegQFp0LKlGr5FnXanKhDWi4MDLcLqJnRVo7Pqdn8aPK7UJrfF2qRD+ivV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUTTSbZP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUTTSbZP"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b2429f98d0so1826085ad.2
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 18:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775093461; x=1775698261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8kuPAaybsnZtsLWLw4g22dvkDkmFH1zM7ZxA104XNg=;
        b=dUTTSbZPAGaA3ttGID5Ol1SKkq1S4de2cbWobXt2ApAlguGKhrdrsoMNTE1GI+TkXg
         naqwgE9N2goutHnc7u9c8ZGNa7UAOUZXdGBvSVABCH7Mr61VQzblclz68bBT65tFfGYo
         IKfaFnt/W61XNzXCGAwEinoHPckuXy1c8ZuEI17aIpzC75ex2xidIUdOueIiJ/vDIrmQ
         LcWMLNm1xAZu7/MXbtQdkwv5GuOadzmofKtuiuLPXyYIJxUvjqgslUeo02p58L3o9/Uw
         x4OZ46KMRCDbnnxXtDbh+nTfzyMrqQeTcZIyPSAQVOgLiK1OAcKuthhwo3Bm/tiKbomG
         kpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775093461; x=1775698261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U8kuPAaybsnZtsLWLw4g22dvkDkmFH1zM7ZxA104XNg=;
        b=eYde7KsdaA3zpvobZuzTG2yvdJyROF6+HJ7fSjAUxGrdviNLNv072C9RKPNpEhpfnH
         DpEU8IKLKQYCV8EFmj4SF4+vlJBvf0Wt76WOyfE9LLPJ8MnMEzteqHzUcoSwYS25IaHb
         HfomNRqHPwnLvlj7jmwgAaUb1xMYcl6ajbSFAtntXPE4c6mEMnW+b+9Lpiqnt6rMmPLm
         qLXaoyZLv91CrIE+wpMELPXqFo9gJZUw2i9SK3qp9PRS908kFT1jW40XPUj2oWbVuKbn
         nVmRh/g4S+1/NaESm4uRafBxS7c0chxhJvwF3+MrNLqrKlf9HIG7RQDvDGSG0sIvnwU+
         UzHg==
X-Gm-Message-State: AOJu0YxC3vzg9kVNYn2DRSQL8zjIHiWbrHW4LBAo76W7zXe/czFxurIh
	BAxaQhIKFG9m5NhuCiKSh/WUEClvK9/6558pTosMwA60JIawyddRjZIQ9Al4AJbU
X-Gm-Gg: ATEYQzyJXb4wRURN4fONhXHjV+mRPmUIq6qaeDq1KTZo+Oe3WncIRg9Z22q8r3k4UuB
	+0of4q7BnnMklIQMAPW9sknd3hRo8RMaeth0p4ar+QrLpjYwBJQSonrUmHCCjt5E51fFxWMCgIL
	EsMqS2pQ59ycZvYRkoc5JIzRNTSKz3WcCqcSGfw5UYm9a+AubREdnn0BYP7LpmF3wNNHv6kmkkD
	UtvMFoNekgISwod3pWh0l9oeGQ/QLIj83x5+ygL/y5hSZM+UQE6GT5bDgQ/l8UwzxSlJTMdHMXW
	Xq45v47EcHIwRynus3b2FagxWAPT76mHbQM62ibqjdNm+s3PbsSnHtXy6MufgvmS5w/Do0JgiMa
	31+KJjAihIKy6Nosyg9GN8TWpco/s2OUTaB/iV6oZeuxloUUVlVZhIJZOqKbqbpEEz7mirog6At
	jf3tUuWXefREue0a4jbWpQF+B8p+KMj5PuYx5MNvc=
X-Received: by 2002:a17:903:2ecc:b0:2b2:5124:d068 with SMTP id d9443c01a7336-2b269ab2a7dmr55923525ad.10.1775093461057;
        Wed, 01 Apr 2026 18:31:01 -0700 (PDT)
Received: from acer-nitro-anv15-41.. ([27.4.76.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477c54bsm12480875ad.27.2026.04.01.18.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:31:00 -0700 (PDT)
From: "shaikh.kamal" <shaikhkamal2012@gmail.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	dwmw@amazon.co.uk,
	linux-kernel@vger.kernel.org,
	syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	"shaikh.kamal" <shaikhkamal2012@gmail.com>
Subject: [PATCH v2 0/1] KVM: x86/xen: Fix PREEMPT_RT sleeping lock bug
Date: Thu,  2 Apr 2026 07:00:22 +0530
Message-ID: <20260402013022.21879-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ac08V4TaM2yh9SY1@google.com>
References: <ac08V4TaM2yh9SY1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sean,

Thanks for the detailed feedback. I've implemented v2 using unconditional
read_trylock() as you suggested.

Changes in v2:
- Use read_trylock() unconditionally (no in_hardirq() check)
- Apply trylock to both gpc lock acquisitions
- Return -EWOULDBLOCK on contention to use existing slow path

Changes from v1:
- v1 used irq_work deferral (rejected for code duplication)
- v2 uses trylock, leveraging existing slow path (cleaner)

Testing:
- PREEMPT_RT kernel: No crash with syzbot reproducer after 30+ min
- non-RT kernel: No regression

This minimal fix preserves compatibility with your planned gpc API cleanup.

Thanks,
Kamal

shaikh.kamal (1):
  KVM: x86/xen: Use trylock for fast path event channel delivery

 arch/x86/kvm/xen.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

--
2.43.0

