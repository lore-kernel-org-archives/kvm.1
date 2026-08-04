Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB03F0A9F
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864880; cv=none; b=V/bedETUsmKKBs5bUfVOsAUcqitNY8m3F440c22lBnlfgGdMPtxSVhIOAy+RAh+i3NcigYRBleooWMzP76aeiQUCRk6oKqS/BbXpgBlEOxQMUnr+ZcawQR2AdC5A8rCnx+wNSKoZTQ+/7fDfOKb5YVm32b4P0pyDxtJS7yv0hk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864880; c=relaxed/simple;
	bh=YQrvEDQ5OrwsuBxDUYxdLoNvuDNpQlzXJg4KdYe8ZSw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ud3v7uJMND07oStsTDCuZfjoMPz9jOr3TZDh2DCxjtKa9+JcD4PvtDftuSBCxLTwAk39ZLi462zNu/GZOW3lCGp49PEmwL71+k0YmrJWDFNwa0PJyzRmkF5QwEwmtDQid5Eh9bmhe9MCF550m06E9GGfoEu/kGrE274UIJAmb00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnwQQ4yO; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnwQQ4yO"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848544a8496so82977b3a.0
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785864879; x=1786469679; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QuWjNxQUUN3+lvsqeDl6rlKCHsfK0DloOnBH+HQpjls=;
        b=mnwQQ4yOPuHba87e59xL3FD4MarNfAgqgO/Rc0kDinsWjWgc8CODAQloePWsaOh6yd
         odG0KEGXdzK257dUFi3yHn+fFwCSKWZYyQGCbUKeHiufw4jxZTc+D4wXAMxFOt1Rb7we
         eMxbQG3MUI7OnIUyH6W/Sg1axz3gFmFfyw+7hutHzcZZmCmR5I4Gh1LwSg53ikaZuLuY
         nYken5XVIUOEbufBBRTtZmYszOV500ZmjxPfWEYRX2ve9VFLK6zlyfIGJbrFXkd3jzr9
         TRfwEpqI0xLT83CI+5nsDiWMKyVXPDdbTeNIaY3J/0Kn0arE2cdVA7qxri7aGcAt14cI
         2ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785864879; x=1786469679;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QuWjNxQUUN3+lvsqeDl6rlKCHsfK0DloOnBH+HQpjls=;
        b=YICRGMxXvL61QtChqp8S2+5fBGE83jIGm7dOVRMB7EipW9FmpIezshdlvUU7gGnOpd
         c8AcddyZ2G0pkz9QZAeNRuGOct+lI8GMXtI0i0r2pEq3C9gM5EwCvGdK52qNHJzyucwn
         F+yY2HKQeCOFDajtEK8Wqh7xhadEAqCdT/hPZ9rBH7r7PpIBVdck3jPBLhdd2kW9UXcH
         DiZxC3gcdiJQQsgnNHeTosOHsrpOjdUOz+NZP/jjZ/yMx+ETMRH2V7LmBu6jpUvT+CUC
         PUCUHk9HFf6LtaU+LJuQ3+MX2+7HCygHpfsZeV2GqkyOtT9wF846LlBptsTkbniFBFz6
         D4ng==
X-Gm-Message-State: AOJu0YzmSVv6DVItEvypAXyL4I1EVNBRvWJLn+0NGMaA2BhAzcA7f6Bj
	L2exhy8RR/GuAuJrfM67upPSlpGGRcqAYS57DacMwjBT8jmU/HHY9gZJ2A6aPIwA/yZm7b3ekc7
	qh9GRvw==
X-Received: from pfle9.prod.google.com ([2002:aa7:9209:0:b0:847:b0e2:92a3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d06:b0:848:2a2c:8528
 with SMTP id d2e1a72fcca58-84f2e0c9ce9mr407746b3a.44.1785864878302; Tue, 04
 Aug 2026 10:34:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 10:34:35 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804173437.3339269-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: selftests: Reduce PMC test runtime by ~17x
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reduce the runtime of the PMU counters test on an Emerald Rapids system from
~85 seconds to ~5 seconds by (a) testing one random GP counter in the arch
events test instead of every GP counter and (b) creating one large VM per
"major" test and then running each subtest with a different vCPUs, versus
creating a new single-vCPU VM for every subtest.

AFAICT, there aren't any bugs anywhere in the VM creation flow, there's just
a lot of work to be done.  And VM creation isn't even that slow, but creating
something like 1000+ VMs for the test adds up.

Sean Christopherson (2):
  KVM: selftests: Test one random GP counter in PMU arch events testcase
  KVM: selftests: Create one VM with many vCPUs for each major PMU
    counters test

 .../testing/selftests/kvm/include/test_util.h |   4 +-
 tools/testing/selftests/kvm/lib/test_util.c   |  22 +-
 .../selftests/kvm/x86/pmu_counters_test.c     | 230 ++++++++++--------
 3 files changed, 150 insertions(+), 106 deletions(-)


base-commit: 2dfab80a305700a45bd947350dae253ba4e30c41
-- 
2.55.0.571.g244d577d93-goog

