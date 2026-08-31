Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFE33C81B9
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163823; cv=none; b=QvIEFNwGTY6RKo2ccmr4Hlk21RAxkXN8lA9My2mfci1K7zrleROX7k/cs0LVqimav6olap0MIS0FZicQtG02SDgaaTAxiFoTzc+7AzgcVf40Uurzzk86LCzqkql+//F4f51ty86sH5usuBiaOGQZ1SiXUADMxv5pOvKpri/CFCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163823; c=relaxed/simple;
	bh=3oRLO2+O+nNQlRC3Hve6ZkusqNFXpr/KFZLae5kr4HY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TUydTvUnGbpyrVBEbTYitEfzgsjFur8tO0XvIjRDk5PGP+XyqeOzlVpMMLEseT6YWq7VRCmP87Ucv4+9cfWlbd3EA4ida5GHJ+QctBbYCr0UWrTW+x3ntE9oh6Colz/jiGUMi/OQgVS9tCOigTyMfUM2bpA7mdjbL5Pk6wdeIRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXs9sP7D; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXs9sP7D"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4957eefd361so25166305e9.1
        for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 01:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788163819; x=1788768619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=seMt61JR8WO02xp6SOLRxCCG0tr+MAwwqiFyhbMBI5g=;
        b=IXs9sP7D28TRk4h7/3d8MEvNkSBQOqJs5zeOy/IKpUnIgiDCG57nlpbRRoo4a6UABa
         VyDV/F0EdFb6a0lnR7l3RFkMUwyQ0ucY/mmlFdeNqSRRa4iHkKES4CyCfz3f3QZNsTvy
         N5fRmEFLrzXN08qbKXjho+scfUqfErRj1AtlysA4Wm5wo3bIurd21RhANxl4JoU44Dq+
         iq8j72wu9l6shn8rr9fPfehY4bJfTCedQjILcEfhgNzATLsLYp11qUb1xKtYI3r5WS05
         ZXSkSYwdsIqk9ZRmRES/fsbgIMYkAZrCZp2jOi1crrOZFIgnBdgUDThwnqScEv6bK0CG
         b++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788163819; x=1788768619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=seMt61JR8WO02xp6SOLRxCCG0tr+MAwwqiFyhbMBI5g=;
        b=dbnEx4dUh4J9WnVP+1t7GJZLwvUSt2dExUuAgUhlhBVgLM4vZzuVNbX9aCS+np/8q7
         DEx31yLdCZS4gInAcoKF5ndVSlxzN5abdjJEnT31iUELo9Y0KFU5BrLpb3DeYk4qFgPW
         TMsDoBommpfSX+46s5dcmBS8y4bVsIcakFnoFHV4ryir/+uZbw6MdmNQQi9qdBYBD05/
         SsfxtgHsXULGy09xMgt5qj6YLBImsyDNzp/APlE4xAaynX5G1xx6YnvUl+39VO9cMc1J
         5Do4ITgtv+jL3qks/urwJd1IN+1QOvXZczUxLemFGY0MbKjzGBoSFjNJ+SQ6yieKsAiA
         0x2w==
X-Forwarded-Encrypted: i=1; AHgh+RqPUorbbxd2tCkohIfLOmDCi9A7MKCoK1cPaFX3mWkLbtrhI+gQYs+lLKkAgWLbT5+cPFk=@vger.kernel.org
X-Gm-Message-State: AFuF++mzw2Dc34IlHN6ZejWCIw68ONWMBVuktvw+jUD8X5xaceF5HJk3
	GUc+GfnaANcblX5OeE2H5sqqvB+uy9e+GFPLl1bKyaikwSuKDkhLXA+O
X-Gm-Gg: AR+sD12nDSEFdNPAtuaZwn/RC/J/65hx8cG6GwUL1Lqne75adIMdEf/e8NUQZzOL3S+
	+hs6uODnnFXSHxT8vxl5g50UXiQmQa5v87A4t1ihBS5XyN8KLKQwcfc+SHG1oGAk6ob++3dEDEu
	vHYmcRrkvG/oVcGAecdyxB5ANqleNMraJOIEH2Rjy3NhNdHHU2eQwDl+/wTwEzrgd+96XYqIsVc
	mtwNYTYhZMFvXqZaFky9Fj4myPMiT5jXShDZqWmrOKZIiaZVL/X90uuHmZK5JNIA49/8S9gGa/8
	3WxH3FLQslLrVAFBs1gz/Ewpzf8jMeNTZfl7ilcv89ZXbSTk3VDhPnp+egZgfmv6r3qRRlSwEpE
	TFNeWLaSHEplC7+Hkgcv0p6k/ALZMLNZAb6z2vwjpuEQ1+dcRZKCDKEPOqo6llma0VIMRkJjtNh
	j4DLVikUzIOFI/gQ2HDy1JYpN1bWakZeC5BE3+3unfAGZR44p5lIVWDQdbYSk9NDuRxNdXIrjwB
	3F052C2XEfLmQg6oPxf+6KJQYzZYOTpTvkc4ss8tY61Xkebrg/Ol3c+bkTqCgD+v+M5g6OakkBe
	mYp6JKVXHfuXcjO+sLvTj2+VN5vqW1G0qxvwosMw1rGyZ+6kfMAk3Aynze/GN93iDFF8ogTHKE1
	IsPMabA==
X-Received: by 2002:a05:600c:5288:b0:499:84fe:5f3e with SMTP id 5b1f17b1804b1-49b91c41014mr396116665e9.9.1788163818374;
        Mon, 31 Aug 2026 01:10:18 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-acb9-0201-68d0-34d2-ad1a-175a.310.pool.telefonica.de. [2a02:3100:acb9:201:68d0:34d2:ad1a:175a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b95013d06sm370393515e9.12.2026.08.31.01.10.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 01:10:17 -0700 (PDT)
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
Subject: [PATCH v4 0/4] KVM: arm64: fix VGICv3 redistributor rollback
Date: Mon, 31 Aug 2026 10:10:00 +0200
Message-Id: <20260831081005.41346-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A failed REDIST_REGION write can unregister redistributor iodevs while
leaving their assignments cached. A retry then skips those vCPUs and leaves
their iodevs missing.

Patch 1 fixes the accounting when an individual MMIO-bus registration
fails. It reserves the selected region slot before registration and undoes
that assignment on failure.

Patch 2 limits rollback to assignments from the new region. Resetting
assignments from an older region can miss one held by a vCPU that is not
yet visible to kvm_for_each_vcpu() and move free_index behind that live
assignment.
slots_lock prevents a concurrent vCPU from acquiring an assignment from the
new region before a failed write removes it.

Patches 3 and 4 add regression coverage for an overlapping region, retry,
and final GICR_TYPER accesses to all four redistributors.

Testing:
- Built the modified arm64 KVM objects with W=1 and the arm64 vgic_init
  selftest using GCC 13.3.0.
- On an Arm Base RevC AEMvA FVP with GICv3, vgic_init passed with nVHE,
  VHE and protected hVHE. A VHE kernel with PROVE_LOCKING and KASAN also
  passed without lockdep or KASAN reports. A control kernel containing
  only patches 3 and 4 failed at the first GICR_TYPER access, 0x8030008.
- Under QEMU 11.0.2 TCG, test-only instrumentation paused vCPU creation
  after assigning a redistributor but before kvm_for_each_vcpu() could see
  it. An MMIO-bus registration failure was injected after one vCPU was
  assigned to the new region.
  Rollback preserved the old assignment before and after the vCPU became
  visible. A valid retry succeeded and guest GICR_TYPER accesses found all
  four redistributors.
- An adapted Linux 5.10.268 backport of patches 1 and 2, on top of
  8542a8f95a67 ("KVM: arm64: vgic-v3: Fix error handling in
  vgic_v3_set_redist_base()"), passed the isolated retry test. The
  prerequisite-only control failed at the same GICR_TYPER access.

---
Changes since v3:
- Dropped the REDIST/REDIST_REGION serialization and VGIC init/destroy
  rework, keeping the fix close to v2. (Marc)
- Limited rollback to assignments from the new region so an older-region
  assignment cannot be missed during concurrent vCPU creation.
- Added Fuad's Reviewed-by tags to patches 1, 3 and 4. These are otherwise
  unchanged from v3 (formerly patches 1, 4 and 5).

Previous version:
v3: https://lore.kernel.org/r/20260822095346.53882-1-kmehltretter@gmail.com

Karl Mehltretter (4):
  KVM: arm64: vgic-v3: Undo assignment on iodev registration failure
  KVM: arm64: vgic-v3: Roll back assignments from the new region
  KVM: arm64: selftests: Pass guest code to vm_gic_create_with_vcpus()
  KVM: arm64: selftests: Test VGICv3 redistributor region retry

 arch/arm64/kvm/vgic/vgic-mmio-v3.c            |  54 ++++++--
 tools/testing/selftests/kvm/arm64/vgic_init.c | 116 ++++++++++++++++--
 2 files changed, 151 insertions(+), 19 deletions(-)

base-commit: cf72cbb39da84b6f02f90c07f33b102fc10b16f0
-- 
2.39.5 (Apple Git-154)
