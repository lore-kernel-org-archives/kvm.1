Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F243443E4E
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785518373; cv=none; b=XrZChT3X4eGu6pBNAIAUjibaL1ga8HXZ2wbudu0pDT/lgP+eNg30Y0TaqXofOViaiJ/yaA+OU58tL55xje9UhPo81Y3ROusriFXED87koNVQO0G3eHSaRNRGPE5/ncY/K4zBLZxbIWWqJn/a67sS1RXXD/m0O0w3c+5JAS1k9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785518373; c=relaxed/simple;
	bh=xIU6uO65MTI5GT5LeU4s+zhDQ366657/3pJut9ChS7g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XJclqgEO3jxS6+DrzHTbVZPBdggpx/0pSCUxdWQi5zf6PS0ebgoYw/ub+xJLWU0pqWoLA3/aBH4lq/hoTcJ+rgSDIpR5HhKb5/Oda1dyjr7EV6e7RDFxo7lBwbgcyA1+Etqfc088GMkqC8JLcsIjeWC0gaxLBFO1Cy7n4n2qCVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=naN+pMMT; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="naN+pMMT"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f5ac7354dso2212845a91.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785518369; x=1786123169; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XIBeCVj+waoKu55IzF4HgiRWJHXPMbjXy1AWpcy6gsA=;
        b=naN+pMMTIU2eyjP5o7bzJnEbE+nDIU049RmW4eUakW8rIoefIlNkAeZ4+r0dgJ2kAr
         JM1MMz1HyTWE0P8AkEI1adklxzED+I80tEcQwqwIoyM1G+HXwHEXjU3Wsr4VnYn3kqk8
         Mt4RxqABV/pvbLk2i1x2OPQutBr3cFfMmFPquKTz9BEer1LAWF+94U7Y7MCynEckjjau
         l00dVxtyxWNWbYKtRgm4rr2vPktz11Sy2KS4w08NWq0VzHxlCOBrWsptPkgr381eZAyo
         FDtmifVhBE5AbLkqH0STpPVkFc2czSS59Dwlydjrz13Q0NMhu6s6yYF8WG+U8SFJubI5
         aHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785518369; x=1786123169;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XIBeCVj+waoKu55IzF4HgiRWJHXPMbjXy1AWpcy6gsA=;
        b=GaeI0PatTWXMNU6ko1Yw87xsGNk/eHsb9GgBTZyn1/HqXT/IBwn2v+ZWVXl4UhJBOB
         0KN+emDUwWuvt60LiIL07zf4n5rI3FT0D+giM4IpmyVjie5qioFWeO5H8jNt0H6TK/XS
         G+83n39Ce7KE2otcmG4KLSKq8gLc8qMSjNXQIPnVL+Wz1SCzxaMsDynA8FFcdEA/lYdb
         iEZeZj7ohQk4V6gRcfqNO6EFzW2QlQV5ahuqNccMcDAnfahRDeBVYKMT2I4uxdr4m3Xd
         GP5lyOjUiL7/ZCFSzLp7oDM4zxmpIBf1uzoa+9y2qLpf6x7jqbiMW34Z7yYwSx3uEegu
         i/jQ==
X-Gm-Message-State: AOJu0YyxKN2IT7BD83DIK7v6eDsp538DtUiaCI/VQxu3bm0zgHlOfdoa
	Iqv1oV6JYlFNKnlyQt2RzAs+XrlvFXBme57CQM72Y3i/svL0xHAqyrlhIT6Jt5pd1rhwpv74m9R
	XD5n5fA==
X-Received: from pgaf18.prod.google.com ([2002:a63:3812:0:b0:c85:98b1:c613])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b8f:b0:38e:2524:7272
 with SMTP id 98e67ed59e1d1-38fbc56c8d6mr561358a91.39.1785518367803; Fri, 31
 Jul 2026 10:19:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:19:24 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731171926.2629627-1-seanjc@google.com>
Subject: [PATCH v7 0/2] KVM: VMX: Workaround VMX preemption timer erratum
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Due to a widespread Intel erratum (e.g. EMR158), programming the VMX
preemption timer with certain large values may cause the timer to expire
earlier than expected. The recommended workaround is to cap the timer value
to strictly less than 2^25 * CPUID.15H:EBX[31:0] / CPUID.15H:EAX[31:0].

v7:
 - Ensure the timer doesn't exceed the architectural max. [Sashiko]

v6:
 - https://lore.kernel.org/all/20260729134203.1377606-2-seanjc@google.com
 - Collect reviews. [Chao, Binbin]
 - Massage the wording in patch 1's changelog. [Binbin]
 - Use an inclusive "max" instead of an exclusive "limit".
 - Define a local ARCHITECTURAL_MAX_VALUE instead of open coding it in multiple
   locations.
 - Don't apply the workaround when running as a guest.
 - WARN if the CPUID.0x15 information would result in max value of 0.

v5:
 - https://lore.kernel.org/all/20260724234914.987987-1-jmattson@google.com
 - Include Sean's preparatory patch burying VMX preemption timer code under
   CONFIG_X86_64=y [Sean]
 - Replace div_u64() with direct division (/)

v4: https://lore.kernel.org/all/20260722143024.3938899-1-jmattson@google.com
v3: https://lore.kernel.org/all/20260722040311.3369898-1-jmattson@google.com
v2: https://lore.kernel.org/all/20260720231639.1592848-1-jmattson@google.com
v1: https://lore.kernel.org/all/20260720205230.1457146-1-jmattson@google.com

Jim Mattson (1):
  KVM: VMX: Cap VMX preemption timer to work around Intel erratum

Sean Christopherson (1):
  KVM: VMX: Bury all of the VMX preemption timer code under
    CONFIG_X86_64=y

 arch/x86/kvm/vmx/vmx.c | 158 ++++++++++++++++++++++++++---------------
 1 file changed, 102 insertions(+), 56 deletions(-)


base-commit: 3c7d7f908d574277a845423ec32250a8d8df44c8
-- 
2.55.0.508.g3f0d502094-goog

