Received: from mta1.migadu.com (out-166.mta1.migadu.com [95.215.58.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F433B059E
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370881; cv=none; b=PIGHCuyGWtvSZwZg5SvgRh/R0tTh3YFFnI52QuupINgqLcmXf3NnbiSqoqXPuX2AN49FlA4P9pc69tb6Z2Ww2akGmtIVKBgQpbDa06Cc6d6UkfuYBOd8s4+qoQyZvTdLy1FFUrbS5LHySm1z8qaLGcnCL7I7qtDgk+9s4pWcEpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370881; c=relaxed/simple;
	bh=7AAmUdrhI1yAcj5z7olkLM57zlwGodlaq9p9uBBFRNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYNHbAWpXmGsvy/SxKkdC58JGe//Ew2ll1+Vm5cK9Wh1/O+sxveYU1d/2EyWDjfn3qMCrIAG62R3T6q46vBt7yN1L0zYw8Rxk7kLzyTGwETEk30LZ+oOLXakwSRNskMN681VFmPZEjy/hNYAMqyJFJMNzuZ3DDGCIAQ69UhPJpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tn363HVf; arc=none smtp.client-ip=95.215.58.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tn363HVf"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7AAmUdrhI1yAcj5z7olkLM57zlwGodlaq9p9uBBFRNA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791370848; v=1; x=1791975648;
 b=tn363HVfaG1BSxJl7FV6GnV7WwNpFDJSPXHo7wm6x7nfvX0XrZZgHjBkMRsM2ujO8ZnRwKqO
 INGuFC8pHfVDf9Ot8yzQFf0Jiss1xbgRsBESwJCiKiMKl2mRh4uMGw4uZso5K+iGptmRqcK/5Dt
 0MksrX7iqYl+y2g4pIJ96Gtg=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d55d62ae8cf380ef;
	Wed, 07 Oct 2026 11:00:48 +0000
X-Mizu-Trace-ID: d55d62ae8cf380ef
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5ba429b64c5so5595e87.1
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 04:00:44 -0700 (PDT)
X-Gm-Message-State: AFq9FYIuQDwWFZeohvDkNpn4Sm2fb6bYZ4mE7iDySpL1JhV6/Gbfr7iV
	9dxwdoTajuUFBBGYGwod9auvuUDvJ3VEAiL+XxyGzcqRUcWCF31gOs/RooMnFHFQwFCXzvKfnIY
	Dwi3HFFGaRFk2zsZ5mBz79O8VRg33AjfByh4jvL4R
X-Received: by 2002:a05:6512:10c4:b0:5bb:7b34:8e00 with SMTP id
 2adb3069b0e04-5bcca834338mr303502e87.6.1791370843101; Wed, 07 Oct 2026
 04:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007073537.2454351-1-suzuki.poulose@arm.com> <20261007073537.2454351-4-suzuki.poulose@arm.com>
In-Reply-To: <20261007073537.2454351-4-suzuki.poulose@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 7 Oct 2026 13:00:06 +0200
X-Gmail-Original-Message-ID: <CA+EHjTwdoj8k8-To5ywwDO18Ek-sET5OHbKuawatTNvMc6gyGQ@mail.gmail.com>
X-Gm-Features: AclHuK9kFsM0C-8314xeyKxj7wNCXh1xIF58U3OrNPCRgmPj5uaBmkaoPd_Q9sw
Message-ID: <CA+EHjTwdoj8k8-To5ywwDO18Ek-sET5OHbKuawatTNvMc6gyGQ@mail.gmail.com>
Subject: Re: [PATCH v23 03/14] KVM: arm64: Include kvm_emulate.h in kvm/arm_psci.h
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
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Oct 2026 at 09:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrot=
e:
>
> Fix a potential build error (like below, when asm/kvm_emulate.h gets
> included after the kvm/arm_psci.h) by including the missing header file
> in kvm/arm_psci.h:
>
> ./include/kvm/arm_psci.h: In function =E2=80=98kvm_psci_version=E2=80=99:
> ./include/kvm/arm_psci.h:29:13: error: implicit declaration of function
>    =E2=80=98vcpu_has_feature=E2=80=99; did you mean =E2=80=98cpu_have_fea=
ture=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>    29 |         if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_PSCI_0_2)) {
>                  |             ^~~~~~~~~~~~~~~~
>                                |             cpu_have_feature
>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

nit: If you respin, could you update the commit message?
vcpu_has_feature() is in asm/kvm_host.h, which arm_psci.h already gets
through linux/kvm_host.h, so this error can't happen. What arm_psci.h
uses from asm/kvm_emulate.h is vcpu_get_reg() and vcpu_set_reg(), in
kvm_psci_narrow_to_32bit(). (Sashiko, confirmed)

Cheers,
/fuad


/fuad
