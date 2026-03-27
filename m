Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD02ED154
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621023; cv=pass; b=JdMQ+6ANsyPlhAVWxszU7Gu+4DRfzHEaz+iOstdg2+CSEG63/F+GONRaQPzyC3mbTtndhk4MAKmBe+HNGcok94fPXwYGu0MRYPo6z17bSWX1hBsgPrLDnpa0JzN7llBFeqq5XIRAlX0smOtDsNexfxqxZrk/Mf0DtNOGUKZjpj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621023; c=relaxed/simple;
	bh=H05pu1oph6i20zdQPmfFwuNamYsmz88n81AK/YEWkBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLI14p8T4lGEzEFLlnbxrdLnKruGfL1GYPfJseMpNzAx2cTaodKE8e9U43QuShTLuR9hJomqKSHx+6TWiQloD791DGH/dd3qGC63tFB9zKAjFtw2HkrLyJpYzd5oMWyPu4QhIUnt1fIcMCKG1Rm5VB5IwnmC3Ytt4qmFgcCMmoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B0FH5pK/; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0FH5pK/"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64e8c7f5082so2234915d50.0
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 07:17:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621020; cv=none;
        d=google.com; s=arc-20240605;
        b=al+CL3/8ykaPcoe4fLdZRkICs+4162nVrVFlMU6pAxHnYlyxx4B2WtJZWN15Y4YX6/
         GbZEDN5aOJR033D9LCc+HWeRH6RiLL7ciEHvLjeFhnxa0Kb3GyqFEtDrF3Dtu6l4BTGu
         TIT2Qb9HuKBUtdke1CBDhyu9VRYwifsV+2PgC0pbYeaNcjHYTX1mW7r0M2cAyyTtAr2W
         MdPK2KeZBhVrVDgi3anCOg7yN7uk9mRwdFiSRgtIQeQLVf5ZFI+c2mcxJr2fDolGxUdl
         R5BrMhco2YJc0+c2BtH4iaBdQes+IFndPbGVrLz+w6N6ug/lrZWgyS+QYtujcolLdXN9
         7Nyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
        fh=p0FmGObOlIvZ/1qQNaxoepduQUgeozROvuN0BsX7pM4=;
        b=SAZTJqMtbZlquwVgQdBvD5yPOfEqLJI0d/kyQ7z4m3rhoG22W2HvL1MkDR6LuIThda
         7Pvu+lXRq8rdwFvU6xdiEavvIWUHtfXm0KSaiw/mRIvnw6n5/Si5/WEKVS+weOC/V+6v
         vPTQbxghRb4Ievqm2WZF5KDPgV0gr/dsakNQv78CJhakbOU2IsyGbI8IYlEzp7XzoVGg
         2hzm89kcU5IVGYR85RctalQrN9ZfcMFTEZNwfRVaW/9E/WXDPyL1+Y4hOsl00tjxoUqS
         I/uBD/LGMxNOzUMQh1X6zRj6XoLvtnQPmSJVBxWuGN4SFNH+33RqgAwcCHA1R+i76EZ+
         VR0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774621020; x=1775225820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
        b=B0FH5pK/X4Dv5VaVVF5MZyCtJrUXPM5IeaUH2Z4n6+rHQxaFAVR9nFbVW15pBCtGMv
         8gyGorj+ZpjFJqvsdaFwBn1KRbbiz8a7qKtyGBLsplPpJpnqFhHdKfZ2Qfg8b/bxoW5Y
         k5NUygq0xSR0ANecNbEU4ynA8pdXoLtKrLtAGZ+7F0tz57E1FGQBt9Y7RW45cIBvEGCB
         WBny2xi/ujj7Pz9mkKWMHR8ngIVIL8T5bh2joCVFiQdPSef0/F2fKkMBnT3VDPauha8L
         Qdx0uOMWUVPfv6ju5gnh5wVHuOU+XV/9y+dW0V2pD31U32cPIOxAZFkGOZki7d4DDBKP
         8nMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621020; x=1775225820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
        b=pRdG4yIf9Cf2ctgZxcqwNbhqVNnc4xWFCMuUAFR76mms07bvdQ6wP0ie8pgGPQgvvc
         cOOle16hYqjr6rZu++vF7pSI6JsmE6qbsJ1UEwZH6S2e98CwN8EFQxSIH0CmR4jhLSZc
         U/QQTAx95lo+u6a15+Qk0Hm+MqfZz/j8FBpz5AYh4oyVN6iG8ov1aJFQuaxaurYyUruw
         MEU5grjvcYSaom9ZjIGBhI8k3ORGFeHaT+xewUPaJdOIvHxwrzjnRmPZUr+slVxEis1Y
         EbeYOzcPF6eRs7MK0xNKJpV+f5nPmsX5MIWfiWeOcqGEIj9eiDMPxboibw8kVoiTorl9
         O0cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh+rDJIVvIymZJbBLXF5zfl2cdavBWsZuswHFW+/jsV0A7i8d3aNTBRq3mr+nDEASZfzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz//kvNPwtSxFpYs+PaVjaXXNg+P7rPHOittnW9csH8T/XtbOp
	S76w2y/nsxSScK79MHfaf/kQ7BzNJMZZiZe9LylV/PKt8maIpPUB9l9nLuaJkQR6FCWJGVS5OWt
	s+2uEcZoS7rm74gIoyxKggmvGk4f/+60HLEhMDk7V1A==
X-Gm-Gg: ATEYQzzIwnAiX9t8kv20+VN/wL+fKb0KAfbNd07AF9f6fT9pcmOIiyy6sUJg+OxImXW
	ojZS6HfG+I2c3e5dR+HTEByXrHfl3DgBO0J2kq5oKKllOFs7BKZOU9L98VJi0w07/ONldUf6IKM
	3WmsLnpKRIVemuWhWHKHzdxMV6m1n8IMiEuRc42lORsxACE0WT4TC5EsGCesGii04YjiWrDjouu
	DKYJNfrw8RD4LXnIO2nVhrVndPZpokzfydgtpmF+vTh4cejKxDnmwPe2fKSOSt8Oev7YPIS/7NJ
	Z3am+Zy6dU3u948HXbHFyMqMVPpqUH4xXEU6Wx/oZoSie5PyyAZbBnqRSpcM0AMh1iU=
X-Received: by 2002:a53:d044:0:10b0:64f:eef6:d0d8 with SMTP id
 956f58d0204a3-64ff73cb7fbmr2189544d50.50.1774621020394; Fri, 27 Mar 2026
 07:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com> <20260327134401.270186-9-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-9-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:16:48 +0000
X-Gm-Features: AQROBzCx_TpmN_iQdg9I4DMWr0nbkXMk-IwFbnaKbQfcHiWDnsRxVjwQg32y-do
Message-ID: <CAFEAcA8PU+TR3zKCWSD5UbD02Z4rK_cEpKSttKFOeXzrau-b8g@mail.gmail.com>
Subject: Re: [PATCH v2 08/15] target/ppc: Use glib2 instead of strcasecmp/strncasecmp
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
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
