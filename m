Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFFB1FF7C7
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620704; cv=pass; b=RY+8m74Ii3MZsnknvS10KBUNVKIdFVx8xjFLEM9FIjoJm3TqAv/hMyXG8aJva/lau+S+g1TmP9z7gS5C56dysszo3h/hweCe9Jy5eiGZDEe8AxCO3e4WjtSnjS2lrcCCklhen8Ctw0dR+Mbdzx+Rtt4AXdWmnAtNuqEMrVZQGrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620704; c=relaxed/simple;
	bh=/70/vqxDJLNkNgS/hzXnOunvDJEEtg973nnCLvB0yX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZSVGWwUfKXseihqBsCE9x87BMsBdi8iqeGMhM5ZFQSA6LeE/gDI28Om6N5Q6PAp1y5LYtSZG/DXx9l7iFDgZmnOBkr+QY3xTtsTIuYH+p7dQ3nsa/4E/Grj3on4UFe+orOKzANzCu22lRm8wqwXchKfvwanjiflD/5KWfp4QUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ChRaZuMe; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ChRaZuMe"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ea73e7b60so2277484d50.3
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 07:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774620703; cv=none;
        d=google.com; s=arc-20240605;
        b=XaEiaj8VaLhJ5uadsQIpNPlvW2Q0HXx7BSR0pZByA123xgxtBIR3kHKw8+FjYnkHOn
         IZ8O+6oQHNw9TULfwgY9Qtw4pfQMUlmSVMjvzt5K0LXRB1p7PNPl9+WFL96fzZ2KzDMG
         NAbkGGoBf9psHlhTCuYWvapcp8/5JKhHdEr8BCgKLfhMqiXCCqNw6bWZtJufFw3zJ9YD
         eX+PLJKk/sLmRTp81uTw6XfduiLHCNYaIm3oroB7cEIk4Aq3Mqndmo9C3JaAXaQP2TJe
         JSJUBt0oZEGCqUdP0U4gSD2BUJVgnodcUhs+MApNPTflmeHnasynLk4OmbMaw+nejWH2
         5I1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=inifQfQgIY2IYfSgHyyln8KaB3fVOElqWi8O4mM7icU=;
        fh=nzpIhqIzCFBizdEeokEN177r2E47DqoBXz5FrsLSnCg=;
        b=JU5yKmCmNerD6oJV6Qux/wrBrEiQcdM9Y/39X1KccN3FxkmU/L3tC2cHd1qNjPAMdm
         h8BJnCqCr6CWXbera8O+p7Fw12yVBXieomDCQTDypfbkkGjxZQ417M7r974eV0ZSjqU3
         Z7P9YwebejiAFun1ERbyB41xpeyIzjX0gqNm/p5G4qP8oU5Y/or+ioDytFPEunZMudJr
         7cUteE84qIvCTvOwsaSN2YVJ4SpgrrdN/OXVlZObRYc8P7boYdDzmAu4NNQkAM8ZgIMK
         EYrdzUeg955XFqzis7Iv57YjBzr/iRQ96wBbkWsM/j0BCSipzZlVRapfag35+NmJfNwS
         J0gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774620703; x=1775225503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=inifQfQgIY2IYfSgHyyln8KaB3fVOElqWi8O4mM7icU=;
        b=ChRaZuMe861ORLqqdx0gF7SeTxvqb1yIW+hupiME03vde5YxsyNhqz4mulWiX1eE1v
         cJQIizeKp2zrpF5h2seR64PuYu1gP+aZFgXVinVlkvqd5iLkCgGS4bfU+PgDcs+s91R0
         prpUk8CUki1vTE/J72aAYupu6McQ+V6T+2lnU+kRVu1wvZrggEL/RUHE64bDOhL9OuU2
         ppX+BwAVqkWGi3TiznJS6FbdMz9pzY1C3Aj+sUewrIivbCwAjSwp+QvmLsPuDrRoQQsl
         Dg1agmfYuME1ADRLHzkljg+cx8vTGlLCxGbEteHp8SwmKwXdGD8YzrtcnHtaJpaZ24Iz
         y2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620703; x=1775225503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inifQfQgIY2IYfSgHyyln8KaB3fVOElqWi8O4mM7icU=;
        b=qwG3HD2yO1/fvPoox15k5vJhM5qiFZuBDWOrD/B6L83trU/PaAsyk0CjSomZUI9o8r
         zlm4pdwPDWdym3QeKM8uD+6ZQaMJHVF/goHCUbB9QFp27wy/Snd4eWhFNP3iWXbdo2yO
         LXI4gTRYdINK3/JJ35tLEkKQu6+N0qVzsRcw7itxYP2X66YPtU16OTuRCz3YTjsX0FLV
         wyn3il1LJfSdzfYzEw+v1npR4AW7zsq/OqiOrSEndtJSJEIwIM6zuxtcikIFsgYQcHkn
         ll3d0Q7TjHpQfLsRcK0KST3nqo6SDS/rfXU/OxBgW8mINQzjkRXB5dHDzHw3pVQoA+eW
         82/g==
X-Forwarded-Encrypted: i=1; AJvYcCX9DgHtpDxhsYRWmz6Gz2xB6fGf3CdHD/iFlsg4adOwIQt0Ai9EGfgqAPbL0KCWo1pBBfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsoajDNaNl3jQ/wkJCitdhnNlFroBx5Re6OhzDvfLerZs7u8nN
	06Ll4meLBxPQ9frMQduCVsrQM5BRmwajaDobC2a5KKfyn3fj1MU0mchvhb0yWlsxFIWzHiWMvmK
	N2KAbmck8p7ePmlFfbUHynZXM0gRP2+zCG0DlvMQAAf6QrwKPHmwGVTs=
X-Gm-Gg: ATEYQzwaCN99IRqZ2Ez/lUuBYOY+aywPTXIX6O+cQ4xeT6nEpGObWBZj5/ecFSyv8DV
	cO1Cc6aBT8Nq0HVH19O4uyVZ9uOAQuio8BDCOK2panKjq8ICjfb6Ci0Yduirc57/p6NG5cQiqCl
	JsJan5yY7yT+te1jVkfllDnN7186izKxGbNvv5az9LUvgVz2CU4iqFKGK5Eh0sKzhjvU0yw7GGK
	iwHp1XujT/pLlaHSwO6IstPX/RxFzvwkYjGRGYnyn4gWQHqOobtOW/lLt21rDGKVIHBHaj6F5xP
	VWVb3lsrVR2obCXlyDR8aObZ72XC5PXb7mgA4MBLwdjq2cAAoZGhmqTvRk93iC5qKiM=
X-Received: by 2002:a53:e101:0:b0:64e:f106:60f0 with SMTP id
 956f58d0204a3-64ff73cb80amr2139268d50.51.1774620702415; Fri, 27 Mar 2026
 07:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com> <20260327134401.270186-4-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-4-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:11:31 +0000
X-Gm-Features: AQROBzC-GF76seJ-pj6gXNfAn4m1CsFefNOgqbZYHJStea0S2XWUlyeb6quiHgw
Message-ID: <CAFEAcA-41M=AbGfk1Puxz_Tu9_mD2G1H-1h5ConJvcS4KCbOPw@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] block: Use glib2 instead of strcasecmp/strncasecmp
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

On Fri, 27 Mar 2026 at 13:44, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
>  (2) we want the comparison on url prefix and it should be a plain ASCII
>      one, not to do weird things with "I" in Turkish locales,
>      so g_ascii_strcasecmp() is better as it's explicit about that
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
