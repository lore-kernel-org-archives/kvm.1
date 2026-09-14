Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89CB26AE5
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409548; cv=none; b=aOH+UFML0c/Urwcmf9R5pEV3oqO4OD1+l55Ei40cJCsfn10MxwT5Yf2sPBoHOGaBsgtNi4qpi2Je8SaJ5t9QERLNROvBqDNEb9p+RvOECF61caae3NKAgJyOZMHPZkO60mDlS7E0sfTdcHdTF7dpbjoL3+dnTrUtga6FKi+0wYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409548; c=relaxed/simple;
	bh=oMTZ9YvcEuKXd0sl7DDBeFtBmc/anZPmbkoPjf35IR4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YqhjliaBf2MKPb+WHknybwf8In+LXIE6pRRHq3HbWIcZ6Qfm+tHOX5AyfhRYGgbo50OnQUvRcyKcB4sM7p8G/4dAcVLl1tBufzo9a0jjke57QXUGE437aa9He2uau4P3st5RZRBzgGHKnbXn2uCvAJn7AtX7n4Qt/1DXoAs/rTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+CpB40X; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+CpB40X"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8696b921ac0so5704328b3a.3
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789409545; x=1790014345; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rezP5mZjrm8YvaUHW4XPpmjPXDEBq3PqpAphWhmwTuw=;
        b=Y+CpB40XPIifLqi6oWtJWAPL0U5SOBItN90YF84ipPvi/GrIKDPH1l5X1Mj0wppn6m
         KejLUtrKhOiCSaUR/2oxhk/KNMv/QB/0FFm2wWY9l1tPhPdaDMa5U1bY+FYZgo2HIM2b
         oBbMAv2Wx7QUNx3K5C9EaWdvxcCCkkWBY/nbRg3RGvspk+iL5xGzRpZ7lBQ206SHdxDk
         tW8I1oyBDWnUndwJmldSvdO2msNBO9bRKnk2gZfGT8i3+XazEi8WRA+i4OGsmHBdhFBd
         rYM4nRPcipi8RrsqSx0zHkudZ7LJOOJGw5HJZTwBhBHTA+M2JCbKtJ5g6vim+r61n3hV
         KHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789409545; x=1790014345;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rezP5mZjrm8YvaUHW4XPpmjPXDEBq3PqpAphWhmwTuw=;
        b=QHwZmss0xUk8NnOB2H+DONcTntm2x36P9hNG0mXfja3s8KQzk/Nr4X8qP4WRMOjJuq
         gh+YZMHfSkINt+WYLD8KOBF7G5xj/J8cD3oTHE1o7dnmazOFXGqlKbIphaB3ycglZuoW
         qj+UoLvtg98bqQ1Dh72QgWceoJ62U96SM5b7xr19N6hlXrjpAxsMGCnLsHTu6u99osTq
         xfKv6mmR6nqsbZ55Ia7+aB98f1IYQ8HzoyVyJpMuBaT2HLM7tYPMaVN2iN8jx14n96og
         XunLtcPhuf+X+Ulax7ZXEiWTLJc3XdieiaPmY/FRtSlJiQkuRb0Q5Q5IqVg+TASeshR+
         lp0A==
X-Gm-Message-State: AFuF++neUSq8PRCKCXJHLfGQ5q/D5z6XkB+cfzM8hbeJ7pRJlK+7980X
	jI0Ae3e9Uf9Xpc+rujTuh858X3JJ0A0x4UqD6JXv0+SYOmI5ofy1CqXirWvNJ/hWgFk+O7Jf9CX
	1Crk80Q==
X-Received: from pfblr20.prod.google.com ([2002:a05:6a00:7394:b0:84f:b437:398d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:438d:b0:86c:bf42:fa46
 with SMTP id d2e1a72fcca58-86f8510477amr7798678b3a.12.1789409544739; Mon, 14
 Sep 2026 11:12:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 14 Sep 2026 11:12:18 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260914181223.289061-1-seanjc@google.com>
Subject: [PATCH 0/5] KVM: Serialize vCPU creation and revert vcpu_ids tracking
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, 
	"=?UTF-8?q?Pawe=C5=82=20S?=" <spawel523@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Serialize vCPU creation by holding kvm->lock for the entirety of
kvm_vm_ioctl_create_vcpu(), and then revert the now-redundant tracking adding
by commit 97d65b544f48 ("KVM: Check for duplicate vcpu_id as early as
possible").  I botched the math when justifying the vcpu_ids tracking; it's not
an extra 256 bytes, it's an extra 2048 bytes.  Roughly doubling the size of
"struct kvm" tripped x86's KVM_SANITY_CHECK_VM_STRUCT_SIZE, and obviously isn't
something we want to do in general.

The TL;DR of why it's a-ok to serialize vCPU creation is that no VMM actually
does parallel vCPU creation.  As with so many things, KVM's current behavior is
the result of decades-old cruft, not intentional, deliberate design.

Patch 1 is a tangentially related bug fix; I included it here because holding
kvm->lock for all of vCPU creation allows WARNing if KVM attempts to lock all
vCPUs if vCPU creation is in-progress (the caller is must hold kvm->lock).

Sean Christopherson (5):
  KVM: Reject attempts to lock all vCPUs if vCPU creation is in-progress
  KVM: Protect all of kvm_vm_ioctl_create_vcpu() with kvm->lock
  KVM: Move check for existing vCPU ID to the top of vCPU creation
  Revert "KVM: Check for duplicate vcpu_id as early as possible"
  KVM: WARN if vCPU creation is in-progress when locking all vCPUs

 arch/x86/kvm/svm/sev.c   | 10 ----------
 arch/x86/kvm/vmx/tdx.c   |  5 -----
 include/linux/kvm_host.h |  1 -
 virt/kvm/kvm_main.c      | 35 +++++++++++------------------------
 4 files changed, 11 insertions(+), 40 deletions(-)


base-commit: d599822bdb66aeec5ec76297b0fc6efaaeefe07c
-- 
2.55.0.1032.g73a4cd73de-goog

