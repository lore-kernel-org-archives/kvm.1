Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5BC4D2EFA
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959720; cv=none; b=ugqGgX+XrsK+oRIVDq4zk6xPSIAk540VBFQs4aWRqjNS0nmp5BRLUCML2RSeVQF4DwpkotyCUcIbe+mz4fWu+4Nu0xDMEwAwIcIqZ5s6euNBqx6eUwIrajibiHRB6NZgTzrCVay6dppRti+xeZWHF/h9NXkyU0Dzinsc+X5Gl/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959720; c=relaxed/simple;
	bh=6ODwo+16pMIfil4k6galug19W/vck29CbEXmoNYWtB4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jCVzk1Hm3jd2/yYZF2chBitQeenVTrsl7lyZhMn3gWF2OL09VpCEyxnuhOCHEkbYLji7m9Snyz7VZ2s784Dc1JMLHkPpjZ+IBRnt6R2c5EIWMBBzG+FXlfQ1RTFcNPksMspOoG65bGgUHqca5+iRXVyx1i6+cEa9O0Cfyz9yKCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VdGSH7Io; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VdGSH7Io"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so102849a91.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790959718; x=1791564518; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IpRTn+KD9NJK57wJTMwL/20JlRBVAu7bzDg4EAe9yBY=;
        b=VdGSH7IoLKlBqYx/FXjoF4l2/WCyrvC9FQKkflUEiMMgB9AosVQSzSUIEDJ5vHv6e9
         LFK9w3XqWxkiv+A7Oe9J2TCAqqxJsuqGlhC+8ZbrhLtO+ofZqRYeo40HDgYY9ZQV7uH8
         2+EtkEwkQoIhgzc3CQZDOmySwYISe6Sv5y6yC5aSK0UUAEvhBiymwEvmcFEixIk2k+bX
         6jgxl/2vj7krS6i56+vqh3F/JRCydGS+nOkabIB1Vpm1Vz5Id6G4W28Qyfht6Xf4utDO
         upBFysRpecbWMopzZQtXZjlej9jVtpapWr+v2c7+GiYap7WuwIhUyAwJxDvbzkj1B5KJ
         rxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790959718; x=1791564518;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IpRTn+KD9NJK57wJTMwL/20JlRBVAu7bzDg4EAe9yBY=;
        b=ljD/dagRWPMPiUyBvoGrCs1iyA2N8juRS+7hsP1kG2zuFpj2uKewYOkhK8tYo3CCW0
         TkWBj7JjoyCgtq06s3EItr4rU9wUeCxyYDbrE8AbkhH2Dc+ju8+7lAhuJhJqEFkrg1Ny
         dFX6yEvqIsFaF4Yp79E9ClGYdKw8um3sgH0sArGxZ1X3YuUXjj3PBsG7VpNHix0KbyKg
         7D1Ydubd1lmdN2IlHhxux/xvEYfcVr95zW7pUq2RauULp7T3VWyBVFkI3ijApdF4WV8V
         iNq4jqvm6WRC2ejdb7EM4qxGxnHd/64q82RTiuBdVD4ybC2OW6ygIQSrgkDW3bs3upgr
         uLdg==
X-Gm-Message-State: AFq9FYINXSIBv/3u6746aB4097jD07e4ay382FTVKkkc9V7sx25443wU
	zaQXrud8Kb7fx4dl2hMJPt6LDlHwE3OTlodGTvCctFX5vmOR5TUWXkOz7pVKVLN+ZjpgLLkcg+7
	hdUEfBg==
X-Received: from pgme16-n1.prod.google.com ([2002:a05:6a02:6c90:10b0:cca:4a92:2716])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f42:b0:39d:f247:bab
 with SMTP id 98e67ed59e1d1-3a6ce5fa392mr2970671a91.6.1790959717666; Fri, 02
 Oct 2026 09:48:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Oct 2026 09:47:50 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002164750.3981742-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Fixes for 7.3-rc6+
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Please pull a few more fixes.  These aren't _that_ urgent, so feel free to
punt these to 7.4 if you think we're throwing too much into late RCs.

That said, I'd really like to get the AVIC fix into 7.3 as I very deliberately
didn't tag it for stable@.  The fix depends on what ended up being the changes
to hold kvm->lock for all of vCPU creation, which I don't really want to
encourage folks to backport to LTS kernels.  So, if we squeak the AVIC fix
into 7.3, which is presumably the next LTS, we'll save a one-off backport.

Thanks!

The following changes since commit 973ea70393e885e540f714904e51bc6cac80e3d7:

  KVM: SEV: Do cache maintenance on the source VM *before* clearing SEV state (2026-09-28 17:11:49 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-7.3-rc6

for you to fetch changes up to b3e6212dea2e4328a841ceb37f377583176dc735:

  KVM: x86: Use active memslots for the per-vCPU MMIO cache (2026-09-30 06:40:49 -0700)

----------------------------------------------------------------
KVM x86 fixed for 7.3-rcN

 - If creating a vCPU ultimately fails, clear its entry in the AVIC Physical ID
   table used by hardware to perform IPI Virtualization and delivered posted
   IRQs.  I.e. plug the same use-after-free hole related to IPI virtualization
   and posted IRQs that was fixed for APICv by commit b41f2ca6c0601 ("KVM: VMX:
   Fix stale PID-pointer table entry left after vCPU free").

 - Use set_page_dirty_lock() instead of set_page_dirty() when marking a page
   dirty after writing back SNP firmware's desired CPUID state to userspace.
   Using set_page_dirty() is unsafe if the page/folio isn't locked (as pointed
   out by its function comment's big DANGER warning, which no one reads given
   the number of bugs of this exact nature).

 - When checking for an MMIO generation match, use the memslots for the current
   vCPU context (non-SMM vs. SMM), as a misbehaving guest can coerce KVM into
   incorrectly identifying a write as MMIO in order to bypass KVM's
   write-tracking.

----------------------------------------------------------------
Jann Horn (1):
      KVM: SEV: Fix page dirtying in sev_gmem_post_populate()

Jinu Kim (1):
      KVM: x86: Use active memslots for the per-vCPU MMIO cache

Naveen N Rao (AMD) (1):
      KVM: SVM: Clear AVIC Physical ID table entry if vCPU creation fails

Sean Christopherson (2):
      KVM: SVM: Add paranoid helper for checking if vCPU is AVIC-addressable
      KVM: SVM: Use "is AVIC-addressable" helper to sanity check load()/put()

 arch/x86/kvm/svm/avic.c | 22 ++++++++++++++++------
 arch/x86/kvm/svm/sev.c  |  2 +-
 arch/x86/kvm/svm/svm.c  |  6 +++++-
 arch/x86/kvm/svm/svm.h  |  1 +
 arch/x86/kvm/x86.h      |  4 ++--
 5 files changed, 25 insertions(+), 10 deletions(-)
