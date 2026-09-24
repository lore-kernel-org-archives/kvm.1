Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81DC2EEE89
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 01:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790211862; cv=pass; b=p4lHLzqJk0zx7bAXqMA61tn8UeMHaa06Ejio0xt5MLqDbH3jRdFwwNsvnNK1gB8yfLEnPQWwElIrUADZYfI9HqvdoOaDuAekoshVgY9v/nvt1agsWNhapuOcKjg8nNhvRiH74of5v3F1VbM77fft6OzmwsIDsykBNHJaROvJbHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790211862; c=relaxed/simple;
	bh=e7NYzYowAH42T4CIyLla37LCOTvpZlsNv4w1YShEB0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3y/ktLVrc/w9n0jKxI+LpCTSU3PFgl01wBfZixodaJ+e91GhlRsOeUTNvTy2y/2ADSxXXvPSUdbvp7JWOwHZbOt+hSGddwk5R87nKM6WwIozVXWip1zkQ4O8Lt2lnrBA1Va+eB1AMJeFXmBdzYZm+zB6jFxSP7N8pVKtN0l9c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajy0EMXt; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajy0EMXt"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e620fa473so8776625e9.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 18:04:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790211859; cv=none;
        d=google.com; s=arc-20260327;
        b=ChgfbYSIEoA4fuTCJV7chlrVulcYucSshGyAudBEshdprb8uxnAb67UP4TutFF4VdW
         XRxPsgDMpUgBxNXcVAove8p2evGYEtGLN5SAV1h/1u+wsXLhxEZW7/lfoOLqf1Ld8OH8
         BNPGuj9R5gmjzhDMmwUi0g7RKtTRbHTQKsTwhoe/4ToY3oaJsAA4Fl5WaUdP1bVnxrsg
         kOn+Sg/yTnIzNo74kUc2GkfnvXjXobGCnhTwwHDfuklHH9Gtn/5jyoN9nN1iY+xF6cAR
         GcNaYjlZHzDHXbLWHDW4/Uy/O5mmzOuenwLtdX7rHoUfSzEr3UzOmFHvlmaHYYlml+bB
         7log==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e7NYzYowAH42T4CIyLla37LCOTvpZlsNv4w1YShEB0s=;
        fh=zzJOfGRijyGYdwXOURCHJRq4oXgzRyahSmM0vYT+qOE=;
        b=QAU2Vj214pqN1unzR+Vxc/S8aMNRlu2BRVk+yVvvojXZbz7BCtmVXt3TWQU83IBI7k
         37MLX5jHiLIjPPQ+rtBQTwjG5cEDvdU/Sen3u7bvVf4XIWHbo3T5B1JmnEMCf27RjHBI
         iOGtXzOlInTs5nT1Hfs98ty82UH2sNKswwmTClmzWd/4LusbJf+3mdrIyFxfyv2S8kx9
         oOqIT0aRCa86mdRmZVCSxDwGP/P9G9aJlYSJwSaHyk2BXoGKE5VbTnm1ETNWjvYlucIM
         wn6WbH/fudo5VAhE5+xDBVgzFMN5RK+LFiurotbDsu+9c3a+IeRvug7LWdxeb6fOQclu
         lvhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790211859; x=1790816659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e7NYzYowAH42T4CIyLla37LCOTvpZlsNv4w1YShEB0s=;
        b=ajy0EMXtWXEEtuEzs0fhJaHHzTOIefavKgLWDDqenNKEF592vNluon8kjHRz53ZWeg
         T+cSyPPQoj5F8jyZFK1Ee7puNyQLV+PVASSq8d7XDnmrf1yfL8JrU4R8j8DGw1DAnpD8
         neChnzF5hLluCtW6ZInxgguX6oVyKkIXtpQ2t2oOXcFNPMbWaSRkL6tTOSjmuZlHN5M0
         +2d6ZhV6JieiXYs9qK04hilhRB0dG8DzkLQFuS02GKwvKicGf1TUpgAqS+HabX41kjzo
         alx5DyBXS0hF9OC2ysqJ5aZlqNUHL4M+wS4BnFrUPVek3ojlVc66fdKIlZyKmSlYwftG
         JOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790211859; x=1790816659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7NYzYowAH42T4CIyLla37LCOTvpZlsNv4w1YShEB0s=;
        b=flISrEiR+n3ugPevrEZA3CMwMYgFczo9+I3eTdErIdoWxMG7ANavMfVHNKAspRvI8V
         MQd7m4F+rHwlmyppNj2jJjk62+xEDCKRFRE//uD4S6nt+vUm66ww//hZiEVkPhf9qJDT
         BSD2oefs0t+6N2FAZJSs1EWfFmUls8IHMBh5oLocwBGPGRh8hcGesZ/jdHgtMFWdxCrG
         ndJiyWt1ON89ylTKES0siusbW5RbPL7qKPROrF3n++yNzB8Jgr+RQvEJQ97S5vyfDrBo
         ZqtwlVJhwjWij5u1bPWBt6cgF6DPAjEHpnbr019Y5P4n6kXZ+M7HNXxJ9ybrIxcrNqgJ
         +gXg==
X-Gm-Message-State: AFuF++k2TSfkZs6SeIc2jBBgnDk38ETrJwSMSMIZVR4QZrqBWUQ4Snlh
	fo9OkN3HQfLdhoh4LGCX0/yaG11yOfsoy8vMYx6Ask63ZmuT4i46Joyq7twjBn+iP931UzTeBLx
	CEl4fE1dcxceAlhRNY7o62TILiU/hoV4=
X-Gm-Gg: AYBFou0jWBFpAwJ9erY9Acn2PpTfaMRVQXXYE5aMGLuDPvWogkATpwRgmOuj491Vn8f
	QbT9SvjFjdvdtRgHe1rrMXmOtddoIptmtOjLQBCaNX6oxiCi+K20+2L4bByTPv1XF0pR2nQVI7f
	Fvt3qLwG5kYOdRNj+ipps6229OF53FdPPVHOqa0TIJBgwtIEbSIj8R7WjJXmdMqEUOoT5zh/V+2
	JvCdu/eYB+Kfydom2JMRPagWrlkS/1L5PoPCReM4wIKaI0iZSiD6N+OAwYGgYOs0JCOTXM5y3F9
	m4csZUVdENV7v7nsoJTfGGXsdEYbmWiyTuvNqnlrFyRn85JAvi5LllV6hFfNjyxS9TPDkYVdMwq
	0U/m4SP2KLCeF
X-Received: by 2002:a05:600c:1c0d:b0:49f:ce73:7ac with SMTP id
 5b1f17b1804b1-49fe67106d6mr15096175e9.35.1790211858543; Wed, 23 Sep 2026
 18:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923095435.591542-1-kunwu.chan@gmail.com> <7efbc8e2ecbf397fc8e44327d13e9a7021b97212.camel@infradead.org>
 <CAN_Opa-tDcZOEk=Mt5MAqUTkg2as5G79uBkxkUaJif8b5QpXYQ@mail.gmail.com>
 <1cb9c1d40f246ddbe24c9fb930d6dce16aaa25a1.camel@infradead.org>
 <CAN_Opa-xVAzFAJVU3rwCsiBzVpQYqUYWzgpBBP7EaX3K+ASk1g@mail.gmail.com> <19595BD7-98B3-46F0-8B47-DAFF304C5A7A@infradead.org>
In-Reply-To: <19595BD7-98B3-46F0-8B47-DAFF304C5A7A@infradead.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 24 Sep 2026 09:04:07 +0800
X-Gm-Features: AclHuK9lgR6kmKYPwa1ltvDPz79B4tIYoVe6PMK2Mrf54spd1LXi9d__ShA6Me4
Message-ID: <CAN_Opa9r1ZbZjLQ_jHSaFQ=8Q-QPrDNxqOrN=feCNz=3N3kNGw@mail.gmail.com>
Subject: Re: [PATCH 00/17] KVM: Use atomic SRCU for gfn-to-pfn cache,
 reinstate guest mode for x86 nesting
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@google.com, paul@xen.org, paulmck@kernel.org, 
	kunwu.chan@linux.dev, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 12:46=E2=80=AFAM David Woodhouse <dwmw2@infradead.o=
rg> wrote:
>
> On 23 September 2026 18:26:32 CEST, KunWu Chan <kunwu.chan@gmail.com> wro=
te:
> >On Thu, Sep 24, 2026 at 12:07=E2=80=AFAM David Woodhouse <dwmw2@infradea=
d.org> wrote:
> >>
> >> On Wed, 2026-09-23 at 23:58 +0800, KunWu Chan wrote:
> >> >
> >> > You mentioned that the SRCU read side scales a lot better and avoids
> >> > cacheline bouncing. If you happen to have any existing measurements =
of
> >> > the reader side, such as throughput or reader-side latency, I would =
be
> >> > very interested in seeing them. That would be useful for understandi=
ng
> >> > the reader-side benefit you mentioned.
> >> >
> >> > Of course, no need to rerun anything just for this. I was mainly
> >> > wondering whether you already had such data from the existing testin=
g.
> >>
> >> Most of the KVM gfn-to-pfn-cache usage is per-vCPU so doesn't get much
> >> parallelism. The main case is interrupt delivery to Xen guests' event
> >> channels, and I did some benchmarking of parallel interrupt delivery.
> >> I'll see if I still have those results, or tell my friend to go and
> >> repeat some meaningful tests.
> >
> >Thanks David, that would be very helpful.
> >
> >The parallel interrupt delivery case sounds particularly interesting.
> >Please don't go to any trouble if the old results are not available.
> >I really appreciate you checking, and I also appreciate your friend's
> >help with the measurements.
>
> It's no trouble; my friend is remarkably compliant once I've held its met=
hodology to account and probed at its conclusions.
>

Haha, fair enough. Thanks again to both of you for indulging me. :-)
