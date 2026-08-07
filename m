Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA303222599
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 03:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786074661; cv=none; b=kPwlTt2rL8GparwOcWbKoMuPBsSh2ytOsIqHe5FLCxH/JZ7LMkF+hvavdc4XiiLs40z1i7o+ZCXkxK13K47pLIvztK8xm2mmJL/DjKAvq7bZzNhILFq7UZJnSENhjir2juoJp+wJlT0+X24ZSkBWGBrm3FPJ93DYQEQlkX1n5Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786074661; c=relaxed/simple;
	bh=YFtg6GjqyxOSM3CzP18SVF0tf9eAu6AJdv8xFMMizto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bqt8d7COtu+GQVlKeMaGtN+s1OJ+fkguxTj8Oh6RPnWMfL+68QHvJ6ZNuBysErJxP95rV0bijKt3RTzCoRY/9zMN/5olWx6CWUeb1r+56YGlkn9GfWBd74T8geaBj5H+YXpUoZ4hNvwouDFx1BM7hT5hJt6/6cOV0X7FOG9eQ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCe8bwdk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCe8bwdk"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1892347b3a.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 20:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786074660; x=1786679460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SDjiRmYitCVi6Po+hNUTG0dnEo7TwlYi6LDldiPSa4E=;
        b=lCe8bwdksOgA5J9DJdiNaKv+//KqRUWiTiKqQR1Jv/SjSRoHwUOh4hMgFgIub/RuIx
         G8T4d0qyJ9SdozsSch1Bg5cSLIYvZvjGp+DQ9sqM7zaE3DfLOEWfjFzhHloMbd/a31Lg
         lUwu+TxjwlIwSTQhHm+z5elZIXB59HuNwMInAUnAspExEsqs0DHRMtTq0wotnvzmy6nS
         oGeO395l5ztgazXJbxD6bPwIOz50H4tKtdO9Shdd+IcmDLyCuJI+AjtCA6qfLz66Ymc6
         xm6XSpo0WvO1dTkGINRt2f4RPAn3a6jTRdQqPEq3toJbb5v++GNfph6lM+7zEZj/ZwtY
         h5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786074660; x=1786679460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SDjiRmYitCVi6Po+hNUTG0dnEo7TwlYi6LDldiPSa4E=;
        b=TOUygZGT7tRJhCo6/J0XEqFln0+GvuYZpICtFtYJoLfj9FEntid9xO6LUdEaDviCpd
         4qdrEy3Af1j1aXqe5FvX/iT+FB+B51poLjlXlrQVVtOc0+eq6EDSvm4GskH9r+L6YJ/t
         191DwbO8RuAnj6zRvzjICOMPCIeWGifZuKHgTSvvFD1wncD0cnpR8OpElJIcWqNfLzgn
         pvDPIhKndUQfnoufptL4/wetsALYP61wl1fjx/tNfnb8KxwrShs/+IoGU+1OfmMlzAbZ
         a1WwC64rdekit0Ze66z14dQ9MV2f8CIzX5tSDZVji/Pp5axQ3APKpWEeyFO88AmDjOmT
         g6RQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq2x9NQUbCahmKzoB4sZuHlgV6DirmDw2VCulWgJdoAU+R2fgKCE8e3fjJmVCbLEQ1Etx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqFR9m3mijFR0fNu1E7IBojmY4c9YDHEnXTR+Xj+NMsO2pu39x
	ngsMJJ17zzZ6P/zgjU7c3CmceYA4k5LatwttkXTunqywZPbNRRzGwD9h
X-Gm-Gg: AR+sD10jyZl+exVqF0dp/7NFuwg3iy4KCLTQJn5hRmwplKh+1RRzhbJ10XKjFllxWgV
	g6r0o3G55dZvLlfQZ07WpMZc9JOLkRYYmdxre+PyfVPD4lwlq9PpYhs/Cd/D3WCN5F6ZqYiYW+O
	65gIkAORV/RrkhYU+Op6ZUU2FHLgQmt1WikcUYaHb6DSk11h1DkVDu519S6uOSOWKRHorGnpF1d
	/O0Z164qCT25G9u8zw+vp2g6wWFQWEeo+9Em+tjbfHmNNRSQRi8NQl0diaf1kJ404KHueIkB01q
	Zm2Ynqeo11DLNH6An2QGOZsm0BEGk1BR+TZ0f1EVsqD/QimmyQGzOmRgV5hLoFEkSdsTHx/mpwj
	Vhr6LhWXVupgo5gyYYKbJHioTlsHiYs2kny/PnB9JHe2LNvsFixl+37SMWdCQ5aHkDGexFl6c51
	WGCE6lYReSabWI4q97+stoSC/04d0I5n0gdax6s/5USS2d08EcPJev4qCon/py8RVStJneFxtZS
	rEuxKU=
X-Received: by 2002:a05:6a00:a117:b0:837:f111:b70 with SMTP id d2e1a72fcca58-84f41ba5757mr14013802b3a.4.1786074659915;
        Thu, 06 Aug 2026 20:50:59 -0700 (PDT)
Received: from cyh-System-Product-Name.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3d0d96sm287586b3a.18.2026.08.06.20.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:50:59 -0700 (PDT)
From: "Yuhang.chen" <yhchen312@gmail.com>
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	palmer@dabbelt.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	pbonzini@redhat.com,
	shuah@kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhouquan@iscas.ac.cn,
	"Yuhang.chen" <yhchen312@gmail.com>
Subject: [PATCH 0/2] RISC-V: KVM: Add PMU event filter support
Date: Fri,  7 Aug 2026 11:50:37 +0800
Message-Id: <20260807035039.294998-1-yhchen312@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds PMU event filter support to RISC-V KVM, allowing a
userspace VMM to restrict which SBI PMU events a guest is permitted to
program.

The KVM_SET_PMU_EVENT_FILTER ioctl and KVM_CAP_PMU_EVENT_FILTER already
exist as generic KVM uAPI (include/uapi/linux/kvm.h); RISC-V KVM does
not yet implement them.  Wiring them up lets a VMM limit a guest's PMU
event access, which is useful for sandboxing and for withholding host
PMU events the host does not intend to expose.

Patch 1 implements the kernel side: the uapi struct, the ioctl handler
with an SRCU-protected filter, enforcement in
kvm_riscv_vcpu_pmu_ctr_cfg_match() (a disallowed event fails with
SBI_ERR_NOT_SUPPORTED), and advertisement of KVM_CAP_PMU_EVENT_FILTER.

Patch 2 adds a selftest that covers the ALLOW/DENY semantics with the
event in and out of the list, filter clearing, and ioctl argument
rejection (EINVAL/E2BIG).

Testing: built and run under QEMU TCG with nested KVM (an L1 KVM host
running an L2 guest).  The selftest (patch 2) passes - all ALLOW/DENY
and argument-validation cases behave as expected - and dmesg stays
clean throughout the run.

Based on v7.2-rc2 (a635d6748234).

Assisted-by: YuanSheng:deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Yuhang.chen <yhchen312@gmail.com>

Yuhang.chen (2):
  RISC-V: KVM: Add PMU event filter support
  RISC-V: KVM: selftests: Add PMU event filter test

 arch/riscv/include/asm/kvm_host.h             |   3 +
 arch/riscv/include/uapi/asm/kvm.h             |  20 ++
 arch/riscv/kvm/vcpu_pmu.c                     |  28 +++
 arch/riscv/kvm/vm.c                           |  66 +++++-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/riscv/pmu_event_filter_test.c         | 199 ++++++++++++++++++
 6 files changed, 316 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/riscv/pmu_event_filter_test.c

-- 
2.34.1

