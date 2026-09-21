Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A64A31F986
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025372; cv=none; b=BShVPCyyLR7AhRvuf3L7TqZYuYLOQZFHISBPCBW78wM8fHSvOJlTU9vsVWSxOHg3iiKYjqnWWCfDBj15q7zBNLzdqPSy+4RyxUz43OyAtwk/p9XKxoA0NKF/dLdn/of11kiwdX/LGG7j6rpKx70IPCnrUft5hQ1L4aXHnsaJ9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025372; c=relaxed/simple;
	bh=2B9Jtu3Xm+xPmtxCAMZ3/a/KLxuQpwi4aHU8hpuTsrw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dP7XKajCZFFoc1lTApTuJb8u2uT8WlN6oMqQq2wOgDQbtrawyBaFOiCBVeyh79dtwZHHGMMIvcuLpz527zg1Go2dFQpgJXCMejWJoB0k9XNo6wjNmDpnO8Q0YZkoLb1L2bdFRfo+T1giP9QYD7CgB5CEbeJn+6E8ZjOvmbOja+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uFAD0ocF; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uFAD0ocF"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-854f274dd69so3515338b3a.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790025371; x=1790630171; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n/Pv1RISzwI+jWTE+P0Nc31p7KJ4QnlTFUDF+YmmZBw=;
        b=uFAD0ocFEaFvY7BRyJDTJIB6Ny07XjYwlq8jZmUwtku7pZsCPVkPr0jEXIh5heyhOg
         oxCb7agpaKGevGC9990FfSo9pHbNcQpsg56gfKmqDIKxqukUcup5b+8cKs1rJtmdgrxJ
         q1TLP3sNiR/6WyoL4L+DEq6ywMgJkSZSXzJk6mMIUSfJ8C35m0U9Ye4CiqVJx+DbqWQ/
         Qi6sxO4qQ+T0RhFPfxr6TkeG1v6cFqJCyBAeCShMclngt9VP3E37/zfLsJe4iaEQlUZM
         t8jXWk6wLYZMdLyYFCxEJnbK6/E270ThR3/Xm3sVnpU9wb5y4WDW3XdlCdnZOfjxL7iA
         rcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790025371; x=1790630171;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n/Pv1RISzwI+jWTE+P0Nc31p7KJ4QnlTFUDF+YmmZBw=;
        b=ZVg/RUVgcgw9eujXBGCaA29zG/crJxbW/r5q7zPij5afSVytIXGBG8//UitqOyjY+A
         LLBDAirC6xb5h9P/+oou7K3fKsDiWizEr3IdtPN8okmkFVw0O7i0Va/LMHD19DnRWqA9
         ST0DuM67dHxTkxcxu2dRhCtTBiI3Gm2GoCAq+4duIRCOzDORFyrgxhhVSDqJU3Jdh9vR
         BHVKKrbzOf9OEgpcgYb+1euOUXQQmuV5ujDW7UJBoF9QPIQxtplc0HnPPBYqKZ8HddeU
         nQEEU/CyjkbeSUHLytZ0EuvgWQG+FqAM01TdYM9lsYkbRGLqLBI5qYgJH0k5jDXY5W7/
         xF2Q==
X-Gm-Message-State: AFuF++mknlLyc4g9fEqOgKtPxfNRez2cwwws8cWOhkI6O5ykh6Iz72ts
	QGAHshHFvF8nbpe/ZkmcdlYIelRUtAi9lpyN6eZ3aX4cC2BahcL3rNK9siNer5k0TvN3T6CAfNR
	D6zFtvA==
X-Received: from pfbfs7.prod.google.com ([2002:a05:6a00:8187:b0:874:467c:2cd9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22c7:b0:874:708d:b632
 with SMTP id d2e1a72fcca58-874df10529dmr15760385b3a.30.1790025370481; Mon, 21
 Sep 2026 14:16:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 14:16:06 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921211608.1030158-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: x86: Ensure userspace can't run L2 with stale PFNs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jinwoo Lee <rkskek9254@gmail.com>, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a class of bugs where KVM (a) lets userspace run L2 with potentially stale
PFNs and (b) fails to set kvm_run appropriately and so could unintentionally
cause a well-behaved VMM to run afoul of (a).

v2:
 - Re-pend KVM_REQ_GET_NESTED_STATE_PAGES in the common vcpu_enter_guest()
   path.
 - Fix the kvm_run bug(s).

v1: https://lore.kernel.org/all/20260813043932.3214460-1-rkskek9254@gmail.com

Sean Christopherson (2):
  KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails
  KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages()
    error paths

 arch/x86/kvm/svm/nested.c |  7 +------
 arch/x86/kvm/vmx/nested.c | 15 +++++----------
 arch/x86/kvm/x86.c        |  4 ++++
 3 files changed, 10 insertions(+), 16 deletions(-)


base-commit: 70c944caf570fda2d79baa71435589a8db39f048
-- 
2.55.0.1082.g2b9226bbc0-goog

