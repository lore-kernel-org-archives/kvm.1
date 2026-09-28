Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEAA4E9C38
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611521; cv=pass; b=q2r3K+ymO/I2yS1j0qyFqWpPajMb6dLw/iDSqjTzpGxwxZpiQ5RZ8nspVXjc4tWjkHvwwgdTtG4Qos1MGKU0WyWfnH/wpSBuMTrBNO086InKH1qsNSGcK/EZ+fhjUDXCVMPT8hdDuhqm1+mjr/Pn0qsQ1pN4glZUwtkoc4Licfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611521; c=relaxed/simple;
	bh=D20t56SJfazcKJzQ4nk8WVfJXVT0cZ8BIp8BmiaxG+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIGMlklSYxgI7fL8zspIm2rDTRYcLXgja2uh1unWLPWWnyUAnv6MdyKW54ZrI+WmLIvTt3dz3U4jrjZLPgwTbsIlfxJFGe82h/1Ib7wM4UDE2b6O8Ce+i31tzdGdZEI7lqMikGa6TavKXCcxgeJ+EzEDWVgPkYpu/c2Mkicv67Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8tXoDoo; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8tXoDoo"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac6f5c507fso1910054a12.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 09:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790611517; cv=none;
        d=google.com; s=arc-20260327;
        b=dLDKZrt6s10q2ejktlUnIlyd6w2uXNu7Cvsg3YOy2bJvXjVTfB9pJTuHX5xkJOg6N1
         4SldhCJAXcq29bmBZy38KNGIFQOHDYb4KfGUT36peF+6b3fy8pdc873KxTuAR5aN3qt/
         8iz/poE/gk7npKkazWSsJ6fzHY9/Buxby6RZF6uPyTjlbeHzKvvy1j1+twz8x3iVuehR
         LEDOcEpU4ZNIDUpSM57Ml4ikD8RZtmXZAFtvHpFa237SpUEsRTIQ1MBs94iBTpfcPRnl
         PkXrCFMbboEqMAXtnUDfwVvIFfTF+L21nypy3bNGgkENY28QOi1wxqQE9xTnbZuwWwoq
         Fu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=w9EzIeFbERenqhymBK9XblJ6PBKI//1Ot9k5xJ9LNso=;
        fh=yE1D6Ej31Jb8QyuY2SgVMKVFGWegrnhUChx1FBa5sYY=;
        b=JDJXagbNlvk9S7MeD+zA2tub2ThhKy8Ilho+A2m6ofHdh7HUpe3rOVqUe/ay3iPdSh
         zfCcvzpbpsJ2pjxE/qWRKXOvt//SY6O60D+OC0WFUKilUsLlfMokAxG/ygA6p6mCT4hu
         HckkXE2XtC2puNwdbGcWVKS7Ggwttq9YJ0dPFTtbUpnztHxjI6XpTfdTevNujbuyu3nn
         X2Xn26DVGpuBAuNy0AydiTJ9ocks8JELS0qD0XaUXyOl5dibmJq9Usr7a5Hk0tt2syEX
         TlN/1mXYAPDGHFWTyXTHhd0g/KmlWtVz90K4EVmBX3gkRogGAOLRfXqSCQy6BCpCZD03
         28GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790611517; x=1791216317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w9EzIeFbERenqhymBK9XblJ6PBKI//1Ot9k5xJ9LNso=;
        b=S8tXoDoodwJbLnV9my57sGJj9q1m2zgSyaG43lrsIB+3/DV9rdBsKC/62FAVMjdQX0
         MmNKpLI7BxpjgAczm3KlngFFI7adEWNDEES0/AhxnUpbkyG3FBBbvnxm5l61hTveJ/Eu
         FmxM/QgeLKHlw+itqK1uTuBpjqZWhM+wO/g3SkyHorkAyusUup0bojuozvSfTVmNJO9T
         KIHibNXJAu5/WxwBngKvWajb9gO9D/lUwkaK5XJOWNK4IQqSLFv4jNOAgVQuUylD2Rag
         HzCqzZHkS/m4Pbm9+Y0davkD61zJPK/j/Dv/9FuDmYQ1EJh2pKy3AK0BZRxyeF1fvzi4
         XRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611517; x=1791216317;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w9EzIeFbERenqhymBK9XblJ6PBKI//1Ot9k5xJ9LNso=;
        b=ROX1+9fdzEc7CfEMgrYKLAhnoZ9yww7Wg+R1UuWmvio66CbHsAVlsOZrBlcr1miFiP
         tcr5Bttm2qYPYgH3X0oZIOpA5ToL8Yln3sDyFZK+8xtHoX5iSfVgJQNkH5Vcf3zLQcJL
         F+8z+z3cCRNmJ0dZTlNP0ns/9RtZrn8K1rYAca8cu1Ib/ePzXq8gcGq+2TdPQ1lFcRTX
         bFTICVxhP6uRuMQP811oowThBiTl0OW/Zdm3TC91evC2TiQrUu/kaWS4bj9sIdjj++x3
         mJjt81vxFQVObmAjRGljiFsmu+D8tr4r3PgQWQp0mvEfDJStNlnigez3r6YLNLlvzjrW
         YJXg==
X-Forwarded-Encrypted: i=1; AKwUvBwA9E6XiATuhM3C9VR4RaKki+0woYvskbNEK2Phmag9fsCe9mp2Kwd2APnR8ixyfxlJfB4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0RjR3NSDfse91PFI+m2zo8ncN3Qm+5gC/DVAlm7PzXYhcwqXa
	45XQbKcetk2v4R+KUYhRhVyUJ4J5ywC91sc3mGMxmAuHfOhcjooAZcPGhzrieigKa10ExeElMHf
	OO8I4Vt4pVFerlL3qLKDZxB/AA/caEck=
X-Gm-Gg: AYBFou156xcInx+nsnRmZSQkxrwkUD+My2GjFay7trrgktC9QjAehX8PgDqShuVU4aq
	v+8xnIbkE3J0XWMequq+iB8j7Ya9jGFOhJhKR4/ISZGYID0qJQJqxb9jTGs8dY2xBHIxjMhEcpz
	NgwJr4OOoBP8Al0Y3mFqfXi3R5DS1oL45F7mnaPiYCCFsSu1pWBFtTjXlOSF81PTORaWVc/lBL4
	DzRQthO8h39MoPfQ+t8282x2YQTx5U0OlyIt/HuBlFOfZYl48JCh6SLsKsYf0Fs6j6DIp5x6njU
	hFue6O5M3LV4jmGZOpOHhKgcnmET4r5RxZW8W7DUEmWvfQS3c8n9AN0=
X-Received: by 2002:a05:6402:a290:10b0:6aa:e589:87df with SMTP id
 4fb4d7f45d1cf-6aae5898994mr5001332a12.30.1790611516982; Mon, 28 Sep 2026
 09:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com> <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com> <CAE2XoE9AAz8KfJrpErBaZvW5p5COxfE1yveA_AMPwa0j=ghyEA@mail.gmail.com>
 <arp7xUzPHmkgfxLC@redhat.com>
In-Reply-To: <arp7xUzPHmkgfxLC@redhat.com>
Reply-To: luoyonggang@gmail.com
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 29 Sep 2026 00:05:04 +0800
X-Gm-Features: AclHuK_ySAh2wUP_ZLkRO-cTQXhVC-RYZXjpf9omF8LYWvQDhoUtMF2fg4CBqtU
Message-ID: <CAE2XoE_Zgs0_Co4ZLZiTRQZrx4DMRo_i-FEN79b+ZbHCedFd6w@mail.gmail.com>
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>, 
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, 
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 10:38=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Mon, Sep 28, 2026 at 10:24:39PM +0800, Yonggang Luo wrote:
> > On Mon, Sep 28, 2026 at 6:14=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > >
> > > I don't think that we need to report machines though.
> > > We already have 'query-machines' which gives much broader
> > > information on the machines. "MachineInfo" needs to
> > > gain
> > >
> > >    "targets": ["SysEmuTarget"]
> > >
> > > to list which target(s) a machine can be used with.
> > >
> >
> > This is my final design for the query-target / query-targets / query-ma=
chines,
> > for consistency and testability.
> >
> > Per review: reuse `QemuTargetInfo` for both target commands, drop the
> > per-target machine list, and let
> > `MachineInfo` say which target(s) each machine runs on.
> > `QemuTargetInfo` stays small; `query-target` and `query-targets` return=
 a
> > derived struct that adds the target's device and accel Kconfig state.
> >
> > ## QemuTargetInfo
> >
> > ```
> > { 'struct': 'QemuTargetInfo',
> >   'data': { 'arch': 'SysEmuTarget' } }  # since 1.2
> > ```
>
> > ## QemuTargetDetails: QemuTargetInfo plus kconfig
> >
> > ```
> > { 'struct': 'QemuTargetDetails',
> >   'base': 'QemuTargetInfo',
> >   'data': { 'kconfig': 'any' } }
> > ```
> >
> > `kconfig` maps every device and accel `CONFIG_*` symbol to whether it
> > is enabled for that target.
>
> KConfig is an internal implementation detail that should not be exposed
> to management apps as we don't want KConfig to become an ABI we must
> preserve.  QAPI introspection provides feature based information to
> the user. eg instead of querying for "CONFIG_SEV", qom-list-types can
> be queried to look for the 'sev-guest' class.

For example, `TYPE_NITRO_ENCLAVE_MACHINE` is available only when
`CONFIG_NITRO_ENCLAVE` is enabled for the target. When I construct the
machine list literal,
I need this information to help me to check if the machine is listed
in qemu-system that matches
qemu-sysetem-$arch. That needs a QAPI for it. What's the method you
would suggest
for? Otherwise, the test for the listing machine names can not be
reliably running for it.

for example:


/*
 * Machines omitted from the normal lists. Merged in when @kconfig is
 * true in the target's query-targets "kconfig" object, which already
 * folds in host libraries and accelerators. xenfv is an alias of
 * xenfv-4.2.
 */
static const char * const xen_pc_machines[] =3D {
    "xenpv",
    "xenpvh",
    "xenfv-4.2",
};

static const char * const xen_aarch64_machines[] =3D {
    "xenpvh",
};

static const char * const vmapple_machines[] =3D {
    "vmapple",
};

static const char * const microvm_machines[] =3D {
    "microvm",
};

static const char * const nitro_machines[] =3D {
    "nitro",
};

static const char * const nitro_enclave_machines[] =3D {
    "nitro-enclave",
};

static const char * const x_remote_machines[] =3D {
    "x-remote",
};

#define SPECIAL(t, k, m) { t, k, m, G_N_ELEMENTS(m) }

static const struct SpecialMachineMap {
    const char *target;
    const char *kconfig;
    const char * const *machines;
    size_t n_machines;
} special_machine_map[] =3D {
    SPECIAL("i386", "CONFIG_XEN", xen_pc_machines),
    SPECIAL("x86_64", "CONFIG_XEN", xen_pc_machines),
    SPECIAL("aarch64", "CONFIG_XEN", xen_aarch64_machines),
    SPECIAL("aarch64", "CONFIG_VMAPPLE", vmapple_machines),
    SPECIAL("i386", "CONFIG_MICROVM", microvm_machines),
    SPECIAL("x86_64", "CONFIG_MICROVM", microvm_machines),
    SPECIAL("x86_64", "CONFIG_NITRO_MACHINE", nitro_machines),
    SPECIAL("aarch64", "CONFIG_NITRO_MACHINE", nitro_machines),
    SPECIAL("i386", "CONFIG_NITRO_ENCLAVE", nitro_enclave_machines),
    SPECIAL("x86_64", "CONFIG_NITRO_ENCLAVE", nitro_enclave_machines),
    SPECIAL("i386", "CONFIG_MULTIPROCESS", x_remote_machines),
    SPECIAL("x86_64", "CONFIG_MULTIPROCESS", x_remote_machines),
    SPECIAL("aarch64", "CONFIG_MULTIPROCESS", x_remote_machines),
    SPECIAL("ppc", "CONFIG_MULTIPROCESS", x_remote_machines),
    SPECIAL("ppc64", "CONFIG_MULTIPROCESS", x_remote_machines),
    SPECIAL("s390x", "CONFIG_MULTIPROCESS", x_remote_machines),
    SPECIAL("riscv64", "CONFIG_MULTIPROCESS", x_remote_machines),
    SPECIAL("loongarch64", "CONFIG_MULTIPROCESS", x_remote_machines),
};

#undef SPECIAL

These machines all depend on the kconfig. When I try to write qtest
for it, I need the CONFIG_* information to be returned for them.

>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo
