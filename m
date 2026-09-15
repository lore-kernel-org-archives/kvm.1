Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BA54499B0
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500939; cv=pass; b=FvIH97X2syvEa4zpArC+vqwGfZQ3B4mtWWijl99EFF2tJzTt6fZOtfmwFO74aXeEw94Yt7SIYfQMqkuTGxGGj64cZLjioHCCH7mWQZOhnqAVje7DfmkDDLtkPGGYjdWtJkI/AcbVvmnI6820rXfkwi2n+xlyIRLH89n/Ezn9v2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500939; c=relaxed/simple;
	bh=9iP5wCDaS9EpQ+gfjMA3+Yk2v+5OOuRQACmgXFd/pac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccx4Adf/b6VXIrEK6e81aqlybpD7WkFQDODaU1/5giRTkvrnBrqzXORJTE2GhduJC2eY80995cjdaQVb/b77qSFjAG8FQcTb862vyVKt5y5XbC3zF5+1UKApnCEKGL/Pzw2+EvyoL5JdHvf/nzpxFbmV1i3ccJCTwByk4nzs73k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YOJyBI/H; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YOJyBI/H"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5da7416f9so1728861fa.2
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 12:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789500934; cv=none;
        d=google.com; s=arc-20260327;
        b=Nnlji6wEb4h7fuQ21feJvrtwV96UfMeEwH4LeDh6NzgmMqk5ZMCGZ2rBNuknVy8mNd
         UBADWozF1vcV+HLYZ2C2n4DTiYv/22EH5kdU1adZnpWifIMqF1GVY72sdeIiz7ggRKMY
         ALxZQgKx2lcPRbqWTN9SNU2UDmKSqmeFhHitoQoMPuSDr55rfHNdBFZvTOsm7GCZGKtL
         PRjPgvNDJEKEDoDXAZpgIzKPwKmQc0zz1YrpdMtjW13L/PKj8RAv6hCvK/3UM4xk9W9L
         no/Id2vDugQIaCI+qsuddyTQP74t/Y6ve/U78kaDeezswz0tghgznkNhrIZ88xrHyhG3
         6TVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3sluWAJ7si51ldKO+IEOlj7IVd+xFNM1gnjjRPbQIZI=;
        fh=kbBd0KhVOqRJYNEu5Z9zuMmro7ujZvLg2Zx6vAqOwmA=;
        b=kw0YZYH4UFRB6Prt5hArTKpUQVf3dNidaa1bHf4vZzbbQ+YqelwTsi0EySEbts502s
         +Donag6bUIiyDNjTWipiuw6jx6TnFEEtxeIPm5T/s3cJolprnSX9xaL52SEK2ruVYIHP
         nXI297oewGVS7966GYEi5JNfl/0rMm+hV9U6BTNLRwj1D5Y0LeCd6UjsAvgKmwsGU+QX
         td6bcOXYBM6+k9XBcV80CxdB3k1uydLeVmjOjCJ+yIn3Gr5A0peZr0+ZJvE+D72CqKHP
         w1hjH9cxgW1AJKxBeasujTHaqgkdUoKyAZHDRRjsiAD+gRzjMqOeV/QOs0ukiCkM9gC+
         jH0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789500934; x=1790105734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3sluWAJ7si51ldKO+IEOlj7IVd+xFNM1gnjjRPbQIZI=;
        b=YOJyBI/Ht21acNqjF1TCgtq//JfEi8GDdXUUm6NH2onhf1B+QgxuPDme43/lT7bUDR
         fdHeZywLOkoLDp0I/BzWmRgK+fPga7xHN+NQb1KQxkyL0OYvZ8vEqpeCwnUs6zi7Ou0K
         I+bvymGQ0xY9/w3vHUy9UL0ttMRoeYKszjcZyuP8mRUFFtZvwaWoxgsr8jXIXsk+DcV2
         OkNpXbK6I5+0zzMSE/n1WU6ZrYaoEV/G+8fLBeiWRsFPdyPoJ4zDP5sxkYr5szzV7KqZ
         XX+aFc12ln2KgIZZD14o1DwTG5UHOdECn9yiNpj7mFUqyp7p7xZzm3HpScvWyq3yexrO
         aWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789500934; x=1790105734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3sluWAJ7si51ldKO+IEOlj7IVd+xFNM1gnjjRPbQIZI=;
        b=l2EzJSG52byKMtpYwsTSY4oMxLWHafOzuv2sKIBOX4h+dNOmKZY+f1AJ2C/+zrhlPZ
         4MD2YJl/IIeUt+dlY8ENNEN+PZlYgtMUyNBl9JAuripaRpipV7s6zVPzqLoqeaXGJqL7
         tMCcBasDS7Kr6zA2SxeejEA1H5TInCyDToMx6a4mgVrZzUHsdQfGjbBVLqAfKG8U2yc0
         LX/p6i1fsenQtkBeaOwAUyBBYebjrgGa3AuVLMZCui+GKHcAu2a2o0N7GMlhosPi3q2L
         F7rsbelOzhG34Ak9jyrwJsLs+uq9HMGd6yVDs/GiGyIoAT7ARCTEAajm/KE+4Uw8SWZa
         v1Vg==
X-Gm-Message-State: AFuF++kGWv8dLNL2GilX2+1ppIGKk4piV0/aaf7k9vqHZRDgmfgAC/0P
	/Q/SDIXg/11+BfazdFp9vTQU30uiI9eLVnSo9fGmJn50lcY8EUFkSyf6PoLtBK6YELuMbSUadyT
	wXBiGyTQHqRKjwukN1nu1EiFpe5Yzb17uHZypGzme
X-Gm-Gg: AYBFou2sp5tT6CfD99xNuXj++cFI0/xorf0BNhG9iUzrSmTd3oYm9Diu2IT2F3zDIqB
	qGCGV90NLSAcPEGOkXXzcily1RFn11loOPHAricl09dIjdW4tnO0k+hvTcKaVGj8Z5p+Nn6UcX4
	c3qgLucdFzRoBDjuR30uSJSReJwAS7fUgv7xRnSC7fkjVX/XOx7bqJa4VjxIY1HjQO2Eu8DzqYE
	qa14Op7IlJuvS5qb9RogtcwJSAgFi2hqMzP8JoI8WaBgDQTX/VymQmwK/oa6KCFyYuaHWwmIy2k
	hioPSHHl1wGHgC2vmzgEe1SrQe8SRbLLiNOICR5reonOKUrxPWzh/MMq6y9/dA7f
X-Received: by 2002:a05:651c:a114:20b0:3a4:9e46:235c with SMTP id
 38308e7fff4ca-3a5c89b031emr21060911fa.14.1789500933920; Tue, 15 Sep 2026
 12:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912083611.2513845-1-suzuki.poulose@arm.com> <20260912083611.2513845-8-suzuki.poulose@arm.com>
In-Reply-To: <20260912083611.2513845-8-suzuki.poulose@arm.com>
From: Alper Gun <alpergun@google.com>
Date: Tue, 15 Sep 2026 12:35:22 -0700
X-Gm-Features: AcwNN1VS3YvKKCCRg1vDnBVkoWj-7p2fofNqSox_wrQ014s5kEA5YUvjF8gr3LY
Message-ID: <CABpDEukTAc1m=g+rZRPPqaTwrvhUJPsFRWpFd0PxZsyWw5mR=Q@mail.gmail.com>
Subject: Re: [PATCH v18 7/7] firmware: arm_rmm: Add wrappers for Realm related
 RMI commands
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com, 
	linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com, 
	sdonthineni@nvidia.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 1:37=E2=80=AFAM Suzuki K Poulose <suzuki.poulose@ar=
m.com> wrote:
[...]
> +/**
> + * rmi_rtt_destroy() - Destroy an RTT
> + * @rd: PA of the RD
> + * @ipa: Base of the IPA range described by the RTT
> + * @level: RTT level
> + * @out_rtt: Pointer to write the PA of the RTT which was destroyed
> + * @out_top: Pointer to write the top IPA of non-live RTT entries, from =
entry
> + * at which the RTT walk terminated.
> + *
> + * Destroys an RTT. The RTT must be non-live, i.e. none of the entries i=
n the
> + * table are in ASSIGNED or TABLE state.
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux erro=
r code.
> + */
> +static inline long rmi_rtt_destroy(unsigned long rd,
> +                                  unsigned long ipa,
> +                                  long level,
> +                                  unsigned long *out_rtt,
> +                                  unsigned long *out_top)
> +{
> +       struct arm_smccc_1_2_regs regs =3D {
> +               SMC_RMI_RTT_DESTROY, rd, ipa, level
> +       };
> +       long ret =3D rmi_sro_execute(&regs);
> +
> +       if (ret !=3D RMI_SUCCESS)
> +               return ret;
> +
> +       if (out_rtt)
> +               *out_rtt =3D regs.a1;
> +       if (out_top)
> +               *out_top =3D regs.a2;
> +
> +       return RMI_SUCCESS;
> +}

Doesn't out_top (regs.a2) need to be populated on RMI_ERROR_RTT as well?
realm_tear_down_rtt_level() checks next_addr > addr under case
RMI_ERROR_RTT: to determine whether the RTT is missing or has child tables
that need recursive teardown.

Thanks,
Alper
