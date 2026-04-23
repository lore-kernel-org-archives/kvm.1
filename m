Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95531197B
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961592; cv=none; b=OeaCO5RIADNYJr/jB4IXDQzqaNCIRo6dDTw5EQYvYL49Wc5xyR7Ul3u8j03xgk2JJgvmVpSnc5e0dDYWd6TMtumRjPg6DS2vf7fsk30Zlmasa2xFBOWMoLt5V40SKb2pHyOY7xj4gKrSFHgbZWxjwAN99GFqlcUS7k3HxGee/hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961592; c=relaxed/simple;
	bh=2WHR07BM9YZMu9YXVW9q/VNkLnVamHMmal6QfJQU0zA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VFQzV8kGDUlns9vSXFXfIEyrcXPQUXxhvL57hy2xybrqMLrL+o6f3OAEexr64KAUZG+TdfHITatUT1AmW7oLKWXmmLJTS5xlSYsc8czVgbnc3rpYGtTuUXgjKunP0utchVPMvRs32jCKirK2iyIB82R0yh4cc88ZP+uDL41XRok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FHyrFvps; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FHyrFvps"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c799a65bad2so3232327a12.0
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776961590; x=1777566390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgKQyFNL/xZdySs4+82GSKr8MJJui3Na6kPKf3Q383U=;
        b=FHyrFvpsHeO245+Tt3yY3YlLk+YTydYGEDauMTIQvxnl9+88PdSfNWl2Egkb//VR5t
         SxM1dxetJvVXzCduFZXxS9lRT3fyi7uvwfofoPHpJDaSKuDYFxvjeBUpwBq4z/1mxrtI
         hxFFtj+sqFy39mhUiCNeEOfZP9W92P9oiIfRbs0XchHNZ6HDYUVoAPIl1wsVo9r3muQi
         OROr85Z3SXawIJRXT5PlnBTU7ICXGw4P00aMdItFKEx3nXQNZBrB/DfTUrIfayVAB0Kj
         xTmN8D5gBaze3hx0fldEPzAEBoUKDMdm7rI+BqF0muMT3az7/8k/Ja5IlcUXAQ+3nkhv
         zrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776961590; x=1777566390;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgKQyFNL/xZdySs4+82GSKr8MJJui3Na6kPKf3Q383U=;
        b=XqO73h1DNWmCntaOLRwGdaIWmSK/7H92Q71nxxEqmldQd7krNa2jExjYs5xbCmkITT
         8w+mPenL5GIfJRG0kJEhkvOzDqmiixw6yr7j1ykMSfW/m4BUL0r4UEmiBNAAbTnIQjp3
         YV3pVoBDEqKiji22/LxfkzPj8bMVGqSIIYvXe6UGYrALMZPSwjS9isqhgJfaWhq5hg3F
         E3SfVOccjN0qKA9wRl0zluMOHvCdc4gbamt05tEnRE6Q16x5Q0DZfyxjhEq/OSXL3+cK
         DhvojGxDuWLX2IrHkSDBScEVQ0Krf3FIHHNyKijsRkoxsBTaGcFCM4roIkIBPskvxAKT
         8SAQ==
X-Gm-Message-State: AOJu0YzNdph44lHtMFSo1UNPvXy10auwODSj+cPbm7iVtHWGWpXc1qY2
	Nvqu0RoTPlbk94ZWc5BU8S2FG9bZDuOrQj+I2CEKQtobcb7t+MP+I6LLdp7BPjOF/bhk7MzNwCI
	Q2Bwb8Q==
X-Received: from pgtt124.prod.google.com ([2002:a63:2d82:0:b0:c73:fbb5:af1b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d90:b0:39c:126c:93b5
 with SMTP id adf61e73a8af0-3a08d74e884mr32160120637.21.1776961590228; Thu, 23
 Apr 2026 09:26:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Apr 2026 09:26:26 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423162628.490962-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: x86: Fastpath userspace exit fix and hardening
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Nikunj A . Dadhania" <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

Fix a found-by-inspection bug where KVM could fail to flush the PML buffer
(VMX) or fail to grab the most recet CR0/CR3 (SVM) prior to exiting to
userspace, which could prove to be fatal if that exit is that last exit prior
to save/restore, e.g. the last exit before userspace commits to migrating the
VM.

Patch 2 is related hardening, i.e. isn't fixing any existing bugs (AFAIK).

Sean Christopherson (2):
  KVM: x86: Ensure vendor's exit handler runs before fastpath userspace
    exits
  KVM: SVM: Refresh vcpu->arch.cr{0,3} prior to invoking fastpath
    handler

 arch/x86/kvm/svm/svm.c | 15 ++++++++-------
 arch/x86/kvm/vmx/vmx.c |  3 +++
 arch/x86/kvm/x86.c     |  3 ---
 3 files changed, 11 insertions(+), 10 deletions(-)


base-commit: 85f871f6ba46f20d7fbc0b016b4db648c33220dd
-- 
2.54.0.545.g6539524ca2-goog

