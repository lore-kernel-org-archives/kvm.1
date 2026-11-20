Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183842;
	b=AH/Md+U+DTn63uO29KdOM8SkeOOh+tYbxFNFZBCeXW3PzFAoSbxF8DhylgbYi3oxyh3r
	 05ILDBFM0FbPtkqFHlJEROPkvBAUlpZlaQLqVTd+4bP0OQNKljjEEnQHs0NGFh9/bT84h
	 s53+XYK76zXOMv9xk1IY6iFYPpTNRRbggTEHCZERIw1HBsxdA8wL/OIwIZRLnNfw1AI3L
	 xvSAlZV01uGrGo4u9z+twFh08K4gkTLta1fSz6gIZ5FifFjQuDNwRpcA7WdoyEaAPPJaU
	 Kbzbx+hmAR1/g/XK++ZPYx8pH6iWQwk07o42qwoiHQel6LzSElNRRDRiElSoODT0DpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5S4P9EVhrzfLBPEUlAs5RhZwbxTfoymelcBjiUJ2aGo=;
	b=EWLmArzlFG6N8naycDuZ1iIcso5o8u5PNO7EkUaZLdt7WaDaPq3SFEdMoMwL1ccTcRtu
	 3Utd/yNUP5KxTk86xpjMkZMsEyF7NRbeIe18o03b8TlXlcjQAwnEYnuTLfAMwIM6FAyfX
	 i9fxvC/a2Mg0KFhq8w2t4cB43R+v/NtUmXQtNAYWpzYZ/hgdtZsxbhrhyrxlv3Weziuj/
	 g7Ks0gLiG+esRLMg9HRJREEfYBxRxY/cSlUb2tD6X9RNP90gOz1gdb9Ee16Gysa+UX0r7
	 v9jOk0DknT7zDtt7HFHAdGJASx4ik+zDsJIJRqQsD9IbHLq7OuQ0B7fY3PPmv5zYd7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=GtG1iaQR;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F56606A334
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 14:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9F56606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=GtG1iaQR
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so477900f8f.3
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 06:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795183840; x=1795788640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5S4P9EVhrzfLBPEUlAs5RhZwbxTfoymelcBjiUJ2aGo=;
        b=GtG1iaQRI9u9ARXabDEe2D8SnnTyfL+8UjK/8tqYjNwSU2a9LuKhrlTU/lolo1fBCy
         RDXey437ySP9hiMo5QnJD6PtHaw+F6Wm4BqNZ5ctCKbAFymc2+vqkB6N6NXnQATAuFRD
         yJb5e8zbLw74CQfoie3zzYHaCY6EU9YGVeRppeU8xhgcUI60o0ILXKInDYZh1OPny0rP
         euD7j7EKrlNYddojjjsLrgMjEaCgk74eQrjoFa8jw3DzuIq57Zg2AbYdM1+ZRrk9PgFs
         cU2/mDTVEffUIcg1EQR80oRe7thSm0zVOcNSnsDNUgyUVQfMBfSB01AnLEf87AeP79MZ
         VJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795183840; x=1795788640;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5S4P9EVhrzfLBPEUlAs5RhZwbxTfoymelcBjiUJ2aGo=;
        b=n+3oFT0mWr/kbWayXrFHeFBNaxfKAY5j8UsQ7ZV/gUWn/Bmyc/wu6mFU1Ej/ASt7YK
         4gntKVTDDnOrINmf2pauD2ulorHqPUi2lcU1cIsU5wbdHpGkrOQ+2zfJZtT+7qU4dibt
         +RPZiWtGAFYQqc68ya4VofAqKcmFofhiXcQurYHneXl8CgX2E4usO+9TY9Nd7bFbC0kk
         6owzYixRjz0Hed5m/fv/ededA2XEfGhJBSKJD8jh9+TsxDYcHTBBDyFLA7fmVOKJXKp8
         ctTo9DUxMVVXgXe0CJcs6rACkcyp3pZL1/23Q7JeEIC+20ZylfhptfI8PdoGletFUjWS
         +K0Q==
X-Forwarded-Encrypted: i=1; AL+hErHq9I5PvwqsR24Lzuo9AtsGHwFiKVQ2pZSvZwXXBbcisWZYY5QTm2l3A9ENjMutMMCqayk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8u3BW5qHRDLqMKBr/FG/3VANaC8iTrGqXzat6UezGQxJkxqS2R
	qGSJxsH73908bjZ3utVg071ezeVAYjNIwxRu9G3iNycYLRs4vfxzlir/3izeGHMDAvQ=
X-Gm-Gg: AYBFou0oVNz0TT1XzWyV+tVsqzQaCJ5Pa9ViFdQOfJuzln38RBBngYc+CuRrsBMpvZ0
	iAIaKUcn4ewYxeotHqpGpyQ5BGDo6ckZRiOBNtY2XKe52/e1fp1zDm8TuCrQ/JOe3ulWfMlgN78
	O8sSqYqu5Pk6ws2htcsbMzo2WKoDRbYpQoVZ2jlhf2AxPnPnVJKMe+vNBwd9bZ9OL2DcMgBdc9u
	jdY+YFCiaa8qQREGKLjAkcKUiYwIGb8Df2uyH4kIUKNR5s2Hg9YFiNHYjKPGixPF9n0vcWpjnmK
	Zbho+HEXzhWMnYMNk+antHYQmUcLMFlm3OOtAinYwanUFordf1DG1AohjzuQyuK4Xzfw+RKT1BE
	Fv+DroW9xmhjHXAL4qe1mIZncZxGQ8P8CEclr11enthrfBssEpDpsCRegT2wNFlDUQoy7BJamyb
	okvz0Sfg3iopK2KHJeWurBdAsf2F0nvd9tgfFVcGWMWgsGduDTFXg2h/nM8cPEWiVyoBHWqa4EN
	5JLknoXTgZxErtmGlwl4Aqq0avvJ8VT6vlfi2fne85bB10vwDgDpLsNlaBnClfGbwoP/jFscM0e
	R2LnO2n4f+Ggtxvl6mtEHuwb11G8guv5q9HVb1MZxBRqB76XFtsj4Ys2XxST0okNPkU6fNFzH+/
	C4AhD1W9ddwuo+3zW
X-Received: by 2002:a05:600c:3b1a:b0:4a7:8fe8:130c with SMTP id 5b1f17b1804b1-4bb8881d4damr71087005e9.28.1795183840190;
        Fri, 20 Nov 2026 06:10:40 -0800 (PST)
Received: from localhost (p200300f65f19a9041d3eb07d772156f3.dip0.t-ipconnect.de. [2003:f6:5f19:a904:1d3e:b07d:7721:56f3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb895f66e1sm37012445e9.0.2026.11.20.06.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:10:39 -0800 (PST)
Date: Fri, 20 Nov 2026 15:10:38 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Yao Yuan <yaoyuan@linux.alibaba.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>, 
	Thierry Reding <thierry.reding@kernel.org>, Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Karl Mehltretter <kmehltretter@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Marco Elver <elver@google.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, Bradley Morgan <brads@mainlining.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Pnina Feder <pnina.feder@mobileye.com>, Mete Durlu <meted@linux.ibm.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Rio <rioo.tsukatsukii@gmail.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Longfang Liu <liulongfang@huawei.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Brett Creeley <brett.creeley@amd.com>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, 
	Julian Ruess <julianr@linux.ibm.com>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Eric Auger <eric.auger@redhat.com>, 
	Mostafa Saleh <smostafa@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, qat-linux@intel.com, virtualization@lists.linux.dev, 
	intel-xe@lists.freedesktop.org, kvm@vger.kernel.org
Subject: Re: [PATCH] vfio: Allow untainted use of driver_override
Message-ID: <awBUG7-QzXplEiUT@monoceros>
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
 <20261118235645.2907908-2-alex@shazbot.org>
 <xzp5gljhburzbpol5bgnyyzwdrgpw3fj6ff3j23ein27raiidw@kti7moeuwvb5>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="76ybofus6n5n73yb"
Content-Disposition: inline
In-Reply-To: <xzp5gljhburzbpol5bgnyyzwdrgpw3fj6ff3j23ein27raiidw@kti7moeuwvb5>


--76ybofus6n5n73yb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] vfio: Allow untainted use of driver_override
MIME-Version: 1.0

On Fri, Nov 20, 2026 at 10:17:46AM +0800, Yao Yuan wrote:
> On Wed, Nov 18, 2026 at 04:56:44PM +0800, Alex Williamson wrote:
> > Driver overrides are the standard mechanism for binding vfio drivers
> > to devices.  With the introduction of the support_driver_override flag
> > in the core driver struct, it's now required for drivers to declare
> > themselves as driver_override compatible, otherwise driver_override
> > bindings will be denied or generate a kernel taint.
> >
>=20
> Hi Alex,
>=20
> > Set the support_driver_override flag on the driver struct across all
> > vfio drivers.
>=20
> LGTM.
>=20
> Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>

I missed your reply when I sent the next revision of this patch. I had
to trim the recipients of the v2 because gmail refused to send it with
everyone on Cc: who was emitted by get_maintainer.pl. So please see
https://lore.kernel.org/kvm/fb0df5c89336b77a373ae0f890f63427e4adbb28.179517=
1088.git.u.kleine-koenig@baylibre.com

But also note, that if v2 is picked up using `b4 am`, your Reviewed-by:
is considered as the patch didn't change.

Best regards
Uwe

--76ybofus6n5n73yb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsAVNwACgkQj4D7WH0S
/k5TyQf/eHBkTiGwub1DLzfSI9Ji/DkzXua0OriEhTmok4cd+2dbl8OfLn0CXg3e
B7W5T3PuQPmIapUivPRGpIJ31hN6+UScHDdfNvj1Xbret/ZoqA+0l48dqU/ikpgB
X4WK2ENvhE+glZpB32rPkpeMadqauuBUmh1TjWnpLKn4QmgLyf+pHIJSnUmH7XkQ
BV2i7AIctyUc2PP/Y+URhj62+6B5pxn3+5BlligAvpjkpg98TxVTctcCEgP4apyk
TI6uZtnd9maFMXHbUJHEArWhVKI8FLAzZySY9/E7u4+tsY0gz/JMib7RngFR2IY4
MPZB/liFV473f+eDblZh9CKsu8DAJA==
=wiOu
-----END PGP SIGNATURE-----

--76ybofus6n5n73yb--
