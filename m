Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12C93537E5
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470140; cv=none; b=TWGW1XwwWNXKlhectsqhFoIafFFwwwMfHcvnH9ZHliOreXzEr+FxE0zOBiKuLPGNzTXG6z2lNXTtgWFtnK+xOIweGCS6Ip18L0FsHIjyA8OsovEhJVizdWyPNIX7C9pLk7Kl4YGenPuE97ATw0yBuW2qULe4aFBV8brDtGvr6HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470140; c=relaxed/simple;
	bh=tLI+ftTe5n/BxZacb9CKqeN9cY9aG3zmYv8BLfH4AQo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QN2H2F3sadtGqKlGkde2tLUggrWwpXy1F5+/YVw/aZE3XdlwLNmwJ3psgoPhsrpDRQoBewr9zMd/Clmkj7xlcI6B51EyUiiGyZziLNyjDrIEIdTbzo1H7kFILjq8tGZSc8n6Bk/8glM7TdzMlXXDqHojHrqxwf9kBfAdtpWqTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=szOk8wwf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="szOk8wwf"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b9fe2d6793so170601755ad.0
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779470138; x=1780074938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHJx7iyTbCSgp5BNDvBx4IjA+LRtGjpTLcLfJCN7OAs=;
        b=szOk8wwfdRShte59eVTMC+x4o4go03NyIAME/RBUzSZMybsO1v86c5pkZEm+irSjmD
         K3T/KsIRnTOn0zWWfv6DDpHc56+c6dDP+Ae6DFJXDyjKkFttufaPzyTnC8BQFplwJZlf
         jK40fE2y/M7oER24IGW7nAGc5FtJnjEExmu8KpESbeaPTls/1uulgekdxf65BusQV/W3
         1q88zwUI3zRqpIf/8yOdrzsdQm1Bq66vtoabUUoZHGNze6i/9eS9/+6QPCBWa1PHTelC
         LtoZjjnEmEZV7ilwU1Xz+EfhVR5YpmKH/4zGHPZlXlQRzE89ohUQpVYhTLASXy71lcss
         m0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779470138; x=1780074938;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHJx7iyTbCSgp5BNDvBx4IjA+LRtGjpTLcLfJCN7OAs=;
        b=KU1O/fzFJ0VI1XEy8+qqeMvmLesIZXYuJaIhALDCqHKzTGP08Kdg/URHPWSEMIp6f3
         QviuyaHK+MZzJGVmEAwUFu53bM0Jmm9oo+wZo9cYs6VSiqWI2g7BdUHOIM+yvz4RWuhS
         tJMFIWjz6utTVRDHUhSs6grHBtfGLtpF6cKb2XS1dct45+qD3vbPuTIVvS8k+m8Iu54z
         b0kxFPsgXC49vNFknzOZfIWs8zVfuFFtkNcajFyvuEQaopkFfCmmjsv2QGRmC62S7sJU
         EM2StuwJBM+Bxngtn+UBNJgwzPoKk/gUISV8/bSCXNbEZIyrpSTIaMJk5ak6RO8RFx2z
         M6Nw==
X-Gm-Message-State: AOJu0YxV3u1hAMCj1Tn7CD29HsD6eG+OiSB5YBaQxuAgV5+SSP9bOazL
	vPh0OScle6qF7eFLBjXjXA6dUuNM0Fro3khaG9UVyeARWfIWIrtTgMedNi4rQ2GSo0zt+Ea73f9
	4weWMkw==
X-Received: from pls13.prod.google.com ([2002:a17:903:448d:b0:2bc:bdd2:af75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41ca:b0:2b7:aba0:ac10
 with SMTP id d9443c01a7336-2beb066295cmr52576115ad.11.1779470137633; Fri, 22
 May 2026 10:15:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 10:15:33 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522171535.3525890-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: selftests: guest_memfd close() fix and hardening
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bibo Mao <maobibo@loongson.cn>, 
	Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a bug where freeing a VM attempts to close an invalid guest_memfd instance
due to checking if a u32 value is non-negative.  Then harden closing of fds in
kvm_util by invalidating fds after they are closed, e.g. so that freeing an fd
multiple times will fail instead of silently closing the wrong file.

Sean Christopherson (2):
  KVM: selftests: Cast guest_memfd fd to a signed int when checking for
    >= 0
  KVM: selftests: Add and use kvm_free_fd() to harden against fd goofs

 .../selftests/kvm/include/kvm_syscalls.h      |  6 +++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 25 +++++++++----------
 2 files changed, 18 insertions(+), 13 deletions(-)


base-commit: 66939c1603bd5579e63278f9dc72cba5b79da9b5
-- 
2.54.0.794.g4f17f83d09-goog

