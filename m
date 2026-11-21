Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795221756;
	b=oanbECbCAsjTXOkh68gvVWfT3wqSRpH0t1S+/WeRTAWVORof02Jfk+TySAZVyb0lOEFJ
	 ajhZOHfuZEdeO2nGcmpm1A0yO7AUzz4oX9vips6g/e3S7TE7AJHCPdYoYqUTkFCkUnMeP
	 5ScfuSMceWNadBaU4tBY1zvdhc4ZuITea8m6hj90AFviMhKkAG7c2MdfuEXemWiPVzzJX
	 v0Uwq5RRD4u0a2mVGGHX3mi1Fema9GAAPGL85zHGPCrujA8bOYWoPD8cdMyEjIy0KOK7V
	 TurIKR1Uh6mTHYKNJAvsdLddqHggZ26HtSANujYRfwraSMP8lbBdRsxhVO70e7DfcGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795221756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Js5N6yiXwXXSTzZ4KgFGwIMSCZDX/tKTz1lwaDrh2ys=;
	b=bR44NOS3Uyy7JA0xccFIiVwRmw2anhvnOqrj4rYYzqcQeb/t8RbcmRY7YReK0et/JHbZ
	 6JPvjmf7ijwu8zmAFWcyTIYfcCwEsxMN0foWYh4HjO85w6MMD05HEi1RCcx1bPZNuSwAb
	 92VaMcoZW+NgXeZy5zN1iz0u5uysDmLtIgDN0Lq4f6R/MLd2K8w4z7E5C5o1dkYqzd54B
	 4lXt/2NPCy1vpvR5osNm4BtW37WfJiGfFxOaP1M6TUswbbLDSrQIrsId7JDP3Sm2VHOO3
	 qNruFcL1279O1gls8KjB4jx6ZxciW4s1HaJTFShv0hwDduHCAEgaXuGo1Delfxp7l1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pD4AmFXt;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4F606A6BB
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 00:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CD4F606A6BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pD4AmFXt
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3863db981d4so1435076eec.0
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 16:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795221754; x=1795826554; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Js5N6yiXwXXSTzZ4KgFGwIMSCZDX/tKTz1lwaDrh2ys=;
        b=pD4AmFXtEI4gcW8lq8jgkb4TQsgIV3/rLtjvPlKCyYdsJDnM+Zhcqgii1TYOrJgoEg
         68QH0SXg5hfk3V3UukH3TNA6omD4Miw35AKisfch3ZeCi1bcWUEFHWVhKQFBenR4d/uT
         PFVo9ZKRd8MNE9ce59HLBrRIZXQfzrDXwp88W6gcmp93e+7LmSWp/JUaImYP0bEpCPKk
         6tqgTgqxEcGLlucCXJv1PzuFx9Yqt9WPeGxHvVFuV+Jy7dSJmrRs5k1OvQWJzkVegXfk
         /o+CFNkY9vYecLaF55iDgXS/a0dzZuftjHafZCpoIZxy8MI8Lcx0nAf3II18bzFxbRtK
         7fWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795221754; x=1795826554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Js5N6yiXwXXSTzZ4KgFGwIMSCZDX/tKTz1lwaDrh2ys=;
        b=LeYo66v/jsH+n1aJgvRIHpy2ffXiv4GXw2HR5dQvzYo2eqQCIOLQzzvZwWq5VH6q87
         VBAF44TGubCWBm06/scxtvoZ0DU4jIPDmqyJNV3LvjZMYDwBFisQ5C+f5TbgpfeNPV+7
         D9eUPqqcBBiUMiyHr+RRlfeOMZZFZWjDk/XqKfvkxc6E47x3myV+TzXVh02+Kf444dV7
         IJU8Nt7p9QalMs1hoVGWHBDoj/lyaqgwPWDnON/kpFzN3+DzO8dTNbYsP0gb7/EiQGS+
         aU9HPTvgN49aftZ+czOR9ihaW6tA/JVSsrIWnHszvl1aT9Uue7K04cgbVoHA9MgTNrdI
         eOQg==
X-Forwarded-Encrypted: i=1; AL+hErHCCS8STlE63CJjLRBvd7W9nWNEUgXZRcvyKctgbOtobMiWjonVwkXp0LRDjjHSqUZmDW0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aLMcqeuxhV5XVUBGDKQD87zMNzu6ZmyLbIv8Ca8eIPGHf7sbk
	ykuCaUzWCrjfOblKSwXKulVZPV2RpE+ONgnpNrjoBmk5ii4x70XiM+22
X-Gm-Gg: AZFdTZdN1UIbisvjgDiDBxRGMXhNu6G144rWVpNxiouqSOUULa5cmH4zDFSDmiuffng
	qE9xdIkyq3U8fa7FQObAKdIYqPCqSPcyzMFdo01asqKTeQMFt8Fz3gITJOhkx0VO+xh8CmHun5p
	gOhuNIeaDG3ZknHjkXTh1Hp7cAHeACUdNIOVN24v9OuMCGLR8MpicXqghHflo0Relz7pXOo8tTc
	Zx4DdmxaimPdIY63qPrY+DTWx7cLty+Ju3cwyMukGvPg6dOBFNH0J8qO95pHISwgo3N6V6ZntR6
	FOqbfoSq+iN4Bv/VVTgvogDFQzpyTkC0Ovy1RCYal6M5BHiuwpxpihMjTcJdpPyTzYvou5hCnfW
	p71cgfzx/AKseV+zuIaiY0LdXY151eRcnRNN6OwhIHL2PN7NVnKtwvO9KruT+K6wbvDH4g+v3WP
	4R7HmIKqA61CscS90DAbvNBTxzF7mCWvQxPVHtIB6fqbs0nmZdPC7xZyJfpOKkMkq/cl1YfuBHc
	Au6195TMFn0/4UkwAvwhHtGXOTwJ8HP42XP1HHBCh69HZ2Fxc/siXge0Y+JAsKbCLmzEjIIqpBD
	jEq+YCwkXOmREEmyRvms990ht5ednGDVyA==
X-Received: by 2002:a05:693c:4091:b0:379:4197:5eef with SMTP id 5a478bee46e88-3856f65b3cfmr5387027eec.8.1795221754060;
        Fri, 20 Nov 2026 16:42:34 -0800 (PST)
Received: from localhost ([2408:840d:6820:1a1b:6def:d896:8796:4938])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm12699706eec.27.2026.11.20.16.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 16:42:33 -0800 (PST)
Date: Sat, 21 Nov 2026 08:42:28 +0800
From: Yao Yuan <yaoyuan0329os@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Yao Yuan <yaoyuan@linux.alibaba.com>, 
	Alex Williamson <alex@shazbot.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, David Lechner <dlechner@baylibre.com>, 
	Armin Wolf <W_Armin@gmx.de>, Thierry Reding <thierry.reding@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Karl Mehltretter <kmehltretter@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Marco Elver <elver@google.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, Bradley Morgan <brads@mainlining.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Pnina Feder <pnina.feder@mobileye.com>, Mete Durlu <meted@linux.ibm.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Rio <rioo.tsukatsukii@gmail.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Longfang Liu <liulongfang@huawei.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Brett Creeley <brett.creeley@amd.com>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, 
	Julian Ruess <julianr@linux.ibm.com>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Eric Auger <eric.auger@redhat.com>, 
	Mostafa Saleh <smostafa@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, qat-linux@intel.com, virtualization@lists.linux.dev, 
	intel-xe@lists.freedesktop.org, kvm@vger.kernel.org
Subject: Re: [PATCH] vfio: Allow untainted use of driver_override
Message-ID: <awDok7Sm5Dgp-Ty-@sapienza>
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
 <20261118235645.2907908-2-alex@shazbot.org>
 <xzp5gljhburzbpol5bgnyyzwdrgpw3fj6ff3j23ein27raiidw@kti7moeuwvb5>
 <awBUG7-QzXplEiUT@monoceros>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awBUG7-QzXplEiUT@monoceros>

On Fri, Nov 20, 2026 at 03:10:38PM +0100, Uwe Kleine-König wrote:
> On Fri, Nov 20, 2026 at 10:17:46AM +0800, Yao Yuan wrote:
> > On Wed, Nov 18, 2026 at 04:56:44PM +0800, Alex Williamson wrote:
> > > Driver overrides are the standard mechanism for binding vfio drivers
> > > to devices.  With the introduction of the support_driver_override flag
> > > in the core driver struct, it's now required for drivers to declare
> > > themselves as driver_override compatible, otherwise driver_override
> > > bindings will be denied or generate a kernel taint.
> > >
> >
> > Hi Alex,
> >
> > > Set the support_driver_override flag on the driver struct across all
> > > vfio drivers.
> >
> > LGTM.
> >
> > Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>
>

Hi Uwe,

> I missed your reply when I sent the next revision of this patch. I had

Thanks for your reminder, no big deal to me.
Let me follow your link to have a look on v2 there :-)

> to trim the recipients of the v2 because gmail refused to send it with
> everyone on Cc: who was emitted by get_maintainer.pl. So please see
> https://lore.kernel.org/kvm/fb0df5c89336b77a373ae0f890f63427e4adbb28.1795171088.git.u.kleine-koenig@baylibre.com
>
> But also note, that if v2 is picked up using `b4 am`, your Reviewed-by:
> is considered as the patch didn't change.


>
> Best regards
> Uwe
