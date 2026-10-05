Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A29C47ECFB;
	Mon,  5 Oct 2026 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213810; cv=none; b=qd+B0XkQPCMpfwakqP/r0XgMUheriZrtI3ukP6Wlt4zbbfeRgMFPXhenME925WW64AQpd/WPE+BqDwiyzEIOXT3NJhoAD9NebBPkVUb0k8Lb8QiMmXTKZ78UNEcoVQnwGzxlSsyD2QBO4miQ3FHDQS5YzkKs+dYJEzY0O+1gXPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213810; c=relaxed/simple;
	bh=dbxko1Tskh0UHfn8lMh+ZDyKxaEwpceAQxIp+yv4VEc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Q3v03owkCbm2gK2tsfkwaLJ/FbMX7ZsBZS7S3ivVBC2TcPkc6MCJZKiInmVQhHQQnbwb8B8hE006NQJDfiUp/jrBYoHxVoMHyXJCy7GkeOpvn5OD3u2dkmoOeliNSImUfklOk8QTbYay8mXhV2f3KrQBNCAyoa6zla4eXSJ7r5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEn/2TGV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEn/2TGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563EF1F000FF;
	Mon,  5 Oct 2026 15:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791213808;
	bh=g/JAGXLuoKcmjyycPO+efDbYZ+A0Nw5jhE4IlEY1e9Q=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=IEn/2TGVQmVfWJzysBgUUpj6pW/dkCAaE4Dw4bTbGlygIokmqLODmT61CAWHv6ov6
	 GB3o6iaQDWEtEYnu1SBEAOiyaAMy/H6OGCiiiQV+Ac/dT82KhltC2PVpFKCO22PlNt
	 fTP11ImSAeHJKKnC0BaKx8mpcJYl4ih7Zgh+acyWBjzek5HUZGNTVYjFx8GUVkKnTW
	 xm1f38L58kAbjFnXcyr6DQEuVJI2qzdSku3qvijr7z9PlWowrjR67rJ/aWmsUM1qGm
	 e3FYPKVO/70GF5AjlrD0LuAPQJY6loLKBsKPgCe9wa9mHOfjNY4MpjwqbQ11Oixkdn
	 AWJ9mpIcaX52A==
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/3] <linux/mod_devicetable.h> deprecation continues
From: Nathan Chancellor <nathan@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
 Raag Jadav <raag.jadav@intel.com>, "Martin K. Petersen" <mkp@kernel.org>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, 
 Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>, 
 Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Alexey Gladkov <legion@kernel.org>, 
 Hasan Basbunar <basbunarhasan@gmail.com>, Hugh Dickins <hughd@google.com>, 
 Armin Wolf <W_Armin@gmx.de>, WANG Xuerui <kernel@xen0n.name>, 
 kvm@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@kernel.org>
In-Reply-To: <cover.1789988540.git.u.kleine-koenig@baylibre.com>
References: <cover.1789988540.git.u.kleine-koenig@baylibre.com>
Date: Mon, 05 Oct 2026 17:23:16 +0200
Message-Id: <179121379654.1159753.4410832336442519712.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4378; i=nathan@kernel.org;
 h=from:subject:message-id; bh=dbxko1Tskh0UHfn8lMh+ZDyKxaEwpceAQxIp+yv4VEc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFmHD7z4FrFFbNlr2zsC/unFV0/IM9hq/Fjw/K/npB0v5
 /b6mHT4d5SyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJVOoz/GZ7eeNY9Oc7IUff
 aWwuYt1yJ4atdiKDqf/pwBD9Y1HmIryMDIsLG954XN9v8ocx4N1d55IXuYuYK/1TZgoYd7zy1wr
 +zAoA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi Uwe,

> this is a next step in the deprecation of <linux/mod_devicetable.h>.
> scripts/mod/devicetable-offsets.c and scripts/mod/file2alias.c are the
> only users of that header that use more than a few device-id structs. So
> their number of lines actually grows when unfolding the needed includes
> into them. Still it is a reduction in build dependencies.
> 
> I suggest to take this via kbuild during the merge window. Would be great to
> cook in next for a while before.
> 
> Best regards
> Uwe
> 
> Uwe Kleine-König (The Capable Hub) (3):
>   Move struct cpu_feature to <linux/cpufeature.h>
>   devicetable-offsets: Include the needed device-id headers instead of
>     the catch-all
>   file2alias: Include the needed device-id headers instead of the
>     catch-all
> 
>  arch/loongarch/kvm/main.c         |  2 +-
>  include/linux/cpufeature.h        | 12 ++++++-
>  include/linux/mod_devicetable.h   | 13 -------
>  scripts/mod/devicetable-offsets.c | 57 ++++++++++++++++++++++++++++++-
>  scripts/mod/file2alias.c          | 56 +++++++++++++++++++++++++++++-
>  5 files changed, 123 insertions(+), 17 deletions(-)

My apologies for taking some time to get to this. I was planning on
building it using my personal test matrix on a local machine at home
while travelling for Plumbers to avoid tying up my main workstation but
my home's internet connection has been down for two weeks with very
little hope of getting it online before I am back...

Sashiko has a few comments that seem relevant (most of them are the same
issue):

  https://sashiko.dev/#/patchset/cover.1789988540.git.u.kleine-koenig@baylibre.com

I have applied it on top of next-20261005 to see what conflicts are
looking like. I see a merge conflict with this series from

  d59717cfbe1e ("firmware: arm_scmi: Add SCMI device table alias support")

in the soc tree, which is fairly trivial. There is a semantic conflict
that results in a build error from

  fe7f2a805443 ("firmware: smccc: Add an Arm SMCCC bus")

in the arm64 tree, which is also trivial but subtle.

  scripts/mod/devicetable-offsets.c:317:2: error: invalid application of 'sizeof' to an incomplete type 'struct arm_smccc_device_id'
    317 |         DEVID(arm_smccc_device_id);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
  scripts/mod/devicetable-offsets.c:62:43: note: expanded from macro 'DEVID'
     62 | #define DEVID(devid) DEFINE(SIZE_##devid, sizeof(struct devid))
        |                      ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
  include/linux/kbuild.h:6:62: note: expanded from macro 'DEFINE'
      6 |         asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
        |                                                                     ^~~
  scripts/mod/devicetable-offsets.c:317:8: note: forward declaration of 'struct arm_smccc_device_id'
    317 |         DEVID(arm_smccc_device_id);
        |               ^
  scripts/mod/devicetable-offsets.c:318:2: error: offsetof of incomplete type 'struct arm_smccc_device_id'
    318 |         DEVID_FIELD(arm_smccc_device_id, func_id);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  scripts/mod/devicetable-offsets.c:64:32: note: expanded from macro 'DEVID_FIELD'
     64 |         DEFINE(OFF_##devid##_##field, offsetof(struct devid, field))
        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
     16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
        |                                 ^
  include/linux/kbuild.h:6:62: note: expanded from macro 'DEFINE'
      6 |         asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
        |                                                                     ^~~
  scripts/mod/devicetable-offsets.c:317:8: note: forward declaration of 'struct arm_smccc_device_id'
    317 |         DEVID(arm_smccc_device_id);
        |               ^
  2 errors generated.

If you would like this in 7.4-rc1, I am not opposed to sticking your v2
into -next now but I plan to finalize the Kbuild tree for 7.4 around
October 15, so we'd only get a week or so of build coverage. If that
feels like too little, we should defer this until after 7.4-rc1 is out.

-- 
Cheers,
Nathan

