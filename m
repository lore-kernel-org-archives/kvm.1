Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AB23F074F
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620891; cv=pass; b=UseFNqIkOceSP0sjgoDiVVZ8oVDNkqS7pPRlzBjlOv6CjDP4TOUAj0pYHEwqgb5mGcSzdqAqx3qhFHec2QklbvZP6BYSFP6ZjDSoIt4cf0QB3PGXgh7pYcDkW3cgBykIb/DBsWiJnt6WDX5oBNEJgRnOuEH79SoNJtW4y79GDvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620891; c=relaxed/simple;
	bh=CHV/vlDIAa4X057tgoTsB0HMGNJ/+FJ/rXYJPwQup+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTCRHib7wUjkt1xovS3E3n3OuMOvtxj2SXG887rC5joyFKeRFJ4u27dNFpVhaYCp/HuFSdgnSu+S82khm+hMPLbTBTacMWQjjufO9F9JqB6kGOxj0rkBeVC0Kv30/zGn4zpAlRw9mSwBYn4LZwBQlTUp9zI4TwYnm0jCwKO/TJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mAudPbO1; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mAudPbO1"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64c9ebd1369so2054333d50.1
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 07:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774620889; cv=none;
        d=google.com; s=arc-20240605;
        b=cFWWQQwWxL/ab8lx5/Hx+dVd46H78O10VRYtFyfKOPbq8uuijzoMobVrFNBty66Lbc
         Q9KpOf9VtgIjQztg2ufhlcDzIMrmaSBKRhtXKESan8BK7Jjge2M6FaB+Za3F9a9XGy6v
         71jmyi/UbwB8esAHi4g8H511CqdtDj42OYd6303BNQGve4i7L3VROBGnmkkcDhNU6ONd
         oUs3YHPsNgy+mlfYc5smpYnPTl2B7J9rVN3o3gal8CAPl7hInU1ONXRqauTTLAlOFpiD
         v1a6y2M0+vnSHH4gJfozPktPPElZsIGbPrq4SXBQpwLgxPO4VbSlQiG1UgQFg0Ks0kI4
         UxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C/ml6sj2ij7nuKX/I796QqZSws+/aq+hBHX9oGOjYsU=;
        fh=Q8jXf+vp7FK3Vc/Z3Tqs6lDPsJjNPiKFQa9Px166VWY=;
        b=Pgk1fQrqmmB2p/U3vSQNvfxV9887SDYYRn/Jf1ZQaauzVbK0ibhXcDAS3XtN5YW8/e
         xr9yjsYhs1gTyvRzYyeYx4LTuDqYwOvBxAgpclQYZ0/q9u3nC3cU553FrjNpburVPOot
         HB7sgch0FlZnycdBbkt1F+kEevbr5FMtvHl9mLG7Bqn5bWSRVwllxKd3l6khRB3LrOzW
         iaKbm9cCtG05ogm9F0aMp+ajDREo7e3EGhlEfUA5pObgs7dGLnuFI2XAYjM/tCYlihH1
         7WqI4kjMaqo/9LgmAFvjc748DJ/kY1tMPv/7W3+RmJs39uzQ28ys7nrPawDGt4Sks07X
         okYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774620889; x=1775225689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C/ml6sj2ij7nuKX/I796QqZSws+/aq+hBHX9oGOjYsU=;
        b=mAudPbO1luk2ey+GcvoA6u+zaMStDksNk+CxdC/V4Px1eMU7luEJ9yDQnMmWhYG/or
         Du0tRyhu1yeMwAt0/+eShCbp+wDV73PwTif5WlxgUJ4LgqvpLphkxzAP+RpGRpHkjCaE
         TMld8v62DHzcFk79VwkP8yP0eADmQEmgLkKNEF4WjzKFY43UxZELDizqgaEkzR1h0Z3d
         7ObaM34/mhHPRBAkDdMhKl0nm+oVMTU+xBtLot/QcwKVLts6FJ3D62kNboe5q01bI9ML
         d9veOh0lp+v/lFCRv7OALUd38ue4Hj/bVIAZzsYHSn5QWnpq6l9vQZgHBd5uX0VkoBI6
         UoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620889; x=1775225689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/ml6sj2ij7nuKX/I796QqZSws+/aq+hBHX9oGOjYsU=;
        b=kiP3ADnIP0KCOlO/aNGy7AhuejFV5LxIzxngLVy3xHgYDWWrKHuQV250CTWPM3cu47
         Gon4myBgW3aVbk09l0/scPPBxLAzAexN86XzXZblQ6q2twGei3n3qMfe9yrbD/yMxIql
         pHuYxdwUs7jYh165XkK+XCc4sxnvSSXr0j1JaMAvTQJXKy9uOdHiHMzMHoO7lCitAgUr
         Fwn91JddY1+lmnJr5LWjcL35dVsOMOdL3zHg1ZHWgQDD6CdawXQQb9OIMvV98TQsYzsF
         YJuBCMY1ZzqmrLMn+8vNS39+7yowyiGV9Mwt5r9fD7TSgb2Qcy+FaJJipgWkhK0hmXE0
         pdoA==
X-Forwarded-Encrypted: i=1; AJvYcCWDAskY0hdL2epKMmsx5c4AvZZuMtTa4kNezsVPP4ma/k85rbM7vKsiSGNGg+6yLcVuc0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlLbGxW4tmzvYr8BAjEE/Wu1koMq+WTUX4pugk9QI9anzDpGL5
	kmUKSAYii2IO++QB4ED+OkGm/pefApXyT5eOSWKQjx7Oemufp1QunJ/e4c2TOSzLcrk8AFUwStg
	12xMen5LW7i2mAqvRO+w2p37phGz0FZEXnyfM8xiJ/w==
X-Gm-Gg: ATEYQzxnrzjZW7mnQHemiqhwlMz74yr7wZFT5m4McdsM/osb6LUNdAV+vYoGlaDpqrx
	ouABzR2zR5Am+M6L3oA4W5r8ffqyEcA5e3gAinj7oF7M05DmGAVALX3r7LmrV+p738B62Lh7A2X
	KiyHG/foklGOsG/ETidoulh7AyjM70iKSdwqofpoDGZOd2dLST5mFvRVDh1fJS82vucIg2BXPsJ
	cpnWBQazJiKoBiR3/rFhfdQChdeX3xWvFPIvXr7usMPEdsn+/nchrOo+II39aV3BtV3X+WGPSnb
	u+nd3lwiOShnbCR+P5yGe6rwwrE0J1TYm3mVMEy/VRe6Xww4BtkwHsz/mzpNrE30olc=
X-Received: by 2002:a53:ebcc:0:b0:64d:600d:854d with SMTP id
 956f58d0204a3-64ff7404b19mr1981932d50.53.1774620888568; Fri, 27 Mar 2026
 07:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com> <20260327134401.270186-6-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-6-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:14:35 +0000
X-Gm-Features: AQROBzCi1095s2JAbhDfmDJVMDlI5ALR_3Uc637l3MuB9ZtNrrEgfitkidYRsAk
Message-ID: <CAFEAcA_MDAnHxX4SqdB8hvS3jJTOG3mYFZd912_61KPd0QgcBA@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] hw/arm: Use glib2 instead of strcasecmp/strncasecmp
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
>  (2) we want the comparison on boot names to be a plain ASCII
>      one, not to do weird things with "I" in Turkish locales,
>      so g_ascii_strcasecmp() is better as it's explicit about that
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  hw/arm/xilinx_zynq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index d43f36b718..e3cfeb4c08 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -186,13 +186,13 @@ static void zynq_set_boot_mode(Object *obj, const char *str,
>      ZynqMachineState *m = ZYNQ_MACHINE(obj);
>      uint8_t mode = 0;
>
> -    if (!strncasecmp(str, "qspi", 4)) {
> +    if (!g_ascii_strncasecmp(str, "qspi", 4)) {
>          mode = 1;
> -    } else if (!strncasecmp(str, "sd", 2)) {
> +    } else if (!g_ascii_strncasecmp(str, "sd", 2)) {
>          mode = 5;
> -    } else if (!strncasecmp(str, "nor", 3)) {
> +    } else if (!g_ascii_strncasecmp(str, "nor", 3)) {
>          mode = 2;
> -    } else if (!strncasecmp(str, "jtag", 4)) {
> +    } else if (!g_ascii_strncasecmp(str, "jtag", 4)) {
>          mode = 0;
>      } else {
>          error_setg(errp, "%s boot mode not supported", str);
> --
> 2.52.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(I suspect this code really ought to be doing a strcasecmp,
because why would we want "-machine boot-mode=sdXYZZY" to
act like "-machine boot-mode=sd" ? But that's a separate bug.)

thanks
-- PMM
