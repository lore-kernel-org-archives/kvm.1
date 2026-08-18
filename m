Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0337A85A
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085884; cv=none; b=ofGnCuTHbAphB/XZcWz81RNKlO41bkz/+3nDwpMhpM6FQNZX2VFmrJkn4gzJdc1CAxB9cX+eBDfsEFPz7ctrZKMXmghcYdqoZ1yyb8UsalHXC+7kD+9ewVJMcbtngDjuSX4oQ0h5GTk1Q0p5zQ482HLaLG3QRaP5jiRT5mWWdhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085884; c=relaxed/simple;
	bh=EWSo94o+NC9AsqgKot1Osv3Re8bXshk6/su2AINZpnw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rxdtsx/WZh0l/jGHzjeMiLBRknSGGez8Jmx5v6vZDqY/zmf9XcjUe/zFehgve0uZV+4PFAUycRC6hOqJXnUuXxZKaCfTGIBCSzlYwhRRgbmap5rq6pPPVV1W6sDZS09vk1+rgBo7MzDLPV/hUEdatMwO/Jt3oUIho0jz+5GfWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jgmqMgGC; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jgmqMgGC"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb835525b10so227606a12.2
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 13:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787085882; x=1787690682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zgsgqcz30KQGgMzP9vxq2oYMMooKqJ9S2gmDtPTjvA8=;
        b=jgmqMgGC6GT5OOxF2KzS71muPUlBj1fyhwxW4BgD0BvjG+C1BPqo5RpfVM8H2qKWND
         O82XzMydcowD+xYb4NmnlyMqnJlPPZsyrNcCefDpClFGLsXgec/K3KIJr5t+64gO39Nm
         lwWPwEwD5FMnDVhL2dn0VN9wZjRmVUa8H8LuKOOa7U8hNG7Ua0pOXZKB/FJQcRqfvz7g
         I+25OK96BYJXSWNeJzDcBalrstJG0GiRF1IZZgL9D+sNO4ByAnGCb7vVE2k7nrj31Llu
         HEcMqFMIbQNteDGUG95bu4+IISWU9H5afoJBWbGIalpbqBIaMELiw05fF7hQFUc66ppO
         LBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787085882; x=1787690682;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zgsgqcz30KQGgMzP9vxq2oYMMooKqJ9S2gmDtPTjvA8=;
        b=CRFbZJIQ/Irkiv+Vq1KMLgCOJmSHcqwlwK2RMol6oH/M1UXDiBYg87+HUCwrlYU854
         qNc0oJ2LJtzEp/KmQedW/44lviHucgVfYNfLqwogdn/m3jo5fq2+DBzk7eUn0ju/7pmd
         pGJHbJ8lEZobD9bNspZ16Wr+Hex7krOR4/OE1AOMHzR2MHOWO4OTZsfuR//4wxJCPy7p
         XuEnwoF2vhjrAQOFY5kHJ7cTAnzHWuGzC8sHKYyxSjYAp8zixC8degxy9G76XkYljrA5
         rMj0gqrcuuKzQ598d4TaAORpeTu/4+/OB4I2UKOEfPUA41/07x1/ZJ3h8PAVIX1smuqY
         ApEg==
X-Forwarded-Encrypted: i=1; AHgh+Rq3d4dMnFaqMn+bxU7RjMjMidgvl5fvZRPrPfQrpohdQKPt831R+Fg5Eva3ecYgor9NMJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF/ZBGldotKU+CyCQcUM8yg80D+myxpeAMbnjoz+Ac1ibWJ5fH
	tDXYotF/YIyT//ZgLNGgDzV6JgtfeSeNoIKcpJsXuoZvdU98sr3m33/SfgmZFE55h0ZVeTXfIYD
	niiyQVbTo
X-Received: from pgbg13.prod.google.com ([2002:a63:520d:0:b0:cbe:9dc7:9efa])
 (user=jackyli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:94c8:b0:3c4:1c9f:d81
 with SMTP id adf61e73a8af0-3ccff3c3fd3mr751374637.7.1787085882100; Tue, 18
 Aug 2026 13:44:42 -0700 (PDT)
Date: Tue, 18 Aug 2026 20:44:14 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAB7EhGoC/32Nyw6CMBBFf4V07Zg+eBRX/odhUdoBGpWSFhsJ4
 d8trNzo8tzJObOSgN5iIJdsJR6jDdaNCdgpI3pQY49gTWLCKS9pxWvoUM0vjzDdcQGDEbRU6WZ
 aWbQ5SdrksbPvI3lrEg82zM4vx4fI9vVPLDKgoIURvFBtVdd47Z3rH3jW7rnHD1My9sOUpkKZF yXjVHybzbZtHzLFcVnrAAAA
X-Change-Id: 20260729-feature-pkey-dev-c8a026db85b4
X-Mailer: b4 0.14.3
Message-ID: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
Subject: [RFC PATCH 0/6] Protect VMM from speculative attacks using x86 PKRU
From: Jacky Li <jackyli@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
	Richard Henderson <richard.henderson@linaro.org>, 
	"=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@mailo.com>, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Reiji Watanabe <reijiw@google.com>, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This RFC patch series introduces a hardware-assisted memory protection
mechanism in QEMU using x86 Protection Keys for Userspace (PKRU / MPK)
to complete the Address Space Isolation ecosystem by protecting the VMM
from guest-to-host speculative execution attacks.

In a guest-to-host speculative side-channel attack against QEMU, a
malicious guest mistrains the VMM branch predictor to execute a
speculative gadget in host mode. This gadget speculatively reads a
host secret and uses that secret as an index to touch guest RAMBlocks,
leaving an observable microarchitectural footprint in the CPU cache.
Existing mitigations like issuing IBPB on every VM-exit incur high
overhead, while guest_memfd cannot protect memory that must stay mapped.

To break this covert channel, we protect guest RAMBlocks using a
dedicated pkey (pkey_mprotect).

- During normal QEMU host userspace execution (I/O handling, timers,
  event loops), we lock this pkey by setting PKEY_DISABLE_ACCESS in
  the PKRU register via WRPKRU. Because CPU pipelines natively enforce
  PKRU restrictions during out-of-order execution, any speculative
  gadget in host mode attempting to touch guest RAMBlocks is blocked by
  the MMU at the hardware level, leaving zero footprint in the cache.

- Before entering KVM (KVM_RUN), we temporarily unlock the pkey, and
  immediately re-lock it upon returning to QEMU userspace.

- To gracefully handle legitimate host accesses to guest RAMBlocks
  when locked, a SEGV_PKUERR signal handler unlocks the pkey in the
  interrupted thread's xstate and issues an IBPB (PR_SPEC_INDIRECT_BRANCH)
  to prevent speculative leakage before resuming execution.

Comments and feedback on this approach are very welcome!

To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: kvm@vger.kernel.org
Cc: James Houghton <jthoughton@google.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Reiji Watanabe <reijiw@google.com>
Cc: Jacky Li <jackyli@google.com>

Signed-off-by: Jacky Li <jackyli@google.com>
---
Jacky Li (6):
      [RFC PATCH 1/6] x86: Introduce basic PKRU hardware wrappers
      [RFC PATCH 2/6] kvm: Add guest memory Pkey initialization
      [RFC PATCH 3/6] physmem: Tag guest RAMBlocks with Protection Key
      [RFC PATCH 4/6] kvm: Lock guest RAMBlocks via PKRU during host usersp=
ace execution
      [RFC PATCH 5/6] x86: Add xstate parsing and PKRU offset detection
      [RFC PATCH 6/6] kvm: Implement SIGSEGV sentinel for Pkey recovery

 MAINTAINERS               |   1 +
 accel/kvm/kvm-all.c       |   7 +-
 include/exec/cpu-common.h |   4 +
 include/qemu/mmap-alloc.h |   5 +
 system/physmem.c          |  22 ++-
 system/vl.c               |   1 +
 util/meson.build          |   2 +-
 util/mmap-alloc.c         |   3 +-
 util/pkey.c               | 386 ++++++++++++++++++++++++++++++++++++++++++=
++++
 9 files changed, 424 insertions(+), 7 deletions(-)
---
base-commit: fa19879df1658f96ac07365fca8835b7decd6995
change-id: 20260729-feature-pkey-dev-c8a026db85b4

Best regards,
--=20
Jacky Li <jackyli@google.com>

