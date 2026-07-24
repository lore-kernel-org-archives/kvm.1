Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30A1BF33
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854082; cv=none; b=Fr1yncOioAzmq2LXZ6DNw62kb7kgS7KI4jy5R17uLzvh/0Gn3PJEPiYw756cIzry6rn4y+eq41ZccZW8ocZED7lyw+59jnv/Jhh75rBKxm36eNJU0wlu9oKGE7ME8pZ1/LH6BByFKFWdwgTAagrmpqQ7FX2/bEJ66qQe7MoCePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854082; c=relaxed/simple;
	bh=upeoNjGANARKcbXzTfGCfmDFSpjdc66uF2LXohGIzMo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AsViPVdvnYHtqEWHG09Htkp6Z57bA4m1g3F2u3Mmpz9lL0ieDohuUjvcaS1SUh259v7OBDSorrF6ZAKXO5vbgVgAg6ESq5l+SJZ5CmodOVxbb+L6JZbFnV6cUny9f9mRzc2M7IFx3Qgnl+/I6nPDFxQozT+oRKImkazJ27iuMPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iY2LxLFu; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iY2LxLFu"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cee1ec30f2so16754725ad.3
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 17:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784854081; x=1785458881; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oC8miNtsbOCSUDu5oKXYgZACbFsZ70Mvq4+HrBNxgtc=;
        b=iY2LxLFuY2T3pzGGcUpd4yya0UCAQULNEEYkPXJOC/Rczr0c+47s3q9PK7xoWKKIpe
         elWYyfbptnGmBcHEk9mRCP0k0W7InvXYxMC/t/t9KZqLoEwZrykX0Uqf5AyVe5ClPRHW
         g5/LMrNbPIHFru9vY4/gO/xxWzAtWepi8vTf7styImMgpNZ8V11lGd+tV6CkppPYLbpV
         fkSz3DUaUTPNUbXPwJrSHWuCdU5/Pn3VzK86G9N6K8kKG+8oK3NvV1be9FM5OgLe7EkT
         bSACzrLH9BdgzQlUxP5qAgBQH3Kbx0x/dMOQKSvwlgN7Sm+oJE0i44oc5x5mwPNcUZ+1
         4K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854081; x=1785458881;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oC8miNtsbOCSUDu5oKXYgZACbFsZ70Mvq4+HrBNxgtc=;
        b=pHfX4XEmtTK2glg0Ff89di9yJyc5jkl4i+D4jj00eymGiT//ToSjbKyXVB5vwjaUN/
         Rbl0oxUUyNtzNgxUhstygcDEinTrgf8qwI0kBODKQVGaeHB28Y0b8EkypgU9YUQ16apI
         OOxTei7ubTl4phEUT9W1do2Tpya88TuPCgiLcoswrccTHQqq6duxCN5LPFP+CZDO0hhP
         1zYmCXxPxgjsQgWQs3uQPopOKMbP+zKt0/TJWEg+YECWT+f/gZ3kWqxla9Qf7nUK81HT
         XNbTRuIcNOqtq4vRf2bLImCGE2i2ChiW/8DJFd5vER4yFZ7feq4FBIlS5NEhglc8gLzt
         C5uw==
X-Forwarded-Encrypted: i=1; AHgh+Rp8VBHPcoe91A383FT2wCw66LdU0kpLeo/NyGs485xLkBTfzLtnJ0IM19JzuszHmraCnk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhAmSm1ZN5pdiSf8NyJgY5F9yCfY88izSCvp49OFCgf++QHht1
	XRr5Jv/cXkC0K1cU2z4+zeHLw44MCA9GKErZGs0ulI97ByP1mqROvnZQ1UyQncnJRK+EuRZIsze
	H8nApcw==
X-Received: from plte12.prod.google.com ([2002:a17:902:744c:b0:2cc:6815:446c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c7:b0:2c9:97a8:aff1
 with SMTP id d9443c01a7336-2cfa6f871abmr60493245ad.42.1784854080601; Thu, 23
 Jul 2026 17:48:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 17:47:51 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724004757.131420-1-seanjc@google.com>
Subject: [PATCH 0/6] KVM: Harden kvm_vcpu_map() usage against memory leaks
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Harden kvm_vcpu_map() usage against memory leaks by yelling if there's already
a valid mapping, and then unmapping the existing mapping before establishing a
new one.  To get there, add a CLASS() for local, on-stack usage, to guarantee
the map metadata is zero-initialized (well, so long as the CLASS() is used).

Prompted by 2f2312c422fd ("KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails
due to invalid guest state").

Patch 1 is related in that it's needed to avoid tripping the new WARN.

The PPC change is compile-tested only.

Sean Christopherson (6):
  KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is cleared on VM-Exit
  KVM: nSVM: Add CLASS()es for automagically handling local
    kvm_vcpu_map() usage
  KVM: nSVM: Use CLASS(kvm_vcpu_map_local) for SMM VMCB mappings
  KVM: nVMX: Use CLASS(kvm_vcpu_map_local_readonly) for MSR bitmap
    merging
  KVM: PPC: Use CLASS(kvm_vcpu_map_local_readonly) for patching dcbz
  KVM: Harden kvm_vcpu_map() against double-mapping and thus leaking
    references

 arch/powerpc/kvm/book3s_pr.c |  9 +++----
 arch/x86/kvm/svm/nested.c    | 18 ++++++--------
 arch/x86/kvm/svm/svm.c       | 46 +++++++++++++-----------------------
 arch/x86/kvm/vmx/nested.c    | 13 +++++-----
 include/linux/kvm_host.h     | 19 +++++++++++++++
 virt/kvm/kvm_main.c          |  3 +++
 6 files changed, 55 insertions(+), 53 deletions(-)


base-commit: 6bc96b971766fbbbbdd9fb2642cedacaf02da957
-- 
2.55.0.229.g6434b31f56-goog

