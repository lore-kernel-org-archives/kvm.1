Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C5BA3D
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198210; cv=none; b=YvMeXghplk4mmPB+tmYYexiAx1jsXKQr97Mo2HeEWPCZiuwK9tq1FEIxyvbxNtKdAGa0wjtxZXPJm/rjnadcCbSnO4u1gcJ0Zsb8/phI0HniHtnXICiW0q8ZoIk9oDRDOut2WE2cO9bmwmVqtGzfT7YTxd3BiK/kWHW0ZyBdfQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198210; c=relaxed/simple;
	bh=3PhHS4cx87d1kDraniHXJ5Yt8qZeJOak/oW7RUNtkb0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WP05oLzkLH9aRFoIXo2SZMBWP9Bkaxorx95hPZ5OVN1e3a+eiSzngRksexJ17bCkcEwVlaODlo0y6P8asVATtzW0Opwrp6UhBbnwwv2HvMYawtmefotGrzBZV9JvU9X79dJC2w++Fk9PVm9CqNZ05DTiH3mj/QvpwOY4UegEcIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pgWtQ1de; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pgWtQ1de"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e01a62d99so4573903b3a.0
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785198209; x=1785803009; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xFS92TdOEy1I4tDpJqHj1DWKbqALk3IhZSaExM65JNM=;
        b=pgWtQ1denGEQxxQPLtnu5Fcw7wXH3bvGg/RxWAW98VeWzCifAYs/ULRXoXUhqABXxj
         8X7mwePDDgL3XXr9Q8aAe7HKgBdVlQ/7gNwrFJ7gGVMyrGs9omAxUTwXaEqpbDK1lhhY
         JQ2j8e4tXrLNf8n9Kt2/hU7z+1Q6O/oosrjOMmvdfWbHfrAlO+8gUBECTrpVnY/1ZBRM
         Mux20IEDmcnJKE5hrHYg2SsBOjdVtxW9yXr9SNSUEDTplpH7cj8Z+SXfRhtILvZsSX4p
         ZY1oLncLkV7y1w3rpaEsY93iq3HGB17D3qJH6RzwvSe5CxkB29FlABSyhqqYuvgyIPkA
         v6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785198209; x=1785803009;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xFS92TdOEy1I4tDpJqHj1DWKbqALk3IhZSaExM65JNM=;
        b=hGU/8gByhhml7qVSlHTRIHEnXZc9cde3YdivuuIoXm5FlKmpPPGqdY2N0gSYhun6pD
         MYYI66h1j63rFmEfCkmeIXw/3qIPbV1dRniAgByJPByiuFCXtEKYawCGdxwTWamtTKQl
         2NFGEfTbjGy5rknxhQdjg9CLr2FQxA8F8RC0KYUZ9juqt19OlDOsZovcx+1MBooQDQqi
         0/O6HX8T/rb8Kne6Y0I6BfEjsar9qf4dLN/Qd+tKJgBvocuGoZkoGx5eYpsQeo/D0BQ6
         IBCf/nb7LnsPNxOfmCxodnmrLFvVtbG6IoGxr5MGyuIyM7B0BOZTgEzEyc+AShl7qLno
         DA0A==
X-Gm-Message-State: AOJu0YzNZNr6hhB624K3J0sBGbFmmShtJx3eKWkRdlHHwmzEflZaL+5q
	dF713qGEt1pWZ7H63ak5/lSR8zjTyOmQDcZuvPwKhNyLf1KSBImpBMKBu8aK/Tqi2g6RjpNjpgr
	hhD00kA==
X-Received: from pgee11.prod.google.com ([2002:a63:1e0b:0:b0:c9b:2759:d240])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e91:b0:848:7b92:8e68
 with SMTP id d2e1a72fcca58-84e933613b2mr96021b3a.66.1785198208421; Mon, 27
 Jul 2026 17:23:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 27 Jul 2026 17:22:34 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728002236.869865-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: x86/mmu: Use LOCK CMPXCHG to clear Accessed bits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Use LOCK CMPXCHG instead of LOCK AND or LOCK BTR to clear Accessed bits when
aging SPTEs, as LOCK AND could clobber a !PRESENT SPTE.  Specificaly, as
flagged by AI of some kind, a LOCK AND in the TDP MMU could clobber a
FROZEN_SPTE and ultimately result in a false negative since the Accessed bit
is included in FROZEN_SPTE.

I initially was planning on tweaking the FROZEN_SPTE value to make it ok to
use LOCK AND on Accessed bits, but AFAICT there's no meaningful downside to
using CMPXCHG.

Sean Christopherson (2):
  KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit in TDP MMU
  KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit in the shadow MMU

 arch/x86/kvm/mmu/mmu.c      | 27 ++++++++++++++-------------
 arch/x86/kvm/mmu/tdp_iter.h |  7 +++++++
 arch/x86/kvm/mmu/tdp_mmu.c  | 20 +++++++++-----------
 3 files changed, 30 insertions(+), 24 deletions(-)


base-commit: 271255273d5ff348fe29d89fe4712b2f7f7907c3
-- 
2.55.0.229.g6434b31f56-goog

