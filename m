Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38D2EEE83
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649848; cv=pass; b=rHopfqEffgRZ40DyDalZ0uDr9uWf5DdEn0b5VZzUDMHxxkk4YMaAoYL0TjtUgxYIJj1VLpDgxBUMPTSV30auLw38P5FxvnBCAYzK61ouBwekLHEPpz6xHY+ZUIzDx15Yx1w69lziVvPIpOymcD3aj3ptlY14uzn36CfxCsvObNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649848; c=relaxed/simple;
	bh=yjGleyBftL4mc4+T7OaOkxuKfXAcAseCzpwWbCEkYR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5wwduJr5SxPer5AE01W66jZb6qTX5mHbTq+2qTYtXjkcO0skl+JE5ddVePZdS2g4ctU0EKLEM8Q9f17OfVDkUSE8QpfbzKAY4YJdJctaVcUTkfeo1oIhTqSfaqu0zBnxIfOuppaN3SyMP8Gh+A2VvXdZjEdcMK/56J7Pc5fxTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qrwO6V5i; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qrwO6V5i"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b83c1421ecso1628e87.1
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 05:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789649840; cv=none;
        d=google.com; s=arc-20260327;
        b=MFj7I7um2AVaeixZ+3wt+TAj8ZWWyEIeBpgMyqj0d1qHXnk8ZFxcX97Km/ZAvcL5wv
         EHzr8s0NPU2odTR5APGhaFqCv73umDxbOUefUAxfKdnLt7GyzAmFHsU1tWh2fItoLule
         Tdd0qgOEctn/zAWYrghftfAlawW2nQLwWus78EOY1PIj8pLRBCdHmruTLEzMvmCww3NT
         24wEg2tmRs6Vhp2z5WNxRzrWAKNKwE+XVFnoMjpPbD5H6EZv+6ygQ9G5a8fGEEeyF7/J
         bTAn6pUxMVTkPyjV85xEf3QduhThd8+z++JKp+rra207R2ID0CdMBQe+/FwBCzYQpvxT
         5Thg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wCB7kYcnG02MJOJXUn6C/taoVXipNbSEcZ1HCYhjZfo=;
        fh=Ez8NpNZlYpJMs5FsbI2d5a16stCZJhW3aTDCQxMMJyU=;
        b=jeEsGYI72xEIbBMVQM85WVOx3X6/mWPoR10OwrQFhNEtI5IVDO+Uf56czyKh72D28i
         e+zOA1WTISReSDN8rpovgONAHPtrbL4tb0Zf/1vC085DK00ckAFjrg8qwRMFQaCvD/0d
         FfA0OK+1fDzgIwNrVRKF2uDjNgIGgT+pPf/4smo2MazVfWMp+gxR0+8Rpwvfn7Uv40i9
         zYRF43ewVbAYaytl3k8X9gLCtKTLmTi3NnZLc4W+j2GEveaapcM6P4eL12uR5P4Lj3dy
         dFmSludwdfntijvcSMg6yhbYKgnRR/FBYekx7ByNPESJSIh1xDtCvWO6tfuMY5AdBirN
         kDiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789649840; x=1790254640; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wCB7kYcnG02MJOJXUn6C/taoVXipNbSEcZ1HCYhjZfo=;
        b=qrwO6V5i+FcCrr5WEE+v8JMCeu3t7EO2A6l+G3mMxjKjAkV/enOF48qwJ2xTuFMvVp
         FDeI78Fk44nAFgo/X5CP2pD2Tx52cekGiNOqzTq0RMm98zvGlY1chcMDNw2gHOEXOgkt
         GACpXMy99WT5+lNcTgRJR1oLL1O+8z7BAMo7zBa00Ugc7OM9NRIrGYbaXberlmFzQRPs
         Tem+ZcAMz7sQW4bp6i800niR35r+pQGe2Bb3HqH9XVbME628Rs9c0TYCnRaLp0PgqtQ1
         iHWv6kFrYKGsmRSvzEQaq5Lupwd7WbxrEM19cGRUMETW4NoqfNGQg6HjFjTUUhK9Etj3
         Q24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789649840; x=1790254640;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wCB7kYcnG02MJOJXUn6C/taoVXipNbSEcZ1HCYhjZfo=;
        b=LPMHv6LuIL0NZko50AIitidzJRs6/5IGBFuOvdgOhBFdourivOtpUkhCWMHKHCFq47
         Y1bvGstHt/DGdErYx4lwjcEHxMsd4C+RxMH1OfiDaeFzUoto6JN1+Czgpf3E9wQAz+Bs
         EPX/9p1eupmV8gjmc/QrsCbNXSwMNUWNiExmt2CaHhkFAKB4NNV1W/KB4NjV5kubnnr2
         4u9ibz4yGUHjfUFdwnjOZ6GKWS2T5XxJZSCrhtZf3DclP/EWjsxgHUMcArDJhPmwbSBy
         qGvrosV+OvLvuslYA2D7aZRF7bRSjEUdDC41KY67Ye/R029Xf2uIA4CjgrYxQ73gL+dv
         09tQ==
X-Gm-Message-State: AFuF++mBoyewhCuhfNFQ0Ywc+vpj3PEjQmzFlG5HynC3KliOqAd+253e
	8G+XSD5xVtWer9vW3wGsUdkV9TSJLS/4Tnvd4Wtdi2dYr6I6SUOa1RaiPHR0W4Yh2+dmn7LHfFB
	OcQbNA7VBwWAg65an3c+phP30Rky+ejw+hVc/2VMk
X-Gm-Gg: AYBFou1rN7D4X1ke8TzzBv8vvKuWP/Fvui+2/mLxnl6vskmMIsxXErEnI0szx52E3de
	fDqDO/aWn73Jqz4b0Glsp+OGWNLoA6r++BTRHNOE2y6W1mJfXM0XLi+Ty9DDPGyitxZfnUPahXy
	WhyksBOKFNe0LRHUxgfPFagVsU6t0JfKqgrlYXYheetAgMXHmFPJzk1LTkOqJbSwyfv1FFe2R4I
	zEsCdDDic7FBosw32vjFIsW3MHPQntDpZLVw+fbOEsVyr+QFEyoV1X20xH4oMOT8lPQoKYQJaI8
	94CQS0SZChvFLpdvD//WRfZwNR4Y38qnSBuWSqaT4AlET9sES4Dmw3FOfBr3MdyC/9Vscj64PEB
	Vu83lOrv6R9/ofQ==
X-Received: by 2002:a05:6512:b97:b0:5b1:571f:715f with SMTP id
 2adb3069b0e04-5b8bff16793mr25923e87.3.1789649839151; Thu, 17 Sep 2026
 05:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915160141.3543048-1-suzuki.poulose@arm.com> <20260915160141.3543048-19-suzuki.poulose@arm.com>
In-Reply-To: <20260915160141.3543048-19-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 17 Sep 2026 13:57:00 +0100
X-Gm-Features: AcwNN1X3rwZaClpg5QtpbmDuAi81nkVt-NA4XEMnqdzMUr4WqSiJJDooQvLcWZ4
Message-ID: <CA+EHjTzKjjEuAuoOuzGG0uKyVZE-r+CEreca2H2kEQYuRPpgUw@mail.gmail.com>
Subject: Re: [PATCH v18 18/23] KVM: arm64: CCA: Mandate VGIC_V3 for Realms
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki,

On Tue, 15 Sep 2026 17:01:36 +0100, Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
[...]
> diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
[...]
> @@ -84,6 +84,9 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
>                  !kvm_vgic_global_state.can_emulate_gicv2)
>                  return -ENODEV;
>
> +        /* Realms only support VGIC_V3 */
> +        if (kvm_vm_is_realm(kvm) && type != KVM_DEV_TYPE_ARM_VGIC_V3)
> +                return -ENODEV;

Could this be kvm_vm_hyp_is_distrusting(kvm) (with patch 13's compare
as >=) rather than a Realm-only check? A GICv2 isn't possible under
pKVM either, but there the v2 mapping is only rejected later, in
kvm_vgic_map_resources() at the first run; this would give both the
same -ENODEV at KVM_CREATE_DEVICE.

Cheers,
/fuad
