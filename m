Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4848B366
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997149; cv=pass; b=iGTgJh34QKT5tS2CAsWcMzOG3N9TaOL8JC6o64bboZOTM8o+MibGAPslmfcfLx/GNtJcPPQirt/k9kqwMCcX2zUSbUABAXouwYSuGFFvgk6cDHQW8u3jH3NemZm7yoyaSkW4DewNMjXYhIFRmYapB9U7wdSYn8+QABEktuc2Gj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997149; c=relaxed/simple;
	bh=J6ANT64o73Oy/MqjWeiTVaKBLJandxdhBxQ3kDb+K3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EI6Z5ntDCQOThUI9fRMfxPRTCGgsMCojJsBrAtHI0ZOQnwl7MV10bDYoqhTxyrL/ykyETzmO1WXxhuHSlniiBtnOFGCHdzqDUY+2BbxE362bKxD9cHvh+mYL+bSl+H1M3Fu8ZMm5iqibau9MZWlWrIul3FuEUFSGJM16JREh0GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TXITp4kL; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXITp4kL"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-130c653cce4so1537430c88.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 09:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777997147; cv=none;
        d=google.com; s=arc-20240605;
        b=UsQRCIsMeRFCWupQ7Pc7/fYeGYBN04YJ13QuJjBIDmkchAWImLKG0CmgUJBKuf1qvw
         DkGcdAivNjA884kxioJRAYuiIRfPG8rhA/324LPYE6TP4ZD+Y8KtwzzonaoXh9SP3BDv
         hJt/4z224yhIZP9678fGt+o/AcFieTtqYbxUe+UVaoWy5dRivXQ3nfAwhpkky+wRmThj
         9O8bEWOk/1wONZHND+FaOqRObHKFVIXSUa7YLmrR98Tx9dz+4pV3R8+Qrq/VZ2zD7Jjx
         AoBm1mxvedba7VUws0peLW3N8ZeTko9n7ZL8lHvpyyVCa8gf5c1g+iJyh+c9hdCQUYt+
         k3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jr+WQFKJTcHJZ0sRMLiTHOm1qsMvrLUcWME2L+LwpFY=;
        fh=FRAOtJC92lePbZFBW02K76oViXDhpU5swZq/N4fzjyU=;
        b=XGf4ajU2hOYUkS7K1hO/TfKgH30w8mrLOLX4Og6MCGwtlPnbveb4KHRDbMEk1nesBR
         G6AzjpemTV+iXizUVs9JeABV9Nd4iQg1S0WYX43TppKvqyWP59HRd9AhHUsg7YgcdlWI
         pIKjwezk1zqETECjek+YbhSdDKPasZ+hwCXG02jgWkiWvFAz29QpVEfQYORbwoXoRwjK
         wCjb54mdRySV0h39MzP8sCEbxyYW25jJ0VFKMQoQ9zt5PwfP1tF2NKVV7R1lpXGBO3GD
         efeCviQaGHMPE9SpSXewYK2KD8CH9/wLAHoerXzQvNc409RyKDi8nDk8Rboh4GvUSMmn
         ShhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777997147; x=1778601947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr+WQFKJTcHJZ0sRMLiTHOm1qsMvrLUcWME2L+LwpFY=;
        b=TXITp4kLzGaLEQ2tD87iXCniwLYk0Hoh67wTjG6eywIBT8W8M9bYjQuTxUtBqXjcnz
         Z2A0YG2LTUTtYeaxAqFcvAPxJN18EGASAFFdhU+HBfELiWbMX1c5fXYpKnv8xPnHDDqU
         0a1zZoY8i4YZu58ZThlZJuMMvfXkFC5jFwPBRaNr0E3VFzQ0y8nuZum+qTbtSVodOz7s
         EUWJQGc2aZttD9MmCEKR5WUmXgNW88yJdHSQHO2Q0kd1jZKzfvrL4LHqBhEEgRkG75zC
         bZ4edVIte6ee4zBIDibknoORQmZ2R2BIy2irgABosj6PQEOXV3cxTH9mAqFLzuxmET+i
         8TMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997147; x=1778601947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jr+WQFKJTcHJZ0sRMLiTHOm1qsMvrLUcWME2L+LwpFY=;
        b=PpExvhAnl4TIUOhH18cNtkFENrNDaVb4nei2XwUH2osxcfHdkibZID5Ol/iBXuPa2Z
         CnP+0rCeV8eHRBH1GU0YQ5WKmE/xNtT+6a5vQAQ0Pv4N9/t6LsEF3YsI1GL61u6hTNa7
         YqHURSg0oTugXuwaS8lVKOQBLgc8IQIk/K96mFGeFAt7p8rRO86YN7+J8gJGPu2M2B+C
         ru1blAea+pI02VFEA/AN/COGo/CWNSytsKIAd85GjjlXL2PVbGUM7rz21qMii8lC5hRq
         lpZB+AJjS6goK0cGdLjlNMRmlBclZaUr+DvIiMelHQDotLq9zlicKtiGRjsP5geuNi44
         uOgA==
X-Forwarded-Encrypted: i=1; AFNElJ+PMCgOqurmNyxWZ/9X+SCN0+pQBg/bKCmQm/K7uPewCylPuHG3HlIOWqHKcV+Bi/RItr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6J8qavZriGHYGt8Pgsjy6UVtk0ujPE+Lm2ZNd7Pk1qjFO2v7z
	3qjKozN8FSfmzy/pyDydq+lGX/qqpiVmX/I6knXewIyQjVQJ1O5G7auswKL0wJNHzP5LwDKfbnX
	aX5OZQWX1d8K5vBoIMJaWmSj4rC+JTlKu/sGq/c+pLOPnepx1P/2ymCJx
X-Gm-Gg: AeBDieu5w8TmgJSwdMs4m3+nMotwqhLUyJiFviuqLFW0h1ZYZD1EHBgUEJijy/NXH0d
	BOFvVHC2BX7+67TtLOYGpSlhP152YdD3FQA/zTNTEbCPorl1IVW7u0ov3EE1gj0CUdQSjNj8WFH
	Vqlxen3b/XMgdydUWuw8iKGwUuV1hNqIUUuLpMNzS/dCs0qB4cKEq3KkgHkIoqssCpzgzoJlFlZ
	qdMjNQC0q0vkxu7ALVtQvn6OHyMAwCSFBPbJooFlZRPOc6C1WGI92t/ciPaal6jUS3fk+cH3HZf
	4N1jSMKNv5hJiXAHh5lMAFillIuc7Ys/9s19EDC1
X-Received: by 2002:a05:7022:6628:b0:12d:b214:7dbc with SMTP id
 a92af1059eb24-12dfd7da15bmr7713863c88.7.1777997146733; Tue, 05 May 2026
 09:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com> <7-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <afkH3pMJKkIbElhI@google.com> <afoSQWreOWDIfVxZ@nvidia.com>
In-Reply-To: <afoSQWreOWDIfVxZ@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 5 May 2026 09:05:19 -0700
X-Gm-Features: AVHnY4I9kiI4Q1jkqtdnHvyGsFiT-Xosh4J8OR2OjxYfYINDrozPSiggYWTK0ps
Message-ID: <CALzav=c2r5cBSpgnG6-Njc3sGrrtt-weFXo1pRUL862SdK7w=A@mail.gmail.com>
Subject: Re: [PATCH 07/11] vfio: selftests: Allow drivers to specify required
 region size
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 8:52=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Mon, May 04, 2026 at 08:55:58PM +0000, David Matlack wrote:
> > On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> > > Add a region_size field to struct vfio_pci_driver_ops so drivers can
> > > declare how much DMA-mapped region they need. The mlx5 driver will
> > > need ~18MB for firmware pages. Existing drivers leave region_size as
> > > 0 and get the current default of SZ_2M.
> >
> > I would like to get rid of the magic SZ_2M to make it easier for other
> > tests to use the driver framework. Can you make this commit update all
> > the drivers to set region_size? They can all use the same approach:
> >
> >   struct vfio_pci_driver_ops foo_driver =3D {
> >           ...
> >           .region_size =3D roundup_pow_of_two(sizeof(struct foo)),
> >           ...
> >   };
>
> Sure, lets put the roundup in the core code?

Sounds good.
