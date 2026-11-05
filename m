Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793920458;
	b=Q7CSLki95fSC62J8oA9yEoNi4rdOAkSSfpT8ERASFESrrBLp4gexl1Egf55VIT+umkLb
	 19X5bonOlPlvWYdI+0Dw7F/h9gpUK9HkfpgFyVWiBUL5lsnAvELGxUmdVkEF0NKzdS+pW
	 XRKbf55o8po2A1dYeJ3RWbOtDIw1sPPvAE63de0Ixb+z6TXYFNXrio5ROJLwmZUdMq6Sf
	 d9K2dKFJn0SzWdBNdfYQtf7mzGqbKeetskvZJZ1lkyAS2vWaT4GCdrNas5kd/wPoLW500
	 1WW1YhC11Ani5IusCfmSKZvuL27SuyvYXP2Sd+iTKC3KQPnghlcZW+tQ3Koe5qoh+UA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
	b=QhrCjijnKYyvlecAGGO7WhBVpkugsdY5yiO8lc5Qlj/5wHhN6llyIciZ8Ez03ZOQqaZB
	 DJYuFv8HtdL9Ot+pA89/FM34DyIhAT2dSs5/Xf77YW1zQrFUx2iPRgNZpzc5F8qXFRROx
	 +qasMhTNgdCfySLNxbp3Oi14Nsfv52q0NQAfiobTWIPbFZpERu9JHOlg3F8sJpGlmjUEG
	 EvXplW8xo9sCRac4Cbp4BKrGOrk2ZYtkVT0ZPUmDCe5ZdtarsLKe8SkqxmZ2ZxzhepKhc
	 jE6Snn2HGshor4mgDnGFtWyRcftCXEHYC1k2Yh0oTntg0QIIcs1ZhOINK4uhn4xW2eQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IU6i1Fwv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BEC606A32F
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47BEC606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IU6i1Fwv
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso42561a91.2
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:14:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920456; cv=none;
        d=google.com; s=arc-20260327;
        b=dQn94T8yXiP5iAsP1IPcldH7JGyHTW+a7rO8LLJuvruGy1k4oonOHXVpFKhtUgvEkn
         L/MttweJcFq6o2u/k53uUKYitOCluRmzhRClwcS1xz6mxoJ4vOuOuvWkczhxG6TwLWx4
         FeQ8gE+JaRnY9AczhC53Vn1vTkuNM+seHbBnEL/20hDrZBclffKFk1QHEZG3eFKwNCWC
         bSDSkaofPnwh9MwlUGiHceyUmUe9uU/447Ng2T/PmOZwzg9odUwvj4piP0weCNvEXKjK
         YX3akPYaF0joPIFnNbmyIygRP6Ay2iKznRylrSzIKWCK/XZIS//Onk5BvpCTZzvgljEm
         T3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        fh=Gdky/fGfsmJKR72Hsgls0zij+ltiyHaUNUWJShCPa+g=;
        b=puQjewH+hmc8CWGS4Am/5yWbhGpB40CG8lN6DuNidClUi5d87TRbFRxHlq8DwZ8pr0
         HvssCJu2zYuewNlGXAdmhnBpkAN8i9lthOdIb0knPHdicXaxsRQNHjASEP7cyZkkBskP
         gYBs2F8tmZPcMpQ1qZeclleh6KQOHTuIvQoPnOKor7h9Hx8C9Q+wCDDzBPDX9jAHs5xz
         XdKeutaEo6OFzZ7aR1hRZpXu1QGExVLemycg7N13BADGpx76ms2v4wBzpAE0gLBj/LqP
         XLHvmyoSW/V53+ylorlOewn6ZXqTj5ZmC/sGM+E81wR+mPottZ91pBjV7GCl09dNYONg
         /vwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920456; x=1794525256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        b=IU6i1Fwv/0w/cks1e2nfs6t6sk022zL/8GvQwys2lPo33xKyfU4+rlcYd/DQAZEHG/
         pOKIazGTVuNB5nr366kMh62Z8mKuK+0wykvjpk6nMnF62dQEPqXhVYv3AiAUQh2yheQg
         Wv57SCnVaPWXfP0Spf5ZrgQ+6Qros/0dGKzT5Ct8KPvTnGxmERS9srU07KlGSKT3u7rc
         WSDGWK1HJ7ZHGpFoQ0kLcdKEj3NsCe6oNqECA6Dmye2YgKsYtmlI/U8g/CwAwltsgKHy
         7lk6f9CpVk0uzXD9qAsG8lDByv90XfisBUHNR3hzhw22DDDhGO8biMGoTBxSg1pPVUNx
         pPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920456; x=1794525256;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        b=AnczbSCyU1d98AGHbK8MTnMIUQ6u/qHOodx0AL+eDLsJRFEo1pvGQc1TIqF0SfIm6M
         Nj0WYUUlL07C8662sLonrcOfrut7kS7C4AQsxq2OuNj3Hs+PTZ4c3kzm2ZjUZ8RYoH6s
         swK/WRkHXIZvc0S5f8yZhpCdB1Ea+FDldZ1ZjUjZCfIXUkegGcwDSP2zgUEwkq6ALKGm
         JGo8Gu0UJi1aOPhv+TGSrf3BlRROFUQ5eeCGd0vLcT3B7BE8Z6WNl1UFAWc8K17Ebulr
         vT+c+mBAcivNwhyOe1AzRU+e8MxFcCsPEYKK/EO65qjeNsErMTv0SuAiKeMvGUxUtTCI
         GHvA==
X-Forwarded-Encrypted: i=1; AKwUvBwawF1ovMupeR7oceFML/maIH5TX2BIm0UebuX8u1/w/P1b3a/XJ9UrneQ8k7Am/3qV3n4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jrpEgMiDGi0kVrTw9d6+f7xi6p2sRfnxqdrByKgVwjwDqWg1L
	zAcol/qHkebqsSwH01Eh6Esk3SaaHA60j6UWh9ZIjWoe+vNPJcTk+MniBoPBWsoE2j772x3JKwO
	KJp1TNGeAzie436Cep5QFSx34LmKZoN4T3BgZmphv
X-Gm-Gg: AYBFou053ROqId47lCySbtnBs/84knf7pVpf8aK0inwoXu61ydtSP8xaxMPjo+qwnY7
	vzn6L9NUFGNgCXXq/5WXDHLPNZQivIuLC1jYaLrZ/JpDkz2kJdnWjD6Wn8RXGT65V1uL5M/eDpz
	HEop2//CU4WcxQ94U18Xz1MEgbu0En6IUqg2mljtZDIC15YE2wYFvauG89am335Fw+q7WQevgZX
	TilbqNwIG474pdldUsOw8NhZDXTiQ0x/sA4ajEuGXPU6J467eN965pSSEDyUM8MVjUwaT7WEm1a
	VHdGQpGa8AzmoFH1oStCr32ANWxeYx9rWXa36cCeaIoMkBAUeJiZudC4x5/mVksAUBGI2bVxX9w
	vA/lP4x/SUfEyi4Ak7eZnXu8nln+LWLANcBtpjoPb8eF03exMXq9EF109aoaerSNhESKs
X-Received: by 2002:a17:90b:48cf:b0:3ad:a462:f07f with SMTP id
 98e67ed59e1d1-3b0db6e8ca3mr534231a91.45.1793920456567; Thu, 05 Nov 2026
 15:14:16 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org> <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:14:04 -0500
X-Gm-Features: AclHuK-Yq9Ya_gmjsTlhf760be1vg51BQVbAOtNinoyo6VpZvAmG2k73A1wV2Mc
Message-ID: <CAHC9VhQcmX09Do8BmY-HYJEWKiw7Tf-ZB=EEr9K6t5dBzk0SSQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] selinuxfs: convert mmap hooks to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, 
	David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Move from the deprecated mmap hook to the new mmap_prepare hook for the
> policy and status files.
>
> The policy file only sets VMA flags and operations. The status file remap=
s
> a single page, so use the PFN remap mmap action to do so.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/selinux/selinuxfs.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

See my comment in the cover letter.  I'd prefer to take this via the
SELinux tree so it can be included in all of our SELinux testing for
v7.5, but if this has to go through a single tree with the rest of the
changes, here is my ACK.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
