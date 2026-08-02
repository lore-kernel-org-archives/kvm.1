Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642463AB288
	for <kvm@vger.kernel.org>; Sun,  2 Aug 2026 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785672068; cv=none; b=Fmp87ohxlj6l3s/uldfud4cGhKG/Ato00hWFY24xd60a72anp8b69oTNREm4TmL6uExl/VOCFeRiaz2Ta4AeYUH1kKcBwoLvnjvo/oSQTJ9TcieeewaUUUlMwTjRtsYAcBkAeFG3CPDC+hOt/AK03wlQj+lafVHQsnlALl9StFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785672068; c=relaxed/simple;
	bh=OUPhOJtFVYRT75g00eSkyTr3j9wy3n/HPEB8KDvHShc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6pUjFLS/PQlGhOrp0Xb6b6oZOoyojaYdh0PILOjUDVo7G3+a+5ohdUQnmrHBe6ukCkiy25iZFZ4JPe00oBnkIAVaXNy4WzRu6/UGcO70wS6AN1aKSw/i89+VaFWKCfEWN1H0vFM23dTiJFeTJhBeJV7/e+k8/34GWb6/ZL8dFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMcjVKS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMcjVKS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C121F00A3A
	for <kvm@vger.kernel.org>; Sun,  2 Aug 2026 12:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785672067;
	bh=OUPhOJtFVYRT75g00eSkyTr3j9wy3n/HPEB8KDvHShc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bMcjVKS8lFKT8EPJUttLPahv79YmSgb0W+e3XSjjTT4oVKVw8pnf+by4Mp2XAbuGi
	 qTUf5oqK1kV6QKbPTmyLPwr2rFiDqEguSvlI0IFB08/yjVJZgfG6uJNShr6olXWGgs
	 tQXAVDa7Z8jpkQx0Go3uLTEX//iQ1O1AURjD09zaGtBbmSLDHtRSBIO/1tX8kdpOoY
	 v5LrBGpTjJyC48IQz+U2CaR66vJmCQbzv/5SJjaJoBERP4NcsrswZHJ/Yf4vFMBG6x
	 l3+DGcUUKhXQJnUiXvLAps4vyfE2YSzAA+anHm9ehmQrQHzLuonOHdHcaSbCjnLU1i
	 n0y66Op719yYQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a051904222so3682011a12.2
        for <kvm@vger.kernel.org>; Sun, 02 Aug 2026 05:01:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp732KedrTihHYKCCO2SZll1zBlT0AzDczNCpO3f6AOmtuRxeCnw62TcTKLq5ifPFp6zgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMN3TbEm5J7EOCxqVhBDMQn/UbyuxYnbHboPJTSqtwN1R4lTK
	XuMPsdLq3dlShPS5OBC+iZB1nzwSLhkfvBb0dpEcnFr2btqjbz/TtIo9QA7TsdYaV1XarbMRlNV
	+9BAgvZcHtNdlgifNlFT6SVSS5FI4C/0=
X-Received: by 2002:a05:6402:21ca:b0:698:c13e:179a with SMTP id
 4fb4d7f45d1cf-6a0a7c72678mr3991274a12.10.1785672065678; Sun, 02 Aug 2026
 05:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723111552.1623996-1-zeng_chi911@163.com> <20260725033820.21904-1-cui.tao@linux.dev>
In-Reply-To: <20260725033820.21904-1-cui.tao@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 2 Aug 2026 20:00:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6SfckPJkB=ZcXT5w_6mpkf8kZyaMHes64Ep_56atvPLA@mail.gmail.com>
X-Gm-Features: AUfX_mxnF2tcbbT1bHtbfXwSXfVqhfHnHhDAp0-yWQvjp3AfQXCn25mWK981EDY
Message-ID: <CAAhV-H6SfckPJkB=ZcXT5w_6mpkf8kZyaMHes64Ep_56atvPLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] LoongArch: KVM: Fix PC double advance in kernel MMIO
 read fast path
To: Tao Cui <cui.tao@linux.dev>
Cc: zeng_chi911@163.com, kernel@xen0n.name, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, maobibo@loongson.cn, 
	stable@vger.kernel.org, zengchi@kylinos.cn, zhaotianrui@loongson.cn, 
	cuitao@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 11:38=E2=80=AFAM Tao Cui <cui.tao@linux.dev> wrote:
>
> From: Tao Cui <cuitao@kylinos.cn>
>
> > In the in-kernel MMIO read fast path of kvm_emu_mmio_read(),
> > kvm_complete_mmio_read() already advances the guest PC via update_pc().
> > The explicit update_pc() call right after it advances the PC a second
> > time, so PC moves forward by 8 instead of 4 and the instruction
> > following the MMIO read is silently skipped.
>
> Good catch!
> Reviewed-by: Tao Cui <cuitao@kylinos.cn>
Applied, thanks.

Huacai
