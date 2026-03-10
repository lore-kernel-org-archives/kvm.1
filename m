Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0274A199D8
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154334; cv=pass; b=U15136Z59VWvMRmDoy2mzG8kG2Z+hNwnfVZ/rOZZ9/PPtYafAHiIjS7PokcAoS3JLSTncR0Ted0zobnSnduz1wd1yGh2K5Yt54LtlAPOprLsjmz6Ue5aI2YPRRff1OyjP7YxMpGq7qnx/DLegdgu6GoZJoJst/EMLLI9rvwOveI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154334; c=relaxed/simple;
	bh=mVS3y2X06TvywvV5GczVg28OEycEsoPqAYfUe+jg3v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVXlh4cW9kCFM2WK4lekiyLoDSYYqVen4YIklL5H3E/GmKY+P5MYBTj/ylhjXh5DIo2ZFZyUGg2SctgRkNr3pbNMKfJaaMQDWyeAdWs4+pFHyjSHusdK2k7LN3UBZDW07Rd1Appx3PW1XoXB+FoLR0NJb4iwzlFgGv6l2OLVVUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FIeudo2H; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FIeudo2H"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7986d231b3cso162170017b3.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 07:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773154332; cv=none;
        d=google.com; s=arc-20240605;
        b=D5zzaXz0ikvN7FtlMnJs77R0Kik+DpXgRDOLMJINImN52RAC3TZ9rnMgk4Kc82yGdV
         IXW1Xm5LRmQOonlq2shb7ST1Q2fQfT9+x5l2KMZyS/LI2Mr9znJJ2TnQG1xUX/EYqFTs
         hLvuDjni9pWLkGNUwnf++9Jc5ppe8L2UPlHTg6lJiDuI6voawBkhJRLeLS7pATqoIyip
         WWc5lbTO1BasdzC6U9OlK1ow21/hERdtIz2fcIHznU1GR+AKR4zSacyGpYPM9WyweHmW
         JuAEucH+DWd2ucO4kX/MXW31iso+yC2nTDKfSKMul0FNZaAdP2AnXBQcpcO7LT+b1UW1
         CRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dJp8Hg9WBMV1JSzVZsMnHkOFsyey8WWYIm8zPWJ7FnY=;
        fh=D46vR7iyRCcXXla0jW40zUzCI3b/80SVEhZznS2vfX4=;
        b=OW0ZbccFwSpBupYVw3daxr6yB6rUSMA/IkvCr0jKu5oQ6u4XjY4A/5fK3K7RmmO3DZ
         BjE/Uh2WEo7GfGFxK/rjDgkKcBkBolxLYI//dm8DNX99Tvg+FM4N4Qy2Cey1CibgLEzY
         V6wh7n9isTlsj7wOS42S6xVZG8EgugeK4DRCeYXHkD2JsK8N2WhE88+tu9RyDXyNyoGM
         Blkb1Fn7tEcdLmrT7PhnSRiNtFB20y3vxoUVKV/ZQa1yUz+OXiyhT2T0CdBFA8GiEVwj
         P/Yis7NNVmgrhJcZYILG+Eb2lLX9YwAlyrL5j3kQCls58val/CKz5kZB/xQX3RIkPASA
         v6Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773154332; x=1773759132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dJp8Hg9WBMV1JSzVZsMnHkOFsyey8WWYIm8zPWJ7FnY=;
        b=FIeudo2Hw4QlAfHMO/m9BAQh/254XkepVNid354PMWN/8pEFjRuopC1A+slardiQSx
         +4BhsN/kNSz60G/x2TpLm0ED4J3giUlJYXZtxcaPoMgflgl4uEwPrcL9Ij31fWjeGCWO
         XqQjrUbrkeZ8Y5rmuDAFe9Hb/RnYyNIWxaAOLy8SjeYtXrlAzmxZ5AqaABym5TGlIiYj
         UYfWgulXkxZBj1FYWtHn6sxrmVIWaLDC/o61+O/cs12kSNbPDgJzbr/YSw0Bbc0gWorE
         SWD00C7Gzi+NrBPyhvkyy4spa4Bz2fkNjE6eIz1EvUeGQhuwF/RgdMDlWIj6wZdLK0qr
         1qjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773154332; x=1773759132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJp8Hg9WBMV1JSzVZsMnHkOFsyey8WWYIm8zPWJ7FnY=;
        b=Wb83tyAr4ouI9mnffiPGIeIv8BxxAMY5WB9gxgKhJvLhN0e11WwZzU/yB9k8xomI4k
         n4VA2K0F4USfmOrWI4LdXn5gwM/KOB6B5cfkZvBNoGgEM4lX+sSz3Z8GqwaxIZXOCrHX
         vowQ5AaOyeWk4EHqBDRyQBhvYASbqGtlEy7tT+z8or/+l1g9hzxjMWWXh+7C/hckg6bb
         w+axmv/BvAvJ9NYuqNDAQmQvf2TK2Cs3Ta4dmX8bg/B7aUInGbkePdP8Udtx24CBT7vJ
         bagQ5ZKSNjsDsHYrFBRMRAihoQ087/RAkZ/VaB2y7aswfstGgSSuolghkXnoDkvx62GV
         qXUA==
X-Forwarded-Encrypted: i=1; AJvYcCXxCJ6ar81pTSQt++j61vMSyQitezXMqbPlXU/EUp6ZdUzcFszkroRCH9vxa5l0puijvtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqjQl31q6knEq/OsR6Jka5CwBwk8qhr/bgnc2fbyVa4vwfmYjS
	FlL6LgnuKkd1uQzvJIdm7GDX0d0NzEL2EDxBroBWfINUiELaMKtH4cG9bwCCbwuoGWNFp/Ag9Bs
	U4BCZ3QIGmOY+JlBrPSP0kf0PTfizi4eXit8tVQaMXg==
X-Gm-Gg: ATEYQzzDUVjVEFm33krqV04fCKu2j+yHrHqa4oZB6ivAOYx0wt4CghImjzAtlzc7Vm4
	iSJ0YkQsgPtAswsYyG58zqTmT76r6mgDFRCIPHm7SP6MS91OWcX21/0tkB6IgP9ZE3BC5107MKO
	6y1VUTDXjv8sSKZJnK8F6o467IrrHH3Sk25x2/iWUW0wFulyeVSJqVyWDC/S7l5TDXHF9txwutD
	8JE+4wN+vgsggPiFTh4VAtr2vcTyiNNBt1lA0gOUYw2iKCfTKmVhkw81QTiX6sJKY/A0+LmvwDe
	eorMf7sgXdSHOeoWp92WsQ8dBxLO8y0L6fRYB4CNFHCT4EEMhvwBTaIhogNDgjkDKXo=
X-Received: by 2002:a53:acc6:0:10b0:64a:d3b2:d394 with SMTP id
 956f58d0204a3-64d5a13ebeemr2693589d50.26.1773154331912; Tue, 10 Mar 2026
 07:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310132154.2783257-1-kraxel@redhat.com>
In-Reply-To: <20260310132154.2783257-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 14:52:00 +0000
X-Gm-Features: AaiRm50hzBtQP8mn_uikyElZG_YtsHGwkN8joSgiJHgdOkWuRigr8P-RtoKA4RQ
Message-ID: <CAFEAcA94vNGzmFMdMhu7835uH-N5y3M8wr-YP0zDZnLY8z8nDA@mail.gmail.com>
Subject: Re: [PULL 0/3] Firmware 20260310 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, 
	Pierrick Bouvier <pierrick.bouvier@linaro.org>, Stefano Garzarella <sgarzare@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ani Sinha <anisinha@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Kashyap Chamarthy <kchamart@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 13:22, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit de61484ec39f418e5c0d4603017695f9ffb8fe24:
>
>   Merge tag 'linux-user-for-v11-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-03-09 14:53:42 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/kraxel/qemu.git tags/firmware-20260310-pull-request
>
> for you to fetch changes up to 470ccb470b33bedede0100fdb703228a3f2683a5:
>
>   i386/sev/igvm: do not reset guest policy if IGVM does not set it (2026-03-10 14:20:41 +0100)
>
> ----------------------------------------------------------------
> - firmware.json spec update for svsm.
> - igvm bugfixes.
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM
