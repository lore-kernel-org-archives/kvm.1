Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794707273;
	b=0qgWvdDy4cJ2oYsWQw7gbEYa4eJ5nmgklaxJynl5BLk26IQVerIC+I986BFNPmuT6Jmm
	 w3d973fKTCj9CBrHM+4YlsLEWS6gjQB63B1LPid7tZ3LmZd3u1UD6xWz3VYVIdd00HOdI
	 KvuaNLMhqLuHRr5B3lDATj/y1jE5uIakcEBZOPPYRbTSSd6e4PW0H9/VDrqva69I8+rgt
	 8ifvBKPP7X29Gl9WDKp77kF627Zj/l4K9BeIuPD9TGvXJyjtjx+ByMhdxs9DwEpa6IVmo
	 zWHl/mW6BxekkLh3QlVT6drLJI0d+PxMVrw9lEXd/FYznK3P6Qgh2sbqxYWMuuV4whA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OE0V4hDYj6rciPValeql+PDftw1T5fn9De/8GtPo6aI=;
	b=fMxiN72uMzsOeZ6UVTHmElISd3n1As/N1CzeczND2mOZCgSp74Cm4CnmA9adN7qabG8V
	 mWEjN2JS45EUYRwHMuff7MeCaktMa2YpVFXPgK8S8Bs3UN3FisLprjjb5S/ta4yR0LWRA
	 fme4EKNQh1dGY7Ppj+UGYe3gk1W3IyJ1Su3it9M7Fb7WVGT7LQqgB4wPFN1R7WBJKhWID
	 NugRBjLFs2BMOWBqGbDYl2oPLmu0YUoJO0j3QGU/5R3nln67oB3P64G5CR7I44P1Y8HLM
	 mZWxyrhcG4x8otK3LLKz7v6FzXKQkBKk2ZiSjjfr7QlPBKcrfYDK3xoSkJPud8sPLQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z2gVAHL2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B8E606A323
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 01:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3B8E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z2gVAHL2
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4d581da0aaso296229566b.2
        for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 17:47:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794707271; cv=none;
        d=google.com; s=arc-20260327;
        b=BZ3qZAtWRg0p9NIQ5Ecqr6t8vmsYubRNxJgOx5a0E/mCcDhxbvPJUliEP6ocQuUsmL
         yhYRZWfOC4WJwTMbaiQZ1pap0l5ebKPLFA9KggIGT3SbocKuQ9fJAGlK6DbDKy1w7Q2f
         dibqfGb5pju62Y8PubTVMjc52l9qJTWsHmEGuS0QLVt1Gb/Ei46e9rFnSqLw31yDna/K
         4+rr2Pihfgda2z+lMQe1N7nG04TvLsRLagMY6AbtOXN8DYFMVILsovaAA2sfnWGG5LVR
         knkWU2XdffaUjR+L1qzW8ld/LLgE0LQX/xatO8LKN7BwabnmDie8G6SEWIiIIQIuVOZz
         aOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OE0V4hDYj6rciPValeql+PDftw1T5fn9De/8GtPo6aI=;
        fh=02FFfDG0Mo9x6s99mNnCF97ITEK+eh/DOyJRfipcvtk=;
        b=gFjdcDAIO1Al3AVbrO51E9P2k2DgMCiVz1HVRVsj/knKksJGUnBwdlexCdW4VZDtjq
         gMIqM27RpKnz3a0wSJSsT0SlmGqBTwNsAwqkj9qGKyAcNvUCP7AJm82TitoBvFZuB42T
         eISjeYFUKgQeIdwF8bq2ekFPaaJ50lrl6M9nMFlquadWvaEwaDaWeIDSX6dYYkhTvxRt
         Bvw/iP4vyURQcb0hY5hrHOizys0wb2YDoeRWSVZ80KtKzj5WqlcUuTqf5lrxgnnQdsot
         M5uwgZP3mOVZqklx3kJDhbgvglS9PHP7OHNFCIkn1m1SiB7/7Wtt70aLE0POzsZbQpSq
         Q8QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794707271; x=1795312071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OE0V4hDYj6rciPValeql+PDftw1T5fn9De/8GtPo6aI=;
        b=z2gVAHL2z+x8knWv91TPYYOz6MOsnsUKca8jKwGhSeucc+ZXvt1GALAUWo1aWaFcI5
         ng3uFS3yt//zqgciRT/DBMTOx1x5hPkA5DkQSK6bPTzS7Q+nwvtz+BqWv7Ef+1B8vEBJ
         oTxO+lsUQED7F8x1UKB3uU+wrZf7DWSN76v23rINlQwzuLU8WwhM+PejbCtbeMzh4rk+
         Ajs3d/7o+QxOnfL5aOtmX6IVez1+1FcNy4cT0z2L/kKY/5kg16k/jFs6D71/mKgpnkME
         vGPj9Op5uNNQcDMHWSkbIl+fyPd/DSBFTYZHoShZY3+Br9aVFpoVTEtTkdTrKokbYFkW
         wI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794707271; x=1795312071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OE0V4hDYj6rciPValeql+PDftw1T5fn9De/8GtPo6aI=;
        b=KLsqayleuh1XXjS1scAB1kV7erDCvjsamXgFYgo/UKkkug/FEmFWwL122f0415u9b3
         1KBgSiOaab8maxO24eJNtyXY0IhxxdwyFRNNwtwIZXumCqwjyH1nayVxXHRAFKZwEIBg
         pEgWAL/WYg+RmFPG5OnUWrUDcTwmW9WwQ/dCuZkjAb6Vsn2Npbk23482uF/LD1Maz2aV
         OGTrw39rZAcdY8fIZ2U30a4U52jNzgfphZEAOizb656jX231xhihzYfz/X7HrV7ZZ5IQ
         2R4OKyiVgFWmYLf9p421cz6pLEyZ4aJpXmeDyFM30ch6TeeofXHz4B7pNYjGszX6bNYp
         mBbQ==
X-Forwarded-Encrypted: i=1; AL+hErGXh0Kt16jhbx0BWqcI1QZzXyQgXUqnwTOLpH1Y/ykH0UZwl2mRzamSeGtMIFs/3uXPdmk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ouQzBJpC79UFVO2MFGR34sYp4hmVF++B+Ldbb0KdNjAazEtWM
	IazOuMRRuR72YShZ1OFmm/VNFv53ypiZ8O3+odNeRltMJvOmWw4pCPPkOpBfECzX/MwLTtnNu9/
	RAeQJ7LAgTYWYEXchIR5sFFMMMpUSb7o9Dcry
X-Gm-Gg: AYBFou0RWEIIYDV0MMsIu7G0o/vccU1YUsaZaHBVcIa3nij8EjBLSqmiJ5Lz23WTLji
	iwJs4EEutObnSNgklKuMwYeAMfEzNJ+BLxTA/9NOwpmLNtypxHFGkelOgu3CRPEmKrXZcDd1rXV
	1wkZVcaYbJ0WmiZWHaR02iflp4hbj1v4GeGUzrFYlx8PtdKRk0032/19nO25K7bBilVtrRg/NEY
	Dvjrp7eaDboR80UCTn52LggfAcmM8lHBu0R15j1GzVXhjDlWB33uGY9FWQnjDb2rSLRva0+6a/W
	SJHhMJQwGGBR8dRvMrpBsf+vT25CHx4T/zswQlHS4JML3Oa+qgt5LhUDtbMo2O45jwYlhPYOiX4
	IhQP1oRUD2fd2L+WF8THRGXT0IxvkVKN/J4bX/oYQb5DgsQnI7nbQ1UsNKxOVGVn+cHOkSfHrht
	aGFH+hl2xn99E=
X-Received: by 2002:a17:907:9443:b0:c46:75e7:25af with SMTP id
 a640c23a62f3a-c50963446c5mr535005266b.11.1794707271041; Sat, 14 Nov 2026
 17:47:51 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAPZV9qUk3-eKOGEjVc7f0QzZcjb3L5QwUceAEUV0nuCdo90eGw@mail.gmail.com>
 <20261114235828.GF3706007@nvidia.com> <CAPZV9qUvgKjoBXGjYXJzwnCmqzSfu781ZSG8zW6Fn4PokUN2uQ@mail.gmail.com>
In-Reply-To: <CAPZV9qUvgKjoBXGjYXJzwnCmqzSfu781ZSG8zW6Fn4PokUN2uQ@mail.gmail.com>
From: Gustavo Andrade <gustavogyn@gmail.com>
Date: Sat, 14 Nov 2026 22:47:34 -0300
X-Gm-Features: AclHuK-T0Xx18CWBs0ljRBJr9OWFzUd844AH_e8W_0A95quNMuvEFSNR0XQKFu0
Message-ID: <CAPZV9qUMZcwVF=CUK4LY4G6Qoqd5ykCXE5ocX8VCy_f1c6+aBw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] vfio/pci: Wait for GB202 firmware after reset
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

Thanks for the feedback. I submitted this as an RFC because, while the
workaround solved the issue for me, it seemed unusual that only my
card required it, since I haven't seen recent reports of this issue.

How would you suggest I proceed? I am currently running the latest
VBIOS available for my card (Palit RTX 5090 GameRock, version
98.02.2E.80.10), which is also the most recent version listed in the
TechPowerUp database.

Best regards,
Gustavo Andrade


On Sat, Nov 14, 2026 at 10:44=E2=80=AFPM Gustavo Andrade <gustavogyn@gmail.=
com> wrote:
>
> Hi Jason,
>
> Thanks for the feedback. I submitted this as an RFC because, while the wo=
rkaround solved the issue for me, it seemed unusual that only my card requi=
red it, since I haven't seen recent reports of this issue.
>
> How would you suggest I proceed? I am currently running the latest VBIOS =
available for my card (Palit RTX 5090 GameRock, version 98.02.2E.80.10), wh=
ich is also the most recent version listed in the TechPowerUp database.
>
> Best regards,
> Gustavo Andrade
>
>
> On Sat, Nov 14, 2026 at 8:58=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> =
wrote:
>>
>> On Sat, Nov 14, 2026 at 02:48:53AM +0000, Gustavo A. wrote:
>>
>> > PCI reset returns successfully while the Firmware Security Processor (=
FSP)
>> > is still initializing. Restricting BAR1 to 4 KiB mappings masks the pr=
oblem.
>> > Waiting for FSP completion after reset restores normal output with sto=
ck
>> > KVM and verified 1 GiB BAR1 mappings.
>>
>> That doesn't really make any sense, you are probably hitting a race
>> condition somewhere since 1G/4k changes the timing. And possibly
>> because your new kernel versions boot VFIO faster than older ones.
>>
>> IIRC there was some VBIOS bug in old versions that caused issues with
>> vfio.
>>
>> VFIO should definately not be doing things like this.
>>
>> Jason
