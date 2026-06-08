Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC322AE8D
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934020; cv=pass; b=Oz06bcUBExx6sTL4xx6xeVZNib2QOjmd1h8NZLykupnreHp47e38gI2mFRD96Z6NhP7u7D2cr7MhlZ2aC2fbH7xo4VsTnYe3bJyO0/mhq4+onI6fqoic4RK6xTyzyCg7Drf7jTTPEcQ3S5M7cUe7//WISG72n2ZtDwTlJIeICCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934020; c=relaxed/simple;
	bh=cGL/9b07z0rUpS/xzmbUfcBuKWYi/7ZfhvMUt1pJ48A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrQAEyp1qChhmEv+R/5rRCn+m1IovtkUJnXUZlgQjzu9kecg1vghek05CYwZRLdbjln/33Lrrrh2n+wy/uB0tqqQyuXCFM9djZvmlhszM/0zNGd7LOrwYf3u6/vsFgaA6xMUACud3UrLbT/JxU6fLzmUjG5WOF2S1UjgOrPVNsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXXM7JBF; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXXM7JBF"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-660456349d9so4358676d50.3
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 08:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780934018; cv=none;
        d=google.com; s=arc-20240605;
        b=a+p3Fh5fHpfEviwSu3uNv8A190VMDucfjX+qs46nfCNEga71F9uiZZQXfEIO1SZqUd
         56M+CE8bww/hRpsmR/TKscIZhq6VGBzpMGc4O/Eq9kQtIABo4cmpPQnksI7rX/+yA5gN
         +ch7uxJiUXsyZikQb5uAeYjXWawF5/h8RC9/Vv4Ir4/5nOsb6/edNTp6+GNpyxHo7v3u
         XE31rMzp0YfMJkpfXR12Bv+h4dYuqVVVXWOnj/F0QipfHxQ74r9e8VsTg6HJscLoW2Ir
         xxjCjWaIzfuEFsfHFzvYPG9YxrAdG07msxLVrk2LIF8EOJmzUwG6pNQHtyW+zxpGl3jz
         XZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cGL/9b07z0rUpS/xzmbUfcBuKWYi/7ZfhvMUt1pJ48A=;
        fh=uYrPIM59n2Z5gP8PWMfj7V/UIKwGKRkyBOndUN2e5OY=;
        b=CtDa+dIxSmIpbfeuf3drl6SQ7mlhXU6FS7KHDG/2spNJhJQouwRxHVPdU8q6Vy+Jb1
         vWrElOoGYdAG4zQJfW06N++u2QHUlZbauy93Zt86YrLvRnN/6ZOZsZzjRM0xTBZAAX+G
         6XX1AUsxVvTRmfKw59TEL45SiAE2EqhSqpf7dmLgdhh+/CbC2BfFFm9nX+hIvgjZ8Ahq
         L1YNcmxIs1VNk50cy6bt0GGZGiaSDrEshAKizm4EoWBb6ahACscywEBKwNNAiByeBi6i
         T4BB6v+8QUNhlrXW7b9DcjFu2UKmHu5pFWWpQAeFH8FzgWDTJ1MS/oyzGkgoIVXcCe8a
         UfUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780934018; x=1781538818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGL/9b07z0rUpS/xzmbUfcBuKWYi/7ZfhvMUt1pJ48A=;
        b=OXXM7JBF1Zq0nd9yXLpApww0koizRvc1OP2DP6pzHaTaXRHdmysBm7+puMMtJdf1Q/
         pvFZ5mNDrtYidFbSLYwqOHOp8gtlHILwXEVVZJnVARLQWuQBsg0ySi5t0bn9Zr24dwc2
         oxwHfdzEDeNRKfUJ6doczwPTr6urfBk/9PXs7GN7ROUAL1sGI0k2EDy9MpSO2sbYyMYb
         MYVGxmcRFAEbRbskRfIuDMaawEOIuXPXTu/ogakQqoNIUo0hHVGK7Et80nOfLLfP5Gnd
         WR0TI7IzVzvX6gbnlH/Ok00bMrOWanmUqKU01DKBaSz9t5cD2ceG2BMFHfUOhnWC3/Up
         L2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934018; x=1781538818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cGL/9b07z0rUpS/xzmbUfcBuKWYi/7ZfhvMUt1pJ48A=;
        b=saizIIV2F0NqFidt/KHcvLszPM/lu+vveMqjgI2oQctuPaSbh2AvZtsIux4Q6lpxQR
         OpR6SWUgPHCe894mWZqto2Peb9jI5IR8kl2AG2//Ef9sHGQWKSHvLQxkS6lfu+R08j2W
         Zk+Q87bmjciPGYnceuRAah/h467yU33c+wwWrZaPbcm0pKWcEU/byWZvpECQZIc/RB9t
         ipbq+nwTJZD7OIxDHjlxAgFgrPiJ7Y87d9kTNHv29I3uR9loxqTef9jx/oyoh/Ub0JCL
         Nx0Ja3Fz4zLSnzfCdQ9LeFQqX3axjPdRF979z6jMQVUyaeQdhnOnomlNqF9xGysrssMv
         8OMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8i3+eqrtY/ELRGYBz7Fk9UVequZsWYoKzAhBq3dFnxtxsdMv+19mBgcWXSrnBpU6smI7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6L1KGFvNlR4PP6YnRZZR3dEDrP+8O+T72v35HMYlMI0C5kaOq
	16VUyUbmgxn5O3EloijRQ/KHxRreEZBnnOhDLLHcjuxZPhUxb9M68tbhZIfI86+4nIbpcUzETDf
	KNASVxqQP4k/p9xn/Ly5ihawTeJwqLeinjZsbS90s5g==
X-Gm-Gg: Acq92OFM0HlhplMJQLD8IRDvjCemhlhw8CPw830UtimNRfTYWsbCUUtT4rnSQu/tijc
	w3CBWItNb5ZOWBCkP47YO0x9DMEOUSswloB6Ym2RajGQeN2rUHCur0gHupLh2j81TuV9PN8hf1k
	qbFyMB4nUieD6IcTIVGXWbVJu8paUXDm8O9j/2TwyMXnK7NxGt+vMGWoHFkTpK1mXkbgiqtDuoP
	aiVaSWuqk/FKrhyjPRSfdHFLX2n8BAwkR8hf6kXfFQMzu7BhUlJO2T2pIX6kqGcPcWvhUN8Mhov
	M4PkebnUWXlo73YDov+rx/KQ+38WmgqxmHtBJ6a7/is75UdKpj3p+CH9Djfh1f7mWwbKR59fujo
	i73flm2gdYG0G
X-Received: by 2002:a05:690e:144b:b0:65e:39d1:d9f4 with SMTP id
 956f58d0204a3-661073da66emr12684719d50.9.1780934017770; Mon, 08 Jun 2026
 08:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529082948.363931-1-alex.bennee@linaro.org> <20260529082948.363931-8-alex.bennee@linaro.org>
In-Reply-To: <20260529082948.363931-8-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 16:53:25 +0100
X-Gm-Features: AVVi8CcW8P0G698t2w9dMFbyNLX1pYu_ywbTj3TI5RGvV3Iym5GgMjKCA1KpA3g
Message-ID: <CAFEAcA8719Q=VCwOm790V6FPA8FyaFZEux=N-7PmOGaaq=O_sw@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] target/arm: handle the WFE trap case
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <agraf@csgraf.de>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
	Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Now WFE can actually suspend on A-profile we also need to handle when
> its trapped. To do this we need to pass the instruction size so we can
> deal with the is_16bit syndrome encoding.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Doesn't this need to go earlier in the patchset? Otherwise there's
a point where WFE can go to sleep but doesn't honour the trap bit.

thanks
-- PMM
