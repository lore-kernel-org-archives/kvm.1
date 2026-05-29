Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE093A963A
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 06:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036131; cv=none; b=tOQcHeUGQpefj2c/WTLESV3xddFR05W28D8J0SiV7rEGFC8FWUoIjoFkasMwCp7lBWY6YS4DObVRsyGAmKT3LHx2aRUUrICE+8CBTUk4M1DOKKTs1IV3bK5xSl0BJeECOayW7XV2gyexlvVRA8cZKyBmutmdXAQyYNrf6mv0vGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036131; c=relaxed/simple;
	bh=VBg6eYh18X5PDnPO9DIhzM31fE7SG2D5HIs6cG6KOkA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m+5FF+rZcMhCcihHcYflY8PQudl4bQgk4YD+qKHachqaQQ3VhtLK4lq0AzpWkBKONrkF78CwywXkHRz/YhqMA4icHz9EC84RCjjddWILwr3yrTjEwuAoX/MnSjGZQMnW69nYUVTa+ubY8XNfdm+MXmvMAjCOSWeLRhRY4hLEwDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YpJQqztq; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YpJQqztq"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-304f0039c02so137607eec.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1780036123; x=1780640923; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yc3+Um0q/cLzforp36o+SIYNj+jJ+pe+LLCc2WA5hpM=;
        b=YpJQqztqtb7Hv3FrMZkaCcuJHIGSeFLKh18/RjW6TooHgwGwW3Vg0wxCdOWePFJgUC
         8syyYkgwuwKMpCdIVvrSrGqsSFgPS2r9Apo5Uky/rHPdRtGgRo2Vn0iPRqOqHu+Aqga2
         tPCvlWeY+9OTv5BklBSLrnqz+oG+5aRU7UDg4lFjdQjTaU3/zc+sxfd/gZvXjdSQ3lZh
         3MATtjyc5+Jj/xKduRYgn8kdmvbBn7wSUbcxyR66dWXEZxUQXaSAWYUaeUaIJY/Dyk/D
         hxwgAx484ivwNmmjAOmU8iIDhf/U4CWNo9O1qaNAEG0n0uI2T4luF+T0lxOWQHqXd8u+
         qMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780036123; x=1780640923;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yc3+Um0q/cLzforp36o+SIYNj+jJ+pe+LLCc2WA5hpM=;
        b=Yk1pNlKDb66inQIaKudeBmGqZtmTL4AsftE3c/bmH+CPvuVuH6r1PTAu2nCDNO4WUl
         2rMaHG0C98GV7T0F7sD0pqNu41V5p+GY67Ssto2q0BJNBwFak2Oddh5J+cbxaXysNucg
         J8i3FlluHuZzY0M8SfoYx1dluSR+cYWV711gxdpNrC2lxFcEeC5gqhiw07CEXGqSM+dT
         xr53E2GjM/4JHTrcK+AV9Teg+f2gcyzP30OO8AFOT1L/KdUt1jg18hU6AnNe0Olrqwxx
         rFXEUtnivyRuUtBPbVIGkostE2PBsAok3S/tkqSFbRt71XAiav8f+s4/2UJs+BGlf1IJ
         oXjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9bBAn0UJoqn9RpFt+T4F4sJPKUp0hAM/pwf1ArLBZtXnyGph0r8UbRmuTbaJdWLLsGWGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4EVaVIdAXOm18nNOpb+U5vAoHCzVNrUPNQoF8uVC0AvNjSWmA
	OQakIO0Q8oNheAMf4Kvi2/Kr+pfQJg5LxTPJHSJiufAyU+9/IaY4lXAghOtpkBsRt7k=
X-Gm-Gg: Acq92OFOzKB6YoFbTrnqOlvfxB4JR6uN2y4Mze06Vz8V++TnkZVh0lJgiJxG/+lHqQr
	QZVsK7YCbsGu0KcglvlIBrO0PrMdi7Tqk7064LqXYnV579SrAUPoZNd5ExtD6ik886E5HXELp20
	Mq295HDv66u5unxgtynof79vlhA1rgTVqmX6teO41Y2BxGhStuJSWEGtT6Sh6h3CnwEOhFZXCXl
	9fgNV7Z/gyUNonOLk0VhYUJcCvuHGiR/PXbHJDgSYr1wMvLIBM0WdkUBbJHj4o2IUVDOuKc8Jgb
	vz4jstA1QRHDVQf5k6wBM6GbnD7ha+cmmTln0yzlDzpbD0y3nE77TyXZe94cnXLxKUA0THlFuRz
	YMTWGp3gO1BS0keVYSLhQ+agGD9sFEvojBhcXBdPHe/fKzOjOu2jNKmPvvBTF8U3tqlw3BCb7ur
	DZNcGP7DHIJrkBtqAhCkL3G4AYyNWHgaKbs76ZMaMEWaEBAy113P7SoQ==
X-Received: by 2002:a05:7301:3f16:b0:304:8366:7456 with SMTP id 5a478bee46e88-304eb0f0b91mr881488eec.3.1780036123025;
        Thu, 28 May 2026 23:28:43 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed3358b1sm694607eec.13.2026.05.28.23.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 23:28:42 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v3 0/3] KVM: riscv: add check_supported_reg() into
 get-reg-list test
Date: Thu, 28 May 2026 23:28:26 -0700
Message-Id: <20260528-kvm-get_reg_list-v2-v3-0-170969a8599f@sifive.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAoyGWoC/32NQQ6CMBREr0L+2ppSSg2uvIchpNbf8lXAtNhoS
 O9uwb3JbF4yb2aBgJ4wwLFYwGOkQNOYodoVYHo9OmR0zQyCC8Vrodg9Dszh3Hl03YPCzKJgtrG
 ValSpjTKQzadHS+9t9dz+OLwuNzTzOrU2+mxO/rPdRrH2/j/kcHZoJNeSl7KW+hTIUsS9mQZoU
 0pfK5R+F8kAAAA=
X-Change-ID: 20260526-kvm-get_reg_list-v2-f9f36961ac6c
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780036122; l=2682;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=VBg6eYh18X5PDnPO9DIhzM31fE7SG2D5HIs6cG6KOkA=;
 b=WZoiBediPqeVKPQUkdFvp7yI3jn8I3iTjYJoIKq4mGWSe2Kp/W2UGojEd5uTJ0uuEmyPqLRcj
 7rI61rm9xdwBJrDzyxmPQWX4j2oJx3ZKHkGz5kt7Z7XalBAlPFk0bj0
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

This series addresses a bug in the SBI FWFT (Firmware Features) extension
where features could remain exposed to guests after their dependent ISA
extensions are disabled at runtime, and improves the related selftest
infrastructure.

The bug (patch 1) occurred because FWFT feature support was cached at vCPU
initialization time. When userspace subsequently disabled ISA extensions
via KVM ONE_REG, the cached support status was not updated, leading to
stale feature exposure.

The selftest improvements (patches 2-3) enhance the get-reg-list test by
refactoring the extension sublist infrastructure and splitting FWFT
feature testing into separate, properly-gated sublists.

---
Changes in v3:
- Restore 'supported' field with init() callback for initialization probing
  (sashiko-bot)
- Add NULL checks before calling feature->supported() in all functions
- Fix isa_ext_enabled tracking logic and restore isa_ext_cant_disable array
- Add sbi_ext_enabled tracking and enhance dependency checking (sashiko-bot)
- Refine code organization and variable naming consistency (sashiko-bot)
- Link to v2: https://patch.msgid.link/20260526-kvm-get_reg_list-v2-v2-0-7940a401454a@sifive.com

Changes in v2:
- Fix FWFT stale feature exposure by removing static 'supported' field
- Refactor get-reg-list test to use unified extension sublist macros
- Split FWFT testing into per-feature sublists with runtime checks
  (Andrew)

To: Anup Patel <anup@brainfault.org>
To: Atish Patra <atish.patra@linux.dev>
To: Paul Walmsley <pjw@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
To: Clément Léger <cleger@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
To: Shuah Khan <shuah@kernel.org>
Cc: greentime.hu@sifive.com
Cc: vincent.chen@sifive.com
Cc: zong.li@sifive.com
Cc: kvm@vger.kernel.org
Cc: kvm-riscv@lists.infradead.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

---
Yong-Xuan Wang (3):
      KVM: RISC-V: SBI FWFT: Fix stale feature exposure after runtime extension changes
      KVM: riscv: selftests: Refactor ISA and SBI extension sublist macros
      KVM: riscv: selftests: Split SBI FWFT into separate feature-specific sublists

 arch/riscv/kvm/vcpu_sbi_fwft.c                   |  32 ++++-
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 168 +++++++++++++++--------
 2 files changed, 140 insertions(+), 60 deletions(-)
---
base-commit: c7832534a8160276cccb9a8cc8cafb5614c579d0
change-id: 20260526-kvm-get_reg_list-v2-f9f36961ac6c

