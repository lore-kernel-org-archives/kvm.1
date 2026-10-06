Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DA52931CB;
	Tue,  6 Oct 2026 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276866; cv=none; b=BS+cH+y6bfAI9fNRCcn1EDo/KN5BfF1zMmAP2fwH4310kfWJb9ezIy15DLjVQrlyP58xsEcmn3GiDM6T65G+ubJSRWWrvDZKw3URLInJMrGEVh/ZNKN5imypGJ0pc+D9mYyEiSVo3r0OoGMmNxyKlqdY3+Vbl3cQoJGDHyCElik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276866; c=relaxed/simple;
	bh=urxC8lW8Cd6yGjZ29oZvHyXOLt5KM7BDBnHHCG8V+9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozePoJicSEtldj0+M+Ovc72o0G1+LRImOxCUjthh0Hp3waEKEtXm8TPJgaf4ob87FEpX7Mc4IbaTwN2eBKBfehPk12+dJaOhe/DeToWSXTsqPmPJYFEy8hluHjIiCNZm2Q5z4sjusKQsdXdxp/b3hOhi2tW7vnNAd3w6JJEj3mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E246Uhk4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E246Uhk4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E17C1F000FF;
	Tue,  6 Oct 2026 08:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276865;
	bh=b4F2pC6sE9BMPqLGvCFDalXCw5BiwXL6xVzHA76PUiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E246Uhk4TQ7dg5nPgDZCqmR1+sSNxccMXVLMJJmwt5RLD+Op+hWeoLiTmcg7eG8/K
	 MQCtR1kWqcs7kjZj/E7rAj6RvcQN5CBkDLovDMkCxuRlpI5roiqRATgB2w+W+zcFRd
	 2aEPZUiqiUZY1zmA+FpEF5PdfC7COE/IdwNXYkSVXUbeuk3rhlmTcPRBKsnSlBspFx
	 PP+MOo4GzufATo8XHDTRC4CA8umt72UttuNFnLDvr1Q/8OETtVIYDb3KeCRPqrJEFQ
	 KykzJlJtJV95cRP7BgFLHjvEUSFFCV+vq2F2lyB/WkKtAatCpwBoxxuP56XG3f7CW1
	 e3RG9K9b5cVTA==
Date: Tue, 6 Oct 2026 10:54:17 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Raag Jadav <raag.jadav@intel.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Alexey Gladkov <legion@kernel.org>,
	Hasan Basbunar <basbunarhasan@gmail.com>,
	Hugh Dickins <hughd@google.com>, Armin Wolf <W_Armin@gmx.de>,
	WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>
Subject: Re: [PATCH v1 0/3] <linux/mod_devicetable.h> deprecation continues
Message-ID: <20261006085417.GA1522@ax162>
References: <cover.1789988540.git.u.kleine-koenig@baylibre.com>
 <179121379654.1159753.4410832336442519712.b4-review@b4>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179121379654.1159753.4410832336442519712.b4-review@b4>

On Mon, Oct 05, 2026 at 05:23:16PM +0200, Nathan Chancellor wrote:
> > this is a next step in the deprecation of <linux/mod_devicetable.h>.
> > scripts/mod/devicetable-offsets.c and scripts/mod/file2alias.c are the
> > only users of that header that use more than a few device-id structs. So
> > their number of lines actually grows when unfolding the needed includes
> > into them. Still it is a reduction in build dependencies.
> > 
> > I suggest to take this via kbuild during the merge window. Would be great to
> > cook in next for a while before.
> > 
> > Best regards
> > Uwe
> > 
> > Uwe Kleine-König (The Capable Hub) (3):
> >   Move struct cpu_feature to <linux/cpufeature.h>
> >   devicetable-offsets: Include the needed device-id headers instead of
> >     the catch-all
> >   file2alias: Include the needed device-id headers instead of the
> >     catch-all
> > 
> >  arch/loongarch/kvm/main.c         |  2 +-
> >  include/linux/cpufeature.h        | 12 ++++++-
> >  include/linux/mod_devicetable.h   | 13 -------
> >  scripts/mod/devicetable-offsets.c | 57 ++++++++++++++++++++++++++++++-
> >  scripts/mod/file2alias.c          | 56 +++++++++++++++++++++++++++++-
> >  5 files changed, 123 insertions(+), 17 deletions(-)
> 
> My apologies for taking some time to get to this. I was planning on
> building it using my personal test matrix on a local machine at home
> while travelling for Plumbers to avoid tying up my main workstation but
> my home's internet connection has been down for two weeks with very
> little hope of getting it online before I am back...
> 
> Sashiko has a few comments that seem relevant (most of them are the same
> issue):
> 
>   https://sashiko.dev/#/patchset/cover.1789988540.git.u.kleine-koenig@baylibre.com
> 
> I have applied it on top of next-20261005 to see what conflicts are
> looking like. I see a merge conflict with this series from
> 
>   d59717cfbe1e ("firmware: arm_scmi: Add SCMI device table alias support")
> 
> in the soc tree, which is fairly trivial. There is a semantic conflict
> that results in a build error from
> 
>   fe7f2a805443 ("firmware: smccc: Add an Arm SMCCC bus")
> 
> in the arm64 tree, which is also trivial but subtle.
> 
>   scripts/mod/devicetable-offsets.c:317:2: error: invalid application of 'sizeof' to an incomplete type 'struct arm_smccc_device_id'
>     317 |         DEVID(arm_smccc_device_id);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>   scripts/mod/devicetable-offsets.c:62:43: note: expanded from macro 'DEVID'
>      62 | #define DEVID(devid) DEFINE(SIZE_##devid, sizeof(struct devid))
>         |                      ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
>   include/linux/kbuild.h:6:62: note: expanded from macro 'DEFINE'
>       6 |         asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
>         |                                                                     ^~~
>   scripts/mod/devicetable-offsets.c:317:8: note: forward declaration of 'struct arm_smccc_device_id'
>     317 |         DEVID(arm_smccc_device_id);
>         |               ^
>   scripts/mod/devicetable-offsets.c:318:2: error: offsetof of incomplete type 'struct arm_smccc_device_id'
>     318 |         DEVID_FIELD(arm_smccc_device_id, func_id);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   scripts/mod/devicetable-offsets.c:64:32: note: expanded from macro 'DEVID_FIELD'
>      64 |         DEFINE(OFF_##devid##_##field, offsetof(struct devid, field))
>         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
>      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
>         |                                 ^
>   include/linux/kbuild.h:6:62: note: expanded from macro 'DEFINE'
>       6 |         asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
>         |                                                                     ^~~
>   scripts/mod/devicetable-offsets.c:317:8: note: forward declaration of 'struct arm_smccc_device_id'
>     317 |         DEVID(arm_smccc_device_id);
>         |               ^
>   2 errors generated.
> 
> If you would like this in 7.4-rc1, I am not opposed to sticking your v2
> into -next now but I plan to finalize the Kbuild tree for 7.4 around
> October 15, so we'd only get a week or so of build coverage. If that
> feels like too little, we should defer this until after 7.4-rc1 is out.

Two more issues came up in my testing.

ARCH=loongarch defconfig:

  In file included from include/linux/mmzone.h:20,
                   from include/linux/gfp.h:7,
                   from include/linux/xarray.h:16,
                   from include/linux/list_lru.h:14,
                   from include/linux/fs/super_types.h:7,
                   from include/linux/fs/super.h:5,
                   from include/linux/fs.h:5,
                   from arch/loongarch/include/asm/elf.h:9,
                   from arch/loongarch/include/asm/cpufeature.h:13,
                   from include/linux/cpufeature.h:23,
                   from scripts/mod/devicetable-offsets.c:3:
  include/linux/page-flags-layout.h:6:10: fatal error: generated/bounds.h: No such file or directory
      6 | #include <generated/bounds.h>
        |          ^~~~~~~~~~~~~~~~~~~~
  compilation terminated.
  make[4]: *** [scripts/Makefile.build:185: scripts/mod/devicetable-offsets.s] Error 1

ARCH=s390 defconfig:

  drivers/s390/crypto/pkey_ep11.c:23:28: error: array type has incomplete element type 'struct ap_device_id'
     23 | static struct ap_device_id pkey_ep11_card_ids[] = {
        |                            ^~~~~~~~~~~~~~~~~~
  make[7]: *** [scripts/Makefile.build:290: drivers/s390/crypto/pkey_ep11.o] Error 1
  drivers/s390/crypto/pkey_cca.c:22:28: error: array type has incomplete element type 'struct ap_device_id'
     22 | static struct ap_device_id pkey_cca_card_ids[] = {
        |                            ^~~~~~~~~~~~~~~~~
  make[7]: *** [scripts/Makefile.build:290: drivers/s390/crypto/pkey_cca.o] Error 1

-- 
Cheers,
Nathan
