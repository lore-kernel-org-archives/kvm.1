Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18F3502A8
	for <kvm@vger.kernel.org>; Sat, 22 Aug 2026 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787392436; cv=none; b=NYeeBeNRFHBqMtBULiDXy9Nc8GquGbZPrZ59LF/1TFBmqRB5/dvN37xzLzZHYG/uOI6O3XOMs8CzvrjJi+x86eRsfAasro01zpuVmn2g7+Ubwe9Es0kRxVWKpx9qPzGKbF+aJxwxur50XleZXEVr/aq91YwqojiFNyIcGfzm/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787392436; c=relaxed/simple;
	bh=P/Ktk545jXRLZttOHRTppRjr9SjSkBeTUeBlg3rATSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cS94xZK5JYIF5EjiW8DTO0gS8cXBnuhgYU8FcxsuEQaT0CRcBWU2bLi8UbcswKd6Xh6KdcigRvqGKnhhou0t6o2+X4MgaEs/pjHtoGAG6vaFmkKZfvlap4tneM36RyyzXKAaRjbWC5bRayWFrShqjvRYsbK4ImyPjOzG+2/7oUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXjBU1xY; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXjBU1xY"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso3352643a12.1
        for <kvm@vger.kernel.org>; Sat, 22 Aug 2026 02:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787392433; x=1787997233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KmdKERRlZ3s8gh9GxjWOTYWpaFpAZrnfexg7i/lEpyM=;
        b=QXjBU1xYWJy37qjr2L7hTeeK1K2gV8ebfYaLbZBGNRF1bhaDrzTPtYRLBW4kOAeli2
         FsNiMHlcbynGPhBBjGbUgAz6pBm0FYV1fQ1P573CDa2u5mZZjpaNgL19pPNso42e9Tkj
         ia4gBUj2zvLO/p8q6A3DIz6hq3Jje5AotTvaJAP0Ifxaq2d68p2VhFeH4T6MYPbL4i8g
         kNE1uCeFg9CW9v1jbSrioFBJ4uD/yyI7OvqcstABE6kLF8Oeld1d1GMjeDnj2zkYGH6V
         6BdY2Usfu+1+6TQTABv5TwzIpooosn3GFiXzU1rCje2HIKuXKU+ijk44fOX+8sUy5i36
         mwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787392433; x=1787997233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KmdKERRlZ3s8gh9GxjWOTYWpaFpAZrnfexg7i/lEpyM=;
        b=XNIxXggzLmT4kQkSbM4tJZtG0c2/TaTg+onwYp8mOFR2ZU2fiU2s9TtxaQyrDPyXh8
         tJgbXGBomJwH4OsriaweS76rVQBEIbG2MeFIQaBlFmlkmc1TW8IdtzZ318v3vTEKf3lq
         d64bgG/uATI10ltf8cd5uRZ3DpTAbfYOULeQouTjYuyJ8azrckTjqk/tkztXD+hUFBl1
         u3uFAQ/pnF1I6NoHCpF5b2vkhGKSwn9yLFFLtt4KhbZ+kp48meZxhJ0vWfWmczydoeDB
         RLkTiqGJWrvYojvnKPGPRMc2ErcrcrbESB7YhXfzce+sOSaJkVtiC0hGBhMYo2xAl5ax
         8NZA==
X-Forwarded-Encrypted: i=1; AHgh+RoeAb4nAJhtqq3ZFDNZf9jrZNjCJbNJ9Jq7eKyxjGp94xzOK6KhGwd4BjE9UCdjtjdfSQ0=@vger.kernel.org
X-Gm-Message-State: AFuF++mNFOAHtuPxRmONCySiJCwv6G5D+GXCAC110SIlit+yvjWWU2qI
	UvWmjRzC9zvGTEW1SnFzBYYlHr6Maatn5qksdy0Kr3138E1Av3HIrlT/
X-Gm-Gg: AR+sD13rIk7WD73dlmXqNX3l0GuvzeN2MPjxPFhQvs/kexKoOd0C1Q92V4DlqOwnhho
	I7FuPdW+U70dR69iLjpdRT7G9MNFdgEfY/lnORIHTyuU3ObtgupusHBb99OlgXg9kuykRirv/Rw
	PxDTV7hFTnHXPDmA17CiQJmEz5rGUizYrxMOw/5InBTeti8S+qQFSvbG91TprV74nBqHs310Gjh
	A7uofo9zS5J8pAG44XqSMsQo2YrVE8JvpbGpxFccsDzqlXpyAbq+4Bmht4IPO9Pjz1Jiv7v/f3C
	rADc8O5aMaxbEGM5Jq9cAu0i3W0Fe8QLea2Obw4HFHhao0ObSqq7AS6Sr7U9Bne5fm2zK9RPvBI
	DZGFLtcejM/OLLZO42VWfl5NywiIZ6B5T9iHr0gqd+yhpqSYORmmLg0ujMDG2iyCNpl0jnmiFtF
	j+VomFBUCTc782ghLJmdxE3llQpl0bF9vSUDYnDfwSutk7sp0xa4hu1kT4sMqEQt2ReJtRPBxEq
	ppnsqvnQT6X7eNICVDZi/6Kqinh1nQPQJLlkXQJ8cjd6kkH/pdRU6z+ws6dWx2efSnJZGUmY+Lo
	PyHXVHnxLZFkmFVXHePJ7ex/xWqMAWaGNBA5x3/0YXHV0MpAM7CvMIUGhH9hYr56UeEH/09/wRr
	TaVzrGEJFAW/IBOA=
X-Received: by 2002:a05:6402:24a1:b0:6a3:f74d:6a20 with SMTP id 4fb4d7f45d1cf-6a582b0c6aamr5531353a12.4.1787392432720;
        Sat, 22 Aug 2026 02:53:52 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de. [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c327asm11151586a12.8.2026.08.22.02.53.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 02:53:52 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
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
Subject: [PATCH v3 0/5] KVM: arm64: fix VGICv3 redistributor rollback
Date: Sat, 22 Aug 2026 11:53:41 +0200
Message-Id: <20260822095346.53882-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A failed REDIST_REGION write can remove redistributor iodevs from
KVM_MMIO_BUS while leaving their cached vCPU assignments intact. A
corrected retry then skips those redistributors.

Userspace should instead see a failed region update atomically: no prior
redistributor assignment survives the failure, and the next successful
update rebuilds all possible assignments in region-index order.

Patch 1 fixes a separate accounting bug when an individual MMIO-bus
registration fails. It reserves the selected region slot before
registration and undoes that known-latest assignment if registration fails.

Patch 2 implements the atomic failed-region behavior. It unregisters every
redistributor iodev, clears every cached assignment, resets the region
counters, and frees the newly inserted region. An in-flight vCPU can have
an RD iodev before kvm_for_each_vcpu() can see it, so REDIST and
REDIST_REGION writes are serialized with vCPU creation and return -EBUSY
while the created_vcpus/online_vcpus counts differ.

Patch 3 is independent teardown cleanup. It separates MMIO-bus teardown
from config-locked assignment cleanup, preserves the cleanup required
before a late failed vCPU creation frees the vCPU, and removes the special
conditional from the common vCPU destructor.

Patch 4 keeps the selftest helper aligned with vm_create_with_vcpus(), and
patch 5 adds regression coverage for an overlapping region, retry, and
final GICR_TYPER accesses to all four redistributors. The test exercises
patch 2's final-state behavior; patch 1's MMIO-bus allocation failure is
not fault-injected.

Testing: built the patched kernel and the arm64 vgic_init selftest with
GCC 13.3.0 in an arm64 Linux container. The selftest passed under QEMU
11.0.2 TCG with -machine virt,virtualization=on,gic-version=3 and -cpu max.

---
Changes since v2:
- Patch 1: limit free_index rollback to the immediate registration failure
  under slots_lock instead of generic unregistration. (Sashiko)
- Patch 2: reset all assignments and region counters after a failed region
  update (Marc), and serialize REDIST and REDIST_REGION writes with vCPU
  creation so rollback cannot miss an unpublished assignment.
- Patch 3: add an already-locked unassignment primitive, move failed-vCPU
  cleanup to kvm_vgic_vcpu_destroy(), and remove the redundant base_addr
  reset. (Marc)
- Patch 4: match vm_create_with_vcpus() by using void * for the guest-code
  argument. (Sashiko)
- Patch 5: document how the first three redistributors span regions 0
  and 1; no functional change.

Previous version:
v2: https://lore.kernel.org/r/20260819224229.82948-1-kmehltretter@gmail.com

Karl Mehltretter (5):
  KVM: arm64: vgic-v3: Undo assignment on iodev registration failure
  KVM: arm64: vgic-v3: Reset redistributors after failed region setup
  KVM: arm64: vgic-v3: Separate redistributor teardown from unassignment
  KVM: arm64: selftests: Pass guest code to vm_gic_create_with_vcpus()
  KVM: arm64: selftests: Test VGICv3 redistributor region retry

 arch/arm64/kvm/vgic/vgic-init.c               |  46 +++----
 arch/arm64/kvm/vgic/vgic-kvm-device.c         |  20 +++
 arch/arm64/kvm/vgic/vgic-mmio-v3.c            |  83 ++++++++-----
 arch/arm64/kvm/vgic/vgic.h                    |   1 +
 tools/testing/selftests/kvm/arm64/vgic_init.c | 116 ++++++++++++++++--
 5 files changed, 200 insertions(+), 66 deletions(-)


base-commit: 57e7cf13ac26bf1a3dba6cfa601f7b2481811575
-- 
2.39.5 (Apple Git-154)
