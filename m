Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F7472536
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039689; cv=none; b=b+sMHF+4kNGOCOdfsQQ3nEfyC+o1l+Lq4IFSm/Caa+eP5vTrmtIRysI7qYKYxIwyd4lGVMArjxADCEvWO2VpEoGnSrOOO7l5p2pMbHclmDQUsCB3vfS+pSmC5LP7dil4cXS6i3CEV3raAWxPdz0YS5/Pp2a6ujJrWi66lZ/l5sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039689; c=relaxed/simple;
	bh=Rdvn6SlWN1pYD61UCQmrt7vWGIUZg8DLzgLld4sc614=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=hueGXPlR/2VvtSXSByCW+wr5Q/NMxVU+WFvLf00VDb46W47rUFhXIeJY3Jxc3PgVRAdEKwg4YmYMMeI4CCGg9SSRpYPSdx5amyWwiBkMhY/11TvohxI9ps/sjEkqvM6FUkXIIY8H+f34Rhh3GdHzyjHEq5ZvNa5v2JnB0kuQamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erHsHykY; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erHsHykY"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4b381337e1fso6616889b6e.1
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789039687; x=1789644487; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Rdvn6SlWN1pYD61UCQmrt7vWGIUZg8DLzgLld4sc614=;
        b=erHsHykYY91loEwSURWmcGU3eqYDrnWrFj+g4RMTCSht5u2VSncyxjNGH+f+EwfhPk
         Y2lqwo5FiJE1gy9WfKMZm5Ri/ejfj0/0dhrZe02zWPoxhriQsnUN+c3ydAluU4GaeF8m
         N99835VqZS8IrRhC3VMTciw/o0wt9GHOgGICCm0Rs9Sr4eyqNb8tFWaZSJCumPJWBFVJ
         cook0EQMj3LMQTVbAdXovrYyVDdi2XYCHqDJ7QZP6NtBj++rhZaUjONPs6qHWLTF89dO
         RVgAUpMNl5+hO7irYaId1UTl1hYmlJFUldcHd8LoQ2SeARluUJoabeML0t9KC3OAb4DM
         mBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789039687; x=1789644487;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rdvn6SlWN1pYD61UCQmrt7vWGIUZg8DLzgLld4sc614=;
        b=nquhVB8VxLsI2dxFbh0eSc91zMU13cPzeeGHX1Gwhvtbl40QriR7SubLR3vMsfeanr
         S/6JmhrzGcV73OoWaAyjUOY0GgFZYf5dn0Mnv/EQQT9HmJmCNoZDHx2KlPeCdba3GnKV
         mb822sI9i96iYmB5tSPYEZMaLuCdkkpsZ1A2Vs0Io/Z7TtpU4Y7cQEsP5+pRFh96EnNf
         3NbeGEPi94Qgtuw7MYMi03PdciDDMD4OwSIgCx/EfWPPHPQH7EL3H9NLIGHUwzNpAZYa
         ET0uxs1Qr88kOB+/sCDO/oegb0cyMCLlPCL0idAU4ef69qW6StM217MV5nq5aWGoxc19
         1yBw==
X-Forwarded-Encrypted: i=1; AKwUvByGx1VpU5M99yIpTZmLKlazUj+XT9a85+54AEUJdPWOO4MQuYFoIODd3OsIa5rWRf5bzgI=@vger.kernel.org
X-Gm-Message-State: AFuF++l4t589qb1nW/VUGIR7cgdyfY4ZSGMXeMCF5bqWszBvXnDg2zNc
	CSiFx4SHPPzd+0AGosQuEwZTCgucbWQUNXJ+E1HSXr7Rl3Qvx/mBkld1
X-Gm-Gg: AYBFou3Fpv1zPNGFJAcKobqJzCfMw7ZSXl49UDgc8Rd2bciTUP1nLAPRg71Y0ft7fPS
	1MvxwH26gA7sRsyfC4LOCs7WFZyz992dZ7z3M6HB7RV/izvkpXECIX4lxp1D1B14DtpyFhzAy5R
	+wZHUegLxzLodLLZrT6V9CDcVi91bXk9T03kg0SylZNB9YwwLnAaxAZChEC+THVSvrsiEVRiGHz
	7b84aAdvEaGoVDuCjrkgDvKZX3gRDpCv/yjojah08uE6grFljAUcO+gx13aSqP68XrryiC5aTjL
	ljkQNmOTbEjIsX92HY0ON7lPAn7A5zCUJkDPJoogSkSr2zKlE+frhcO7V3FO12h1I6qD3+AzN2o
	7SHX/Eu3eMn/mtHAO6no69Vi4WQjVJYt2S4BXtUSMCLsbH9NaqCmWgBrO/WSUNhf2mhmNoiUTUG
	of8BTXFNqdngobjYJ3UkSOQha9zkWAHVcgdO+8cO28efoFzJAukdWzyVZAFsS+8VzNXwe+rLTMC
	PiEaaZQwuoMitw2TFcBZVOhkBNzQ39ijIBiQELLo39JwWRQKIbO5KiAMLVMpUMBRA==
X-Received: by 2002:a05:6808:f09:b0:4b2:8ee8:8a38 with SMTP id 5614622812f47-4b95db6da80mr27637088b6e.0.1789039686755;
        Thu, 10 Sep 2026 04:28:06 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14332405e92sm49398440c88.8.2026.09.10.04.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 04:28:05 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 18/20] KVM: selftests: Use TEST_ASSERT(), not assert(), in vm_get_mem_region()
In-Reply-To: <20260902164123.2546762-19-seanjc@google.com>
Date: Thu, 10 Sep 2026 16:57:29 +0530
Message-ID: <4ifx1h3y.ritesh.list@gmail.com>
References: <20260902164123.2546762-1-seanjc@google.com> <20260902164123.2546762-19-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> Use a proper selftests TEST_ASSERT() in vm_get_mem_region() so that bad
> input is guaranteed to fail the test, and with the standard error message
> format.
>

LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
