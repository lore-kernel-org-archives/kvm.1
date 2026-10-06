Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76674330B09
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791264525; cv=none; b=V57F6tTIEzoc/81W+OuYEx1Z0WxnwDJ0Zu46mLovHUSuaMslH0FqszMTBRy9BiOU0ozjEi2TSUmTdTSlVXwo0MRzejYwaGEnDNbtinz9ZIeTXxHB5cwVJMf7CjBcyOlcDusMLrO6DKRD2UphrruMsfmFiD+nT85vwimG8ejc4tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791264525; c=relaxed/simple;
	bh=9HNEAgZBFHcYTLoKgcMQRxKJGpiWOAr0xe/pxActPcc=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=NUuJvsqeXOiO8LkeKLSPZ9rI0he12ZU2CcWMfcgzVfegiNBH3uCkysomXX/QfZ0xxO4SFsJq+jsa1aqj5uVDc92VajmSpGwQnLhz+o3q5vc24tKw3TNVY3rPPBzXYL3fGv/V8QZQaNtdrPpX6S94MTq/bYq2L/S+lGwFsqwWI60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWh6G8ak; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWh6G8ak"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6768a9fc0e8so2223377d50.2
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 22:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791264523; x=1791869323; darn=vger.kernel.org;
        h=content-type:subject:cc:autocrypt:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+nCX8wsQF62S5gcqdhMgMojOzeuu0tFrTa4f41qQVqw=;
        b=dWh6G8akzqSeemAMPKl0olfxP7UqOmX03BmOvSSnTJufIb6TvsA5/wcKbKPyABdZXL
         Wyd6pD/qe3savXMbK85RBFvBZw81JS+xtdzYmO2KWRhV5+s0mImThFkTBDrM5ZPO0vlP
         9svDR09yPPwF7p8tp3tDtjk7BvA3fKKAFF89QPdsKqpvlii8CfDsjBOnkxscLvNzeAoz
         uZeIBQx5Y+LShmN9QToq6/b8vJ9ohm65oVhzkV3DODzvWme1EcdrAveLS9GYK/MdzpQ7
         ionwbYGC/6o+gdOkF0c+6nBtVaS5+AKMRnxWHMENEbUT6I373dl6KdV2DN2G97AuUdES
         k49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791264523; x=1791869323;
        h=content-type:subject:cc:autocrypt:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+nCX8wsQF62S5gcqdhMgMojOzeuu0tFrTa4f41qQVqw=;
        b=mE2IWDdFfTCCsf+SRgctdpCXDIbspKe6vsbJhuO6OAxSCM+N4wTMu3NzKXJvXmCXfO
         be+HVyiYCMuQg/dFQq1+VRb5YVXMIcrdmJoo+5nUyLDs7dRlYbc75K5Qo9mpiv08cpd7
         6zVKsbryKkQBaaEDw6UZr0kj40IcY6aKtoy53N5SjCIyXfhnvHxBDv8xdeofJXkdv38n
         Ix4NEJ2csLuX5QyDuLq1p+i4AoxFtbPDTHGmh2e8QaxchkNzqlYYXZt+7mAtl2exG+Kk
         T9RzcGkzmol8I541d/mDyS7TyCxTWKLd1bxBTWLJGUsGQwNqobPcPofBh8OOxuOXLypc
         GAGQ==
X-Gm-Message-State: AFq9FYLnEJINw8GO3u6VmBOVQR7jhzQNIxaTcTcUxocukJj7adaOqwkS
	vPM7ZmeHgB8f04nX2wdTndJVrM6mmLaVcZclwD4tngD9iWsw3cL1SPCiqWqbqA==
X-Gm-Gg: AYBFou0gf1/UA8BHlYh3C5BstG7IGfXJgDXdZUbclBW0WlWVW/Cia3Kbg0l8EZuvgdG
	VZilHA2i7dAMQlnpKbmCmnljZOSUAjgXZAj6BfHNVaEIrV+sA2vbWdOr9jUFWCNpO0R7RtVgwC0
	JSGx/nRozd5latLlMhjTKZdAehrS7lxJTxUFtzeL116/B4zqUNCJKtBa40uf8+YF8A3S4oM7hdJ
	9jmOc5dOGm5irsJd47YCK29eKn0EfxNyxJGG5Tl6rgCRgIDfZhYzrRbHiHm8ei1XL63Ykd7/ooR
	54/gRBp3NR57amf0qo6P9NoX8V/587y7lHbzKnODuX/3eeMY1QM6qNuIdWd/435x9B5LkMW9fuc
	Bt/2tFZGXFXC4/+xvT9r/oOE0+G5sVdfZWHA1MawVTRnUEPplvJu5/wqoDBBhMvE0eP7LG3bhRh
	xuHmaqAu+ptjbBEL9mORL5w6bgszvOtf+akapQ/KrS7pIxLPFUVdhzSsWfrf2jiAEJSMdpyjZYr
	A==
X-Received: by 2002:a05:690e:1242:b0:678:fa71:2ff1 with SMTP id 956f58d0204a3-678fa713bb5mr304997d50.14.1791264523102;
        Mon, 05 Oct 2026 22:28:43 -0700 (PDT)
Received: from [10.138.10.6] ([185.98.168.8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae3011f3f7sm48018747b3.3.2026.10.05.22.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 22:28:42 -0700 (PDT)
Message-ID: <b16fede3-97a5-45cb-80b1-6e080af84235@gmail.com>
Date: Tue, 6 Oct 2026 01:28:38 -0400
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kernel KVM virtualization development <kvm@vger.kernel.org>,
 Linux virtualization list <virtualization@lists.linux-foundation.org>,
 Linux IOMMU Development <iommu@lists.linux-foundation.org>
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
Cc: Alyssa Ross <hi@alyssa.is>
Subject: Recovering from IOMMU and/or KVM MMU faults
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0LUY9lfAwgYbsudM0Elh00H0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0LUY9lfAwgYbsudM0Elh00H0
Content-Type: multipart/mixed; boundary="------------F0HqGzIso2ZZMnzZ7vvq5Rop";
 protected-headers="v1"; hp="clear"
Message-ID: <b16fede3-97a5-45cb-80b1-6e080af84235@gmail.com>
Date: Tue, 6 Oct 2026 01:28:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kernel KVM virtualization development <kvm@vger.kernel.org>,
 Linux virtualization list <virtualization@lists.linux-foundation.org>,
 Linux IOMMU Development <iommu@lists.linux-foundation.org>
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 xsFNBFp+A0oBEADffj6anl9/BHhUSxGTICeVl2tob7hPDdhHNgPR4C8xlYt5q49yB+l2nipd
 aq+4Gk6FZfqC825TKl7eRpUjMriwle4r3R0ydSIGcy4M6eb0IcxmuPYfbWpr/si88QKgyGSV
 Z7GeNW1UnzTdhYHuFlk8dBSmB1fzhEYEk0RcJqg4AKoq6/3/UorR+FaSuVwT7rqzGrTlscnT
 DlPWgRzrQ3jssesI7sZLm82E3pJSgaUoCdCOlL7MMPCJwI8JpPlBedRpe9tfVyfu3euTPLPx
 wcV3L/cfWPGSL4PofBtB8NUU6QwYiQ9Hzx4xOyn67zW73/G0Q2vPPRst8LBDqlxLjbtx/WLR
 6h3nBc3eyuZ+q62HS1pJ5EvUT1vjyJ1ySrqtUXWQ4XlZyoEFUfpJxJoN0A9HCxmHGVckzTRl
 5FMWo8TCniHynNXsBtDQbabt7aNEOaAJdE7to0AH3T/Bvwzcp0ZJtBk0EM6YeMLtotUut7h2
 Bkg1b//r6bTBswMBXVJ5H44Qf0+eKeUg7whSC9qpYOzzrm7+0r9F5u3qF8ZTx55TJc2g656C
 9a1P1MYVysLvkLvS4H+crmxA/i08Tc1h+x9RRvqba4lSzZ6/Tmt60DPM5Sc4R0nSm9BBff0N
 m0bSNRS8InXdO1Aq3362QKX2NOwcL5YaStwODNyZUqF7izjK4QARAQABzTxEZW1pIE1hcmll
 IE9iZW5vdXIgKGxvdmVyIG9mIGNvZGluZykgPGRlbWlvYmVub3VyQGdtYWlsLmNvbT7CwXgE
 EwECACIFAlp+A0oCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJELKItV//nCLBhr8Q
 AK/xrb4wyi71xII2hkFBpT59ObLN+32FQT7R3lbZRjVFjc6yMUjOb1H/hJVxx+yo5gsSj5LS
 9AwggioUSrcUKldfA/PKKai2mzTlUDxTcF3vKx6iMXKA6AqwAw4B57ZEJoMM6egm57TV19kz
 PMc879NV2nc6+elaKl+/kbVeD3qvBuEwsTe2Do3HAAdrfUG/j9erwIk6gha/Hp9yZlCnPTX+
 VK+xifQqt8RtMqS5R/S8z0msJMI/ajNU03kFjOpqrYziv6OZLJ5cuKb3bZU5aoaRQRDzkFIR
 6aqtFLTohTo20QywXwRa39uFaOT/0YMpNyel0kdOszFOykTEGI2u+kja35g9TkH90kkBTG+a
 EWttIht0Hy6YFmwjcAxisSakBuHnHuMSOiyRQLu43ej2+mDWgItLZ48Mu0C3IG1seeQDjEYP
 tqvyZ6bGkf2Vj+L6wLoLLIhRZxQOedqArIk/Sb2SzQYuxN44IDRt+3ZcDqsPppoKcxSyd1Ny
 2tpvjYJXlfKmOYLhTWs8nwlAlSHX/c/jz/ywwf7eSvGknToo1Y0VpRtoxMaKW1nvH0OeCSVJ
 itfRP7YbiRVc2aNqWPCSgtqHAuVraBRbAFLKh9d2rKFB3BmynTUpc1BQLJP8+D5oNyb8Ts4x
 Xd3iV/uD8JLGJfYZIR7oGWFLP4uZ3tkneDfYzsFNBFp+A0oBEAC9ynZI9LU+uJkMeEJeJyQ/
 8VFkCJQPQZEsIGzOTlPnwvVna0AS86n2Z+rK7R/usYs5iJCZ55/JISWd8xD57ue0eB47bcJv
 VqGlObI2DEG8TwaW0O0duRhDgzMEL4t1KdRAepIESBEA/iPpI4gfUbVEIEQuqdqQyO4GAe+M
 kD0Hy5JH/0qgFmbaSegNTdQg5iqYjRZ3ttiswalql1/iSyv1WYeC1OAs+2BLOAT2NEggSiVO
 txEfgewsQtCWi8H1SoirakIfo45Hz0tk/Ad9ZWh2PvOGt97Ka85o4TLJxgJJqGEnqcFUZnJJ
 riwoaRIS8N2C8/nEM53jb1sH0gYddMU3QxY7dYNLIUrRKQeNkF30dK7V6JRH7pleRlf+wQcN
 fRAIUrNlatj9TxwivQrKnC9aIFFHEy/0mAgtrQShcMRmMgVlRoOA5B8RTulRLCmkafvwuhs6
 dCxN0GNAORIVVFxjx9Vn7OqYPgwiofZ6SbEl0hgPyWBQvE85klFLZLoj7p+joDY1XNQztmfA
 rnJ9x+YV4igjWImINAZSlmEcYtd+xy3Li/8oeYDAqrsnrOjb+WvGhCykJk4urBog2LNtcyCj
 kTs7F+WeXGUo0NDhbd3Z6AyFfqeF7uJ3D5hlpX2nI9no/ugPrrTVoVZAgrrnNz0iZG2DVx46
 x913pVKHl5mlYQARAQABwsFfBBgBAgAJBQJafgNKAhsMAAoJELKItV//nCLBwNIP/AiIHE8b
 oIqReFQyaMzxq6lE4YZCZNj65B/nkDOvodSiwfwjjVVE2V3iEzxMHbgyTCGA67+Bo/d5aQGj
 gn0TPtsGzelyQHipaUzEyrsceUGWYoKXYyVWKEfyh0cDfnd9diAm3VeNqchtcMpoehETH8fr
 RHnJdBcjf112PzQSdKC6kqU0Q196c4Vp5HDOQfNiDnTf7gZSj0BraHOByy9LEDCLhQiCmr+2
 E0rW4tBtDAn2HkT9uf32ZGqJCn1O+2uVfFhGu6vPE5qkqrbSE8TG+03H8ecU2q50zgHWPdHM
 OBvy3EhzfAh2VmOSTcRK+tSUe/u3wdLRDPwv/DTzGI36Kgky9MsDC5gpIwNbOJP2G/q1wT1o
 Gkw4IXfWv2ufWiXqJ+k7HEi2N1sree7Dy9KBCqb+ca1vFhYPDJfhP75I/VnzHVssZ/rYZ9+5
 1yDoUABoNdJNSGUYl+Yh9Pw9pE3Kt4EFzUlFZWbE4xKL/NPno+z4J9aWemLLszcYz/u3XnbO
 vUSQHSrmfOzX3cV4yfmjM5lewgSstoxGyTx2M8enslgdXhPthZlDnTnOT+C+OTsh8+m5tos8
 HQjaPM01MKBiAqdPgksm1wu2DrrwUi6ChRVTUBcj6+/9IJ81H2P2gJk3Ls3AVIxIffLoY34E
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
Cc: Alyssa Ross <hi@alyssa.is>
Subject: Recovering from IOMMU and/or KVM MMU faults

--------------F0HqGzIso2ZZMnzZ7vvq5Rop
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I'm designing a new type of virtio device (vhost-guest, was virtio vhost-=
user), and I'm running into an interesting design question.

Specifically, the frontend (a vhost-user client) can ask the device (a vh=
ost-user server) to ummap memory.  This is handled by replacing the mappi=
ng with a PROT_NONE one.  However, the guest might be accessing that memo=
ry.  Furthermore, that memory might also be mapped into the IOVA of a VFI=
O device for zero-copy I/O.

If the guest is accessing the memory, KVM will get a fault.  If the PCI d=
evice is accessing it, there will be an IOMMU fault.  Is it possible to r=
ecover from this?

If not, then the only option is to wait for the guest to release the memo=
ry itself.  If it does not do so, that's a memory leak (host denial of se=
rvice).
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)

--------------F0HqGzIso2ZZMnzZ7vvq5Rop--

--------------0LUY9lfAwgYbsudM0Elh00H0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmrEhwcACgkQszaHOrMp
8lOmuA/9E4DWi9cLz8/J86RGWiqaoWZLSBgrEwCkeTlCp+JLhR0lxMn6F1gk0Vme
+EJ86q8PkdJntreE5wauaGQofRtNWBH5duYcACmzmVTVJ/xcY/2RwKrpqSTOQBNz
Sy432cCFP37xKMO1cNgfDk4SZoZMAMvnRcHKCWr+HRvSn4JZ06ddhI9uQVdxPrjr
3Z0LKOA6rkiQgnztgOtZ4E9SiA7xCEKpmJZCpVmrgtQmccRLRjoN3sfY/XxwaN8c
SZ6ks4shJqYNF/dAstru5VXAkPDFxZW9I18qxYp1uQIMuvFd3lOsyMweltulUfY7
2hY//INXhRIJ9hyAyXAbSR2qmrUUrbpRiqwbljZ+hVzD4g4dDySwimzHb2Eyx0Jr
Tx8t9/PDB4VzJu3/yaBErBsQnWCxTl9grB7Hvp6X/gkOMxZkA1pcXSvSXdS2vZvk
f9QluxhINzjyRiRLvp3mbrrCzaeAFF21PgCN1r7dQuM1ImcEF26QoE7FpT6fql5g
sNBiVKbqDeybVdDBtErbK/nFlATXMeCO5ncM1Fz7UgIdMP5Rs3kVpHNUAyYCCUCj
H8pgxRapQ9GkGwSrz7la1E7EOTxoQrMMFfKJm3V/+nLX3xRzoyD3ox0dxz6ngUgE
j/VUGhr3pv6RblxXD+A0ejvQ7+8MhVtV81GELeMEOygg1vH3igc=
=3SGs
-----END PGP SIGNATURE-----

--------------0LUY9lfAwgYbsudM0Elh00H0--
