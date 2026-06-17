Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DAF326D55
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781723239; cv=none; b=pyDgVOGWhp9THeHPZUFTS19VN6A9coYTAnXUA+PaHweNamoo/5Tq02ME+m+MD2g/FLvdKSqEtckIlkeBCePK67rViVOLdz4crizDDq+vE23XkDRFwUbJDNmyz9FltdedGIYaVNqv55moPafD1E68l5YyHMxQlzc0bmd5Y9bmKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781723239; c=relaxed/simple;
	bh=xCtJPcNLWyoPjpPhu2YChOz+3yORpxz1XHDMMWMaME8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIlRz90m9VYYZLvfN07ktHRPH/rGjyCu1OJeDj20qF/hoJAvpB1d5wVpxBvXG6amVAGloq0oJSGxtD7BKpL+R6UthJtYGSp2F54d00nmGvvgeX20gdv6SIk0WMDsW0TnSQeQkcY3c8NSzt1a8cFtcxM6jKD2ely+O4DrrFEjFhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vDuRB2at; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vDuRB2at"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c69fa0b1f8so10715ad.0
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 12:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781723237; x=1782328037; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=81mXXCCpcttBKrAxsKwbl4tlltYVTnNUOOayD4OTdWM=;
        b=vDuRB2atV0Y5P2mgJqmOX+Sbkk9DrtfGe1fTWDZOa7crA8mQQTDXRgaJAG4eMGmOCK
         dYcng0KXbkr22v7b8bmwjW3IaA83WrBILQLQNRZ5z1ws/0Qlae507oHmCM2sQWWt67pi
         F9CKGdWdey/Pq1NsBIiI6FNYP+Dt9LmDdWLTjlKnp77V7U1K1Izs8z8zj0f4Zi/Mzho9
         3z7K6iiw9VX9FrjJURorhrIJVZRtQDycX7aZplE2CwANncvvEurDgjX3sUjgUHMrDjJm
         vAHUWtIXS1XYWeiG8DNeE2iRS/GtRBtCVPfCHiYFFa44N8V1kujhC3fPOf6S2XjMwusu
         Ih2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781723237; x=1782328037;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=81mXXCCpcttBKrAxsKwbl4tlltYVTnNUOOayD4OTdWM=;
        b=tZMXtroPPqylTlHFokUIp6KL/NytXrlYRl+41UiBXCLLaL5wuIlORKcNPxn8mTtyn7
         sMiFm0G7UE7u79J9oO623Y+QCnqEaux0iVV2ZpCzV9qigcF97ZxtLGhXl5QvWuDB18Yh
         QnN/XTeoBCmUXWUzkszUqo2ur9SyA6f9Pfr16MV8XOwsz8I/41u5bPAZbCPFKYzlUPIt
         q9FtBBsVRjK/Em7X/+XdvQoJsMK1STNIFo+jYOQa1PRnvDH4mLf9rT9Z4jjDDpBKqOs2
         1pHpDntFEKV3A/i/VqlRMTIjc9L9waWnxrTkId4172k+PUXKhRhF99eZZABU4EnJbGPv
         bXaA==
X-Forwarded-Encrypted: i=1; AFNElJ9cNnAWzbsneNj+IwWq49GwukNb+ULQ3QYkMvZOIh7+6UuUvAlxTDiKe8Pr1vr1uFbVsME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyalUjC4yU7dAXn+8Twom33R6owmYHJpK8AcdjoZ72sjnKIsw0c
	Y1YA58iQXXlq98iD5fHMstN8+bwqnTwOXdVPNWPjtgkw3yAWf/D4cMFTaB59P4iJ5WlGmS47o+P
	sjm17yw==
X-Gm-Gg: AfdE7ck0yLLmQOr6dwGOk1y77Jj3DKz3siHs5XwxL8qk6CoWvMI+PjtW+9XDXCcRO3v
	HSndpYBLULpb4UatlZXbYrpSjCu5L0T5MRIZFH0Ig216CRrcat6Q0ON98/M7PwQYq4aIyloCa8O
	7Bda65yI9y9NUr3vIvFLltDVG/P9eNyZz6QA2KM8swSjQHiRB/zddvIrXnDMZby9bCkBjsdOUHj
	omTqjaby2Nw1GQaMtV5gw1mhBxgko/MneuX0VzYRPSZkWvPBDQCoc/Ie/ICcZgnizY3gy0/tjHw
	mMdamzKjMTr5A6JHISSTxfMQpJFK9RW8/JHDnQq88H58ptGBwHLs9wn8XE870TekaRU5N07qKca
	mle8IYcbuxOsB9EtLMElP3MbL1ZDAJ3iD+86I2NAaIgUV4SduoIQWFldPWXJaE5mxJBlGbInd4s
	vrR+QNnQNeGs1X/NX1ByXs3h7L8ruKrPxcEQQ+cE6c82SdTt3BWQ==
X-Received: by 2002:a17:902:ec91:b0:2bd:a61:8536 with SMTP id d9443c01a7336-2c6e20e58c8mr471575ad.6.1781723236749;
        Wed, 17 Jun 2026 12:07:16 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866518677dsm15074194a12.19.2026.06.17.12.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 12:07:15 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:07:11 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v6] vfio: selftests: Find devices that have VFIO selftest
 drivers
Message-ID: <20260617180507.GB2704872.vipinsh@google.com>
References: <20260602222941.3133236-1-jrhilke@google.com>
 <aiHW_1vBrukpuaW2@google.com>
 <CALzav=cb=SaTtkwdTpK32Nboq6Uj8WKiN_=wRfpO+zugdjLRCA@mail.gmail.com>
 <CALzav=dCjGHMfDaW87jKOhquUvY6uEns1i+wGY1Kbq2A7Pfreg@mail.gmail.com>
 <aiMTJa1KHHgpTbDq@google.com>
 <ajK_P2AEGLvKD5US@google.com>
 <20260617161412.GA2704872.vipinsh@google.com>
 <CALzav=fcHk5SiVc=q0G3dWR_USw5OFNoqXucfiEvxbLBXrda3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=fcHk5SiVc=q0G3dWR_USw5OFNoqXucfiEvxbLBXrda3A@mail.gmail.com>

On Wed, Jun 17, 2026 at 09:34:18AM -0700, David Matlack wrote:
> On Wed, Jun 17, 2026 at 9:28 AM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > On Wed, Jun 17, 2026 at 03:37:35PM +0000, David Matlack wrote:
> > > On 2026-06-05 11:19 AM, Sean Christopherson wrote:
> > > > On Fri, Jun 05, 2026, David Matlack wrote:
> > > > > On Thu, Jun 4, 2026 at 1:30 PM David Matlack <dmatlack@google.com> wrote:
> > > > > >
> > > > > > On Thu, Jun 4, 2026 at 12:50 PM Sean Christopherson <seanjc@google.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jun 02, 2026, Josh Hilke wrote:
> > > > > > > > Add a new script, list_supported_devices.sh, which prints out the
> > > > > > > > segment:bus:device.function (SBDF) numbers and names of devices on a
> > > > > > > > machine that have a VFIO selftest driver. This makes it easier to
> > > > > > > > determine if the system is capable of running VFIO selftests.
> > > > > > > >
> > > > > > > > Includes a -q (quiet) argument which prints just the SBDFs so that the
> > > > > > > > output can be passed to tools/testing/selftests/vfio/scripts/setup.sh
> > > > > > > > (e.g. via xargs) to bind the devices to VFIO to use in VFIO selftests.
> > > > > > > >
> > > > > > > > Examples:
> > > > > > > >
> > > > > > > > $ ./list_supported_devices.sh
> > > > > > > > 0000:6a:01.0 - Intel DSA SPR [8086:0b25]
> > > > > > > > 0000:6f:01.0 - Intel DSA SPR [8086:0b25]
> > > > > > > > 0000:74:01.0 - Intel DSA SPR [8086:0b25]
> > > > > > > >
> > > > > > > > $ ./list_supported_devices.sh -q
> > > > > > > > 0000:6a:01.0
> > > > > > > > 0000:6f:01.0
> > > > > > > > 0000:74:01.0
> > > > > > > >
> > > > > > > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > > > > > > > Signed-off-by: Josh Hilke <jrhilke@google.com>
> > > > > > >
> > > > > > > NAK, until this stuff is fixed and properly documented.
> > > > > > >
> > > > > > > This script needs to (a) communicate that some of the devices may be on VFIO's
> > > > > > > denylist, (b) NOT report them by default, (c) let the user report denylisted
> > > > > > > devices, (d) make it *very* clear in the output that a device, and (e) ideally
> > > > > > > provide the user with a hint of how that might be able to test a denied device,
> > > > > > > e.g. by reloading vfio-pci with disable_denylist=1.
> > > > > > >
> > > > > > > Nothing in here so much as mentions that these "supported" devices may be
> > > > > > > disallowed by the kernel, including the devices that's USED AS THE EXAMPLE.
> > > > > > >
> > > > > > > The DSA SPR devices has been on the naughty list since commit 95feb3160eef ("VFIO:
> > > > > > > Add the SPR_DSA and SPR_IAX devices to the denylist") from 2024, so I have a
> > > > > > > very hard time believing y'all weren't aware of this.  And if you really truly
> > > > > > > weren't aware of this quirk, than what exactly are you even testing!?!?
> > > > > > >
> > > > > > > C'mon.
> > > > > >
> > > > > > Yeah vfio_pci.disable_denylist=Y is required to use the Intel DSA SPR
> > > > > > device. This script is a great place to capture that previously hidden
> > > > > > requirement.
> > > > > >
> > > > > > Your proposed (a)-(e) sound good to me.
> > > > >
> > > > > Another direction we could go in here would be to set disable_denylist
> > > > > to Y in setup.sh (if it is currently N) and set it back to N in
> > > > > cleanup.sh (after the last device is cleaned up and only if it was
> > > > > previously N). I was already thinking about doing something similar
> > > > > for setting enable_srio to Y for Raghu's new SR-IOV uAPI test.
> > > > >
> > > > > The only issue is that disable_denylist is not currently writable. I
> > > > > don't see any functional reason why it can't be writable though. It is
> > > > > just sampled during probe. And from a security perspective, privileged
> > > > > users can already reload vfio-pci with different parameters if it is
> > > > > built as a module. But for built-ins, this would enable the denylist
> > > > > to be disabled.
> > > >
> > > > IMO, any changes to setup.h are completely orthogonal.  list_supported_devices.sh
> > > > can and will be run independently, e.g. by people like me, and so absolutely needs
> > > > to claim a device is supported when it's obviously not.
> > > >
> > > > Actually, that's a good amendment to (b) above.  Instead of *never* reporting
> > > > denylisted devices by default, have the script check disable_denylist and act
> > > > accordingly.  And then it's "just" a matter of communicating these details to
> > > > the user, e.g. so that a user can find devices that are supported by selftests,
> > > > but not by their currently loaded kernel+modules.
> > >
> > > SGTM
> > >
> > > Josh can you do this in v7? We'll probably need a flag to control
> > > whether the script lists devices not currently supported due to
> > > denylist, and how to convey all that to the user. I lean towards
> > > list_supported_devices.sh printing as much information as possible when
> > > run without arguments. So maybe a flag to hide denylisted devices.
> >
> > Do we need then flag to hide denylisted devices? Instead, I think it should be
> > opposite (I think that what Sean is suggesting as amendment). If
> > the script finds vfio_pci.disable_denylist param value is:
> >  - Y, then just show those DSA devices if they are available on the
> >    host. Don't differenciate.
> >  - N, then don't show these denylist devices.
> >
> > A flag can be added to show all of the VFIO selftests supported devices
> > present on the host with the warning next to denylisted devices or group
> > them in the output.
> >
> > Flag case is for human consumption only.
> 
> Can you explain why it should be that way?
> 
> IMO running list_supported_devices.sh without any arguments should
> display as much information as possible. I think that will maximimize
> the probability that people running VFIO selftests for the first time
> will be able to figure things out for themselves.

My view is that setup.sh should get supported device list by default
using the list_supported_devices.sh which should correctly tell what is
supported based on the kernel one has booted and wanted to test. We also
have in-progress series for IGB and MLX devices selftest driver support,
these devices are not in the denylist.

People running VFIO selftests will be intentionally running them on
supported hardware. They will also first need to check/read scripts on how to
use the setup.sh, run.sh, and cleanup.sh, or manually pass
device BDF value (via args or environment variable). These things are
not default and one will not have a successful run in the first try
without knowing these internal details.

vfio-pci module default is to disable use of these denylist devices. To
use these devices one has to set Y to the vfio_pci.disable_denytlist
module param and reboot the kernel.

So, a pre-requisite for running VFIO selftest is to be an advance user and
I don't think they will have any trouble in figuring out these things.If
they see no run has happened or they want to explore more,
list_supported_devices.sh will be an easy read to discover flags.

I think my suggested approach is advocating for keeping things in sync
with what kernel default is or booted with. It looks cleaner to me and
respect safeguards provided by the kernel.
