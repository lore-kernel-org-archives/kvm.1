Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D116230ACE6
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149487; cv=none; b=I/nM7KFkzQuykTVXsaN412s1ENuaqrEy8WKiJeyxknY2I/YL3Is0MKqdVXG3Em0fpirMu7wgXL4R7WgQe4bP6H8Ms8qNFPEFEIGIG/ftdqjUKsg7RJPP6Q76ixsc3ItLMFjS9FV4vfLLMOOu3pDD7V6WhhcU25+n5b0DTq2op88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149487; c=relaxed/simple;
	bh=wgBMX9IuK7BfoA9PzeuTwsbN5QBfs57Tfd0TFXNnrnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bZm1gn/oPAMlg5rxcT+oPtnUbBzTHWNqI96lRQoueyCstFJo7em4zLEYzRjVxQSzKcFs/JX09vIr4zgpEWRwY2WYNbEVcIX2l2A6DdLWSaJQZFj5MWPCPXTQ1L5tNlSF18m6j6IWINevzjB34DIEieP+nALCgRvckQFZFPq76B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rtC8fKPw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtC8fKPw"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfd832155so661414f8f.1
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775149477; x=1775754277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UolboCUEZpC2bIGieZdsWjT74OHHgRoWm02qV7hCKf4=;
        b=rtC8fKPwjm40ikys3S0lEZpmoy5buYhNSj1WOdRDKbSTZutFE3aIEGqxO8UbzbbXLS
         vbvYzYSp/STa8l++kvdp1h9gqRlF7XZzmSStLJU4UsiOiMhOAupRyxrh8z5iImzie0Qt
         sUtWocFsHRhlqRg7D4cXeBoNgW+J2PAgS+mOYwHvOl/8nWDb1eat5s/d3J/mkTOsavQZ
         jFHyjjFhUOaSxu+Q/0ziJlg/NaQntPe3ZAdDNBRqkjfqQlcjZfWLuiAWD35Xb8KxgsDD
         OgISr/OfRPGW0Mi5NCZEEg4aSUX+XgTrMD7Uiq7FWFVKLctLqN7xYaSGW484PQcQFDXD
         QlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149477; x=1775754277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UolboCUEZpC2bIGieZdsWjT74OHHgRoWm02qV7hCKf4=;
        b=S+nABKUq9ITE6bD0R6Vetc/Sk1BCo+Ok5aOHOL3nDsbgtdEQbNHr2jUxh6lOJdUdiz
         DsnGPHObh4gY57ZeuxkgjRFbQdWrAVQg1gQnMhZJsKFOvV9FBSY7yTF9Ua5I44aIwJaI
         Fg/AQWWA0aQiPqUKgKpYA7HmhuW6XcgXUFvA3oIjRioemqZbc6XIMaHOwBBruXjbQlu5
         OsrvDw5rDAlcPBvYbGFunm2pne2KFGdtx4I2ZZpKXKyDPsa+Ynyhr1+HDrIruc+X/isl
         NAeAdP5vZzZdlcQi69VuxmbPEPel9fH6llzYqP3/ooGbWO92lBbGlwV1m0G+inqcH5/j
         HVkg==
X-Gm-Message-State: AOJu0YztKjkRGbL1qIZ0eFLeiTllc3WCXWNYfM3WqlorwGfd4qeWDaBD
	lEfTYowmUbQaqs/BK7dRuao79N1kLkNfIqVFe5f/jP3Bg1+u9fbuKOkb4MmrnO1BpQo=
X-Gm-Gg: AeBDievgQVX5lIic2LWyfJOFz2Y4eBB4hvRZqHDHuh87A+IsaD5d0Y1RGe08T4JNHXR
	oVGBSEuYc4/fFla6ZJl/eFoAvjBtZ5Ns+152ObUKj86mX+Z+gdLH4VvEE7L6rlPNDRkLzNdq9K1
	74BMTBG2hrpNX6J94EyYKMTigIEicVrHL7BQ1QdrMvekbO7WH4xI2vzHp0luDWvxGf3YBamrFfH
	MIjQ8nN4Uz30APh+wtSJ7CXuXm5OqXoQE3ROy1GiNmRbCqrL0u2kcSoTpQXhF0fL/txXcygspwU
	YFPJEAAzxMYSVBGbr9LHa01PKjLU8EZ7W8pqF80TcVj5uwwVh2EsNk9/A02sJ0GD4/SlwhhzSFl
	0e4a8WLfSiHUz3fyPoM8mzPISuBGRyWuA1jJOrVogzxRsI+PQ9wdqqI6PTJvcwHMl7RpOCufW43
	efufzVHbYVrWoaJXFiy8trjg6I5QeIYIXVPdmIpq1fNITWCVV8Ju7BtUZkus3aFl8llCb7gnQIV
	rbbU8l8XOw=
X-Received: by 2002:a05:6000:4285:b0:43c:f40f:6c92 with SMTP id ffacd0b85a97d-43d150429c7mr15427579f8f.8.1775149477038;
        Thu, 02 Apr 2026 10:04:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d214f2b63sm6044517f8f.28.2026.04.02.10.04.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 10:04:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	Anton Johansson <anjo@rev.ng>,
	qemu-s390x@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-riscv@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v2 0/9] target/arm: Compile accelerator-related objects as common code
Date: Thu,  2 Apr 2026 19:04:25 +0200
Message-ID: <20260402170434.94783-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

First drop TARGET_KVM_HAVE_GUEST_DEBUG (all targets but MIPS
support it), then -- after minor changes -- move the ARM
specific accelerator units to target_common_system_arch[]
source set, allowing to remove arm_system_ss[] for good.

Since v1:
- Include missing "exec/cpu-common.h" & "qemu/queue.h" headers

(I plan to merge via single-binary tree)

Philippe Mathieu-Daudé (9):
  accel/kvm: Include missing 'exec/cpu-common.h' header
  accel/kvm: Include missing 'exec/vaddr.h' and 'qemu/queue.h' headers
  accel/kvm: Remove TARGET_KVM_HAVE_GUEST_DEBUG
  accel/kvm: Expose all non-target specific declarations
  target/arm: Compile WHPX as common object
  target/arm: Remove target_ulong use in hvf_handle_psci_call()
  target/arm: Compile HVF as common object
  target/arm: Remove target_ulong cast in kvm_arm_handle_dabt_nisv()
  target/arm: Compile KVM as common object

 configs/targets/aarch64-softmmu.mak     |  1 -
 configs/targets/i386-softmmu.mak        |  1 -
 configs/targets/loongarch64-softmmu.mak |  1 -
 configs/targets/ppc-softmmu.mak         |  1 -
 configs/targets/ppc64-softmmu.mak       |  1 -
 configs/targets/riscv64-softmmu.mak     |  1 -
 configs/targets/s390x-softmmu.mak       |  1 -
 configs/targets/x86_64-softmmu.mak      |  1 -
 include/system/kvm.h                    | 14 ++------------
 include/system/kvm_int.h                |  2 --
 accel/kvm/kvm-accel-ops.c               |  4 ----
 accel/kvm/kvm-all.c                     | 14 +++-----------
 target/arm/hvf/hvf.c                    |  2 +-
 target/arm/kvm.c                        |  3 +--
 target/mips/kvm.c                       |  5 +++++
 target/arm/hvf/meson.build              |  2 +-
 target/arm/meson.build                  | 12 +++++++-----
 target/arm/whpx/meson.build             |  6 +++---
 18 files changed, 23 insertions(+), 49 deletions(-)

-- 
2.53.0

