Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC2440DB3F
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231619; cv=pass; b=ABCC74UhJ1+EmoxFEr3cbzQeg8PcEhm3M+6OD3j7uVLYuEVmQMEzaOt9xvfSHPI87IvOMWYnKPJ5mzRGejsf6CL6kWodPoNO4fTyTDNfpgJjDx5M6eKXfLKdcnYLKUo//xzrbinElVf/isioop2mSAO/3acZLv9W8sxQ/vqUSdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231619; c=relaxed/simple;
	bh=NaRacMAIbT0zf+9+8JPgWZVOEMFjv7cQZrTI6Ni4rVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiNizlt/KOFY7awPA77fXfJbC9ywzEFatn2gd9+Fp7Ummo+6O4dZUcfuEDbGCA99e8jFcz7Kt63Idx40oiYME386BWkg0i0bLIlogDMRaAbRfjCC/g6zH3cSwT/WigGDO1/IEZ/TBoRPY9ZKqxexX+eoduAzCoyDD2MtbYxJVTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gicW+k8C; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gicW+k8C"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81f64e8dfbcso42218387b3.2
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 02:40:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785231617; cv=none;
        d=google.com; s=arc-20260327;
        b=D2Qb+F7UWqCafDeFZXPrZ2+VbLfAfyu4/fTSAD8jhAKRc3uFB6egdgdE4PeEYREIvQ
         biD69vbDj++tciIiMlhfCXRUDqxXUVJRVfC71AEkazzKjaeWeHGso79/aPlNMwT81Zra
         rE4wnjuMOMGFEC8DMZ+fHbnDXErfaUYKzu3iCYeLT+f/Ns7ZhSWUhvW8riyrCHa1xvqK
         PMtbFISRRwCaIVdKyjJQiNv7rgvmMzyCXsptm3WsOGoF/RKmr4/Frsu9MzVyOFwjtYrC
         wy1JitgCsdvB3dmvxNM6vwIL6bjwMQVxOIbsnv2BipvW6soQHp9ZhPZuHgLCHRqfCJVR
         6LoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NaRacMAIbT0zf+9+8JPgWZVOEMFjv7cQZrTI6Ni4rVA=;
        fh=K0RZ2nXBxz3LOYk0g/1KLYyHdwT5XvDpADt8OCdctrU=;
        b=go1vHLtluWSeIhWiZoNosknaVddamenFwjZkGcHHJ2syk6KqjmuJMLnAccCvff8DMj
         PKV/HPnJgGmN4g02s6tAtvQgwjmpJiS0FnUunt5ekyU7C5JQlLGorez60ReCuyxaoRwF
         CMAv+WcNSKWGCFw5ZVFLxYxIMPxiGBtlWp61yns1GoWJIx+em44tMxyF759WVYICcrlp
         UFuDy4dZr4RNrvFaGJ8dCeMZF7Qo2+fSKHmI5gbseKspGgjrU38wUKtbL09oJ2egllwc
         jMkFfnw+o1Fu07F9NuYTbHNNKQQ7ZTVT++JX8b7QUPYPEpFUQM4ig3j3bxs/4S+rUMK6
         FWrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785231617; x=1785836417; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NaRacMAIbT0zf+9+8JPgWZVOEMFjv7cQZrTI6Ni4rVA=;
        b=gicW+k8CU+8tIXdEbfIqhQH6M7BWiN1R1ssCNw5xEUmYd7d48jIFSrUbiYoY0zeBz5
         /Ry+cwRex2qVrW1GPub4U7sx8Va3dXzYWJhI70sc8HxpqDRS3MASzZyHsZWTS2LgMarT
         GmMpmBE85gZevYSy9RpvwczB1Xbxc1Ptf5mJ1Bo3X0NlWuaSqwxYOPlyEo9+0oB7TyoW
         uBPBneBNStaM0zHw7C7R/FLYHi4rQQ9wm9IoSwsKbWwo/0uCMuyzJNMhkEo0jlf4FU7j
         KOJQTdV01Xyiae8U2Haw4mf1tCRxP3ygXNyAlq5Ws3RP1LO9QaO8K/a2eIAi2POliNxU
         GG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785231617; x=1785836417;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NaRacMAIbT0zf+9+8JPgWZVOEMFjv7cQZrTI6Ni4rVA=;
        b=YukQ2OVDUjc3utBRsOI54W+ij+2j2q70z3ctCuya5OSLB2XgohalozUJnZCwForYdU
         hguI6S1Wh6qR6kT09Rj32eOHPL2TNm8jVYkup7nC3zyotH3Za5r6Kt//qmJaa3oQr2mn
         TOhsCJqlgomw4d/gLNbKaCBP26AWU/1w9HZpwEOp1BZMtQp6mgQQZWE1eYgkx9iinV/S
         +Ai/mox2mX67c515OLYoRnsw91aq4YOTuOSzSfro7K5YOM123VxU95NBocFJZ+Ud3c4F
         fR64YCyUdbYBoNSSWLKhoXsAQcYRXuBFqd8QYHHdwbpneLqHi06eq1FJ6WT2qcyCMTTA
         MavA==
X-Forwarded-Encrypted: i=1; AHgh+RrdtR5VCiliVd5ygv/zwn0f5i8rabMaBX7AOFvBAFrLJPuFjDQaVKIngNcpqpQtfpX1y1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQyHpr5FcUCxWvOFTyx2AgP3HInZJHeBeqLCR09YGdrje1gbKG
	j0fm/bWUD36li3hbkQtw68hAVh5ZBJqXNjjT5FtU3oMA6RyTLfXq5I3iumX1BZvp/pUG1pMF6it
	6iLbL+AoredT9kRBe42UDgt87KoWpt9Ld+ZLzNlAWMA==
X-Gm-Gg: AR+sD11uuinQ89bvlRY7+IHFUrdDEQck7bMPq3p2prmhOyXRBGfD+adz9nszGfjTDhz
	d8kQ914ESNkH3KeCurj+QHl+8z5eiCyw06ynwgf04UaE8NchM4CgnlRwZinwFnZUanbvMyQgTKj
	SOl43SZiKHmcOD7PvV651XWfLJlBCxJmRwrSWELpPoXW9YNjxLolwYfjnGVItOgXxOCWwUtOk6S
	wdVvSob6Mh+r3HgHi5PGOEu1sT9ae8vhpfZ3reW0h8gHr/59fJ/6O9GJUg08ccWb8GweckzWcOo
	o/ZF9Y4wk2zRaPZ1IKEh1A6rsAHgb5aPrAcU2/0ltqqc8ly/l0huLRYe
X-Received: by 2002:a05:690c:250a:b0:81e:d656:9909 with SMTP id
 00721157ae682-81f991faa6amr8140497b3.1.1785231617336; Tue, 28 Jul 2026
 02:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-pmu-v7-1-939518c349be@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA-=u3ZgiAXRNWM1VCMv7FYG2YP=oirf40yGo--p0BSfbg@mail.gmail.com> <39e270ed-1667-4bbf-8732-913e8b1f87e8@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <39e270ed-1667-4bbf-8732-913e8b1f87e8@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 10:40:06 +0100
X-Gm-Features: AUfX_mySqC9ltK0KFuDMKEMZTn6u-bGp6fw-nzmfG1sVgTzOupa-Mk8nMlvhu-s
Message-ID: <CAFEAcA-_mSr0e8yePxoxW2wS7xAHtTzd8S5MfLWwr_BPkAD+Rg@mail.gmail.com>
Subject: Re: [PATCH v7] target/arm: Always add pmu property for host and max
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org, 
	qemu-devel@nongnu.org, kvm@vger.kernel.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jul 2026 at 10:33, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/07/28 1:10, Peter Maydell wrote:
> > On Mon, 29 Jun 2026 at 09:10, Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>
> >> kvm-steal-time and sve properties are added for KVM even if the
> >> corresponding features are not available. Always add pmu property for
> >> "host" and "max".
> >>
> >> Note that we still don't add the property for other CPUs that lack PMU.
> >> This is because we do not know what a PMU version should be enabled
> >> when the user sets the property to true while it is defined as an error
> >> for the "host" or "max" CPU when the hardware accelerator is enabled and
> >> the host doesn't have a PMU.
> >>
> >> This fixes qtest-aarch64/arm-cpu-features on the hosts that supports
> >> KVM but doesn't support PMU emulation.
> >
> > No, we should not special case "host" and "max" like this.
> > The "pmu" property exists only if the CPU has a PMU and it can
> > be turned off. If The arm-cpu-features test assumes that the
> > host CPU always has a PMU and so always has the property, then
> > that's a bug in the test, not in the code handling the property.
>
> The test correctly avoids assuming that the host always has a PMU. It
> expects that the run-time-derived "host" CPU has a stable "pmu"
> property, with its value reporting whether PMU is available.

That is not a valid expectation currently, because that's not
how the property behaves (and is not how many of the Arm CPU
properties behave). If we (as has been proposed) refactor Arm CPU
properties so that they're class properties rather than object
properties then we will have a property that is present always.
I don't inherently object to doing that.

> That is already how Arm handles SVE. Commit d25293068b03 ("target/arm:
> Move kvm test out of cpu_arm_set_sve") added a false SVE property when
> KVM lacks SVE. PAuth and kvm-steal-time use the same general model.
> Other architectures do the similar; for example LoongArch KVM does
> exactly this for "pmu". So we are avoiding special-casing the Arm pmu
> property here.
>
> The comment in aarch64_add_sve_properties() gives the rationale
> explicitly: "to allow -cpu max,sve=off to always be valid." sve=on still
> fails in that case. Keeping the property stable prevents -cpu
> host,pmu=off from becoming invalid on hosts where the PMU cannot be
> enabled. This also matters outside the test: libvirt emits pmu=off when
> the PMU is explicitly disabled. This design is intended to follow the
> alternative you described previously [1].
>
> "host" and "max" are special-cased for a different reason. For fixed Arm
> CPU models, the property is omitted because its semantics is not defined
> when they don't have PMUs. "host" and "max" are different: "host" and
> "max" enable whatever PMU available, and fail otherwise.

We should not special case "host" and "max". If we want an "always present"
property then its semantics should be:
 - always exists for all CPUs
 - if the CPU can't support a PMU then you can't set it to "on"

-- PMM
