Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7E3EBF08
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862445; cv=none; b=sx1TirRx6XN6u+GoQa/F8ALQpse8WwwSlJ95W4mGrlgqjN+40XOhtplP/9mCmTLuGVKkbR2PzNeR9hO3jJ+sooTYckYu4Q2M1T1xfyFhg+YQYBwxWX3sWRlefgVQpLN7BLpa6voJcqNQBn2zDSvLM1nPY8yBOdqzlYZi41B1Hto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862445; c=relaxed/simple;
	bh=i0VhflUxEFpED0+itF1fFpiYo5q4BEti/6FUf86soek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LNhzSHNHOHdB1YtbNZ3dsQ5KVjLCev6Wtqwiq+TNLwuomDwe+BgxPaTfdxbaMuOAOukCxCfKFCPd0f8ORtDRkjezdDKKGwDpH/ZaD1XD9uq2wsbEgkqV1TtRRIsGr3myDIHBNP63LKDiCSK/zbLoqcfcYjYyAWBPy/Opnn3dqIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TYTaTNEa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TYTaTNEa"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ad135063so47393855e9.0
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862443; x=1777467243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00AJ7UrUeXPy7ZqKcucMiGTlG4wrum92TpmohAq+VBM=;
        b=TYTaTNEazuWTVlXPHz0q7wJQ5mJEsDoMuk1Aaay9vKH3SPs604dKfOHtQWZxjQ/6wm
         ttH1hdqksQVYi3dQyD6VkCTmgGp6I2pf1Lvo5V1LO3OqSMhZqKI9CQYPDwj4tcQ3cN/I
         nHR3Zsw0O2N0iPzzpB95QBlUpHOxoOViC4Dkp2BAQd7oAbeVwmwdYlOYZ59tCC79Hs1j
         bBJzykbQUGG/C5ZkUUBkRUsmaU1JrKntiUUwIuH73O5+75Bnk6ZSOu5N7EK5XvkYHaaE
         BO4PyxoBeXGXBmcPBbBwmdHLpfyCm6t34qvyKBingeeHkR6ufSNT6/OkP2BCO2lwUrhz
         m4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862443; x=1777467243;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00AJ7UrUeXPy7ZqKcucMiGTlG4wrum92TpmohAq+VBM=;
        b=p4+LB53HlwCYirFbf7twYKnQZqgrVLPi3U07ZtAIrEBlN4egTvkVtgreXZaBzLvmAP
         4BBOStTXspeT7YAyRuRjTo6Wu+3as9nvdDpeQy4fVDe7fyxy4OqkeBcnKV8YnkzZiJWr
         FA/UUn+CTURSm+xs7rsdXn7hI13NxXbQ80BgppU6PQSZFHMky827KTerU3ay/Bn1ukqm
         N1vxWVnGXLyhAZimgll73P96BDIDF7TCo3s5fuk7iTep+yDYzzgfrDCen+sdLI6EGUdS
         iqjMhdWBOcJ3dGjkTTnB7BYJizLvskuub9ar9JiLcOlC6izyBRORq4xPPdSQJ/WZuWNL
         v+VA==
X-Forwarded-Encrypted: i=1; AFNElJ9Fq/kpgvXSiBbArgxQXflu8VvsjlINwr5hwSJ8sD7WcsqHCNxrcrZcTe1wOgDvDAAapI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygVgaubR7ivHRafi3bDSYmdsOVhLLlblDTgy4/8uyT3b74zm1j
	jG53oaFulc1wfa2uZFbq2aCODFV+mBZOVzVuIeF2vL5RCL1IirqArwwNovO5g9kiW/Q=
X-Gm-Gg: AeBDieuSfh1i+w/afiovnT/7qe11QejHriIC920ZsAItL9agGK8UQv2i6tp4/JcMdw7
	av03j7CnvYmvk8eDQlu681KmcD0T9o/ZVszt74/mDhL9yFqFKd8tDkFHe1OqVYnzMFFcvweH+Sr
	SmmlVGd3DGSBTsB/qLugh3AhgGmE/OpQCs2t1es+gdoV9f/WENfYQPiyTQja1hqiDciqz7s9eoH
	qhXSi/QnLktSnRMMNoJJ013WPNlqbRu8/3YVM8tXMJxAggmG6X25ZaDAFN7d3Zn+j4sA8JMblE9
	fNGHF6GeE6+0abl3+7q4gpP7r16n5P63WEJVscFkMmoQHdP+dZSe/5pnYBLdqYSc0+iZodJ8sBD
	9dkSn6LzyeYCIoc40nXll9cwDYbRjvc7JGO/qyZedZ+jLyNX7AOt6bnnjpPrsDRnB932WWHYlQ6
	gADZ2OesRkA5sdSNW6OEVdLehMnofJdt5gWK1dZ7yckXlp
X-Received: by 2002:a05:600c:4f0c:b0:489:1c1f:35e6 with SMTP id 5b1f17b1804b1-4891c1f38c8mr201641885e9.6.1776862442605;
        Wed, 22 Apr 2026 05:54:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm753110215e9.3.2026.04.22.05.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:54:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 38A1C60342;
	Wed, 22 Apr 2026 13:54:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Mohamed
 Mediouni <mohamed@unpredictable.fr>,  kvm@vger.kernel.org,  Pedro Barbuda
 <pbarbuda@microsoft.com>
Subject: Re: [PATCH v2 00/31] target/arm: fully model WFxT instructions for
 A-profile
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org> ("Alex
	=?utf-8?Q?Benn=C3=A9e=22's?= message of "Wed, 22 Apr 2026 11:10:11 +0100")
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.1-pre3; emacs 30.1
Date: Wed, 22 Apr 2026 13:54:01 +0100
Message-ID: <877bpzxija.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This series fully models the behaviour of WFxT instructions. We
> already had support for WFE for M-profile but we left off A-profile as
> it has more potential sources of wake-ups. The main one is the event
> stream which includes events from significant bits of the timer
> ticking over.
>
<snip>
>   target/arm: enable event stream on WFE instructions
>   target/arm: implement WFET
<snip>

I've posted v3 to handle the missing WFE exception and fix a minor
syndrome bug on the WFET exception.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
