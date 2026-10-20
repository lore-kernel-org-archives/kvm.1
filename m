Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792501133;
	b=aoEZaZuM4wEFpTxxCF9ncXESY7GlBgcNpIZ42tAf13ujvALzbF5qPgqdi1Q4d0BYcdJy
	 NKPof0YqouwhYflD10PKo7EfY2QKQOgeJU2dqvwIkZzoXCdFcS/UtWy+/NOEmCmY2a8O2
	 3dMVXHVHGjM16PL2Kza+uc6YVRO1OUrLKglvFtV5KsM0t7N9MAAmy+tMxQUum1MIF0LUd
	 HzIFhoXOzakR5iOBujNBqGw8mPWh07fk9v9uuybN70SVuIXYnulBb+hsDRfJtDYJQcslt
	 apv08vMqmFDrjj6da5TDl2tULXL2m6qWUWZdP3MIzUQv+yqdhto6ek0zRyZZUyc/VzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501133;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=VUxthBqiZaOd+FFznks+MirJZVKuej0EZmOWkfi5vpk=;
	b=31tblATtu+N4qrGkFTxbrvQ8/MCBXz3OoykS7A6DmRkUKq63TVWXV1gIYXV8/tdx+0fY
	 HjPTPKw8017VN1678ddFBMvP9EfPaqEZP4U1dVKMQ+qSl0/hRPoIXN7s7hnRJ6tb/gtSO
	 L04aeI1i658nT0bBRkqRWIC+R5NMwoiHgloOkvnXFrpBGYkuvABMEAvdFmwPSIbVBRYme
	 TItdmfh1+zmt2t6QWiSKuG43FvM2B3gaIA+6FFhS753/iHfSQXemHqtytQoYyqe/ETTkH
	 b5qni9YNk3X9OogJsrVyJtp1QEHN3FulpdNLn0dq1gpl0R58NBnppwvuHPcNBN3FvaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GA5oeREv;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Wg7p6buZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB51606A31C
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 12:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BB51606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GA5oeREv;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Wg7p6buZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792501132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VUxthBqiZaOd+FFznks+MirJZVKuej0EZmOWkfi5vpk=;
	b=GA5oeREv5pINVVAEDQB1JeZS4rvjNXWDxum8IzuUhGqxjP4+Etqv+xKpTUhyCVW1lstdTC
	nVKqDUtHqfawx+jG9yGdzM3w5CqX2lIdri4pv1EWWqybKECrB3B1btXi7Lqg5CYwLclzzw
	2nygl0CevQpV6A+tXhRoWWB9HjijZgk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-dLNTZny1NAeeIZAffF8FMg-1; Tue, 20 Oct 2026 12:58:50 +0000
X-MC-Unique: dLNTZny1NAeeIZAffF8FMg-1
X-Mimecast-MFC-AGG-ID: dLNTZny1NAeeIZAffF8FMg_1792501129
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c4445512dso2862864f8f.2
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 05:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792501129; cv=none;
        d=google.com; s=arc-20260327;
        b=YyD/zZKP60wA3LI/08ein69RziyE6K6reBLEI0Oalqjg80b2KhwTxQAmofFjlRZwxG
         csP9q4hVBtJMsPdUDJEnlnzQPUXVBuc6IhPX1CfFw8HNrHHkxCC/BYm5RIFhC9cAhzgy
         4kXtoMBJ/SZF8c9ftt13tf1asglBoxgSYuLaZCvh8hp2/+fxXEIyFMIOJ3nFFrH50jn8
         kCq3TeZ8G5YknU3anJpjG/fDXN2rhhCtLd5lDXR1+CLp62o/ZfX2gSgXxpCWqDF7a8yp
         JHspaw9+qTAbWiq8qOHwqmKQtNZXQf9bMtnfUTUXQlU0Xqbi+AZ6MpOEwGd3cR/5LHho
         WWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VUxthBqiZaOd+FFznks+MirJZVKuej0EZmOWkfi5vpk=;
        fh=4efFLAMYchlJ9I5E3aTdssOmKB/0gMgnjsqwjSoGJnc=;
        b=HF1dkVxUnScrFdCMFrkb7iArgc/f0ueRqDwQgkusIMyisW5ND9sb1UHma9IrUvdoHQ
         nwYsCHlmLRWT018Z2lVKDQdQI/NF79iuVAn11591sPv+/xdXa8oXsosyxvugErrIJvCz
         m1boJ61NIuhmfDOZNeC4VkRCgceKGTYsI/RejPOxcFil0NFru/X9genaPbpMMIdAvcw/
         nmuSUYUqkii4EyOXi0HEFk9ciY3XkuLnRllNdLepFgtSKibD98GbIJnzFadEz7zrrUWB
         HKjSaCTcxRadzKlRWhi3u/lrQo05gsNchHGjblnmvPahWE4nZbnbUhtiCpUoYYkZXlLD
         pCOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792501129; x=1793105929; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VUxthBqiZaOd+FFznks+MirJZVKuej0EZmOWkfi5vpk=;
        b=Wg7p6buZuipxNpz0ZdaQxziAT1GrbeVjckzLhmLQDo1l2a/gL5BbVaxUHuLM0r6TMO
         RNZYYxsSb1i+ZA28kk8sMNdPWY7EFnRRbLUkjav0ea3idgcT8vSyK2vcxgUjomdUnQqG
         LBTw7mfTU9TXN5TUed1lmm9irUxsGt5/IP++bJBMnuTMdSvJ3gji6Vr46pa/RqRNFtOr
         tSgFBuprcnq62amlw4EeoSpryudQsEkWcUjPZ1Bi50kFRMSATC1PVdTXPmibog1A1qhj
         cTl3yqaTbLSS+9awdfTKNV+shJ5h/WI7lT7HYAJKn4+c9tEIFOke9N7mMj2QzkTIYbOw
         M8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792501129; x=1793105929;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VUxthBqiZaOd+FFznks+MirJZVKuej0EZmOWkfi5vpk=;
        b=cLYyuEb7nu5UoCFM07yZI1iokWkz6L2hTFyfYKdo653Uj+uxUdu+X4c/dy2vppYB2b
         sJDPbv1z64MrzrlMKb1AOWPc7/ynwJBvmvZDo0PLAkBcPLB4hM9z1znedfrEylI/+h75
         Bqw1KCyOxNcdWYTnYpWchkjoFeDEuTN0m1Hq3lawQl514WCd1cYI/slqF/e/iZOie8q3
         DOMI/TvcB4oqWRewa/rviX/bA3RR5XnN21AzhtoFSpNb/8mV5C7BxvweFb3W/TF0OfVj
         sDo44Xil5rtNxodLBmVeqSQNo7ENNBdtTrWSAeE72MWZTz9gTU+3JRZh8aoP944sYVSr
         4h9g==
X-Forwarded-Encrypted: i=1; AKwUvBzvDKrewsVPNmUU6/QVNsFIDZtaIby+kUlcHzrmczn54X+NZleJm45JPymdMV6ua098+AY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUH29pCdLgBscjguEn2mQW1rj60BOCshrHtpl20VVoi5x+9emY
	6tdw7w5hAXCyJWMdA75cehlG7ncbnDYnKlPAkt+ISlm7ESwyTd+6AEZoSjturEKkKIrCVGF/NBi
	qSgsNkUYSpa7t5F1aNEl5/XBPaQBbwRGuWqAATT6zA8TkpbRi1lXWYWbCE0VYRiKUQZ5T6MwbuH
	TmVSHuqTH1ff9N5JIwvmSF/b4QGoCI
X-Gm-Gg: AYBFou0mA9KcZ7AxXr6PN78L8d2+B7a1D/k0kA9362wGz86Mzkum6G2GCIir38LEsCW
	iQaCTXjprbq3emYnkK5DfJwf3/HTTOHNVybervk2u9WDrwdsaGgL/Qs3ohh8PG3yKLaN4LqOeOu
	ZO0Dal1n8NeAFqIhE7cbjfVLF2NrplXE31UmxBMRgt9zvC4pUCB3YIgUjMhkc36PBOm9RKNaDXZ
	J59IRll34MkBOHmiaeMjHGsoxz4AHflK7a1YFrXReWbm80Jlh/7vrDIiLW6iw==
X-Received: by 2002:a05:6000:24c5:b0:488:7b66:140c with SMTP id ffacd0b85a97d-48e07bc17f7mr19463053f8f.28.1792501129587;
        Tue, 20 Oct 2026 05:58:49 -0700 (PDT)
X-Received: by 2002:a05:6000:24c5:b0:488:7b66:140c with SMTP id
 ffacd0b85a97d-48e07bc17f7mr19463023f8f.28.1792501129183; Tue, 20 Oct 2026
 05:58:49 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <atdeLNa8rtifVnaV@sirena.co.uk>
In-Reply-To: <atdeLNa8rtifVnaV@sirena.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 20 Oct 2026 14:58:35 +0200
X-Gm-Features: AclHuK_EyXz6S57-dKvlnTp-wiyLvlM_cIx0foL-YU26mYTOQGN3J0P1sUFgOR4
Message-ID: <CABgObfZJJ8WF4cYm-cqYY0OOBs2zJCBV54+c3YVjCaBv_CiAmQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the kvm-x86 tree with the kvm tree
To: Mark Brown <broonie@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, KVM <kvm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Il mar 20 ott 2026, 14:27 Mark Brown <broonie@kernel.org> ha scritto:
>
> Hi all,
>
> Today's linux-next merge of the kvm-x86 tree got a conflict in:
>
>   tools/testing/selftests/kvm/x86/nested_x2apic_test.c
>
> between commit:
>
>   994489f04ebbb ("Merge tag 'kvm-x86-selftests-7.4' of https://github.com/kvm-x86/linux into HEAD")
>
> from the kvm tree and commit:
>
>   8b0aa41839602 ("Merge branch 'selftests'")
>
> from the kvm-x86 tree.
>
> I fixed it up (see below) and can carry the fix as necessary.

Oops, my (harmless) mistake in solving the conflict. I will add a
fixup patch to kvm/next.

Paolo

