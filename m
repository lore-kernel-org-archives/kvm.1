Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F53AA1A1
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784235265; cv=none; b=n0dszhJF8w4zwTDwhb44wwSVJStFtY2CEXdR1O/A/k1bDRLtxXn3OWxtLEv4DHVVXUym7dLk1iO5GGSkZzRSs6rlFi6adnATAYB61UEyt+/MrxHZcuC0kQ6WlW4E0Daw8cmoRhiz0zSh45mVTsTVcI4vdZtrcZ0vxZkbAyKhsv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784235265; c=relaxed/simple;
	bh=qRjhuCsO5as+7lZfGtHRB4kpUgjF68RomSL+mcrcOOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sC37akNuo3mDveG5kuOfkNi+lcEk+D3maXfQe39q1q6xxUcv2Q7mnN40nVaO8nyMSG1YQdpZpCed8YZME75xdXLxsEvJRZJA4AUGnzMy9uU1YSRgu5Zy5xeOsI8NBarodNFx2NJgErMQ8lkRlkUle8s7INQC6e7l5k/5wt2+UbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kmcgoWUF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmcgoWUF"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso3969503b3a.1
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 13:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784235263; x=1784840063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BJzIIFDdDzqLtCWmyUzRxr6o/+lBrb/0M6xgQK1DoGI=;
        b=kmcgoWUFmGhY/MR+kTW3E4lgCKcnIXe3+W1Y8zm3navpZXLPWrOKhEaPkGYdmGwvw1
         3nZ6wnd9m9/jigXqSeydBkYECjq0PJNPgUL26i0wt62jrwx9aMmrtb3atUGsdbZ+sgG2
         gpOKdCNLx5dQeIOkUlBcjA+z3mXBVmMKYMCp18ySNfX6O/Cw4zftuAi1Km5dT4Baved/
         Y7Mtf14R+rl0Gr+M7vCO8WmCpsU5a4JuoO+5Lg89+HlqGSndP7wvtgDL4rhT5EW9SiXJ
         2adadZtTjLIQ/0THD8n2mhlNYrtuHh562tn50pIQ2yhQBZFpz0gn5q5/yeBvn21fYJ9f
         gIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784235263; x=1784840063;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BJzIIFDdDzqLtCWmyUzRxr6o/+lBrb/0M6xgQK1DoGI=;
        b=gtQsCA6oE/i4th5+omHD4mmviy+A1XJjnuhmE7UH07I2iUcOZ6ZD4sX35csGJ1o6UI
         pEbD/azl9eDTU8+IRr4XMoK9fqgzfGyIxKdoyEUADkKhikh/q5CbWtYqLypWojsUWJL9
         et9vW1Mxv8eMD0iz+hzc1DDCCjNesnnb0jue2MaQS7yapmCGAomzbEbGQNUQZkG+I/Mc
         DuFVy0J4nPCdqKPF2gkZK9JqJRkXO5kc+LEZcwbufXVa2KKClujASRvA9eXvYpYGxe6D
         IVc+h4IzgEiqtmwyyRUr91oEIhJUf14O0D6wLFu1Om5iFLdMZZBEo5oajNXSk6aZV8oh
         KyAg==
X-Forwarded-Encrypted: i=1; AHgh+RpFfBTVqrSMBPXUCcYVaQdMq40xojNuunCazojfQ72udBO7VD14NRRqAeX0sYI4MfMfA2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd3Fk2VbrcuODHLTWxee8PVSJG5Zj+5TnAN/I6DMTekOHWini8
	6btERZLVorpfocG6BNOLohjFXo7KkRAkjefklx4Q6IZIr0kuAcVNB5eovjIVmd/4YK0=
X-Gm-Gg: AfdE7cn6ig2gbwuKedVKgwJVkhQdsbo45Y1VlJF5w2vTOd5vOHLixvJIeJWS3l8nhK0
	har11KmoDeoKSNpOeJqQeSK9Mc9IemjbsdMjJoiMWxudEJrxHakRlvs9+l6eHqkzCfddhg7349t
	rjwmBAlfLWLPYQY2LIpZnY3l6c2bgdXR34gcoWAAVVwmVjR/MqzUbnLzOJLoVrNoX11gNXAPane
	HM4tQex+eQ9Plx75HYbqyrKGTthRNvzOWk+MbFqf0PIhsvN6h15t41ymx0JNTiv3y/LKFxPscHR
	9oDeom0mclCb5TMix0bI5Xyhs2x8LG3KbXSMM95O17k6PMLs7jhBOe6KRaJDCB87YrN1qmZJXo5
	Wm0yxaY9/nD7Oqc7iQjpkW94gvKyeDrr7J8/DxQjCJ9fiWgU8MJV4weM32PMPPNE6zIGjJnBUG0
	6fw7EzGA==
X-Received: by 2002:a05:6a00:1808:b0:848:6698:2d5a with SMTP id d2e1a72fcca58-84a6726c042mr7950638b3a.20.1784235263350;
        Thu, 16 Jul 2026 13:54:23 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:bc13:5578:20b0:9bee])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eb856dsm2492407a12.6.2026.07.16.13.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 13:54:22 -0700 (PDT)
Date: Thu, 16 Jul 2026 14:54:20 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
	lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 08/25] target/arm/kvm: Use kvm_vm_check_extension()
 where necessary
Message-ID: <allE_PUn5T4FRTXr@p14s>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-9-mathieu.poirier@linaro.org>
 <3ac5a5b7-e41d-499e-a4d2-e9a5a78f8c0c@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ac5a5b7-e41d-499e-a4d2-e9a5a78f8c0c@redhat.com>

On Mon, Jul 13, 2026 at 10:43:37AM +1000, Gavin Shan wrote:
> On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > The Arm KVM code can return different values from KVM_CHECK_EXTENSION
> > depending on the VM type. Use kvm_vm_check_extension() where necessary
> > to ensure we get the right response from KVM.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   target/arm/kvm.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> 
> I'm putting a note here so that we won't forget. The following changes are needed
> so that capability KVM_CAP_ARM_NISV_TO_USER won't be enabled for realm guest since
> it has been hidden from the realm guest in (v14) host series.
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 3d5e16a21c..4c52ee7e1b 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -623,7 +623,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          return -EINVAL;
>      }
> -    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
> +    if (kvm_vm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {

Addressed.

>          if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
>              error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");
>          } else {
> 
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index 6aa1cd04e484..c69b5310c184 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -328,7 +328,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> >                                1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
> >       }
> > -    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
> > +    if (kvm_vm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
> >           init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
> >           pmu_supported = true;
> >           features |= 1ULL << ARM_FEATURE_PMU;
> > @@ -654,11 +654,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >           }
> >       }
> > -    max_hw_wps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
> > +    max_hw_wps = kvm_vm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
> >       hw_watchpoints = g_array_sized_new(true, true,
> >                                          sizeof(HWWatchpoint), max_hw_wps);
> > -    max_hw_bps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
> > +    max_hw_bps = kvm_vm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
> >       hw_breakpoints = g_array_sized_new(true, true,
> >                                          sizeof(HWBreakpoint), max_hw_bps);
> > @@ -1905,7 +1905,7 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
> >   void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
> >   {
> > -    bool has_steal_time = kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
> > +    bool has_steal_time = kvm_vm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
> >       if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
> >           if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> 
