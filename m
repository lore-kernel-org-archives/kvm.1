Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623603375C5
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858382; cv=none; b=Tx5m7c9PfIlmMbhv6/AiqX/YFL3kRfOfy/63R6jquoeoIF+kl6973kir8t2mQHXXPNOkz3Ifh1Qes9yqXiZUZ9WXxWVdWWwTZZMpGtad8Wka2NwembJjoj9+VbJlOt8khNCQijgoRkEIGNDr6KA2Qq/4wQ8+GDqcROAA+lxSSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858382; c=relaxed/simple;
	bh=HG1feGI5IlRLv1EZldmnpuccydXnewwZEq3J8EOi69E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uejIMKcbmnAKbDuH+1aPNCuLWZ+iOUBfNTk0D1RSQrKg4QTpVKNPU9W0eNfZP/kG39F0hjqbwmryFXwLB373gB7FgqY+ejzFT/ARpVeG7ByiMAHfkYNT4y7e+DQvPC499n93PNl6kFqF9pjaPV8aJwbSjiaW5Mg9Guc7yHoADrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3ECMxTO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3ECMxTO"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-38096cfd353so28198a91.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782858374; x=1783463174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iXLxXMqbIY8W/T72sN/kWMTgzC1Ya7nU/31VzyXOD5Q=;
        b=r3ECMxTO5LaYLauUtKIAiUeSNbDx8gXEwSn3RCaWOdlIJLU/Ogix+EordGB2tjJrmZ
         NHSXXWsXYwxa4nVNChygdpWgkytYHixjt97gax+WBAKyLk/adFGPKzdMa3ODfqy0H1ci
         RfJ32pZgF4kmSimK53WlNDrgQuco2IHhwAmCbfakLHyaGCAQnQaw6JAa0jCPcpQLgngm
         aBxnHVjcxchtZc6n3alNrcS9HJ5E07cSbQ9ew3ogpajRkUlH5S+cDnMXCxoqjdUf04Cv
         flY4jmTq31IBjX1VkaGzyop+tnmwSDFSHyDeKPSsEc8sJiNvK0s2d0Dj8eKY2v1BMT2h
         sNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782858374; x=1783463174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXLxXMqbIY8W/T72sN/kWMTgzC1Ya7nU/31VzyXOD5Q=;
        b=EV4OtQD76OiixeV3VlPLeeNaUB25+QKqA1W58ebtusoRMUdfUYaivjvYth8qt6g0ZK
         G78PZT/LPhSad/KrCmWzMnWvqFSwvIJ7htfUOJzjHGtZwNkNHiBlUuLjiAssMouwueCR
         UhmK9Tt0cHjIvhamU9q2rApH6cMhCrejXbv1mbiAJBwEGJAB+Z5tXun4bp9y06l54rJj
         a+Bfoz3Ja60iarq9yulHw5VtlEhC78RbOWcgNkXF03S41NwGKCNWyRFIkx/g6IgluDhj
         OzGj9BO5o80THrGYMPseuGldfMfgF3/Sxn42OKzSvi0fZfh+HY7/xTruBrb8WPBcELx8
         W6ow==
X-Gm-Message-State: AOJu0Yy+9uEBoKtJdga8Ep+8tSpZAss9WoW3ul4DQg6nA8MObLCKKyBm
	MJHVXjA7qWtKuVdPlv+ED5pgKeJrNIiogKplKkaQiS6IrKVBBYKFVsEGcCgCMF9WnoPYYKzOeSU
	BPdAikQ==
X-Received: from pjbbk24.prod.google.com ([2002:a17:90b:818:b0:380:8669:e33b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f90:b0:37f:9ce1:7369
 with SMTP id 98e67ed59e1d1-3805278b7ccmr4252232a91.31.1782858374332; Tue, 30
 Jun 2026 15:26:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:26:00 -0700
In-Reply-To: <20260630222607.497895-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630222607.497895-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630222607.497895-6-seanjc@google.com>
Subject: [PATCH v3 05/12] KVM: x86: Serialize writes to disabled_quirks using kvm->lock
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Protect writes to disabled_quirks with kvm->lock to ensure KVM doesn't
clobber state in the unlikely scenario that userspace disables disparate
quirks from multiple tasks.  More importantly, this will allow wrapping
accesses with {READ,WRITE}_ONCE without "needing" to also guard the writer
with a useless and confusing READ_ONCE (since the RMW wouldn't be atomic
anyways).

Ideally, KVM would disallow disabling quirks once quirks are "live", but
that would be a potentially breaking userspace ABI change, and while all
existing quirks are fully live only after vCPUs have been created, several
MMU-related quirks, IGNORE_GUEST_PAT and SLOT_ZAP_ALL, are partially live
at all times.  Because populating MMUs requires a vCPU, the guest-visible
behavior of IGNORE_GUEST_PAT and SLOT_ZAP_ALL requires a vCPU, but for KVM
itself, processing the quirk (or not) has functional impact, i.e. for all
intents and purposes, KVM can't prevent those quirks from being disabled
after they've been consumed.

Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6b9a1b0b1460..74f1d7169218 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3939,7 +3939,9 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			break;
 		fallthrough;
 	case KVM_CAP_DISABLE_QUIRKS:
+		mutex_lock(&kvm->lock);
 		kvm->arch.disabled_quirks |= cap->args[0] & kvm_caps.supported_quirks;
+		mutex_unlock(&kvm->lock);
 		r = 0;
 		break;
 	case KVM_CAP_SPLIT_IRQCHIP: {
-- 
2.55.0.rc0.799.gd6f94ed593-goog

