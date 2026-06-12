Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772753D301B
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292575; cv=none; b=M3HC9cXitqTQnzANqF+q9CZzhXnzo/fQJbe8mrG+U4xA39KrbYsI94HDy7v9um3fECGkpwX8ywqOx7LkDdeBAvJuSWgwRf3kmmNlp6tyZUl51qaGyM3JajwYBr0QN8eprUf2hfQoIGSyKvl9Z4tyP0wbFIMtCNNPY7NXax3LtlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292575; c=relaxed/simple;
	bh=HBuFwboneQNMp7qglhgXk7alnCfDwtLSxYiguum4PxI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fu5ETx3Hj5oMlamWbdD6mkNotV0CwNQpuSZDG2BIUPOAxhQSSaH54Z3OYxBD0kG12OHnBwivaJz4Nhly5wqA/MbgMrg0A8Vy3Id+/hKFVWT/kGhdA1P7X0bFaFEUHbC3GDGw6D9WoPTWPP94JgnECDiJrUkFq8BsMUw5Jh6+hNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pr/aGln3; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pr/aGln3"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-48576b309c7so1808890b6e.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781292568; x=1781897368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lI2FhZeVSW/rDbtlOOBPVMTchx/8Z69t0suel1yDoGI=;
        b=pr/aGln3J9K7mB7pFQ7vKNt9N+5/LTescX762MEq40KZ1XOAC30WqI5a0vJXHE+DfU
         xdB68KTUPAAMR7uVW+JgMPpz4ZP0yWKhC16N/HYehe20mq+vfcZTRjBsF+KTONi4LKZZ
         B8vcrXsCdI8im2fICAcFWli0usmHnyg8/ELYuxJnfo8pzpDpqD24ebc27fd/sDxC2D7x
         oEZerZ33KuqZQxkDPXJXf8esM4OTDSuq2aHsX3pN0aKd2hUFdtpY1h5u9m3yJrUknuUL
         8J6PU323xrNVo/dZz0xLqm8RbjzHFrD3P3xBh9iE086T1kjX37MiZXPaaliDY/Cd6+kK
         u2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781292568; x=1781897368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lI2FhZeVSW/rDbtlOOBPVMTchx/8Z69t0suel1yDoGI=;
        b=QY+T0H5sDpYeGM4gCdT1D8xpM/FASV9E4lwjBtPSMuMByEk81ly7XCfjl+GFNTTcMW
         vBzlHycKokbGS4/3kM7GtahOZQ+5cLDDkqJGS8D1HDucJtHTC4okx07wAwY0OR4WW4mE
         P78F+sdQTotXBK9GGAkjfs9JCbEQzGs1uXpRI7e4bR8aJ8cQCpzFW9KdI8sVY1TaBltY
         J0ONRi/u9797JnvebYJbw8KUxnnwP/1t6PiNA4XMtxWYEG2rKsYXmTBmqdiSO737I0D5
         p4DoJ+w4TOg3j4pfeybUiZgPshtZTBroNNJ0GYwXYVN1lmTRL0tJKRF0cd0t9YG26gyM
         GYUg==
X-Gm-Message-State: AOJu0YyLO9cligGGHSo1Vk1Va8xwu9uYACVHFTDQGj+QwJpB/L4k57nN
	bho1M5hxE+B0jm/Vs3G0tBBVI9Gt21qi63BpexSQwSbI8ZtWIIdcC9syMIUVUZoHKrsZ5Bqi30a
	EMi5aYD1i0MM2bV18ddosk/pHR+tKZgm8ggHpTJY8rhqy+q685KXdjWd4QSTUn81q3ZYl8/VWKI
	qyDiFqphoxbCN//4Y6c+EXLQN9FxSOM8UO6An98Vj7mw23p8m7uVoECGW6s24=
X-Received: from iljq18.prod.google.com ([2002:a05:6e02:1072:b0:500:26db:d9ff])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1b2a:b0:485:467f:a306 with SMTP id 5614622812f47-4872f352d35mr2615199b6e.4.1781292567951;
 Fri, 12 Jun 2026 12:29:27 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:29:07 +0000
In-Reply-To: <20260612192909.1153907-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612192909.1153907-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612192909.1153907-20-coltonlewis@google.com>
Subject: [PATCH 19/21] KVM: selftests: Add find_bit to KVM library
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	James Clark <james.clark@linaro.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Some selftests have a dependency on find_bit and weren't compiling
separately without it, so I've added it to the KVM library here using
the same method as files like rbtree.c.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm   | 1 +
 tools/testing/selftests/kvm/lib/find_bit.c | 2 ++
 2 files changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/lib/find_bit.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89f..fa7a2746b1c13 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -5,6 +5,7 @@ all:
 
 LIBKVM += lib/assert.c
 LIBKVM += lib/elf.c
+LIBKVM += lib/find_bit.c
 LIBKVM += lib/guest_modes.c
 LIBKVM += lib/io.c
 LIBKVM += lib/kvm_util.c
diff --git a/tools/testing/selftests/kvm/lib/find_bit.c b/tools/testing/selftests/kvm/lib/find_bit.c
new file mode 100644
index 0000000000000..5534248c663f7
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/find_bit.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "../../../../lib/find_bit.c"
-- 
2.54.0.1136.gdb2ca164c4-goog

