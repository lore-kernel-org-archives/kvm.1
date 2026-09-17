Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D134D2EE6
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645673; cv=pass; b=H/aYX2ABdshjFCYgj80qFEebzjPEEt/c/ATwBBEFZyHdlWYsD8JdYkeBTEDIQp54h5qKZL8X+iADz39DZdIN2Z3U04phCX4SXqlpP8SbOqSuSMXdxbi7yVyb8VnGS1Y+Lt+VovWRk71wRdiAPk/keUaRRQV7g4Ey6SvrRwqBwZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645673; c=relaxed/simple;
	bh=FzFQy2j7fd5eTJJCXIk006/qLEE8a/Xai2F79n9BXDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3rHdkvUVxSB+9dssgPxbBqsRjGHn4mXpx7B81Tx9ry2UZQ0H5nCbxKjoa++G/U2qymVB5z2XlU+D2/Oet8PT8tCH1PTArNWbsXVPbkWTLH2y+3MYEXt3iscm6MCfl5JlsZJ9jfI3kWW07goY3tLQFWFYWNsoYwbLqlW5AnY5PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AxxjaZA5; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AxxjaZA5"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b778bdb5b8so1003e87.1
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 04:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789645669; cv=none;
        d=google.com; s=arc-20260327;
        b=CY0ep6eIYsvE3wDypMOlBqKCUenCzahVwU+BRPMpwIuAqIH9RisnRDavi5cBImRaxb
         lPFK86MX6L43tuL6ltUyENEWrNeQmKTt3J5RzkwcJ6EsKgZ9oPbTiaZxBhciAwe1wEUD
         5GTc17DOEmQbcHk0Ozzsrr2Ays6Mtvt+WtJnPYB9gFYMu51YUrVZcBNk93sL6Oclhx41
         jHWlEjnU9yD4NCq89P4ikcPa0UDiQ/fgiZ5bXDUHSblETLrep5vfHb0MPlxDXqcsF/hE
         4mcpaXv2zyeYrlubZc9McaS5Op7sx7ETW8HgiYvu4HXXBgb3BFb8uYGy1M41fsBeaAEZ
         s0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AuZmGKQOozDdYhExUfv4iQ5oFoGABaotqoRByOfZs54=;
        fh=Ez8NpNZlYpJMs5FsbI2d5a16stCZJhW3aTDCQxMMJyU=;
        b=cVbe/+8rZJPh2GWobOJgj2NnR/dK2Cz4R5cI/eadkixBs4QPZ3YyvAKNdwni5T8wKO
         Eps4/zUwsXOd7TzeQPLgyGV+TRC8acVInLD2sACRTAStXdF0dcNhIhetNaQMkgkLs8sY
         ZaF8zfs7vH1n8mvgcTxqUqGPAUZU2mng7N2PoT3ChTTWBfYmwnzS6ZWPV3kx35sCW9Fk
         7i7Vbh4sH15rN2YvRuiqCSelRBJCtxwrp0kQPJQyil9TEnNl/kVSryn9/V4VqpxikQzK
         f0K5gnVYORXxaHGPCGLUX0+HjCg02tQJ2c6QxDj0U+96NVSPf0+OmxbIuPM/neph1U0G
         CEkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789645669; x=1790250469; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AuZmGKQOozDdYhExUfv4iQ5oFoGABaotqoRByOfZs54=;
        b=AxxjaZA5GviweJ17Q3K6ID4epFqp79D1CYzArB+FfA+Mj0RUK8DqzonI5aaqRYmVF/
         PA7vHqlH9J/RuYk99E5Zb/I9B89zpoHUMWZhvzz+AzdFdRa0XgKp2ugr6vl76b7EDFI6
         s3XbQ8KKS5eSfbPGy+1Sn8fg1HKj/whH9ib7zOqt/nXyRznorH3IN4GGN6BEQL6NZXaU
         iomkvOD61uW0BWZb9dsfETh8JkXpbwVME4gmrjn1WqZEJRTo3TmPgW1jBlrZ5My4j3Mw
         e11ikF5EeCB5O1qFWOaSrFmG9z68xlzPYiSqLNcHsr4Q68OHgqMA+RGQvhFeRhbsXK/t
         HlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789645669; x=1790250469;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AuZmGKQOozDdYhExUfv4iQ5oFoGABaotqoRByOfZs54=;
        b=LXvv13m12MN2AtFlpFo8pla7V3Pv3qSjvAAQz2/k575B849FwvZqrm2KknkTyJhVaE
         kZB+ZID1brlqMMJ3zrg5/1mu6lB9QhBAnml7K9rxPI3+JRqvg6Vtg7LV5WnkydYH+3PX
         y+p1oAT6+CTJdsqvqWMGRFAOSSNHe9u5eAsa6HL8wbv6d41zk/VytrsSriwTD7S65NEA
         eeqXJZBrBAFOQaL/oHSlsOBDDOTwSSZNGGH1XFPoq+SemDX1Rv1TQLmjJQyOkaO2O2Hx
         Jyhvu9sxYmc9Sg72dICB0v3C0Fx376bWsT8DG0c0VnIedFdqXeJ9vz+n8MqssR8948vy
         Osuw==
X-Gm-Message-State: AFuF++lcp3G7jUtQuxHbGWqkNMY/uiqPsfv6uIky+vUvo5pZYdginX5e
	ABqMzdXWbU++3Yxim+xH6y/5ValBDapEQCyvJxaBbY/wZuxywGvcrKq+LVmg0dQd9ADuaWZHleD
	lEcHoI+boVNJTDRtrpGJVZ4m9dT8GM/QM1OTs05g7
X-Gm-Gg: AYBFou1l+OjCb3zvDdBr3V894Lm0ffGCMvZnNYlRBSO99KvLTiMSV4X8Y9mRAGzSC2P
	dEV6LzftwIsFKSokDh4H8pdrDxxImBPjocby9Jkda9jxLCWx8YEzO91rc/lnDG8+mM6d1H4lA69
	TID/CeI9Kou5a34FPUj57px2iOoYdCtaxavBZf00gj+9iGWYI2ZzFE8Ayk+h6Ww7XiThmOEbK7I
	eroIBNEBLvjgCrlsimngTo0kyRPxzg3Ec3jeJxaixW76S1y8E5ctKm8IdgReh6VrPbHyD8WcYzH
	bcpLNo+KHWZ2G9HIHs+pv4KReEQkv8Cnys30mZVP+qDCCyJZZXL4ozErLVNwx4Fp7COQBs4RSFX
	MOKqacp/C4w4KWQ==
X-Received: by 2002:a05:6512:3c86:b0:5ae:b726:5f1f with SMTP id
 2adb3069b0e04-5b8bff2c01dmr18224e87.8.1789645668434; Thu, 17 Sep 2026
 04:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915160141.3543048-1-suzuki.poulose@arm.com> <20260915160141.3543048-12-suzuki.poulose@arm.com>
In-Reply-To: <20260915160141.3543048-12-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 17 Sep 2026 12:47:12 +0100
X-Gm-Features: AcwNN1UOph-dvwenB_bEiuZFqzb6gytAI9_L8AUcm8oP9DDQEKK-aUQXatB0jDI
Message-ID: <CA+EHjTzOR7xczcb1HbUAi3H7K8ta=pFcdjxJb7UixZEh7QS-Eg@mail.gmail.com>
Subject: Re: [PATCH v18 11/23] KVM: arm64: Use kvm_vm_is_unprotected() for !kvm_vm_is_protected()
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

On Tue, 15 Sep 2026 17:01:29 +0100, Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
[...]
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
[...]
> @@ -490,7 +490,7 @@ static void handle_exit_pkvm_state(struct kvm_vcpu *vcpu, int exception_index)
>  {
>          int exception_code = ARM_EXCEPTION_CODE(exception_index);
>
> -        if (!is_protected_kvm_enabled() || kvm_vm_is_protected(vcpu->kvm))
> +        if (!kvm_vm_is_unprotected_pkvm(vcpu->kvm))
>                  return;

Could the two pKVM-only helpers keep the static key in front? With
`is_protected_kvm_enabled() &&` inside kvm_vm_is_unprotected_pkvm()
and kvm_vm_is_protected_pkvm(), as kvm_vm_is_protected() had it before
patch 5, the boot-patched branch skips the load again for every user.
This runs on every exit: the old test is a cpucap, so on a host
without pKVM the function returns straight away, while the new one
loads vcpu->kvm->arch.vm_flavor on every host. The wide
kvm_vm_is_protected() can't have it, since Realms run without pKVM.

Cheers,
/fuad
