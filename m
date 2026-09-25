Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFEF361970
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790357971; cv=none; b=s3U4gf6a1nZRwM3HgzoCYgCqT7MP9vjSLfuELj3C1zjbqrLzs56Y68x6UErfB6nMM4eFt5gg5c/Z20qfaU78PX2ywG8IR+bbZPYBuMVC+7k//gNVxvrGCaQGARhGUc/yRPBGOVkf5ydMmU+y2YQPiDgkX8qoqoa6w2BQGB1fivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790357971; c=relaxed/simple;
	bh=tXcKTi7E0tgeKbTpIUN5oOeXpOFCG/vnZLh7M1NMgdo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BWEYRC2qv+fuJ0RDzW3NBVqzQmRRueULWzXQDQ10uIPY41fyxVs7CJn8PBw328SMQCGuMlI9psZrZu1GWDUM2+o8/4EwfPxekY5PMfH9kbL9UXdbN8BhGqviZKALb53AilfkiGuiBZHfSY3f8aQDtu5TWU7dXe800C3AEAKAsTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRLzUgOe; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRLzUgOe"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a0b6ef90fdso1119433a91.3
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 10:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790357970; x=1790962770; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nd7skY8GVJXfxGSjkHGGdACPeU66uBiLpjXLRBNa47I=;
        b=hRLzUgOeM4kztdRdpBABBzghCNdQsCHnJCk6F1LzmsoydQTiioFyGnkX3s18EAYffc
         aE9STZYBeSTOW8m41soiourCEd8u8OUOaJjUtVL5lIPdMRXAm5qUpaksZcqVFbrP+InH
         uTmJBs5eKW+HYRXFUrxfYulQUVSb1WdpMrzlEvvs5/xukgRRerrQliUjavz+1kQVzyQI
         i38eKVOviCsFOE6ZKh7/jLByLevbZ652glQcQzk9fxgHiMRooCyhH2XcD8EoS9ZIRls4
         ZTarXxO0aLaZB00BkjffeMJUaFipUKdQD7QRR9qtiSRcxYQ/ETWvTZjcc+xUHu6WnnsK
         XXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790357970; x=1790962770;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nd7skY8GVJXfxGSjkHGGdACPeU66uBiLpjXLRBNa47I=;
        b=AY33EtUzHd/xdaRkIk83ajZSh1C8rAniuqt4s9xt9f2la7xEQVr1Cb7eG1SLCYWSuQ
         PoXWAeyebi5SlWDcW3vT94dSgzXBD4WwH77gUHYrNObMhZPrnrocLv28MICHKLB/9UWR
         AXSzs9x4KpzVKBkyI8QC/AcpqK/5E2lrMLGCzIvMR0dQTeQ0HrEP6lGYw3Wyf/Mk7qmt
         Tnz/Z65T5fuSqd+jv8vKheyjePLjDbTEHpMoiCVW9XIvhw94hszfmy+Ku1zFszXuo8CJ
         pm1A4TvV0VGWP2bizmTK51wzkbTxdC9k2OzcGhtjLE4+L9AMIUH9Ufbr96Ajk8AcymjW
         Ipbg==
X-Forwarded-Encrypted: i=1; AKwUvBwIXhNrSrQr9Ku3AlCKPqs975zGLByu8uKOso8IxPFZ8nqQkbZnZ7Wt78YhYd47D9mrmm4=@vger.kernel.org
X-Gm-Message-State: AFuF++lGDTCMakuHIWZPV3pbh8fWKGBP3U2mFhspW8qem01H/MWQoBQb
	MhvVQ4tvRsZ97zhrE9Xsl95EHXP3kEANLSOBrbzZ5tVvwtCSSmfZeMhbDT2B2MtcmDNFxNWI2SY
	0tdpQRA==
X-Received: from pgeh13.prod.google.com ([2002:a05:6a02:53cd:b0:cc7:9856:ed98])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ed0:b0:39e:4c81:6c62
 with SMTP id 98e67ed59e1d1-3a09860b25fmr5854309a91.29.1790357969481; Fri, 25
 Sep 2026 10:39:29 -0700 (PDT)
Date: Fri, 25 Sep 2026 10:39:28 -0700
In-Reply-To: <20260721050600.87268-4-shivansh.dhiman@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721050600.87268-1-shivansh.dhiman@amd.com> <20260721050600.87268-4-shivansh.dhiman@amd.com>
Message-ID: <arax0JmdoGYoSpGw@google.com>
Subject: Re: [PATCH v4 3/5] KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed()
From: Sean Christopherson <seanjc@google.com>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, 
	kvm@vger.kernel.org, x86@kernel.org, yosry@kernel.org, jmattson@google.com, 
	thomas.lendacky@amd.com, nikunj.dadhania@amd.com, ravi.bangoria@amd.com, 
	santosh.shukla@amd.com
Content-Type: text/plain; charset="us-ascii"

The shortlog is again not precise enough.  With this:

  KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed

the reader doesn't actually know what behavior is being modified.  It's also way
too literal; the shortlog+changelog should strive to describe the change in human-
friendly words, e.g. in conversational language, not be a play-by-play of the code
change.  And that matters in this case, because the poorly named kvm_dr6_fixed()
makes it even hard to understand what is actually happening.

  KVM: nSVM: Don't assume all active-low bits DR6 are fixed-1

On Tue, Jul 21, 2026, Shivansh Dhiman wrote:
> When preparing vmcb02 for nested VMRUN, KVM ORs DR6_ACTIVE_LOW into the
> guest DR6 to force the fixed bits to 1. DR6_ACTIVE_LOW forces bit 11
> (DR6_BUS_LOCK) to 1 unconditionally.
> 
> DR6_BUS_LOCK is active-low (the CPU clears it to 0 to report a bus lock), so
> forcing it to 1 unconditionally would prevent an L2 from ever observing a
> bus lock (DR6.BLD == 0) across a nested VMRUN.
> 
> Use kvm_dr6_fixed() instead, which forces DR6_RTM and DR6_BUS_LOCK based on

We should kill off DR6_FIXED_1 and rename kvm_dr6_fixed() to kvm_get_dr6_fixed_1()
as prep patches.

As above, the changelog is too much of a play-by-play.  The names of the macros
don't matter, and knowing the exact bit position isn't necessary to describe and
understand the change.

  When preparing vmcb02 for nested VMRUN, force only the actual fixed-1 bits
  instead of setting all active-low bits.  The flaw is currently benign, as
  the only active-low bits supported by KVM are RTM (Restricted Transactional
  Memory) and BLD (Bus Lock Detect), neither of which is currently supported
  on SVM, but that's about to change.  I.e. this will break upcoming Bus Lock
  Detect support as the guest will never see DR6.BLD=0.

> the guest's CPUID. DR6_RTM is a reserved bit on AMD and is thus always set
> to 1. DR6_BUS_LOCK is left writable once the guest supports Bus Lock
> Detect.
