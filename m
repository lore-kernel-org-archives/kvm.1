Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC62366DCF
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471331; cv=none; b=Mj/Jk2Br651Umbk60aP5S2dpH2FK6qG3NYzsrDZ5h566fnVc4JYWYDs0NWSSJlNYIulF49elJQYkly10SKBCG6YMr3QT1Id83D/G0t9IfsSY0s7NOGd16pl6Px8i44GaoqCQIDFpH2ozFLrPS2vKjEqHRZVvUvVN15PB/k2wCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471331; c=relaxed/simple;
	bh=H37boUuo9E5mRF0qNF93k4Gbsh5xl/36vRQDNUboOmw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WjXWWHWcTYAeMprb9r6ITNfjrjaqF4r77EbDtQw0Sebyicl4ccczw1iL40ybQWZKWZS15NIDhyhaNojdS+K9nWDjLxMRjE7htbALFBOI8YX+4ZHmeZbc6D9heWOcdvw9C5kH97fL04nOrXh0yAnuoGMBSxqZkkoJmbmgbOg81HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=loxCuRn2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="loxCuRn2"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-366ded3bed0so5273700a91.0
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779471329; x=1780076129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTB+p1hY2Q3qlp9axeeOZzonrWJJs/l9vXric7dVHzw=;
        b=loxCuRn2zz0y6mb/MvORuk6GO/r1MV1cOyzlXqGVdA3mOouQFDs6gp5A11F4XlSgF/
         l+sLYABTFISvPWTN5xW7r0QW3D4foVcqBB00epdiTYcLW5SyYWIWfcgO7c3J1RwgVEMX
         3lnOW9nUX569CSUoNlBoRxN/jLdoobj8nQ9tOfTWHWMwkaJqSW2ctVjl/CxIlL9G7I5/
         SNO7DS8/e1SE4LJoA81Wi2789rllt8o2L57GsJiNHyioCn9pfRhW6FnxMMSwI863P0/a
         zkl+pLV5tMPLt5cgqBr96qdgpCroL/EQLk7LbrKpg2q5ip5zAYV6FGv9XeMcpzZyGZJC
         f1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779471329; x=1780076129;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTB+p1hY2Q3qlp9axeeOZzonrWJJs/l9vXric7dVHzw=;
        b=dslrQnq4AeUwnRUuGMy2TFF632VnyGtb1Pm0Tz/WFzm+Ald1U79Hv9NbUGouRZZ9n4
         scMVXVzXJsk5R5tX07LEpa3xjPcvQHqi1aUz909b4WpUcCt6LzSKDrOHon5DR+Rm2t/y
         JXibzy/S8+Vcc6UYBmiwPRq+6EQBYNtTqH0j06zvDF39MEVTFWVOURbpkGn7QRZyDQDQ
         2cBHdqtMb7kD/YKysiLXNmX3JyAcTXDYincaNWDDUc6cgsmjbjlsIFErczwnc+Imlao5
         xEPHVcXo+94QeQPzaQUGMCtuFi9iQQOs9Nu9WAioRCeYo6Daymy8vdrDZOD5+UwQAKQe
         IQKg==
X-Gm-Message-State: AOJu0Yw9dfUVk1C0uoqqKHKF0dj7yEp9oaxy8fXJXFJ2OaIpRG4Sl+E5
	xwivPVgVdTogCKzbVU8SntLcyrbZ794MbSTXzdZt4h/m1V77gbR/MsjfWo7vnnvR9IuFLdJIyik
	lZ+hN3g==
X-Received: from pjvi2.prod.google.com ([2002:a17:90a:dc02:b0:36a:1262:8c5a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ac10:b0:36a:5b56:5c1d
 with SMTP id 98e67ed59e1d1-36a5b565cf7mr3864016a91.11.1779471329272; Fri, 22
 May 2026 10:35:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 10:35:24 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522173526.3539407-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: x86: Return VM's actual APIC bus frequency
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Fix an oversight where KVM always returns its default APIC bus frequency when
userspace queries KVM_CAP_X86_APIC_BUS_CYCLES_NS on a VM, even if the VM's
APIC bus has been configured to run at a different frequency.

Sean Christopherson (2):
  KVM: x86: Return the VM's configured APIC bus frequency when queried
  KVM: selftests: Verify that KVM returns the configured APIC bus
    frequency

 arch/x86/kvm/x86.c                                    | 2 +-
 tools/testing/selftests/kvm/x86/apic_bus_clock_test.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)


base-commit: 66939c1603bd5579e63278f9dc72cba5b79da9b5
-- 
2.54.0.794.g4f17f83d09-goog

