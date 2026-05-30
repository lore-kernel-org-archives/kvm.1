Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F197E29ACF7
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101602; cv=none; b=SKpwypRVr0Em45HFho2+xacOrsn7BJO91vn5i1y/gHAmT5f6viDqEvGqkMpfN1nAQv7g79xX8ZmgCN5kceW5DMk+R2yaE+wZAn3qtXpNC5jYE58SPp9A/LpuwB0ot2cb6f/mEhHdSFoa5KqGEAfF06B9Iwgw7/FrwneTce9MmqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101602; c=relaxed/simple;
	bh=OnIqZoyGAWWWlahd6W8qMeb5CjlsGDbMWDJgrHbu/l8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CSAa47os/E5bgIleL8gcV+w7t4Esag8urPiUQVBwICS+XhSU6jSqLDggGuYSxBxAtqDOvyO8C+NJmmdQc8RLZZ54ZrDJ8K2vtDzX0g0d4+hWG9o7evHL/IVT2KsZ97VvEXe8b9pcM5K4UOv9yAf2blii2iJ6zftFfxHCf7xZluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fNh7LE9f; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNh7LE9f"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8294d8c48eso9295187a12.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780101599; x=1780706399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B7A+MtkkGwrPjHTd3SEo1c1C9cMXAbCZ2p1DGftew+g=;
        b=fNh7LE9f1cfoEnsO3Mwn3zCTjagB0tRmz3ttqiu7sGsHpm7TLtTFqHHrnW+gboRCUG
         hS1Koj9hRmfGiYHe8jIKqdkpexxL4Gm41u/IRN/X7E9Yd3IecyxmCZwrd12d7yKhuZLY
         Q8Abvo5WAB4cVGydnoqoMELlj0dd4xChXWwN/S22xfMFhE8IBriOzzeymmIQtiyDWvyP
         2DCARSdyAAlLc77coR4q41CM5Oo5pqimhuFzOfKiMUtaJIGIQ+12xLEJTM1NFXVuWejV
         zRRFFXBskHGJbxGIslfw9BLy047xJ0m0ne536PP7egeFQnoha3vICjJRcIojLE0eUtTw
         8Iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780101599; x=1780706399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7A+MtkkGwrPjHTd3SEo1c1C9cMXAbCZ2p1DGftew+g=;
        b=BmmH6e+ZxXy2n2RAkLwTk0K/6a+xaRJNUgL6yop2g+UewBmsB4tO1HESYhjHMUT1IJ
         t+MP6+ObcFX3LabFhugqTALBJjQTgPHx5uJMJOMmBkj3E9Qf/TiPAL//qH199QQRRZ0J
         DTyFstSySstT+pqt6zi9ni8xOqsgEmg2VO5x9krbTWo6/U1ljw+OxkNn+0O4U4Akrlvx
         xwkbFc/Icp4mqmidEn1tcTiKxyo2l/hP0ekmVGhFoY/Y3F8Zn3CUWD8OBTlt02kcBF30
         2aLUApcQk7wCVqzqadEWpT/8s8GlmqTjMfUBW/syBg5fmNVGK5sD6Mheqs6Qv6vDZRok
         nFHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+VfBrTm89UaaUzpkbayAyh3KxDOblIclbZvhf7/WqXbySIodWRGmBR6jYPKxD9blky6co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz47dk8qLauz7YUZKHxm5/fgQStuRHteVQtAJ+zGILMj5wSJ4jw
	mfNHWqvfmR53cQxCnRuVRhdSFZqiOpQmzX0KlIQ1sr2ulNA11KswiKsPcoKeDwpbtGGoSaG7AlN
	0oxu6VA==
X-Received: from pgap184.prod.google.com ([2002:a63:42c1:0:b0:c80:251f:17af])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6004:b0:3b3:be1b:c873
 with SMTP id adf61e73a8af0-3b4281eac8emr1565035637.44.1780101598930; Fri, 29
 May 2026 17:39:58 -0700 (PDT)
Date: Fri, 29 May 2026 17:39:58 -0700
In-Reply-To: <ahow9ka9VEwQbKOV@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com> <20260529222223.870923-15-seanjc@google.com>
 <ahow9ka9VEwQbKOV@google.com>
Message-ID: <ahox3g0KFRo1orXF@google.com>
Subject: Re: [PATCH v3 14/40] KVM: x86: Move async #PF helpers to x86.h (as inlines)
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, May 30, 2026, Yosry Ahmed wrote:
> On Fri, May 29, 2026 at 03:21:57PM -0700, Sean Christopherson wrote:
> > Move kvm_pv_async_pf_enabled() and kvm_async_pf_hash_reset() to x86.h in
> > anticipation of extracting the majority of register and MSR specific code
> > out of x86.c.
> 
> Not sure how these things are relevant?

Oh, I should have explained that.  The PV async #PF stuff is controlled via MSR,
so kvm_async_pf_hash_reset() will also be called from msrs.c.  And there are fun
CR0.PG interactions that need to be handled, so kvm_pv_async_pf_enabled() will
be called from regs.c.

But they also need to be called from x86.c where the core PV async #PF support
lives.
