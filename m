Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D423A5E73
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269255; cv=pass; b=uU5g+866GGjNqF8u7WXDH/ipGT8HoxTZb2oTbLZ/V75LYEJ1MWEcfVl6mVnxhmzhrYmouhvvVQ179vL4YLDrqGIHD8L21svU0Cd4LfnnFtq9MUq/trulWDe4AC6eDlpKkGFdLxt2Q6jM8McFA4wVBj3WCa3gutcK2KX4V6Op8Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269255; c=relaxed/simple;
	bh=qP9YpmLhqJ7iKLUEJKEs2FdAVP2Ma0eNZKoPVjwl8pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODBoDVA9+CmFFwCevAK0lbx4/delfDUdU0kmov8dc6IEj2YQF23g90YIIv4CKY0sUlaWOAWPjC2mmJTqcLM7N8jn3XDlnScNMHLzrCOPXrcRlfFnVOi+i1Kz6ucCfd4ilr+WxpgWgPUO1BcuuZfiP0wmA4/Y16I3Ibd2H08k4ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qBZPc1t2; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBZPc1t2"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5091ed02c54so1073371cf.1
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 05:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774269249; cv=none;
        d=google.com; s=arc-20240605;
        b=MqDCqH95I0nPyMjTCoSvVj8EwJi4ZSsazA+Grx4Jg0F3Z/19U4mAfUu6UsjvscMdha
         S93iRFGzp2FGX58kuMEL2IoAiztKLyTxzUTCat56hm0UO9UFZc8SrQb4rJe/egGBtg95
         IJCe7o/EXW7NX9Vi0fgMLrAtzBLxTKmjUoy6gKUmEzVsXkERx2OTcFvRRSJmFgbR1H+g
         fBLZIgdHzk7ZGnyXo+43ZVsVu+51u9OdBbDsrggE//Xz5g8vrqtUYdWgMmHnhQq+YjZq
         IJJwnFAgOloZfwaLIa8o/iI9hyY25TDLWcDStS236NH1BUGVGz1o90xJEnlU41XnuBf+
         TyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YDciruzs8Ey3qf1jOS+c7GPDS8nO7KcVc/iFzTYFC6w=;
        fh=zbpNnicEsQV64UDkwoKqqMYa9mrJsqsjKwQ6aoHffe0=;
        b=AtBqAIE+HkU+9pqzQp7NxWCsDvpdqOZIKDi5SmahFvDPvwEMq6PFUwgajVGKfnRgz2
         8gblvpKkIV5i3B2GQkacwOt/7EaN5cOvJAeEa+Bu2CCkXI8DwYBBT+kwOo1ONQBDCgUK
         iCELlutrxe9gtt13e5Bjt1vrhicaSpHhOzTp2XxG/v/4gOH6IYE85TFR7KZxllQpfYnE
         VSJ5LY68g24NoCk5NDSnXCS6NXIeJCpd1rG+8VHO4K569Kog/i6Z3LIJLCM4qEeYamLu
         4bIYPFsQ0MPPWGPBcCu4If183x2Z9rR6xGqGEyW5ZJUUNrZC0b6msnzjLUz4fA0sYsih
         2kpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774269249; x=1774874049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDciruzs8Ey3qf1jOS+c7GPDS8nO7KcVc/iFzTYFC6w=;
        b=qBZPc1t2EzVgwRpzEoAmTpEZNWITYTpeajkqziNqaAnpUsBwhEXDPZistGplziLCf2
         y4DBcuKM3ObKfJdB7iEhqZS8iGRJ5G/XB1M41ESU85GFBi4mo753Rf3bh1z41xD5i2KP
         bqd/l6xUGPTtVF7C35sxj6KLYjYnwK8O0ZZRDqyzr0CByfIsEptclWmEBkz9PS0J6v7O
         fRcWdB+Yw2E9mZQyUH6ab+HYW5CcKErVPxfe6jBflJY4oQF8AvOSI/MxvqUe1p/i69N9
         6Bw7aNVpicC0klKfAvqk16t/y2znvIOM0Qx7hyaGiEeGIQ76rEHU2VCROaT19BnYScIr
         xLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269249; x=1774874049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YDciruzs8Ey3qf1jOS+c7GPDS8nO7KcVc/iFzTYFC6w=;
        b=SzldtkWa9S3/kQ49TIPVc/tlNYjG1wauOn8m8J9IAIwX0lZP9IxTx53pRbEq5QVAUE
         0trUQtOPwGyalDVggpY6ZXU1Dq5nyajp2QP0ctslSlJ6pbO+MKHjxY5M8MI7G99JDaE8
         hpk8NwygB/ShNTbvPWOmlRNKlnF0eoQgrQKBhp3Nlzy72nHrGmmIbZ9P8it4jq6PrL4X
         V9OqH8lesRwDcCa20PttZoPT5CqH4/QMiIXH5MPiy+1Vwf3KvJ1WMLMsr08uwLmLClUx
         mvVOEF/6/J6lchuhBVn/D6KfEW9wW79mJ50rjfOfNKhfoIsYE0JBvU9IyRO0WmaxrFhZ
         yabw==
X-Forwarded-Encrypted: i=1; AJvYcCWzxpsn209/9PQgkFC/GPjOz3l1qIrA7BBfv3Uy5YcWu1WbGo2c0npqr8f91YXJSs6e9OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlXAaZAEcLj2nNZwucjFJLBEs5/5KQa29Rwc3tFiqGD5RgueKz
	uthomfYeW8fINnxasyiNhOpApehPvSx04qywPK09eaJXJgAXh2BiZ89UAtCn2DUMk6lOdIGWn0N
	lvxTiTFXzTIMxJTz/lx6mMyeaYCZuHjBeN/EBMLz8
X-Gm-Gg: ATEYQzyV2y8OsWRVdAhuMqTHoxZaTMH6kX7JDZPs497WYwp5WhS4OBioea78o4Xcs9t
	dOE+fVjOqs0pk8uPLqPlzOgTwDGjYcVazis1FA29I2RjN0SgrTyb9XydFZm0GOW21XuDAnEBWq/
	Xt69Bxz/NOctvJlvZHyaU+kjpw59Qs2Z72I+uCJV2660pp1juz7glpKB/KdV+SjV0cIRLxJVJ1h
	AyP04q9evquf5lpFZ73EzMDT5DvZpgstfeAyYu0AT7AyW84QibScqWXVM98t4qMKxjit3+thkJy
	HM0+TC6IGyU9ZpOTvWb04TdnCTH3v9axNh6F/ul68Q==
X-Received: by 2002:ac8:574b:0:b0:509:25c5:42b4 with SMTP id
 d75a77b69052e-50b480c27a5mr24589311cf.13.1774269248302; Mon, 23 Mar 2026
 05:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321212419.2803972-1-maz@kernel.org> <177426391593.2932170.8726976984414575226.b4-ty@kernel.org>
In-Reply-To: <177426391593.2932170.8726976984414575226.b4-ty@kernel.org>
From: Mostafa Saleh <smostafa@google.com>
Date: Mon, 23 Mar 2026 12:33:55 +0000
X-Gm-Features: AQROBzA3qYHe3s8BaZ2dHYM9ZdaRsKXyWNR-mfM5AIq5nZXyLzrP-udG8vd73pg
Message-ID: <CAFgf54rsCocMTaP=OPfFq7BCwoxQKcEkcyad16BtnZ11XxyKxg@mail.gmail.com>
Subject: Re: [PATCH 0/5] KVM: arm64: pkvm; Rework aspects of the PSCI relay
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <tabba@google.com>, Will Deacon <will@kernel.org>, 
	Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 11:05=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> On Sat, 21 Mar 2026 21:24:14 +0000, Marc Zyngier wrote:
> > Having recently spent some quality time debugging [1], I ended up
> > reading too much of the PSCI relay code and felt that it could do with
> > a bit of spring cleaning.
> >
> > To be clear, this series doesn't really fix anything. It simply adjust
> > things to my own taste, which may or may not be everyone's.
> >
> > [...]
>
> Applied to next, thanks!
>
> [1/5] KVM: arm64: pkvm: Move error handling to the end of kvm_hyp_cpu_ent=
ry
>       commit: 4ebfa3230b40728638a6acceb709f900f920f921
> [2/5] KVM: arm64: pkvm: Simplify BTI handling on CPU boot
>       commit: 1536a0b1386850b67a9ea840e57b7b475e895fed
> [3/5] KVM: arm64: pkvm: Turn __kvm_hyp_init_cpu into an inner label
>       commit: ba64e273eac3d7ec4a2b621b3620c4d3b0399858
> [4/5] KVM: arm64: pkvm: Use direct function pointers for cpu_{on,resume}
>       commit: 59c6e12d40a5b05038b68bcdb4690456fee68e8a
> [5/5] KVM: arm64: Remove extra ISBs when using msr_hcr_el2
>       commit: 54a3cc145456272b10c1452fe89e1dcf933d5c39
>

Maybe a bit late, but I tested with pKVM(nvhe and hvhe) that it
boots/powers off + hotplug through sysfs

Tested-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> Cheers,
>
>         M.
> --
> Without deviation from the norm, progress is not possible.
>
>
