Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5F43F1649
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620671; cv=pass; b=t18Hlr0sNp2dVICnd2mWl7vUDCb2rr7rrphmKCDk2jaOCJ+yEz+C2JTiTlE8JIzVzLgIsysNlEgkipVxm3wl0aF+Yf3kbMwIpIBl/B2z1ZkpIhH6XU6Q/TSf+2Oa3QvmjTCg7bhY7SLsS0BTP3yKZwDlSbyrtQryaO6rnWRXfTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620671; c=relaxed/simple;
	bh=yWerNXa55FoGg8UqFfKxYXxndTZQ6MD9X0nThJk+MDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rH6J2s3upfNt0IrljPMnMdDrmsuT4YwCQJUbMH72UiEb1IRfMcr4WP2hn13cvvCyyzapsBeMTKgg3nhVddLRZUBsJB7e/Hg2HRMAf1fdn6E/kc5Y3pBlLYao4ZzEfrX7a7xe5YvQZ/AoVTtrjrtfoatMbV+y8iBmFuECLANoBWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T+ofnxlp; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+ofnxlp"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ae222d978so2200947d50.1
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 07:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774620664; cv=none;
        d=google.com; s=arc-20240605;
        b=UlptiNVjOs+YxgE/+Kw4qhvWQIKCLlpTKwlVS9hYUbUAqBWIHKvqlBjnHxQ+v76dud
         zWd/VwsxwMWqqsy2H1abnNJA1eD8esfyjqT29lB9eMy0Ce5SAlh9ydxs20rkI/XXnVDp
         WZFTu37tH2Ya9y+wFPGlkyLVKCNqpcClpn4oCm2QQf7ndDrh04oDWU8OIh1kPXZEdz0c
         pBZF4ZI0TER5tfF2e6ljPyMxinKv106GVOmoc0ByX0SWcoD8nvZdaclZmhNa97xuy3UH
         SfCPyJ4k0XBGmNedzWHtlhlJ2YlaVPK9KsgrkgkQ5EmOVS4KHzpUhLuKzwY3QCHbpFPy
         WmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yWerNXa55FoGg8UqFfKxYXxndTZQ6MD9X0nThJk+MDU=;
        fh=4O766FMmc6RZW8tjv38pODVYaLVFLylTAf6gctlhZ0I=;
        b=R4FoTcTfCaCAMU1/MQAcqnbdL5grvRj8Yx1rL7EKgIbCJ+UU9ES8pTL8riOwAxruE7
         AMLKc/ChXa8us3uYVaOXjt/qsqnAdEucHHMlI76faE2EhdbMibAbNh+LpuqHoGJFd89x
         ztWYZxozRkV2LHfQ87UI0I23uPG/ll1ZzK0U+WZ1/RTmQbMr2WJvNdCuDUs5AUXU8m9/
         Vefiy+jtS5EtF7YTKMt2rcdJnKaFPEvWHuN9Xrys5OUV1Nudsqb91TYpcDYPexQWs06E
         HyxMxgZaYo8pIj0/GPDiTb+TpLWsW+SMVLjb4VrezzE+gsGboGyQbQNngD0cCmlwgagP
         4s5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774620664; x=1775225464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yWerNXa55FoGg8UqFfKxYXxndTZQ6MD9X0nThJk+MDU=;
        b=T+ofnxlp8oypv2LzpUJMyIbQY4AzUjUD6XzA30uza9YEcC8fygzyUiietlu7VM3uQf
         TlhlMpT1AEw5ZIXc/sGxlR1cQCB6cAoydyX/DUU6SKtKSivlnMt8VsNYu7ys4rp12AsZ
         fIjMrCNGkDbogpiGjwU1YA7Wm5OGaaSWhtApKP24MZ9Ok7oUv38rEnID/TNhRUibqfEK
         NTMQWjwy34QIQC5U5M1curgcQNUkFgyr99p0l9YWHgaHK+AkOwgXe781WZ6wq0mx+UU6
         TsRMrGv8H8WDq0FkHjpU4ot8+JuIBy9sd/8bmrerc0eq/AO+3iG7kIvn6sP2C3GkAHbU
         cJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620664; x=1775225464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWerNXa55FoGg8UqFfKxYXxndTZQ6MD9X0nThJk+MDU=;
        b=QIACjFJGiizL10EjXAA7xqnHbckwQAoUuRswaxr2aXiv+tViIMsU52k5D6wUgQv8FG
         q0GdYSc5S8fiuLobzeOH/o76KliIxqTYw91YQCMRCXdHPXEO3Pazm57NepQKF94cBDqo
         ND6cIqrvOnvEMshgaRnHVzrtGTig/xGX3ny975RyFukITHHDf/laeT0Fg4urW5LOvR2Y
         C5DJ/ADDi3KO5/QkKBF7JgPc9OfYE4shB7hzvyErAqofctrKMqvdUEh4Of4fcw7fcvIl
         MSoQ2o3bt0ZcBJ3JH/DtAB8C1QGv40LT35ifXn8zopFI3BKswH+KJrk7smZM6MhEqA2R
         kRoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGUWvxralNdgcm/kCcawoGCYWkqKFcAaSIgEXIKC1B3iCJ6bnl+Il1ky+2/7MJAgGOUxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymmS/D0MbWQ5HDaHQqXDRcVQNUCct7fSEEFJeMqEX17TjYWt5O
	rYerhAIUvPatYLO4AX6N7NIu337o4kLMRwhSlut6W6pXT0XaT6HS3o7c8XH2UXl330Cu/0iLFy+
	yGwlXKnjBC5Zob7lb8Fp2Np494CMHhdsL5ec3J0x47g==
X-Gm-Gg: ATEYQzwpECO3ibskYghzbZiQbZSDDIOL/woEuOCmAyxEdL83cwy8Oyg5Og5Bi4ny2Vc
	+Ta6uZXO3v4piBhI3nLmB9XTDmlqr9uXCkW+BfkdKGIDpoY1h6vKi/+lFL8pkDo6SqaOBlgSz80
	+vhaZrWixPzjrof0+7Qu2TrwRKo46Pg5ZDc8Ql7hLwme+ieqyTY03pjs7ZwPGLl2rBgyE/bPKGH
	msWU1MSezGkFn/2Ks9wL3Bk/FB0yAnM2RbZRzQ7AgOdIS3+Z1T4MfzbFRoS3t6CjsdUhQbJhQxU
	AORct7pm0D34DXg9buEcu+UChycbCPOh2iBqO9rZT2mqr0mtHxMndB88sfV8Bd2JKDE=
X-Received: by 2002:a53:a50f:0:b0:63f:b9b3:9c3 with SMTP id
 956f58d0204a3-64ff720f08fmr1735404d50.31.1774620663398; Fri, 27 Mar 2026
 07:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com> <20260327134401.270186-2-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-2-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:10:51 +0000
X-Gm-Features: AQROBzCjIUjSFHkDPFtUrdZVMFUY3sr0ofDX50lkRJBlZpHp2XQmoCuXEF0Cnk0
Message-ID: <CAFEAcA8--YTs5rbeQSUZ3N-uGTcWjeOU2wNe8BY63tk_PmRv2Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] meson: Use stddef.h instead of unistd.h
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
> POSIX says stddef.h provides size_t, which is the only thing
> we care about here. unistd.h can be missing in non-POSIX runtimes,
> so include stddef.h instead.
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
