Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55D72FFDCB
	for <kvm@vger.kernel.org>; Sun, 17 May 2026 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779024553; cv=pass; b=OYn/Yuv1KeU85vru1jJWL6vFfIZ7ZdsJCJmZ+Q8LwCAxYgAiFx4aDyB5a5WGp7DOaOSy/IdMjtciqHzyY4GSX6AqDTbzE6zIsxTk4wI2bbky+lGLv6H2fnuYnNHF9nNuqIyBDpEXMbpocaaiKrbEKmDizSE8e3yKPMDeEuRtT68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779024553; c=relaxed/simple;
	bh=yKb7Osmer9sr0Ti7I6iqGMluoqlrfRdk9SK0rDF56Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5g1PHszmIPUlWGnMCrR2sS9fg9Dp7vRb1o2THOO6+3HlbF1zCUgow9rWn4Tdn2yDxkhxZi5p4QAGGY3YpPG26yvI9uCpJJcktTvi3bwmNibF+8ryGkQlPDLOyQqRhmVvfaaFSIz8ltFD/+/BCRMlgftuiZswnF5ADmBFv95qUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkAWy7dp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyQignPj; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkAWy7dp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyQignPj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779024551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKb7Osmer9sr0Ti7I6iqGMluoqlrfRdk9SK0rDF56Z0=;
	b=dkAWy7dpiWVqrIMlMATOqT2PMrcbozUugB81K4EKGXiqdKD07HNkaON9AWWQhujls4cxjh
	kEtX46WEndexNVREoGzq2J8BozlitsH+QV3kQ4hYuXaLQ5tlrNwTtTjZnzKnMhRBJRrYVz
	waZwW8VuonoX+lnBR+wTw83nap21gHM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-OG3GwMuJPo2flYuHe7n1sg-1; Sun, 17 May 2026 09:29:08 -0400
X-MC-Unique: OG3GwMuJPo2flYuHe7n1sg-1
X-Mimecast-MFC-AGG-ID: OG3GwMuJPo2flYuHe7n1sg_1779024548
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43ff19e54beso893040f8f.2
        for <kvm@vger.kernel.org>; Sun, 17 May 2026 06:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779024547; cv=none;
        d=google.com; s=arc-20240605;
        b=CdX3lBNxH6nYc8O5x355DbCTe4hBJm8LoMyda/FcMKEdMKC0ibWnTa+OKymkME8uXx
         Ogipc1lJ8TM6MeWdURm1tVhWLBh7uBhJO0JemhP+zJ/k/UeVoz+0CaCBoRiCK/8/W/ml
         nxCGXPfZd743RHvRrOcuFSYGRf9n0vQ4u+LfRPuD7DcK+kRuohklYvaaqghb47swdjvn
         13t3j7HdxmTrX8AgBttVQa7/VcN5r28tQECVNd+v8x3ArRM7s9vXkZa3bicQN8R7+G7H
         SYX9dUzJ27QxDslxD5SBb1I/nq9slw7EhcGkL/ooI4ML9IyXz1uYlLA/P3qF0C8m0Za/
         2/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yKb7Osmer9sr0Ti7I6iqGMluoqlrfRdk9SK0rDF56Z0=;
        fh=s/n3pXbH04czH1AElb2CMAuOKq3pMtGJiC444n4ONIU=;
        b=cfqkPeQiaNKOcUVMZK960EN3yhRD16KA5qm2GjABgMtE4v9u0m3M26DHVbuIrOfr4o
         ym31VH0mX4cIDcgT+lX/HpoIMGhwBOI1OIjG7Mbq98GK6DaR8zCgGEGgUh6kwamJO4oQ
         mXaGGAHLNPNMzzKYj79WpJKBL3yz2PPe/A4VI15D5bmaIIHeJ2rlQgUWeS5dIJ9OEpvR
         5Kfy+s4NJvPTys7Zl13TcRa3nTOEuxR9rt80D/n8APSroLIhJxCdxNq54+A57znCGUIu
         JU6ob9DR4Wc4m99M4JJWWrEi32nnihBwspKt0iZA+bGcLoIl2WwscACzS2znz0815PnD
         oECQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779024547; x=1779629347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKb7Osmer9sr0Ti7I6iqGMluoqlrfRdk9SK0rDF56Z0=;
        b=eyQignPjC5u5IuOusKahlihBcQbTFb/NRf5TOKx4j1eanB1bYsC8FogJdVqnAEQprG
         K9DatOY75BKkjqDKxsj0p6DrMP7Syvu4XxS3PYFvxVlHT85OUT0IfFj3NIwXpNMNeLST
         q95rMtASOvIs15e7GEFKouHt6LtqJEoafiVAQT+nA7ysUXY8FPU19pnrM46l7d50R8t5
         R72OEkOX/h987QmmcfwaiH7Yn3NVEuQwnz/2QB25299q90YmVn2tcQ3Wfxi57EF30EH1
         nndl+SRHS8qVUgPqjpLfJewl3WLutsXHBCaPdEwVa+tzkM10ETQAHXbiDb4VKCKG5eZa
         5T+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779024547; x=1779629347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yKb7Osmer9sr0Ti7I6iqGMluoqlrfRdk9SK0rDF56Z0=;
        b=OO1FwZzMYvTRF84pdvB8UgOxRwkFoSjQ91BeIKGGkf/JoXizbMzBV9VBRdZapkLRUQ
         XSXaMOBbU3kxEHzt2NewEE4EkTXf2EDdnjh5ycmxya6eXEcO0T+KQxo49jiY35X+NceK
         pdDK0g4K0fCKZ2Es7/Z5eqYLqrK/od/SVMWTkzGRzUVchP6pUXOgJU1Rc52iX5PLx59+
         W5lunSp3SOH7v1GCUNCaW/nxBKdEES0w0Qwys5DJcDwJMx+UDHIxjAE/ke7xJFidpoIV
         aaaapkWkhRf+c+qlJ0683+ukmsTS6XhBXgSSiNE4vjwlTZn2krD4Ko0GDGVcnMUhdmDT
         svZg==
X-Forwarded-Encrypted: i=1; AFNElJ+arFjx6zpUXed+uATXgTDHmQt6gtvo2y8ZEm8/22j2gtxTGj8j3wUu0yInZxMA+PAMOG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFsyvVrlA+8+H6Hx9BQ3WbXoPjAYCb0wRlsGpUkb4uupo7VjtN
	Ejt+wY/OQZQwb3dYHE/Gb4fAtQnUU44nvnSynSXN/8f/wH/eyzGfaCyT4xMQXz6FAGFoPYI4nKd
	IpfRWfNKoS4wv6shXtBMDO45n8u17+ASWS4WCygdxC/h99R/tTPAcB33Mu2IIK2UbF37xsNbpOA
	DbXWqD13zEy/z9yhiXM6SN7C+4fNiu
X-Gm-Gg: Acq92OHpRcGDQdPwrco7CUZ+4SECOrYVKzoioS2RC9Z71R9ATu+gL4LjjvTOggXMAUm
	pVCY+VAnPKzNoPeMHDYl6JqAu1EJOAH5Apg2h+EsXwUKaGeQSHbmTeKG3Z8h+iv9l8R4gaQyz0D
	pp/CBlcJJwl2F50RZq07igybsYzKO2AzXotXlwWZp5KMz0yXkCdEE74nPMoqtE5tXzKayavaPBR
	WRhgZ8xXlya3KCS5z2m5tr5MNSvf87yiG7fsJNEmpYqkmf9IF/+wq6EBUW23yIqtCKXk2xZ2s5P
	iNpyqlB5
X-Received: by 2002:a05:600c:4685:b0:48e:5d91:cfe3 with SMTP id 5b1f17b1804b1-48fe5fd494dmr165423555e9.1.1779024547649;
        Sun, 17 May 2026 06:29:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:48e:5d91:cfe3 with SMTP id
 5b1f17b1804b1-48fe5fd494dmr165423205e9.1.1779024547283; Sun, 17 May 2026
 06:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177749023441.304242.8022456530166067549.reportbug@mspc2024debian.lan>
 <177902420697.2035014.8796825668567298024@eldamar.lan>
In-Reply-To: <177902420697.2035014.8796825668567298024@eldamar.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 17 May 2026 15:28:40 +0200
X-Gm-Features: AVHnY4L2h8IPRcfmkGoiaF2GGAN48yDsSxx5Sop4dQotSFnSMOz8PMdBSOSPpYA
Message-ID: <CABgObfaUE6wKKiSXSg78pjo886Yd-L6W3pxkyOd5CpyHv52P8Q@mail.gmail.com>
Subject: Re: Bug#1135235: linux-image-6.19.13+deb14-amd64: Reoccuring host
 crash "Invalid SPTE change" with gaming win kvm/qemu guest and device passthrough
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Maximilian Senftleben <kernel@0in.de>, Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 1135235@bugs.debian.org, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 3:24=E2=80=AFPM Salvatore Bonaccorso <carnil@debian=
.org> wrote:
>
> Control: forwwarded -1 https://lore.kernel.org/all/177902420697.2035014.8=
796825668567298024@eldamar.lan
>
> Hi
>
> Maximilian Senftleben reported the following in Debian (cf.
> https://bugs.debian.org/1135235), it should be noted while Maximilian
> uses the looking-glass application (which is acompanied with dkms
> modules, they are not loaded and do not tain the kernel). Do you have
> an idea how to debug this?

Hi Maximilian,

do you have any idea when this started occurring? Can you try an
earlier 6.19.x kernel?

Thanks,

Paolo

