Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873646EC87
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251251; cv=none; b=bGtii+7Py7r5nMMAR3AJ2AexXDjbPcrQDGpmctYa1RF+5OBJc4PmaJYpAolnIpJ5YTtOdk0Gkxj6n89n7izw7mbXwTOEkPdWVC5Cmxna4UoVIMi4M1TrUlPApYREC5Wj6cnOIbRGOVcocx7axvJiZALe2eIHAjURaByOlktCzXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251251; c=relaxed/simple;
	bh=IkmOQmTNHgCAKusK/MC6CnaPT4r9K1qk5lgYoQHF1s4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=goEs2UoEsuUYWdr0RU292CS+txrmxHdZIHaYpFwSULAc0MMhIYK8o8sllFLlqlYSmnh9i1jlawOrh8rzbJnI21wT+JTIIUSrog8RGRTCv2p4cfdjRi/TCuehZxjsvt3lEHdGsFKg0CRm6gp5sMfcABhuS1GP0FcnuygpyJ09xW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AGb+PFxZ; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AGb+PFxZ"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so2569260a91.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 08:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785251249; x=1785856049; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IkmOQmTNHgCAKusK/MC6CnaPT4r9K1qk5lgYoQHF1s4=;
        b=AGb+PFxZZforNUgXgQkp/UfWrL07bmAnOV+kKYev3LW0zJYBvPFBcYSk+eIVeR1Edx
         dkkbi021HoU/hUvLuyjPP8Bb4TJrb1VMW2nHCM1re8zeJdzr9RYK+7dbAUnZfzKkJVlf
         5m8LDYQoIC5NaCeLfJkbv3fYEXPmLlR/sNlt0aT3pcza1q8UQZOpNS4NQSw/daLUE+60
         fhNyeSFyxBkQpXm5XnpSCjPyTtYgy7XAPmaois+urxSjoRAj8cj3z9mlFCKMw7UhZkeg
         wQCr9DDqR13DU3bEte7Ry9jbgu+9ku1VpA3mVdGSVi4GP7QDDrMTlwd4FQeZsxsALY95
         HeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785251249; x=1785856049;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IkmOQmTNHgCAKusK/MC6CnaPT4r9K1qk5lgYoQHF1s4=;
        b=TEniYgynWsPfjAuvQXDphAztm1O2ePYbAJFBxaKa7AKPmPyApnTxRK00LT5yzALEsX
         SdaMg77iIIkcz4mijEEFXEGBoLvtQ+YQjNnBvixlaUz6+tfC53Yt/C8h1XXvZqwhusNj
         00gTGuRW478gWZ5fRlGnuIImMKh+MCfmAfxqmKu9XMnBr0fYeJFjNMpaBhSqDGIvmmIM
         K6/ruljtbpiTCUxl/XQaDymfvS0+/3/XaS7TC4JqNZ5bWZkP0CmgV3U1eFnu3QZ9Vs1M
         D0+cFKfuEgEDl/hQDVIKK10ArfH2yVRkfkk7kfTjbFJfItovTIMiYFDHJOHoRqI3I70M
         Sfyg==
X-Forwarded-Encrypted: i=1; AHgh+RrGcDVu9ijDmNh9Y/a0tXcBIpZfoRXiWclndYgKyHhRwUT8dAHvODr0+n1KzwYoG5Z0bw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFRiRL717b9wOB4dZaRWyJdc+QaarAfnZ23sA/YsC6pRb+fd/V
	9m4YNkwrSbA3LmiaFMnh6TGB5U6S9zRTD4bIqxK7HXRKD9nqs96is/y98TQgXbx9ld2yRpciLHs
	JTp+4dw==
X-Received: from pjoa4.prod.google.com ([2002:a17:90a:8c04:b0:38d:c157:c023])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d43:b0:381:a766:efc9
 with SMTP id 98e67ed59e1d1-38f6a40fbd8mr2793557a91.7.1785251249329; Tue, 28
 Jul 2026 08:07:29 -0700 (PDT)
Date: Tue, 28 Jul 2026 08:07:28 -0700
In-Reply-To: <20260727235228.1007324-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260727235228.1007324-1-yosry@kernel.org>
Message-ID: <amjFsLn_Ki8VL-z3@google.com>
Subject: Re: [PATCH v4 00/12] KVM: selftests: Stress save+restore and #PF (ft. nested)
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 27, 2026, Yosry Ahmed wrote:
> Add a stress test for save+restore while the guest is triggering and
> handling #PFs, in both L1 and L2. The goal was to create a generic
> selftest that would catch bugs like the one fixed by commit 5c247d08bc81
> ("KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12 on nested
> #VMEXIT"), instead of relying on high-level testing (e.g. building GCC
> in L2) to catch it.

LGTM, but there are juuuust enough nits that it'd be easier for me if you send
a v5.

Thanks!
