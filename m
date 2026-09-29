Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88804175A64
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790645778; cv=pass; b=DwCjbChJUy9GaIOR3xlfdnH2UM00YCRSVax+1GRTbGwmsqUfyDSJF2qwHYk4d67nGsXxJP42ZQuV29+4eOR20UQ0vZKQrDUG3bBKqqHs754XFiVy5h8GF5cTxakSPIMAS1/52nWg0BqIsXln1YIAqV9yVggMZ3RNMTmd/gWCBXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790645778; c=relaxed/simple;
	bh=FIwE0Bpd+eoA32YbChPqzcgtv1uYijeu/1Gr3AA0O1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7P+c3/YMUKgE3Tqu8ktNmhetyV2j/oLuyjgCXD82dNqYYwUckN18gQkOzGdkav9Hv5tgQ8ao3qcLrlVS0wJO79+1cfAediRU5VRNMtUgUzn1cxfIi29rDPcXmVRLfW8WNT7uBdCG3hnuJYttZJm2lpeRTvSZpWnL2A5ISwPEic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT6xaMz0; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT6xaMz0"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6aaf28a86b9so930227a12.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 18:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790645775; cv=none;
        d=google.com; s=arc-20260327;
        b=jpZp7rZvAtWDRftJd6sG7CaqkDEXt4JJQD0CSmoFOzcEW2p6zzrmX1h6UR07eKuLDB
         ho122+fVFCB7Uj+PXBPAS1KmVxfM5TgQhCL46lxRJFKw5IOC4VWcVG/8RH+NaVTFsR6s
         BLmkSTmim2X4FROGqg5JqLElSBMg6XELWlnx+GIdVApYhagrCrT7AhJa48T55AET2f9Z
         pd3YpAhx/5CrVIOKx4FtHiRzLzGinF5tkjKo+QWwOl4oEd5i6J9nrFyGuYjgXnU6XCKZ
         Q7uxSSQpd99MTl/mV57vtK8vkaB+mHuz7eFbxEUNDOMOWVxXT2C2NeYZIl87N+I3I+1X
         zfig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=rs9au1eGA9M7SYgh5SPNLTgJY2xqQlWh6Et+Arr6MM0=;
        fh=qqnpyLzYKDKE9KOxhmePoUzRHTF6GhynPhu0qyQycEk=;
        b=Lm6yXOy+Q+F5WbDMSchS8Lk8Slgyv+X3LloaoEx9lL3i8TmOglfHgbCudSn3TNYQvU
         D1btlRXJk1GKqH3vBsOWkar/6nrfnVzGqHHmnYLs8oKrhmiJcIYGsltIVLgIdvsQNyDT
         UJWa1kasK3YP6vaiAL7hAd5FOUGL/75wjZ1PcuJiOQIjXp0Y0E9IYaLsahaQ9Dr5rx9Q
         9FOrL7buSC2rDLFi7TEM6+8EmhYoODwa9t6s5uzh8c6/lEAvO+GK3F4DxHpWvrCF65H0
         954alajB9jAibFWzjU+bMQ9WlGf87VioiGaaSKWjGB9p166DqZS8TZsWKn0QIKcB45ah
         2ndw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790645775; x=1791250575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rs9au1eGA9M7SYgh5SPNLTgJY2xqQlWh6Et+Arr6MM0=;
        b=XT6xaMz0EcYQzAgA+sdrd8yP94KEbCfplQnttJJ6JvU/fTl71yEro0KYai19Ph2q6W
         l1jzdfTEFvD3fU8n3x/p/i/0MRAoH5YLGWFZrCXESRsM4YbjyUyZ/bktlx3/RLLVjW3u
         WwQgoMY6p0sA1eifZt1vOJgjTrfXMcqtuW5ID/L3BdddQrYMN97vkFMNfxH28gxbVhSB
         JtL+n4OsZiM3eZY4abqWIeiLfnOdAPqRBqaNtgTB7di8jq2voaxlIBpiNpIan52gN3hm
         PDvZh/mIt2C92eNmZ6kBz+JvOAKQUto86/lnlyT/m0D6PLxdsC72JWJkgp9s3NKjPThy
         TxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790645775; x=1791250575;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rs9au1eGA9M7SYgh5SPNLTgJY2xqQlWh6Et+Arr6MM0=;
        b=BNRY8csdyLnrZ3YApuBzAMX6/MEOOUxzLI0Ld6sUoX/BXA2tsPUUnSME/a2vElObXH
         5TXz9/BGg7zUxwT9nwrZkEns5JZrmwfDPZ4QFIKSMXDTt3Q3GpEWzn8Alv7Ob8mn76v8
         q9hvRrkw+e0FrWsqqPVjxU/d5KmeahQL3uHppxEqwP2Yswfp05R3ImBdMEIDPBnUbWB1
         f14GNsjmVHQpG9Q4DkOjhZLbYSeO+h68kj1qwN7Ua8Dec36S0J6B34MOtppzr4Qp110o
         KKhER2DtuJriz2cH9Jej3FV/UIEcpErE+SLY2a1rpBvPl6KHtlu8scBUCmqjWyWc8nyn
         DGsA==
X-Forwarded-Encrypted: i=1; AKwUvBxoW3q4Hc94a6Eyf/VjlfJ/mZuHqVJl2H3yx37iiNKTluGafqEtJanMTlO7F71tdAycAgM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLH32rJ5lQf4RqUvsliWOGgVqr23wdBCy3g474NVUUNMVD6xiYB
	Qh3sIB8X7Eal4rZ1EGWgq01GgSYFWdFvSRmRfICwQLDZEM1SBbiwrxCdU82X3/lSZHI5bPAfic8
	EG/NHdeq2mBtckZmBdud+9QSyTrww7wVdMd9KpUQ=
X-Gm-Gg: AYBFou0nH2yycPWnOYFSLp0sz7y56LrnlycYp1g2soHcJyYxMIxDtRiMbMLvakfesSj
	BtRTorTrEmE3dEg6/57vgBHhjKnMp6bYWd6XI4Zb3YJWE3HZNHFISVJ4FbtQxPMXfcJAQm3ov1k
	rH6cx2dIOgYRk5bemYi8FNkYVQ3SfM1F9F1CPZSYPCNOW5tGRR2tYLtIIB8joaQkMbiaa2j3w9k
	x2JcidPKmDDnsWvC/KcxPBQYmJ/W98x9lcel71kG9NSGmo3zgzMVXs3/GCSU/lwpHTKIfzkZSUH
	DLDrwL8niF7COIrR8aMTsIZROcJxlDhWmxiwQ4GwD6EN/gDOtW1vo0I=
X-Received: by 2002:aa7:d51a:0:b0:6ab:260:6378 with SMTP id
 4fb4d7f45d1cf-6aca86236a8mr499160a12.11.1790645774380; Mon, 28 Sep 2026
 18:36:14 -0700 (PDT)
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
Date: Tue, 29 Sep 2026 09:36:00 +0800
X-Gm-Features: AclHuK_udHvC7oTjEuhilwZdEHpiOvElmXHC3KV0wZOIgddeR19NpS3MIjJMWOE
Message-ID: <CAE2XoE_fxTRQJPzsDZHS44z65KR0e54cWjVpyZQGtr1sdLOinw@mail.gmail.com>
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

Now I can answer the question more clear, it's because the pitfall of commi=
t
https://gitlab.com/qemu-project/qemu/-/commit/e934c624f32f6f44f427d73a2e6a6=
7e983a02ae6
cause the issue

 target-info-stub.c | 2 +-
 target-info.c      | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/target-info-stub.c b/target-info-stub.c
index 8392d81e8f..65220cc782 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -18,7 +18,7 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) !=3D sizeof(CPUS=
tate));

 static const TargetInfo target_info_stub =3D {
     .target_name =3D TARGET_NAME,
-    .target_arch =3D SYS_EMU_TARGET__MAX,
+    .target_arch =3D glue(SYS_EMU_TARGET_, TARGET_ARCH),
     .long_bits =3D TARGET_LONG_BITS,
     .cpu_type =3D CPU_RESOLVING_TYPE,
     .machine_typename =3D TYPE_MACHINE,
diff --git a/target-info.c b/target-info.c
index 5a6d728252..a26532f660 100644
--- a/target-info.c
+++ b/target-info.c
@@ -24,13 +24,7 @@ unsigned target_long_bits(void)

 SysEmuTarget target_arch(void)
 {
-    SysEmuTarget arch =3D target_info()->target_arch;
-
-    if (arch =3D=3D SYS_EMU_TARGET__MAX) {
-        arch =3D qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
-                               &error_abort);
-    }
-    return arch;
+    return target_info()->target_arch;
 }

 const char *target_cpu_type(void)

Look at the diff, the original one is directly parsed from
target_name(). and the new one
defines "glue(SYS_EMU_TARGET_, TARGET_ARCH)", but that indeed does not
match target_name() at all.

And TARGET_ARCH is introduced in commit
https://gitlab.com/lygstate-qemu/qemu/-/commit/f87f7e145d63f93315e0f0e00fb9=
ba0b6ee8570f
for this.
Hi Richard, is this done for intention or a mistake?
maybe we should always generate target_arch from target_name()
in meson.build?



>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo
