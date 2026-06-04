Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C56E31E855
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585911; cv=none; b=OhFeQfrpqlupjDFNAqTPVgjEKxs2gsX0eOw2WelDjT+RScQOcfbX8IhYJKJ+mS6CzAh46X0IHkOy2PSfA3tYSiqS3WeW34VhlDxjQj+aQa2vf3/KcscWljbGe6EHmB+L+o1VDxpdPGBFLw23bnnenk87ynitEv5E0v3/cqeyqos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585911; c=relaxed/simple;
	bh=SmKzBru82MXbWfMD6jBKCeYD6cZ596fFD1Rlxx5mYrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLzpR0c2VIq9YwOAomGcTfEnZHzqUWItCjm8NGBlpKD4TJXDZp+CzU14Ow80DrbdIszV80d1tKJCP5BljXyOZKs4ybvD3lMjXBYr3vMVMctkLaK2HwoxBnix5Ae17Ozc3I5nF6B6DS/DjlHEHH9s4QCUdvFjFz65k/GeWHJ91HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LvUS3Suu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LvUS3Suu"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-beeba001887so118407066b.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 08:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780585909; x=1781190709; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SmKzBru82MXbWfMD6jBKCeYD6cZ596fFD1Rlxx5mYrs=;
        b=LvUS3Suuuv0e2KCHhhMqKpy4KEvhc+F1ZjATbc5ZKoVbndy9I1swpIf/aeu6uTVxxK
         OyjVz07D8KmUbXWoFamg0/jVbfO7FYt0TrScfpoRjYrROQyYsuLcCpNnbu3SY5vBrH/2
         w1U34VnPKr/kvruiP/z6Is5Lf6cZ5s9RgFQSmvRrHiC+Q5FrspqgsfnMIp/AE/7SXudZ
         pQhlnzSw4vA4/TYMSmIzGoqeXR+Bnt0bMo2tnQH5RxdB4fzBZtXXW8rTtk9eRDhj6/RN
         Nqi0Nsa5e8AonDlqVELZp7b64ZBeuFL3wNO1ktCo1Ms2Av4YLCybFsXVb2xC8RbgFjrg
         6tFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585909; x=1781190709;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmKzBru82MXbWfMD6jBKCeYD6cZ596fFD1Rlxx5mYrs=;
        b=mNM4j64zIJtla/bw+AzGBrtLZjtXFi6jCODhaxbkgD4+8UFiH6zklD5FmSScWRw8jF
         R+vye44w2N7sjiFaFVU6VJlqLcvDym74j7ZMkaYfPwfYHIRBto8HDYem4Bt0Qz6YwZyH
         /Lj/6zfdQhNLqcWVNmBkQuhdxJOt6eb8hg+lZz1cgawUYWczOHxOHoup41VijNjyiujq
         Eh/qDGulagby5KTKBL0ZoNNMRMqnTz7hURD/WyV3geontemczw5q1kF4lLCt0ZkK0d3d
         uOuNEDv5HUuEWz7R8L10+bB65Szgi16kVewj6Lq/gUf5p7Jj1bBi26myjd2/wAripiqX
         S+/A==
X-Forwarded-Encrypted: i=1; AFNElJ8WKNMogtkdoj2tZ2amG2neasRL/LZFOvFX+5W9iToshFGuAqYLULwqcEXaySvN5jN8e+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YybHMFnSCJGpPaP4wAU5PaiIKs2NXJi3f3aDejStqWx2Bp4CB3g
	FFEOtrPUQUhL/ogU3xfQOPRIOOT7zkNW06CHm9PVBr5aPi6THmD7vExk5bOWr3ez6uo=
X-Gm-Gg: Acq92OG4+NNZvbk++79i41wh/PrNqOokL5MeJpZKQlz/CJJUOp9sRnMzFlnJY0JdJfQ
	Nc1jPK8le+HEgy7eTXKu7n3DiakJuEaJnnDVS9/DCtcbdcKpfY5X6cTxBd7h8MrHSsCdGtljflv
	MWSZYOJQ0M7HKQBX94Bewz6XDWnD1InsTtClnqz3LmMWu3bydjYXC4jgb3bTkP4EsrqtnMI709B
	ddPbJfv6XSuIWUGw/Y1x24hwUek+MBRxRm95RXYHaNdKBq5MEbk8b4PBvPu8AKbUiNwYPA2+Sx8
	uc/dkM+ZMdAgazblKHYVq0kM47R7PnTLk5UiYpb0HaqGqZQC9lO72aGxS5ba59ldM5kk4Zhcrn2
	f6U6o0NflksjIAo8IQ7j082T8Nl+sPgmDZMUgGHwmVa3JZiyw4LHxUYamts0b0lpjBD1jhpzgVZ
	JB8z4OYq2zPHVPEvkXDxeCQ1Un1C9zD33LX7jc6cgrhBQrh7527phZUGVtgE/kedduEur7VDH29
	hN+EmBV9TEMxaX+ZjNJK/e5E6+JmsB6eK3rgl6WYPPXTWgwS+M1SGmTx7gyPPqv
X-Received: by 2002:a17:907:cbc5:b0:bd4:f3e2:f1b with SMTP id a640c23a62f3a-bf0b2bd07e2mr457906866b.32.1780585908739;
        Thu, 04 Jun 2026 08:11:48 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9b1fasm324775966b.23.2026.06.04.08.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 08:11:48 -0700 (PDT)
Message-ID: <ce60e4dd-aedd-4376-9af1-cdae2f0d674b@suse.com>
Date: Thu, 4 Jun 2026 17:11:47 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 07/12] PCI: Convert xen-pciback and pci-driver to
 pci_is_sriov_* helpers
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Keith Busch <kbusch@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
 Jakub Kicinski <kuba@kernel.org>, Dimitri Daskalakis <daskald@meta.com>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
 <20260604150153.3619662-8-dimitri.daskalakis1@gmail.com>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
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
In-Reply-To: <20260604150153.3619662-8-dimitri.daskalakis1@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fDgbKYEUhquRvAN6UrfLuZuh"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fDgbKYEUhquRvAN6UrfLuZuh
Content-Type: multipart/mixed; boundary="------------30t203kwaL3N2wp8gES1yCvp";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Keith Busch <kbusch@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
 Jakub Kicinski <kuba@kernel.org>, Dimitri Daskalakis <daskald@meta.com>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <ce60e4dd-aedd-4376-9af1-cdae2f0d674b@suse.com>
Subject: Re: [RFC 07/12] PCI: Convert xen-pciback and pci-driver to
 pci_is_sriov_* helpers
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
 <20260604150153.3619662-8-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260604150153.3619662-8-dimitri.daskalakis1@gmail.com>

--------------30t203kwaL3N2wp8gES1yCvp
Content-Type: multipart/mixed; boundary="------------3qkLssp3MHU7hgnhd2uP8TB0"

--------------3qkLssp3MHU7hgnhd2uP8TB0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMDYuMjYgMTc6MDEsIERpbWl0cmkgRGFza2FsYWtpcyB3cm90ZToNCj4gRnJvbTog
RGltaXRyaSBEYXNrYWxha2lzIDxkYXNrYWxkQG1ldGEuY29tPg0KPiANCj4gTm8gZnVuY3Rp
b25hbCBjaGFuZ2VzLg0KPiANCj4gQXNzaXN0ZWQtYnk6IENsYXVkZTpjbGF1ZGUtb3B1cy00
LjcNCj4gU2lnbmVkLW9mZi1ieTogRGltaXRyaSBEYXNrYWxha2lzIDxkYXNrYWxkQG1ldGEu
Y29tPg0KDQpSZXZpZXdlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0K
DQoNCkp1ZXJnZW4NCg==
--------------3qkLssp3MHU7hgnhd2uP8TB0
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------3qkLssp3MHU7hgnhd2uP8TB0--

--------------30t203kwaL3N2wp8gES1yCvp--

--------------fDgbKYEUhquRvAN6UrfLuZuh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmohlbMFAwAAAAAACgkQsN6d1ii/Ey/z
Gwf+I6PwL/5jb3ILq2SuV4tHfCxc0VmbrFbnMM5EOsQMcaWg2dP5NKldVbe/9YglVn5+Q5ye46vE
XWXGZO9zQwiZMhRcifnpcvOVrr8qkwJP/VMylckq5xoql5M1BUAHjlOhZ4wjFz+Wvpxj/fAAXbNT
KXh52eS0zX0nLAOf6ZRstfv/HHNQv2rvD7EnS6xApQMbKtzalH2DDHU9TNN4oTpLPwt4mhak+XqC
kY9uwtTRokCL5nZ2en1gTbsheVKCe185MbBsv5lJlm3VovgSNFTtkeId1Vx10tBQ9H/hLcNCAToO
ihpK541tDD5nYCbj+fTEuEG4sW+f2H735xkmbz4oyw==
=ZQpm
-----END PGP SIGNATURE-----

--------------fDgbKYEUhquRvAN6UrfLuZuh--
