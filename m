Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B79524F
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426155; cv=none; b=IYel4OOZZLcv3V32hpxTlkRVSVZEYKRX9pRdzSrxbDHKaVnd92sLbel3P5HlySys0fKKaenGVVTTk94ucqW5N+LDQCfz9W0LJeT5a2vqn8lPD0kjqt+Izep3iOVHmhSxVBVo/hSa0hXyXF8H4NdC28fWfkS9RJSXlEFtRak/LuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426155; c=relaxed/simple;
	bh=AanuNVc9DMW3JfMbmRkTuDJWY1EVVwkDfPAfoVSOeqA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=btnq37jI62y0FImPkJbQqPSO0yc6ppDk2bvoXxc8056wXbFTF0iqwbTSalolSCWY/iBHYUuCsgSEUpAZQUiPx2E9X47naHx/RNb5VgMJ6s5dU/YXDIRTjYjyqiFKOl0q2GUH4fI5SiZ2iXQIiInP0L48mqyZ1jvURl5h3HEn4o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pBXtz9NF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBXtz9NF"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-845a29d8c1eso157229b3a.2
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426152; x=1783030952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGRkfEyfwGoD+sZrm4UFt0uzcL48V1rz2GYoK4BhT/4=;
        b=pBXtz9NFy86CCl1+ARNUkB8g44s/fZkN51JqWadLz+OY8q/tMn7+xtwFn8nJoY6q+V
         qE3UKnBt9+VMPuJoiF6rct5xNRkc1w6lfd2HTXTpVrXhFtdSkQQcqRP1sydx5wnGNqSV
         mvRIZ3pQHaL9Mg7cM8GDh05iPe6EmqD7+IWUKuIUMYIaCMkKofsBIDui/AU/bjLTtmoi
         x+x/jiHeKCQf9AB5WIle1KiKR/CvdJLzfSJP79Jn8A+5ADKcf0ayahCU03RUqvbljfmX
         a7r+cKLq9RBHnMVis5IkL4+NNeUeT55cvuXJ0r6O5FzRtHedZUpnnIqXL8SPcTWCLzSi
         qJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426152; x=1783030952;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGRkfEyfwGoD+sZrm4UFt0uzcL48V1rz2GYoK4BhT/4=;
        b=bzi83ZGaWxzzEmef9/qBANX90A116vE2toKN5O3tgUxpWGt6v69yIRF4Z8Fe++1aR0
         /mOjHrLInDGa1KNUsYCzQtEwpyew8jLA8LbwL9Uy0Hq2sXr3txY6+IgKbRrGUyEYpJDh
         CrfcBpvH638OFyTsll3QucxU857Fa1VLBEmv7xVZrSr0G8MoSw/jeRz94CjU2nDCtiKE
         xiyFpZ3zaA/HkQxtxdrgj1EPmA100TuN9M34o3J2kofuygwKpkuw3lBB50OfDdNaegon
         Uxdb3/Gy/97QxveSo1tgR+ujuvVLVUkLGJIx7XUvJ1B8qhR5/oaMOwhFGLQA3di+h9JR
         +oVg==
X-Gm-Message-State: AOJu0YwCS+0imlP7aNo7MwAaVNPPfrRWWkdyT99QUEiUE+xHF38OPiPc
	ORW22+SisShlhHcOKnAcSSW5yUqXQ3E32Dwbm+9HoIsICXdh3DGTkowL+WmIbP7KIqweyngY3K2
	X3EO0tg==
X-Received: from pfbea13.prod.google.com ([2002:a05:6a00:4c0d:b0:845:c4b8:9730])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2187:b0:842:6849:2180
 with SMTP id d2e1a72fcca58-845b3ae2581mr5162951b3a.37.1782426152237; Thu, 25
 Jun 2026 15:22:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:22:22 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625222229.3367197-1-seanjc@google.com>
Subject: [PATCH 0/7] KVM: SEV: Fix RMP #PF due freeing in-use VMSA
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"

Rework KVM's handling of guest-provided (and always guest_memfd-backed) VMSAs
to forcefully reclaim VMSA pages when the pages are being freed from their
backing gmem instance, e.g. in response to PUNCH_HOLE.  In the worst case
scenario, marking the page SHARED in the RMP will fail due to the page being
IN_USE, ultimately leading to RMP #PF violations due to guest_memfd freeing
the memory back to the kernel while it's still assigned to a VM.

Note, the implementation nearly identical to that used by KVM for VMX's APIC
access page (which isn't guest controlled, but is migratable and whose PA is
shoved directly into a vCPU control structure).

Sean Christopherson (7):
  KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP
    guests
  KVM: SEV: Extract loading of guest-provided VMSA to a separate helper
  KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is unusable
  KVM: Rework .gmem_invalidate() into .gmem_free_folio()
  KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is
    zapped
  KVM: x86: Guard .gmem_prepare() declarations with
    HAVE_KVM_GMEM_PREPARE=y
  KVM: SEV: Mark vCPU has having guest-provided VMSA even if its invalid

 arch/x86/include/asm/kvm-x86-ops.h |   8 +-
 arch/x86/include/asm/kvm_host.h    |  10 +-
 arch/x86/kvm/svm/sev.c             | 152 +++++++++++++++++++++--------
 arch/x86/kvm/svm/svm.c             |   6 +-
 arch/x86/kvm/svm/svm.h             |   8 +-
 arch/x86/kvm/x86.c                 |  10 +-
 include/linux/kvm_host.h           |   3 +-
 virt/kvm/guest_memfd.c             |  17 +---
 8 files changed, 150 insertions(+), 64 deletions(-)


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.rc0.799.gd6f94ed593-goog

