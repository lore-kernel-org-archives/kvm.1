Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC434CFDE
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959974; cv=pass; b=NJB1I6UMhG11wkKa9z8eCPBJVkDmpuKZ6TiOm/dOpK2cr/ulXlxBalShLWtZ2yTZDimQp4mWX4LMNP+yEKDeE67ortEBiAqGU1CLnFv7/LpMVrfuaDkBcdj6ynT7jCkxv/lvAXJABcqvNiGDB9x9p9175/6O/s0pxwd1FHmJhlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959974; c=relaxed/simple;
	bh=/lXKMho56Iawzotjf9gqPSSOK8+fhDi4DHNzWXgEKCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTBUFaY8Jc33skk+x/iAKQEircnz5mEsu/gSEGkcU2h7d+g0Den0z7BOLbuFi+9NTT/ZW+MwxdgwW8BUoQSxNbN/1POzzZh3Nxi1eAeYlqQcAtF8ZHS0qPgo0OI3peLBS/550JqMN7dQOj2uThj4+rtfm79GwWLwPHdTFv0uouE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wlkJGoJA; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wlkJGoJA"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b17359so6959e87.0
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 06:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788959967; cv=none;
        d=google.com; s=arc-20260327;
        b=dXe4x22RytqzFk0QWIqGDwkC65xgw6puoKCmsW4Bz1IUDr1stwHg6G6nj1GKEF7vlw
         cOQ95CC4+hI/dGrpQ5pAR7i/m3zNxikxIwrQPhTWSZi3uznjLYDYMKQeP/tVhiO4qh1B
         qP5LtYBhAGCqDgR1GHOPAkt3sUVHL0tcow/po9K3Ge7t1ghhix1dF74FuuE1Z3Le/jfc
         AM1xsYdm2VbFTPsNHW6LyJvZldPgod0Zw9jKEeXDWOl4Z1tRQl5YymN1iC8ihJ8J8cDR
         /i41o/mRLTFL+DTew2Q4Sijd/FLy3IY+HNhEeYeF55ORYNk9AwyNXK6bwfeM5BV2Rehk
         kfhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=STg7xRV8j3OkHmv1a51bOo5IRu3aXP7QERSx2DeQDNI=;
        fh=Ez8NpNZlYpJMs5FsbI2d5a16stCZJhW3aTDCQxMMJyU=;
        b=jCUqgCg7/wp+eseGzLLjEGwaU08oLiB9SyIf5nynFZGAc3guZZ/YGmTrA5oC6h7mnI
         4+rI7eKNuNBBa2upCxWShHjr+lSmtgoJHyji8bAVSaeDw2qZos1IneS6Z6uDqQW5khTk
         EKa+fDDl3sLCmdi7il9JuIJO08kBsdgRPier6O6lV6xcswfPDOBxDLzEY3r+RLsvI0jV
         Rut6guMWJrbwbGTghN0OTFGUtPRYdyEGkAubFmXKkAlQaJJPiz59D1Cmh5P9oiMVYALI
         GJbw286SxvDEHRwPlreG5Vb5pZ+xM6ghuh1vcXx+jvfoTYF8KkAGHJNYC3W2htaFJGLX
         QJ6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788959967; x=1789564767; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=STg7xRV8j3OkHmv1a51bOo5IRu3aXP7QERSx2DeQDNI=;
        b=wlkJGoJA2p2wzMRXde0S5XbeOqgypZfTDB/Ks7JLTddKnRGBiyQdTbx0mZ6jDK9OfN
         QxlxYJC9oKu3C8N9Nwt1CvRBnFQIzUB72uepV+2XpR+nJlP0c+KO7j+mLjG+MReJ6+uk
         seVlhRxVixrEIviE24knhJbBVksCyR8Lys93cogz2nbgH5mLKPMA9wB7xvCa3kA84t7J
         akuyGLvWbAygNHHJ55JpspYmCpjjYkN+VGw8K+nBeos342Czo73JFzw/z2/HFRvj80uM
         3sO6B+wFD1oBC9Dm450utReCRHAVlDCEVJffab4snl2fmLcEtlPdWN5denE8x5QgKiG8
         +8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788959967; x=1789564767;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=STg7xRV8j3OkHmv1a51bOo5IRu3aXP7QERSx2DeQDNI=;
        b=BEx+21eXM6wrVWzcHr+rDhDhGCn/2sCtpDtvWPF6aLEWGGFlQT8K+8n6NpQF2WkjFb
         y/c3iRBDLVI3T2t26UBAZKfaViL+shjccZxz+tiOGmub/tiCLtV9UQanNSepOIIY2oSb
         EjjsGR791n5JzP6EZY3snlb1AWarRUmrfbfwH+JnFSYoTTa0sFLUcq40Sd9uKi2udrJe
         UIkQu+SS2WI7C2HBLOl6pgp7TarmmITDZr31BHNa3nKpEorLP717L8zXeWmjPcUXIX3b
         hH1e/SSv+93UP0bXnRNhYewnUIA7AjM4vSbqx/c/FRSSJk3e/KNoQpRcPLrTmyGPvEZa
         srZA==
X-Gm-Message-State: AFuF++llJOOg1Kaa3yfDCQAUfhWtUYj/Kb7aaljz5QVLZONEN35HLMxd
	F1VnpiAiqJEiJ6g+Ln4j9yW+3U33Fq0jV+te64iFMBtCCqpnCHUo7KQyU5joRtGX6wnqnZmZtPO
	dNhZyvdcs8RC9OxkW68eIbeAlJ5B+TyqhhzGH83Ze
X-Gm-Gg: AYBFou1nreJSOGwbwAEe9ODpN8Wkuxf+DVrBVIcMYfBnaaTI8yQZZqYSQQUe8wGQDau
	5lorAJJv4fEqd+qETxt8P36Dqa4UvvPAOPTDvEAAKEdRXeIBhu2HaByPjDNuagZVIR2xWX6Bigz
	rOk90YnobSRPGSAYbRpgkeXlKKzVNlm3xOWhcMET4d1Q1mdyo+uWRHPKttN/IdrlfQMG3/n6pwt
	XC5IdG1cuOR67RiBxdtgLq1diGyaalpnoQCsbn43/wbrTGGwH5xoL2gC7fq2BUuI7OPuCIJIF00
	D+748CkaFZjjXyNA6so4+vcFKXI3+xSe3xyRAi4r6n/j1Rqg+hKQ+5Wzj+Oy+rin5IurlX4RHXa
	vRKhH78u+yQ==
X-Received: by 2002:a05:6512:234e:b0:5b6:bea:f091 with SMTP id
 2adb3069b0e04-5b764bba2f4mr141895e87.10.1788959964067; Wed, 09 Sep 2026
 06:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908162223.1683432-1-suzuki.poulose@arm.com>
In-Reply-To: <20260908162223.1683432-1-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 9 Sep 2026 14:18:47 +0100
X-Gm-Features: AcwNN1W9J0hO2XvyP_iEth4oT8xwRLULtx1NyAOMY4yUoohn2-IYZWX_G_vBhiM
Message-ID: <CA+EHjTzr-r1FRuJ-X3E38_SSHsNSz_vdO-8sFOtBdsiB3V_x=g@mail.gmail.com>
Subject: Re: [PATCH v17 00/20] KVM: arm64: CCA: Add basic plumbing for Realms
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

On Tue, 8 Sept 2026 at 17:22, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
...
>  3) NEW: Enlighten KVM arm64 about the different VM types and use call backs for
>    the VM type, rather than spilling the is_this_type_of_vm() everywhere. This is
>    not complete yet, but it is largely functional. Adds VCPU and Stage2 MMU related
>    callbacks with support for the existing VM types.

A design thought on the vm_flavor dispatch tables. They're
hand-maintained arrays indexed by enum, and a gap fails silently at
runtime, not at build: arm64_vm_s2_ops[] has no VM_REALM row, so a
realm VM would get NULL ops.

How about something like declaring it unsized with
BUILD_BUG_ON(ARRAY_SIZE(arm64_vm_s2_ops) != VM_FLAVOR_MAX), as
host_hcall does? A non-NULL check of the selected ops' mandatory
callbacks at VM init would catch the s2_ops naming typo Sashiko
caught, where the rows point at zeroed forward-declared structs.

Cheers,
/fuad
