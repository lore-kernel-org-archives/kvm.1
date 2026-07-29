Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17F33B0588
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338414; cv=pass; b=ZwTlg8/OXiQbTCju9k2btT5EwnLnnsYOd1fWd2ooVHxKq4EQMgsXnBTDpZ3GwItlRaCp8FrsVuv+fAQZxFz+MxyKGDVTY3R0P2VP1MwvLys0/NZuUo9HdKFH+JtYOkccqUqEG6oj8lpmw0JeYbsJc4o1M3+ryH7xkUrP/VUm6MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338414; c=relaxed/simple;
	bh=3BAdkEbGZqLfwXxKr2RxchaDtVa9lkmIZOkFm2/fWWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNP0kSiSvzcL/TaAtFse5zsNegeLKAJJcYl0lbSZhXV/kJHOvm1UxLJIczLbWiR/MTJKSI9VSzjBeTTcqsCvm8K7M/g4iC4nzaH+cShDyk76yWEmKd10hkcQX0u5Ri8e5jJE6ZBKeQ6+5KqOHJek0pUBUnEg8pPbWedkrARPRyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=flwBmU+8; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flwBmU+8"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c10e86e52so280021cf.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 08:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785338410; cv=none;
        d=google.com; s=arc-20260327;
        b=nFtoRVDCjvJv1LnRIkZHe9mFyl8BFdlQljDHsbMlQtsKWLQp17eT0oeXuXPeYe2sdd
         3ifNpeMM4XAh5j+72ALFmGo6kkV0drEybbw5a49JCCB7aAzv0bvCpvDDQH5PXpATJbX0
         TXLP62kvqIlWgvq6QbtmEarcw4TEL3byITnbKynXoruNqlIo98CWWpvDoN5EktT7PzLq
         5e8OV81ES2ydSEDmwQooIbfkwfHScEHn+Av4CXIn9g3nRmtOVcbmPul6Qj1MWexPk5cX
         8v7rHYA7TiPdbs22nwqcNzbYZeDa+FXT7kUShabnJ/ss1VVRFh0zniL6HBuwUYDSHwKl
         /51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JYgZt/35SRTSOby0/Cc9E+OqarqONJhII6K0Q/18dbI=;
        fh=xH8jfQmSaHqo7gKELDx6oiAHiyiYo0RqR+J3u0amzl8=;
        b=BENzm64LCf/UmJ+1R8P4Zg9QPXfdY4cnCOnvqMVi3QPC+OUB8d1Lkx6WWIu4HV0EaG
         O9CSDQkCpi4HXyqJ2Op3eC/UMMUoL5e8TCLarsl7XhTNWa3GjY1WqfMybe2gPm/HXK1W
         mEB89IT1Nt1ajVAB0Ak5BSAQYu7uqX0fWAWfaAHjTJsxGEal2DCrYHwBBr8NQynIIpD7
         C8UQ9O5bPJjcMKD9FU8IRmYuGzNOTWQ/G2E7VM/9BpuA55AYSIn2z/Pt+rKH4N1sik0n
         1MlY6fBNZmjAz9WMX/PGrnKEYyTh+noDmvsphOl2f2ihg95hDHr6f60ERHYOrVceMf1v
         Vrrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785338410; x=1785943210; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JYgZt/35SRTSOby0/Cc9E+OqarqONJhII6K0Q/18dbI=;
        b=flwBmU+8K3TKZ4m+kVr/qD3PwiqtKxCBtZOWMCEzCQPDKE660BJkTnvZLrrGCOKwAI
         VCQojgYDfZCWaOWKJM0M2Y9PVXPYOToE49vwJ4NHRZ1VuERrWOQOEwKUp4CDr9mVMOur
         oEFVHoWrY5dqdiWN/uvtTMIS//nmrNtYWM2m/Qj65HxLpQxEU0uGnJqFFUV90VNySugR
         ct1kaHpci+Sg45BXe77xef1s2HKul1bAoWqSFoZyCm3G3sWuZOsOHGZWrl5xwtrCxsXF
         opnkgHIe8rGQxa+fMtlMC2Pr1NpX/F3eGQ4CKrhQ2TVbccGaAALanGXG0LZzyioKaqRd
         NVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338410; x=1785943210;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JYgZt/35SRTSOby0/Cc9E+OqarqONJhII6K0Q/18dbI=;
        b=h5TYsBn+UZnRdJwUP+3cgrn9vRaS4aik9DJLSoXPjPrfBg7JZ3mphhEhO1qw6GO3G4
         8YneroXPO33PtZjidND41UbasbS29x239Y7LeiX+DUdYklSt+5ILPHBSQolp0eY9a1aC
         3exr1JyVhcrQgntcW1YCztFLRTNtYzeOEhVPa0nA5yDJJ+uoJSbz0hhVsJzmVwNFyyIZ
         2tLD45ffHaPkmjSE6fAP5xPD5StzvnT8R98hZr18zo66kfeO3Vg9ZQflDme2505OdogG
         7x81kEWzkOWcKWIbGyh9otcY/xvalV8rfcUkJnmFblBFznu1oBiKeqkgawxn7GbWUpyh
         EqcA==
X-Forwarded-Encrypted: i=1; AHgh+RrO4HUSTRaoGlsDqHqP7G1QtKSw7fof1QsLGbvVVGaYFA0GaQQJjuS4eudBO3ZuPX9xotM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXIxbEA02c7H6bhgq/p3nLTN77ScnIrVUVhg9oBUqX7qcKlVM
	qRww39RWJMpUizNmRvzu/Wh1RE0PHN+1KBrM82aEHHWYJkBp2/lQG835c8rzvefDRhcOgnLC0dz
	RqwYjTv6bMoU9+SVxXroE1BU+sVv5JZsdhoECgKJ4
X-Gm-Gg: AR+sD10vtboTKsut3Gxq2qcL90VGtuyT0DlKJlerAuv/mGcztXtuqRuoe79EwTH/jeb
	6CtA75ucye4AM5x3qisCpuy/3eRApRrl0Pp97oVitLHBfJcvi/gDQY3gBWMoloxX9hOp/2zJc8G
	FlxTBRrTrqmDtv1y2Q8T/Qr7EWW3sEaYzPVYf0eARFPdPWBDy2x6cooSsW2yXQkcKUzI8vG6Js+
	9fEwfgCfLDDyDMVUTd1P8JtweoDOHuOHzsRHDfFjUmIzx3b9T2gkZSqweNe+tfQtusYOyNKnAZc
	VIRisHSJM+2tDk16IkOcQkA/KFTdptyPxFoLO9N36mslZUh+6HDrTrwEoqH7HPp2HjAg1JV81FW
	daV29jQ1/ZQ==
X-Received: by 2002:a05:622a:9014:b0:517:6010:7c71 with SMTP id
 d75a77b69052e-52b34e95118mr803001cf.4.1785338408902; Wed, 29 Jul 2026
 08:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-hybrid-v9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp> <20260720-hybrid-v9-3-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260720-hybrid-v9-3-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 29 Jul 2026 16:19:31 +0100
X-Gm-Features: AUfX_mwnVrQrZWbAViwhlMWDHtZtcw4flUU1g4ENMs-4TGfR7On64kQESsXcw8M
Message-ID: <CA+EHjTyYk0Dcc-8RbvQZHFBZ7HM7cekfg3O5MR4jo57qX5SohA@mail.gmail.com>
Subject: Re: [PATCH v9 03/16] KVM: arm64: PMU: Freeze counter count after
 first run
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steffen Eiden <seiden@linux.ibm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	devel@daynix.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jul 2026 at 06:39, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> PMU configuration is VM-scoped, but SET_NR_COUNTERS can be issued
> through any vCPU. Checking only whether that vCPU's PMU has been
> initialized allows userspace to change the counter count through an idle
> sibling after another vCPU has run.
>
> Reject the attribute once any vCPU has run. This keeps the VM-wide
> implemented counter mask and the PMCR_EL0.N value stable after guest
> execution begins.
>
> Fixes: b7628c797376 ("KVM: arm64: Allow userspace to limit the number of PMU counters for EL2 VMs")
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

> ---
>  arch/arm64/kvm/pmu-emul.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> index b5df6843dbcd..b4b877f31097 100644
> --- a/arch/arm64/kvm/pmu-emul.c
> +++ b/arch/arm64/kvm/pmu-emul.c
> @@ -1087,6 +1087,9 @@ static int kvm_arm_pmu_v3_set_nr_counters(struct kvm_vcpu *vcpu, unsigned int n)
>  {
>         struct kvm *kvm = vcpu->kvm;
>
> +       if (kvm_vm_has_ran_once(kvm))
> +               return -EBUSY;
> +
>         if (!kvm->arch.arm_pmu)
>                 return -EINVAL;
>
>
> --
> 2.55.0
>
>
