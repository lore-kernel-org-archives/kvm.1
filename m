Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09CC3B3887
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621419; cv=pass; b=GxR7yy1f4WzHfQ0XhtEGMqk++2S746N7usnD7wVtPeWHgO1qE68zQ+dIEBtt4VWN+VDBWnlFCTD9hVMobfyJIcdeIFAmV3qtUqwoIv//tGHVzzxT3vRH2bGj3mTVcZY4Qg8NS/d830zspkCTs0WNQYdKaGRWWB6pMTMRPwM4V40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621419; c=relaxed/simple;
	bh=MUq2IVaELHmXZg4HVFc9uac3c+iiYOqoyuXOPCliCvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JglHy54hHmkEXbpUXa1yGwVxER+xpfypiU12gPAqK3fs0LZEKU0zRGt9NPAP3KiL4VNhKGGj8tJ41PHAnZ1JiHNrz52qspPrqlN5iHffLnxO9zSTKkJnrHBNUlVSdDkbRkYJzv6ZUsKrfMGRUAkMX4hTntrnBoC0+kJnqBW/GlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juEWVmGm; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juEWVmGm"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aaea178c96so3990794a12.3
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 11:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790621416; cv=none;
        d=google.com; s=arc-20260327;
        b=bMW6rD8F13h8iei+kDKXmgc3Tib6vjvDY0FOHeducpo8pz+djHdngzrck91+p51HV4
         WIpw2vtq6h6zwb0q6WKq1gdT9iJtd4gOknHOk5eKQusCpPRXmSCqEuRiCU45gob2gl1A
         ZW+UtBnW+sWbKm2ZB+PLwt8p2JQ2YtvucN0t8gVX4ePeoEXHtQUT244SwhxC4/owmMKf
         DfO+QkGdyDr2tSKUhr8vZ4rFzhLPZC9RaY1HPtwzpC9MJBcl0DNxC5FrjS2VvmB4XWPQ
         JTduGuUOp2SBXXCOWDkq65O6NWvYOYGCWISQR/nMl7d+gb5egBBlBRXCf9mebV1e3FL7
         G8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=cNWNsOCJ4AlO+zLzUIcfQWq7CBexHD/3GmlH1NAXYOk=;
        fh=t2MM47Ne7kdH51J9wj01Cu3iOQVZfdn8lk8PV86T5lM=;
        b=K/hy5fg8YB8a2nhkwxLzeJOOrGD1fxKsFED+sxjBJGHdps22Nj6kjGCDbB4IXOBCjU
         5cipzhE0zgagC1YRjoShC7wGmUUVY6O0yiYGOJbezZf38XNtABs6P05IhPbi0ZkO4K6W
         lEtNahNJo/No4RjbfbeGfFJi9XzYLYjSmuBpQyqoDN5HQOcjtQsO+2uQ91FZv9Mnq7Yt
         m3HFZ0CFjOoEBPrES41MYECBQ6SYOTaYO/k70WPh0OsSC4jXqPPOey0HX5nxmIkJ9Dlh
         BFPFXrXlEDZcitLAuXrxDyXjDSdPVR7koLemUHVoIMKV2Zn4uI3MLcRzlnpyshhnh93y
         5GPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621416; x=1791226216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cNWNsOCJ4AlO+zLzUIcfQWq7CBexHD/3GmlH1NAXYOk=;
        b=juEWVmGmZEQ1bnNHR8u3sdFBDMje41beNQhrpcX+brmm0PAMb4yiPcpauSfPq/uV0i
         gIdWIYALzaHbpjvgH72yubf63/DLulY+n06cU9CSq/SwuvI5Iap6VJd6M4xrFXKFckNu
         7eCCV0u2VwAdQr27lFRF1ENKdvww6k1zTBGtvleXIWsBuI+eeh/t0pb53KF5+juVc7kc
         qq3gjxYAj7Skxz0A9QnasUV9M+zZZuw03MeRCaVZBNAT6KTcDe+KodVAFODcfvhJUiK+
         wlZ7V7Oqk7+PMFCfqkLhEEMrfZRAEc0eXNCuAwem6XVkJJ13FsbFmhBERwCEWnnsAZm/
         XiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621416; x=1791226216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cNWNsOCJ4AlO+zLzUIcfQWq7CBexHD/3GmlH1NAXYOk=;
        b=b4qcm2EThpAlt6H8QDyR4VDv4TUL1hnQnztzIPBRF2nyf0fp3YHOCP/MygXsh96Yx2
         TgxFVFZpJ3/etlRrx97O+ZK3IJXWYReaRT708UNDoCaAbHZx/m/xWNqjavDZpPBezD/l
         I0xYq9B8f5ci4JqcggtkKnxVBMC48/H0eSVeRaFVJgB+/1iZ+ZVAwHdHxRloLYryGI5m
         JhIA14f4jZ9wA8WjnDcr630SYvmLEluqKGR+zWWD0qdmih+cxTH/cNf5hanPRATjZeVm
         nMJeJ5uybJMwtghBzccHhsNTYMgk4ZRGfsc5CNXlZVGMi2gFZZX5A2Xj4tzMQuii4B/m
         3qww==
X-Forwarded-Encrypted: i=1; AKwUvBxeLR0HT551yTA688Us2xV/iowHN5OaD8zS4Q3Vy+OhiNwD48Wfeg85HjYPa9MqO4AUMsU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzGECkoyWGrN/t7eq5Ear1X7j/RroeJDo66h8ZAqv1kHkGXl+V
	IRv+QP7fTi2YWQgLMkEFtfd+xfZQktCFPDyXB1584SjbTx3+e0jYpqY22muxhYLBUj3P/jcL0/s
	sDBt/TjUXc0gGnxmQvpgXWAOw7aHFZpQ=
X-Gm-Gg: AYBFou0BGYhJW0S2P2/Z3GXUP1+aGXGUicwdd43MUVS6YrLXnwgJxbKE+AMWaEjRPHI
	aZLOUxDvAUfufYx+Bk8/Kto82XSl4fjv/lLhjt1+9tFdFKO+e5lkl7bY5wggQMY3AIxhWsyGdpn
	ozwiJ/gZqJ74gwRIXps6PrHE7eMVA6eHvY/WbAp/RaMDcZlL1M+Qj8V4rsULE9LvxBv6yN0zzOM
	NNHCcvTRFhMlWR8ZlxXKvvhdqsp8k3tj3rh4FjORMg9sg+IeIJMhEpU0cpRe7JLSrt/KHvA9ual
	Dty8B8PzmR1m6VufQfRFjNByy7YZ1vwInXphzTzztwHsdrxz/47kPAQ=
X-Received: by 2002:a05:6402:52cf:b0:6ac:813a:a1de with SMTP id
 4fb4d7f45d1cf-6ac813aaf45mr2454700a12.31.1790621415614; Mon, 28 Sep 2026
 11:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com> <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com> <87e7c5ae-c78c-4a47-b9ba-9851ce5757d9@oss.qualcomm.com>
 <CAE2XoE9qsZZ+AnfGQ797SQj5yXP8SDOZyxYoKP=oh57UPFqq0Q@mail.gmail.com> <a4b7056e-1651-4167-86e0-e7eaa3941d02@oss.qualcomm.com>
In-Reply-To: <a4b7056e-1651-4167-86e0-e7eaa3941d02@oss.qualcomm.com>
Reply-To: luoyonggang@gmail.com
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 29 Sep 2026 02:50:01 +0800
X-Gm-Features: AclHuK9MjNSmaMmQn-0GfArQrUjas0ym97Kf1QeFVREkyJZ8FhppqJVItRfEd-4
Message-ID: <CAE2XoE_0=iEY4uSQ6dBwHpJOhuQOL5SrVbO3kDjMFSrJwbVoVg@mail.gmail.com>
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>, 
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, 
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	qemu-arm@nongnu.org, kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 7:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 28/9/26 12:51, Yonggang Luo wrote:
> > On Mon, Sep 28, 2026 at 6:39=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <
> > philmd@oss.qualcomm.com> wrote:
> >>
> >> On 28/9/26 12:13, Daniel P. Berrang=C3=83=C2=A9 wrote:
> >>> On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
> >>>> query-targets lists each linked target, including none, with its
> >>>> arch, endianness, and the machines that target accepts.
> >>>>
> >>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>>> ---
> >>>>    hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
> >>>>    qapi/machine.json          | 35 +++++++++++++++++++++++++++++++++=
++
> >>>>    2 files changed, 65 insertions(+)
> >>>
> >>>
> >>>> diff --git a/qapi/machine.json b/qapi/machine.json
> >>>> index 6aaa2af709a..d8cdea6203e 100644
> >>>> --- a/qapi/machine.json
> >>>> +++ b/qapi/machine.json
> >>>> @@ -307,6 +307,41 @@
> >>>>    ##
> >>>>    { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
> >>>>
> >>>> +##
> >>>> +# @TargetMachines:
> >>>> +#
> >>>> +# One registered system target and the machines that can run on it.
> >>>> +#
> >>>> +# @arch: the target architecture
> >>>> +#
> >>>> +# @endianness: the target endianness
> >>>> +#
> >>>> +# @machines: machine type names, not aliases
> >>>> +#
> >>>> +# Since: 11.2
> >>>> +##
> >>>> +{ 'struct': 'TargetMachines',
> >>>> +  'data': { 'arch': 'SysEmuTarget',
> >>>> +            'endianness': 'EndianMode',
> >>>> +            'machines': ['str'] } }
> >>>
> >>> We already have  'QemuTargetInfo' struct which is used
> >>> with 'query-target', that should also be used with the
> >>> new 'query-targets' command.
> >>>
> >>> We need to add the 'endianness' field to QemuTargetInfo.
> >>
> >> Why do we want to expose endianness, and what endianness to
> >> expose? Endianness is a runtime bit state of CPUs. Sometime
> >> this bit is hardwired but that is an implementation detail.
> >
> > For some targets it's, but for some targets it's not. for example
> >
> > mips-softmmu.mak
> > mipsel-softmmu.mak
> > mips64el-softmmu.mak
> > mips64-softmmu.mak
> >
> >
> > mips64el-softmmu.mak
> > mips64-softmmu.mak
> > only differ the endianless
> If you look at git / mailing list history you'll see I spent more
> than a year unifying QEMU endianness. It was too much work for a
> single person so we decided to reduce the scope to ARM + MicroBlaze
> for single binary and we got MicroBlaze unified. We don't want
> an endianness-specific single binary. I'm not sure what you are
> trying to build, you didn't clearly explained what is your goal here.
>
> You can find series unifying endianness for MIPS, not merged because
> more things need to be addressed and not the priority.


Oh it's because target_arch is not setup properly for those arch


From bcffa0d129fd864037b4e0f7b2f46f4889e76509 Mon Sep 17 00:00:00 2001
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 29 Sep 2026 02:47:48 +0800
Subject: [PATCH] target-info: preserve full softmmu target identity

Generate a full SysEmuTarget token separately from TARGET_ARCH, so variant
targets such as mipsel retain their QMP identity while user-mode targets
continue using the base architecture token.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build       | 5 +++++
 target-info-def.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/meson.build b/meson.build
index d63174ea8a4..e86daa47228 100644
--- a/meson.build
+++ b/meson.build
@@ -3319,6 +3319,9 @@ foreach target : target_dirs
   endif

   config_target +=3D keyval.load('configs/targets' / target + '.mak')
+  if target.endswith('-softmmu')
+    config_target +=3D { 'TARGET_SYS_EMU': config_target['TARGET_NAME'] }
+  endif

   target_kconfig =3D []
   foreach sym: accelerators
@@ -3374,6 +3377,8 @@ foreach target : target_dirs
       # do nothing
     elif k =3D=3D 'TARGET_ARCH'
       config_target_data.set(k, v.to_upper())
+    elif k =3D=3D 'TARGET_SYS_EMU'
+      config_target_data.set(k, v.to_upper())
     elif k =3D=3D 'TARGET_BASE_ARCH'
       # Note that TARGET_BASE_ARCH ends up in config-target.h but it is
       # not used to select files from sourcesets.
diff --git a/target-info-def.c b/target-info-def.c
index c02d98e6875..54e499712bf 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -28,7 +28,11 @@ QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MI=
N);

 static const TargetInfo target_info_stub =3D {
     .target_name =3D TARGET_NAME,
+#ifdef CONFIG_SOFTMMU
+    .target_arch =3D glue(SYS_EMU_TARGET_, TARGET_SYS_EMU),
+#else
     .target_arch =3D glue(SYS_EMU_TARGET_, TARGET_ARCH),
+#endif
     .long_bits =3D TARGET_LONG_BITS,
     .cpu_type =3D CPU_RESOLVING_TYPE,
     .endianness =3D TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITT=
LE,
--=20
2.52.0.windows.1





--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo
