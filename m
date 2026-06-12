Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB1384CD5
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276205; cv=none; b=U5YkREN0mcxLbQUcHGYmd69VPnF4XxXJ1Gm8QgkS1h/xe9xrWU/CoW/tU2L3Q/tIGBzkEWAmmjd3kUCBt1QRfit8WUIUIgNJIVorn0qJJYH274W2NSuP9WCpOqSXCwQgG74br4uR8iAu1rSGYeA7fed0h10G2evuMjPn5verhSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276205; c=relaxed/simple;
	bh=vVJthlNf1xsGUNnOilQjy7yBliqp97Qw1g3n9IGmtXc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KYhngc8lrVXWebvFlyI+bHLPwSXdTIqvILAlczPa9/LD37XJqLNoYcG15EX3lZ+v0QJtVOqp2Fh9cRFjAV90XabhgVUVJYKz4S9NVu72qziqWJfiEFHhoV2tN59D2q1jEOK1A9nFPXTi2hMJ2JK+lC1uRbkZobowb/q6WaAuW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=em4LueXb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="em4LueXb"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c20f7581so11636555ad.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781276203; x=1781881003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x01veqm415wq7cLHwV2kqWsZcPnDuVx2qWbO7T/80Xc=;
        b=em4LueXbVFHeFQ60HIP76snaSTiPNNJfvi98gh5u54d9mT5K7eVJiu4mUIexKrDBSM
         2avwGErUh0IFrwON4YTmTvRuvZnMba8c07gIqFkmso/DaxmIMrdc9mA8IAh7IG52YJCn
         hyWNS5NVW+Aa4TBQGoKq65ajsZhXzEeptIBeWBV4Zs8XZH/QzfzNfkGdEFqjI0G7Zd7X
         B+u2QH+2yLsNAaNmnTgjgD/n04V0g2ReIEG5xHw02iVbBNXC/5XAZWx2xvQ6QFXcQGdo
         O/Ro8SWVoPUA8gpLT4iEWrWoGLmXxSPQVgTWi5F56gJvfDJHeSWja/NktnBsst+D+NaZ
         6poA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781276203; x=1781881003;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x01veqm415wq7cLHwV2kqWsZcPnDuVx2qWbO7T/80Xc=;
        b=HPT9QDqFZdMbcY4G6x1cQf/webomuDhB2FGo3WEnSRhXGBg6YGi0y+Hwur+neOVtO1
         MFd4HcB10ZZaTeYqh1hYDs1QgSskdULnkAHv2SCTq7zsAW8WNElmqrTV8TuMczRAtvlA
         ONfu4D0lOFpTYXMkwjQDDaVCqykli94W1VuX+FoI6skfKgSFnOsSMpuFOD6ek4aja4l+
         4kFD0n5j+HRtmsB5IObmurXlLouVsepoMGo4sjnCU0VAXje5e1/QEzRlwuEuedx1voIz
         lh1xslu1S4rQIsfbbkE5myJgbifnRYBDjdNgvbL3+uIHMHq5TCwMvynBJRVpodSmz3AM
         CWyQ==
X-Gm-Message-State: AOJu0YzPSaVwq7+cSxiHJmLomSqaHn5pUjV1zCvmw8gyOXULpOLJooJt
	3LRx3bLcvxTsDWtfNOaRVwuV7qOZzYfOifEQmpMQGZ4VPVE+5CKiCzSDAbTyu1DNqJsE+fTNLUW
	QWSl1YA==
X-Received: from pldp20.prod.google.com ([2002:a17:902:ead4:b0:2bd:52b9:305e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2310:b0:2b4:59bf:5728
 with SMTP id d9443c01a7336-2c411d79afemr33408815ad.25.1781276203151; Fri, 12
 Jun 2026 07:56:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 07:56:40 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612145642.452392-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: nVMX: Fix ept=n bugs where KVM runs L2 with guest CR3
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix two bugs where KVM can run L2 with a guest-controlled CR3.  The underlying
flaw dates back to commit f087a02941fe ("KVM: nVMX: Stash L1's CR3 in
vmcs01.GUEST_CR3 on nested entry w/o EPT").  Past me claimed:

  Smashing vmcs01.GUEST_CR3 is safe because nested VM-Exits, and the unwind,
  reset KVM's MMU, i.e. vmcs01.GUEST_CR3 is guaranteed to be overwritten with
  a shadow CR3 prior to re-entering L1.

which was and is true, _if_ a nested VM-Exit or the unwind is reached.  If KVM
fails directly, vmcs01.GUEST_CR3 will be left pointing at L1's actual CR3, i.e.
KVM will run with legacy shadow paging a guest-controlled CR3, which is... not
good.

v2:
 - Use kvm_read_cr3() to read vcpu->arch.cr3. [Sashiko]
 - Skip consistency check if reading vTPR fails. [Jim]

v1: https://lore.kernel.org/all/20260603223418.1720035-1-seanjc@google.com

Sean Christopherson (2):
  KVM: nVMX: Move vTPR vs. TPR Threshold consistency check into "normal"
    checks
  KVM: nVMX: Don't use vmcs01.GUEST_CR3 to snapshot L1's CR3 when EPT is
    disabled

 arch/x86/kvm/vmx/nested.c | 87 +++++++++++++++++----------------------
 arch/x86/kvm/vmx/vmx.h    |  7 ++++
 2 files changed, 44 insertions(+), 50 deletions(-)


base-commit: de3a35be92d2391ece4bf3143ef2887192625fd0
-- 
2.54.0.1136.gdb2ca164c4-goog

