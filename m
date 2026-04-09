Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26E38F65F
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775773494; cv=none; b=JH2XnKvAyYVG3Xc8z2TUX3sbxhCZlLJ8fZdYa+qMfgqUqpS6VUoGAKVPDIFzuUng4X9DH3HTMMqo87NtkCVvdFsGnDmM9lslbP//Qo2cjtsOOsrtn0cb6/n2HtISy64Vv1eu6aDt5s6MzzojaXWO7R3cy/lvlnHPGp0crd4BGX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775773494; c=relaxed/simple;
	bh=k51SJdHivpA9JZtPOeZrMlyKCdSiPU2JEKzUtnTp7Yg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HLOGrVmvC2Od0zCRNqZO1AgDoLAdMT9skfsC/wremnLgywKKY0gpqE61XrigRQnLSBhQZ2Q/GbgLiunoLXWMmg6lKCutCg3VT0jLoia0A+gPFMSX7JZmy1qG1ugN/q95McekY+OkQ8dYFZThnaRMzUmfQBE2GtEN3+JnvljXCas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cEfNBwkw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEfNBwkw"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82a77f807e4so1624343b3a.3
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775773492; x=1776378292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60TinkdCqjMvZHewxqPRZkqNrIgayknOG6h/lFThNIY=;
        b=cEfNBwkwbOiWLNuNbZBc3uALxyMd7y/iSA7eVZWj/jw6H9gnrc26ubKNoJy7OLixz4
         l/LY5Mj1RNE3TCY4xmQU5NOPuprQtL65RX3RIfYD38o5Simj7MVuJJJejVKQw7ixnwrw
         uwnZohU01u7ZujKZS8J7Ga41N32iFpkEQIj9BFXqx2U+Mg+eyoR5G8fQHIP2lUV9/6So
         HeReT473fl8U1Q4qrUcfVs+TVd0UmflzdV/Xo5OZxwZTSpkgXfKT9t2ZvaWpK9ohQXDW
         FWSoPqkz5M3fHrRcroa159nr+NCb2ni/ej9/MGzsmu3MzK1RY5vOdZ1t9E7AXfNEdW+6
         1hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775773492; x=1776378292;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60TinkdCqjMvZHewxqPRZkqNrIgayknOG6h/lFThNIY=;
        b=a7OHFoR8tbh/iYQaERXzq1sZdPyxlUdEwzJWpP79gGvjC6AgKBsrS5MSualqodFakg
         7Nan0n8CLecEgGBa19NfkGJEBIs3KikWcKdBpua5Om4hw46JfWGQ5XJpsiKO2IdT9JWk
         WqapNYaJ/lEK7Zww3KOm1JNXCtiQCcfqbPxKuavqSUsQcLRHRyow1a8AcBmlg5fl2kUj
         h7iiUv0PlGC+tM9wFDFTP24S0LbPlXf8VqVeoiYuYMeq1+xhN6iv6zpIzsad7fWNkwNi
         LUSyxRPk3BH6pyst/fhbjF42TDL5QamEBQ/KNoO8MDdjM7P0Vfrzu5cYHW35PwgWpKhs
         KAew==
X-Gm-Message-State: AOJu0YzBYYMmNEx+jJHErwEV00eAHOUaWMrpa76yBuDIFZ7WICn+Tr06
	+b8DkQ1HySCMssnE8QtgAqIr+FOn13sO0tjT25rm5llPnLWy9fIw4H60LrYG4xghbxzr8860yDg
	CmB2l6w==
X-Received: from pfaw3.prod.google.com ([2002:a05:6a00:ab83:b0:82a:128b:1d95])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:238b:b0:82c:2445:bd52
 with SMTP id d2e1a72fcca58-82f0c210935mr915292b3a.14.1775773492171; Thu, 09
 Apr 2026 15:24:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 15:24:46 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409222449.2013847-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: SVM: Fix x2AVIC MSR interception mess
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Fix a variety of bugs in SVM's handling of x2APIC MSR passthrough for x2AVIC,
where KVM disables interception for MSR accesses that aren't accelerated by
hardware (pointless and suboptimal), and also does NOT disable interception
for practically any of the "range of vectors" MSRs, i.e. IRR, ISR, and TMR.

Lightly tested.  Functionally, I'm pretty confident it's correct, but I
haven't done due diligence to verify accesses are being accelerated/intercepted
as expected.

Found by inspection when reviewing a TDX patch to fix a bug where KVM botched
the "range of vectors"[*] (I was curious how other KVM code handled the ranges;
wasn't expecting this...).

I tagged all of this for stable, mainly because handling the
AVIC_UNACCELERATED_ACCESS faults (unlike traps) #VMEXITs requires blind
emulation of the code stream.  Which is "fine", but obviously unnecessary.
I.e. I could be convinced these fixes shouldn't be sent to LTS trees.

[*] https://lore.kernel.org/all/20260318190111.1041924-1-dmaluka@chromium.org

Sean Christopherson (3):
  KVM: SVM: Disable x2AVIC RDMSR interception for MSRs KVM actually
    supports
  KVM: SVM: Always intercept RDMSR for TMCCT (current APIC timer count)
  KVM: SVM: Only disable x2AVIC WRMSR interception for MSRs that are
    accelerated

 arch/x86/kvm/svm/avic.c | 50 +++++++++++++----------------------------
 1 file changed, 15 insertions(+), 35 deletions(-)


base-commit: b89df297a47e641581ee67793592e5c6ae0428f4
-- 
2.53.0.1213.gd9a14994de-goog

