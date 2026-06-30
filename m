Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DE32E738C
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799473; cv=none; b=tC1b4oSy4ZR1yLHE5+LcwS/648Uo0qtqCAoYv1JMezUtecXqFO0BoXEal5fYMrVoWODJmqbncEMBn9kpPa9+gPWZH8MyG7IvgIFds6hiO8DFrQ2fodElJW90KAykKZgrmM0OiWKHVmzIPSIaUTHtUUlk/4hso2T8t80shivspSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799473; c=relaxed/simple;
	bh=q9HQDf6uU3KOpf7X+h0FkXT0BRmTsT0Ka85jPZxYGjU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdVv6UHRl6U5ILuZDiO7Tn8I64cgSH6N9oUsy33eIEKBkbcqOVfG7kBo9RKoB0VPo0T9i73TqPcbPev/Z7dR9C9TRSBGqfhae0JPzNBwLqBmi/mUL5S4pJUZNadnkV7YQ+VWzp/c8F70elcy0Jmz+LyqyS56QXje4ypvNmjaWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ktwxb7CX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ktwxb7CX"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493a613571eso18093085e9.3
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 23:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782799469; x=1783404269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5BBnItCnxunKMbKk5r5XGq35MhHqmNERXs298mNYZQ=;
        b=ktwxb7CXt+trnAajnkzA9h9gdeaP+NWWqiQtMnj/0fmN71drYBEJJVqA/zdDPOHA+j
         tx53cU1g/94nmCKnfAZI3uM4N20ZfXbOrGesn2v8kLV408YjA0rqDDhX/rgJwy6yAMAx
         RHuc5qOE1EEd+PNOB/7AVM6ZKg1kPXmDutlUdICaEZh79ksn91a3posF345m56bEi96d
         N3fxZ84jT3pXm8b8Vnk4HkRUvEcpZIrhYwKHSeZAEHqu8PzndfN05M6wyGGRylM8ZzM2
         GlE2jFRlS3Dsmd36Hh6dzBH61f9OpFXTs900Z0kPYXTJM4l+T3BlB2wf6TAGsYHsX3mL
         IlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782799469; x=1783404269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b5BBnItCnxunKMbKk5r5XGq35MhHqmNERXs298mNYZQ=;
        b=OVmhKMUfoIXN6CVESvSEmROz/1hQKIRwmSse9jOeLNgA4ArugVKAlui1/nhcgE7Vux
         7OYZ9mhx+VgXPK0k9H16ftb8oCjhhWOXHsFD2H9QCsKL/zn54pc1W9LlEi0xVwlgSohG
         X5Ift/ETUSMd3c2u4vUH7kZyVBt2DXR52c/e6qQIrPcBhCBUZAKnDSqDoPLe6q76H+4O
         GnCoBBkqOS6cdHHnfykAa8++ZYeg8GFsRaM9DaMk/Dwxp9MXI35xnonEwbDtLjLcogzz
         DwQy9xONiu80TNMwYRnMxyKprRDV9nURS/r3eER6XNmv3Erm/3pQn02ruqJEWsK6f6F1
         T82Q==
X-Forwarded-Encrypted: i=1; AFNElJ+WuwproTr3QXU2MMdYcbXGOqvyor9yqWE9fu8Q6sD0kVlidh11LnA59Nno31E0Kx+Xe8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YziBTRulAOWhX9JUvR37bD5HwgEJOv5HgAyc8tGv4kykS8xXFuu
	HQDU3NY3A9tKWJPyVfwxQY9WdfSNN8H0jgY2AQl/nXSVdSU/cKu1oUoBLjuC+CTkzKo=
X-Gm-Gg: AfdE7clPrIhIEyLCW5nKDg1p06VOrvULvXP7R7Fk9YgFgusm+SBwEHEC0hQIdcu3nH0
	9cyTDmq44Vf9PlHqSQQuo3c+lyVga2mYFS8xGji8TIZ6PswF0S3t7qJKYechBQNfcsbKERAqSza
	xmF2kO+DlHRoqbtMt2HubSfRamnCUiTB4Q58wFmPv0czokAERwz4+LiOrwz7Y3nGLmb+c7nH5me
	dJdOXMV3NDVU7zIdWSiqoo73ZM71RFjm2IsvTJ89kYY+IhpWAaGpy/a6sGOrciv8ozEAGaWJ7gD
	cosutcLi+MM+hM1uXGwcNf5lS06P+BNPnGWnIyvfYfIBqVeSr3ZxFZ7xWp9+GMpbKy9XXR5yGL5
	FBZmku6XGsDyI3M503jI5rWNdyudXndLRg8mdPgxW7arK1yKUSkz9wXghsR4fbcsScOI8nGtKzl
	aI6nEoFZqwAjMKKcu9ug==
X-Received: by 2002:a05:600c:8285:b0:493:bacb:1341 with SMTP id 5b1f17b1804b1-493bacb176dmr13964925e9.4.1782799468463;
        Mon, 29 Jun 2026 23:04:28 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493b8cd3018sm45429405e9.5.2026.06.29.23.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:04:27 -0700 (PDT)
Date: Tue, 30 Jun 2026 08:04:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mark Brown <broonie@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Raag Jadav <raag.jadav@intel.com>, 
	Sohil Mehta <sohil.mehta@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org, 
	Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Pei Xiao <xiaopei01@kylinos.cn>, 
	Shashank Balaji <shashank.mahadasyam@sony.com>, Ben Horgan <ben.horgan@arm.com>, Johan Hovold <johan@kernel.org>, 
	linux-usb@vger.kernel.org, Nikita Kravets <teackot@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, 
	Daniel Scally <dan.scally@ideasonboard.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev
Subject: Re: [PATCH v3 00/16] mod_devicetable.h: Split into per subsystem
 headers
Message-ID: <akNYUdAS3sbEdRqC@monoceros>
References: <cover.1782682124.git.ukleinek@kernel.org>
 <20260629235804.GA414914@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bjsp2vxvxtx3lqot"
Content-Disposition: inline
In-Reply-To: <20260629235804.GA414914@sakamocchi.jp>


--bjsp2vxvxtx3lqot
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/16] mod_devicetable.h: Split into per subsystem
 headers
MIME-Version: 1.0

Hello Takashi,

On Tue, Jun 30, 2026 at 08:58:04AM +0900, Takashi Sakamoto wrote:
> On Sun, Jun 28, 2026 at 11:58:35PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> >  ...
> >  drivers/firewire/core-device.c                |    1 -
> >  drivers/firewire/net.c                        |    1 -
> >  drivers/firewire/sbp2.c                       |    1 -
> >  ...
> >  drivers/media/firewire/firedtv-fw.c           |    1 -
> >  ...
> >  include/linux/firewire.h                      |    3 +-
> >  ...
> >  sound/firewire/isight.c                       |    1 -
> >  ...
> >  1649 files changed, 1575 insertions(+), 2544 deletions(-)
> >  ...
> >  create mode 100644 include/linux/device-id/ieee1394.h
>=20
> I have no objection to the above changes relevant to firewire subsystem.
>=20
> Acked-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Thanks! Added to my tree.

> Consequently, unit drivers just include include/linux/firewire.h to refer=
=20
> to 'struct ieee1394_device_id'. After merging the changes, I'll post more
> patches to modify the following unit drivers, since they are left from the
> patchset.
>=20
> * drivers/media/firewire/firedtv.h
> * sound/firewire/bebob/bebob.h
> * sound/firewire/dice/dice.h
> * sound/firewire/digi00x/digi00x.h
> * sound/firewire/fireface/ff.h
> * sound/firewire/fireworks/fireworks.h
> * sound/firewire/motu/motu.h
> * sound/firewire/oxfw/oxfw.h
> * sound/firewire/tascam/tascam.h
>=20
> By the way, the changes touch so many files. If it takes more time to
> apply, I think it better to make steps to modify across several kernel
> generation.

Touching so many files is the motivation to do all the high-impact
changes in a single go. As of v7.2-rc1 <linux/mod_devicetable.h> is
included (transitively) in ~18000 of 21500 .o files below drivers/ for a
x86_64 allmodconfig[1]. So touching that file requires a near complete
rebuild. If we spread the changes over several trees/kernel releases the
need to recompile the whole tree repeats more often than necessary. Note
this bites not only during the merge window when building the
development tree, but also during bisection.

> For example, getting rid of direct reference of
> mod_devicetable.h from drivers at first (in the case of firewire
> subsystem, for 'Replace <linux/mod_devicetable.h> by more specific
> <linux/device-id/*.h> (headers))', then adding these per-subsystem
> headers and applying relevant changes.

The impact of these firewire changes is limited to the firewire
subsystem. So doing these later is a smaller issue. I plan to tackle
these when this series is in. (But if you want to care about the
firewire bits, that's fine, too.)
=20
> Of course, I don't mind to apply the v3 patchset as is in upstream.

There are a few changes that I collected (Added SPDX markers, a few less
#includes added as my script evolved, a new patch to fix a hppa
fallout), so I will send a v4 later today.

Best regards
Uwe

[1] I did in my build tree (with the series applied)

	$ find drivers -name \*.o.cmd -not -name \*.mod.o.cmd | xargs grep -l /dev=
ice-id/ | wc -l
	19221
	$ find drivers -name \*.o.cmd -not -name \*.mod.o.cmd | wc -l
	21597

That's a bit wrong as my series changes the numbers, but the ballpark
should be right. In
https://lore.kernel.org/all/20260622210733.1743063-2-u.kleine-koenig@baylib=
re.com/
I found similar numbers for 7.1 (17038/21330).

--bjsp2vxvxtx3lqot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpDXGcACgkQj4D7WH0S
/k6p0wf8C/fqLWElPKeEJ6VYZOMbHAVQFFSaiocKgLhyatujJO/xABylQtIrG2bm
oNQHPUayrcWacObHGF3fEjQy4hRJLu10iu9WrGW/FvZUPjhCWUzPdhuXpmSnE4fH
zd/NVmkNUTbomy4rUfxcWTKfXtWxqi+pwwPvcbEeQBUCqK/R3MK9MTJPeo+fuS0w
N7J2Vv4yLihgZU1OW8Y9uT+TbrHb5Kn77XyKCF3bvRyrDK82GHBAEy0UIojDpJnT
sIhHykaiFL1/5jUZb/iCqMx0+2OUeNz8HOywoSete10zzE2qFPFgI683oSrO6gcY
cBQF6NX+zboS6GmYI42xlkzJTj7ODw==
=GSrp
-----END PGP SIGNATURE-----

--bjsp2vxvxtx3lqot--
