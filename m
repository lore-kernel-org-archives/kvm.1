Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4A1A2658
	for <kvm@vger.kernel.org>; Fri,  1 Nov 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487036; cv=none; b=VMgM7IXbOgYwVTeLBpeBDVjaRyDgjiON8+EqEU2fithXlCw1+xHZ+Febp83W9txAF37I2QGf9ISjhFMdacrDqrBNAcDeq5xtVNPBIh/tZpF0S1vQ6Yrnv8pLbf4R/3U+kiqL77zgRyvKa4ueaWfCIugBDseqBmELH+1RdqeLMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487036; c=relaxed/simple;
	bh=JghzadJb1RzeYmUv5G9/I9KYuZLOl2NXdDiCkQzqMjM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZRBfm+JzwyY0/WQwmdrxDWTni8m2lzA7AruGvC2jxFq6T3iZBi8Gos/qSoMWvKkYmUFVUXxK6bzha5mvhlhO4uoxg9MM28EaEO+NweD9jE/vBQNFGsegd9XImuK4cqDKpOKv1bfMFbErln+knGr9k0zdxTWqVc947JTPboKqAME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZGnJWDVm; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGnJWDVm"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30c7a38bd7so2981869276.0
        for <kvm@vger.kernel.org>; Fri, 01 Nov 2024 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730487034; x=1731091834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0yD6fxz/OxtK4CZyxTQ3jXuBHxwejODYX78SCol3Io=;
        b=ZGnJWDVmTLgZDe4dtg9DPJ/6dcM4kZKum+TbvesJQkPwQuMXlckVnJWtnumQL5W8pA
         KmQxRl1aZ7H1+mDEpuBpxvCNqbT8GC6+VrxHT6AKoe2uDaENdxv27bYZGbomynoW/+jQ
         qHzBVa37ztF4293JsqRUzohQX6bQBYGu5LtFCixDKk1NMYHHhdZ+PbLkSWTYeSZk1PVR
         oKFaEXy03SqPn7BzZpGOIkCz1rIkF07ZC416ni5m0bz0C2NcsjeMcjaHuWoUxTaclpvY
         8soET/jrIc8gSuCLLiGBCukbGcHDj6gfVaa5GItz2yw9q7hdr2pdsGJ96wn0n9sazjlE
         Q3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730487034; x=1731091834;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0yD6fxz/OxtK4CZyxTQ3jXuBHxwejODYX78SCol3Io=;
        b=c/1woTZ+sftRtUdAXJm/QLcdCW99bhukp+Er7YDaiWLoG4Lwq2Bz+LngTlN4cBTIbH
         O4eectVToc/TxWFBpvWX4Ly4nYoLFwiury4sWZK5skWJUOqi8yJw2cs26RK3JFiDAw8Y
         kdnNP4nVQgyb/8NP7o/BvF5RrCqVoBQYj8aTA3gnJymaZzFPPzWeCXfPF9c9G+2wwvrP
         IGrizauahkF8DCCTmDz3+Oq9RXC/tw89oNRnCmH90J7NrKSal0juY2BQZ1iGQo0IBvzl
         U/ThjIDCJ4DTLPdD9DC1Wk/4hSotzepJ/7ll9nxl5GZknTURWAv+MSo7U31sSk6D46GP
         Zq6g==
X-Gm-Message-State: AOJu0YxjH8JK9QwF//OODC4nV6vtg5g0g5T3ugS6Etaqwp9dnxpGJgpp
	ZZutl6ktx5Klkq8frJemTPyjSATCle+DyA3xLFbCO+5a7YfFUbl1lCZCvbooBLpToSbmH/vAguw
	wIw==
X-Google-Smtp-Source: AGHT+IHXZoWalcZy57W6wrfik1Rn3U8tlbZnbkCaEjoA8ZWubLTNsOhruGbtr6L94QWgRRFAxLRauROAibY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:8289:0:b0:e2b:cca2:69e1 with SMTP id
 3f1490d57ef6-e30e8d6b7edmr15277276.3.1730487033850; Fri, 01 Nov 2024 11:50:33
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 Nov 2024 11:50:29 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101185031.1799556-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: VMX: Mark Intel PT virtualization as BROKEN
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hide Intel PT virtualization behind BROKEN, as it has multiple fatal
flaws, several which put the host at risk, and several of which are far
too invasive to backport to stable trees.

I included one of the easier fixes from Adrian to help show just how
broken PT virtualization is, e.g. to illustrate the apparent lack of usage.

Adrian Hunter (1):
  KVM: VMX: Allow toggling bits in MSR_IA32_RTIT_CTL when enable bit is
    cleared

Sean Christopherson (1):
  KVM: VMX: Bury Intel PT virtualization (guest/host mode) behind
    CONFIG_BROKEN

 arch/x86/kvm/vmx/vmx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)


base-commit: e466901b947d529f7b091a3b00b19d2bdee206ee
-- 
2.47.0.163.g1226f6d8fa-goog

