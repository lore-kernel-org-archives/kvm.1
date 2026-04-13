Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204B339B94F
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776121035; cv=pass; b=Fc/y779r7q6R9rbls24CfI2aekAp/TXuAI9eKbjnaJX2FA9XPm8we0zEkECgcoRuKokUxTDmvjlYCz7gcyLpEVCi1+V07pYCmDSLujN4YV/OtJ4nXmy0Gm4W+ZM9q3rdpnmMwLka18ZieyKdefxzBsRlZbTjnO6J3JoJBSgWeY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776121035; c=relaxed/simple;
	bh=7rmbnZD2rcOue9tOLee0E+dYBO8ewVAcrB9mpgLmax0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7psSrTCloD5qnUc0tFH3tcSOW9Vo/10+2Ec5XYoJfHtQh4qJKmvWwm1xZBrm8rYJXTcnEBcE7s3TWGowPwlAPstVN+hXPYPqj/hDeximeZNobHfv0i8B2MnY/RcFdVLNw+YXZnC6r2FGmc9/9ZhjGb/h1jeioKHOLh2JnAktVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FzIyXyYj; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FzIyXyYj"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50d6b393d60so3757511cf.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 15:57:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776121033; cv=none;
        d=google.com; s=arc-20240605;
        b=NxcEucma2JKZ3WHzxh58uuRpaGO0vvgwsd95CKYF6shtA3dbb6zN+wea/BJgEP8G0p
         rmRPMG9RctUDv2qc7qFax1Tl6bhkT16thBwF34bt+fSH0Ns+HGgEglnezLRGG8iCM3a2
         C+kigE8JlduLPT5kbFjhXbETX4EPPaLbpmVGnxpNZIUuzn0bCjH7b5+M7bhA+4Knytzi
         mE/1ajvzrHX1F1GAO+OmeIXPidCj5U4g1SDtVAVBXxBZZTyDcJhn4UmI8QtefoVdPZnM
         0+SDJ5Q3r8jNpMYrgqxAIYJ88COOVQ+fRZmNv8FbmSbQRzLgYIY3FXmy9NKg8e8+yFXl
         2KmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a/L03SLxXQUQYPNmzF+TYQrgo9uVSJ9+asSNDkpeLNg=;
        fh=CrDrj8aSSLbPIc0MRtjXVdGiZE+CnU1tCW24f6r6Bxk=;
        b=GhVYlZJm2RFu8jv8TWbswjQJsj2WF+GMSEkSvaY6qhJSQLf6ZJKpZtsCluiCW55CyW
         izbeEyUJO8LYNoLtsrJWIaEpzS9OvLHtT2okpFfZh1C47J9k4WwCWB0DK+ThWxnLgQne
         QFhNTm0PvReWNDaxbf6IpL5/mtF482kiQJXVQ/sZu5AW1YWJ1sXlMrtdR7Etc15GWNmk
         pxXKh7ixrRbyX6Siyd0e5BYH1q0E6dKED9cj/tyuYnxpOD3AX5D6tYg0M035Ce2kWwLm
         dKiD5VcqUMmeD0g76yr31bBJNht7Qf2eEJQvThph5qlqLy595EG9c2hj9y+cu/ZAxkdR
         HcIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776121033; x=1776725833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/L03SLxXQUQYPNmzF+TYQrgo9uVSJ9+asSNDkpeLNg=;
        b=FzIyXyYjGlq0qn9BlqTUIEpKQr/PlWsygu3AlfXWOzFj1Zd5q0IMfk3g6ho9ArUtF6
         6n7H9q11nRRpREeFnSaIj2HQXtBM5Jh6HkMQZM/n0eptsE5hK2FE3yGZVOSa8JduwDnW
         0qGPZLqZWCzhKaFq2JPUD+lLqeFoPXG3Ls9l+8KxvepU9PQ9mC9TSlWglSrX3kjPX+CO
         hRyWWXRA9oomue7DpCqBbvKQ3rQ0RDQ70oRO9zaWVeLhR1yW0wc1BvQtQ5AAitgPqfwc
         NxKLzsmi8XxIlifAqoUtWzgiGc7HPdkQXUnqrBJbL5v/kYZbMiwNJWAo+sFMg6ML0HFl
         0MrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776121033; x=1776725833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a/L03SLxXQUQYPNmzF+TYQrgo9uVSJ9+asSNDkpeLNg=;
        b=jDLQtnGJt90VG8NAf2+iNM4WCDXfcUcxMHiJNZtRVbOTh84XXrKiDfchvNNjp26r+c
         n6YzkXAEIIGUMZqCX4Us0qJjOo1BoHVpLFi0WNdj3g15n6b3S2GE8iIrW8KufeRSjawB
         F9je31AL/wnapIKploNF7fiwj1C/Vxx61SJDQHssF/4XpEq6SeT8mPx0T30esTrVLyq0
         dbJgcuTYataTz+e74Mxp9DbJWA89W71S3nzuRAcW/e3kITCIlaMDt8Ex2r2UI0agg/5V
         ajMW0kg+PN/VtatxKpR+JirBq2T+oNg24bcNQQNbiU8KiIydb9cahruKoTSTsAAz6X2m
         vMZg==
X-Forwarded-Encrypted: i=1; AFNElJ+ER3KUpvn+dnYPJVY0vNPCIM+6Frhp5GXvSYL3g/8oLOcayqhbzP25JLG2kBU0L/HFxVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8mxLwmyYK2XXjhBVmn/Fif9hiM7iRzvwuZQQytt6V14QyOTo0
	TqiF4oKcd47zrHWbvpYask+o6WV6OX76eMPA5pxHTu9bo551tPgk5S7Kj76a05a1uaafRlPHW3t
	i4095aUCbPGxtE8pPvH6tiRFtuL7hC/Yr6uiC1m4=
X-Gm-Gg: AeBDieumsNt+zSN/5ARXxbVTzZ9T6c1oZHcOCag9KJ8bgn8Hkq99+S0+wB7/5KQ5xH9
	ECgV3lMtxWl7cLfj7445j920xYvSEEZYVmH8tsuirMC9HzRKVPdzqdxb5GcrUXjiANz93EAApOz
	Dm2r8HbTzm6LcvGlEE6ZcwgmTDNP2M87RiBPY6reXdV2P9asRVueL90JA0lEOmoGnAjGkY5GLTw
	+lE5gm2VqTOpJHYurMBb6KS7KNAQr7g9viawj4NcElPWhw26lEvuZWiLGGtc12a0YAcMme5PGD2
	WNZWPzWrj8ofPq2IQ2MgZCTNRIwtIN7oTqxnHbhXkPpzU0yeAlq4E3cH
X-Received: by 2002:a05:622a:408e:b0:4f3:54eb:f26e with SMTP id
 d75a77b69052e-50dc417b88emr38207111cf.1.1776121032632; Mon, 13 Apr 2026
 15:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409015139.2800185-1-jrhilke@google.com> <20260409015139.2800185-2-jrhilke@google.com>
 <adl8ZlgM9JEtV_Vx@google.com>
In-Reply-To: <adl8ZlgM9JEtV_Vx@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Mon, 13 Apr 2026 15:57:01 -0700
X-Gm-Features: AQROBzCKPheyE3ruKOHfn_XwqU6OIZ5LsZ3kxjzLWqx5PNQPFzNhqcbvw5f6I_s
Message-ID: <CAAdrzjtZDFaXJbSKrJTfhZNg6PLuotxH4LEdJ1Gpuvz-XFw8DA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfio: selftests: Find devices that are compatible
 with VFIO selftests
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 3:40=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
> > +# List of devices which have a VFIO selftest driver
> > +DEVICES=3D(
> > +     "8086:0b25" # Intel Data Streaming Accelerator
>
> Please also add the new DMR and GNR-D DSA devices that were added
> recently:
>
>   https://github.com/awilliam/linux-vfio/commit/c82cfe15916d33e89c2d2efee=
b624e8c9c2c4ca8

Ack. Will do in v3.

> > +function print_supported_devices() {
> > +     local vendor_device_id
> > +     local id
> > +
> > +     for vendor_device_id in "${DEVICES[@]}"; do
> > +             read -r id <<< "${vendor_device_id}"
>
> Sashiko seems to think the read here is unecessary.
>
>   https://sashiko.dev/#/patchset/20260409015139.2800185-1-jrhilke%40googl=
e.com?part=3D1

Ah yea, the read is a vestige of a different iteration I had of this
script. I'll remove it in v3.

> > +             lspci -D -d "${id}" | awk '{ print $1 }'
>
> Let's print the whole line and let the user parse out the BDF with awk.
> That will let the user see which type of device it its rather than just
> raw BDFs.

Will do in v3.

> > +     while getopts "ld:" opt; do
> > +             case ${opt} in
> > +                     l)
> > +                             echo "Supported devices: "
> > +                             print_supported_devices
> > +                             exit 0
> > +                             ;;
>
> nit: Put the echo in print_supported_devices and this can be a one-liner
> like the rest of the options.
>
>         while getopts "ld:" opt; do
>                 case ${opt} in
>                         l) print_supported_devices; exit 0 ;;
>                         d) bdf_list+=3D("${OPTARG}") ;;
>                         *) usage; exit 1 ;;
>                 esac
>         done

Will do in v3.

> > +                     d) bdf_list+=3D("${OPTARG}") ;;
>
> Let's keep the current semantics where the list of BDFs is passed as
> positional arguments. The next commit would just pick a device if there
> are no positional arguments.
>
> This will keep the script backwards compatible with current usage and
> also keep it simple (no need to pass extra -d flag for every BDF):
>
>   ./setup.sh BDF1 BDF2 BDF3
>   vs.
>   ./setup.sh -d BDF1 -d BDF2 -d BDF3

Works for me. Will do in v3.
