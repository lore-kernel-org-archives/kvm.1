Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386972;
	b=4gS/H5nKBFVXg8kJY4aS4l2WN781SsKnz2JbxO1et3edGT+Y2eA39ALrhu6PFQNB6a4c
	 7O3A6Yh7bYDjTrv8831G053YlLRPN4Rq+dBOF1mOcVzy86H3/bv++nDF4Cv9IWcTbqGwA
	 tSikuod4P3sxMDYKFuQmO1RuvIE/jXFCevNhIqpEZwXTSzoWgQQYe6BKxNu21D7p6wti7
	 W7v2DWyloAduzwL2/idvpdAPpi9RTsIYtNThuGXdFGGbEBooqwGSywxXdMfsCyg7eakTC
	 t2dousNnlz0FMU/u599ciPJF2Wf8nxvwLHxL6jCWC1vZzPgjEibCyXcV5XkPTr4SI8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=TsE43CbBcP3yrj//6OBRvd1tGiO9nFSu3Jcj7hV1cls=;
	b=TrRmZyWylYLLUX4XIXP8EeUQW3L0ugs/5X8fWr1iOVeAbusefcKmBxYjFHC+nJwoWcoO
	 A8eXSgX24HQXb2BEkdZnVBptUpMDkkbX1fXsosq9UKcnDzHPu8pPyWjpEGfsI55DUfFSM
	 HWvMw+YdtEcFg2X0Hf8g/kQYdOlHP/hdo0Mfn1TsZJW0IaE/0MXZwhooIPgRParhLhIng
	 Whd/sdqiRghosqLHpXql0OgjBZkda5ZL4PIIhRV22/YpyvQhM+JGmtwAEkR9fPrtOaCl8
	 wVCRQf2IOFHzJy/ckVeM0Po3vJk9pOc5m/3mCrmu2x2mpOuwymh7heogOWr0PmXqnDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="pGQg/DFW";
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C7F606A31A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 19:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53C7F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pGQg/DFW
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdaf2a74482so580998a12.3
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793386971; x=1793991771; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsE43CbBcP3yrj//6OBRvd1tGiO9nFSu3Jcj7hV1cls=;
        b=pGQg/DFW1MJLlZuxMhf+4E1mFkSG3scUnbG0uTPxrEsh09jsMukXyEDikGdDduX55F
         slCroQPd3498biFNQC/qWa+mXOFjsndCfj2XbiV9JiP4NiHNZMvWJi8jYxQGXeflw09Y
         PSMVff3xmaPeNNilOUvvDEC0T68aYyT4sgBVyQhzMeMnH86+FBfcatnaP3iOYEqWxNsf
         pXg1xJN4eljzPh6Au1EwmyMkH/jETaIF5Z1d4t4mDav1m2Tw9pfz3QfqTr8mZLv3U4Zb
         msmW6aEAqVETpDYLw+USDF0rNms5bzSsQ6gJtnCR3367w3LmDVOlWS6FoQpxG/AMQcOT
         0mpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793386971; x=1793991771;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TsE43CbBcP3yrj//6OBRvd1tGiO9nFSu3Jcj7hV1cls=;
        b=TOaRvr7XLut4Iby7EA/rx4LMS3GbNp+bwrSbS39qJ4KMloxoyDf5Avs2eL3SX4attv
         SRawXVSzrNyXKBqwp5vxJrWQbPyNKwZ3bIphDThNzG1kEIV0EyjHtfZVkRywdyoYE/IF
         K8UDljqDkDfj1q1MaQxkWPw5RIioU2VWSMPKOMD89ub14VRt/zcdlkc4l3YvcykWjLFJ
         FHawC+YUOcT9oz1+e0egmcW/Gh/uggqXraG5TBPqBCo9gFxB7uUTscg1BlaXjuE7xXt+
         EyoxIRnZAOTkZlPkZeXj3gyE470CFh1mnxRWfrU5wiGcpUloA+p/7Pru9995dbMHXqzw
         4q0A==
X-Gm-Message-State: AFq9FYJFYji/gjcvQcQBJ/JJ4dT0CDRStSFnVdjDdS/sgVa8wxuGzdfd
	zKWjIzZHCku8pAEzf35MOkK+PJTKjFynPp0cIosiIxptcTO5oX4pMurnTCPOsNqfH5HibDjYdiu
	hVfcUMQ==
X-Received: from pgp20-n2.prod.google.com ([2002:a05:6a02:62d4:20b0:cd6:b08a:e7cb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:914b:b0:3e2:9470:5303
 with SMTP id adf61e73a8af0-3e928953948mr2814804637.15.1793386970294; Fri, 30
 Oct 2026 12:02:50 -0700 (PDT)
Date: Fri, 30 Oct 2026 12:02:49 -0700
In-Reply-To: <MRWPR06MB107263BB1EF5464326E45DCD7B96D2@MRWPR06MB10726.eurprd06.prod.outlook.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028202607.1844883-4-seanjc@google.com> <20261028215143.2913059-1-jthoughton@google.com>
 <GV2PR06MB10711171A7A8F225207FACD6BB96E2@GV2PR06MB10711.eurprd06.prod.outlook.com>
 <auO1_YE89Q0T0hfI@google.com> <MRWPR06MB107263BB1EF5464326E45DCD7B96D2@MRWPR06MB10726.eurprd06.prod.outlook.com>
Message-ID: <auTp2Yp2qtqtiPkX@google.com>
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Add automatic prefaulting/prefetching
 for TDP MMU faults
From: Sean Christopherson <seanjc@google.com>
To: Marco Marangoni <mamarang@amazon.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"cc-open-source@amazon.com" <cc-open-source@amazon.com>, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 30, 2026, Marco Marangoni wrote:
> 
> On Thu, Oct 29, 2026, Sean Christopherson wrote:
> >> From my perspective, using fast GUP has the problem that you cannot prefault
> >> "around" your page, but just ahead of it, so I don't mind going with normal
> >> GUP if it makes things easier for you.
> >
> > I think I'm missing something, why would fast GUP prevent prefaulting "behind"?
> > E.g. is that effectively a limitation of the underlying backing store you're
> > using, a fundamental limitation somewhere in mm/, or a limitation in KVM itself?
> 
> I didn't explain myself properly, sorry.
> 
> What I had in mind is that kvm_mmu_auto_prefault() returns on the first
> kvm_tdp_page_prefault() failure, and starts from the ALIGN_DOWN'd window start
> rather than from the faulting page.  So if a hole is below the faulting page,
> the resident pages above it don't get prefetched either.
> 
> E.g. faulting at page 5, window [0..7].  If [4..7] are resident and [0..3] are
> UFFD-missing, the loop fails on page 0 and nothing gets prefetched, even though
> 6 and 7 are right there.
> 
> It doesn't matter when nr_pages matches the UFFD chunk size and alignment, but
> it would with smaller chunks or a non-linear access pattern.

Oh, that's easy enough to "fix", the only question is whether or not that would
be a net positive.

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 08b6a90c7131..61cae6f1d9a9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5179,8 +5179,7 @@ static void kvm_mmu_auto_prefault(struct kvm_vcpu *vcpu, gpa_t start,
 		if (gpa < start || gpa_to_gfn(gpa) > kvm_mmu_max_gfn())
 			return;
 
-		if (kvm_tdp_page_prefault(vcpu, gpa, error_code, KVM_PREFETCH_AUTO, &level))
-			return;
+		kvm_tdp_page_prefault(vcpu, gpa, error_code, KVM_PREFETCH_AUTO, &level);
 	}
 }

I generally don't like heuristics, but they're practically unavoidable when it
comes to stuff like this, so the other option would be to set a threshold for
when to bail.  Failure should be cheap?  So we could set the threshold to be the
default PTE_PREFETCH_NUM, that way the default behavior is that KVM agressively
tries to prefault everything.

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 08b6a90c7131..5dc820a32f8c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5156,8 +5156,8 @@ static void kvm_mmu_auto_prefault(struct kvm_vcpu *vcpu, gpa_t start,
 				  u64 error_code, u8 level)
 {
 	gfn_t nr_pages = READ_ONCE(auto_prefault_nr_pages);
+	gfn_t i, nr_failures;
 	int nr_pages_msb;
-	gfn_t i;
 
 	if (error_code & (PFERR_RSVD_MASK | PFERR_PRESENT_MASK))
 		return;
@@ -5179,7 +5179,10 @@ static void kvm_mmu_auto_prefault(struct kvm_vcpu *vcpu, gpa_t start,
 		if (gpa < start || gpa_to_gfn(gpa) > kvm_mmu_max_gfn())
 			return;
 
-		if (kvm_tdp_page_prefault(vcpu, gpa, error_code, KVM_PREFETCH_AUTO, &level))
+		if (!kvm_tdp_page_prefault(vcpu, gpa, error_code, KVM_PREFETCH_AUTO, &level))
+			continue;
+
+		if (++nr_failures > PTE_PREFETCH_NUM)
 			return;
 	}
 }

> FOLL_NOFAULT is fine by me; it just makes "hole" mean "not mapped" rather than
> "not resident", so slightly more cases hit this.
