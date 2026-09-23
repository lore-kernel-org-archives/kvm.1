Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9686C496D49
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181459; cv=none; b=pcZx0i/7DqDzR5oL6zoK7qeV+xx1iK5GMFURmpEBYObRsHUT3V1/BdXI1BfaHlibTe62aRf6NK9a92ig9Wwc5Mwi9aGtFROx4oOIK6EzImpC6gcJpsUIS/L/OZD3kXKYdz0BuekMrlJe1CbHSU2D66wsd028Ke/QZphVrEeA0+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181459; c=relaxed/simple;
	bh=QC2cfQtOr3mgwhs8Ewza8183LqZIUPFCL0wxrCHdNlQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Sp0IgqBx0FVcquoY1Ihm2jowLEpfSY7xex0jmDoOnQjGgQFEfYJx2GvfEtPT4yr53CC+q7SROHD7mUO8M/m57Dh6e56uaGRhS8M6m/NbfxRLqxNbvhy5RwnvdJD12PctoDV5zxxWHfYsE22s5l9nMB5fwl4tocKeSlFEIrEF0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oBq9D0Ld; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oBq9D0Ld"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d94f086fedso10596895ad.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 09:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790181443; x=1790786243; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Db4OSh1pbWLsHf6Y89zz48nYvEY5ZVSH6l1sOo99aqg=;
        b=oBq9D0LdjtVIgRrqgRoeNbMRVYicZkQzViH9nvyrsNVCx9Jd8P1GRGSc8kZF9Ntj2A
         tvjwF+xJDJCa6tDfzJrc3zolQjziqAdcsyisJiUIVN7Vr8azfe6bmBi/7rQmO9XZZOw4
         rSypDh829PQOpoW3CROjqcYTAhH8slA9mv3J0k9ZQ7/UxKxBxlkSHsT/pQv/x8OMI5AU
         UGO4Z7Q7BF5caiZrwzOViHH/4eHnLjV7vlLhAw7i/Bbvrkwd2ygArulxcFH9IVoFyNBm
         L/dmEasNXqyJiosGu4h+ybbMiffZlqqQ+k2f7iapOFcmeMGvIV8v24iuOuLZK9xn0YVs
         Z2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181443; x=1790786243;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Db4OSh1pbWLsHf6Y89zz48nYvEY5ZVSH6l1sOo99aqg=;
        b=q9gjJ6kfkclO1xS2H6GSAWDWrp8t9OVEmPiY6B//GT8bi4ht42JviaRKRHnNUN4jzi
         DMSTQpk7++QAfLGgj2y4ive3fE2STfPyJyxLMmYObu0vfBKovZREoy+FfxsGDbS+Tsqm
         hMCNMsxd7P7BS55mpynTd1BpcG8WUMZFmZvGAbEakxgs+HF+Kuc3neDA9r5DiClAqn/H
         tD66ktwcbneRwIzjRhXrjIMVfkhpLdnFFx1t+918iv5cWZuBl/wsnIPALCPEZR1075ww
         YupIndpHFPUix6rm7XJqL2ftsFiPQkrPKRGKb6s8R8SC+aHecu422mdeZ2H30DvyiRWz
         qcbw==
X-Gm-Message-State: AFuF++mGiqhYsxqwEYnwoTvQontHwAWkwqzPi4sY4U4HmFaLKU9njmCG
	BCidDmGXffdElXFkhcC9c71qFwbgoIFFfOXL2qRUf2K/OJCLhg6KXXz10HmUTg/WpwFLXCJFuEH
	KkdPYGA==
X-Received: from pltt17.prod.google.com ([2002:a17:902:d151:b0:2df:4d8a:26b7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc85:b0:2dd:c053:ec74
 with SMTP id d9443c01a7336-2df69dc7525mr28181045ad.39.1790181442700; Wed, 23
 Sep 2026 09:37:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 23 Sep 2026 09:37:19 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923163721.1584779-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: SEV: Fix intra-host migration cache bugs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a memory leak and a cache maintenance issue related to doing intra-host
migration on an SEV guest.  TL;DR: the source VM becomes a non-SEV guest after
intra-host migration, and so KVM fails to do the right thing because its cache
maintenance stuff keys off sev_guest().

Sean Christopherson (2):
  KVM: SEV: Free have_run_cpus during VM destruction even if VM is no
    longer SEV
  KVM: SEV: Do cache maintenance on the source VM during intra-host
    migration

 arch/x86/kvm/svm/sev.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)


base-commit: 30b5175943e709911702d8a9364145e911f57e3f
-- 
2.55.0.1082.g2b9226bbc0-goog

