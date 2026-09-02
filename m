Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDE43002C8
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 00:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309536; cv=none; b=tkF0LP2ABvsR9n4b9YF2bOazkoa426tkZmnn5jqddjmu/pZeOv6FLRv9lP1QH/dcAGnrTCz2DH2xixN/eQyCx2nndVf7KiVBH9/XRKgUFptLyxz0q/yOg2iW/oMKTh771a/40poBlnUD4THk3VMXZd4c64+IQWyTnu+FzeKdnU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309536; c=relaxed/simple;
	bh=dM8UMjdfpzrInG7yBCOavPUVK2/x4vlb0fefgS3K6Yw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SaepJdYIFkmy7gVGaDdHfH5eg5RdeDdZXbb8rbQAtDMmxl+Lzrtpoi3WKV6F4CEPj416d9peS2LRTGFgG/JxwULgPA2uiXAjU3eJRWetghxoUIwsqmUw2+o1JdMHEOzOPpoxcAwdS4hm8So+bSwNpNSBibMj1T2P27cotav9MWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cd9q9TuF; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cd9q9TuF"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d959904658so7469705ad.2
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 17:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788309534; x=1788914334; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FaTmFFkWvtpI1wxK9lbUH5Q49TqxcdmMs9wtskLlSB4=;
        b=cd9q9TuFdqYqcDrugYPeY/JVeFF8BqYOYNEwpohfGF45vi82FUDlNUcdQLqpSqTvrs
         Rdh1tHhEou14WwmTHxqMp+CSiQ0OSNLH3HkO9yyFpxyu0ZEJUkuYSzgEWr4C/Vcjz1sZ
         2ZXeIhlEiPtKY/n8cwyP1SniE/AFekKN0U2LRmroUF3Ta/3c4owa7QjWp+QBt+iyAWbU
         oO9TfdSBZyyBRbwQXOaHrSoteRS71mHAJmgCdkIJ1HghR1/oTgSsTqSoqIPlvKpyrxAl
         sdO1y6mThMALRjC7ExBGuTIbUtrloROtrVKLTdUQD7nj1d9crFr+nak1zM1e7Umq5y4W
         fkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788309534; x=1788914334;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FaTmFFkWvtpI1wxK9lbUH5Q49TqxcdmMs9wtskLlSB4=;
        b=BiG2ZHvJaNqtvDqS49mT4uV1NfNf6vL4BfzG4D3Hx0dCJmTc0JDgprSBh5k0rl/lTP
         gkBx/NU9s522ZXUKSkomroI91eDx8Sp01cVxQybnLTs4pJn/wowlVobg1msKWKqxyHu8
         zeMgLqZGXD6Qk5a77KSRRidgr247Pq1kVSrXtUHE7Prkhi9oQ//LoUuwmUbCGIpsIgb2
         Xh1UKTU4GSNFB7CsmQw7vJ7GHLafcRuG5grPXKYqaw2IGpGJX29FusAog8pQFLdHz3BH
         7SbdFJgkR2VGJyXeHKDJxMOCo47oFqCB1GBUu70JlmmYqzAV3RdfEZNV6VPIC2TqD7d7
         kl2Q==
X-Gm-Message-State: AFuF++mNOxKf1u3tIXoNfhB9/g7x+Np6TCpVFU0x4ho4nrPY18DVLeiD
	ybMw7r27PISwYRwgImy7nrE9VvftBuqMV8zZ0tlSS9tMxnT4gtn7KIcVneooMuLYCLvSJ84u2VY
	7XzbcZQ==
X-Received: from plgf7.prod.google.com ([2002:a17:902:ce87:b0:2cc:6063:a658])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:26c6:b0:2d8:d4cc:be67
 with SMTP id d9443c01a7336-2daec73f1d2mr14199535ad.20.1788309534336; Tue, 01
 Sep 2026 17:38:54 -0700 (PDT)
Date: Tue, 1 Sep 2026 17:38:53 -0700
In-Reply-To: <20260831144802.834315-4-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-4-seiden@linux.ibm.com>
Message-ID: <apdwHcdy2iYRTrww@google.com>
Subject: Re: [PATCH v7 03/23] KVM: Allow KVM implementations to switch off
 MMIO independent of Kconfig
From: Sean Christopherson <seanjc@google.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, 
	Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 31, 2026, Steffen Eiden wrote:
> Only defining KVM_MMIO is not flexible enough for multi-KVM systems
> where one KVM implements MMIO but others do not. Solve this by
> additionally testing for the non-existence of KVM_NO_MMIO before
> including MMIO code to KVM.

Ewwwww.  IIUC, s390 ends up with two KVM modules, i.e. there really are two different
KVMs being built.  Rather than have a KVM_MMIO and NO_KVM_MMIO, I vote very
strongly to drop CONFIG_KVM_MMIO entirely and replace it with __KVM_HAVE_ARCH_MMIO,
a la __KVM_HAVE_ARCH_VM_FREE and others.  Tracking two separate macros is going
to be annoying to maintain, and will definitely be confusing for non-s390 people.

It'll mean linking in an emtpy coalesced_mmio.o on s390 when building without arm64
support, but I'm guessing that won't be at all common for s390 builds.
