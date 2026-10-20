Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493005;
	b=Tp+kccnOniHaCckecFvZNjlLuiODHSTTMoYYj7Ilnn5zabaS/NmhHAIZMUPbGXPBvUDc
	 jSSRJDWBFifLnTSh7aHbE0iGOpMKRgzINZRvQ3xetvoaqDCoVxAdUeqzJztraXlvJ++AS
	 3+9GFO1bazt9iCTy74qGmzcCWXAYdA4DB4A1NHPPNtO/94F86zLr4wLlExrK4yPEzmHTr
	 iL/ECyzHQ/ago1A/ZUTU86TR4qE2af7i82M+ouDO9KnV5lk/i9hNuupIkAAO5PkiQk8Dj
	 Wb3MEnFt98RUr1VxjPD7GiGE3KZIdrY/arwnQJHGgw4KfckcTfVN0cN1GM6OwH4tgXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=3NNeDfISu2gpg9ZYXN0W5UQrgwObRlFXGjX8CXeq/qY=;
	b=U3bxp62lwHdEVdOPcIqsjc5m0T9WzhqMCuy4UnAiUFsvTX4i2OTmb9Lg2GR4S/doqxBE
	 kPokwY//wwsMdliDWP1EfPogzXoxzTq5za4h1g1hMsTaTX7YRnU3wQ7RuGY7BBQnrscfM
	 d+zGecTNSaNJLulLrw3F7/FFa+roVriCTuinorYWQSx3zqQN9HFpw/wuk7OT1Dt8KQ/og
	 h43A4JdDDqoMflYQTvP5rHZAD3G19fB+Cx4QAZ5iv/Ve49SCyuwyuBKGxT53cCJM8TrPX
	 +9zrg43pSGgjNcqx6lsGZC4qbUHBE44YQ5Iy4gZK2xI2v3XA8h3MiSI5Lrb7esMVWiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZzXPp+cy;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA53C606A327
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA53C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZzXPp+cy
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so21607555e9.1
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493003; x=1793097803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3NNeDfISu2gpg9ZYXN0W5UQrgwObRlFXGjX8CXeq/qY=;
        b=ZzXPp+cy41nzog4uYXELR07dErtQdAt2dRqel2MX+ZlFIuveZcY7EB/6DSX2DUNnZ4
         Er6f3BP9FSukzBuL6qeel0gKztr2l4KIDKlzXjTXSUOp3ul+iXWR8preCUJMBIkQrIYO
         Am4u7Jor1Qohq556qHf8bHdrlLJty29rO+2xhuGs9VMvqYna7HjzzmeTW6s7tq+/22xI
         Q8sdXhEVb7gCtAwISqRRknnpuua9VQ98bX5DSI9D/j+bqsMh0pEQMtGAE2ppB7t/HIBq
         WVGrHorHi2Yt00AEzy9WlCsTGYAYYUw/wbOOQjI8XgisYmay7MxJ0p2ces6DSYgrZGM5
         rOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493003; x=1793097803;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3NNeDfISu2gpg9ZYXN0W5UQrgwObRlFXGjX8CXeq/qY=;
        b=kc8QXqo8RJ8N7zD1wCkosWauLMpUbXEM6SOu5/hkqgati9geDeBeB3E6Pf5qeTekT6
         HskkCkXGHpwW8cX7FGxcHJT3EcMvKFCNYE68eKEYU6MxkYV/J8mcyBDnZ+cZYmvGslHN
         MBTLQ5QhlYXWs+HgWIfoTPVTiO9B2Rz4orvMYkgY5ndqi+jxZKT4FqsgaKeLYI6Ca6A3
         R01VxUgBMJnDFB7VBMcx0R+JVNvMcpHuKXaspMty3QTyCF1t6eGyk2irW/KBapG/4cN5
         q82Vwz76NzLGb7Tk9DLVwA7kA+eL9gPrdfmWsQzFaKegNJeHXO77vU6r5BBmScxYPeD2
         AX8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwSP/dj8l1jAasvinO5PYIb90g9pIP5KgynTwoBSRKV2TpZtsWhC4vDMdBjd/T3wQm52cw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdHmY37LeNwx0gwq8vWLsoIx5AquAb0eRJIs+yI6iz5YVje3Pf
	dgo3OWikUF8rN8lG0CjHJA/zsTXIhj9pM96F3xtAauVwVgprlLHJlFL5gF3RYiPda+c=
X-Gm-Gg: AYBFou20rZku71rbADX3P+8bNdkAI1YsyszEvZREFJLGtMZSYc3PcwZdiHR6POFQgyN
	Cq1jM8L7k2SoZTFiP220vpi+1pR7vUDEnjGO61iLfPBdXqBKaD44DTBOw9jWHy1MAx1Anz3GYht
	r5L+a3fyNcL9jLVIA6tDvJ3tDTbbUSscRWlBvKWxH2m2uUjc6s1FGDw2poF/T93JZHxRfwQS++d
	wm5rH6dAkwEx/35xeGm9T2gwPDzCDcTHDxVTdI4HHLWy/iaEaK8huXP9f0wRwof14q0C3IZPfjs
	dt0+hJbPiQcdX9JUd3WvB7pDMataCfWJsofzyMfDmr2z95C3UvQZioARm1jGLWkOmWKTyQyQbV4
	rARuM6OeVDeVngGiEwxskiv3cwo7Kj1b8GtzsyvrKoVpA2CdWEM2rtQkGh3DZMiQCm5EolxKkZg
	AMWIimdVYCZwInoDYfNYJQFbgLoVHOWr1D265MrUVj7gVdDubX8Dnr0n/dEReGpXGIAz5DbgLPC
	ZR8mRyo
X-Received: by 2002:a05:600c:608e:b0:4a1:e08e:46b5 with SMTP id 5b1f17b1804b1-4a1e08e4871mr157389645e9.16.1792493003076;
        Tue, 20 Oct 2026 03:43:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce325107sm289903195e9.3.2026.10.20.03.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:43:21 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 37ED55F8DC;
	Tue, 20 Oct 2026 11:43:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Song Gao <17746591750@163.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Bernhard Beschow <shentey@gmail.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paul Durrant <paul@xen.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Walk?= <bwalk@linux.ibm.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	qemu-s390x@nongnu.org,
	David Woodhouse <dwmw2@infradead.org>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	qemu-ppc@nongnu.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	linux-edac@vger.kernel.org,
	Glenn Miles <milesg@linux.ibm.com>,
	Chao Liu <chao.liu@processmission.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Xianglai Li <lixianglai@loongson.cn>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Chinmay Rath <rathc@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Amit Machhiwal <amachhiw@linux.ibm.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	qemu-riscv@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 00/23] kvm: introduce KVMCPUOps
Date: Tue, 20 Oct 2026 11:42:54 +0100
Message-ID: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a world coming where we can have a KVM interface which
supports multiple architectures. The old style approach of using
linking to resolve per arch kvm_arch_foo handlers won't scale and is
also slightly antithetical to the flexible not-quite object orientated
way we do things in QEMU.

Taking TCGCpuOps as a reference this implements KVMCpuOps as the
shared function dispatcher for CPU specific KVM operations.

A couple of open questions:

  - should we consider some sort of shared AccelInfo region for
  CPUState instead of a bunch of mutually unused bits
  - how can we improve coverage of KVM testing?

The main driver for writing:

  Message-ID: <20261019192704.3220373-1-alex.bennee@linaro.org>
  Date: Mon, 19 Oct 2026 20:26:45 +0100
  Subject: [PATCH v3 00/19] testing/next: functional testing updates for gdb (pre-PR)
  From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

was so I could be sure the KVMCpuOps where properly working. I don't
think we have that much that exercises KVM in our CI system anyway
because most runners don't give access to HW virtualisation. I have
tested this on:

  - x86_64 (on my dev box)
  - aarch64 (on my personal dev box and the aarch64 ci machine)
  - s390x (on devcloud instance, same as the s390x runner)

Notably I wasn't able to test the riscv64, loongarch64 or ppc64
behaviour. I do have access to the OSUL ppc runner but it doesn't
support nested virt and testing on that machine needs some love anyway
(see #3207).

Anyway I await your discussion ;-)

Alex.

Alex Bennée (23):
  accel: introduce KVMAccelClass and KVMCPUOps
  target/i386: wire up empty KVMAccelCPUClass
  target/ppc: wire up empty KVMAccelCPUClass
  target/riscv: wire up empty KVMAccelCPUClass
  target/arm: wire up empty KVMAccelCPUClass
  target/s390x: wire up empty KVMAccelCPUClass
  target/loongarch: wire up empty KVMAccelCPUClass
  accel/kvm: port kvm_arch_pre_run to KVMCPUOps
  accel/kvm: port kvm_arch_post_run to KVMCPUOps
  accel/kvm: port kvm_arch_handle_exit to KVMCPUOps
  accel/kvm: port kvm_arch_process_async_events to KVMCPUOps
  accel/kvm: port kvm_arch_[put|get]_registers to KVMCPUOps
  accel/kvm: port kvm_arch_pre_create_vcpu to KVMCPUOps
  accel/kvm: port kvm_arch_init_vcpu to KVMCPUOps
  accel/kvm: port kvm_arch_destroy_vcpu to KVMCPUOps
  accel/kvm: port kvm_arch_vpcu_id to KVMCPUOps
  accel/kvm: port kvm_arch_update_guest_debug to KVMCPUOps
  accel/kvm: port kvm_arch_[insert|remove]_hw_breakpoints to KVMCPUOps
  accel/kvm: remove TARGET_KVM_HAVE_GUEST_DEBUG
  accel/kvm: port kvm_arch_stop_on_emulation_error to KVMCPUOps
  accel/kvm: port kvm_arch_on_sigbus_vcpu to KVMCPUOps
  accel/kvm: cache KVMCPUOps
  accel/kvm: remove redundant ops checks for kvm_get_cpu_ops

 docs/specs/acpi_hest_ghes.rst           |   3 +-
 configs/targets/aarch64-softmmu.mak     |   1 -
 configs/targets/i386-softmmu.mak        |   1 -
 configs/targets/loongarch64-softmmu.mak |   1 -
 configs/targets/ppc-softmmu.mak         |   1 -
 configs/targets/ppc64-softmmu.mak       |   1 -
 configs/targets/riscv64-softmmu.mak     |   1 -
 configs/targets/s390x-softmmu.mak       |   1 -
 configs/targets/x86_64-softmmu.mak      |   1 -
 include/accel/kvm/cpu-ops.h             | 171 ++++++++++++++++++++++
 include/hw/core/cpu.h                   |   3 +
 include/system/kvm.h                    |  42 +-----
 include/system/kvm_int.h                |   2 -
 target/i386/kvm/kvm_i386.h              |  20 +++
 accel/kvm/kvm-accel-ops.c               |  13 +-
 accel/kvm/kvm-all.c                     | 183 +++++++++++++++++-------
 accel/tcg/cpu-exec.c                    |   2 +-
 hw/i386/kvm/xen_evtchn.c                |   6 +-
 hw/intc/openpic_kvm.c                   |   4 +-
 hw/intc/spapr_xive_kvm.c                |  10 +-
 hw/intc/xics_kvm.c                      |   6 +-
 target/arm/kvm.c                        |  96 +++++++------
 target/i386/kvm/kvm-cpu.c               |  26 +++-
 target/i386/kvm/kvm.c                   |  42 +++---
 target/loongarch/cpu.c                  |   8 +-
 target/loongarch/kvm/kvm.c              |  96 ++++++-------
 target/ppc/kvm.c                        |  75 +++++-----
 target/riscv/kvm/kvm-cpu.c              |  95 +++++-------
 target/s390x/kvm/kvm.c                  |  89 +++++++-----
 29 files changed, 628 insertions(+), 372 deletions(-)
 create mode 100644 include/accel/kvm/cpu-ops.h

-- 
2.47.3

