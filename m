Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266ED37FF50
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874887; cv=pass; b=obc5EQysLL4Yls3a8mu2guxXzqAcsHJwSWn4T7qV+MuYFSYxy+bZkU4bz31mV6Gw+WAm36dMoOfDfaMg/iHY+Tz4fG4p6/TKXKzpcPvV2GDmPlH0MKRySg85FSvsrTEYg/a/qc8mLlX6GQVdOWQQk3s/xjT9hZKfLyHRvt9J6y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874887; c=relaxed/simple;
	bh=HdxIVy11uzcW0T+Q0jj3VIJ/qwX4f5mro17dP5zpg2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKwJmzh2P5kYIpolUZGjzWErk0CeAeFDH9uPnr3nOu7FrFi8FwUZemcHwOdE1VZqRCI59iZ16mZ1a/oXzpMUNasfzjs9bl+A21YsYYL1hpau2kbgVxB7C/NU6mtRoKcWB8r0lcFzt2u0Bg2k1yWjdDOJFLLfmCCilG/MRMfPHZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJj8zHck; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJj8zHck"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66077e888b2so2079485d50.3
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 06:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781874885; cv=none;
        d=google.com; s=arc-20240605;
        b=OAyC9xBcIRz02dY9Lr2oUu4pCvr1ZX9DxcRBQFKu/spWCZjj5FlUefDekF5ZWI0vj1
         ZSnCM7BxxTNxA6ggMqAI9Zea8y6llNxy67eW0GOAZ8AuR4vxKiSU8GZnAg+wwUnB5boc
         C0R8RKdYoJ6Go5lVqc1HmLiynnmgj2fh2ONCMBgmQboLBzhFOKIEKuaZ+3IsuvJDa58Q
         pUjHdVDuxGITvf/RhIQ2p1ql80waQHkCn+eo+kECnWK3UvwLhRmdkzBQ0qYGKjCcwMDR
         Es301q0GiW6gvGrIvtdm1CJTmwxUVleA4v+qlJ1i+7Uw7qjsuCg1bfXQi9se4+7DhMJw
         xeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JjEqOBx4XBRQmpZWps6rk9/oRg3CowveChr0GB1L2fs=;
        fh=75cqGPW5sIzHhG+FLksymlgN4njcPG7ZfIuGa2aVb7I=;
        b=R4Efw6CoHK3Yi1aNVethZ3xVnESltZDnhooy518LFiilCzxKDRH+Ocr0EG7zc8OlJf
         Ny0MtyAAt4zjUskXJgS30pg+uCX+eOy2nSziGNBRny/AmTKLU85ZLoIL5acPq9npCTOR
         yCE+Q8RFCZXb86pXeINLp/SKmEcyBuGP0jKvGk75N/sXXS/O3/qU9JkdaVn2tI/8g741
         wyRrzpovoEwkVKoi2uQsqPzIYpV/cpcquuRXbb/5Pa7s4QbdHSgXN/dCM+Rmavpb1KhQ
         9jsftdVlTbcY0bU+qBYuZPM5OUEswZV60wO7QWaGXWEu9Ncn5itI/j6/zGTl3qU1nvLT
         GWCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781874885; x=1782479685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjEqOBx4XBRQmpZWps6rk9/oRg3CowveChr0GB1L2fs=;
        b=qJj8zHckOgG+QXs8AIFL9kai3/6qGzj/MfFZK3Ni+vfK7tT84vogIDKu4w0aDJxBDt
         TPSF05EKVxc2mYrln/zpJ2LWruH2B/s847ZYshXP7REBmjOR+KFfC0FKEdzGETWmN+Hn
         JYTjr2psyCvVIGiDJP55WxM17fYE9qKVK4o+NISlKXFOTCwrF9CFs5oSWKy3rARlSkAh
         tWYcXhUYIf4GhMT/ctALHL3SNZOx2WYT+dWBg2LxCgK+heZg77qjVxl/g6uzkZzrCZX4
         xteULzfgxJ4Bc7UbJk9Qy8sABVzOc+N53lBQaueOsKEj51ohCEO8R693YdbXbBAmnslv
         dCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874885; x=1782479685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JjEqOBx4XBRQmpZWps6rk9/oRg3CowveChr0GB1L2fs=;
        b=FngpyD3JEcJL/lzV4rmtqKRz3XzSA8zhkypUI6MXnOljCq3zZNCf/TTd1aQnPcpw4m
         zlHMbG3bguJcVy3F4OEo06JABh0mIlKQV7uUU2DWochXVjNe94xA3Vtr2rnc+eL6cwNq
         vpxR9m7QJzM01EokreLCZEdJuOnKx8xnnXduItmG0mq6q3KRexf712sKBaDWk+yvpZ2q
         1nHZNclsperea1XoGB0sbO2V/ByAOIMVTD/TH7r31d3BJz/OePU7vdpBl1ZgXERFCxt+
         J1BjzWYIR2O+XDGgJcaIwxsARRMJxu2iD4sgoxM0OfFn2Z2vocqTPpLgAjDJoYPlm/bk
         wrzg==
X-Forwarded-Encrypted: i=1; AFNElJ+sFXtFxRKV1omv2gEKbVnJyZam7JpL9z6AuZoHHQ3K+dfufGUGIDy9VCj4W2Rs/tbrgzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqbYT7+M/V+wEgatsdz9w5gu/5nb/XzMgxdpNEm58jTCypy9sj
	nrtZmICZtlaiUMIa05pkbVc1H8Kt3qDVM+05scGkLMfGBUqqbUZZ62VJGwMFt44bMYNuVHg9mZz
	ffptOtL6d4qtHc21N7bc0BmEKzYvHIl4qY9pIrZ5v+Q==
X-Gm-Gg: AfdE7cllEp4S9c52o9hKkFEU6yRLYyS6ktheC48a950pCWXhySLNIIvQS/xvYZE9PBb
	AbP/adkD9s8EvfL8eGxyOrOkEZXrx9j7hSx9z/bfSl8nLFHmfrW48huNcE91vDka76Yk3a1Nc/3
	4mfJkxRTy/B9GKo+++7A2RIYWtwu1AQVj1k39Vjwao0MEAJh6rEjWfT3Ki63/e23tixh1rqBL4P
	Xa4in2HytJyv8wZaITOtY4y5wkgxUrDmXuNAKSRTxOSGj0SZVH+vifeeMvfT3T5l/2FXtskNzPX
	Ygb0gq/kzz8PuvhZJUzIF9+fIbXSDtuM39tH685Fd19ik7SfAH8s+P9z
X-Received: by 2002:a05:690e:12c9:b0:660:4090:90e8 with SMTP id
 956f58d0204a3-663030d63cdmr1999344d50.29.1781874885105; Fri, 19 Jun 2026
 06:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619130537.820184-1-alex.bennee@linaro.org> <20260619130537.820184-4-alex.bennee@linaro.org>
In-Reply-To: <20260619130537.820184-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:14:32 +0100
X-Gm-Features: AVVi8Cdq18FzEkc_gHexW-klQUyn9uNvwzjyRrER_rbWwczZhnhBDP5u_klSlxY
Message-ID: <CAFEAcA_rnV3Fq0Qp_XfNRn9p970iAXzeNMD9VJiE3sW+PQ6vVA@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] target/arm: do not clear halting reason in
 has_work helper
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>, 
	Mohamed Mediouni <mohamed@unpredictable.fr>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pedro Barbuda <pbarbuda@microsoft.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
	Steven Lee <steven_lee@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org, Troy Lee <leetroy@gmail.com>, 
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
	Kane Chen <kane_chen@aspeedtech.com>, Tyrone Ting <kfting@nuvoton.com>, kvm@vger.kernel.org, 
	Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 at 14:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The helper will be called multiple times as we exit a loop and until
> we actually restart (via arm_cpu_exec_halt) we should leave the
> condition the same.
>
> Fixes: 6fd2fcdc61b (target/arm: teach arm_cpu_has_work about halting reas=
ons)
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  include/hw/core/sysemu-cpu-ops.h | 3 +++
>  target/arm/cpu.c                 | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
