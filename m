Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35648434982
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157671; cv=pass; b=k0PxFrofAbPy7rr+poEJ4Dl6Hp9KOmBoYXz4STbn805at8YViHz+p5G6hwB4xTfgsofqyGA0tNymriLZ14sX5wQwSzVXDUQqntrIovUt8XC5eGveYYobdEZM7brnjt7+xRIvDqDAAD/QMlIz4wpbbGRPyjOdnI5fIVoaUUWXEE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157671; c=relaxed/simple;
	bh=O9zkSaCV5VFgzI+wOv+MImonveYQ2lP9YLYd2PHZgm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNpit/DDg0Ad72SZfIAR3TglSYAJCdpHY2mu3gDba9TNgz7Ifem4RQaX2//ZXeMESQDov8b+eOduZOwu7ogXxuBchQnlallA/CaqowHiQ1KbT4qBmDzhJWbKa5WvGARcOEcjtuSG6cYH4A152Ch1vcMnNtH25lO0Ug/1oJjJOqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rHmpoCO0; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHmpoCO0"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae54so688645a12.3
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 13:14:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789157668; cv=none;
        d=google.com; s=arc-20260327;
        b=av4AfjVq5FDjGymkrL1/jCUZzD/QByEk762oO6U/OvJVciokFFsHcori6KZF/XjF67
         cy0FLtpDcgNZH2Ib9fQVIi5oNzrzk6xa9gCW6KG8+bD+kGLAIK0a1alCatdUpaOtq0CN
         NCfGBe4a1DvJ6uZChfzBJBcY20+0i/6rAljTVWD5/JW9HfGZiLymGbZKpGjZHcPvkv93
         CTDD1V4KtFvBQO75fydiGHAkUzyO/OFoACJHNcOclSIiGs9lmWsCPZti6oQHvUNMprka
         pklV1Er9AqBxz0aRWw2tjoQucR9vtOqs4BPWVvGjfx8Y0AGvuCYh2Ji8V9DbVApVyJY4
         dSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=COJlAZk9jLF0UmRg14vcElvRBEITByJv3T7tBC0IEJY=;
        fh=DeIX9ziinein0TJuLOTriryKACvtGFzY3E64os8b8dw=;
        b=fw0A9/7IUIleKWa+jNenBdW/2EZDBfGEfo5CCLUNi0o3rDxoezodaSUZB6ihxWiY/b
         GJsUmoXvGjqWwPa7F6YaRGUxE2KjCJS/UXLiQeXY7cEd2HKvP2tx7qVOuvwtW6k0OLVo
         TtDZ4OvqcPotxJBFY9NJwJ7y7fWhNYJwlaQiq/BO6XmMInOP2lItv76lIv1h++rY/Npe
         uB/R/dccHv6PQrLMvnynZm4fXeQ1gcyTDQ9BfProHrx5WGzJTnQ++F4tVMawIkGQmt5J
         EAyJlKq0H/I/T+Vw3fhiHjh2RsEpvSPQIpyKQPT1GBGe1XAbj87j+qjzkbXXr58jK3YY
         nhfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789157668; x=1789762468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=COJlAZk9jLF0UmRg14vcElvRBEITByJv3T7tBC0IEJY=;
        b=rHmpoCO0Y20vSNiTworFpUesq7klNDhRuvfW5q0RhfbfTbi89l54Zn83/thaBXAnCC
         jm4zrd6xKyLbkALo35i/cUvzGrMw+iQX++lTfILUeKQ4LGeDm7VdMfm4H+MXrbp1GlcR
         DPpwZpAFTYoJ7UK+BtvIIzygALWez6qf1nChc+ro4/vveblruuvWfzbGeaszA3K8X8SX
         eueTuMOAlyiFEn9BOERAxBpepxPgy9K2DdUfROifufaHWqx5k/1nl3YRJr7B/LuhZNsY
         pUVZYNAFkAA7XacGNTCZQcn2WTCgglBWlOIa/hmanPBJDHgIwSLIVHZXPwFzcDtYNba3
         yZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157668; x=1789762468;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COJlAZk9jLF0UmRg14vcElvRBEITByJv3T7tBC0IEJY=;
        b=g+pFK1zM+QzbO0mcrLX9aRxZ8K7/ZfQMeJ9nJ8XfU7JmIU8Xan5+YivZTQOH0Gc12P
         Ii713La5Y1dv1qd7WPrMlFBdfmJTXVErjUL8VUnYY6UZLYo8x9XVDzwBmXl3yHXEFtlR
         VWy4j38qQqrKpNIhLybjPqy8w/2pG2CdqKRSbx2OTSTEqFRWmyFww+ksNw0mczroUU1Q
         H1C81XY71riHBhj6myC4o0Aq6Ketc4qKLYtzkJO3qoUDPvBW/8DmarbIrM8P1cBL5Yn8
         VfOdt2ZXjJn7jBR0CxZ4VEgzmKbv4zWB2b80dbttPbAeRRWEIRx7K4Nml11XR3fVv0vL
         weTw==
X-Gm-Message-State: AFuF++mbAtAdQEHWY6hyNpzfhfwjj1aj/OxuubymOre2zQ+K93Sbp+/v
	yeP/P4+IQn38YqyiflVtIb4pYUJwYPAYnCztETaC/8VxAUmMDlU/p8VrG+3BUcHrK+hY5lSnmcP
	GvSFVKRc+aAwMjuIm1v+HQK+xnONb/5A=
X-Gm-Gg: AYBFou2k4Hh+sVStzvQpSflbq8S/U757ZTuDvX8lZYeQVXOw7FmDnvhX6k6grp4J2mX
	dEu8Bd4cwthlRrHlxHVMXDH+ysf+tJ9J4WXMr1iWbVReQCC5uA7ROaNm9dFlXCoUZm3LIwTRAJd
	c1yMBKQiBNNPrnxJEqZ/5AhO2SQ7wuefNVMXWKwz79xkeTj/f1jBcAvx1m9E9WzcU+MxYvPmrR7
	J9qeYjzWDZeqPQ0bMyDNKtj/ioPoljIEsIVbstcm+0EBdI+0j8NEud0c/HzMYHOAxWo0L0efdfX
	O/dynE1P6pghSur3DPMhxC0Xzlyh/rUxo140w9T8rl27dwZ4IOY80LCdFUDCM94YwV4f8kq0UZK
	aZqLT36higKpQHg==
X-Received: by 2002:a05:6402:a205:20b0:6a9:c0ec:417a with SMTP id
 4fb4d7f45d1cf-6a9c0ec45c0mr2730047a12.18.1789157668243; Fri, 11 Sep 2026
 13:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABD=WFOS4j4hDv+pW-eEM9HAM2q2GY_iYdAG+qvYcUEinUrcQQ@mail.gmail.com>
 <aqREYDrEyelD8eEk@google.com>
In-Reply-To: <aqREYDrEyelD8eEk@google.com>
From: =?UTF-8?B?UGF3ZcWCIFM=?= <spawel523@gmail.com>
Date: Fri, 11 Sep 2026 22:14:16 +0200
X-Gm-Features: AcwNN1VH82F_gsfdCS5larB96uqwmtHftPdPGZ_HI7Zgrd19IBcuKFxEbPRayQ0
Message-ID: <CABD=WFMT4nZf_ApWcJ3X+yq7+YDp5_xPCQkLWexbdNTmJ=e+jQ@mail.gmail.com>
Subject: Re: [BUG] KVM: VMX: BUILD_BUG_ON failure when compiling vmx.c
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the quick response. I'd be happy to test the patch once it's pos=
ted.

Best regards,
Pawe=C5=82

pt., 11 wrz 2026 o 20:11 Sean Christopherson <seanjc@google.com> napisa=C5=
=82(a):
>
> On Fri, Sep 11, 2026, Pawe=C5=82 S wrote:
> > Hello,
> >
> > I am trying to compile the latest Linux kernel from the upstream git
> > repository (v7.3-rc2-352-g08df884136f1) with a custom configuration.
>
> This is my fault[*].  I have a series to fix it, "just" need to get it te=
sted and
> posted.
>
> [*] https://lore.kernel.org/all/apYh4GDHD3Tdb8t4@google.com
