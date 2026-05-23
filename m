Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E354F3890FB
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779535815; cv=none; b=F7k3FMRB68B4xuwHmzlalDNFyZACGaWEEgoktFQU9Fn+/2tFtn4tOHC1cWKLAfLMQjy6K/w2+2Tf3nXmxT2RRd4+mxv+cy4391eDuH5+KU4HcPo0tDCWj55GAH2XqLkjco0QissA0U/+9mHrOfplfoEiXzpGYIkp4ItvPD+NwTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779535815; c=relaxed/simple;
	bh=JMI44/ouLWGh9v3cwRXboxes8Ebe6Yq5Nc7HqOw+anI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nodyTGVATVUKn3tzvmaFJ357S3CiomAv1AGT+Q1L3Mu/VajQOkYSH5oAEG/Hxx4Lh7iTHF7B769ij513qVEuWAnSmuLV2fKTc44PM07JevJoqWBczPMod02IcFqY9CYB4+3vmcowoj6T7fcHi1GK07oYWxMqF3PgLD5FBRPfmHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ybw8ACPE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ybw8ACPE"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6870f904c6bso7182288a12.0
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 04:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779535812; x=1780140612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JMI44/ouLWGh9v3cwRXboxes8Ebe6Yq5Nc7HqOw+anI=;
        b=Ybw8ACPE4O+XhvcRXrDJyvODHQ0XC519EcisfoVwi7aDBZF0f8QBK5o9wtLHcI7+er
         fTW6cdrnPbS0+Rs8nev15Ge1qloUIB1wEzdoYnhh13A6beuqddmCSsejfBSnaQFuy9F9
         e1ZGeSGsh76mZnqgaEtNT27qtWZdAUU2p5Ev87dxbx6qdbD4r6EK2T/Klb4KEalU9FRr
         N7gEzk5jIr/H11MejWFBs0rTV/+gEJ0m7ldQmQuwRKJ4Olmix+JETv8cm97f644ylB35
         hwkvN6YRX0gdDL1xhVDeXbNoED6SvSSvO6XB2xTeacgnzYJzNAzppsIq7vcc9fNUssgo
         /NSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779535812; x=1780140612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMI44/ouLWGh9v3cwRXboxes8Ebe6Yq5Nc7HqOw+anI=;
        b=KaaEQToLUpmEcUFAfQ9+HJ5XgjuAukDg6iXK6kzvKYCCMCZRkYuLUozgNaswhlEVZi
         kL4In1ydf/HKjasUZ6/M4PVQauuyZ0LDnr0hKqRhk69Ije+vrnnjGpcpHMAp+90INeA8
         kDCiwnk4EictlXwOnNKJmC6XPifn9mOwi+hSIpcyhae9nO2MBn+K4adyhh7QViKIIsK/
         sfSpQI7e4j0kFsY8BkpJe5AuCR1O7xC76AL72PpKHPDuXw6AZegpUfdQ8MOT/Qz/Ce1Y
         UuEcycEwIVDBcyhsmm23xcbDMwGV1zuMiuSMBz8zelmbsHqemn/MQ3wJYXO127LySiTb
         n8Ug==
X-Forwarded-Encrypted: i=1; AFNElJ8tur7QLXtESK9qawASohwRSDYEVh6xClzkWKEMkkS/Wtgy2HFRmUN89m37AmdHAO3dthk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeXPCA+nOSPU85wT+GaYHoSYpmRksMhih5InnQ9NAwAPwTPGE1
	SMpLBw8+WTpANHKHIyoxTBXucdgwcH7r9FHE1L0s6Cnc1aV2A8zHDkPV
X-Gm-Gg: Acq92OHSDlhWhTBI6bztdvwtsToHeurJBrXdAA4tDMK3W/G6VFPTBqzdUJwN5Byxl8I
	rLW48HQ7OQb21LvcnxaEhaAUMqO/SFBnLc1sqHl7uRgN3ykGMTadrGiyjJVK8X0o1IGAQDs6hJg
	vBjltbukTVtVeFN7e3qbLIIR5hjifGb1TSYFNO+CdgcigrOlcMozdWkv8rYuXkYtRc1VXRa2gaQ
	E+djBzxHyGhYIwx9KTdljrC222F8xjZZVAiLDcgdm31CofRWeysxm+c8MRORSLkoRZiowZjjglt
	k+Me2rSwnHkhZwR1fYdvJmvxsvDyV6/brP0tpHnPvtK+eiN1NYH29zJWu7m0iHGNt8vZwhtPVHp
	GslT9eXfhDai2ogLfjNZrZw5MBzQojU+2XNjqo4BjTnOkyBqFKA0rO8XwpL4Ua1pvd3ESBQpNdu
	gl+VZDhR6m2KVgYs5kJIcFFmyNHLvwW86gRP3GW9hVsGC70CrjZTEmjsXHU1bYtxDLf7n/hQBF+
	Yr9yMsCgHwC
X-Received: by 2002:a17:907:b5a6:b0:bdd:87c:5bd0 with SMTP id a640c23a62f3a-bdd28a79cd4mr339609266b.11.1779535811817;
        Sat, 23 May 2026 04:30:11 -0700 (PDT)
Received: from localhost (226.55.classcom.pl. [195.150.55.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc264dea6sm171918966b.7.2026.05.23.04.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 04:30:11 -0700 (PDT)
Date: Sat, 23 May 2026 13:30:19 +0200
From: Piotr Zarycki <piotr.zarycki@gmail.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: vkuznets@redhat.com, shuah@kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: hyperv_features: test write of 1 to
 HV_X64_MSR_RESET
Message-ID: <ahGPQDJCT1aW7vVY@arch-piotr>
References: <20260523111857.195396-1-piotr.zarycki@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523111857.195396-1-piotr.zarycki@gmail.com>

Hi,

After receiving KVM_SYSTEM_EVENT_RESET the test simply advances to the
next stage without resetting the vCPU. Is verifying
KVM_SYSTEM_EVENT_RESET is delivered sufficient?

Thanks,
Piotr
