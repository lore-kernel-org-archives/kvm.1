Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF243AFD06
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768116; cv=pass; b=Qj4NcIcLC5e2A8E3mzWUnqaLDyiyxLvjoaQ5cLN0B94hV+hbcONEiEhKK1T8R9ORGVKeFMKNxIC7t8irycVReYCBedgVKrLytolr52QOlDd15Ds7NwSe4/LSpmJ8TkeEf7iy8wS4/7Wp852FQKM7W94s8/fzUCTubEebwcUuom8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768116; c=relaxed/simple;
	bh=SeY6Z1jmk7ymRLBox8aezw1ZLI+jut6EQpLQBAspM3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8kY9dtMW8c+AaBXMrwRRLHFzjf+78AD9qnqILMmpgxe+bi11Io9I8wmot0UZT9Lo1KdDF4iSyeI6HVjQBxDPP1ZxNzq1zruL1Z0TKJfFdk/sZgrz0jMmSch8TZUpkDLJOPi8zudEgEtCiTTKfbdJWDOf+oPyjk6eL65mxypx5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LLp0Iagj; arc=pass smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LLp0Iagj"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ac47074e38so2681587b3.1
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 04:35:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790768114; cv=none;
        d=google.com; s=arc-20260327;
        b=m7jH8aVLrfTvBbG0D8KczQWGek/Nhbn/afCjAIV3INhCltu1a3DitbcUSva6OiJDhG
         UWnlXyj28Gml/Wc0cx5L7BHxZFlyShnXCRIKAwr7QMZkTwenHboMGd9/a20n748o13BY
         81eKE5IjJ9Uql4c4JJYJJxn1tfoYwf0W8Er5LU9hRt0bcJX9/NX0L/iqNgz977gcNFE3
         Z+zRC8Ahsak/8zSJSB4D8Tb8alzLQW53QN+5TucHBFOEdynqFuhZK0Zxw2HM844B9Kac
         gz3BTw7G1BMfzoz4YqndyBz//TSDn4Ju0lw11+zm/V5HyW8EY7bbRFK4+I5zyfCBxZXO
         9aqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SeY6Z1jmk7ymRLBox8aezw1ZLI+jut6EQpLQBAspM3Y=;
        fh=lW153Yz+An4pkUqFmsPBQNgFnDrafIM0XhPLXiN+gOE=;
        b=Bnob7RQZiKcyxUXs/2l9h9azdRCY2wA2bzIXG3xGOspoLr53xgIRt5cuufGjzqKPLi
         LRy4WmuEBVFDkoIRNC8ePmHL108SN85LbgTiu07Xneyz+0V69uIs8haCnmOG9TNvGtP+
         grvt/3cKiIb6eV2gLytDlcIRFIKGVS55H9pFF40zUBSHrpE/vWWvmeGiZCIG7JQ773SM
         Uw16ojw0oJSQrsGOXQu5MxPBv9+/0gXitgiM8VmcVXWtDr5ziU3VpF0kGq4HEgVMAZA8
         HOwbxY8t4zfjkEvPLFTI0yZZ6CUn+Uepca4VEnK2HbpmaDCV/3vFVs33inw0mK/2K++/
         OMrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790768114; x=1791372914; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SeY6Z1jmk7ymRLBox8aezw1ZLI+jut6EQpLQBAspM3Y=;
        b=LLp0Iagjaz/VVuSyXEVmL9p7Eb9AOLsKdaTZbTuNvHxioXgjn5eLfozPDgrTs7Pjnj
         y1zCZ+aDiLijDM+9WwbamsMeDM3iERjv3uKybCH5GyuHskXLGhWHqoatupoVKr6wFNdu
         /V9A74kJN8FABo8yF6y0EUaGIDx9exuQtp7Bu8QUfk1uGx8pHnPzNdMqT0+p2SAI+ErJ
         1GF5bcrqcP52/GSZ1n3yF9zwMvUAN2gfACU5F/D1Z1znp0KBGzM4FN4UCPBPVpvJZHwp
         gvmoFfoLvx/gdUEZYetRqCTq90mStufk6yGYyeAnijS2PKOxI44k/JqgJvvw5pF1FjXJ
         x0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790768114; x=1791372914;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SeY6Z1jmk7ymRLBox8aezw1ZLI+jut6EQpLQBAspM3Y=;
        b=QSKiVUCkeKaDaPI4aRhmELztNOW+NaTAF9XV6wZaNnS4SAfc7dsw/gQqpcNQeZ5beo
         DFrami6yns/D/PTHTgQtm/tFYze8lXNro6fu3II+xEgpeqbgAoDPKRBTn3AbFR4/A2+J
         gHQvnQLjKnB+ZYVYD+0BMIFAzWNiBEyOTM39Ti8++oVmUzv4bhVv8UadIJOgK+o8Y2cV
         z+9m5BNA8QYHna1vkyqkZP23q12nIKf7wTS7PVYcvmESpeY2DXtucUcv4f/rZdUKnIcT
         goWRxO8775NNgn5uPAw7DEm8n4UCpzy85Ddi8DSxhfDUrR0XHsEASPaB+tiARjzUPHP5
         GAhg==
X-Forwarded-Encrypted: i=1; AKwUvBy1G6h9TBFyroorOqdDE5PZNjRXb2kVLatONjiKNx7MBxhs+X+aLNLEiXJAmo7y+0KjW4M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhvSJhGTfZ1FJLWEFmGI+x5sz3adYxN7rqucczOcSlKl0+yyTr
	mjVGJ63Xp9cW63iPYEwdstOIzA2o6ePa9Q8iesmnAJj0nraVZWVPmqHdYxDu4iDMtiDdDc2LfKB
	ay6nmdk1puvcaKdxKLeVrYgdcOlZc0ZMKKXZPqK5Jlg==
X-Gm-Gg: AYBFou3HDC2E0rfkn25+Ksmo8rWqSWWTQQdSCLgXatFXAoJMEapevyTFxrmCDuRVeZD
	L+aVgdfvOs7EpHd4uI+gG0LPmGJUJY/1auHjfqmNNMDI3v3Pj9PitCbMFSEF3EP/4suuqROL7Fa
	kWHg17I+9Qy2xAE33jGD1rtmVXpDKUDG1cr0hQgqMHe8zwigEdExpdpcEKo2eeHpKH+830kKGRy
	lr6XSbP+hv+xHAUEu6jcgzn/9WTiPEgs/OWbEpY73uFkwKqTxfIb6FmggbgLcYR4IuZ1DUHFtXW
	c9CQx15V3zJsl/7gjupNEoJxSDjkgnSlg0B+wE+kY073CeYiJ/tch3s/BiXWPU2qbqGxRhXLPkt
	/uBjxB8hdERcYSMcxEShm0JAOvu7+DElI46Iqh8o=
X-Received: by 2002:a05:690c:ec3:b0:885:cf67:95dd with SMTP id
 00721157ae682-8ac97909b55mr3191337b3.31.1790768114223; Wed, 30 Sep 2026
 04:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
 <20260924173051.2117637-1-coltonlewis@google.com> <CAFEAcA9Rwrffx8bYiOxrtQGdg31QAz1oBm8okzpfqHZ6yK0Y7A@mail.gmail.com>
 <20260929212102.3659389-1-coltonlewis@google.com>
In-Reply-To: <20260929212102.3659389-1-coltonlewis@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Sep 2026 12:35:02 +0100
X-Gm-Features: AclHuK8bFLv0KvzZpr3GNRdEy1zBXYO_hECfn1oR1UjooEwhow1ZvPDksGAca58
Message-ID: <CAFEAcA9DYo3GW_59eZjsk1qL0--3amYd7ufPqt80O2qv=Qm_pw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Enable KVM PMU partitioning and counter limit
To: Colton Lewis <coltonlewis@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvmarm@lists.linux.dev, 
	Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mingwei Zhang <mizhang@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Sept 2026 at 22:21, Colton Lewis <coltonlewis@google.com> wrote:
>
> Hi Peter,
>
> Thanks for reviewing!
>
> On Mon, Sep 28, 2026 at 03:01:32PM +0100, Peter Maydell wrote:
> > What should we do with these properties if we're not using KVM
> > (i.e. for TCG, hvf, etc) ?
>
> PMU partitioning is specific to KVM, so moving it into
> kvm_arm_add_vcpu_properties() (which is only called when kvm_enabled())
> and naming it "kvm-pmu-partition" per the KVM VCPU Features convention
> in docs/system/arm/cpu-features.rst seems to make the most sense.
>
> For the counter limit property, would you prefer that it also live in
> kvm_arm_add_vcpu_properties() as "kvm-pmu-num-counters" (KVM-only), or
> keep "pmu-num-counters" general so TCG can also use it to override
> PMCR_EL0.N in reset_pmcr_el0?

If it can reasonably easily be implemented (or potentially implemented)
for TCG, then I guess the general name makes most sense.

-- PMM
