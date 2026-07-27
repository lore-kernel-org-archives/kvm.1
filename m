Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7DD374E55
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182349; cv=none; b=AhD4rZyStNCJOlN5fyk5NZcIyoTqeertJUbHETevC4O+lrv8nl2wlLaXAj81WgvnkJUxtLbm4ACeb1jhm7t3JCPFbtoWgUFcXRr5/h4Gt2qOqSU8evtxYngP18FyqTBfIRX0Du+Foskv7elTCsFN8t8VlkgmHu5JMEobdAqAYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182349; c=relaxed/simple;
	bh=u+ilvPxeB1k83CHdxoeMtCj1BfZ7ijrfkQx1SKvv+CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M81Pgqx6Shi/USB1L4/ivblvdaI4aBSUkXDVDuY0gfWbFKDSkOmsiAMe1T0uOPqeYMeOnv4fzu1ulFvf7cTREppJ3mxAinTjXGGqHYLeUp8WAWhutuuNNKNUBSxDYMjYL4qlZnuT3382x+Lh2jEFWVjbhcPK3yXh96S4VoaLK9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZV4kdTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZV4kdTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BDA1F00A3D
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 19:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785182345;
	bh=VEqb3cviMgA4+Koji5ripUmWTM4rUOGt9IwXrB1ETiA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UZV4kdTmxaaeyByrQ0eSnAI1AS/9LmSgNX0DesgWwWyydwFv6c0YbRETNyDn5C+77
	 8Ue/RFBf4hJ7mlWFI4hw5vecQY4+1fY7CMUSUdRLLv4LMKuaXhAPd5ZwYg5n4OB0LQ
	 Nh5Z/1YyWZL1o3bahD7GOWkkxTMX34A5YSUwawuW7uUjK3MV2WjJBBpnwbwk3UihTo
	 t91kqxuNyDB/6F7n4K6ALwiXOEuhBTsGjAk7g1mMCOc/pQGlRzmIB1IzIrzsTaeKmH
	 OtBDuS27s7lh5IL85DENNpH/YBiyaMrXU95HwxOyo7Tgy4DBnSa4sZxGR1X6IpNkY+
	 uHEVo8YTymh0g==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69ea0595598so3257127a12.0
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 12:59:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoXsd/usaCcjzMJyl/UfaL7FfCrXJDcgiUmGn2DYfy4EfQhBCboZ6z/Kfe5XdVOZ/kz6Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjob7q3jLuf/ZQonclHFtv4Lxj/jTac/+tI+IriLxgHOHPVosd
	azbQ+BlT2CVy666Yx4Rt53a0gz8VSJL5Jxi5FU2o6dykRk/TgCgLNqI1E19R1W4L3GkB2ZJatvu
	SDNNCv0/p0p58RxlIF8C2OxlQLPou8fs=
X-Received: by 2002:a17:907:a42:b0:c19:58ac:a15e with SMTP id
 a640c23a62f3a-c1f692379d5mr22351866b.48.1785182343927; Mon, 27 Jul 2026
 12:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723094419.630204-1-pbonzini@redhat.com> <ameuTMWJUZfleIbk@tycho.pizza>
In-Reply-To: <ameuTMWJUZfleIbk@tycho.pizza>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Jul 2026 12:58:52 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMopB=YKXs5pkQmPf9uHKE0P0XORcNbc60AWXTusuY3tg@mail.gmail.com>
X-Gm-Features: AUfX_mwaybNBDQt0bRJLe-GyiyHIJdijlFWmqtWznkdIfavb_bonGBGRgpyCscU
Message-ID: <CAO9r8zMopB=YKXs5pkQmPf9uHKE0P0XORcNbc60AWXTusuY3tg@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: make svm_flush_tlb_gva do a full asid flush if
 NPT enabled
To: Tycho Andersen <tycho@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Alexander Lougovski <alougovsk@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 12:23=E2=80=AFPM Tycho Andersen <tycho@kernel.org> =
wrote:
>
> Hi all,
>
> On Thu, Jul 23, 2026 at 11:44:19AM +0200, Paolo Bonzini wrote:
> > As to the workload, Alexander threw more or less everything at the same
> > time at the VM:
> >
> > - a full Windows Defender scan every 30 minutes
> >
> > - a disk I/O job
> >
> > - a loop doing repeated mmap of system files (mostly to hope that
> >   it triggers some consistency check in the Windows memory manager)
> >
> > - SQL Express 2022 + StressDB (1.6M rows), with the host doing queries
> >   (75% write/25% read) via sqlcmd
>
> Can you share the code for the mmap + disk io + DB content generator?
>
> We're looking at this and would like to reproduce.

Not sure if this is relevant, but I see that hyperv_tlb_flush is flaky
with npt=3D0 on Turin at the tip of kvm-x86/next (commit 567329869b9c7).
It's not likely because the problem fixed by this patch happens
specifically with npt=3D1 and not npt=3D0 AFAICT, but it is a weird
coincidence :)

Maybe something is wrong in the Hyper-V code that manifests
differently with npt=3D0/1?
