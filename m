Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3802E2E541F
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984364; cv=pass; b=FKDyLiWMCsdl+69sjup0LOxE6GKh8+LQj+rrTysupqtrsTpmK1IimCpOJ/AGQaqngQTWXiSz388knRMUC2CIStm6NpJrEX3sT5YIdBbj5NIOCaqpuZdxabtRnH+a/Q2LlXrzQux1sptSa9bSWYxxBget3u/fW8j3dGIgPEqIH6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984364; c=relaxed/simple;
	bh=3WPDyIonSBCgGlVYifqoCBmZfz+ZrP/eDqswI+ER1VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsQkllHEIAwfso/sSiu5+x5K5LRCqXhdYXGD8GA6rFUp1mJvIqDAEUa9uWlkjIVCq69TFheeVIdZI6Oa9D6E7b3jiHsppLST6JPz6t4se+ik6ov/m9bAnvWZKlSLSFNFfGfUGqemy24g1dwtLE4mYl1G1gnRRE85gxEAS+kLom4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kan4fwwb; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kan4fwwb"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7dc6d090381so10738367b3.2
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 09:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779984362; cv=none;
        d=google.com; s=arc-20240605;
        b=k7kHGCpw3JcyAoUn2jW4J8EnTUMjvIPH5qa9IihJdd0tq1+02m1VwVo5YFqH3ixec6
         z2Q4KNoUW5SNE74tTnh0asX/eswHHcJaxRUYlbRFQcSRb+TVZqmvJ5ZkgLiiloqkTQ1a
         uf0i1Oq+pviNQ0YqqLhPuGNjxjBjC/b6oimTZGWs4pnxfEA82lHreqzdKVsc8GL7sjEW
         /xfqTbDCBvO45aBqcOBI7/OPwEVXSuZU/jNUBWzuP2iGvrjX4kf8zUJkQwoCkCpgF8qn
         gXd40ntujaLWELlVioDsy1QOkkX9bCHbwJeIUzk0mg1AwpvNLYoXOVxGNDqmsjHbMEjJ
         diyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3WPDyIonSBCgGlVYifqoCBmZfz+ZrP/eDqswI+ER1VM=;
        fh=Mn5+X4o8YTt3GJDX+wweM2gv6l2rgq8uq9h+a2rcXMA=;
        b=E2uWcU0FU8akF4g8b5GFDpD1NvG4Qm7vtYAE2PPCdjs2yQTqsbAPmFSUU8xorNHVYL
         3vlnG6U/LAC6BizBrVUE29e/wVOocrxau5ATUkiPK+mw+Ty2vEyqhBDiFo4E/hn+3Xqy
         qYeRdYr1po/IhUzBLwlO4twVa1CeTwD1hUr54Eksrz5lsMhpr74R8/7ocCjVOpzeTxuQ
         f/iN+G8kXEP+5+SPfFCLyJIlS04UcqndC4wo3KNOYE8+fW9YZmjel0TpC4uUldsM27pG
         ihCRzwkos204hbSE1ys+y6UqKA7di/MAhQJ3fymauZA7UBQ5CjWC8LrS3modR7YBaKzw
         Squw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779984362; x=1780589162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WPDyIonSBCgGlVYifqoCBmZfz+ZrP/eDqswI+ER1VM=;
        b=kan4fwwbJoDA1JSBkRixk879tO+eaQjG0CAu0rrprIcsRv1DhLEO4vvRvFFMFQReEk
         4CL9lD/7Nsu+Ks7GOvftFJ/PHtadXR0NUnq58oPrtb6xege5azBmT+xtSh6dy/uCiEwV
         v3txQQa90Km08BXePgILoh7DyoxjN29dP5Lu+So5j02HAOBmXDqBSS6VeaGJdzy+YJo9
         7iREq+I9LBPWBeFdUcVLD7F/hz4RIVg/Jh8H4dRMGUsUT41ZGoW/N9otono3rLX8HlrN
         CuOsufh3vpuvCBMB5mJ3U+rKZEK4JRclyf7wO9a9ctLvVS2ma6gwHvtV+9EAY/qIutPi
         elfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779984362; x=1780589162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3WPDyIonSBCgGlVYifqoCBmZfz+ZrP/eDqswI+ER1VM=;
        b=M/5qJ84b7LpJpLX21GLm0SX4/T2mIBuHt//v6xDzophFM9u5vY8IruCyavnlPdsXq2
         h2CWbO8SFOxFlVTQjFMlwdue9NTw2vny6aVFZ5GvFDpoA0ZHRbxE63LB9Yxgb0vHDJm+
         HmclJvMIv4E54wshOaKZk2ce0s+Np31DzFsPqf+slYWpWfv0gsEEDDaEkgY3zpg3bnjs
         CqjlHIjf7YWE4O0Zm0CGBubsyyVbPxtHk/0r3NWq7Omem3y9isgVmp5cz+7RtctkYcVG
         qoZBLdWs2T2HqvRupd1tY5h7tkRpL0z1G6tNLGFvou8c4fTarABbCCSPISmnDVvLK9JY
         SGiA==
X-Forwarded-Encrypted: i=1; AFNElJ8Uyk0q2uEW0tqGL7Sv3YSRsxBOoF2aYPGHJcdAPuDVMyvVCoZtT1v6ylLx4kghiuKpk6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQsTH7cSHx4B/rLBpKiPl2C2R/JNBrkWXjE2ciQrkhcgx61ghZ
	LwlT/GH+eFsg9bOULxQP0eHg6HPhovYYdITz1ugiCoN+L5MzWQdxd7rWMp6Ur/j+YIgg3Qgf2bf
	RRfjJth6SORUbnXpWQhnbWKmWw9As3hM2mKDIJ9J9qQ==
X-Gm-Gg: Acq92OE+XFN/ZmIfyT4WITuQAFZqUmHjK6M7tQUmZDQqzTCOk2Au/QG2T4yCFKDvFyh
	LatRtV267L8cmn2gbulZKObzRGGWrn+9EixBEZep7D1cfxKIlfp29W/m9g7dWFBgr/aXvmy2PDy
	EmoYgwR/9/giMz8t8uXwHctPGYIG7pFNk7L1lx5TSslSbsTgWZTmXGAjw77v3myjuGfFdh4AoV/
	Hqc0eP5JtniSunZGhLbhhz42ZWHoTga2YXz0LbqTuw+Sp+u+DO3ve1PL/K3+NHxYI9xpIUwgZll
	vDd3iVby5BGpoNAqO/sHvhjZ/g/GR0qYHvV/Y/aZ5NbRTSEilR0z3Pf3zbXiwNjIzoYtRO/AaKO
	n1wLwdVkRtBKj
X-Received: by 2002:a05:690c:368c:b0:7dc:2f45:d036 with SMTP id
 00721157ae682-7dc2f45d29amr46894057b3.41.1779984362125; Thu, 28 May 2026
 09:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527114320.1581552-1-alex.bennee@linaro.org> <20260527114320.1581552-2-alex.bennee@linaro.org>
In-Reply-To: <20260527114320.1581552-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 17:05:50 +0100
X-Gm-Features: AVHnY4Kzu_yhLWNBW-7DlJzmuj9Pp4fD2a-EoJBaUpYYftjQUzoGD_6uwx3F36c
Message-ID: <CAFEAcA_-rY7A0Q2GZcFBVd4WOn8S5TXM4kaAnz_Gzn2wHLnikQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] target/arm: fix WFET typo in syndrome
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Mohamed Mediouni <mohamed@unpredictable.fr>, Pedro Barbuda <pbarbuda@microsoft.com>, 
	Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 27 May 2026 at 12:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> A stray x slipped in and we didn't notice!

You might mention that this didn't cause any actual bugs because
at the moment we don't use the "WFET" enum value anywhere, only
"WFI" and "WFIT".

thanks
-- PMM
