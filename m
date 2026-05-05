Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047EA48A2DD
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996656; cv=pass; b=SgEAafzJY67MTxryjd317x2nQTfimMSSehBJP9fbVyjHEi2D/4UaqmlmEk51p+yy62h1jfvgoWP9zUvs0p2ZnSxAuNqaulsF/037+FpmYgtqZGxTG1wAMiuMEOzHqMEeP8f6AxK4ufUfChwqtOaUPfljQzGDvVLjjrwga+ohGq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996656; c=relaxed/simple;
	bh=LDNzA0ktaQOd9EO9z8tWH2U9AqQnquf4cSGKsb1TqKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msGpOHdHhH1o7RE9a+Cb4Ez0z5hPD9AD0OMs6/lcf6PKCy/dnPQVmSOFOtmtasKNn6VWQgZPIJTn4ssL2tmWGUDNQ5708BKONekJ+cjkyg9Y7LnA8gLTYJo7jufQCQccR3I7DIsKjHzcexjqW/QnE99AV/dta7XVP90FZtf38ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRLB5fuK; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRLB5fuK"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1305908ae11so2597397c88.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 08:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777996654; cv=none;
        d=google.com; s=arc-20240605;
        b=SJkvyQ8C5S71zuFilW/2fsThjZFQPXPIhEgk+CgzAf2tBCWK3a8/o5+dzpL8BAcsgn
         H9ntvBggQqn4W7BYjGv9fHEdNuM7V4HcDA/VerGYUJige+E79IulhRqVu3jFvpv3rgrZ
         KYQ3W9sOYeSSqApbyElLN3chMimTOb0rRrzSePGjW8/iRAGyYlS7aVcBm0v3HF9PVzA1
         8lkixC13J5Ny+qhdxNomKeg/CMhAQOxEUIyTLpgK82AtpsZPKDSsNCGvK3Ye2S2WYLNr
         jKe4ForWMwq20Fj15srjFsYoqOVuKWzr1OX7Gdofi3oFRteb/0e7I6B8u3OExDHrlVA1
         bmQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LDNzA0ktaQOd9EO9z8tWH2U9AqQnquf4cSGKsb1TqKY=;
        fh=Cb/8jFab3OW1nqdbzQ89Fjf87TTJqzGMZE+SazPc2QU=;
        b=jwNgfSVRexvEvI6ceW200i6JtutGvTJwJZk7okk4oUfxaObeV/6vzrC05P6wvZaMSd
         M+c415qECTUBY9b6DreIKpgkOkwW2b1dgsb4YcZ3c1BNQGAy5oPEDRNj7480PW6kCphq
         o8kscQ1etBfBPFuLTTVr96f3nHMBIcrwTydhToBU0o2U8PQJm3IouhyFWy41A9bwgIty
         grnZDoWgiPiyw8d0BT2D5VazSjsYirGd2VJhQNkoZEHtRtVao597zclDRMiqQH4plr1z
         qfcCw1QFJjCek0AHt1QIhTwFzs6gqa1ZKJpP1ztDetccncJHwiOdDu8A9dCMnVrv/Kti
         u7XA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777996654; x=1778601454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDNzA0ktaQOd9EO9z8tWH2U9AqQnquf4cSGKsb1TqKY=;
        b=SRLB5fuK+rlRbRhR19pBwry7cLZbvtRVEXUjGHjYwtc7Am201qdkI/9ScVbPpVQdvn
         o2+lMM+mNjjwpz3ySgVFsMjc05G/Bf52ulrCsBdX7D1k+oOdBGuX+Blizi0Db0U0DQZl
         gTtzzuxGExcSNZrIP+LJ2Fy65AuAcfV4gP3yHMpJbf3+WcmoeJqfp/YykIkfmeW/Wmog
         axaqM/d0gMoaPtVMeQtHkwwIP31E8UzAem7dL8aR/VWks1SJMK1r5/UMEOZGfd7wFjgH
         sQRJNkzol8SOmXs5P68i43fKcXV8qkp6/l/nsK5WGFQAENusU/Bf/XPf15vZX5LuAXTU
         yTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777996654; x=1778601454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LDNzA0ktaQOd9EO9z8tWH2U9AqQnquf4cSGKsb1TqKY=;
        b=AnxVUhuD7PIaoa0BqXlbKAQruvPh0qea5q1x1KKpDuLaMdsokzgS4wp/zPyOJ1mQyb
         WB8oupTkdXhsRBO1TyhCLypArIla7bIOeVo+YBMRqQGBSCn3usL7fG7eauzYh5haxS2f
         uXl/Wmk8e11qORQuSjk/Q58lwKc+8SXpB3InbOMYgsHqCSy7P/vmSo0ogr+umIXXzPe1
         RsilYlc1Le6PHQ9Izh9eDuawvZokSeLrTswC/2x70jSzdP+stJx56Rhq7dtUVSkUc1r5
         hhZ2DamfvZp4bl4XT0RTJjBApkQvxILh8L3tyGySKuUMETMbBcWwMRagTmMoW9Uam2V3
         alOw==
X-Forwarded-Encrypted: i=1; AFNElJ8gNUbe2pz5r6jO2y/wv6N8sOmH7YO9qGWZ/lPf4W1x0gQnBjdEG0SOW7NL3Nxh2l3e7qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkN6fgEDOkhA+gYhH7ldR2X3XYEKqmja6Si4KPKnVUq9fzB9X1
	9suwcZ7YMj5BdEhXc+vQzvEzhvQEFTzN85trKDlALDaVCxozlMgUDATkMk/O+B0kH66wTMbv/cY
	GHsuPKOiuUoY9O0+M6tnyr1PTKTBsGxwtd971a1iGRL16tcyT3h+CqZBw
X-Gm-Gg: AeBDietdZgZ6W8snwSfj4aRDryBgkpiQ/jI/FxF0iBU2QRIrTP+OZzBGrko+K+hhRww
	qbl5daBIrD73M52+rm6MePMOrJp6M+WUSnu/SP/27OWgZOziRxXMSwNJEYJ6KHMhgtm592iP5p5
	asLJh5uaJ0iJGXiBqtF08UFVrcx1WhLAjE5wkNaMeDphTPvuQeg3GHmDMhdfMnCRooCRr/zysno
	OzkGqG08Tj2eNkGlEctBUHFVCsIPF6D52DIjyujihawKQUBWXgWRhchsDwv3DP2jH9CgxgHuBwP
	dRJIM1HslikX6TIljZ0nLEFXq/1SRA==
X-Received: by 2002:a05:7022:b8c:b0:128:d34a:320f with SMTP id
 a92af1059eb24-130b173badamr2261604c88.12.1777996653500; Tue, 05 May 2026
 08:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com> <CALzav=ci8bi3=sY+F3HJTB5sOQ_pJ8Lm+kz0CDBBWVXry5P98w@mail.gmail.com>
 <20260501164314.GA1381708@nvidia.com> <afkjkBq8B-4KjhS_@google.com> <afoR1izCEe9y0MZA@nvidia.com>
In-Reply-To: <afoR1izCEe9y0MZA@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 5 May 2026 08:57:06 -0700
X-Gm-Features: AVHnY4JrW8dKYzLI7vKq9aNciL3ihCmWQQqvYeVf-qNxqF1RpyWt82ID73cuiLw
Message-ID: <CALzav=d7a-55mg01MEfaonsU-+4QxbRE3QXpZLskteF28tdaUg@mail.gmail.com>
Subject: Re: [PATCH 00/11] mlx5 support for VFIO self test
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	patches@lists.linux.dev, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 8:50=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Mon, May 04, 2026 at 10:54:08PM +0000, David Matlack wrote:
> > > The PF support flow requires a bunch more complicated stuff.
> >
> > Do you think it's worth supporting PFs? If anyone with a CX NIC can
> > enable SR-IOV and run selftests on a VF then we can keep the driver
> > somewhat simpler.
>
> It turns out my test system cannot enable SR-IOV due to iommu_group
> problems so I rather prefer to have this :) I had to hack a kernel up
> to do the initial testing and it was very annoying.

Ok sounds good.
