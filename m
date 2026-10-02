Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638E647206F
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936438; cv=pass; b=Khl/uDYp1+rLe9zDesCCLCWfm16b4g4H33UCaiJxusbIPYW2wFJVDwfI8VXZufk4N32ZBNIPoojec7MlhEWatr7jccAcN99WJVuf7EriPz2wft1jOSnjEz4YerYK246K7RnayGM4vB+PId4f9T/6n07QfLVw/A0zV2kuRn8TSmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936438; c=relaxed/simple;
	bh=UOMj64A4DoXhOCxEjUECHTEJP1J0iaV3eziuUdVe8QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHhc2hswuRyR+kukBv75v4hp0eKFRhEwdXn8qL8bgVhIecJVDTHhTVDdhNVKDy9Qx4F/6IInv5YpY1rTs11Rh8HVkxOgxrc8aI+qWXlSlzmpyZU7YznI64XEWqdbi0nqQEkmImghWbftglaZKFO4AI+IsCtBquszbG3AeT3wvkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJvm2myZ; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJvm2myZ"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ba4065fa07so6748e87.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 03:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790936434; cv=none;
        d=google.com; s=arc-20260327;
        b=QT9newdbH5/9Hylz/BEw5+icdQBTCbrzbQzlRw0ToW0j7Ht7EM+PkVfN9jcI1IUtkG
         xtY7s2NSwF0HLj2ri2U/MGTtaofKamfvAXigfRvpEzI6Q3TzON/8u25Fka33OXPrUFvw
         YYX2CnAiw3XfX1vmM8rzyIffloFTVJ28X5wEMGzn/TPCM90IlKQa3Skt/Zbdhc8O0OfC
         VBLNfOlELAiBdlXUI5MnFB9lx6XfItgIVOLcyEG43qkj0tR8iz1d2E7SeoccZaxJEzxs
         PIxqHnu0zVS8xvxBkMHmcObzAZry2vmwe5cbY+3zeoxWY+AfANvDCfYHqa9/I16Teg2L
         U+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AWVQCSwR0aUoymLEu54Qp5SBrR33qbmFDxb/OCitD2E=;
        fh=rnIkUf6r+pm8oCQPQDOHPhdYLJEIYxB5Eh3hMNjkNs4=;
        b=WJZy8TGVn0537DHHMc/GUZ90HVjA5NLbrejRSJadMJOnfPwkk4Q/gbj40mYjUw6Drb
         I6QAobXSZAqEjRuBsXOxZfMfUvx83rAjGicF6napAz7Y9LQAiK7URtg00aZqnI86mZjZ
         eJGGb+R49V6uFCavS0w4Skl1AXRkIL3HuejAz09WCgPEL2Aor9PyO53HRPg9o8/9feK8
         tIKTYQ4NoMrsDjRBmiX5okKqcMfc/RjKMS3sXs1JSGvelnjQ14zyS8Y1BGgJ+yS3M3uW
         CK3AZPVZXb+reczfDpQw4Vq/vajgceJYg7ZMKjW+FAgZMSsUixQQ6HrSIFGfljJm2qNd
         J2sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790936434; x=1791541234; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AWVQCSwR0aUoymLEu54Qp5SBrR33qbmFDxb/OCitD2E=;
        b=AJvm2myZEjPfyzb4eUBYN1rm5POa/Q9E3JDWiYE1fl/N+bNfe+iBPI3pr2JkHeZEea
         hUA3+9P0by1zW+SNGGwlr5eE7hCB7OLJsFs6PzFHAAbQKPIgU7M1P188JOZgs+SrpavP
         FVjnWGoa5SO2vHfyOpsF9K86NPe/pwlk4cIXHaoh+m0ELJ7Ejewl7wBXLtRMWu98YSN2
         eZ3u/CxQ4k4zCV4uppzNk+JIWzMAb+E5k+iiQr7kuXJkjavsthKgPY/v2sNacrBnbgJx
         ouK0cWSNLHSQT797skr/JXaDEC2W/PEJ7Rsr7uafHSvbFTyby6Yf375s3Shn8O1tzSmg
         AP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790936434; x=1791541234;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AWVQCSwR0aUoymLEu54Qp5SBrR33qbmFDxb/OCitD2E=;
        b=ZUwyFF9MLpFCJxtNhtR8UBdAjvMolIrnKSaI7MjyJ8/UKvVcu4r6fhtQcuz9Oo9InD
         R3B+1Q2beTb7j0KWMOFPe0Blu4QyPzp4e2hTXJbOJZ/3DCFkqYp6/ZK1Zu2Ia+hJ6LOc
         tCPEsaoRjY7XP5XgbieHNJiTh1K8kF7xIbMkBpztxCamMTPZoh6NpRdOa6Aa4LHq8FOj
         MQYvru8rOZ8qpFTHyr/GKElUi8zcYdR0VtS4T73o+0R6T3CsLEJnvAuSfrxtHrLIP8Cf
         oexqqIVVVLWbJ+oM8oKX8ZgQaIkKYK75hlCV8PUtQJ3eO7sarQndwPvtibdqWUn1pLo7
         LhEA==
X-Gm-Message-State: AFq9FYI8q8qZih/Jfk68tcP/IGVbFi7UsZQDo5tLWvTudJaGGwT/3ZB2
	oYM2zbsQbbantmBCZbapGQDIgyAvnf2JIc8eAuVjDj7TM5AQOSgrwhg4Klj/kbHRFP1ti6ZA5lp
	QBYensCpOpFEfVJyHpe5MG34l9yZn4ZJZgvvCp0Fd
X-Gm-Gg: AYBFou3IHW9HqF7lVkqqi41n5D7TUpxWWVCzCDSODWbnZSiW1VUzsp0O2D4ck6F39dH
	PRq9/HHrSIUjkskiyZ0P8DCWcEjfLIWISt5alqzW20MvM4SG9LXbmULrjsFekKCFPKMMwLJjDnB
	xjnyw22Nta4hwF0eoQb5npQcFYxvj8HxV1/p62FbHNDMnrA6tx1L19kXHVv+urQOytM3VdV9TwQ
	amfAgLk429inmjIcsvfI5834znvx4bXXSoX46wRWyuIR8GT3fmdas8lZQjygJyhHqxb9BC+FjmL
	6D7KruNcknA8Gtc3hTiSmHD13VmioQsY+dyJvRAfnaXyzfBK0l4p8DCM1Lf6hhuG1LM0wrEHIA4
	BwC9yv4/cDEFETXK5UJC9JxJL
X-Received: by 2002:a05:6512:1c9:b0:5b7:6707:e44c with SMTP id
 2adb3069b0e04-5bbe0806600mr67600e87.12.1790936433781; Fri, 02 Oct 2026
 03:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001210703.1597150-1-suzuki.poulose@arm.com> <20261001210703.1597150-11-suzuki.poulose@arm.com>
In-Reply-To: <20261001210703.1597150-11-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 2 Oct 2026 11:19:57 +0100
X-Gm-Features: AclHuK9rOT56mg_GDAS-UKmKKcU8gCHcSak7k76HWhpeBX7f_dB7iE1PChHGrcQ
Message-ID: <CA+EHjTxCfmOqiJzYDZHunSuEyoZCbgHuzeSYC8y71Re+9PA6Kw@mail.gmail.com>
Subject: Re: [PATCH v21 10/23] KVM: arm64: Add VM specific callback for S2 MMU operations
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

Hi Suzuki,

On Thu, 01 Oct 2026 22:06:50 +0100, Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
> Add VM type specific S2 MMU operation backends which can be initialized per
> VM flavor, to keep the handling cleaner.

The rows only differ where the base already branches (the pKVM TLB
flushes, the protected VM age and unmap, and from patch 12 its abort),
so the case for the table rests on the Realm row, which isn't
functional until the RMI backend lands. Beyond the flushes in patch
16, which operations do you expect it to override?

[...]
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
[...]
>  int kvm_arch_flush_remote_tlbs(struct kvm *kvm)
[...]
> +       if (!kvm->arch.vm_s2_ops->vm_flush_remote_tlbs)
> +               return 1;

Every row sets it today, but returning 1 falls back to
KVM_REQ_TLB_FLUSH, which arm64 doesn't handle, so nothing would be
flushed. Could vm_flush_remote_tlbs be mandatory, checked in
kvm_vm_init_vm_s2_ops()?

Cheers,
/fuad
