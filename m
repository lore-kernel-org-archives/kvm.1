Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FCA3B4EB6
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644150; cv=none; b=jzDcqXooCHk3HMdzSqNK5TIBnbSXbqhHXDokoBcrQRjxb/krcnWXH/eUaGOA2YjCzKhg3TMug1jNPPkO5Oj0LWL1rhmRJzH5DtQ6RR/cqnrbA2gFd8hcEKZMyuH9pRkTPK0eBV115QHx4s2nlo5hmAnfkdJoozub8vb7iB1UKGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644150; c=relaxed/simple;
	bh=Ztei+DEPacjSiPahV0NkjODCzWT73hFcISLm5/ZnSJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9aKTFMqIr7d2nrVWoC+qyBqkt6u4Kt9DlRWjZVIwlfrjue/TykngHVlxVJrKs0QWJSpQ7sSQYz52zTldK0OrPz5m/fO+mix5Kqblbzwn46sez0I9qh5OwVEyvs5SgpLGU7kiLgiY+zqonmiM5e6cYVAJHgyjbA+lUZLigJRtsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPR/IeaA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPR/IeaA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso57095115e9.1
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 03:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775644145; x=1776248945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lwgNYOWoiOTGXIEkzvCQ0Ysk7UeafU5/fZrAl+QBeQ4=;
        b=BPR/IeaA/rqgIbL1aIdZHHnEdSZ/OD+Cd2d+B6lEKnzF8Ol2hOS8hZldf6sPCcBKmL
         SRDyPw3k5Z4PYImEaUM0N1BJro+U1No9cNOObUT65zMDb/GdOHLc+7RAgPlmT9WpzOuY
         7UUp1/5Kp+9niVejwky6Z35umJ+aNXs2KSXbTgDnhLoChngVYunOyC8W3GTEXkwTXEPq
         JEPi0Neqp6Ec1g7hdc6zvN8hQDKwOmL+pcaub33Zqir2UbccfJjkX58/qRHGe+LSuOEH
         zTaUrblIzmpzBLC9grsm0KXAKktblpQgSHW036p4CvOu2ITkTDrW5/J0nZf4hJwPI0qp
         g9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775644145; x=1776248945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwgNYOWoiOTGXIEkzvCQ0Ysk7UeafU5/fZrAl+QBeQ4=;
        b=KWS5FLd0bwBwiCkX72TPkq4R0jk33G/puYo5ugA2yTrnh2m+g++tARjHYPkUAbot31
         p7MIsl7aXHxJeuj4Esh5T9uSsqqgQuBWN/xvMS+KAQH3ZNnGkR6KnyjiOeyfGkCKCl5i
         6yd+uUGjIuvCBoI2i3PIGnNlz+OtUxyoMbQpAE7k7T3pzwvsyWLlBop2eJltTOOLLTF0
         stNhXmS1vcEmguVeV1BY3v4iYVFBHzzGFAZOyOurbhhhMSnBO5DYIj+QMMRvODoYMTQi
         0b5dH6lWPoGNfpr4JYckyNJCwDC4qhfdIMUjtUqZlBXLoIRRN+LqTq+JyzMS9moCEmDQ
         JHxw==
X-Gm-Message-State: AOJu0Yzjg70F5MI7WO4qIsSdDEnLKwURyfPtIRZKAVZpmSwJuyH+0Ofj
	xWhpvoaGrOljkvitSd/Q3uTcmbputE6VehxmGCsi7FDFOGwDag9NJsyD
X-Gm-Gg: AeBDies/Y2WEeN0wTClbboOqdGgz886Edhi7H5rnBlBf5khGgZWpM8iCcDPBO2LBUwR
	i9GhAAdFVS7eR+smsB9VixMkGPApcKzXLz2ghcZknPY3K2mRYyEs9yyhTewkoZkHNJGIfcQdpSP
	jmuX0VXREDDYGmeD1XymaOePjw5Gb666oyuFxFaztfWFviSGe5UqwXY1JhHYoPsg2uWwhnfGkc9
	LYA9esHONEq//KtGjydEZXPKIGbhHn4t8qWPKzLSKgthp1WvuYsDH5eqv3HZBjJzaWjEDly9Nvr
	P5+DiEA0N3s7I7GptaR9DuSi99cUxRWc0gJE5NKBTK4l554Q35yrTThqN8WF4Vvv2pLvOkOXcFE
	92Sxtv2ZkJGqqU74PbRXAl9hYEtL6m09D2TLPMFH+ZeDlSMO0PqNi6Zjl4QPG7Dz7qP0WQoxuVR
	1ZzOvGrqUBWGtcUmYJDg==
X-Received: by 2002:a05:600c:6986:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-488996ecbf3mr262105655e9.8.1775644145263;
        Wed, 08 Apr 2026 03:29:05 -0700 (PDT)
Received: from nuna ([154.160.21.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5dd63d6sm15616275e9.34.2026.04.08.03.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 03:29:04 -0700 (PDT)
From: punixcorn <ohyunwoods663@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	punixcorn <ohyunwoods663@gmail.com>
Subject: [BUG] KVM: NULL pointer dereference in kvm_tdp_mmu_map under memory pressure
Date: Wed,  8 Apr 2026 10:29:14 +0000
Message-ID: <20260408102914.106838-1-ohyunwoods663@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under host memory pressure, a NULL pointer dereference occurs in
kvm_tdp_mmu_map() at offset 0x24. The exact root cause is unclear --
it may be an unhandled NULL return from tdp_mmu_alloc_sp(), or a
violated invariant elsewhere in the map path.

Crash log:

  BUG: kernel NULL pointer dereference, address: 0000000000000024
  #PF: supervisor read access in kernel mode
  Oops: 0000 [#1] SMP NOPTI
  CPU: 2 PID: 1110212 Comm: MainLoopThread Tainted: G U OE 6.19.10-arch1-1
  Hardware name: Default Default/NLXB, BIOS BQ141 06/27/2024
  RIP: 0010:kvm_tdp_mmu_map+0x471/0x880 [kvm]
  Code: 00 00 00 80 48 2b 35 76 72 5c c8 48 c7 44 24 20 00 00 00 00 48 01 f1 48 c1 e9 0c 48 c1 e1 06 48 03 0d 4b 72 5c c8 48 8b 71 28 <0f> b6 4e 24 83 e1 0f 39 ca 0f 85 a7 02 00 00 f6 c4 08 74 26 80 7b
  RSP: 0018:ffffce128333f790 EFLAGS: 00010286

Reproduction:

The issue was observed under heavy host memory pressure while running
a KVM guest (Android emulator via QEMU).

The crash is not reliably reproducible and appears to be
timing-dependent. Fault injection targeting tdp_mmu_alloc_sp()
increases the frequency of hitting the same code path without
triggering a panic, suggesting the retry path may be a viable
recovery, though the exact failure condition is still unclear.

Fault injection used:

  sp = tdp_mmu_alloc_sp(vcpu);
  if (!sp || (atomic_inc_return(&fail_counter) % 100 == 0)) {
      if (sp) tdp_mmu_free_sp(sp);
      goto retry;
  }

With this injection the guest continues running normally initially,
but eventually terminates after sustained injection pressure. This is
expected behavior given the repeated forced failures.

A speculative fix:
  if (!sp)
      goto retry;

This has not been fully verified. Sending for maintainer review.

Environment:
  Linux 6.19.10-arch1-1 x86_64
  GNU C 15.2.1
  Binutils 2.46

Signed-off-by: punixcorn <ohyunwoods663@gmail.com>
