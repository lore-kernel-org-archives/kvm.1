Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9C447CA9E
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935652; cv=pass; b=TfoZHsEEKXo5VUH5FQCkCzzamQZ5zKX7HS1c5QgumbhzJ6dMrFxlcCl/rxnCECrvy5Id85mCW2gKw8kkdcK/8Fsp23cZ9zNb3YiuJH34eiPXtZsYzOvFQAWigshW5HA7rDRs/iv3kpX0eF+N3ewN+gNU0aYKIYOBv9ad2aFmYE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935652; c=relaxed/simple;
	bh=FFnxElmYnPjkgCx517QhWsk+SbV5hjMWuaYPOQlgkRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLirhgU9ussc8zDrDGXpCSc4Pe7TcuZfnPsiRE5TVCo6ufgm2bP6TK6o4iRV5z8wz3GitLoaT6QbmQnMjYKf5uOFgPbHnMp31fyEotNK2XjcuoziwG5xO4hMnS9Cc5iXg8RF0RNiEcDM6XT/FHbuqjq1UH7JZlizMsA3gC+2r1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YN3lSRCw; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YN3lSRCw"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ba429b64c5so4769e87.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 03:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790935649; cv=none;
        d=google.com; s=arc-20260327;
        b=nBaEgGZw8hVeYW4tjDynbYcUyDF0bv1b30oR4GOSTNMlTODt60Uh68r+AZHnDw0b2Y
         J9oWLBCBiKIOc4PLZd/I8oVDlMAVUW4RGXByk0uaRuYsvIbbUwaJdhqGneX5LxYbH7XK
         zI05CB/TfvC/d0eRF+PixnLxGxOKJ8WkV4TtABXLR6rSgwvbxSq/+a63xgP0xmWrkvjm
         e7jXiJuEx/IOae9GgGlYTy4HwB8Fpn1REMoU2IfhvqZ1qhXC2iG7JvjBvg5r+vXAU3XP
         nla2bfTuDrxKlABuQYzYdcvEBPLECc82W8kXHhGKg+oYAqHDHitgPvwwR+kLnSCQkCJN
         NfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W2aHjvSPxe+vAP9qLitaZl/l2SuTqD1rpV9O3EUjP1g=;
        fh=rnIkUf6r+pm8oCQPQDOHPhdYLJEIYxB5Eh3hMNjkNs4=;
        b=qVrsYHxY3McrKPBLqbO27GbWTkPcE7AfFh1s4RyuRr+5i/5GE61pOkB9hQ3YhLZKJ8
         l30cafZNAqqc6bEfmIxjJXBXG3+I3ksCDZXq0KTRkhkz1aSWvXXf7LfALlNDY9AFkN3t
         kQlOC0ENYpcF617UI2ZfLfr9xYOdwAKHvcqwal9HJJK/Y0o0L0S74ihaKmBOs+DDJTfU
         2JhmhVWdyDB4SejKYm3h7XtLb76Uz5RMGxy3u2HgN9Li5llYhrnt/LJIAxxel1hsKdbZ
         DS0WG8FGLMbCTe5ixfUppFizSO8kw/EzEjQK5utaFcMpvJOgSHL+8dz2ctlJ3Qgr2Pon
         rzdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790935649; x=1791540449; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W2aHjvSPxe+vAP9qLitaZl/l2SuTqD1rpV9O3EUjP1g=;
        b=YN3lSRCwpigWqCqYY8LhJA3rmEakf/EkcrfsQng2FdpeqGA9JB2AZqCv/mEt/ZxfEy
         SD/c7QGL1nCsst/MD6YXcXuMll1mDAWYgLPqG9xKCJgIhoQU/QMrSPJZ79lp3H5rX01t
         bs+R0k4O35QyqOcntjaNgZdJd4Y7m0mPmVrKsFLSoo3XXDLcsnid3pLVyBD1qWRkSWHS
         VMPU3LXVRgl3GCzVdt58u7lJLP3FAHiiShv/WJlC5XCugi/89bELqzCNtCuGHY9JxmOZ
         1s8mQShbOJJCQ6rX/yLZprVuJ8vjwv8nbgBOgURgN4Q9CuM79Hn32auHIFq26ez3Z82C
         EyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790935649; x=1791540449;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W2aHjvSPxe+vAP9qLitaZl/l2SuTqD1rpV9O3EUjP1g=;
        b=avEsU0cPlbXFWhuFGlP1OvMHVItdtXrk9Qmf1qhUtBMZz8DoW2iIvpcPVey3SQoumC
         +OV7Y1A3Rn55fgu3UDW8brAwL6BUy4r2yjFYNUubgOnWudJ1Ztx7bnj0nThZxhECc8Lv
         TIw1sOdVhiH5n0qFF75oZ+otKbwAzluy6WPxF0e/CwPQkPEhlPZZ6c2m/v0IFb3mQ+aq
         qP5+OCDe9gzirEMSuvJutHQioc+qnz8V+g4d9eC8tcUAyvSleMAIF5+KYZi1CqtmCgRW
         urRxFpqXhetAwboXDjFRJAq/dN1yvseXOEObJhCkrGq1LzWFOw6hjQifIsSQHpVODzG4
         /bhg==
X-Gm-Message-State: AFq9FYJc/gPOMWquLmzqnYLon52Szn7PvZoYz6roGeq0o9uWOooP+EGC
	jUh24TaWQKF9HW4SeOEu/kz+E0x3xG+LitAjEewZPZYdj1BOT5u1bCcWHhyWwK6hyLESzEQ3wc9
	nXCnatRMfAFZjVM5RFbYYVDAZXjdgcu7Zhqa6CYnyemRrDD0hGv9680ALtcE=
X-Gm-Gg: AYBFou3h2SL6mIVUvPvKSFgBnXluX4NCVnytu32ubwgBRb7OdwPSwzvq9KyvheQe5M3
	9WhV/SKO+KTyLZTi0VAAF1T24X4K/Rc6EF1W9abf79tDJjyaRx/1784VQOczhB1K+x0BsjE1WUv
	9kZsv5FyAr9I7xzeWTqD5m0y3vOcRFRFKfXipgfdgEgJrhPsncjEC37oLjPBWRB4G2YMq6BTLn5
	9lW2a7InMgrNt0e0CN3y/wGzz+sD/3FoAJevImjIXKYLeLrLPAX/n4jPF6J6taRSuMO9gOuLrHO
	aiklCw5qTQvEq/oCye8pHiScMjDQDJNNv8AcfHuGsW+rxPi2lhuVdSDgaH0VG1VH2kMgkyIMCC4
	pOiZO9fINbaWLyQ==
X-Received: by 2002:a05:6512:3b26:b0:5b8:d04b:a1be with SMTP id
 2adb3069b0e04-5bb7c91a8a0mr135912e87.2.1790935648531; Fri, 02 Oct 2026
 03:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001210703.1597150-1-suzuki.poulose@arm.com> <20261001210703.1597150-6-suzuki.poulose@arm.com>
In-Reply-To: <20261001210703.1597150-6-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 2 Oct 2026 11:06:52 +0100
X-Gm-Features: AclHuK9UDCM_CxoGcsAnKo4MTwuWCAngd_IrvUFvtXNGuqDBjBBZg_tfUnO_TY0
Message-ID: <CA+EHjTxtatPyGcyvEyR129cqUiAYcO_cxRVtwZO0ckZsOnD7TA@mail.gmail.com>
Subject: Re: [PATCH v21 05/23] KVM: arm64: Track the type of VM in kvm_arch
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

On Thu, 01 Oct 2026 22:06:45 +0100, Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
[...]
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
[...]
> +#define vcpu_is_protected(vcpu)                                                \
[...]
> +                        if (is_nvhe_hyp_code() &&                        \
> +                            !is_protected_kvm_enabled())                 \
> +                                __kvm = kern_hyp_va(__kvm);                 \

On a non-pKVM nVHE host, the hyp callers of this in switch.c and
timer-sr.c now translate vcpu->kvm and load vm_flavor on every guest
entry and exit, where the is_protected_kvm_enabled() check used to
short-circuit. Could they use vcpu_is_protected_pkvm(), and drop the
kern_hyp_va() here?

With that:
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
