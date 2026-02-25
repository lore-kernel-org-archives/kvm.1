Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329781D5ABA
	for <kvm@vger.kernel.org>; Wed, 25 Feb 2026 01:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982454; cv=none; b=FNlLt29Xzf+7tBzNjyVKBFPypK87Ep46gytAo4Rh5Sq+OTy8+8j386+cuOQZEY9AxxBxbPy8+d4bnzV5UYbY19ykXnKieGJnyS6N8dkDE/4HeNMlSUVzw64Ankn9yJZb+0wPa390gu10A3wiLelM/s9d5hKkCSqDQ+bOLj1Re2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982454; c=relaxed/simple;
	bh=rIfQEdmFShSU/hfE1nBXkImYGxL0rG4etafqHLncUjo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MINevDEP5nqV7M/h/05TUURR5eEW4MWaWjC3Jg14XKucn9toWmPCnpfWM6rcdwpv44y+9rHgqDDqkWhy9FcC0rA+Yi50Y/PQ3Nzo1PchD7G3bJe1ggcYFkBsena0ubBiDX7PGumFGQ7ix5OKY//yQToJFEqvnLmzZqBryR+njEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XuKtMXMQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XuKtMXMQ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aad5fec175so252239655ad.2
        for <kvm@vger.kernel.org>; Tue, 24 Feb 2026 17:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771982451; x=1772587251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOLZOHpBY9NF13p+U0yWvHRv6RzqdAH2//7LWxAyLYY=;
        b=XuKtMXMQwuVDzVaWSYxnAXUr6jccZO2UaPmziJ6ViqqfGs4/P2dHtWCbgtGn4HKAyT
         lmccF9wDbyWY5ZQXlCLnQyBzncFufagqFaantTufcq2rljmOGDnb299Tv227WOjv7Bi7
         KhlQifaqKy23q/Nx9BJbk1IOpnu9sOkna1uTN7lFYdSpoVEAKoo9/XdTHDsA1S5FDnla
         A211k5SwS1lLv9RHUhAeOmZ6orxE5Q/hmf7KSSq0kIbHFl2nMG5vKVj9Gyykimi5etW9
         sKM/hVoKMNb4WN7PJKNaHUqe7QYuQyF7iIPnCCiBfAcwLixB98NBOlC/6ifXm7TZgVyf
         CPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771982451; x=1772587251;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOLZOHpBY9NF13p+U0yWvHRv6RzqdAH2//7LWxAyLYY=;
        b=YNrW0svb9o6F37myGIws5yF7mT+Tiw44Z0Vq93JlYu+6sv2bspMG5yqI/9LEFCDVgJ
         9v5Ou11J7jgcwkWXCGJuhDAgwdkGYJAa3kQGDmRTmszj4RwDdTWnCVQPBO9+K+AEmNSr
         6Tu2FeUWGb/jiaS5csmGItXzdJqiBAQM7D3O+1nGYEN9MqQFWQYvhEvefWYxsRffHKyM
         wsEG0vK7tMfx1wUMojVjBiByxTjkGxLurWX/R3KefKPcSkxpuxedF6NFH7/xL1B94fj6
         FAcoFfaw0yKZzoADltExBbnZL8HCnTbIbnZFcobhsGur1M28afNCjyalaOHjCbMEB1vi
         owQw==
X-Gm-Message-State: AOJu0Yx0dS3GJvvSe6smHsZ5wxpiAfys5T75mQDS5XpaZQHU0S3o+dS9
	v53mCkrm3nSuotYpe+bj8kEXHEQTJ2Hvi4YvDEojrQFIxCAveafWG9arVr6BSN3+yTTi0t/+F2y
	3ECamEQ==
X-Received: from plct10.prod.google.com ([2002:a17:902:d28a:b0:2a9:8200:498b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c7:b0:2a9:47d0:12cf
 with SMTP id d9443c01a7336-2ad743fbdf1mr128338145ad.4.1771982451342; Tue, 24
 Feb 2026 17:20:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 24 Feb 2026 17:20:35 -0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225012049.920665-1-seanjc@google.com>
Subject: [PATCH 00/14] KVM: x86: Emulator MMIO fix and cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yashu Zhang <zhangjiaji1@huawei.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"

Fix a UAF stack bug where KVM references a stack pointer around an exit to
userspace, and then clean up the related code to try to make it easier to
maintain (not necessarily "easy", but "easier").

The SEV-ES and TDX changes are compile-tested only.

Sean Christopherson (14):
  KVM: x86: Use scratch field in MMIO fragment to hold small write
    values
  KVM: x86: Open code handling of completed MMIO reads in
    emulator_read_write()
  KVM: x86: Trace unsatisfied MMIO reads on a per-page basis
  KVM: x86: Use local MMIO fragment variable to clean up
    emulator_read_write()
  KVM: x86: Open code read vs. write userspace MMIO exits in
    emulator_read_write()
  KVM: x86: Move MMIO write tracing into vcpu_mmio_write()
  KVM: x86: Harden SEV-ES MMIO against on-stack use-after-free
  KVM: x86: Dedup kvm_sev_es_mmio_{read,write}()
  KVM: x86: Consolidate SEV-ES MMIO emulation into a single public API
  KVM: x86: Bury emulator read/write ops in
    emulator_{read,write}_emulated()
  KVM: x86: Fold emulator_write_phys() into write_emulate()
  KVM: x86: Rename .read_write_emulate() to .read_write_guest()
  KVM: x86: Don't panic the kernel if completing userspace I/O / MMIO
    goes sideways
  KVM: x86: Add helpers to prepare kvm_run for userspace MMIO exit

 arch/x86/include/asm/kvm_host.h |   3 -
 arch/x86/kvm/emulate.c          |  13 ++
 arch/x86/kvm/svm/sev.c          |  20 +--
 arch/x86/kvm/vmx/tdx.c          |  14 +-
 arch/x86/kvm/x86.c              | 287 ++++++++++++++------------------
 arch/x86/kvm/x86.h              |  30 +++-
 include/linux/kvm_host.h        |   3 +-
 7 files changed, 178 insertions(+), 192 deletions(-)


base-commit: 183bb0ce8c77b0fd1fb25874112bc8751a461e49
-- 
2.53.0.414.gf7e9f6c205-goog

