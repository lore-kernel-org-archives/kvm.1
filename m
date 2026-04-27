Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE2C39A04A
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332017; cv=none; b=Uqu8ax2Ysw6Nx6Yhf/HTg5lYm4T1u6tAnVUzyicbtLt4GSQOI3gzq6+f5oCCHUqYOdaOIzkkAEMUO4rXdqoaZpR4AMNkbXE2/Yy9OVbNt9HFJs6v4OI5wth5NmR7iHsZVh+PUjsmSi2qmkYB/u3MdehMSBdUmvjijUbdxDursvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332017; c=relaxed/simple;
	bh=N7yp2eQln9nemGHk/bWJ3vWIOLzbiu4oydoOgMIl84Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4Xp9o7njY4sWHvoGU+OcH+/SN2+N1XUPsvEYkLdJJtX1ABW+O/+xE/HUQ8tDVe80Cs3XOf4ZjhjqWtDiTao6OupLRzetAnud3Fm04CLYfjPkiOSVnOSBcmRmpoLVRam9R5uLfVeeTBA/dFZgKSIQAftF3pVYhEQoDoKDJ+RLKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSJp1MEp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSJp1MEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3671CC2BCB5
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 23:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332017;
	bh=N7yp2eQln9nemGHk/bWJ3vWIOLzbiu4oydoOgMIl84Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iSJp1MEpZ0yrpNcGvQhdHwfQvMkw3goPCT7UvSXowx2W0Geo+0cfw28qrEyihKli4
	 kmUMs2CNPdoEEQUEB4Gwz72LaJ51B/pvAm6GTc4sUebTutX8NwM33p2VwNQOVwwXIw
	 x3kxhpsvHxbjaUsYdu5+cZLfTsQfEQ/3D4fKLG0r0w9ayMMOrR0cIMStuP24Rt3ejB
	 ce/XHbiRX8C3p/v4aGIe9XzJktQrmFCTdf+cQDHtb1bVlG3LyL2Yxa4NL4m+9/Zvqg
	 Boqv6JEHlkGVCiF1oYbn5DJmp/34fTNIQy2Be0ULnxf7arDvKYsOGLO+lzl5v/5iT3
	 4rmYEX1NwgCOw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-676d8582a13so12161000a12.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 16:20:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/sMeVSzoghdCtffDlEICDSm/DugXfX3xMsjtpPBkyrET/e40lkumHadMSvkpBGMGBVIUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZL/lKS/DUhecNVnZcr5Klx6EwwH0De/BrNQpqkXx8EjoPW70j
	OzO2jU/8PKI24TG4Ak9ZBuwXRRAAHr1byFRO+1XO/ha8woeIM+bKO+q4a6zmT6R690Mxhkj3gpp
	2OYVn2zHLvE6LFEon2kyCs6HfC6n6Ud4=
X-Received: by 2002:a17:906:c149:b0:bac:7f7d:2bf8 with SMTP id
 a640c23a62f3a-bb7ff35c507mr38849366b.0.1777332016058; Mon, 27 Apr 2026
 16:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-4-yosry@kernel.org>
 <adReHbkVRDGOihb4@google.com> <aesRPt5Vpco29vAt@google.com> <ae-v3aGftsAQuG5E@google.com>
In-Reply-To: <ae-v3aGftsAQuG5E@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Apr 2026 16:20:04 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNzyp4X8Pny7aFAjX8swSxpfmwu7GF9Ry7Kz9GSKpw+bw@mail.gmail.com>
X-Gm-Features: AVHnY4JO6BoSpTWgcs_jMiXSFX7ctNP0rCT15yFiqsQH9-eObE-nQVXP0GiIQ90
Message-ID: <CAO9r8zNzyp4X8Pny7aFAjX8swSxpfmwu7GF9Ry7Kz9GSKpw+bw@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> We can have our cake and eat it too.  Add svm_pmu_handle_nested_transition(),
> but then also rename and rework reprogram_counters() to support both deferred and
> synchronous operation, e.g. something like so:
>
> ---
> static inline void __kvm_pmu_reprogram_counters(struct kvm_pmu *pmu, u64 diff,

I don't like 'diff', I think just 'unsigned long *bitmap' and pass a
bitmap in here like most PMU code?

>                                                 bool defer)
> {
>         struct kvm_vcpu *vcpu = pmu_to_vcpu(pmu);
>
>         lockdep_assert_once(defer || kvm_get_running_vcpu() == vcpu);

Hmm why do we need this? Why not just pass in a vcpu? All callers have
the vcpu and it should always be the running vcpu whether we are
deferring or not.

>
>         if (!diff)

Then this becomes bitmap_empty(bitmap)

>                 return;
>
>         atomic64_or(diff, &pmu->__reprogram_pmi);

and this unfortunately becomes aatomic64_or(*(s64 *)bitmap,
&pmu->__reprogram_pmi);

>
>         if (defer)
>                 kvm_make_request(KVM_REQ_PMU, vcpu);
>         else
>                 kvm_pmu_handle_event(pmu_to_vcpu(pmu));
> }
>
> static inline void kvm_pmu_reprogram_counters(struct kvm_pmu *pmu, u64 diff)
> {
>         __kvm_pmu_reprogram_counters(pmu, diff, true);
> }
> ---
>
> and then have SVM code pass in the reprogram_on_nested_transition or whatever.
