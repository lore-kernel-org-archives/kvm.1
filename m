Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752B3E8355
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526248; cv=none; b=BlpPSeUULJMJQj9LqLHJqXiaPCXH45mwBjuiqRUQDmrdKAr+0ATrRECs7xn6wR65QTExc9Kq/GFH4/nCnyw25q90vYUbvkdc4VFUVhiqo/xqXyeGgQnzTUFv1Z3W0+9qx11G4zYqEY9ELQ7epr4kOOR2P0C2hYhDdOdFfMqDDgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526248; c=relaxed/simple;
	bh=dki4JKzOiiuY5vu3J6a2tqZsAaeVpvMA/2zinXKN5uo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JWcdFFWTKTNghEBnnuHrXtjBYG3KXGuaTZZwzlWKiPYP/vd8a4EbhOKe6u8S0XaW703uy4gICrvisZgDzFKUOh12SIjowstntmvGHz5dqAGAQTyce/zYj8MOKhA4H6+cm+xC7J9BcGQepxfQ75EisJt1Syawb6pjsz34jaSwONE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=quMEJrns; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="quMEJrns"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4908b92904fso39913715e9.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 05:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781526246; x=1782131046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dki4JKzOiiuY5vu3J6a2tqZsAaeVpvMA/2zinXKN5uo=;
        b=quMEJrnsMt0wNxBMhspzvnSBGSIjdcZqDpUULy+3Z8i9QkLAZZzQPBYruU2iq9GHD0
         s/fsIuVPK7kX22uIgfAY+p7tPlI4WAzjGCIFmMd3JYA9T90rtx8quowLi+gA8Hexnvud
         rchc3mEehCO4RplyjBGSAUgoGocWd6ELmZPpKeOlSwg+wiBaAzZSW9xj9ssgJW+8ofSl
         ccK+H43K9fGk4ib+CfKRsbYYa4qGT/1tCsc2N6fvrzlseEj7i1aN6jRG5WRZfGj2HMdk
         M60nA/qajHaKYrwrh20sGNlrl5PW31NezC+NxzUw0LisCyzTrkVUTNQTnOiF2fa4knQW
         DwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781526246; x=1782131046;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dki4JKzOiiuY5vu3J6a2tqZsAaeVpvMA/2zinXKN5uo=;
        b=b1j88nAwF3/KpJ94xfbCCsJIqU+XQu/J0eU5ReCZciBPqOkA/leznol1rxvQ/sz/Th
         rgOKaI2ckFNLTkyfaP4rl+kQrhOBRMroPxdT16FAM6rTZImxqx6Rj/3Vau35YERY/Z/6
         fGg7GMEp782l0RgUV7UcAuz3gFL+7zpISgJL5SaBUVh2BIKghGhMM/ntM3ufhekX/cwR
         VL38sh+MpiMnGKQADeNX+NlQmwP+xalgeU8uA1WO6+o2IkFZTxGwFsz3a3Rx7anFQjB7
         uP67Ja+DEkcKoQWp/NbZ4nLqQjJrpFGljXx5L3auistRaQuHANxzMvuvVbwOs28Tbk/v
         dI/A==
X-Forwarded-Encrypted: i=1; AFNElJ/34niUi3kqou6uAXdWmZRcTe+5AqAXIDIP5JHcguCfCTKEf7srfuQC6EyocZ5uuo9D0mU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs4zgiU5eD5hq1tKRscYttl48/2eLtHpNgrEZ45CDojjPuKLjY
	4KYTSo8K1/e6ZQ2J1f34XqbaCmSntyYi+ykS4UcCjYvb26NTNMQT0Otb0FUYSSVsRl0=
X-Gm-Gg: Acq92OH5GkfyaWAMGrdMIwshF/TTuxR1Q8sLc/Ohritx3NUpVxLW52+x7SDx+XLWt4t
	5Fl5dw8p32ke+TK6EBC4dsXnqXCw+81OOqHAMH7CExYyWzPv9+TDyMXguP0xK3u8a/OxRxzOAfN
	KuQDIZ6a5igsZSCuZA6OLgh5WCno/waJY+2Odz9zOKV2zE7uAQrRwEYJtzlEadB2l8kksPzOQID
	Ug+ZtloQ7EuRpgmAoVFn9lLhdT27aXFPDmnixagxHFdAXzspjsgg77ifzpjtFSBXO3hQWJfi5ai
	XRzKAGzlB/9ril6RhKfiwHuO3QgmU3ZsZUBTCQtIizdJteRUQ8OfR8Obt7JUahbEPWngPfJvnQE
	R2SInK1aAoirs7bW86yS5h21umfCrchOVPUGGoYQDsxO55ZfnMMb8jWozodZPed4d60ob7TP0oN
	ft+bWhQ+pbcq6hUrXUIIjiGoY=
X-Received: by 2002:a05:600c:4215:b0:490:bb3e:30b0 with SMTP id 5b1f17b1804b1-490ec4c0ce3mr110943725e9.4.1781526245655;
        Mon, 15 Jun 2026 05:24:05 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203d2449sm234758625e9.14.2026.06.15.05.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 05:24:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id E6C8C5F857;
	Mon, 15 Jun 2026 13:24:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Alexander
 Graf <agraf@csgraf.de>,  Mohamed Mediouni <mohamed@unpredictable.fr>,
  Pedro Barbuda <pbarbuda@microsoft.com>,  qemu-arm@nongnu.org,
  kvm@vger.kernel.org,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v7 7/8] target/arm: handle the WFE trap case
In-Reply-To: <CAFEAcA86_a3GfXCDOo2G-R6v3ALwUwNFRkspyTCR0umGiAB2Hw@mail.gmail.com>
	(Peter Maydell's message of "Mon, 15 Jun 2026 12:01:56 +0100")
References: <20260529082948.363931-1-alex.bennee@linaro.org>
	<20260529082948.363931-8-alex.bennee@linaro.org>
	<CAFEAcA8719Q=VCwOm790V6FPA8FyaFZEux=N-7PmOGaaq=O_sw@mail.gmail.com>
	<878q8gjcms.fsf@draig.linaro.org>
	<CAFEAcA86_a3GfXCDOo2G-R6v3ALwUwNFRkspyTCR0umGiAB2Hw@mail.gmail.com>
User-Agent: mu4e 1.14.2-pre1; emacs 30.1
Date: Mon, 15 Jun 2026 13:24:03 +0100
Message-ID: <87wlw0htzw.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 15 Jun 2026 at 11:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>> >>
>> >> Now WFE can actually suspend on A-profile we also need to handle when
>> >> its trapped. To do this we need to pass the instruction size so we can
>> >> deal with the is_16bit syndrome encoding.
>> >>
>> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >
>> > Doesn't this need to go earlier in the patchset? Otherwise there's
>> > a point where WFE can go to sleep but doesn't honour the trap bit.
>>
>> Hmm - the way I read the description was we would only trap if we were
>> going to sleep. Pre 6/8 we never sleep so we can't trap.
>
> Yes, that's the point. The guarantee we have to uphold with
> the trap bits is "if the WFE would actually go to sleep, then
> we need to take the trap".
>
> - before this patchset: we never sleep, so never need to trap
> - after patch 6: we can sleep, but we incorrectly won't trap
> - after this patch: we can sleep and will trap
>
> So there's a window in this patchseries (after 6 but before 7)
> where we don't do the right thing.

OK I'll squash the two patches together.

>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
