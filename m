Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0138AC65
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326397; cv=none; b=Y27M44wRL71lXPKBYC9qlk9qjGE66gIz628mo9iYS6EJkd/IkfGtVDtAziieFLg1zv+9xa4Vy+7c5nCSkFf0QPFVwjrioji8Ez+gdDi49YleJi9JmBWH0NSZA2vi/a6xrNtxXLmDCoNHJjPlrkgsPPCemJRg0qoqh9lSEgo/QhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326397; c=relaxed/simple;
	bh=AdxL2XdONYmbRXYyv/1A1S77fovnRsIOafIkjtja1Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJVZsCqN+/9Is/iUrFGJnrrN/bpNfHxNq/hnpuk0Zwty8h1O0cqoxl4QMo2L3sjcvm5GeUW+znw16nMMKtROAbAq6Leb5Vj9OSKk3e+wGAmtDdKmjykBigSwKm4Xhj+/pw/c/gmNxk+sZssI53N678FGwU5L0pi1lhuOaiGij/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=n5OmXMUO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="n5OmXMUO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso32863535e9.3
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 15:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791326393; x=1791931193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AdxL2XdONYmbRXYyv/1A1S77fovnRsIOafIkjtja1Ys=;
        b=n5OmXMUOpMTFQlR8q3KqD9qIFriQA1h9DTmkOzzYO7hQmcJYog+2Xz/YLh/lMD0U7I
         8JA/WkVRDtvn7j3YrkXhNXdbTuMpFWQEyC9SoP0pmw8jVM0wKZ10YoIqcN5d6WCL0VVA
         Ua4qV/9qTdMGcI9Y0t3MZzQv3sbAe4n+rifzmbMvoPNqdLAbobzkQfeQoBhUPZqBlnJ/
         lFK30J+C99o+NF5rPyGven1uzQWyNd5YNaXWGHPTzmAnVkjYqLLs1lHn7P4+/iN86eHW
         I4NmQenpYW7RRgAc0ywyKXE0dDCtvPGjjoQfJCMefpwPu1BfBDaf6tJMyAnJac3DLQ2+
         utvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791326393; x=1791931193;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdxL2XdONYmbRXYyv/1A1S77fovnRsIOafIkjtja1Ys=;
        b=xSdPReXX/3snJjm2vjLL3sZzj59KRlXpATuTn59KN0VxQkq4j8oLAp+Er+9bFnJeAc
         z1ol39kX637yPs1xBAliaRYQgzKIAUODZxRwXTjXxzhPOK1t0BGUz4OrSGP3mcgdBNK5
         ocya4Di3D5UtbtY+I526mTJY3pOkExwiCNGyCB5yifcX3gWMIWPp88IIk85v4a07UneC
         SR85tBKdfUG/HBincnWq/kDaC/K268FowKFkrOyR3zxYOqQYX3DpcIYmp/GuKOCz6Gz/
         7IBGYja1kkthXgCTMCRftCpqKHz+vSX9c0nT2AD8mXkBm0y02EKcbqSyDur27UuQ3eDm
         P9SA==
X-Forwarded-Encrypted: i=1; AKwUvBz501MI3+gsvOwwzzJK6m7QNiaofzTa8YFugSjfmkPoc8z/KcvW2fSmwM5pEltvW84QvaU=@vger.kernel.org
X-Gm-Message-State: AFuF++nXx13ZxHNAhrYcXAemaY0JeSRpGIkPieo/gXKqFXgwKcRDi02c
	AA8rLX8fxbUWelc/pu6H+iQ7CuXCw6uWdG3AWWM+bhzDVWS5OC+DISuBl04S/9ENei4=
X-Gm-Gg: AYBFou12Jvl/TeljlP/Fvl/udAkDPo3y7gf1iJcvs16vxbXoJ0ESF51pH5ZTZ2d7PNc
	qth873RQq1QM9OfXzKqGbLi80B3BS03l4qGSvXr4qZbfPTPErTWiV5qcf57iJA2Q6tBMxb2yrTM
	A4LCwQPIVvzQzyYybGUbuok9sIIY6DIKUFy8k9zPDyL2GTqZ3BEaHBnHGHvz+YmIM91/jWHR3ts
	Y06H/84grfNv6PjuNLDhN3TtudMhmKYfehuaeEoM++DaX3F3/a6oKJapemieF1h7lI2/rgn6MUY
	e4wWS9c9HAmPkbAXpZJjTa9/iY8VmMao3O8hiZCt1r7UkUKzXRABwhj7PgLzraB/wMblcia6DON
	kjZi5ZO3G3spf+xnEczXHbb4hGcDa06F83JW68tg/caLLLGzr//DyJb8Uoeb2L0Arx6u+myGPnX
	bQzGsXhKCYTb8mfHTAS8T/VFotQHhpMd2PSnk2mKQCQpriioI+lrhL7EPgKTEqyCGUJ/8JLw==
X-Received: by 2002:a05:600c:3b9e:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4a180660fd4mr3921435e9.27.1791326393614;
        Tue, 06 Oct 2026 15:39:53 -0700 (PDT)
Received: from localhost ([213.151.81.74])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a18044c970sm4177245e9.4.2026.10.06.15.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:39:52 -0700 (PDT)
Date: Wed, 7 Oct 2026 00:39:49 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
	Raag Jadav <raag.jadav@intel.com>, "Martin K. Petersen" <mkp@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>, 
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Alexey Gladkov <legion@kernel.org>, Hasan Basbunar <basbunarhasan@gmail.com>, 
	Hugh Dickins <hughd@google.com>, Armin Wolf <W_Armin@gmx.de>, WANG Xuerui <kernel@xen0n.name>, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Sudeep Holla <sudeep.holla@kernel.org>
Subject: Re: [PATCH v1 0/3] <linux/mod_devicetable.h> deprecation continues
Message-ID: <asV4UKTFRPv4gCUx@monoceros>
References: <cover.1789988540.git.u.kleine-koenig@baylibre.com>
 <179121379654.1159753.4410832336442519712.b4-review@b4>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c7j23svchiupmb33"
Content-Disposition: inline
In-Reply-To: <179121379654.1159753.4410832336442519712.b4-review@b4>


--c7j23svchiupmb33
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v1 0/3] <linux/mod_devicetable.h> deprecation continues
MIME-Version: 1.0

Hello Nathan,

On Mon, Oct 05, 2026 at 05:23:16PM +0200, Nathan Chancellor wrote:
> If you would like this in 7.4-rc1, I am not opposed to sticking your v2
> into -next now but I plan to finalize the Kbuild tree for 7.4 around
> October 15, so we'd only get a week or so of build coverage. If that
> feels like too little, we should defer this until after 7.4-rc1 is out.

I'll look into your build regressions and then I'm happy to get it into
next for 7.5-rc1.

Thanks
Uwe

--c7j23svchiupmb33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrFeLMACgkQj4D7WH0S
/k75zQf/Z9M3Qv+MzXCE+/ArZCIjcf7D1SB/7qYHmlMpHOhpIQCpv43i8PqY8WOv
ulcwbwStLe9f4pjnBVM0/Rm9nby9VZo3bK79LWBMwnwkZORonA2EqgQdsoZdfRp+
rAETMDcFUQ9GUGhN7DAcWMA4xZhjUtso0mWGwtF7ExTFgEpE33GWQUBdTInG2TNI
0u2gVDxfb010LE6jzbHBJLoFNE/8LEPyCVyCCWsoCz+xslpavz8+KA5j3Frpl3Iz
ier5fkw0XOws8piZfouheZOaXqDZ/HcdrhFTBW9mXVnvMLiUaiH05aCOv9h33Etu
n9pm75LVifFbz4hIGjjZonFwBzkLug==
=5U0C
-----END PGP SIGNATURE-----

--c7j23svchiupmb33--
