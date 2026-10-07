Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6E447F78F
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371623; cv=pass; b=F/yznwHkRyextXw7wUVgoG8Hdi4URFLHUv5DRHamfl4yX5Dny6IlmHT5QznsA7U7sCojVyCcbQVyJr06sVKaNVRRi44UssEXx64wx9VmO0P1vX+QMbS5c5nKK7isNw5pHPOJdvXbwVKsP30pujM1XLBaLl02aTXlQA1+IKNQsJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371623; c=relaxed/simple;
	bh=f+RisWKCQLZOEfrvNgEfr/uIKD0wCzcM3ghzQdvYe+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldgpD/OfU2gJ+d/XlQUhQ2+2rDWpX2OmnkA1R1Cm0rw4DD7OFZLYOQl+JgwD3MJhzjcnYFwqupcys7iUJSXyp1nXfz+pYEd+1d+c68bZhfFfWKvTPtCgBYG/+08Sdklw8jR2OxjWKcG+Lc8U1vyZWJakaaqgMuLPUpBiXAU8f+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NhFllpbc; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhFllpbc"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5ba40832934so5796e87.1
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 04:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791371607; cv=none;
        d=google.com; s=arc-20260327;
        b=oa72iCXYeSCeugZTbSPZ+Fod24LSN9KQBoIr2v6hKh5w8vHMiKe45ZeVyoXcN7KCcQ
         xxcDBbr1ztl/s7CiKSV9fMGINdXdLI0iVTK/NE1kUMY3uli0Bm3zT5zi4Zisdj8fSZEj
         tvlLeqODtPgB5YhmAe/7i1hBNVBPDBK+kPkCm7X41F88WQequmzWdkMM2YSxhiNma6s0
         wy8UcvrMG9pUEI2eLxi4sjErKnuZ0BcCmD9qcQONMCJpp8Q062g3eomEOZaQ6hHLoPmX
         Wurx0VI1Ei8iRDlcse3/EWmSl0Daa5fH6jBIC5Q+t/x0PD3A2knZSJZxQJSder31OQk/
         PvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f+RisWKCQLZOEfrvNgEfr/uIKD0wCzcM3ghzQdvYe+U=;
        fh=rnIkUf6r+pm8oCQPQDOHPhdYLJEIYxB5Eh3hMNjkNs4=;
        b=X8/iAJAVe5OZHT3uMTeul6AXfEZhnUayRuPzsq2JzjElqfHcHqbv7iTMnPUxOFaFcn
         tK5OtD9c8z6R3exbwJ6xo6N+g6DgkZcGxuABi3YNNsjehSWYSOqI/r3nB0uc60xocLBs
         fHdT4hcNAO8zEDIx6HN6I251RisRZmI6A5JRhaSowFR4Qp3ZPqf1dkRchwQcv/4UnWMR
         mFD96zKImF5Ez9SHDJ43Muen8szpFdIvhbHaQtnb96cJ2+oR27Z2e/zBjoiUkSFFY/Y4
         DMooz0A5BS7FCMuDsFt22PBq2KTllPmSGcqGEvjVIgX3vIHipYh+GUdFG79YGvrS0ONW
         n+mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791371607; x=1791976407; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+RisWKCQLZOEfrvNgEfr/uIKD0wCzcM3ghzQdvYe+U=;
        b=NhFllpbc6WrYCF0igkisKJuq2Lg0cbsTJIr/8fVrq8iA10QcPgskFHhSCeSBgX3Uxx
         Y2AvzOxqrDOxAO213eZtroAy7qWAxuj5mPiuOWTIZdrioPHXXXi5JR1Dl/OBrcAFh780
         B8WzJ2TljWUi25aVaPyJ6pEJLmQ0XAGp1tV2c0yqG2OPkel4fw6rRzZj/nqOEzPpoexe
         OkVhQ392gwTOwWXlbCDnjyldDiKnc6gYU4UhBH+5iGAWsHkpvFRGZUyo7X7HQ+o/qmB6
         M6C6osC7gfiq5sBXXNk/klD3cofVsQtfF0HHNk0S64VM0GihxJF2eSOg/1/SYyNRwdEM
         2EhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791371607; x=1791976407;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f+RisWKCQLZOEfrvNgEfr/uIKD0wCzcM3ghzQdvYe+U=;
        b=GgHW+7iyW6o4chSaHynrqIgC1ZjPVpkHw5s7BzbD2BIIdgsS48qW9LXladQOc/XT6b
         15NBylTx15LHZs13xjWuRmjBh3rQA+TkH0lXOtmDOXe80qARFr7FGcs3Bdd+hnCtmyJn
         beqiXp31diunUN3VrTRD5KxqsIQ1InGgZIHuftnZA92mCbTNEzpFd6h2SiX0BoufgLKx
         P+coMa4evL69rEf1Zxoea/Ooc02JmAYS4k3PESuHJR3RMGfYtR088imLFy3cN1Zo473H
         ucZNXCxxYPOA6ZxwDqqu4QN1s4E85MsRMlm3y/9K5dtijRQxW9ZZ1E3pgwmvQ1MBKaQi
         QGkw==
X-Gm-Message-State: AFq9FYLnlCTEPFHMXXJ1KWSUdk4u2GVIruIqQX7giMPSY6QCk2RlsB+V
	8rXRuB55XuT1h3NfQHvhlYF8a1Nc2907yXW0fKVP1I2B6Y439D+YG72rIzO5eTEXuv22M6Uhi2e
	ASdyr1L8jEJPuCY8CzvX4TN3RdXaGapR+HRQ+2HHQ
X-Gm-Gg: AYBFou2wso4fDBhG5vjFw/xXZ3n8/bXYz+5pPKuaBimBlch/qalB5amgAIWY9xR6e/P
	eKGXCn79R4vqEGp3mEQ/lmi3JLdFkfPNh6pwl7czHyy/ocqryl8ypJH0Ci100N2au9tsGq589iC
	UGl6V18XCqI8DyN71X8/XAUwKYxtofSeN7QSdTDmXcz5q3VWO130oBgsCEUSSIQp6UmGpSpIfb+
	IjJv+t8LqmdqffeeQDWqXMp3OCe8f7DSOjyoB76KuSgn32Az2yMVEBdoYNiBWGs/u+m6+GUwKI/
	BnUUg1WL4N+/1djvAohRe5gAZCWTS9i1uKf/8NUmxoCCpYj8WoIndeuSrA6i9EWeKA==
X-Received: by 2002:a05:6512:135b:b0:5b8:f142:cf3 with SMTP id
 2adb3069b0e04-5bcca65b3acmr273089e87.11.1791371606791; Wed, 07 Oct 2026
 04:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007073537.2454351-1-suzuki.poulose@arm.com> <20261007073537.2454351-8-suzuki.poulose@arm.com>
In-Reply-To: <20261007073537.2454351-8-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 7 Oct 2026 13:12:50 +0200
X-Gm-Features: AclHuK8WLpu77qQsvdg4MDduFoR68Hrl6zUyd6Su64I0GC1JFRH6-dZAB7pnQNs
Message-ID: <CA+EHjTy2WuCui_O8sYXviCmgLQfZ-j-jOBQqRY9NOXzMGQ5k+Q@mail.gmail.com>
Subject: Re: [PATCH v23 07/14] KVM: arm64: Refactor the vcpu_load to allow for
 VM specific callbacks
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com, sudeep.holla@arm.com, 
	jonathan.cameron@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Oct 2026 at 09:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> To keep the VCPU load/put handling cleaner with the different kinds of VM
> types, we are about to introduce VM specific callbacks to do just the right
> thing. In preparation for that, make some refactoring to add the change
> easier by mainly feature specific configurations to individual wrappers,
> so that different callbacks could reuse the helpers.
>
> Adds vcpu_prepare_mmu()/vcpu_put_mmu() wrappers to load/put MMU related
> configurations for !pKVM guests. Additionally makes it explicit that
> kvm_arm_vmid_clear_active() is not required for pKVM host.
>
> Add vcpu_load_pvtime(), vcpu_set_wfx_traps() wrappers for handling the
> corresponding configurations.
>
> While at it, also make it clear that the timer loading constraints only
> apply for the VHE.
>
> No functional changes intended. Based on a work by Marc Zyngier.
>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
