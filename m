Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792626269;
	b=nG+0SeBuMeTZ9fufTCZe4BiG9XZ++FKYWtDzwY4KrJ5BAO8NGj1myOWnjEgogOpMgGuN
	 gL/ANZoehIaaylPPOqAWKIciZnVzr1H1Y0OLzBOo/hcPHpNzWGcXze2vYQMv3j+nXc3rQ
	 YKBgaFiBiGanJ1sPse38L2dRO5ppuf5ZX4X7h+VdyC3d7+XMGuMIvc2GSKMBodc3jYqJe
	 4dgUZcI5xVVar/KiJ/gDI9OgFlfGXaJPY0ayVVWAUGdwRbtrMwk83rMwH7rbk9uiNYJf0
	 UyhrkuVI6564De0wbmop1J/miMYobJPF9EO/8/5LZJ86CHD53zBcrYkIsCxpxA2no8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792626269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YmMBtRNMdoQqLjotntz/qTZG4hQKHUTSeLnBN2Tuetc=;
	b=hLsH79uijiH0pRzFrj+yLHNmZ0N+NveO0g87PvOPFgOGp9h8z0uaH5e1P2apN0vHxdsX
	 8sVBE0qs6IEbdeKBUkPKHkE/ayRkPhzob8F1IqQYwiH5WgzN6hfE+4J9QaJkYyx1pCadK
	 /Slj4aiRye71NQ6moGQSAGMjP8q5JZ8AuFr2QcR+u0QdrBl6jYKuQwwofIK9/jOcMJqI5
	 +H/gP8oAki46nxcMX5sou5/vOp48/NDSbAtt+gUUfmJHpRliSRiLCZYGZLLPprfxjeHya
	 a0XIlXKC4XstC61AQAtRFW0S24ezuXkPLnmTqQhRfeamg9cDVA6HwST+VjaWnMwTOwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wbeQxpT0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A397C606A31D
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 23:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A397C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wbeQxpT0
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so2643a12.1
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792626267; cv=none;
        d=google.com; s=arc-20260327;
        b=O2AkWLvzcBy48RCjmmG6RReExbg5UF82pR23ViJotWRxSiPn3BupKhwsjBp8s/AkSw
         LqNPW6uTUnCNMQi+eyen2KRysFhitIkGuRZwaYMExw9WbSKk0Opx5OFb8NgQJGNKjN/G
         7tVrml1YzRvKlh+FHwBYcinGpR2K/eK/OTe+oqgcStrvwd9JzJ5jgaQQGv7NUdI+TMlq
         q20kBLs6w6EkDTIw85H17Tbet1ZOdOAexqhA7J3c3EJZlO4FKbNwdD2y7B5G8Cr/R4u6
         Gq0C9Da3FicGc3GMY4EJi46MkXY5s81LRI7RCRvym3jYAjFUBWSohYLwM7n3+dcZXVfM
         NuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YmMBtRNMdoQqLjotntz/qTZG4hQKHUTSeLnBN2Tuetc=;
        fh=2MHK827WKbWFpbZWR2e1xxu3wyJK461CriUWLwSRiC4=;
        b=ifBJigMTnMQSiLPAZFU8BArrhBWpq8LggzsOSD4oCX5gcqaoRApLT/ehuNieZnTQ7H
         Qopq8jGPE4DBCmX/cl+wvpK5kQNW7/tNpL3EvwSXAzB5TIjLk/DyOQPkUrJ9GxhFDwtq
         9ndmrjpONctMrhN71XAZML9SC5GY3WwhiAfXmhLBn18nlklB1xXJJKYgyfAij8G63xNP
         SHnGVxy5/Lhk37SWVDxFyAs/OCyxF0VyVvXDWLHNuFXk+AkqklJSExEk33Iy4bJ+auDc
         XPrMJEZEpdK5NrqWRH4v9CR7zIDzJaiVaZ9+zT8mZtv3kXztcGF0nbzXtNUapZ21GdZh
         whHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792626267; x=1793231067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YmMBtRNMdoQqLjotntz/qTZG4hQKHUTSeLnBN2Tuetc=;
        b=wbeQxpT0aHLpYNcLZ5SoLd9B7qDE2PlPkrR+HFLOMM8IASLrzAIgnPHwIcQfWMKG7u
         mxHT+sL3jropL3xRFXTZOZ5XUuc/wrmE3xTIJyKW16LSLBOBUe9apD8v62v/GxPsIlLC
         LL5zBl1orWVA2XVvBvRbmcnpzy3Sijv8y7w3hBnGwe+JOrQegiMxo4wWJ7hfhQ9a+a+n
         r1G3xg9mKv6TdgqU3VQm+9rJ4+xlF9KuF7XAu7EYiphxyaNGzszABrmpWeVlYDLnyHvi
         JaAdLibWmg94ZrpZQjtpk353nvrMWRK/IcfSn8Crddtd3PDAmA2wjVyv0t1GHCqzG2d5
         04Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792626267; x=1793231067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YmMBtRNMdoQqLjotntz/qTZG4hQKHUTSeLnBN2Tuetc=;
        b=dYCiw8hxGi1DIlppEk7xyDl1+XdmvXI2eMP9nR5kH+v4nD2Pv9pZtpGkUYhHtzO8jd
         mu6TSrz3xTSVFcshMhoIH7my2VXrdeRKKSWuaECEvcbQP4F95x/GL45kl3nc6eqJxf4b
         thJaWsI36kEDKXnbWG7suBD3aZzevkMvsXlj8cf8xS0bExAHEfpyYEOqGjS92W1WLnlS
         V4ulBoukwKMvkV5UbxwmOPq13yYloWFk+An5wEYG5rt1yN1X6hSW4wPkgQ3n8Kk8/EMJ
         w2XQdD/Z+6N28przUd4p/7jXU79rRpaEXxp1xCpIHYjnZvr96BQq1PuqvABKLU6LUOo1
         XY7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzVwVrhJ9sRXccfzCGixQ7CGj6hxisyRe10dwtNiKIeVT0DZxqU1hoKMNmbVdLOsVgRGNg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEzaOeNW2rc5tUeyev1PU9aZabvZbBsF4TEcJHEfWVgngxqT7y
	/W6TxpOFeVVC9IjneYpq2VMZwhzHQB+g/2jzeikTq4WGDSQpVkP6hKaeEbsYJQRaZ1fV3kbXp5b
	UhQstkgypf/sla9NKJfqCNMPssRQCnNlmT17yS2jA
X-Gm-Gg: AYBFou3qOPC5yVWRXSqBdUeiKh4RM7SYDK1DJYqf6OE5MtPm127gfq/vs/GJzw9iNM0
	1dTzUmAG+FikUsKPYhDsTY3RsuXshA0lrwGtStYntekIIBTrXXYuvQDySo1TxURDrNYJPdeG+4F
	7gRYngnlD+ca5YsaiHSCF3S/qYaN59psk/VsF3N9jCX6HZGhCKazS4neKb2iaW/jehzetKZ7h0P
	V2UmCJsPnQX9HHBot35kuJLvaB6On6JxRtnnEO/MWt/d3sfIdKIaeecq+Sj8v1Q2cLtQ73CELGu
	GkuByqssAVhq0apzvqYhcGdNrBGqVtADY6oN+EzBzzNrO6ok7/Wy4CN9bk74whSVeCATG/zmR8g
	9nWcJmuD9qmpeokGVEclZJBoPBxrTEUBs3KXt
X-Received: by 2002:a05:6402:c517:10b0:6b1:aa31:a627 with SMTP id
 4fb4d7f45d1cf-6b41e05d22amr17510a12.4.1792626266439; Wed, 21 Oct 2026
 16:44:26 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210532.378628-1-shivansh.dhiman@amd.com> <20261019210532.378628-7-shivansh.dhiman@amd.com>
In-Reply-To: <20261019210532.378628-7-shivansh.dhiman@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 21 Oct 2026 16:44:14 -0700
X-Gm-Features: AclHuK__YaoLd3Ldw7IpI9tDCmPzHQyf7B-IV870seKdS0OY5O_Dpscdyo2KVpo
Message-ID: <CALMp9eS3WAZ1LZt-s432qqxkrj6p+RNrS=aym3fx5rnR13tKAw@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] perf/x86: Expose the LBR stack depth via x86_pmu_capability
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, yosry@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:07=E2=80=AFPM Shivansh Dhiman <shivansh.dhiman@am=
d.com> wrote:
>
> From: Sandipan Das <sandipan.das@amd.com>
>
> Report the host's LBR stack depth in x86_pmu_capability, so that KVM can
> advertise the depth the hardware actually supports rather than assuming
> a value.
>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
