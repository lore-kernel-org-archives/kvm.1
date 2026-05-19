Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEC124E4AF
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151419; cv=none; b=d+lF3dvBQNCOsWW4zpo3A+Xyj+ypeP6rCnajL/9HjphxUpeZUaUgW2COO6QPYSuCWoWmHUZOkl8CwMEOkabAb4flGBnhvitKItDOQtRqgnNS/qY4YfmmNZPkJvLiz+bSSyfzB6+kXiqweKes8IxoGaTP4jahcTA4OdF0RyE5pgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151419; c=relaxed/simple;
	bh=nzMxY8+UnJdBw3CvpnvLTddYG+/Acq9tPNOa+ulvV9w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CfKLhA0I8gRwfmjOLuJd/ZTpTHbU7ZVbpGF8vNCvGsPoDr/VPG7XbfZ3ScsTiYZbpvQ1pqIjBsHv2g2n+Y2t4/GR9qx8crcUdiLDtBhz4ygpgXjRG9RBWivpoO1FiMnTz5ElwQ9IgyGyBcJxj+hwYCs/mK1HC6NkasIauWXMhkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g4GqQCHp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4GqQCHp"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba15e384c7so19836825ad.3
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151418; x=1779756218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pW+SZ4DiHEbAMVxFiDO/o07/N3cCEF7bkyUCt/9G1kY=;
        b=g4GqQCHpVRILL+3L21l/0nPBlT2QwhztIwNWT6vDXj0iXNuyexvlUCYj0TRHp92qaR
         RWCmXS3ecGrk4ZSHFKLcnXUVkZNEq93UkbZZlxAlKrh0mRnmqMiYRq2XARg9trE5tQaZ
         N3W0W957FcrwUV6XHUy3Ln/6ZacCmtJEwZfRsppucD4JW++qyb9101FfbIiJ4E612HvI
         v+NRxKnWNq3Ky5e0n1mqIPR3g4ZvFunRiA/HREdHJ96j4VsEmDMd8OVmS8HGJn2n5utS
         YywAthg69cdJXhuvzHNSPvc5txWYWo9qmz4aFyn53qP6+OqWuAdIuSUNrunGEHoUiZZD
         TIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151418; x=1779756218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pW+SZ4DiHEbAMVxFiDO/o07/N3cCEF7bkyUCt/9G1kY=;
        b=BIkxO8IS7sphaUQyttpFAlXmbV25l2kIRiTqIRaIAS9sDn3miNtmOsLfx+x3kqT09q
         YlXI6+vEibw+4xwwgDSh7nA7FWPvIDc89JNRjxew1cP+RuG3weZfXOvp2sSSFH82eSGn
         9+LpKzggXSA5zbLPWkqY6h2S1w/ApNNV72MNG61Wj321yz1Lb5mCaY/cHzchXpCRAsMp
         18uRZURnPjgBGAH8Z4hrgQfwQ3dM03DwcnPX1DzHe0TRU4nehqkMvU0BXt8C8n59O4Ux
         EP+LDxMhWNN7xO+F7w04aNCFApi4wuYlG2ejwDvxFxkz37WaCU9XIVllGjcsBB78nMWF
         cp/w==
X-Gm-Message-State: AOJu0YzGe/OW3xPdk2Pdb+u70R2oaoQf5t6x3wGtAO4FOMt2KdtOKasC
	eOpf27Vj4cuRNob7/prpbZ5QPX1qmZydMrKAA+MRjib4LC/T9ZQ0FiqlzYyWLqMNLzzx2mkY3tv
	8JuwXtA==
X-Received: from plfn12.prod.google.com ([2002:a17:902:e54c:b0:2b0:c9c5:109b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22d0:b0:2b4:61cc:37a8
 with SMTP id d9443c01a7336-2bd7e82bb9cmr183810785ad.17.1779151417754; Mon, 18
 May 2026 17:43:37 -0700 (PDT)
Date: Mon, 18 May 2026 17:41:00 -0700
In-Reply-To: <20260422130307.1171808-1-piotr.zarycki@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87v7djgoji.fsf@redhat.com> <20260422130307.1171808-1-piotr.zarycki@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915101375.2229640.7454102060975937754.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: selftests: hyperv_tlb_flush: replace NOP loop
 with udelay()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, vkuznets@redhat.com, 
	Piotr Zarycki <piotr.zarycki@gmail.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 22 Apr 2026 15:03:07 +0200, Piotr Zarycki wrote:
> Replace the open-coded NOP loop with udelay() which was added to KVM
> selftests in commit 6b878cbb87bf ("KVM: selftests: Add guest udelay()
> utility for x86"). The NOP loop is CPU speed dependent while udelay()
> provides a deterministic delay regardless of host CPU frequency.

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: hyperv_tlb_flush: replace NOP loop with udelay()
      https://github.com/kvm-x86/linux/commit/749fbf2bdcd7

--
https://github.com/kvm-x86/linux/tree/next
