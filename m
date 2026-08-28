Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56137AA8B
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787945340; cv=pass; b=BQF0rwS6dkj3pvkYlhtuJq9iszoTeV0vPx+PrEN7krjqYFSG61ClsFRqOW+O42ZjWRcohEGBBh45qI3bci48qVLNPodK+hOJdTDltoLsKB/gYeupwmsgmQGrLHkAA2c0666mAevDpoE3R0IANJLBW4sBekv7hvOVrDVd7Keql3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787945340; c=relaxed/simple;
	bh=fHmMOkDnc0DAMDW7+UXClup/98JMmn4tO04WF2LBRAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZHoGEmQ3votMTkIyp4QsI0SP2PAF1xqV98T9HjDB4FLfGHwZpzceQj1h1HmS11KQAeV8E/PfQ4tY2YjqnxoDhcco9FvSU/5tYKDjjCr7uiEeuB8UxLO3gzj9dejh05UNw6DB7etAlzwcUb9GzxQQ2vV8SAlS3LFLEVXY2iWzCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPLmx28I; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPLmx28I"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52faa58bff5so40751cf.0
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 12:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787945338; cv=none;
        d=google.com; s=arc-20260327;
        b=km7zoyDhCLg8Uv97J7FRxOkcc3yQmNsCmoZM/4lHwLx1aJqZjuPP3b2m5J2x9Y5s5j
         MNNhKAHxFoDgRpgG7Wc4COR+3jUzhHsAgQlLKR0THoQtyd58xH7OB7pGqEhCMQURKBUe
         5v21Ss12t8VSZ8yeNxj+by9xnaVYMZbtUfQh0XrGhyAhR4OvriPrzitdg/LR7lakRUA9
         jy1L95iCsiL4+RhGwLSxGS/Th1tk1XdYMz0MB4RLn/vCcKoWkfFTl7velX6QhTWXncQ5
         wg04OpIW+Jl0mV9KpEcW/YNvvY/xjuK/PlM/Tu7r6q3kCJFmm1tp7bit+2QQttPNEQdK
         m01Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fHmMOkDnc0DAMDW7+UXClup/98JMmn4tO04WF2LBRAo=;
        fh=3hAW+5nceexMQBVZmzIpfzHoDCru4AnThFf2X77uO1s=;
        b=idAkP42uaLDcJ19YmluI2s2HBWDZC3TwMfnuMXeaN+xeKYj5ojV32fEjMhp1TD2SMw
         JVrXQ9DhRXew3snqZN9k2P73UxD2pYIOZauTFKQ5gbbXkVwRG9waZNoMigECXy5diNLQ
         7X7pezDwalqRlDYyU3vG98/7riRvVwbTGNBkkRyP+tBtPKxoHDbtywfim4h0qEgv3XXT
         ValUTdByxruDeTJCZVzuAsW9xAdbs9jXGztWJgMfOQW+vAAuE175wMy/awW9g/+qdDsS
         xdEEYSSkYpkdF6Ro5VVN6XemkzKG6wriUbvq8TKbwCb6aWPivILt+KvvTwurKjtaQ8me
         bV7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787945338; x=1788550138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fHmMOkDnc0DAMDW7+UXClup/98JMmn4tO04WF2LBRAo=;
        b=tPLmx28Ikq/AKKwVgvg6shpzmukqJJ3cGhEZVGAL5lKJ3KCnR3F3y+8Zl7z2rjdd7D
         ljanT2DvUU1M9Jv2CNvf2xLopGbzaqif3LNCjat5MweDLZR+4rFIZPfDI3I6nKSQGuXt
         VU1D++KbWezknV2AXXYwdeFZVpUWaQZEhol/mPajIdTXYqttCpVeuI8pRN1xnGeZaeEi
         uQ6hY40qnz9PYnjx7U6YAoyFwUVB+TK1pknBpmU983OLYspja1KhqYkU5YcYTsNAIfO+
         bK1bfPXtbfrwTe/1sXwqZL8/x24zhZE/pEgL8D5wBlnk6PzxU1jhXUUbmqNA/gxLGxma
         olKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787945338; x=1788550138;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fHmMOkDnc0DAMDW7+UXClup/98JMmn4tO04WF2LBRAo=;
        b=W7ghk8Da3kM1Oz8U4JVCH5NKcT97wjmKXdFcsCPwopJuteZIvC70tX9igOGtL4lh4+
         E8rUpJBOu4pQuu0oBl3tlLh+oQZ/UpOqFNivOuymyTmwkNt7OlnI7Ru2OdjHDBXxBI/u
         B8N9zGTkN6mrql28TLHvMkrlcz5jf2wySgIInQlvZfXUa+Cn+w9CaxGcXxKydcAZpXn+
         eYAO+Us0l3HHnjiqNwKjpDvz7AVywym1iBIdy9qNDTTBY2JMbwld70JjhwXEWQ7tkAVf
         VN9qr38h4KDDBfzyXJzyqTmD0MuhfH9FO+2D5Wi6OuNCsllEDp8EQ2fPSPtjIfuHGwCU
         R76Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp/kXnOhfd+pg/OTWJeoNTJAQmUmNXr3BbkeRC5wEkZzFISE370doMkS1fDsfyDuavmDjE=@vger.kernel.org
X-Gm-Message-State: AFuF++n9FkEBpQ2ifuMXaX1gg6rWw9GRjeRMPFmcdcpncOJr5T8jICJM
	vIxFiiNDtOF+173ci5yMxqsy/rHbFMEqRuYYhdQlgF2uLVSmEExoIP8tMlotRpTsoynq9k8LTJ1
	bsMkvY39/CvgsmsdAuRSHShcxvD4ZuoLmQRaqYpKm
X-Gm-Gg: AR+sD13q8KUpS/W+w8GBXFFQhelmttWbzdozgZPHhpFkF/W3+It4+s2mvCwBBHvjOdc
	dVQQe3sqWYIaBcyO/cYu5bPBA+1hf4ekMbwzuDof9R5alzOgABmWpPQnlsME9o7ql2CS1cibYVf
	LboqEYZxSOGiqeEKMDbR0v1QoHwECQjs0t8VMHa6uQhGIc5x17zYWNEcFB1jPvH62Ywij9vFZ2Q
	GeDWeyfCzDZ5/7vg1LRTD/IhhhRcQwvBW6WtnHYfB3kqJ2kzMn1gLeLGYF7Ox0VWSHoH5aeYYck
	l+lL10zETLlLNB4RbkMS8P5xOdLF20ZByRozL6tDRUY7UscE6h3i4Q1lbtOx6P444w3KTXOrFDY
	=
X-Received: by 2002:a05:622a:c18:b0:51c:ae6:a57 with SMTP id
 d75a77b69052e-52ff715be0cmr2273411cf.11.1787945336495; Fri, 28 Aug 2026
 12:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com> <20260806020850.1221381-2-rick.p.edgecombe@intel.com>
In-Reply-To: <20260806020850.1221381-2-rick.p.edgecombe@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 28 Aug 2026 12:28:45 -0700
X-Gm-Features: AcwNN1Vl_L43jPWnHgUrkMtGPi--G2PYnVYEwuFbR2C4J7lwt5ES-sPxDWtK__4
Message-ID: <CAGtprH8JLx886qA4rVg5vCKg4M3u9sdEfPig_CtL1kbfvj5B9w@mail.gmail.com>
Subject: Re: [PATCH v9 01/11] x86/virt/tdx: Simplify PAMT layout calculation
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com, 
	pbonzini@redhat.com, seanjc@google.com, tglx@kernel.org, x86@kernel.org, 
	chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@intel.com, sohil.mehta@intel.com, 
	Hongyu Ning <hongyu.ning@linux.intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 7:09=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> For each memory region that the TDX module might use (called TDMR), three
> separate traditional PAMT allocations are needed. There is one for each
> supported page size (1GB, 2MB, 4KB). These store information on each page
> in the TDMR. In Linux, they are allocated out of one physically contiguou=
s
> block, in order to more efficiently use some internal TDX module
> bookkeeping resources. So some simple math is needed to break the single
> large allocation into three smaller allocations for each page size.
>
> There are some commonalities in the math needed to calculate the base and
> size for each smaller allocation, and so an effort was made to share logi=
c
> across the three. Unfortunately doing this turned out unnaturally torture=
d,
> with a loop iterating over the three page sizes, only to call into a
> function with case statements for each page size. In the future Dynamic
> PAMT will add more logic that is special to the 4KB page size, making the
> benefit of the math sharing even more questionable.
>
> Three is not a very high number, so get rid of the loop and just duplicat=
e
> the small calculation three times. In doing so, setup for future Dynamic
> PAMT changes.
>
> Since the loop that iterates over it is gone, further simplify the code b=
y
> dropping the array of intermediate size and base storage. Just store the
> values to their final locations.
>
> AI was used under supervision to collect/apply feedback, review code and
> workshop logs.
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Acked-by: Sohil Mehta <sohil.mehta@intel.com>

Reviewed-by: Vishal Annapurve <vannapurve@google.com>
