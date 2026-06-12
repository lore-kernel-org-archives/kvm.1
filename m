Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444174A23
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781286421; cv=pass; b=L2lnWaz9h0dnLBfgyX4pKAZaZIr9PLrplrhkJ2LqKY+q8aZ7B7rY6/0S86or45qavwzn7NTCuxkhluf840fbdMxKD27wx0XW5PKeF4M2vD7PrDQdGPlxe923m1t0mWLelHA1agt313WjpBiC/CyqLRe0IcqOFY62QfjAVnchO8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781286421; c=relaxed/simple;
	bh=fsHGbwjALiuvCbWQUmZberXehkB0Q3yDl/1Grws8cbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbAP0FYeVL1FTfQCbyylrzAtxp4VbiS62+LUM9wbSgz6DW5jjHsRey+Jhmfy0WAkG6pbYCB11AV4R4zB4QfWuPkAfFW79WL4V6jR1bB8RXYI1IQUIJwN3bkFarQ9Tj0EA3J7mUma/P0Ov5rYTMTIfn7QUOybfn/55KwEt4whM0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G1nACceN; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G1nACceN"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6604176b575so1167599d50.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 10:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781286419; cv=none;
        d=google.com; s=arc-20240605;
        b=SN+128ObhO4Y3fCSN8AZRobadx1Ndi1qagtyh4UDAhiRXZNx7iP4T8RjZBTn2s3Z/a
         y2LD58jUrH2zDRD9bU5IG7/eaIFj6qgwkrPdbdiFc50MdVfU0GX+RmvM9aoikc7c+CmU
         HbGV1kVPp41bLu/InSTgxhEq+zr8Om11+ZpdU7zIE+rPZ3/A/5HLoH+loRk0pVQXMkZq
         CmwjF4JdCjVMkpvsYiGmgaFs/jkop/q0bW80xyZlP7y1MR7gMaxfKp45NoeDOsgzCwu+
         bDigGfh8qqpOGkwDC1DX7oSkSuix2ISW5AGlMPiB1NuLQDp1fBQW3xsjhKEduyWPBD4b
         brlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6NYLGsou+SrQn1Uo3K1b+FXzLLeRzUniiiOLWmx22qQ=;
        fh=PmbotF4VRaq16kp6atVKBUJIZWa3PO0SnWn4IKaRnac=;
        b=e8QjuhafSnZS7sWDffyiD7o/syYLniCS6kGbED93amvUsnuNFch9c0saAb/Bbqskgs
         9zWWryuk6sEVGhSxfG9eRb5VvV6uFDdtJtUVpY4rgJ4X7N3G+VW5eBt3a98PxsEc705B
         WaswrG8FkZvtgs9B+0gBY+p3P24Xx/I3miHiI6Gk3MQ0Vl5UGm5thEozsHtvRqGH39dm
         Jibc2mkWaKRBx1OgHGuv6QDRTcrQtuMmJqDKjJrlMEUIFsDmW0PZhyCCKNoJn9nUAexi
         oCtXPZDSz4ND97bOPFUGLf036R4WxAf7CNJJ6Y9/xWWBOqHOHqVq45nT19t1FARtD2Zx
         76Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781286419; x=1781891219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NYLGsou+SrQn1Uo3K1b+FXzLLeRzUniiiOLWmx22qQ=;
        b=G1nACceNobztcdZTOeb/RRhAzI6ZNJfL7WAcbkKe7v5X3Gm0aEGNhNhNu2ro7AxUjY
         dgsAAd7byguDJJshV2fMpBx+EvGetqOHNpO95zvHJNh4cVH6Mx12WGHKbyMe9034qQcO
         oasv9o0bXedJEFXtyVe8vGd1volo53g+eOOK05F6qOTaP5p6INpQXE2yeq7bhyzMTqC5
         il8vfCyR5FW8tC3XTwFdPrCJYgMFKpLTNfGqjYm0x5n4Fb5d4NwakbFvjsRMW8iiZJp8
         DwcXU2q8uA8K7JRpFLsNSq+IHII+aXbfwM7f9Baxm7G3hOwdNkM6I4ZyScyFFPyfDcHZ
         f7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781286419; x=1781891219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6NYLGsou+SrQn1Uo3K1b+FXzLLeRzUniiiOLWmx22qQ=;
        b=qzwlFG67NsYnBnINkRHcg0/Ui6kzEFzMjZxG3RnXMwbQowns97X2Fa06MxzVpsxBjw
         NBCSxiHrEqnEQeNOdAkJA7fow3BXVuoV3/RtpQFlinuc2GVLzfwBcUPBLZ807qDUQHsP
         r+wnxhSidjchfsXG0quemuBU2T2ys56Zzas02iFftmeNxjPIiQTKbcPEfKaA22ktBEUM
         5UU2fse1piSIFK51WZ5cl7hNwjEsUkGn40HmxKU33Pfylc0xkVRsPd9JxmCUh9xtliXi
         zTHxlEe6Zd550WtUuRDw+U7tQHbTVpvFjalshR/T8p3Okc3j6tnpR3HoioZq84iXdAby
         bJAw==
X-Forwarded-Encrypted: i=1; AFNElJ+Cq26sMHBizveVNqD8hF1MkUNyTbwPRx+YA1Shn8cHa4tnOPPUafn+CLX+8xgA6avi6jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZKKRAItPZpjx02Zc/m9tnrZcTV1kbYRj+/MOzGpEtEdvORil3
	6XA4UDXyJPlKOqAurxphsVlVfKgz4DgA1TUKU0JT6G9ZPcHHOJw+klytA0NIfhbwWAZqWS0mW/I
	aUfZ9zsqA0C8ZCvvFsWJVzbyXb3uXcmgQsz+shX9HcpTSRqqoZFhp
X-Gm-Gg: Acq92OECTNRsGEM6SvqrMQSDjlOyofL/wKSoA2qLMp+/lmsIDfhmNmPWdKRECVCsT1d
	vfFEmdzE/eJAhfz8VHwN17asKomuNzMSqknELfjU1TZgsf/BYukyTZS7eLtM9goCa5Zwx1S0fAY
	Yx6HqQLzO/LRbA59KXjDNgB78nhk6cLeUpQe+dIWU/8A8qKZTH4VTTPH3myfjclOZfOlomjTcZD
	UKtk5DopTC97N2oyr3g5xNQymLNxyAjSkROSOoLGNLe3XyMPbfhDKjEO5/ffb2tm8ourx2oIp7D
	vVNflNW/wZiKdsPHSq4EOcaw1eMGPxXVxx5AFFI3jKXCO/RUhss+UKmOHepurUi0ZWE=
X-Received: by 2002:a05:690e:b82:b0:660:1a82:223b with SMTP id
 956f58d0204a3-662780081f5mr3382004d50.29.1781286419274; Fri, 12 Jun 2026
 10:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529082948.363931-1-alex.bennee@linaro.org>
 <CAFEAcA94+mh_pigFDi+tEPRJ416fSWfxsQ1Lj8Byemug9kBp6w@mail.gmail.com> <87h5n7ekxw.fsf@draig.linaro.org>
In-Reply-To: <87h5n7ekxw.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jun 2026 18:46:48 +0100
X-Gm-Features: AVVi8Cfx4_sZkUhwcX_oNU5Emb8YeLHTOGRvGVAOZ3vEMDeOVNiiOkvDqj4FcZg
Message-ID: <CAFEAcA8yNGiKeMpN_wgWtc5EnfjsnxSvG6an4-UjBf6XG+4Yvw@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] target/arm: fully model WFxT instructions for A-profile
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <agraf@csgraf.de>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
	Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jun 2026 at 18:18, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >>
> >> This series fully models the behaviour of WFxT instructions. We
> >> already had support for WFE for M-profile but we left off A-profile as
> >> it has more potential sources of wake-ups. The main one is the event
> >> stream which includes events from significant bits of the timer
> >> ticking over.
> >>
> >> The refactoring from the previous iterations of the patch have now
> >> been merged.
> >>
> >> I've dropped trying to fully model the global monitor in favour of
> >> taking advantage of the architectural flexibility to have an IMPDEF
> >> event wake up for any reason. We treat the setting of exclusive_addr
> >> as such a reason because it indicates the current vCPU is in a ldstx
> >> exclusive region and we don't want the guest to deadlock. This does me=
an
> >> the system won't sleep on WFE enabled locks but people shouldn't be
> >> relying on QEMU to model real world sleep patterns anyway given the
> >> efficiency of emulation compared to real HW.
> >>
> >> I've written a test case using kvm-unit-tests:
> >>
> >>   Message-ID: <20260527111822.1563679-1-alex.bennee@linaro.org>
> >>   Date: Wed, 27 May 2026 12:18:21 +0100
> >>   Subject: [kvm-unit-tests PATCH v2] arm: add wfx test case
> >>   From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.o=
rg>
> >>
> >> All patches are now reviewed.
> >
> >
> >
> > Applied to target-arm.next, thanks.
>
> Is it too late to drop them? I've a fix for 2/8:

That change is already in upstream git, so you'll need to
send the fix as a standalone patch, I'm afraid.

-- PMM
