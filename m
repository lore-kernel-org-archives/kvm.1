Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794949776;
	b=pXW3MddDbWTGpRvQu9ue27MkvyApZZGdzvrXMvskAvv7rcj3jCeeXW+R91wI9k4YP2Ie
	 7LpTKrfi2VvUeFcomYbYvWMAc51hU9kEU9avz9cbxswkGaCy7daNqhLcJX/rzhiapVr26
	 fE+hzR9oaTxB4ghGb1jDakKdjm8jitpkv8fSc1H00XErBxBNKuA9auT2v85UGuVI+XItm
	 ivj6G4ONCCWepPuUc0/vU1wKMjPaNR1gWclP2O4QP/Gy/OT8YfudrR/653C7s748zBVbF
	 i+uwkZO5q8nuwJZbRMyknyBdsulc6q7HqmmZCneB+OLueF8S4RyE5K/+lg+OVV7uOmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794949776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=NfgX3ez0+K7WIb7CbF9QdYQKCoaZza8TfZUj5MCSww4=;
	b=z0t76vC9oAZDyGuwVJkFmTW41IJpNzhT8S4PLqn3FOUWaZ711r6rVe8gNagUz/gpHZn2
	 TQjchqC2+TYEIPoS7lEj5PTukodOE7ybG6Vdh+HUWN1QQeNctYBeMzwawLGt4QQLdgovr
	 Ax53kQtJwxKEVuBnctejBPfB8HiFRYDBuQ/l+x8fn0zjikwlVtNt/Cllt3zeNhH5T9ewW
	 +U5DcXUO/c2v5Hj3+cdCCUbcyJd+o5sUHV5YhjIkrVMGKYykAE7wYNiBTpeZb7m9Ay2nV
	 Wob2viUn9qhvgfzgcGDaD0rGR3w0qCTlDbcg+PcfwBZ34UrT7mrdIxX7NbPr/PPb+5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZvrkAmW8;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6860E606A32A
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 21:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6860E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZvrkAmW8
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eb5375cd68so2006085ad.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794949776; x=1795554576; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NfgX3ez0+K7WIb7CbF9QdYQKCoaZza8TfZUj5MCSww4=;
        b=ZvrkAmW8Ge1S6JrShehC1MbPF8qF5KGRppNvJo/7VcgQYrj2ptCM/96T1QwOjF8luu
         Oma0oB1BwvZ2y/s2ityCYt3bUj35Hxj9G38U3+XBPBcFebJ/9hmAUSFiaP1gLk4+R93+
         DKeNIHgdiId+43ui+eFzC/kg6Zz8tHpkoufQsj28VqST8I/wFFYTpihQURdKQgXhJras
         qeflHmKfiQaP1voI12CNVToNWlNKLDxYoDaCmosc59evz1Jvb0wXuhB722XXjMCdSyFC
         EiOI0eIEij/3sj88Ci8ifDjA+j09Yb7vIvdSEPse570Wkz7IHuZBwB8P0WmgIqszrrz9
         AYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794949776; x=1795554576;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NfgX3ez0+K7WIb7CbF9QdYQKCoaZza8TfZUj5MCSww4=;
        b=MnQmNiSAC5Y/kejPXtYlOqmHc5wfN/xlStKSC+qGpy6SiX9seDNN3VktXevWNC2ljh
         xRSduP2ObrsdQaZ7ctF9SMmtzVTRykDLR8Tezw02AVQX1pZ5Giqnz48Zy7C/UZnMSEdU
         N6wO0ukSNRgmyb3xyUTw76+OQelGhw2ksaWDQk1ydvcBm3xqf8ed+Yv/10I11Kj+pG/H
         wO55nO7neYTIhjOee85inVNwEymEc7Fm3OFegsv1zLrhxTxhqsZHOB+azgwYPdjgS3ym
         xHUBgfVIuCX5RfLzFaQ5NI6onXXov9R4nF21eoKhmVSsQHyhC2lVl+ETlLVepsuNGYzm
         cKNg==
X-Gm-Message-State: APuU4Z9HnkGbWfQMz+kEXTASGsZYb2gvB1djYKnaHoF8fXaVNIa5bPeX
	tj+i7VvLmRHtUK3K9gk76czqXyHTwo3tHMm7z7WFsyFNqn7h4/Pg5Xq2kVvLLIhRv/sciYWmLtK
	tDNQOgw==
X-Received: from pluq7.prod.google.com ([2002:a17:903:4b47:b0:2e8:5201:ef23])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3585:b0:2e8:c331:fc30
 with SMTP id d9443c01a7336-2eff756d586mr4357585ad.69.1794949775564; Tue, 17
 Nov 2026 13:09:35 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 17 Nov 2026 13:09:29 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117210934.7765-1-seanjc@google.com>
Subject: [PATCH v2 0/5] KVM: x86: Fix nested CR3 load bugs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	syzbot@syzkaller.appspotmail.com, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Fix a variety of bugs related to KVM's handling of CR3 loads during nested
transitions.  I originally tried to fix a svm_set_nested_state() bug by
forcing the vCPU back into L1 if a late CR3 load fails, but Sashiko rightly
hated on that patch because forcing the vCPU from L2=>L1 would still leave
vCPU state in a half-baked state.

I finally realized that Paolo's patch to always check CR3 validity is the way
to go, svm_set_nested_state() just needs to also pre-check the current CR3
(because userspace could theoretically stuff a then-legal CR3 and then swizzle
CPUID to make CR3 illegal).

Patch 5 fixes another related flaw where KVM doesn't initialize the MMU if
loading PDPTRs on nested VM-Exit fails.  Patches 3-4 are cleanups and prep
work to dedup the nSVM vs. nVMX code to avoid copy+paste and confusing code
for the final fix.

v2:
 - Pre-check the current CR3 in svm_set_nested_state(). [Sashiko]
 - Pull in Paolo's fix. [Sashiko]
 - Add patches 3-5.

v1: https://lore.kernel.org/all/20261113170405.473841-1-seanjc@google.com

Paolo Bonzini (1):
  KVM: nVMX/nSVM: check unconditionally whether CR3 is valid

Sean Christopherson (4):
  KVM: nSVM: Pre-check current (L2's) CR3 during KVM_SET_NESTED_STATE
  KVM: nSVM: Mark CR3 as dirty when loading CR3 on nested transitions
  KVM: x86: Consolidate nVMX vs. nSVM logic for loading CR3 on nested
    xfer
  KVM: x86: Initialize MMU+PGD before loading PDPTRs on nested
    transitions

 arch/x86/kvm/mmu/mmu.c    |  2 --
 arch/x86/kvm/regs.c       | 30 ++++++++++++++++++++++++++++++
 arch/x86/kvm/regs.h       |  2 ++
 arch/x86/kvm/svm/nested.c | 36 ++++++++++--------------------------
 arch/x86/kvm/vmx/nested.c | 31 ++++---------------------------
 5 files changed, 46 insertions(+), 55 deletions(-)


base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
-- 
2.56.1.703.gf848ed807c-goog

