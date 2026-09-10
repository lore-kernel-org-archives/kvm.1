Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53922030A
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 00:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999758; cv=none; b=XVjuDK4e8/PWJPFzSWwwJ7m7+oR2ZCRuuIQRvo3btG5BzewIlP6PoLOQuSndH31pO1jCGZVbJRWLK1j5uNfR+WUza1EESkFYOw3EkoloFTxebgEn/mvVUHe9rkFQtVtjU6/oiRXXvONbIXomyimJVp8ey1858stwtJ58kFM4ykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999758; c=relaxed/simple;
	bh=3o4xptYxHv9M/QtLWA+QTUbItiWelQPkDFS5pTa+dyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VBTMd30R0E7MlAFygM+mdDw/g49vcxJmSSwhTPnQX7kWhVAZjz4jI013Hax9fuRcbqtS8ShcjYMLoapVlzK7Twlk7uXt2E+836CkzXp8WoZs3eSV17YU7vvUhRQZ2Rlyi/CsApVzpU+4bMDyiN69ZnwjDwTRmLctKJW1BkulZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GXhP3gFb; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GXhP3gFb"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfa4e4684bso63763145ad.2
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 17:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788999756; x=1789604556; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9SZpxMxEIpdJaZosn8BHIlAE54o/S+silvCTYXeRcHI=;
        b=GXhP3gFbDWlmTm62MsyQzNar60RorXyT9GJBPf3tiA8ARuUdnZWsty06y5JZYIsRxY
         xPp77THvD7EOFQnNpfHbSkYl4Xzpj6cKJaWsTgrKhVxwfjD/jzee9ECyz+2+ajjuPs0Q
         OoouK6yabM/jQXHc/94Xy1QlW7t2J7G6Magvx80v9mugCdt4pjKi9rm13HhpnY067Cyr
         YofXz0Eh+/nYyjh6dCCME/V42gp2qzlDJeTntsAHts7wTNOL8gkMbmH21698QxNmtqVe
         qrzHjhQNm529dPFZzB3Rmaf+YbMgiibI66F0sJSEIZPya+WRaOT1qKPISCqN1/6ZGNf5
         +Zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788999756; x=1789604556;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9SZpxMxEIpdJaZosn8BHIlAE54o/S+silvCTYXeRcHI=;
        b=XwWGskLVi9FL+472EjxAqzerpzr+AYT+ctCq+3W2zffjyMqxhUfIZ2CD4Obw0Wprkn
         Bq15ecNtm2hFYw5khqZlzSqjb/GIgZn0mckqDJLqr3tRO2fqfnjHhnt5BXL6Pc4BDa+X
         G4fnwnBh4t97AtgpYIu/h/xg+Kncbe9DhvWzGVt/a9A7CBrCMwPM1lN3mFTiFqxHLirs
         9OfCqsbe9JWVdiSMqupJvYX9nMo4GuJWaH3o1wgm1tVbgFOYz2sA6szv85N6iPloO0eN
         X2n+JNt2tKhPqwEMv3K0+IZnfxWdE3nHHK8w2SdOgRWq8RC5/DWyp9k9irj8rAaV7aAt
         3Y/g==
X-Forwarded-Encrypted: i=1; AKwUvBzgGI1ut0vDFmUMFhvX6IJZrfDuunMs7n1Rq92ZK7ewQvUQSM3QuynRQcehctPcMuUJOns=@vger.kernel.org
X-Gm-Message-State: AFuF++nzxG/Ma1qiRpgmBEflRcB7Wg7b7y8RL8w/abfPdFptqNDFJkbe
	2ga2AqHSye6WCR0BIMWCvml3AFRKIVukDYODOBTekkHWDRyBce2rIU4gqrGy1S5slSNHx3J2qkP
	pqlG3oQ==
X-Received: from plw7.prod.google.com ([2002:a17:903:45c7:b0:2cf:ca4d:25e3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c27:b0:2d9:b60d:7755
 with SMTP id d9443c01a7336-2db125cd34bmr576611005ad.1.1788999755288; Wed, 09
 Sep 2026 17:22:35 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:22:34 -0700
In-Reply-To: <9a5552de-0f36-41c6-8bb6-16cbba5425b6@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907063906.1964557-1-nikunj@amd.com> <20260907063906.1964557-9-nikunj@amd.com>
 <20260907070024.4A7E11F00A3D@smtp.kernel.org> <9a5552de-0f36-41c6-8bb6-16cbba5425b6@amd.com>
Message-ID: <aqH4SpA_567soglf@google.com>
Subject: Re: [PATCH v8 8/8] KVM: SVM: Add Page modification logging support
From: Sean Christopherson <seanjc@google.com>
To: "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 08, 2026, Nikunj A. Dadhania wrote:
> 
> 
> On 9/7/2026 12:30 PM, sashiko-bot@kernel.org wrote:
> 
> >> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> >> index 73f37b050d0a0..da417c4c59154 100644
> >> --- a/arch/x86/kvm/svm/nested.c
> >> +++ b/arch/x86/kvm/svm/nested.c
> >> @@ -901,6 +901,13 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
> >>       vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
> >>       vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);
> >>
> >> +     /*
> >> +      * PML is never enabled in hardware for L2.  Make sure that an
> >> +      * unexpected PML write would trigger a PML_FULL VM-Exit.
> >> +      */
> >> +     if (pml)
> >> +             vmcb02->control.pml_index = -1;
> > 
> > [Severity: Critical]
> > By intentionally leaving hardware PML disabled for nested L2 guests in
> > nested_vmcb02_prepare_control without informing the KVM MMU, doesn't this
> > cause all memory dirtied by L2 to be silently lost?
> 
> No, kvm_mmu_page_ad_need_write_protect() returns true when
> cpu_dirty_log_size is set and the shadow page is in guest_mode,
> which forces write-protection on L2 SPTEs instead of relying on
> hardware PML. L2 dirty pages are tracked via write faults, not PML.
> This is the same approach VMX uses for nested guests.

And FWIW, because Sashiko's hallucinations made me double check, this series
doesn't advertise PML to L1, i.e. doesn't need to implement and wire up
kvm_x86_nested_ops.write_log_dirty() for SVM.
