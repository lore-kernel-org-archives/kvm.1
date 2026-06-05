Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A5F3B27E2
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679334; cv=none; b=iCemCbUmn/xfsIIrecxT2qRxAiKPFaZwmBDUUjdxp9cchOFCWCOQL1V26un2ZLz6U/xcXuGVafYW5QypcdNdQR6H6ob7B9PHsWJzFaoy4FORbPDVVGJrh+ruzujNwAi6TcJs7YDazYBokvOVlNw8O1qgGYPrX1oAtOCvYsAqiAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679334; c=relaxed/simple;
	bh=MJDgvJp16ybis1BedlFJ9kRuID0T9ivXvbrgXgO2p6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FpaPLQnX/sPLZSsB5dZOozU8mWfkFU6LDClb0ip/WoUEtAoc1ex+UcO32junw/XIFh7ZbIeua97OA6iCsC6ga8udTVNzGno3kswTny0/ebNmDu8jtGSN3vOwlbX9TYtTaxPuvpyus1FprbcETZ1hRO8jUO1ikSbZpAxr/Lc0n5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4lpGY6N; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4lpGY6N"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-becd1c46294so217763566b.2
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 10:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780679331; x=1781284131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wBqu7gqATn/ePsgOW55ydXsXkiRj2gt82F6mXc6KPbw=;
        b=d4lpGY6NJ1CVMPdRmLM+AlwoR/qDGBwtYP5YCONG78BZXj41q7C8rHwzww4SFw6k4Q
         75LmSrkRxv7yAEv8fYEhUYciv0k9yhxeL0uKOvGCBcX5x+7WmNgHiTFBwYv8uKyV63Nw
         oGVuiJyNzGLFgs7oicRi2m462/rNoAFj6AmbU9MKL36d8apbvLyVxV5ggQ3/qAYTNSft
         cm5iDCjIk/JrpJPId4Ay5k27k4M/OKwL83qdCiTvAIuOZxkI5SRfFd0v08M+B50wZaEQ
         Po5gU5aAsugfVKwpw64eLgUC+s+SkqTLz+jkM/g50um/oYzWUXlpSS6NezlK5M+9WUvt
         3tYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679331; x=1781284131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBqu7gqATn/ePsgOW55ydXsXkiRj2gt82F6mXc6KPbw=;
        b=ruRJzQk2o4gVSDIZ7IAx7utSZFE/A68i3dM1xUDhmzQqO3CH+fWYpF/sXQb6CMfwpQ
         q2ES86FsaG2oZmcBk0rxDs86lMDIBXb7FhJbtXih+2sLEBsPquwA34rTeuVLXdy5KuGN
         qBDv7FS3lOApf+hNDCHnQEhjIHeZaTP883T5tR/sjYjtAVuVspU0KNCEUa1sh3rw06Sh
         U2IEQwIQO1ja8fCPidNXJ4t5Kv2JKu6OC0IslgXmPVBiYT9aW90xwDUK3X3632UF2OgN
         BaS2tcrpYcul0BdIcxAPVka5PEXzNJhGPXCMKg6VBZB3/zVQCTCNxvCrcE/GaCg5c2/d
         5K4w==
X-Forwarded-Encrypted: i=1; AFNElJ9KlsDmRMnQM8jLpNfEcoAV3qn8Vd/CCIG4JA5hN2jq1F6RCOpIVskUq1zpzakRmZO+e14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLCP4rlXjULSF54bJJ4HgcKG4mEw/HCGXXdJ90RyaqPnyv8n53
	3hS074L3ogIT1fZ2Au7dTHpksMKFzbpAysVZtdjoHub/YROmfGTE3PNr4DnJJHTDn9T+zoq2oXE
	xVY+4fs/5PbjE5wfMuw==
X-Received: from edpu11.prod.google.com ([2002:a50:eacb:0:b0:686:db44:c93])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3e20:b0:bd9:2b46:99b0 with SMTP id a640c23a62f3a-bf37330647dmr249281566b.49.1780679330530;
 Fri, 05 Jun 2026 10:08:50 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:08:33 +0000
In-Reply-To: <cover.1780676742.git.tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <f9430aa65709131d89d9d6be8b6e8aff4185bd63.1780676742.git.tarunsahu@google.com>
Subject: [RFC PATCH v2 08/10] docs: add documentation for guest_memfd
 preservation via LUO
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	Tarun Sahu <tarunsahu@google.com>, fvdl@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, 
	aneesh.kumar@kernel.org, skhawaja@google.com, vipinsh@google.com, 
	ackerleytng@google.com, Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, 
	dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com
Cc: linux-kselftest@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Add the documentation under the "Preserving file descriptors" section
of LUO's documentation.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 Documentation/core-api/liveupdate.rst |   1 +
 Documentation/liveupdate/vmm.rst      | 103 ++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 3 files changed, 105 insertions(+)
 create mode 100644 Documentation/liveupdate/vmm.rst

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 5a292d0f3706..bac58a363151 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -34,6 +34,7 @@ The following types of file descriptors can be preserved
    :maxdepth: 1
 
    ../mm/memfd_preservation
+   ../liveupdate/vmm
 
 Public API
 ==========
diff --git a/Documentation/liveupdate/vmm.rst b/Documentation/liveupdate/vmm.rst
new file mode 100644
index 000000000000..0cd487a0e1a6
--- /dev/null
+++ b/Documentation/liveupdate/vmm.rst
@@ -0,0 +1,103 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=============================
+VM & Guest_Memfd Preservation
+=============================
+
+.. kernel-doc:: virt/kvm/kvm_luo.c
+   :doc: KVM VM Preservation via LUO
+
+.. kernel-doc:: virt/kvm/guest_memfd_luo.c
+   :doc: Guest_Memfd Preservation via LUO
+
+VMM Instructions
+================
+
+This section describes the requirements, scope, conditions, and
+ordering constraints that a Virtual Machine Monitor (VMM) must adhere
+to for successful preservation and retrieval of guest_memfd files
+across a Live Update Orchestrator (LUO) sequence.
+
+Scope and Limitations
+---------------------
+
+At this stage, the scope of guest_memfd preservation is restricted to:
+
+1. **Fully Shared guest_memfd**:
+   This time only fully shared guest_memfd supported. Any system that
+   supports coco vm (which uses private guest_memfd), will not support
+   the preservation.
+
+2. **Standard Page Size**:
+   Only guest_memfd backed by standard page size (``PAGE_SIZE``,
+   order-0) pages is supported. Large/huge page backing (e.g.,
+   hugetlb guest_memfd) is not supported.
+
+Any Virtual Machine (VM) whose memory is fully backed by such
+guest_memfd files can be preserved across live update.
+
+VMM Actions and Conditions during Live Update
+---------------------------------------------
+
+During the live update sequence, the kernel introduces a *freezing*
+phase for the guest_memfd inode. Freezing prevents any modifications to
+the guest_memfd page cache. Specifically, once a guest_memfd mapping is
+frozen:
+
+- Any subsequent ``fallocate`` calls on the guest_memfd file descriptor
+  will fail and return ``-EPERM``.
+- Any new page faults (guest-side or host-userspace-side) that require
+  folio allocation will fail and return ``-EPERM``.
+
+To prevent vCPUs or VMM helper threads from failing due to these
+``-EPERM`` errors, the VMM must implement one of the following
+strategies:
+
+1. **Pause the VM (Recommended)**:
+   The VMM should pause/suspend all vCPUs before invoking the
+   preservation or freezing of the VM and guest_memfd files. This
+   ensures no new page faults or memory accesses can occur while the
+   guest_memfd is frozen.
+
+2. **Handle Fault Failures**:
+   If the VM is not paused, the VMM must be prepared to handle VM
+   exits or user page fault errors resulting from the ``-EPERM``
+   failures. The VMM must take appropriate action, such as
+   immediately pausing the VM, or aborting the live update sequence
+   (by tearing down or unpreserving the live update session).
+
+Preservation and Retrieval Ordering
+-----------------------------------
+
+Preservation Order
+~~~~~~~~~~~~~~~~~~
+
+There is no strict ordering requirement for initiating the
+preservation of the KVM VM file and the guest_memfd files; they are
+preserved independently. If kexec is triggered with guest_memfd
+preservation without preserving the vm file, kexec will fail.
+
+Retrieval Order
+~~~~~~~~~~~~~~~
+
+Similarly, there is no strict ordering required for retrieving the VM
+and guest_memfd files. Any file can be retrieved at any order.
+
+If guest_memfd file is retrieved and VM file is not retrieved, and
+luo_finish is called, then vm_file will be lost and guest_memfd file
+will be hanging around.
+
+VM & Guest_Memfd Preservation ABI
+=================================
+
+.. kernel-doc:: include/linux/kho/abi/kvm.h
+   :doc: DOC: guest_memfd Live Update ABI
+
+.. kernel-doc:: include/linux/kho/abi/kvm.h
+   :internal:
+
+See Also
+========
+
+- :doc:`/core-api/liveupdate`
+- :doc:`/userspace-api/liveupdate`
diff --git a/MAINTAINERS b/MAINTAINERS
index 16cba790a84d..ca459d032712 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14418,6 +14418,7 @@ L:	kexec@lists.infradead.org
 L:	kvm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	Documentation/liveupdate/vmm.rst
 F:	virt/kvm/guest_memfd_luo.c
 F:	virt/kvm/kvm_luo.c
 
-- 
2.54.0.1032.g2f8565e1d1-goog

