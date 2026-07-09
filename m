Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA97244661
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602046; cv=none; b=qph4Y5Am6e8a6uhyAyHFM343L3GnG21mncJ6S90cEEGq2YMOhAhQTvtqIoueU0e0O6fKGi/EPpkfLN5RY3x4XXhjWmMq4VB0GCi1t5ypT8l4hZZ2wivXdWNi6jheEGLduPsfx+f9rCxJPBi9A5OF371dPX0q5UAhFnGGKioeOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602046; c=relaxed/simple;
	bh=qozIPT0fEoIc0M5kV9d8AahmBubmQ3L39n71Acz9RS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/PT3tAPgw2+G4TSmCUiuYjuFFELHkk2RhrRo1lu6UcN7fDunYfwSEFGZdY5CXWmrt/hvjn3kN/ouuvBrtXQzb1H3g1HoDlBmXU90VA3xMsMIJ4dJJkNiMT+J68jn5mIN0djkJ1UUTOOmkuZJNzxUEvbfQvtREGu2h0vGmvZ0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vr/IHMAy; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr/IHMAy"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca92f36c4acso67361a12.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 06:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783602045; x=1784206845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lg4645HSiS5JZdY+bW3DgGTrgEGwdoGfmFw6PnvB3Go=;
        b=Vr/IHMAylY/9L7NyfeKnoS6ca962aNayaLnF1T8u6yj6VPl27bk8zccTh+mBtj0Mk3
         DU8SCQjaYlJ8JU+QWemG2ptjH2ljtaTuf8MzCAoWsWwAAe5Un7Sds/JPwfJUJ3TtowjX
         gCfkn0YsX4GKnYcg2xoWniEQrwMnnflv1EQHQEQVc+JoJpfcGEP20YPPITUWPL8rQH5t
         naCXZTmcvAeERr5Br64iAAnuYHjKHRrktaVg06cZC9eamZpPaaITGjup50iPkFThRI+J
         vO2aASoeE6N25btuMrleoRMLVd8elFjVsXWoHQtKL1tGPo+C+R3EJOuza+6HI8azcVMm
         3qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602045; x=1784206845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lg4645HSiS5JZdY+bW3DgGTrgEGwdoGfmFw6PnvB3Go=;
        b=js+/GPj4CWJqdbae3GTcuLwiMm6NIFVr8j6DrLsJSHf4qYzRZoKk0pOISCGLTpohjf
         PVdfKp6TUB/gtvkqgjs1PLGi9aqX9HyjQ0dHAXeZY2EYWGvRAtLDXahUV76GgoN8m9fE
         748W3JA2/a2YQORYv1cjhH2NWO0s7H7rkDVLpvgQzbOkr/c2/bIh2Avyfqm+m4hxvbG5
         b5DU0aR+OBQvY/zSAm+NOVCDwLoK6xym/K6h1YrUKMPwYdPG9830T1FbpQVvIYn+Ce62
         GPr/0tEb0TkUullqijx5Pfz5Ytj58jkRq5dVaGR+FF0IGq3IwBUwKAuX9ZBOpOHl0UVw
         0ulA==
X-Forwarded-Encrypted: i=1; AHgh+RrF7/HkOllSCZ/EdJr4j3cd2ScqZUT1qkrbbQHHb+5IiHKwa9k4QOZxgmj1eWIS3LjGFwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTVpGoh3NXLvr7yuG3eAJgKBdzsEWA5AbE+fuu0pEI1UhGJhIS
	M9M+VcI3nmjXsh4Qqe7QcNaZVOIzMUFyo8qxTligz3tRE5jX+YmN/ZlH
X-Gm-Gg: AfdE7cmnyMREZw6JQ6v72JL974VxJCSMMDwIl+r6kWirXRWpq0MXw4fsEPAGIv2vl06
	zHHC4YeZLkpG1OrgzfnV/b/WGmzBCfwNY17hKfI8A3JpfX5jCMng7t2N+9zSWiiZEKfOCVg95Up
	Dsy2eYfh9RaK2tGgGEbCShydxmMhTLNQkRZbOE5ITHFXVxA6t3jIou7bgNqKIdHDlgIAqxXZNqx
	J7TWcOTlpGtDR6iIQbTOsPLPPfrHkBVL/cOSk0SiUIAV1OUdYKoxO2bl+uAKP9jM6x22fKMDsaj
	q8Cm3lfIwjnn1GELHWcKzQ2/Ar+I4ajZvlCnCXWkXju6lR8kwz8E41wIomjMvqyGC+8paDWYB/b
	l0NGiMf4qC8Irmbch6X5GnKKSgduD63W7wCIIij2n3FlwmpraF2eG2SfEWlpJlxdjGhIT3eyhYr
	+BdxCKFD3wtqnKl1JGwLSs8Xul0P4=
X-Received: by 2002:a05:6a00:859f:b0:848:5935:2e11 with SMTP id d2e1a72fcca58-8485935322amr2775708b3a.48.1783602044433;
        Thu, 09 Jul 2026 06:00:44 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b975a0sm8752976b3a.14.2026.07.09.06.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:00:44 -0700 (PDT)
From: "Bingyu.Xian" <shanbeeyoo@gmail.com>
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	"Bingyu.Xian" <Shanbeeyoo@gmail.com>
Subject: [PATCH RFC 0/1] KVM: riscv: G-stage PMD block mappings for VM_PFNMAP
Date: Thu,  9 Jul 2026 21:00:35 +0800
Message-ID: <20260709130036.1708586-1-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Bingyu.Xian" <Shanbeeyoo@gmail.com>

This RFC adapts the arm64 "stage-2 block mapping for host device MMIO"
idea (commit 2aa53d68cee6) to RISC-V KVM, allowing VM_PFNMAP regions
such as VFIO-assigned PCI BARs to use 2 MB G-stage PMD block mappings
instead of being forced to 4 KB PTEs.

=== Why this matters for RISC-V ===

1. RISC-V virtualization is maturing rapidly.  The H-extension was
   ratified in 2021 and KVM/riscv has been upstream since v5.15, but
   many performance optimizations that exist on arm64 and x86 are still
   missing.  This patch closes one of those gaps.

2. Server-class RISC-V platforms are on the roadmap.  Device passthrough
   (VFIO) for GPUs, NPUs, and high-speed NICs is essential for
   data-center workloads.  These devices have BARs ranging from tens of
   MB to multiple GB.  Without this patch, a single 256 MB GPU BAR
   requires 65 536 G-stage PTEs (512 KB of page-table memory and 65 536
   G-stage faults), compared to 128 PMD blocks with this optimization.

3. RISC-V IOMMU specification was ratified in March 2023 and Linux
   driver support is under active development.  Once RISC-V IOMMU
   hardware becomes available, VFIO passthrough will be a first-class
   use case.  This KVM G-stage optimization is a prerequisite for
   acceptable passthrough performance.

4. RISC-V has a natural advantage over arm64 here: the memory type is
   determined by the physical address' PMA (Physical Memory Attribute),
   not by the G-stage PTE attributes.  So promoting 4 KB -> 2 MB does
   not alter memory-type semantics, unlike arm64 where the stage-2 PTE
   MemAttr field requires careful handling.

=== Design choices ===

Unlike arm64's original implementation which derives the host physical
address from vma->vm_pgoff, this patch walks the host page tables via
get_hva_mapping_size().  This is more conservative but safer: if the
host mm itself has not installed a PMD leaf, KVM falls back to 4 KB
exactly as before.  The vm_pgoff approach is unreliable since the VFIO
unmap_mapping_range() changes discussed on the RISC-V list in 2025.

The first version is deliberately conservative:
  - Only PMD (2 MB) blocks, not PUD (1 GB)
  - dirty logging still forces PAGE_SIZE
  - falls back to PAGE_SIZE whenever contiguity/alignment cannot be
    proven

=== Testing ===

Verified on QEMU (rv64, h=true, sstc=true) with a custom kernel module
(pfnmap-huge-test.ko) that installs a PMD leaf in the host page table
for a VM_PFNMAP VMA, simulating a VFIO BAR with a 2 MB host mapping.

Tracepoint kvm_mmu_map confirms all three scenarios:
  - anonymous memory:      size=4KB    pfnmap=0  (control group)
  - /dev/mem (4KB host):   size=4KB    pfnmap=1  (safe fallback works)
  - PMD leaf module:       size=2048KB pfnmap=1  (block mapping works!)

I welcome feedback on:
  - Whether the host-page-table-walk approach is preferred over the
    arm64 vm_pgoff approach
  - Whether PUD (1 GB) block support should be added now or deferred
  - Whether the tracepoint should be kept or removed before non-RFC
    submission

Bingyu.Xian (1):
  KVM: riscv: Allow safe G-stage PMD block mappings for VM_PFNMAP

 arch/riscv/kvm/mmu.c   | 45 ++++++++++++++++++++++++++++++++++++------
 arch/riscv/kvm/trace.h | 29 +++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 6 deletions(-)

--
2.54.0

