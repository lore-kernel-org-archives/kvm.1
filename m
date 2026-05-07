Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23910221FBD
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155290; cv=pass; b=Mu7hoNQxek5hc95XtonQomrz3Nl4j8uhOCbtBHw3LLjGDTDs3pew7gmzZ5PY5yx5YkQfUJm1gB+WcCSuvgk7POfqo6WNjqpXTbDfd81fjH5Z92HLZGOhzSmiCY7CM/b8QT3wbGoXDUlgrjb9jGBKw59K74irmqmZEBjQiudda+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155290; c=relaxed/simple;
	bh=YnaYJ8w6kd34yqFksm5B7jTO172I6eMzgrwpvE9MTNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqQszwT1Vk+J0mRj5A4WfXBLIczf78nXLF6G37UZ0YfQwgVfuz3nXiqZuQQijlcfhD7L+01u6p+thplDzyM9UV6LAR2M3Q/hfw1renGcasXNVzWymPYRN7Oz4FeHKOUTWcvRDe1L4YisopdhOAyLtC0NDMnDbdwNPlBn0iyjkW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=xT0J3zE/; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="xT0J3zE/"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-697bcc9d769so430788eaf.0
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 05:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778155288; cv=none;
        d=google.com; s=arc-20240605;
        b=OHIpkmLpBfCz0uZD3us992I+cOgxooAtOWhSodyK4sWJFhXyY1XF3peE193wziDk0c
         gvqfB2I2s6iat7zGykNuqVSPinNCVmhNAXGMmUKjUDoSmcwU/Ekc4I3h5f+gfTnPo5vD
         JiQupNJJ9Pn2s4m1bLniYlrqjwRjlyc8oq8SaiXT2jI3m0dnb/FXQJpImZh/4ouz+lKa
         C15iC26cwrC2kS4l4vA5BaX64h+IswnDaMgj6C4t+BRtRXRe3nxIgSw1f7otf+2CjtRz
         OCcvgcOcAiD58+fWB6j6oagtU672Aw9u8h6fgmu2EtzDo64jX5zKHmwkkQQB71b57NPh
         L84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YnaYJ8w6kd34yqFksm5B7jTO172I6eMzgrwpvE9MTNs=;
        fh=fm1X5iD5viYtk0aqkqRYrP2naIWC5X/2dGDLpiRLgFY=;
        b=Q6AjlwAcZSsGkdxHj6bqEwpY2KRvZM9Zmelifh9L/sk41d+stNkng5mtIfjV3D7n0r
         mmTjPT/1ooS/busJqMTSRn1fhsAExxoy2YzDTNWX9Ep72W8xXa5qk72RfGyLBnSrQT2U
         KmwJcbPrqYClhwqTjGT/0xjzStE0ALKzdth+QmoZR1qTZfcAXIyTkSzBVuEZJjB3eEqV
         Fw/ZuUKH1JkuMbY1/VjF9f6i+fg1earFn+HN4oEwQg/RVJLQDu/gYoUiwW2vZcy7it7f
         QMPTsARcHkhie1CuK8+KPra+zPZUzMn+0rwDvxM9e2+ff27mh7m2D3jxAl8V8hrNa2Nw
         sqDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1778155288; x=1778760088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnaYJ8w6kd34yqFksm5B7jTO172I6eMzgrwpvE9MTNs=;
        b=xT0J3zE/xSTQwXK/le9EiJx1YVTDpcIdGjyWMFc7HBhtpLul1iB0AEgIMIKqZQHrGd
         7hiCftQD8mD2+EsIRNSVF3EoDCxKIPpe23FDYY7uaQLSEmKpLtbpeLCn1C3swP1GFGnt
         XdFhI3MgFu2+deO5pDMWdybRQDJNP5E0kARNDeXGIK75IZKCoethw+gJbLObdh93yzdk
         OyQ8OdXWRJFE3H34qFoPfcfIjYeLFcoNOGRcT+Y0alKNsGoeDcc76S/Kdzvbq91QJbBp
         nmaPZqiLWZKlxOYjRtMhjXGz4+NeVXVcLVD+BhTptKhWCxAXWzu21ysHYuqlOME4AFss
         sHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778155288; x=1778760088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YnaYJ8w6kd34yqFksm5B7jTO172I6eMzgrwpvE9MTNs=;
        b=TRm4dXOy+9rE4jlUPR0MArR0fhNhYJK3Dwmet31qS7V/ct9pk2EQtKkV5MJi4JzYx/
         1XOOTqP0Pem7Y9/m34zbApOAYuATakVENhyYpWyn2IffjDiCFrPDPqpLBrKis0nERHfP
         xXKEwqrf1sCbyO6k5NfUDW+RSIBuSXl1NabgnDkScI94tYGw3jPExVoq9EUeNRiWS2Yq
         t8ErmW9X6+9aNV0B490hhUqndNe6u+1yZ0DlncKa0vPyKvo4c21aMV4hv9e+0glEGC55
         Ep6tvjfDzqHHwufYxJrzcnzLPDtyQMPIbmsehE7IqrhnJba/9iN6t63/YG6IzYVVZf4r
         TLiA==
X-Forwarded-Encrypted: i=1; AFNElJ+GZFRF2ciGyPEi6l59dugQQePrIr1aQmE3n0fLw5vFhlHyfv3P4gJo7i8DTfIYe55SLck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsFzTN2yr3fud31HE0bsJw7yHA/ZiKW4acZC6zDXOMw7lIbKtc
	04CZ4zNFRAt3WwzQYQWH8o4opbLeoLkOhledmFZbTVuhzQSKyvwoEk+JXKqSDZNgMeICWLKY1w6
	QAithJPZc5/m9IPVtqzKH0b2oAkfJgHvSWP9PbeXqEg==
X-Gm-Gg: AeBDievhOafMChU4cW5nieqGByBKi+DDgvQcsZnuEkPsczLdMfWYGrKCaPcqwekDcTZ
	Ve1k+/RG77LMaiaHkOnNjkwPzsQgMDCpavLzqyDD3vESe18Z7Vqk+yJw4WfIAh/ovIWozS/Cv/F
	BKNVGyHHkfIkgmGL6PkM+1B2geZQsi6P4r15G7Vft45mvlfiztUOcz68dHcZ7Ujp9EsYn45LuuK
	/6INwQBMTivoIn5kXFVQ689zx1SD351JL2/NIETAeDkP2R8f1Kq0EOrY4ecE6aD5WevRd9XzCez
	u3qWCjrCEKNEXPSacBcLWRJE1VPNNsfbDhlu8Rfk5LAmlfcwLJhxPCd02565wWvFc0HsqyO+rwj
	CYD/173ZS0IlqJhunLrrG0bxI2dK3vdVSxS3hxg==
X-Received: by 2002:a05:6820:4b09:b0:685:2a2d:ccb3 with SMTP id
 006d021491bc7-69998ccaa0emr4080398eaf.20.1778155287744; Thu, 07 May 2026
 05:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425005916.3321811-1-guoren@kernel.org> <20260425005916.3321811-4-guoren@kernel.org>
 <87wlxhwr8v.ffs@tglx>
In-Reply-To: <87wlxhwr8v.ffs@tglx>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 7 May 2026 17:31:15 +0530
X-Gm-Features: AVHnY4KEq24Vu_FVNe1O36FY1chK0H9YCsRLUDToEwTAF_X2VUeIt8ykh3nsO4I
Message-ID: <CAAhSdy13JYzqf9mB4zw_NFe1jz9yu3p-JarzUPj7RVK1rmoiMw@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] irqchip/riscv-imsic: Move nr_guest_files to
 per-HART local config
To: Thomas Gleixner <tglx@kernel.org>
Cc: guoren@kernel.org, alex@ghiti.fr, aou@eecs.berkeley.edu, 
	atish.patra@linux.dev, cp0613@linux.alibaba.com, fangyu.yu@linux.alibaba.com, 
	gaohan@iscas.ac.cn, inochiama@gmail.com, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, me@ziyao.cc, palmer@dabbelt.com, 
	pjw@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Wed, May 6, 2026 at 1:42=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> wr=
ote:
>
> On Sat, Apr 25 2026 at 00:59, guoren@kernel.org wrote:
> > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> >
> > With the recent KVM AIA per-HART HGEI conversion, the global
> > nr_guest_files is no longer appropriate. Different HARTs in
> > heterogeneous SoCs may have different numbers of guest interrupt
> > files.
> >
> > Move `nr_guest_files` from `struct imsic_global_config` to
> > `struct imsic_local_config`, and compute it per-CPU in
> > imsic_setup_state() based on the actual MMIO guest file region size.
> >
> > Update the related comment to reflect that KVM now uses the
> > per-HART value.
> >
> > This eliminates the last global assumption about guest files and
> > completes the per-HART conversion series for RISC-V AIA/IMSIC.
> >
> > Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
>
> Assuming this goes through the risc-v tree:
>
> Acked-by: Thomas Gleixner <tglx@kernel.org>

Thanks, I will take this series through KVM RISC-V tree.

Regards,
Anup
