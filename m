Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D660E3BE644
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787179382; cv=none; b=cuUI9/IMsXkkBChFSXHiSnzrDp1J7fMyMvkKEWOmnZzuz9dAcf9R4ouTh599bLocQuN6Mop8YB6YtMu71v6/T2/KeUyb1p9KPHiUlMwSCGsJcEtvIXDAuYfumVeJHp3cQbfzjOuFHWHJyzkvZaCVCGeN2p0HPJ55rzgFsp1dM5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787179382; c=relaxed/simple;
	bh=TBv4jWE24nFMwbwZRdR3u9uJWahJa5hxuvryb+jc+e8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cvUQQ+S7sHjxXWj89+Fn2dU62VfeoVnTiBjap0aQWUzqcjoqiTsAna4MA6Tn7HmdtX1vuUZpNuFQ8oLb+9o5rTkNCcrKwH7BJjsrDtznRhmzBrIYX558pQCJDrTUHxDMFVr/xSna+YEf4d49ADWgsid5RSK6fwasrtQVw3bIN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MymcRbzy; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MymcRbzy"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f84023916so1453679f8f.3
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 15:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787179377; x=1787784177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vhLrSGY9svoYEa5H9hIeWUA3Z0wbe2vysdY+foWNbO8=;
        b=MymcRbzyCI9qU5cS+KQodr96iPszMfIwjMEtwHevceflmQzNARRkl0BQtuZyvfXyJi
         EYAaN362VjwkpytwHe581RA9LpPSI29/NMPpa9hoNHNKdSIg+VuQgT6FSDV4hgAB9nje
         9zp6FEp8dMNMl+/Y7Rfuuhke8mINnRAH6NigNS625u/zPZZTfEo+DqNDXBSTWLlT8H+e
         zlp1KMav5uC/unz0nEfVJbb6bX9knAiilENtOq2Xjt86xEClNDDHoNafMmNO5dpbx0Be
         KRx0aQ1uw8pLlNfhj/TsOfiYnQAGwrOKLILlmSN/Pj9ecKaycXBSA00GKR6gIJaAAJOK
         /gdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787179377; x=1787784177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vhLrSGY9svoYEa5H9hIeWUA3Z0wbe2vysdY+foWNbO8=;
        b=A5XqGlixAaIj9AyjVO4qT7IfAGHyLEbIv8qBjxVrBGmU44uekbQD5p72zszXZoJORd
         7B23cB48aQSuEEX86OSIUQhGwvpO8xV71xi0Ga8JOgHX/qrdSbzlgTF20uAxB6u8H3GY
         Nq7wY6CbZ5JZg1GHgLeEU2YNU6IWwt6RIA+8QXa4nwcZVoRL4aX6TC/KkwaxAtBBjyTs
         C1re4jakzIZsOSTbxFsqqerB5OiBYvFR+0LyAW6sdoLTdlhT618s9B11J8V7V7gRSIlT
         d7CMjVD35BoAMwfn1EZ8EQ1w864ap2Et9TuEiP2bIIIPjOcKDKFPUhVUQqNg1xZekz+T
         Q5bA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6nfUoNcmxxJwXHspDFXhhzHCykvVVtbklJKntkSfsb75teakiK5HSuw/B+PKKW9X6P44=@vger.kernel.org
X-Gm-Message-State: AFuF++lMN+P7TDNQhjc/tHP13/J+MWx4MfvCa5R9NuHp24nfmRULt60Z
	WXIP8xOS0bb9AnUR/CWavGzZDdtacVfwJW+CmKHdgPQErRTzknLwvfUY
X-Gm-Gg: AR+sD13G66b6pZEJd2xzBOKbdhapSNkk8PNGHBlj6uE/kCg7vR0kFY6r122IAco43Nn
	Ag3jw4OLawWFlZCbwKFO6B8dhelSDIy2aregpJo1r7ynxVF46TlDw2Z7hP4AYg5Qt3NyrMLDaYv
	f/vtmtTWTCR6Z7VL9DRaEXrZ7nzbbLYP7rt7dBlGQIbAiinFassaF5Foi5KZukt10QJsWLU09Jz
	/sn4NopT3dUZ18qZsAxrB5x6Ck5lxHm0Btheg7rAn3E7HzoIwTx1utobMitEjqq2ExjP2eSakyt
	vRTaHZ5D1PVsGj4O55tVm8rrUZvgBCEjo/+Hv9t+Ys2Z4/nPWMYcIlBMhY7PFxjgoeyGSWDxBhT
	iXwElmLZ7KWXWON7v+mBPYEeGkEv4YGrp7AlImrqHkpnPS/oVmV3TmuntYQB+HQXd2odDrGTXvV
	cFyKiTduJ/EzKIaIPxuegZGRpj+kXycmmlX1BqiEtfFI4AUx5m8ToQZiwgqfpySguLLDVYiCSQ4
	1IY9eVlnuKTSPuGPPLF95gSdaPB8S5LLN8qK6W7tQdR0Njt9Z7fi1xVf4V8tNtuNNmFqyMmTG3K
	yYLODGWV5dp1VqKvSsLRdPAjg+nsVqQ2JIbkd816aquvba64Dxx4coNVk0m6FjHxZmz6
X-Received: by 2002:a05:6000:41de:b0:482:a36c:a5e1 with SMTP id ffacd0b85a97d-482b1e875b8mr15751227f8f.1.1787179376510;
        Wed, 19 Aug 2026 15:42:56 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae9e-1d01-58d3-443d-4fa6-01cd.310.pool.telefonica.de. [2a02:3100:ae9e:1d01:58d3:443d:4fa6:1cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1450e61sm8553317f8f.13.2026.08.19.15.42.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Aug 2026 15:42:55 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <tabba@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/5] KVM: arm64: fix VGICv3 redistributor rollback
Date: Thu, 20 Aug 2026 00:42:24 +0200
Message-Id: <20260819224229.82948-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A failed REDIST_REGION write can unregister redistributor iodevs while
leaving their cached vCPU assignments and free_index values intact. A retry
then skips those assignments and succeeds with redistributors missing from
the MMIO bus.

Patches 1 and 2 fix VGICv3 redistributor failure handling. Patch 3 cleans
up redistributor teardown. Patches 4 and 5 extend the KVM selftest
infrastructure and add regression coverage.

Patch 1 reserves the current vCPU's region slot before registering its
iodev and releases the assignment if registration fails. This keeps
free_index consistent with the cached assignments.

Patch 2 uses the same cleanup during redistributor unregistration, allowing
the existing rollback to reset the vCPUs processed before the failure.

Patch 3 unregisters redistributors before freeing their regions and removes
the region destructor's now-redundant vCPU scan. It is not required by the
first two patches.

Patch 4 lets the common VGIC setup helper select the guest entry point.

Patch 5 adds a regression test that rejects an overlapping region, retries
at a valid address, and then accesses all four redistributors. It exercises
the failed region update fixed by patch 2. The MMIO bus registration
failure handled by patch 1 is not fault-injected.

Testing: built the patched kernel and selftest in an arm64 Linux Docker
container with GCC 13.3.0. The selftest passed under QEMU 11.0.2 TCG with
-machine virt,virtualization=on,gic-version=3 and -cpu max. The same
selftest against the exact unpatched base failed with:

  Unexpected MMIO exit at 0x8030008

---
Changes since RFC:
- Reset all redistributor assignments after a failed region update.
- Split MMIO bus registration failure, region rollback, and teardown
  cleanup into separate patches.
- Split the selftest infrastructure change from the regression test and
  check all four redistributors after retry.
- Rebase onto the current kvmarm/next.

Previous version:
RFC: https://lore.kernel.org/r/cover.1786344511.git.kmehltretter@gmail.com

Karl Mehltretter (5):
  KVM: arm64: vgic-v3: Undo assignment on iodev registration failure
  KVM: arm64: vgic-v3: Reset assignments after failed region setup
  KVM: arm64: vgic-v3: Unregister redistributors before freeing regions
  KVM: arm64: selftests: Pass guest code to vm_gic_create_with_vcpus()
  KVM: arm64: selftests: Test VGICv3 redistributor region retry

 arch/arm64/kvm/vgic/vgic-init.c               |  11 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c            |  33 ++---
 tools/testing/selftests/kvm/arm64/vgic_init.c | 117 ++++++++++++++++--
 3 files changed, 134 insertions(+), 27 deletions(-)


base-commit: 57e7cf13ac26bf1a3dba6cfa601f7b2481811575
-- 
2.39.5 (Apple Git-154)
