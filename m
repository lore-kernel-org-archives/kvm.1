Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E79340403
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681580; cv=none; b=iuYVTH/PNp6oGOcVYn790HRnhgnTVbc4u+v6G8WTYWFbUg8pY6dWtofMp6cNNziR80H3XySCrNSq1qka1UTtB63Cuz2Eyu8bnaMLddlUkIKuWgXap5T43kBV5tqOPjQik9wi6HoHsyXdJkQ6G0jJu9b01golipiIemuDXS8odCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681580; c=relaxed/simple;
	bh=zj5FTTYykEKlVbFMcvZJ/Qz7wJTK3Bxldeavag57v/I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QqcmMap1J+JNr3jfxxbxGPf4AcjUKpuunW1v4tpG6M/0NHGAgxADq3+//f58zg29tOrie4MDJWrEdyzomYTB7zkokPIHn/eeRGVWdxTUmFWA5OvxBtYWadAx6X0fJlhDCx1D+obcnb/zB5GZ1EhDyN6CTCqgYCDv2q8kgQ9eJ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJDGBYeS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJDGBYeS"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf2bc4371bso23142885ad.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780681574; x=1781286374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CU0M+d7o5scw842B6Rv3okGY/Zxdz96D5z3AKtUE3Mg=;
        b=bJDGBYeS7mALJ9v7ldAvsE7rU/gBi/TgJmYcSC00ppo7+1KjtyDhBIJRpeoqNTmmmR
         8Uqv3hzNVF5h9bssfwaq6Ocz/2xm56HeXQadTatKcU8I19UVL//7qjryzo2FiHjxQi7g
         dl4mahcw8CpeQqW9hY0KxxVUWECEsbQM0hhousIHPLeaa9b8Y4/HKnFOGAEqQXoYOwUH
         Ov5r2y3AFzYqALc/tFT7KGjfIHe5oxCiC1EEbyp8P4WxH/g3lUVgzbTNanciYQSY+Ern
         gtfoV0BFvxGztC/aRfdcYMl2SglN8CEFNSpMGbfx7negYxuJDknkxXKfMIUGgm0dzRlK
         tPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681574; x=1781286374;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CU0M+d7o5scw842B6Rv3okGY/Zxdz96D5z3AKtUE3Mg=;
        b=f7WojT26KUEkmRYqXYHXVV73GraSHSX920zrJskugSULv9W5RHeVHCWPoPyjmNg1dU
         +RPe68hN7F/298myjsBCA24PQyAMjmNkaJDf13nYP3KLm8LZLN6jCbFPUR2wj0T52xv4
         Z6m6MyygASyLbNp19AF2KXkBQFHMPbXl0CW7Eck/z7/yxqxHvMJR/lFHnBQM1efAa7k4
         Ky+uHfUM+wDpTUBMB54+ZahhqVCRX0zA3XQ4QKjdqGcTpr6nAzvTA/SjuXvSlR+szw1e
         +zkb1rpF+mzTSK9D4G2mZwdurYu4dZN74LH0eZRnLQWArn5oaM06F54ReqybX4iNnh/8
         0Qzg==
X-Gm-Message-State: AOJu0YyutNcS3Ak27ZFADPzJU62EAOqygo2+hluK6etjlPl81B2R59Qb
	iNzYCEOejUkzS9TzYBarqn8nrmRrxO8CxG3W6fN/lcGm/rSMOr7azL1cYPMhGMaqyQ18i94XoLa
	UnhPqkw==
X-Received: from plte9.prod.google.com ([2002:a17:902:7449:b0:2b0:ae36:890])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8cc:b0:2c1:6ed:513b
 with SMTP id d9443c01a7336-2c1ec94d1a6mr38710185ad.16.1780681573617; Fri, 05
 Jun 2026 10:46:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Jun 2026 10:46:09 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605174611.2222504-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: x86/mmu: Plug an unsync shadow page leak
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Recursively zap orphaned nested TDP shadow pages on emulated writes, not just
when the parent is being fully zapped, to plug an unsync shadow page leak if
the L1 hypervisor zaps bottom-up instead of top-down, as KVM's TDP MMU has
done since commit 8ca983631f3c ("KVM: x86/mmu: Zap invalidated TDP MMU roots
at 4KiB granularity").

Gory details in patch 1.  Patch 2 adds a stat that, very thankfully, we more
or less have in our internal kernels, and without which, diagnosing the bug
would have been much more difficult.

Sean Christopherson (2):
  KVM: x86/mmu: Recursively zap orphaned nested TDP shadow pages on
    emulated writes
  KVM: x86/mmu: Expose number of shadow MMU shadow pages as a stat

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/mmu/mmu.c          | 16 ++++++++--------
 arch/x86/kvm/mmu/mmutrace.h     |  2 +-
 arch/x86/kvm/x86.c              |  1 +
 4 files changed, 11 insertions(+), 9 deletions(-)


base-commit: d4bfaa66fa171089b9b9fb2dc17af9245f2b9b34
-- 
2.54.0.1032.g2f8565e1d1-goog

