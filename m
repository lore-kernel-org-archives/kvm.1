Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A133603CA
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516021; cv=pass; b=RgDiqqAoNhrLGBqiqSOUjPvWsOMHWVToGBM3wJt7Pnb8ZSOhJs1LkowZ+ixadwTDNYx6abuCcfx376QX/nr6lzj1vOV6tC9GpEIRisOujerryQ20x8uTkH/3FTg45J77tPxcoYZNI8FID0AyeafDe27Ubp+ZlZ8VPvjgzeYV8hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516021; c=relaxed/simple;
	bh=oP5yysdDDPIjgsiPxg3R6ga9RgA7ojwMpmnEubfpxdI=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=KwPyj5uZi3fKNqFJb3fePjviEz4vhK+eSpBWV1aHdQd+bA1PemwaOn2hy6znDtqADy5DaT18MC5oE/0zt183Zmu2UQQWGNW7n3Bl0nPCxXRM7klF9M02DloW9UlWbbl6b+Pfxz1N10XcgUfWhIoo1pmw2bhsrtNxL7DkAQjnGSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxNSjM03; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxNSjM03"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3942e9977a5so6581991fa.1
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 09:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778516018; cv=none;
        d=google.com; s=arc-20240605;
        b=XIj0mYob+CS02FD7mIgo6nRWQlmxWvxB6Hcj2POd0s4fjok/rlNJqypP1XPLPuvtoC
         EKKtPYNqqc98Mqxkc0k/uPwid2tcPKrBWSXvoDh/hIIbrV4TC1HrC0673yZyWSCD/xSr
         fh/UMfMwC5CGuMknuk0vpg/EwadpTEQ5GbIWSEQSU6P0i/BFme82KaJC41nl789bqZhZ
         M+t+BN49XaMypCr73nmJ3WXkkh/h7qdAWVY81kwKhB/VMQrtOaQXzQhqSDaglkVwS08y
         hIME0tU2iu88smJDihcvzSNJvxl9ZA2gz2sxwmqP0BKr+ellTGannMorgRIQhNHgyNoT
         FAwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=oP5yysdDDPIjgsiPxg3R6ga9RgA7ojwMpmnEubfpxdI=;
        fh=UA8alT5bMVObxZ7PGLvFDLcZQsxDVBUQbl7Lgeruuqo=;
        b=Y+wxRw9ur4+aSxuyFk/mvD7jt6Cyn1L3MbXOHv8yMxYLEXqGJGkfE2WGFC3pDmpwqc
         eBv/cWtVCijlj40/EsF4T0TSXVEai/Onjf8us8XePl0HBcMh23luVFxQD0DiI7xQ+GpC
         0GehTWTUlgEmqS86dZbdM+354wMIRJjqs04lzVYdRlRtuHwj/5EDVgDV/Hb9lQjLylfU
         UkCVcgpVDpGIEqOtlTa9sr2RwnHhedYyVh7fi/x8f7KZHF2udhQpYklLdCSLVl/xfjbn
         KR+42c9PJUNdKzQG2vitJInyin7+IhO5Y+3eFjzFlOkN4Q+t5inhbutI0IOgnPTyg5t3
         pK1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778516018; x=1779120818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oP5yysdDDPIjgsiPxg3R6ga9RgA7ojwMpmnEubfpxdI=;
        b=oxNSjM03VPgHjyWNx/OMjz/6hIaxVoAOIqZECMi5t+xI2Ta2fT7iXD5UFxp6EvLd1z
         rnR4NDdikULSfALiCrhQmxKhMegqhcYpglyP55Ewz2tekGdZaZXtcCOeI738Z3RjmamL
         8RUflLzvGDqCTSeNNljY1FPQyyTk2aFeTEH4VdiMACW+O8y/OlQVtNHxPXF9p8l8P1Xq
         3YqCBF2r7Z7XSXxrwBkDWMWcZNDvIeluPs+LhhJ24oJxHGU0m1xk9NkU8qmAmJ4ITkMv
         pXQkHUV0j3HOh5r2Gckh1fju1ShgC1iMQuP/GNphxLoRH/UeoKN2Pm8d68RNUcZJlIxx
         SAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516018; x=1779120818;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oP5yysdDDPIjgsiPxg3R6ga9RgA7ojwMpmnEubfpxdI=;
        b=ZrVdRTPaqnDmvGlB/vxwpL1GfQjUXuiqviuqlBx1A92MloABBgoefIVqXgMsK3vTxk
         atV1E0Eoab2cjUCJ00swpc2Vl2iGEctZdQ17V0/OPp9WI7kkWY7blg9u/Y8Pcm0D9zF4
         1yPBy3RfrKhWj+8w+C/pXOn/91yUz1Vvv+NQRFfBUESGN3oiLyQvbH+snSSDhfC6y9AO
         GzCov/1T/vyEz9qkpjLSGM7Eusa6crVtI0pqZsHbWjroTsHIvbwroGA5pvXhocv5fz45
         Hk/YBLyN96jNAWySDcyKdheyXD519TE8RPgfn1Jckq+r5sbR2ZgxH6iNM8Va2LhAf93/
         /yZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yHJ7RVfoCwkizBM1I8YyXIByZnDuEH2CZnM58qUvbYhqRnhINzTvSGc7063k4/HkgXZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSuKWZba1epjm8tT3uzh38HbNJw8MB7a3HT+MYkmx73v5GdGVT
	d2D1wX4THeWPU/GsbA5PvYvtCyhuiibTv2CRziFUwLXkK0gJhUlENZBYJGkoyA6l2Eg+/9rmrF1
	MlKL9Dtr+rYznI4VlHX/ejJaBHqsdhYQj+Cd4bVdo
X-Gm-Gg: Acq92OEsJfhXlmq6NQ96VotjcVT1i9MU3OMHC/HkS3DzbghWVHg7McbAXCKPu5fFT+Z
	b0NWA+43bgAqG+L53LQfR5J8lE7IhHlBu7OU/9P1AbrLD1FimF1QWwJgY/ay2lYHcJWY1sfOE7G
	qE2IqVsYF1+gtJCw69+ZyRGAcIMTpCnqc2G+NMyNdk1KjsGyN/usPQepRx6ciFRU89E0VLw8oBI
	4EQW3fZ2Qfuj/Lf5zPYw7JVbwR4NykXrFlVIs1aENtcIYkCzYZeCMx/DCU0TcIpUjZTy0KxNUq5
	naAmbOBRSux4Oo/H+5OwkGOYRjLWkHFi2uVm1txjjYcm6/5/HMC6Fuxty6nI4iNyfB/2PODzjAs
	MX2Aw
X-Received: by 2002:a05:6512:686:b0:5a4:d0d:84e9 with SMTP id
 2adb3069b0e04-5a8e0ec4f2cmr52775e87.4.1778516017324; Mon, 11 May 2026
 09:13:37 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 May 2026 09:13:35 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 May 2026 09:13:35 -0700
From: Ackerley Tng <ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 May 2026 09:13:35 -0700
X-Gm-Features: AVHnY4KOmfBGJRuh2muMrz7XUq1AEoAtQrmqBfgNBg1bhfN7BYvKUkZnUAn4pXY
Message-ID: <CAEvNRgHAOQbkPWfdDiELxx54B6A=gdtbyjX30+dCUjvkG4PjDQ@mail.gmail.com>
Subject: [Invitation] bi-weekly guest_memfd upstream call on 2026-05-14
To: linux-coco@lists.linux.dev, linux-mm@kvack.org, kvm@vger.kernel.org
Cc: david@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Our next guest_memfd upstream call is scheduled for Thursday, 2026-05-14
at 8:00 - 9:00am (GMT-07:00) Pacific Time - Vancouver.

We'll be using the following Google meet:
http://meet.google.com/wxp-wtju-jzw

In this meeting, we'll have some quick check-ins about the progress of
guest_memfd direct map removal and related patch series.

Then, Frank would like to talk about pluggable guest_memfd backends!

The meeting notes can be found at [1], where we also link recordings and
collect current guest_memfd upstream proposals. If you want an google
calendar invitation that also covers all future meetings, just write
Ackerley or David a mail.

To put something to discuss onto the agenda, reply to this mail or add
them to the "Topics/questions for next meeting(s)" section in the
meeting notes as a comment.

[1] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?usp=sharing


Ackerley
