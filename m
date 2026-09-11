Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21219356744
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 04:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789102150; cv=none; b=Ez0CJ8q/LH6zPWES1oJXYCtFPzhQY5aqhuR9zPa/66oZDIHgjUpjQTVaEdDFcUkU8q2Kw47JNrTiDpOrZ5gPglAt0qr1LFObQ3R9aMHNLqjIDPOqn76VEq3YgOqj96rqKB1U/wWXqzjbMHJTyttTtD78AjDkCz9m3b5Kr/Tab9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789102150; c=relaxed/simple;
	bh=sP/zm+viOpOqrBPed60qECqw/COkU+NGYRtxu1lz3dQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YZrb66k6DkiUKHMEiCjIukVM2Rm0qzVHTeY4Sg1ZlIiVrP25GXjUWqsq1DyGQoAxpM3ckLqgY6Uyh2pcK2itDmrS0d2qIGGXFTVvWZW5VO2m9KIOrQXEe9gGgEgX/n2/05c+alDd+g9r9r4br5EpOdZZxNicKaIeuChWj6R4tPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhkAkem0; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhkAkem0"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so383486a12.0
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 21:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789102148; x=1789706948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1rljTI1Abbl24POJ+IsSXHYVg7wGa229jkDx+f0b6sA=;
        b=PhkAkem0Q8N6k5XSk60PlXEMkUIyQB2w08rYre9JHMDfvkS0wGpZsdbft5MA9qlNOm
         PjQJVzDYYa2eY0XkkARW0CZ4vjjvMEVHA4LV9G56djiTZH8fx/5f1A+w3w/kAQUdXDZu
         3+XbIuugQjybN3oF9mO2K6QHtbaInWWZD3lL2NBgX4B9xI6ZvQZxqViGyedwmtc2zKC6
         qDWrIsyyBNXh+X/xxb5RHEBfvCZuxaY9cckdxPsAhzVY+iNSeBxN7j/9gLzjlYtGREVe
         yjY07kJuv5JrVaLDIf7a0t/DVVSeRSBoi4oXs3gVckKh0Au/2TzGPNcTq9HtFbX9W2Z4
         XueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789102148; x=1789706948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1rljTI1Abbl24POJ+IsSXHYVg7wGa229jkDx+f0b6sA=;
        b=LVsXM8v4Pxx2sy1lHqlZjdyUicnFn6EC9QrrPzKD56howF0m6nB85kBXPAud9r934E
         A3+UdeDH2Nm3AeITg+J/FYhXOTBRPJrBu7CkpJSg7Yly+W1RknUZYWBVrF3E7EJlJFfx
         KsB4M6qjzSJfVUARtTK0vCjnES1loKaY3eTzyR3OHrztcKT3X0jwht1oSB+4NbRPNKk0
         TlMicXXxJxw+Z6ooIodgeGrAdA6G/yF9CWzF6HvbZOXbZVmnAsVQya4+3l3XJ5xVJx9x
         bEUrjCdvJ62cjsX0Tbcfl9zTH/O2J4qoHoNpSMaWknf5eqBgdJXnIY1TgK7jMx6FoQ20
         JS5g==
X-Gm-Message-State: AFuF++mK2mGsbpPggo5miuNV8a2ckYnUuVCVznOrKRPIqKGx9kbupQD0
	kt2vDExG5XnZTDrYX6nN1/kyuMUHIJ5FmAfiQCp2B+y+b8zaywRsAbA1e4c53ZvB
X-Gm-Gg: AYBFou2c5iNDC0r8UJEjxjdVg7IhxQL7tV4UB0Raai6Ib2WawGC1bdUnPB3tT1WqDb1
	TOK92Afk5j52R/NDqscOseZZP5DvtQ8Z484AAir0/kukPNOHmQYoW1mIEID73WDHAM9nEODMaLJ
	BNrzIBo/jIn5484auL2ckLx2tx6HQAk14dHLOWevKQ54XB9j8R9xPrfpi55YEo3xwCSWVqIwie3
	xVQLgDlTmDY8U5aQu1VM/MCeuy9vYlJXOG2jwfqfHaaZxda5MAkKupNj9B/X9xdaILVwTZRWwfK
	lNWLbw4iROIEr+JGGI/XANVso1fgQRqnSjKI0SWjdn51B4Ghm9Ae2iYc6lP9URlVKXCK+1CenWd
	+mnThbZ9y2mw7IMGdC+j+iD6JoRS3k8dwCLta/9BsDnz4jmR+fO8Mgxw8yLYy6DDSna3pPxKI20
	CYh88fnb/fEKjO1jERyeGjuF06WsE/q2clIr4NA8T7+CLri9aI6u5bp4dfsIfasdFCn9rEmC5AL
	S6zrgRVQsBjKBoJqugUztXeH27xGWok3jjinfzzSS43I+6r1LFfQuehxjh8Xw==
X-Received: by 2002:a05:6a20:9f92:b0:3d3:af44:ee12 with SMTP id adf61e73a8af0-3daed51e280mr4405652637.27.1789102148350;
        Thu, 10 Sep 2026 21:49:08 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f1e434sm2883077eec.22.2026.09.10.21.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:49:07 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 0/3] KVM: selftests: add powerpc support
Date: Fri, 11 Sep 2026 10:18:51 +0530
Message-Id: <cover.1789097569.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PATCH v3 -> PATCH v4:
==================
- Rebased on top of Sean's new page allocator patch series v2 [1]
  This allowed to drop and patch-2 since it will now come from Sean's
  v2.
- Addressed review comments from Sean - squashed patches 6-10 in patch-1 of
  this.
- Dropped patch-5 to print vcpu_id when KVM_CREATE_VCPU ioctl fails.
- Added additional patch-3 to this series to allow dirty_log_test to run on all
  big-endian machines.

[1]: https://lore.kernel.org/kvm/20260902164123.2546762-1-seanjc@google.com/
[v3]: https://lore.kernel.org/linuxppc-dev/2d2c46be7f051c7f1c645afaec67f57067d37a81.1781093720.git.ritesh.list@gmail.com/

Testing updates:
================
I have done some fair amount of testing of the selftests both on real HW and
using various combinations on qemu (powernv+LE (default), pseries+cap-nested-hv,
pseries+cap-nested-papr, powernv+BE). There were few powerpc kvm kernel fixes
which were identified as part of this work. I will send those patches separately
as those anyway needs to go in separately.

<pasted snippet of cover letter from previous versions>
=======================================================

Hi All,

This series primarly adds KVM selftests support for powerpc (64-bit, BookS,
radix MMU).

This patch series is originally Nick's work. I have mainly only rebased it on
the latest upstream tree. Since the rebase required few changes to all the four
patches (Patch 1-4), I have dropped the earlier Acked-by from Michael Ellerman.

Since the last series was posted three years ago [1], I am resetting the version
to RFC. This rebase was done as part of a larger effort to improve the selftests
infrastructure for Linux on PowerPC tree. Thanks to Harsh and Maddy for their
help on this.

Nicholas Piggin (1):
  KVM: PPC: selftests: add support for powerpc

Ritesh Harjani (IBM) (2):
  KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
  KVM: selftests: Use LE bitops for dirty bitmaps on all big-endian
    hosts

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/kvm/Makefile          |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |  10 +
 tools/testing/selftests/kvm/dirty_log_test.c  |  12 +-
 .../testing/selftests/kvm/include/kvm_util.h  |   9 +
 .../selftests/kvm/include/powerpc/hcall.h     |  17 +
 .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
 .../selftests/kvm/include/powerpc/processor.h |  39 ++
 .../selftests/kvm/include/powerpc/ucall.h     |  21 +
 .../selftests/kvm/kvm_create_max_vcpus.c      |   8 +-
 tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 512 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
 17 files changed, 862 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ucall.h
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c

--
2.39.5

