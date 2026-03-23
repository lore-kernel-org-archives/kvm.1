Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FB431F9A0
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291700; cv=pass; b=U2YHvdOzz85d2nuY7mMQGmnJ+i1T8zeHb6ET7f1Anu/taZGY4uRI2w1Y0Am1WeqvyUjolG2DCmWLVmh7U+3TWbk5ov0q7HGIiMWH/rGrVbKuxJvvo1mp9l2jTLgtCJhVYh+yNZ2E9G7Nbff38nXglE2B1lq7CMVysSVfS2573ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291700; c=relaxed/simple;
	bh=wtd4dR/oVa1duupPZRE6M4yMtMAB5U3Lxud0Yc5yhbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHVE0x2yt5aoPgZI5CZ813gBDtjMdY2G+hmDXSFCbML0U9/xEx5oqPtCCnMPwsB0+ijtvXVVq3MkM8HqRxoeaAwMksVrVvME8znGGj7ShNqug/s75UNg8lpLZxHaRwFA2LwIsW1jtd4lnLgQn7bep5ZJSALBJvf+VKSTKyNSHrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uvZ+PVxj; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvZ+PVxj"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50b6c45781aso145131cf.0
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 11:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774291698; cv=none;
        d=google.com; s=arc-20240605;
        b=Hn+ry0INq12WLfgk20jOd4WmyZ1TqZhhOEldGW0PFzDYq4oiWMXcEb35xG8Sa6rR2T
         Omd/F4V7oGoe6ey7pKJqYKPaFg1nTkYovd+coh53SrUSzPAN/c/qydnKOHhtsRfS9Jrv
         MYfJzzmnbcI/iijUGB1ogiMQWCfGfsrzpRTLz7lQOsQGmET3AzuCAqOFf81ZFjGnVnOh
         hZdCePMKKMgU+7QV+/d2d3g+azpEKzRuLsDF7j8jMoUHJ8RyDgToRyJBbQSnYash2R24
         5jn2Ok51rhv7MzdKdloxGXEw0YZ4XGv0ldUlBFNHWIv4QKEXyvEQ07Fw6luZvyexntn+
         a/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vcYV5qmYcsnRNOVKxHhuAn3tOig0z+BjjlFLGSFtEKI=;
        fh=YM8CVzd0y7/ddgRy7nY6FZo+A/FGMtJiwCECwEefsoo=;
        b=B8urcylgdENXK3IuHQmchtFSHeLz9e7RA3VtMpKPIyHgSo8y9roUSqqQ1gjFXwZxn4
         kaBFBE9W+cq1yJ1fH/IOufxBRKH4KVen0+QLqPxCidolhINGCAg22AFgfTOApOnUF6M+
         KlYv0KljRW9o0ijdpJ1pPqXlAN7vOrUPH0e2/5kP8tgH+oQDDWnu9R0W42Cr7Ojn30O6
         Qo0VWk4s5GUMgETjaP/juBIf3QlNSVLKB0jQDJHcuh+ryJZYwPEs/68bpRfci6ytqL7/
         8NJt4AE4ARShhYX/O9PQrDgCLvO2PZMKt0n14BOGMlsfqf50Gli/CtIfK3aQAzP18Wn2
         mcmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774291698; x=1774896498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcYV5qmYcsnRNOVKxHhuAn3tOig0z+BjjlFLGSFtEKI=;
        b=uvZ+PVxj96HK+k4Ve4xvJGHxvyizwbjetJuPp1Dc5KTENfgbnAy1/ClCeaM8jZcndO
         4cJzXh/nb8ayOv5YnjXV7SOGTbbCCfkodig3g4JtI2T0X5tlshvoQemfdt/bfTKLYvOl
         haipNw7BOfRLtOTf7f9Fp7+vyvZM1n68ubNJgj2w7AKMIP+K5VOlo0182eGJhnWzuJph
         e0R8VdslH85Zpf9XueAMVrGE7lEPQB/ag6byVMkzrW4vlisx7LVcaHY6f2gAhDo+D0yC
         NMKQkEBL3awkqe0VZV/Y0ouEo8D7n1TPpjJJhMv9gVwrqIW7ylW9/tvv0BckT7fOts1E
         OEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291698; x=1774896498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vcYV5qmYcsnRNOVKxHhuAn3tOig0z+BjjlFLGSFtEKI=;
        b=IcmBLgiEEyBXMRubfyOIwF1n6t56fFScF9lZN03Ov2Cg5Uknwsu4TueOSIuBNtO9Di
         1laG3GQ3+C61YMm5JJAWZzIWiMViXWntFJBAgWAbcRhKiHrtbpRrsppvLWHb8LdRbecx
         RMkD7lvlM0V2tkiISEyit0tSsoENJ2D8PB2zbYKbtZMZoydgPGJ/kKpastSyv0R9EEAf
         67zVX5PgropIhGns/5NBfrK+1SVBWcyP5msFfIfHQ1q2/3TnBK9mb4sc0osjvDX6dGHc
         c6YjQu06yR10OgZSKjb/XMpHwn0m8VUtDFg4vdCCyDF8lT+3r/u6Tqdmk39Cme9ALe7A
         Imnw==
X-Forwarded-Encrypted: i=1; AJvYcCU/LnYYI/wR44qW/S8fve7ApoznCXB1FKkEOrzvR8FzB7qiBExJYPZuRGaeO/QcKsM0Epc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGRn8atNCy6ctevrILCDFg0OlksG0Id93r2/rbn7h155TAZkvy
	0YuUkuwbMIEqTjxtywEIPkqvfPS66sxmYW6S2aPLREqjffnibneHcgiWSoAQ8VTQXzfTxATHpYC
	CtQO2OEX0pCrrme7UYyh0qBbmFSAP/RnXMUod8/Qa
X-Gm-Gg: ATEYQzxAiVqN164Yy0oHkcg2RQNtbNUs7HanwrNyCi3v4pHlsX1pLWcV5dYdYTec1yl
	v/2Cm/sgDzpInhP/JgPSdnSFXWo/yJUkNDG+8QDxjB8iqrYaxC+dWS7zKvTBfW8qAyAc+9dgsTM
	80wcmENVtkMr/oRKzFJ/HyasYfpuMEVn3Sxk/Rk7UMU6UifZTAOONXulaRiFtrrukZFy7/OrtbC
	y361FVswpdOqxQ/fPyryVt4auoV33Xpw3eH3l43UpN+OEHgKRCgkuhUmYRsQ/RWmJbmPmxlB+AE
	S2E0mHmRhy1LHiaj
X-Received: by 2002:a05:622a:1f85:b0:506:a3c8:d44d with SMTP id
 d75a77b69052e-50b6fd357cbmr1787911cf.9.1774291697776; Mon, 23 Mar 2026
 11:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322054309.898214-1-surenb@google.com> <20260322054309.898214-4-surenb@google.com>
 <fb38ecc9-36f8-49a1-bf20-a2c03244e574@lucifer.local>
In-Reply-To: <fb38ecc9-36f8-49a1-bf20-a2c03244e574@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 23 Mar 2026 11:48:05 -0700
X-Gm-Features: AQROBzAcISvCKuZDTq5gxGva_UwU6WnzRjvi5ru0PTUHh42qSaWhag7QAbSow20
Message-ID: <CAJuCfpFDv1JC-wXR2d_KyrisnJTXxZbPSCY6Bpo4vLxj+FNw5Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] KVM: s390: avoid kvm_s390_handle_pv() error overwrite
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org, 
	mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 10:53=E2=80=AFAM Lorenzo Stoakes (Oracle)
<ljs@kernel.org> wrote:
>
> On Sat, Mar 21, 2026 at 10:43:07PM -0700, Suren Baghdasaryan wrote:
> > If kvm_s390_handle_pv() call fails its error code gets recorded but
> > execution proceeds as if the call was successful. If the next call to
> > copy_to_user() fails then the original error is overwritten.
>
> Is that really a big deal though, as you're returning an error in either =
case?
>
> > The follow-up patch adds fatal signal checks during VMA walk, which
> > makes it possible for kvm_s390_handle_pv() to return EINTR error.
> > Without this fix any error including EINTR can be overwritten and
> > original error will be lost.
> >
> > Change error handling for kvm_s390_handle_pv() to alter normal flow
> > once failure happens. This is consistent with how kvm_arch_vm_ioctl
> > handles errors for other ioctl commands.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  arch/s390/kvm/kvm-s390.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index 3eb60aa932ec..ddad08c0926f 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -2947,6 +2947,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned=
 int ioctl, unsigned long arg)
> >               }
> >               /* must be called without kvm->lock */
> >               r =3D kvm_s390_handle_pv(kvm, &args);
> > +             if (r)
> > +                     break;
> >               if (copy_to_user(argp, &args, sizeof(args))) {
>
> Yeah as per Sashiko we probably need to copy_to_user() still.
>
> But in that case, do we even need a change at all? I'm not sure it really
> matters which error code terminates things does it?

I agree. I plan to drop this patch from the series (see my former
reply) unless someone tells me otherwise.

>
> >                       r =3D -EFAULT;
> >                       break;
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >
>
> Thanks, Lorenzo
