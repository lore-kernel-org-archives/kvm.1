Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533200;
	b=YWZmXvJMDu1/BXe+QAGK+c6oT1jHAI7MkbB/VNfZIE2kaZgQGTlVfbYjM/oW5dBtayd/
	 WKwaIJXY+gxlC8E97BV4eQq563DizBRRWMo1ZC7fo4pUkcC9UI9SIL4UrFVWet5xbuVBR
	 tXE3E5kcOFGRHJd9a8Gi2MUUckLiyZy2UbljJqtN3lWs7nBwJaDI67Nj4PNdOqm9LVDfR
	 wAwpjA1gkla37XAAohdJ+KhiH7PCIqJr7ziMgrSeTKIgaGIWVOREKW6oNm9FWqP3NEtcw
	 8uoMG0m9HDa+vu5rPWVCfOfFCVPiweScw3AidQC/5JGW3FM42Q+6mGxcjp75eV5oVjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type;
	bh=OavKAVZv+OA0pfYHqsDmPh81k4IRaCsSuMGSaPHhIPw=;
	b=nhNVvVWlZiWFx9wjdn/Aq/dqgQ7e1HjmScE1Pwqg+NohAikUR69HWHlXEua5fIccI9nY
	 XISAVXyrz44+OSDhD/1aGqo2DYgHOKIq3QO9OW85toSf2bKmJWtouCYjXPgF2qLi5vWKL
	 yf+11vxU7+U84+b7h5cynU2P6NsoomgvTnFtJxYwjzRDU44sDSTamO6aDbMnsW2Kw5X/2
	 6RxwFjYcdJxHAoHcT723QJWtFPS62ki1h/LaBYhtq3LUsYpnpFEn0/Wvcz+382vZ+CKXz
	 vRjXTsH1K5PoQGg5XwtMqEg2+3iwEAzf09P0kVkHJj8Un8/9ad3U+7yw7cmE4EOF4yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=bB0gXxT5;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72926606A32C
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 15:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72926606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=bB0gXxT5
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c511c0e2826so531592866b.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 07:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795533198; x=1796137998; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OavKAVZv+OA0pfYHqsDmPh81k4IRaCsSuMGSaPHhIPw=;
        b=bB0gXxT5Q8JH/1W/OdI0h97Qt3d4ySyODEfnz6xoARA7SA4/X3lTaCmWMaZ1fCMX8s
         JnioO/vI7K/nhE6XtL/vBilK1zeV1MYlabhR0b7QWwxkxoB5jfT+vRdm1Mqv7QvPtoSf
         lKK+GJYxGSvU+jZoDadaxjWl6qt9Umrc3u9FTw1k9yBnz8JglaXClP/Ia1gp562FNVJV
         LcAQwYtC6mnaW+4x+3kSsqUDbJKYWUav7glSYpTmp6Jl386wc2F6I2xTELMmWDlwXaum
         708AY6VmbTAgyqfTAzX8cWEx+CAGoECgrYqzQIIa8HR0lBgBKqEBYw2EE7tjPP8Fi2Lr
         vcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795533198; x=1796137998;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OavKAVZv+OA0pfYHqsDmPh81k4IRaCsSuMGSaPHhIPw=;
        b=ctRgRLCBKNyjPlDZlqgo5uJGzAox9nXlduE8cyvv9J83JWTPKCsSSiBRnatcnR7KIp
         DRbekzPBJMa3ex9glxzCh4sZOfGCLunBcljpkmJcFm4Dq5Yb6n22oGy4cLqPdScGtSiS
         AVkednk7iiRHLMA87C+T1KgN8dds2DL7Z5BRK6S4ub+6BW96DGnZ0I+pqkp6etpTMiZ1
         DQZqsfPkK17M9/1IMsoAAsn1iUvdJn027vFw+6hpFJVO6DiSgP2pfFB0aPyhMxdBouqF
         z8ZoOqS6i6+VoAUuOz/tnBhiAW6LEChWPKJ+tUu95sHop5PIccOxYP5IiPJ4/G/r49oB
         O+uA==
X-Forwarded-Encrypted: i=1; AL+hErFYrf1sZMnnFOb75f8Fo7KG+sxKJ7vTrEavMPfx1vz1VcvNvwMZ+BzO/B2joRtK67iPwck=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qjNw2Y/KAZrkZV7A6KgyjY6R4s0DMOdhNfxZ40nxzJqiW7hgH
	UCuNpdCJJ2a9YJZVQmgL7ekkRfYRS9+Ifxd7mtzjh1yngSUyOv6uKaIunOGM57GR0wY=
X-Gm-Gg: AZFdTZe6t19kiP2azG+zFZ9OP0Ko6jTEM0JM5pKuXkBlrj75T55LvPMJtFuQCORLsk1
	X5O+SDzRfHuajWVh8pxZMh56dm7AFukjWE0IkoH+wToQzg0V/SDwcyqH/5MuBe8CzBGtyRvqdHD
	OFzAXRj4pdaHh9hwOELL9WkO9WxS9G8tKrCpBJ+RNVSb1sIeCXLfmlR7piuzfjNzIk9lx4TJvOU
	YSzXe/y0S6sUusTZLcK/ciYMQawz20QQ5ORZZX7LE/6Ci5pQbSB0ShlPIR2wIft80KCLXrVhp68
	ATWgCV0koqvize5Da9F0SZ9WnO1xQOKdV6lAMn4l9XkrqV+tMhGBONhdUmQR3y8uQQxGv/WRhop
	zaVizYq+dqr0MopSl0zfx5OKjMaYSdpTsCqbvv4JRUnDdIDZ05hZlHkef9+wyNQksoSd1ymkDDu
	wg/IDReOu9uT/s8PZr5nRglPqEq7zN12+bIWSuV4tt/7ndZjDW+GpY42/PworhD895YhlGjyF9o
	Locm1BbuhW6NCaRSMqrlEQwQJT8ipM1xqoWTgtPN1NMbOjBt++RWZGSvXumvXDWle85mnfhC5VW
	98Bo6U39mSD3o29WwAhVisqLY5nHghPwcpgVq+C1tjEg5LqJ7nlRrI8y/s5wYcCLkW62D49PnYb
	TPCwd+w2qayqJ3tPbNdEEWTvA0drjRw3grSCmia0b4O8WzgHXCqA=
X-Received: by 2002:a17:907:e00b:20b0:c4d:22e2:1a2b with SMTP id a640c23a62f3a-c513a47e2ffmr818303866b.1.1795533197737;
        Tue, 24 Nov 2026 07:13:17 -0800 (PST)
Received: from ?IPV6:2a00:12d0:afa3:c01:92cc:e257:77ba:97a1? (2a00-12d0-afa3-c01-92cc-e257-77ba-97a1.ip.tng.de. [2a00:12d0:afa3:c01:92cc:e257:77ba:97a1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae8d0dbsm543097066b.31.2026.11.24.07.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 07:13:17 -0800 (PST)
Message-ID: <f9ddfaa9-9a78-4fcb-a142-6c466d215492@suse.com>
Date: Tue, 24 Nov 2026 16:13:16 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] xen/privcmd: convert mmap hook to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
 Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
 Scott Branden <scott.branden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Richard Cochran <richardcochran@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 linux-sgx@vger.kernel.org, selinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
 netdev@vger.kernel.org, linux-mm@kvack.org
References: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
 <20261124-late-2026-mmap_prepare-v2-1-0b0d99d655f9@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20261124-late-2026-mmap_prepare-v2-1-0b0d99d655f9@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------q205G5Arex3sh2KHaxisqvnr"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------q205G5Arex3sh2KHaxisqvnr
Content-Type: multipart/mixed; boundary="------------AjT5XFhC0OM07fDCW0uVTora";
 protected-headers="v1"; hp="clear"
Message-ID: <f9ddfaa9-9a78-4fcb-a142-6c466d215492@suse.com>
Date: Tue, 24 Nov 2026 16:13:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] xen/privcmd: convert mmap hook to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
 Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
 Scott Branden <scott.branden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Richard Cochran <richardcochran@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 linux-sgx@vger.kernel.org, selinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
 netdev@vger.kernel.org, linux-mm@kvack.org
References: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
 <20261124-late-2026-mmap_prepare-v2-1-0b0d99d655f9@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20261124-late-2026-mmap_prepare-v2-1-0b0d99d655f9@kernel.org>

--------------AjT5XFhC0OM07fDCW0uVTora
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTEuMjYgMTU6MDIsIExvcmVuem8gU3RvYWtlcyAoQVJNKSB3cm90ZToNCj4gTW92
ZSBmcm9tIHRoZSBkZXByZWNhdGVkIG1tYXAgaG9vayB0byB0aGUgbmV3IG1tYXBfcHJlcGFy
ZSBob29rLg0KPiANCj4gVGhlIGhvb2sgb25seSBzZXRzIFZNQSBmbGFncyBhbmQgb3BlcmF0
aW9ucy4gVGhlIFZNQSBwcml2YXRlIGRhdGEgaXMNCj4gYWxyZWFkeSBOVUxMIGF0IHRoaXMg
cG9pbnQsIHNvIHdlIG5vIGxvbmdlciBleHBsaWNpdGx5IGNsZWFyIGl0Lg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTG9yZW56byBTdG9ha2VzIChBUk0pIDxsanNAa2VybmVsLm9yZz4NCkFj
a2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0K


--------------AjT5XFhC0OM07fDCW0uVTora--

--------------q205G5Arex3sh2KHaxisqvnr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmsFqYwFAwAAAAAACgkQsN6d1ii/Ey9P
6wgAhB7FWWxaGPhKVeHejmUgx+jnN5sGJc29B5zeOJ/udOQfrpojRJR0JMaTJNeJ8g/QXkTWmCZt
Zd6lRhkVQVMmVrlatIREKD6+lx0mr154pd31nTm9ffbjdyAK9RPk6czEHFUxkktbU/9vv+pBcZEa
4SaEbJuidUtK7Vgek2j0JKYNWpqv8R80d+nRsMU+RX0YbRKCuT8Jtt3uB/TLb76UL/eK81vzE7j3
bGBh83GA0cSOumIzSg72te0PCuz4U9UgccJbDbwLIPRkV2Gx83sLPaLOj5968cz/vyT0qZwJ5LfI
2oGgirhriBPAdLJrm4WtpkDGIWO5CaJWyZf5I3zVZQ==
=Eyqx
-----END PGP SIGNATURE-----

--------------q205G5Arex3sh2KHaxisqvnr--
