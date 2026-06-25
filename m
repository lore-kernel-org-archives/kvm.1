Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D538436EAAB
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425378; cv=none; b=grX87U4XVY64JSwNuGrsIKu077tqLMLXwPJGhH1hfyssYBoGoHxxvJJfBOHX1bGVEVrxkKwNo0mDS3K1TqvYaAyGlpNuuAvVS5bsxNjSy051KLlY6r6naZxmsOCg71STlawV1TXVxgkFA5WQ0bpFgfrupkMccQj880RcBIkOD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425378; c=relaxed/simple;
	bh=4fuf7qGYrC3yPo81YZemsSWXTRy04yiF7LGS2CT10EU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LuHQ0g7xUY+Wv3x/GyjdT74nMFzy+UCcUZNvOP3ZpxNFMC/OVY+UNK5uTVSF7p+Uf9JzSJsvEzJDP7e/l/NuX6uZGXN+yQQPfb9iwnI5sDesJx01gwEeONMKbsoaczsF3rhbLXaoC7RS1cs+SFgqy02ie2pluvsEGkB7A8Mt79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i8Z3VEjQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i8Z3VEjQ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c816b8b4dbso565825ad.2
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782425375; x=1783030175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NObII2noNO0UIUH5NgoGRFqHrpOKFJqLgtTJtdpgNTU=;
        b=i8Z3VEjQkittp5kCpPwpaOD4n+RonomYYol6ViY1yr43kbooGpDF/0xZ5Ebjrqka7E
         SQcyJG0lPiwLq6r1DJ72gr/mufQV7H2bwu4OGGbuhXT+EDTVE2CyBOfR8hJqTOHjvMu4
         su1JEzKi/XYtD/AB474wZrnbtybxDACh7+mK935H5HpLDHDmWeTD+mwR8KqU1YXJEvQ3
         6hPAywRvdgKkck7biagNxs6xxtkgAwEFEFrakTuoINENuJPEnfUHwGOmavwLBeQtK2z9
         Uzi0HgUA0NJs7SPAe+6PnZeDlx+mmBajVY5Joy9fCvPDU6l6QPY+34Np13qvgVI1lDLo
         uQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782425375; x=1783030175;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NObII2noNO0UIUH5NgoGRFqHrpOKFJqLgtTJtdpgNTU=;
        b=Y68qHq1lKQUbxOY+CZQn6qlWjLb5EGaClwf1ixxL/v72td0R0pvEHCMryRFDn4fogA
         nqQvuzI0XXMt290Ap5vLaGNqnRAw4P27Y/JjTF4A/jEUpIQkPFqG96/8vSnvrEIarQtT
         yznV4V6HvZuqu8bgh2JM3eFvYzLQLU8la8RNANT3hysJkvuI/KwHXXruDRJ/9ezHJZxL
         GGDwXaXh250s3sBASUhJVyO5OODAWirRkUaZtks0DAzDuqxx2cZtxc2C6Pm9od/NK1jo
         SaIsGm2EAyndKoyznlLwswnuTswGs7/D56R2DnEYR+w2Jq3uqTBR6mNzUV5IovFRu892
         Nc5A==
X-Gm-Message-State: AOJu0Yz86mJLTkz+i1PTXfioc/Z/ADQePi0IZUML4c81Renbh1QM7KhP
	M9gvIyhjGKHvIw+Ss5u40Sz0QVUDGC5HYen8AogRrttgFm4xjxOLnxduXO0gaJJB6DamMANHmML
	6cX5x8w==
X-Received: from plhc6.prod.google.com ([2002:a17:903:2346:b0:2c7:bbd8:d3a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc47:b0:2c6:abaf:85fb
 with SMTP id d9443c01a7336-2c7fc890a70mr37327305ad.32.1782425374928; Thu, 25
 Jun 2026 15:09:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:09:31 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625220933.3357733-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: SVM: Fix a (very) unlikely UAF for GA Log IRQs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Fix a potential UAF due to freeing vCPUs while they're still reachable through
the global hashed list used to handle GA Log notifications.

Sean Christopherson (2):
  KVM: SVM: Remove VM from the GA Log notifier list before VM
    destruction
  KVM: SVM: Drop unnecessary avic_vm_destroy() call on init failure

 arch/x86/kvm/svm/avic.c | 22 +++++++++++-----------
 arch/x86/kvm/svm/svm.c  |  2 ++
 arch/x86/kvm/svm/svm.h  |  1 +
 3 files changed, 14 insertions(+), 11 deletions(-)


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.rc0.799.gd6f94ed593-goog

