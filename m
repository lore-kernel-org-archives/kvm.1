Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C92D97AA
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 02:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779934281; cv=none; b=Atzq0RwJTMKGJVUQsPFhsjE8WlFM8sHu1ZfNN0P8ZxB4ZtFSuOWtY7QG6zez5/Ul928Hx6/ysB82tVQLBGRdu0No1zi56e0FXwjBSbZMBJzXvUh2Of1nH0FASOpX4GAxbpPG5QMZvEJmXaeMr4/MXT9g8h/PG+aDTWEfYvuxcJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779934281; c=relaxed/simple;
	bh=zu9tC4dLTq5vhYKmYNY1qmG/fVAVq9UjzeXLethNBf4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kbaAUQNRq1+tdFFZ+6vK2dKiAX/kEjykZz2UceEjPr9EI/mXyMXS2DE/kcKu5IzpukXyilasKhqgScID//FUYxhGktK6dlk5eSL2TfuUEcWJYrwZGjerBrP/Ga+imDWb+07Wph2WVbCO/5Oawd6sxtHH9vIx4qJyMX2qWZonTik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rj4vfzN1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rj4vfzN1"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2beb9002a00so51792965ad.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 19:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779934279; x=1780539079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Osslh/NSDWF9wssUZFP0lnMjWL7+sALKmBd0xwVb7o=;
        b=rj4vfzN1VxZ1Mvvj62Pno0fXLJBra3DmvW/qKDPSkiFrK9ONbUI77qm1nmgKaYD5+O
         +Sm2a746motLXX+6KVNRytlIv66uifzL72Jfxt4FUF5WVK9oBqOw9MC2bQH8wt+BLlzN
         6P3wO6BEvA1/NOI29FU8V8wD43iVoldykwAkChFuUSJGz2cDHt1Sdo710CePGeifGz+V
         ZrOwxHCguxl2an5K6yjQ/LrKU5pP13AtTx46kUjQqCXj52ZxKrilxfyWP1eIaoviR08R
         wxIW2em9xsiLD7bZqqWSnRU/DJaPFKIbSVrq8qGNjsSXr8reHb4cA3Y4Z3l/BSaDnoZl
         euIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779934279; x=1780539079;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Osslh/NSDWF9wssUZFP0lnMjWL7+sALKmBd0xwVb7o=;
        b=mZ63W8cCNoKC0hbPfzLcjdZ/Bx2kbKeR8nRql7vbUbi0SWk0zrzdFycnUJHqLVcVXs
         wx461sMD3Tr/VLo2pEkC1KCJcJt49UGNVCoWtgwRPPF2/6LJrfSkpAlXw/7SijDJxuyu
         f0W/kTefQBRkAt5NfgqpjskA51gqYuFpaF1OLODBUGRvMKnHxOuoutIweduQJvC03eI5
         2s14YZeZAefW4x+W182rTPFHLlc5wu6DCDEomW5pBb/Hnyd6Tnr7XS3qKyqqlHYgtTdF
         Nd4JH36uzNC7OQaBwESSbH8mcqtRm8Lx96vn6WgkhUp6287brGX4mWDFVR1BRmE/jFsM
         FIhA==
X-Gm-Message-State: AOJu0YzzinXTywUOWwS+q/Vpnlbf2ZsZ8UOevGCWCRgfodl1kKlqaaCx
	Lr0XMR6HO3wSH6blf1TIDT4NKmJaKQ9bE/iz0E+9HgcwQ4QVjNoNrj+nvkEuenYev5jz0xCpES2
	hzpCaoQ==
X-Received: from plky7.prod.google.com ([2002:a17:902:7007:b0:2bd:9a1:9a05])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c6b:b0:2ae:450c:951e
 with SMTP id d9443c01a7336-2beb070376fmr275589015ad.17.1779934278864; Wed, 27
 May 2026 19:11:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 May 2026 19:11:14 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260528021117.107984-1-seanjc@google.com>
Subject: [PATCH v3 0/3] KVM: guest_memfd: Fix signed offset+size goof
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a bug where KVM fails to reject a comically large offset into guest_memfd
if offset+size results in a signed, negative value.  Add a testcase to prove
the bug, and to serve as a regression test.

Note, v1 and v2 was part of larger series.

v3:
 - Use uoff_t, not u64. [the combined might of Sean and Ackerley]
 - Explaining exactly what is broken. [Ackerley]
 - Add a regression test.

v2: https://lore.kernel.org/all/20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com
v1: https://lore.kernel.org/r/20260522-fix-sev-gmem-post-populate-v1-0-9fc8d6437b65@google.com

Sean Christopherson (3):
  KVM: guest_memfd: Treat memslot binding offset+size as unsigned values
  KVM: selftests: Expand the guest_memfd test macros to allow passing
    the VM
  KVM: selftests: Add guest_memfd regression test signed offset+size bug

 .../testing/selftests/kvm/guest_memfd_test.c  | 24 +++++++++++++++++--
 virt/kvm/guest_memfd.c                        |  8 +++----
 virt/kvm/kvm_mm.h                             |  7 ++++--
 3 files changed, 31 insertions(+), 8 deletions(-)


base-commit: 9f2a49c511cb05b85745e1578e4fd425bff87f58
-- 
2.54.0.794.g4f17f83d09-goog

