Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E14A2E26
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332527; cv=none; b=IYqbwvqdv7ZYAmglcHL2kSOOLIBMq7dAl3nbrF1J//UrrcFJ1RI9T9BNKTFl/BhPcgzYJJLQ44+uOaxXV4fDLiFoFAxjCYKLNwyzhsUhnT35KnNbYHk1E0zLFPoJcd9SdGznR6R+nMtSOkIfSRhwA20nieXRAtXSqor6pERhz2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332527; c=relaxed/simple;
	bh=khmxLp5K4ukXukURUaFTo3l5VuL6nUOSenrUb4o9od0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D+y6w0f2mTqpp/GVi4mJqj1uJhgpd9UwxHx9J/AlmkRy82dxBJeiC84gxWhdyo+PHirZBJelomtghyQh/OdMy1lL/N3piJFgSedTMbO/sqhaJ+FDVD2IpTy3hytPyMANqDw8mTfuj9ZRI/Sjqus/ZpHWwTfd1aT7saAOxOr4ZWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aej1dc3F; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aej1dc3F"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8488ac68185so2394757b3a.2
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785332525; x=1785937325; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h4/S7Hr3VP0PfA+XLbsiSJD6ArkO5P0hrxACr4+xXzI=;
        b=Aej1dc3FE0Y4FGsFHdnezT4YPgwtvB9eSPCjAyZYBBz+O1CcKt9Z5xk443hBcyOe2a
         aFmMf3IzfnvJluD5gs6OgwwyeC6c/fWfG1HlfFHKEwSEUXsJSyZSvi/OZNY/OmFVyy5z
         BOQWOOiwvia7hX2svMk7DHKOpknwH2xs3YJ2jhenHj0SxG2FgmwO0Dg3hj56iScCkGeE
         5QFRquMOW/S9WvdDsdIlLbIPt0hS3AQllmQQYfC7sj7uv6TepNO5TD1ONZ8runW+KgO6
         JO0OPdppB8S2MlL9keNbclFobLJDWqoZl5w1ey7y6GT02I2C9A3DpNKlhkNtYtyfwAg/
         ByUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332525; x=1785937325;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h4/S7Hr3VP0PfA+XLbsiSJD6ArkO5P0hrxACr4+xXzI=;
        b=hPug+NAplyFrHwQXgl3rEz7TrvO3NhJeL8eQmB452anGvXeN/SeLA8naJJCqRE3d+e
         j1mQutayac8OlU2xyTEEV5yb4hRLLrFUZSTyTr7Loz+5ITHb7gGDNHSHCwssKpKJ5Ryu
         vv+sHFpUQk33efXKlmiZdV+paeBDSBzXOKLoYXthau9iGTP+j25TZSOJTEsIfd8dqIc/
         UxIaMPvgw3tt8vHdCkg411z0nbkwes8rR5nyEsagUuRph7cdb7raJDimu7Wh1bWMjiQa
         3UZv2dTyxvnhUoUR4fGuYqHO9guosRO2FuEUH9zzJtJEfqCLDfB9HIBNjNoQ9+4X016w
         lepQ==
X-Gm-Message-State: AOJu0YyXxqKSE4Yc8t5CLjTZozDkmxC9fsylQjm1X3XqlDBLg7zz5mG1
	pQg67fcYd50eGpRwuiiujIkPuJvGHu3PLTlumO5V1bgvvjBDgzgWsv1g/hL4BlYDHNuop06ePv4
	O6uyY/A==
X-Received: from pfnw22.prod.google.com ([2002:aa7:8596:0:b0:848:2cfd:8fa1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a21c:b0:845:c8f9:6ce0
 with SMTP id d2e1a72fcca58-84e931ecd92mr6251251b3a.21.1785332525042; Wed, 29
 Jul 2026 06:42:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 29 Jul 2026 06:42:01 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260729134203.1377606-1-seanjc@google.com>
Subject: [PATCH v6 0/2] KVM: VMX: Workaround VMX preemption timer erratum
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

v6:
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
2.55.0.487.gaf234c4eb3-goog

