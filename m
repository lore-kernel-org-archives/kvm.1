Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E5837703B
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701048; cv=none; b=qU+xA5+37Jx9X2gkaluceMXc1IuGUlce7vkbEXHXrbQSthMDDbt6Dyu6WMWeef+dK0D43i6hiwmqASgHhFxH3z/E0FUOS6e03EUpeUeugTwqBxWgikYJXSV3hu77EpvRvZtDp81ibnRH5mIrVfa7Z9o+c1cpHdnXj+Jpfldw394=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701048; c=relaxed/simple;
	bh=T02mPnop+VlOHthIvn/hMI0Uo2ghqBUATVUzggRzrNo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V31/v6V1T9N1d7fAsmHDVdL1XI9qWWmchWzZNwrK4LUe/AhiCU0W9NGQ+ZvjuEYSx0pNCO8HkAcxltR83HdcwQ5Tt4mcMitm3PEloDqU9G3fXSK9b8/y1cDdVL2wQTZqTFx9TS19QdKYRwK4U8Hqw+vOSTqvmJR0ut4tg9ZJ3Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G0m3l7hg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0m3l7hg"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a106b687cso1894650b3a.1
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 15:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773701046; x=1774305846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A6pTrTiGUfN/I2rSuI/vU8zcoVY/NvupDuQnP/ABsAw=;
        b=G0m3l7hgZ5ZHWSGuPomxr+6HBmybPUb+dHMSZ3KhqQfxjE8OcOL4r3E0W54wHFe4v8
         J2zrHZqiEXIUVwil43Io2V+CMQeDjdVmv6J3IkUQxJCennzUassPuQzI1jzVKVOwTOH3
         QzIBEPHew8GveESfwpulCX30+vQkuLxdsgajme12q7YOkCk0dZNtTw07tHs+mqJxPY7M
         jCUh3XjBtXStd4iFY7J3SPXlw9IsELKc7oYcpeUa6f95wo18VfPDLpZ6XFpECY+cMVco
         CaO80bUQFTLa+XKiUCxheuJTwNL+3gAYdDTdnUz+sVWoIWvsBq2Q3kYmoCgrt7qG8dfk
         dQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773701046; x=1774305846;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6pTrTiGUfN/I2rSuI/vU8zcoVY/NvupDuQnP/ABsAw=;
        b=VZVVAHrfo412UTkqIM0otYhUlRPNjAt/yJY24lyCvdAsZlAY2spuLUoZ5+NLjU16dS
         nnnP13NJpdf7g6vEm8mOcG6fixBRkKDlWTreUMh7JOuU+VZEsPJ9m6MRV/0IYijNchWO
         N9aVsRrXAX4CCC8YB/I3fXAjCx5Gln7mRHqf3/W+2iHuflct6MDyGSUjelrTuuc+VhNC
         s25RYdJQB+KONiGceMf8k2CnA/gXyrIFRnY+OfD+ftzZBIrWP69lmGvtOyFDLT2kfjVJ
         AXodyAOLMX+Jc8Kwm5+L3neRDgvKs2ObnHnpjl75Z2MEhRvVGI+jZA8DprcUjje+auPR
         KcBQ==
X-Gm-Message-State: AOJu0Yw43WFhPJnlrBk8ZHimR2mr9ROPNIoXXR7FTZphTNguCZPv/c0P
	9P1J1o9AMsezP7aJCFpksBEp4yvJd9gFfJtQgr55zILvbKx/WSq3qZtsyl6qPuFwRRc5bnl2gpq
	sttnK5ir5gK/HRFhpUCmIFd5DZlsrg2UyCsW4n067Rx2vbAFSZ7wUG7IYUWs7BnCMTC5l3QuS8+
	podmHNyON9I8lZnzagWCbd4cyFh7jPpK48qECRfc6rXga/6oKlisJhf8JpETk=
X-Received: from pfbgc11.prod.google.com ([2002:a05:6a00:62cb:b0:82a:128b:1da0])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1143:b0:829:809e:8978 with SMTP id d2e1a72fcca58-82a198ac2eamr13166611b3a.31.1773701045869;
 Mon, 16 Mar 2026 15:44:05 -0700 (PDT)
Date: Mon, 16 Mar 2026 15:43:46 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260316224349.2360482-1-jingzhangos@google.com>
Subject: [kvm-unit-tests PATCH v1 0/3] arm64: Add Stage-2 MMU and Nested Guest Framework
From: Jing Zhang <jingzhangos@google.com>
To: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Andrew Jones <andrew.jones@linux.dev>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series introduces a lightweight infrastructure for managing ARM64
Stage-2 translation tables and executing nested guests. These components are
essential for testing advanced virtualization features such as nested
virtualization (NV) and GICv4 direct interrupt injection.

The series provides a generic Stage-2 MMU library supporting multiple
translation granules (4K, 16K, 64K) and dynamic page table management.
Building on this, it adds a guest execution framework that handles guest
lifecycle management, context switching and guest exit routing. A new test
case for Stage-2 MMU demand paging to verify fault handling.

Please note that this is a very preliminary implementation intended as a
startup baseline for future work in virtualization testing. Users should be
aware that because this is an early-stage baseline, some portions of the code
may just happen to work in its current state. There might be critical
architectural elements or edge-case handling missing that will need to be
addressed as the framework matures.

---

Jing Zhang (3):
  lib: arm64: Add stage2 page table management library
  lib: arm64: Add bare-metal guest execution framework
  arm64: Add Stage-2 MMU demand paging test

 arm/Makefile.arm64         |   4 +
 arm/stage2-mmu-test.c      | 100 +++++++++
 lib/arm64/asm/guest.h      | 156 ++++++++++++++
 lib/arm64/asm/stage2_mmu.h |  74 +++++++
 lib/arm64/guest.c          | 197 ++++++++++++++++++
 lib/arm64/guest_arch.S     | 263 ++++++++++++++++++++++++
 lib/arm64/stage2_mmu.c     | 402 +++++++++++++++++++++++++++++++++++++
 7 files changed, 1196 insertions(+)
 create mode 100644 arm/stage2-mmu-test.c
 create mode 100644 lib/arm64/asm/guest.h
 create mode 100644 lib/arm64/asm/stage2_mmu.h
 create mode 100644 lib/arm64/guest.c
 create mode 100644 lib/arm64/guest_arch.S
 create mode 100644 lib/arm64/stage2_mmu.c


base-commit: 86e53277ac80dabb04f4fa5fa6a6cc7649392bdc
-- 
2.53.0.851.ga537e3e6e9-goog

