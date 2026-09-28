Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C974EB876
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623144; cv=pass; b=sA5Ixf5fs8s1LXWj3J5zij8jfjtiuyy4k4KeWcckP8p7OOKDYT7E/MFK8wDo9vcRiRAXx/h8ViAwHRLwHOYG7QL0NUd/D/vCueqNnqQjFDnx01358qn/+FIPJ9IryBKWosn3ZvcN+her5jfE4PZNCqV1+mNtnXBhAUbVZh0JNOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623144; c=relaxed/simple;
	bh=cl9utouyB8lmF56V1cn8M2znQJbDVNcxvU4mKhK2sbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWNgEkoXuqlz+uX/fMh6O9gQ/jqXJWFsBV7zz3RBD9kDChoYTDyr1qTbE0u/jQ4xy86CqdMVRgLQBuo1bkdvZXCeiUZp02zvUmpfBJWueCa8m9AZhanE938OgdBYgCE8FW9ITgmM7xxHZ57IlJxEqV+FzZ43DLkPrvC+yHPpzQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIPcz4ds; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIPcz4ds"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ab062a08f5so3344048a12.2
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 12:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790623141; cv=none;
        d=google.com; s=arc-20260327;
        b=d8tkLwkv/Flc6Jf+fuZKNYABPpVL9P+jAhlCTXQA/EM+dPFdcMrAzjYh6lM7HigGDh
         dZaRmXoVmIR+oxjiXTrHMkPdCPBKBl4T2rHU33qIvDZNUy26BbLHO86RRpHL2z7aqCw6
         HDEprUaIZYw7vyKw9s3sulHgkOi6ONJdCPKk7Eh/pbhlzJWU9joybUKy8BQtRCaBD9l0
         9sfOtRa8p7uxbt6qWyxcou3d87Ax/S/w7xoCs6IWV67SWUDjyaFGocWutcoemGORA+0g
         I5m0hAnoW+yK18q95fdTiHFCtwlh0KJKVG6V/ByFQesIMGcMQyHl9BCwBILvk7UjpS4J
         r+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=sYv4OegR8GqzCvAtnvT8UGGBWoOzF0nsQRUN1o16Udw=;
        fh=+c/w6QLsQloVK3MqbJugetr+aS3tOpa2I2vlOHvGsAY=;
        b=sB8mwOFDRPU2GqJIxanfaGt6InEL5ipNISaZhbAgGknMovNvdzOWyb911Px0KWTuRU
         kKLYlq1a7K6HNLngV4o/4l044eq6gnDBX4RNHczV1jbbC6vvv5QkU0qL2FLK4WHt2ZUm
         /O3/ji35+V/r1dQjj9Fco1eXQpfIsDh8OK0KbuPjD498P3oUyDrVJDLUr/8NEJ523XPA
         484IissTFIlUxepYZ00qzWTrWOXrWmP3FpBFQYD64bKLZVmaHUPYGiFjcvIxNnq/N7Ug
         t0GsOYBCrjuDkqmcSI1Vyn6BohpXLY5V6MfamhtLUJT6YKAUs8WPutnkSIGqsfPXVB7c
         lkXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790623140; x=1791227940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sYv4OegR8GqzCvAtnvT8UGGBWoOzF0nsQRUN1o16Udw=;
        b=JIPcz4dsPJE05P8ZWI8FYDNeDg/PF+Jaa5aAgwrc0kJ3Sa6JR6vFIRRaeW9GdUXm2Y
         PB7+veX6b3xcKbGJHOoqZJMluLZsnaK1izHvb9vIyAXRYUeXBjFswGmvXYC4LhsRgpYY
         +kc91TmGm+MOoqV6f7dw4C6b47//iaIzWLvXhJic34V5M1scQ2sR5A8+adLjcj7LzL+P
         QKO15sqjtrzCCeZ/IlRlDxYq9WwYDfCRmUoDSLgXBItf8ZWVf6U1teVs91qFWAIRjRG2
         8II8F7spylvu8LbCKjwYMFlnw/jpXnALHBmQdOC6UDR2cAkhEj2dV9HyvYu7+XOcVOsi
         apHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790623140; x=1791227940;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sYv4OegR8GqzCvAtnvT8UGGBWoOzF0nsQRUN1o16Udw=;
        b=NS1vf9umdQoEq+58jxsPh1vYpPTz+Yu4gLnJMj3yABsrxXWf/6zT2xo+nhpHV9t0Rz
         m9gAGaL6HY8ugIUREyurKSaxm/INGsRS35sDZSQTJUYkbGarI71YgUFrmcoUBw6M4JFt
         xfKPrt45nPUTGiK76WlEX0YezbGjnoq84BD6yj8q+JkRrhoypggBLFZjmPKAme2tSU9Y
         7c5Hg05ezy552nO/PKTfem4l0QErR9AQx/0gI/H3Vwfv6+Q4adLGUOwLa57RW4n4mMxh
         6kfd/KQUcKx2ru6hR4nrekEul46OCMXBYy+Hp71tx++8aegoADTi7GN1dfs0YmIiv7xX
         qu+A==
X-Forwarded-Encrypted: i=1; AKwUvBygSCJTAE2Y1sMPwJzlWFlFb2IkyObu7fFEOE42GDoNK5gzCiaDV6REJtRXpLoeMnR64tc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxQjJPO/zqRfR+WbgC+pLrv08hJrAcVqwlFK8jki7KuvuEb+9Z
	3WPeEsGoikx+wTWDU6vd/OtlpzYG4GAYokpnrK7fsF1aiN5oWaBP86Ps3ubYHGUfz/Xel1CtGVn
	yWwemj1UPfI5FSNE35SoZl5/06HWcYyQ=
X-Gm-Gg: AYBFou3KCfAYQzDuGro7QxQSmEI11HK5Sg7+otFe1MkRCoTZ6SALfQIO4zT6Zo3AhFS
	HG3pYqep0ZCP5JiSeNhlQYxromtcxlaWag9cFY64UDI0niaSDvyTd0uWF4Tx8BthaBfoPHcFhaj
	0CQgNoh0RNS/LOALNCCtXTuA7++vedkGn70dIXszEuJMieRVAQ0IPq8EEHY3ZehYWjKL3O2XYQA
	LCg7o9/sI/aDdasQInCeUzKeOr6Try1uezn1demENjYp7Ips0udTyunFVVI1/ZKzdIpYkuDVFvk
	/EDuB1RTtdTCsR4Jp1Imu0sTx2A8X++l/0uRH6r+sPp4Ey/UaoXHtHg=
X-Received: by 2002:a05:6402:5356:20b0:6ac:70ce:ba2 with SMTP id
 4fb4d7f45d1cf-6ac70ce0e36mr2537042a12.39.1790623140222; Mon, 28 Sep 2026
 12:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com> <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com> <87e7c5ae-c78c-4a47-b9ba-9851ce5757d9@oss.qualcomm.com>
 <CAE2XoE8Fp8w4m0WBjEXF3LceFXUqKDcXhdSmhCThgkAM3wRVaQ@mail.gmail.com> <1f46d3a3-1275-4ae0-be07-717c643cf0ae@oss.qualcomm.com>
In-Reply-To: <1f46d3a3-1275-4ae0-be07-717c643cf0ae@oss.qualcomm.com>
Reply-To: luoyonggang@gmail.com
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 29 Sep 2026 03:18:47 +0800
X-Gm-Features: AclHuK89rkx8dUCUIYddhlG0R2D4NPzT6encjJAYmGIfANm--plpg3p1dBox5j8
Message-ID: <CAE2XoE_0P5M_WNXcREVL+5h0JOVnGiiE+-bPve5dX-q1f_5uZA@mail.gmail.com>
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

On Tue, Sep 29, 2026 at 3:11=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 28/9/26 20:34, Yonggang Luo wrote:
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
> >>
> >> See commit 0e2c5647d92 and surrounding for MicroBlaze for
> >> example.
> >
> > Please take a look at
> > https://gitlab.com/lygstate-qemu/qemu/-/pipelines/2890507627
> >
> > I do not have clue to fixes it properly
>
> What are you asking here? I'm seeing failures on targets supporting
> dual endianness. I can not try to help you until I understand what
> your goal is (I asked it multiple times but you don't reply explaining).
>

MM, let me try to explain it.
The machine list of mips64 and mips64el is different as follows
mips64_machines/mips64el_machines,
and the two lists are generated from original qemu-system-mips64 and
qemu-system-mips64el respectively.
But TargetInfo::target_arch =3D glue(SYS_EMU_TARGET_, TARGET_ARCH), so
qemu-system-mips64 qemu-system-mips64el
are sharing the same SYS_EMU_TARGET_MIPS64 for the function
target_arch(), and it's returned for
query-target/query-targets. so we can not distinguish them.

And I want to deal with this issue, here is one of my try:
+#ifdef CONFIG_SOFTMMU
+    .target_arch =3D glue(SYS_EMU_TARGET_, TARGET_SYS_EMU),
+#else
     .target_arch =3D glue(SYS_EMU_TARGET_, TARGET_ARCH),
+#endif

Is this proper?

static const char * const mips64_machines[] =3D {
    "magnum",
    "malta",
    "none",
    "pica61",
};

static const char * const mips64el_machines[] =3D {
    "boston",
    "fuloong2e",
    "loongson3-virt",
    "magnum",
    "malta",
    "none",
    "pica61",
};


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo
