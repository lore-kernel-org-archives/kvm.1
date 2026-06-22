Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320B634B19F
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154157; cv=none; b=YCkAPaCJUepzuaCpplKz9eETHLn1gq0h66jA28HOiMphhYZaH+bO7QuWimh8ovMCuMSXIn5524haLavTDKKDwRrMpJRPHt9X1r+lIeNyTSugaQIGe3Y4uaQ2yZ/G+6Zi0NktzkOnM51ddL9yCuW+rm3qMEcgI2QIkxDYzznuIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154157; c=relaxed/simple;
	bh=x7jVI3FtO5re8r4YJbzK9bNdYBRCZVzsKzUMYHVMzt8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KB9kmMDqX+rAfWI+r1Yvcr19bSi8aMcx8BLUQhyPnzuU6pQ6GZLGBXYfRbGFTI8JCBH5WRgVc7EenVa3fda4mziTLEpnvtObnMJvVHHo/iI+qbMVkBO/NsrHEEHTtwnB5/rcAytionK8MuOn42+bi6M7j0uJ9jW0mJ0PV8n2x7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qylqft5q; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qylqft5q"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-695bbac451bso5137411a12.1
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154149; x=1782758949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ofu2helHDgwWpEtyPAHO+f27C99XXYOA9FQdc6q7UQo=;
        b=Qylqft5qKa+RWL5EsVgzgSRvyMPH60TfO2xhns3K0KFIlAqfDdi5i0anvKIeBNq3B7
         ZGUsto8cfcXMHlEw2fVKOdL+0yLAxYeK56QQ4Fxva4LlI1uPLJ+yWz1VX/BbgBZrVhxz
         LzD9Ajv0u9D4yhnHQrJzt6l7JP36GQtSmQJqOtB+fylXSNzvoZC8iMQx3TSwOKihEGtU
         TPSkr/sux75MZrP5Qsp+6tuejxjyOk3MCwKDOZF3P/ptm3VlaXm7FEns50gq1/KdHhpN
         DMOewigUaoJnRgl/zOMVJW+bPMJT845Pr41OWWVhCqPrRu2jvALbbVooyCPyV7JKogbU
         vpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154149; x=1782758949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ofu2helHDgwWpEtyPAHO+f27C99XXYOA9FQdc6q7UQo=;
        b=nTL4X/UWAUHafkLZM2I/qyYla7JuWSReOH6k6ImiHiEcm78Z6qmJaxN7kaf8jUbtfe
         OsPn6vK2qk2EDz3vXHEYiePLLPn/aFyHWAJZZJJDMHIPgM8yOIDPqdJ8aD4zmz6w1B6H
         T5+5wZh0TxLIzWnOjymA5P8w1SIGVQVAzAeaK9S5HrYwNYUez1nUvjkDy4WTMAh5ADLv
         gw0Gpa39uiYY1ncUTiJfqeCf7dSqXDHqxnyksSJSS8fFbK/1xlzUJ9Ynoi+m+ovv9nfj
         0OUekTd3LoQvFDxCYJeUEeqAN9xduu25T1YDedFzja/SrfYtsCPu/wV4vwclSv8yoySW
         vB7A==
X-Gm-Message-State: AOJu0Yw014bgUSOYaj8UKBaw3CVjxpIhd0RWrBSU4TYmKQfUaC82U2fl
	b8TJDhS9n1E+6BqSCQjGJxvBzZpXyuFQxqi4QOFgwm4Kxyxn0kiBNnNzg3T2ShLgelDjuqD0keg
	INd7n4Z7sl9C0lpRtgA==
X-Received: from edaa20.prod.google.com ([2002:a05:6402:24d4:b0:697:c28b:9d89])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:358e:b0:697:ad7f:58dc with SMTP id 4fb4d7f45d1cf-697ad7f5a8cmr2848079a12.17.1782154148645;
 Mon, 22 Jun 2026 11:49:08 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:48:49 +0000
In-Reply-To: <20260622184851.2309827-1-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622184851.2309827-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622184851.2309827-8-tarunsahu@google.com>
Subject: [PATCH v3 7/9] docs: add documentation for guest_memfd preservation
 via LUO
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add the documentation under the "Preserving file descriptors" section
of LUO's documentation.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 Documentation/core-api/liveupdate.rst |   1 +
 Documentation/liveupdate/vmm.rst      | 107 ++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 virt/kvm/guest_memfd_luo.c            |   4 +-
 4 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/liveupdate/vmm.rst

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 5a292d0..bac58a3 100644
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
index 0000000..8353e23
--- /dev/null
+++ b/Documentation/liveupdate/vmm.rst
@@ -0,0 +1,107 @@
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
+NOTE: Before Initiating the preservation/retirval, it is necessary to make
+sure that the kvm module is loaded (/dev/kvm must be available).
+
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
index d1d699ce..e27b677 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14420,6 +14420,7 @@ L:	kexec@lists.infradead.org
 L:	kvm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	Documentation/liveupdate/vmm.rst
 F:	virt/kvm/guest_memfd_luo.c
 F:	virt/kvm/kvm_luo.c
 
diff --git a/virt/kvm/guest_memfd_luo.c b/virt/kvm/guest_memfd_luo.c
index c242b1d..8411fe8 100644
--- a/virt/kvm/guest_memfd_luo.c
+++ b/virt/kvm/guest_memfd_luo.c
@@ -119,11 +119,11 @@ static bool kvm_gmem_luo_can_preserve(struct liveupdate_file_handler *handler, s
 	/*
 	 * Only Fully-shared guest_memfd preservation is supported
 	 */
-	if (GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
+	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
 		return 0;
 
 	/*
-	 * It makes sure that no memory can converted to private
+	 * It makes sure that no memory can be converted to private
 	 * even if it was initially fully shared (in-place conversions are
 	 * prevented).
 	 */
-- 
2.55.0.rc0.786.g65d90a0328-goog

