Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51B3490BE0
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570342; cv=none; b=LDOGikG7lsZ2apDTF8O9iHx3wprN0InIzLJU9OTolbFYf7FJtGB6qRENxGWUMq8VlfzxObyFNYLt6nibHQu0veGL25gTmz3D0tezUrHepertlEt4Xr95hbIqiG1E0KJz4GBthShdIvimlqoPGCnX3jOvynls49y/tXr/QW0gZog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570342; c=relaxed/simple;
	bh=Yr312KCUoo8OMZoPKGFMFMxvuxatrPCoMn2wDYFGKKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oXVFGnciAZhZRDbuLVZLk0W5R80Xfa7g3vkAyJ8CdSa7BEVx2SiH3tZwk9n6LlxzYFPzzwgyrJjLh9nFrcqsOaUNAqpBT5tDXIAI+M/DdbKflKCcYMFcgV6F5lCU5UxUq9+BTBRXgYN7b+j8MBQht4Lft2jQYv/J6HY/7Kxn3A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T2g5cPlD; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T2g5cPlD"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so114729a12.0
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570340; x=1787175140; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oSMrpCIn/OuVMMxbucvWWd45G3HPwvwQRDE6imx6eGo=;
        b=T2g5cPlD+IF3A1fyz2hnjC1GaUWTbjz10pnZNJmsaFxmibV/qlrjoTayb8SooWfb9H
         /ber8u7bPOjHFY+QrmEpDOAtXQY/uhBbMfx1Fq9IdbCYTrUw2OfYXN+2zyUQK53oO+F4
         1YktJ89zj9h9fOClXAXRMjvOXn3yf3jVaNRg3JycCso8OipX6PJ8GXFz/hMjeMWDWFKd
         EpJZFh/k48HQ26yq2jBWm1rU98TOdDbUyLg7aItQ2puBPDtfIw0c0ERWBc9yGF9l+2iw
         sAPA8cvR0x9HSYbAJ6JVw8KFRKSC1kxKQDgGYJQqcuxvXEk+R+JE21TxQjQdBSKhFLUL
         mtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570340; x=1787175140;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oSMrpCIn/OuVMMxbucvWWd45G3HPwvwQRDE6imx6eGo=;
        b=e8ErXWMVob4VMlBvtmTwqxjKX9Hf4j2Kox1Sq8KGr5mQM0rub4eW3AxnbX0P1dBVLw
         OneK4iRIFGcd1UB/Kcxgp2Rn9v/3iLdpqkeX7yD8lnmFf2FSYj2H6zhEgHs4wLMsyhD8
         L07JwqyBxOmUiSpCfRCIk6/aV/8iCDjVJzJSuo6WtsqGuicDW0mopmM3mSfORcPgyUlv
         U+wlAnroVT5xkwOjN8iCWKFO9AxzrHs/BHabfzCiuVdz2dWMv0R9khT25xspk0F6HdXo
         3GpeU3DT118ZSIxXZUEO88cL/B40iiiJ574sMw8hb9DooUog/Di4ckUK959Rx+eiEfg9
         V5vA==
X-Gm-Message-State: AOJu0YxBUqK2wwbafCA+KoT4b+8/fQTVHXtWi606QbG3nn+dj+6aqJ1+
	xlbZ+GNTaFUiFYLDKNj4vGS6uEgITnV7sPBhMLVwlKD3TF5nPm21InqLMzU0zbq0qLaG3JL515d
	F0p3oYg==
X-Received: from pgar27.prod.google.com ([2002:a05:6a02:2e9b:b0:c9e:2db2:a2cf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c68e:b0:3bf:7eb5:9459
 with SMTP id adf61e73a8af0-3cc552c3804mr1622639637.20.1786570339711; Wed, 12
 Aug 2026 14:32:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Aug 2026 14:32:05 -0700
In-Reply-To: <20260812213206.1564354-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812213206.1564354-11-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: VMX changes for 7.3
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Like the SVM changes, a small batch of fixes and cleanups.

The following changes since commit a204badd8432f93b7e862e7dac6db0fe3d65f370:

  Merge branch 'kvm-chainsaw' into HEAD (2026-06-25 11:32:09 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-vmx-7.3

for you to fetch changes up to 0aaedada606aef1732cf0e123403a1e8b8b38c0d:

  KVM: VMX: Cap VMX preemption timer to work around Intel erratum (2026-07-31 13:41:56 -0700)

----------------------------------------------------------------
KVM VMX changes for 7.3

 - Service local TLB flushes on a failed nested VM-Enter to fix a bug where KVM
   could miss a TLB on a future, successful VM-Enter with the same L2 VPID.

 - Cap the maximum value shoved into the VMX Preemption Timer to workaround an
   erratum that affects all existing Intel CPUs that support CPUID 0x15.

----------------------------------------------------------------
Hao Zhang (1):
      KVM: VMX: Use cached vcpu_vmx pointer in MSR and segment helpers

Jim Mattson (1):
      KVM: VMX: Cap VMX preemption timer to work around Intel erratum

Sean Christopherson (1):
      KVM: VMX: Bury all of the VMX preemption timer code under CONFIG_X86_64=y

Yosry Ahmed (1):
      KVM: nVMX: Service local TLB flushes on failed nested VM-Enter

 arch/x86/kvm/vmx/nested.c |   8 +++
 arch/x86/kvm/vmx/vmx.c    | 171 +++++++++++++++++++++++++++++-----------------
 2 files changed, 117 insertions(+), 62 deletions(-)
