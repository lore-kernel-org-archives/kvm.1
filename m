Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60FE3EF658
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620908; cv=pass; b=TCwVVsUrj4bkiNioCvwL7pbLpuc3bxz9TCIgZkwbpYMJxiek7vVCLI2WAJ2TkZh0qqnWLYhN4DoqwnsQDTfmsOvayELYAG6kTO9eiMJj1x+vuV4FvxXNLhXtgyvZDmEzr8aamJAgYXZwLLewk7h0UD4D3Yzhhx6ZGPvySjQe9nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620908; c=relaxed/simple;
	bh=Kk9xvaycFwpqjKyugL8/dLE+Vvf49y3G0sEA8p+BJz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFJzK/YfmZAXq33X0ZC17tcv5AGrV3NlGOVYBJkWu9OJXlveAXHY9mXfNagqKavqYy7tYliDbdlU1BcavYAuf6N0A+/RbS6IPT+j2u8pRYnFPFs5uEE6shICPhjvIMUT+fR6dlpiw+/wC4boIJxNRBhnaw48iWmVsJtBgYVPqqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zr4H+ldh; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zr4H+ldh"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ca423ad53so2142379d50.0
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 07:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774620906; cv=none;
        d=google.com; s=arc-20240605;
        b=cc9G0Gva9KzSK0TXZ6LcuyUhgqvV0VEJL2klABw4jPwKAkNx6j1tfOeCvGvWuiwdc6
         nzAWBL096Qg6jSulARvke+x5hSUw0X2740w6KDcbYVGTbD+xMPEYJj+mYgbnsmsOvVxT
         FV6xy7FmEoustdpOLU/UrERHJGAhGV2m9JezDw8Z+1rzMeW+SHeOZDTnw/2wYOcyperG
         xsWVa0N04c+cp9zjB/sT4SljOAOBSGsl5imN63tW/iqCDuluhXA3IFOuY2hHb4J2uw23
         GXt3YL0KCXvGrYkHkydcdYKxeMk18YQWHDFabuMDqaX0NIbkqHdhzG9tJfe+1PDB4MWh
         FdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MMoCz01d3cmlBMF4Ojv1E+E/bWckDcyAWJZe1tRwo4s=;
        fh=A7WPJs4ighmAniNA15JYiiByJ8fiamBptDj+JaqGWNc=;
        b=jN2UYm8fLbVY2wrbfm8arcL4t0MhV9F+fkFQbdWA+s4DIAn/FYp8A3fdNQHcGQ2feZ
         aFyw5O6BdfxHez20S63dtXf9+24GgpulTgOKNHQ0Lv6mPBTu93cyxqnBUGuqvyk+G5pb
         nmRoLd7N1OtXLPSeL331E2hc6AGSt0chnKGiE3bzvCDNvamWd5yH+vtxb5+ocV1uISEO
         jf/57a7TQeIgGBG3U0Z0g1jIVrmAtDTRnPoDrcp62SVvvJRYLTD3IH9t7XUXTYnz/oy7
         Utx2Tchfyj3JcYCtWxc9EmNu427XtrPENycfg5nv2RQyuz4jlcMleRfJiuCcHUn1sUDh
         POBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774620906; x=1775225706; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MMoCz01d3cmlBMF4Ojv1E+E/bWckDcyAWJZe1tRwo4s=;
        b=Zr4H+ldhDiCQLYSWzCRLXQk8HXsqyw1LX6Z5A5KL6QyBEbW+GrHDxVhM0D1GzB2/5E
         h16TLLRfr7AphHa/YqWQQbFFZcTnhc1F+qX+aLnKx8RUge73UagNURpERQxP71qmhrwW
         XbHTvxm3W/OtNaD6wTdk1ZMP+irBMwcq5R/2I37VjwoE3gFj9aTBSRQZ6FN8BX1soXRn
         YAOBfFE4+u5/co6CBJ3Fk3JF9M57QOxTLuujD1ODFH+cf0OTNgP1xmzixkEKphBfb2/P
         V75oBTIYdfbCRFw3LpRb3wVLhSi5JytzzlZ+acFcHIOQ0/2pROTdskvqWqy6JcvSrdRa
         d1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620906; x=1775225706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMoCz01d3cmlBMF4Ojv1E+E/bWckDcyAWJZe1tRwo4s=;
        b=JB40awj7vH3UR2WWCTD7Li0ZTeac/al2HhrlplJMYtUjUhYuXCKPAJyPJynF8nnfhS
         GZV9dIZt6JLu9k9Y5WD2RJCgFnlTta3JUTTdUuv/rHcQHppLeGX12XlTD/8qkBqL+2Ok
         pbohIZ7Py+j6KxB7E82M3OrN+JIbnd9f/EBaiW5EFLkSEtFIE4Tj6CS/Qz0tjTw7G3ik
         MmREXmuBW8Ez1AgmV4p6x4iUX4jatpYon16oMtaoTlQ5KrPDOMBxZMx2Ych2rjMHcMMo
         ch01WFFvLafBz/eDeTJjWgM3QYVBmWITmVrgGHHyoinRQNdfXzwgS3s+MhzgOsbyFJ24
         dW4w==
X-Forwarded-Encrypted: i=1; AJvYcCV5Ac9wHv0WnZ3y+DSxPcjo+z6nTy/4L2RO7/YK9KVcocH4ROnM622iy8Q9/LESmZ8FNSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypq0xR8vkYMJhDHCa4f91xz3NSYR+82RfWlAM8rQIhPATxElnw
	DQK3wfBHa7+I7YRbD2XBDAKHz1iiDKJfHWYqe5sqqtvFflly32SpG5vCatbXbLeR74enn6tlcB2
	nJh7BPKQN2fFhP6tDkdwLk1nLPiad7i7Xg1RcQdGApw==
X-Gm-Gg: ATEYQzwU+U/46AayveXf8SQ56zWVM9/IpI5J4fXbXb4URg7FU67LSxNPmougtThxy+Z
	FUQvnwlYes5zFAo+74GzpoyHyArnH4vSq465ocGLPviypZL1HQuygN/iOyAT1EF2X/GGVECKcAG
	YwvVvlLu4hls2fN/nmkwDyyEodGm/Wi84SiRgKSdV6k7+38jXvFvvH/W1Q0dFYqNdUi8bZAsEdJ
	OqSL0iqpmHH/G7idG7038/LbIIStFciM7GP7vu8XXJeTk5gLMSYh28cF9NDdtKmkuGHPawXSWIt
	amoHBXlKO/83vhEj3dYUGstvvcwzmDWqKcgFOfggwM79IA1v5wr0mLHEEQGlt42qSG3k/MK7OXw
	GRw==
X-Received: by 2002:a05:690e:169b:b0:64a:d04e:a340 with SMTP id
 956f58d0204a3-64ff71ae9fbmr2663602d50.11.1774620905698; Fri, 27 Mar 2026
 07:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com> <20260327134401.270186-7-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-7-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:14:54 +0000
X-Gm-Features: AQROBzAb9vsQ_kkEVN2eAQD5ljCjhhyX1HQ5iCE0-l3o0akiYD6zlpbtJhMxPgY
Message-ID: <CAFEAcA_EeyGk3TuUAN9doe-rN4gSD1Gvm=N9x16MZ5HvQTZFGA@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] target/sparc: Use glib2 instead of strcasecmp/strncasecmp
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
	qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, 
	Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	=?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 13:45, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
>  (2) we want the comparison on boolean property value to be a plain
>      ASCII one, not to do weird things with "I" in Turkish locales,
>      so g_ascii_strcasecmp() is better as it's explicit about that
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
