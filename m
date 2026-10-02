Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA7247ACC4
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946363; cv=pass; b=d+VJBR7o95JEGEN8syffi0sDg6PTw5vduiwfVuaSR/R8CMOxK8SEQL4m+VM3C+UMF7Pqq3d1EPg8sK4KHPnYQkL5wyEqVR941bOMkxQajP/ZMA9Tb4LTOOmFCPHyGPyCe7X5GSiQ4DoDjXcqL/c4E5ADOAx1+ncaqyIDPfZjxC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946363; c=relaxed/simple;
	bh=E3o9mY11vfyNe7daMSPv/Jpy/COQ66uBOFgs4MlwYzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiSgxiuKod6sXNNOKKuI8pBU/KFdoUHrb4kL2HGJosxJq2JSZez3XqOVHptYJSxBykWoAeBgm2Tlu2SWxbVroZd2mljzHIBQlOpKY4azzjluF+06SKZnt9CqKsL7IEYtTqeJ5DjEs0tUoXIycZ1/LrtHqZgF+QHlUpeobtNQkG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pzOJoE/0; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzOJoE/0"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5ba3d1ea20cso7130e87.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 06:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790946354; cv=none;
        d=google.com; s=arc-20260327;
        b=kRNky3FkHR/Dl5e9ip9umnFqigTK2O1/MoOODoE5+Hhiyk2uEeRgYfWhOT5BKLmdOM
         KN54RWgXIwSsJBfDANGaQ69uxckfbNWlgH0NQJTHHMwWz2XGugry4XwoockcYj06D2Hd
         AbpVt5fIoqQLWI8FM6EorVW/fbvvMHb65gIh058n5SjoHpuR3QXg+1c6xlqiTvNUF6QP
         Tmlm0WnJfGRFBV6//N4caI5wyigHhcUGSSPnvnuYGhLfWLA7RM2wRaDK6TBDv7K96ZDY
         ZM+Ktsnx6kxClL/yCY3d9LxvDcmtTTiGY/TWd231C4eKJwmf6ooCQdRMp8u2DHpBMGnV
         PNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E3o9mY11vfyNe7daMSPv/Jpy/COQ66uBOFgs4MlwYzE=;
        fh=6OpGt9aq6zBQ9y9tD2vTHOnVPwuO28IG2BSMaT4pf8k=;
        b=ogSnC1hMwAR3Z3eV6Uy91a/Cdn9zts1XNPP1jBP0VeDhyJcPIhqG3I0dVwG38sk6H3
         Zhm24fIOOy5rIlzuwcnBLeOJMe9b/jsGy7gSVjzXI1nnViV+H/3SUdb5HyITjli0J5ab
         VPIhmY0dY4H1U//RZAPnG6QT0Xv0BpR1mfi/gnxz8a3f6vFxi4dV3l6VTapHDXWYxAvO
         M3GurzAlWQQm/ZH0m46NEQyeW73h0xfebNx3HtFPJm7pktFtcQBgBcfvwPPi767Jglg8
         R97d610CMnYqehAMlLDfNniVqnETvqSVEo2qIkouIy/zeukoyVZAN9FJDXdsmvT1xGUy
         hk9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790946354; x=1791551154; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E3o9mY11vfyNe7daMSPv/Jpy/COQ66uBOFgs4MlwYzE=;
        b=pzOJoE/05ofXcf/NM5ADpf+Tn9P+KJUUJgJMQEgk2Y/R64/A47YD9cDI9s1JArtnPS
         osAN0lat6bBssNC5Xv9K1H8x13KlRaqr6p0kyl6Pa4/2SxfAALJwf4tOSUgyl1D0oXAC
         /2N7swd72npIbFy/9hlnX7SZN+jrzLrrbYZkArbAdSWn4GT2+JZN1RmaxmVkyvw4TJAm
         YiEwMtUoYurkVV/ta3e5xirMpVDpEgIsdIWeM/NJyWSoeCrEPWYD+jv1nOWffnkYZlHC
         quvN0djDkn9tV8wuMRttgNTOCAe4Pgn0j3H7+YIs5EXARvYLZF8wela2+os21dtIWoL2
         5oCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790946354; x=1791551154;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E3o9mY11vfyNe7daMSPv/Jpy/COQ66uBOFgs4MlwYzE=;
        b=ayz0nI9rM/+fuTmvBMCZLSifZRwmWq8PnXJtyepNcv+ZP0PY1w8C81oip2Mlj7+4ss
         1kpBsyJLmlbkmKdGb4KqS6+gp/NWhzLxC7wj80eI+P0QVff5Seyq0AFXp3ZaW53mLY/b
         s1cflS3/Bfz9813ZJkjND/+QlypIQW+tACXLTkwv22w6jX2mD2cDvsbLKMgJLIGzPWnU
         CrxIalbI99je0vtae1Tiuhiq1nA90mcDMayjap7KA1zyiP3PoFb2s3m2yOhIo0q+OoXF
         zumKPxPrNY/OcUaPNEqaA7M10v01x8PJ7lSGfd46eT00gdYZCVJormE4itPjahOKAlns
         kwEg==
X-Forwarded-Encrypted: i=1; AKwUvByzVJ1+l7TB7yjAZm1lyOJbiUACqQ/6ZbEa5dbcIKFnadDlsLInfArH+MQV0WzLVAj6HWY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3MKu2zY2Jqu5EonzOtpgJZEA+YrCIdK59XavnfBOG3YQLGPGb
	OnSaAQLeL/l5cGpfw/6pCbUQhWdM1dRbf+y+esLEx+emjkwYywTICNQ4hymkeKGEL3PuiME54MH
	CcJHc3DrDceT+1WqQyq96eJ68ApcUPk5AcAZBBQ7s
X-Gm-Gg: AYBFou2vJaBarkxDFaoEB5bmagWOitnyM9FFfo7s6g+UpigXutN6Xklaef+UyA8ZA+Y
	ETd6GCrBjZyTyxyL8+K9zpWxfosu9TUo99+V/D9yuxlTHS3SCTWXv8G77sZf76IYFKj/dKimr44
	qzEY6ZV2xoMAfwKPdZew25uoJG3Cpzi82KLETug1h1MW74v+XiNSrWFrNnPJHaI0A7cQJ8BeRqA
	TN/yMBFli+bcwrKTdS+wpFLWDfgtkyhGBvZINJHBzZy/7WjCscf7QgRzb0GMwuJOT4ADHx2QFTD
	ueep2wkVybWE4oCmP+FelDmB2ujDLmJRTeqylfMacQz8Ilb3AOzapC9ACUp+NnyWGG9bc77nAFi
	hY9UsgYfoK9GTrA==
X-Received: by 2002:ac2:5b41:0:b0:5b1:5141:9156 with SMTP id
 2adb3069b0e04-5bbe07ff867mr111076e87.9.1790946353509; Fri, 02 Oct 2026
 06:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001210703.1597150-1-suzuki.poulose@arm.com>
 <20261001210703.1597150-6-suzuki.poulose@arm.com> <CA+EHjTxtatPyGcyvEyR129cqUiAYcO_cxRVtwZO0ckZsOnD7TA@mail.gmail.com>
 <86se2o2rbs.wl-maz@kernel.org>
In-Reply-To: <86se2o2rbs.wl-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 2 Oct 2026 14:05:17 +0100
X-Gm-Features: AclHuK-8Kjrfe19sfHmKlc-tMXZBvGMWfs-wEUp4fL4Zc1UtRtbnXSXF_N2l_2s
Message-ID: <CA+EHjTwHuJ0u_TTP46zNFKFmBP124XHHLUVhkAUSyfhe92=41w@mail.gmail.com>
Subject: Re: [PATCH v21 05/23] KVM: arm64: Track the type of VM in kvm_arch
To: Marc Zyngier <maz@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com, sudeep.holla@arm.com, 
	jonathan.cameron@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Fri, 02 Oct 2026 13:57:11 +0100, Marc Zyngier <maz@kernel.org> wrote:
[...]
> Just to make sure. Is that what you had in mind?

A diff is worth a thousand words :) Yes, that's it. With that, every
remaining hyp user of vcpu_is_protected() only runs with pKVM, so the
kern_hyp_va() case in the macro can go too.

Cheers,
/fuad
