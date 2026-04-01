Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F7347C6
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074679; cv=none; b=TSU8a5Q1IX/S96C8oOOqidBkMsdfI/N3Ylh+QoFFyDbmqOFM//rdl+dhErZVvXpHqc7zSzhchq8GeOwD1miEf6zOqR5f81UlrSFQF+fks4BkeQ0ib4iDqZjMyUyNr4A9mkXa+ZUB2rzsGGdSbl60bf17AGGduuFZixQKo6rJS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074679; c=relaxed/simple;
	bh=L/oTqa8h3Me6Y9+KhXIyoZwZJ/gNDsHsDWyCLmfKkrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GPVViNenwBm4vmSQhS0vig899iZCqylGKqS2wdrzAxMNUMO1cnN10nsuvU8aNwefw67kVZbATl3wRI6i1ECml5wL9CCDVjOQOP7Vx1IfL2dzyfjXBZEDL3tGBAQQzzMRaBWnkds/+79zA8ZyBUK6lbtebrSD1v+NU1nwDWf/fQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o7doQ+3p; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7doQ+3p"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486ff201041so1078465e9.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 13:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775074676; x=1775679476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D9EJVmPQy6eeZJJyEDHNsSijB+T9mGxWe0hCWzvTRWs=;
        b=o7doQ+3pEYCmTxNK984qUq5xbAh4jhN39t5Rw1ODVB6+4YTckSmbjwZZaaN+N8pWTO
         urhb05pAq8DXItF/4309Ik+n+QuwSDHPHhDwL/mtEjhjork8x1U5KtWxlJtCESwH5yc0
         gsH5GkXReJxS03jgvCwCcDiDI5Jt4zi/U2DwkfheksnPTgPpVkUUBAcc42JmQFKL5baR
         LUK1xb4RHSSfzaqfDmQhkw7TNK8pI3hJoj0nbLDB7kpkgDhFho/Q4tUFK4IZ024XAwjt
         QppmQoII92Z8s5fJ53Is32qJWA3HOHbgbzMM3IWU5C/qO+kde7wb0Qkdk6Ce2yJuEbbd
         /Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074676; x=1775679476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9EJVmPQy6eeZJJyEDHNsSijB+T9mGxWe0hCWzvTRWs=;
        b=oSNYA2/1BjxC8eXW+swtf6wwAogM4xd8QutYKwKbBaax7V0Mvkg9AWrLqWaa+8MB1g
         Oj5glrAiMF/iyJgMOgwTBnLB2qouPJsaEzobU59arF3b4nX4X4t0d0C/TWz5yOIv6dRF
         wAdU1YGZ3Qbd7OpUqoJgp/jVSWMrhrAHQzPqVmjNLh0ENt9D3v9G0p4D8G1EgWV5g1J0
         lICzQQYOMRTIVe1bEU1yWUu3/pC6N1SWvqk74PQrB+idJ93JHz/lb2HniQXQbN8lOhmX
         mDTkBhQg/OMysL7KCDl24x0GVSt4kmW+6MaG7Ctekiy1uSt0zJKW2ne9SvzeeS5d74Oi
         Di/w==
X-Forwarded-Encrypted: i=1; AJvYcCXbr+tUpUNjBHQaozJR4Vcj3ohJgSuHVlz9Mp4wgwrKDSraad2nM1CBaSjOHfXEn/FCCXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39hVf7iMcTUzTkN+Ux5dCAHJpE1ZHoDAZNJGwJIMp0WEJpZSJ
	1br4cXhB9foWV9ClO9X6UXV1wpAkoE49ZkHyKaPtIsZ/REGVod5Wt6SXZrsqfpnvLU9ZlXMSVvL
	FHbXM8e0=
X-Gm-Gg: ATEYQzxlVswwLw8PpOJJKoaPLpRi1IPuc4sraIEZPa/cSV202UwtkgYiRrDdnt+sR51
	uS+IOKeTI3pnRx8wZ8vDAxbqskkgUrzYBhBF6yV+FlfT+BEAOemHB4q9UZ0faZwVKIJDg5Wggka
	9WNlBB10P1ngWcelg5llVgQHDqlTzSvxOi2VXvxbcSH4rlYfrpDHVNFlRQLhGBJEHYQBai+RX+C
	gxv2Zq1A2qJ1cKAzamon5evGF7oWp5u3HxMcekD4dY5hiPshGIHA1KUD4YJ1R69ENc5EDqEiVPs
	864A2rrVuUElWid9GlcWTbMOiy8L7BxGa1rQKm/jf2wAEWHrP848OWcYDY9VaYW56xfeANrNbRh
	eA1k72/hL8gT9ObJ+cs4Rsu6WXi/aQLZG9/kD08jt/GlhPCbP+D7ObQ926k2ypQ1dzkdyIvCl9y
	XF4UjTFh+V0tlFvOe047NAFcV4XULkh9GyuZZ0WEWTpSBaKRYmlg5+TaB283PmHHDEr92Dp310
X-Received: by 2002:a05:600c:310a:b0:485:3d3e:167b with SMTP id 5b1f17b1804b1-4888b6d4a4fmr11059385e9.5.1775074676186;
        Wed, 01 Apr 2026 13:17:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a7165aasm24239995e9.14.2026.04.01.13.17.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 13:17:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	kvm@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	qemu-riscv@nongnu.org,
	Alexander Graf <agraf@csgraf.de>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Anton Johansson <anjo@rev.ng>,
	Song Gao <gaosong@loongson.cn>,
	Weiwei Li <liwei1518@gmail.com>,
	Aleksandar Rikalo <arikalo@gmail.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>,
	qemu-s390x@nongnu.org,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	Bibo Mao <maobibo@loongson.cn>,
	qemu-arm@nongnu.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Zhao Liu <zhao1.liu@intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 0/8] target/arm: Compile accelerator-related objects as common code
Date: Wed,  1 Apr 2026 22:17:44 +0200
Message-ID: <20260401201753.92290-1-philmd@linaro.org>
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

Philippe Mathieu-Daudé (8):
  accel/kvm: Include missing 'exec/vaddr.h' header
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
 include/system/kvm.h                    | 13 +------------
 include/system/kvm_int.h                |  2 --
 accel/kvm/kvm-accel-ops.c               |  4 ----
 accel/kvm/kvm-all.c                     | 13 ++-----------
 target/arm/hvf/hvf.c                    |  2 +-
 target/arm/kvm.c                        |  3 +--
 target/mips/kvm.c                       |  5 +++++
 target/arm/hvf/meson.build              |  2 +-
 target/arm/meson.build                  | 12 +++++++-----
 target/arm/whpx/meson.build             |  6 +++---
 18 files changed, 21 insertions(+), 49 deletions(-)

-- 
2.53.0

