Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439EA4968E1
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713742; cv=none; b=LIFD30mlLb8mw2eL698l98Z6Zyms25IDE4/uLRo+54dR9FgEFgX/9yO6X3Ma13UxCvARnZ3TgjYAEJ5UlGTQ8+N0b6xIF3Ji8S0HiSvMhmk/S5+ToS8+djgx07XLnKRAnbuy4Li9iQHzUE6pG9J47ZXHBHXhntPd+iTFzAFYJP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713742; c=relaxed/simple;
	bh=p8H+i2hQXAZgr4q/dOHxUPPdpb5hmH64UF+lt8NZZTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2Lg6M7DR3WzzpKUsKKF85NbWlI4hSHfJtB7QQhhMTYh5dv2xlcko64b0NC4FYetm3aKv0ice+PKYBzqkd5hi5uRb6mko9Vc9iCmO2fImkfHf1xGFGUJXc2QDJ6Mrh65ffgp4+79ug+xzsGobEX8rwny1OFzOUcTZnIzY/+LH6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gzOHTugD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzOHTugD"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso69545ad.0
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781713736; x=1782318536; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4rSvVFqn6CKM8ZLCLiC2HUU3gYSC/i5Pbi94cil1tKM=;
        b=gzOHTugDzH54CmoRLPnlvb7O3kSdrri7c5I4T2ppL6Y5Z5YJWOephlPniiN3G6kaJy
         DbWcP9YYIf2asz3BysanK0EE/xX/CIX4JN+UAwW5OE/6zgobQo09Eh/yNWN+lOAF8a2P
         OosR0blkFIMSaINZDGTfnHA38yQGdPoQE3DqokanMiISZ+CQEfsPeF2LEmpMkdgQGNnB
         8IMc4jaHZzy9jSBX7MQc3aQzzUZNwFKmi4B/QQFQvaEG5IE8RELyb2XnSa7huHv094e8
         jksWp4Gwi4AquszYxAo00gNP+dkW45zGpAaX3d5yt+xLG6pjUnfHmMEdyIKMl7ohHvAK
         e9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781713736; x=1782318536;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4rSvVFqn6CKM8ZLCLiC2HUU3gYSC/i5Pbi94cil1tKM=;
        b=Z6xH8cBGxZoYB+iVC1ZO3e/H6KDUvy+dyJWLbGvgUhxtRHoh7B+fDoax78NfgQ7RxA
         lB7QglgyeAcsOSgO4X68pucs0d6iO8YAA2G7sjaRtEJixTump0iIFB1PLCRFCYcpfQcg
         lY9lw1YjaCkGXng8JxqPEdSgvZDo8jp233Kn+9gD9yX82R/1xAnV6i3l2H6UhWjwpw/Z
         dZb4hkSceQCRWJyk5J6H3c8587QRwSGY3loytsVtwRGje4XiQUmKOGYh9keYZsEFyt6r
         b0r1P7htuJyPAtzlR74Km+tDndx1RUO1eMmIVx9aZGGjqBPoIziU96UEglxDT2tejtQg
         mXJw==
X-Forwarded-Encrypted: i=1; AFNElJ8KssbcTmVNATSO0tq/uYH/Un023WFjckfWsCdGINH/OIsmifVJUsw1MkdTXx2tI9Qd5Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPeKATL7pHN7KY10yKz8ssIvYHZGVL3YnwrTgnLTWKKN6NxqDU
	gvp1mKhTfo/b+8uFO0rWFgSuagVmxuVJD9LeEZXjLq+NIaHd/W8EcAeb3n6d+m/0Jw==
X-Gm-Gg: AfdE7cnWM+wSBiyLDSZsSqbZzewzxz7cAcZ1TyMu5Hj0aFEuaE7i8AoZmFXquA6o7Ge
	0s5s4DEvlSIEBDl5kKo4CNeBQQjRi5UVjugRAEC/R02mQtud99dS0CM9MgVQBVj/ni0ZZpcL51v
	RJ/UU8UPi9+7eSAzy3QKXH/U9siHX6HLlFoVNBqsSxeHLawdl0js9iwbqxKIL+Zkde1L+uO4FAL
	2Gg6YSsyCM7tafK7IfpDO0Y4ZZmOP+iqiyq/t4NFM6Sl/nYy4N0LbDHJmJBGwmUB8OWrdkz3lQ5
	SO7ii+GtdpekHeOTTuCqdSKcuQ/2HqRahhEvlX5D2waASirp8S6K2uvQKs30ZckdallOQLjqm/j
	377wo2K+yU6wGfI27QOQTd/IjymR1bW6mGOx6xquzQZVAK8MaVgs9Fsvgl5SGc0UAynLidscpBh
	fdRKUVe96T1lj4U7TXi+U2zyBZyJq9DZWLYlT8Q9e9LHsF4xg=
X-Received: by 2002:a17:903:28f:b0:2c1:ee6e:4e4a with SMTP id d9443c01a7336-2c6bd42f433mr1976285ad.27.1781713735778;
        Wed, 17 Jun 2026 09:28:55 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a3ee1052sm47252525ad.48.2026.06.17.09.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 09:28:54 -0700 (PDT)
Date: Wed, 17 Jun 2026 09:28:50 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v6] vfio: selftests: Find devices that have VFIO selftest
 drivers
Message-ID: <20260617161412.GA2704872.vipinsh@google.com>
References: <20260602222941.3133236-1-jrhilke@google.com>
 <aiHW_1vBrukpuaW2@google.com>
 <CALzav=cb=SaTtkwdTpK32Nboq6Uj8WKiN_=wRfpO+zugdjLRCA@mail.gmail.com>
 <CALzav=dCjGHMfDaW87jKOhquUvY6uEns1i+wGY1Kbq2A7Pfreg@mail.gmail.com>
 <aiMTJa1KHHgpTbDq@google.com>
 <ajK_P2AEGLvKD5US@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajK_P2AEGLvKD5US@google.com>

On Wed, Jun 17, 2026 at 03:37:35PM +0000, David Matlack wrote:
> On 2026-06-05 11:19 AM, Sean Christopherson wrote:
> > On Fri, Jun 05, 2026, David Matlack wrote:
> > > On Thu, Jun 4, 2026 at 1:30 PM David Matlack <dmatlack@google.com> wrote:
> > > >
> > > > On Thu, Jun 4, 2026 at 12:50 PM Sean Christopherson <seanjc@google.com> wrote:
> > > > >
> > > > > On Tue, Jun 02, 2026, Josh Hilke wrote:
> > > > > > Add a new script, list_supported_devices.sh, which prints out the
> > > > > > segment:bus:device.function (SBDF) numbers and names of devices on a
> > > > > > machine that have a VFIO selftest driver. This makes it easier to
> > > > > > determine if the system is capable of running VFIO selftests.
> > > > > >
> > > > > > Includes a -q (quiet) argument which prints just the SBDFs so that the
> > > > > > output can be passed to tools/testing/selftests/vfio/scripts/setup.sh
> > > > > > (e.g. via xargs) to bind the devices to VFIO to use in VFIO selftests.
> > > > > >
> > > > > > Examples:
> > > > > >
> > > > > > $ ./list_supported_devices.sh
> > > > > > 0000:6a:01.0 - Intel DSA SPR [8086:0b25]
> > > > > > 0000:6f:01.0 - Intel DSA SPR [8086:0b25]
> > > > > > 0000:74:01.0 - Intel DSA SPR [8086:0b25]
> > > > > >
> > > > > > $ ./list_supported_devices.sh -q
> > > > > > 0000:6a:01.0
> > > > > > 0000:6f:01.0
> > > > > > 0000:74:01.0
> > > > > >
> > > > > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > > > > > Signed-off-by: Josh Hilke <jrhilke@google.com>
> > > > >
> > > > > NAK, until this stuff is fixed and properly documented.
> > > > >
> > > > > This script needs to (a) communicate that some of the devices may be on VFIO's
> > > > > denylist, (b) NOT report them by default, (c) let the user report denylisted
> > > > > devices, (d) make it *very* clear in the output that a device, and (e) ideally
> > > > > provide the user with a hint of how that might be able to test a denied device,
> > > > > e.g. by reloading vfio-pci with disable_denylist=1.
> > > > >
> > > > > Nothing in here so much as mentions that these "supported" devices may be
> > > > > disallowed by the kernel, including the devices that's USED AS THE EXAMPLE.
> > > > >
> > > > > The DSA SPR devices has been on the naughty list since commit 95feb3160eef ("VFIO:
> > > > > Add the SPR_DSA and SPR_IAX devices to the denylist") from 2024, so I have a
> > > > > very hard time believing y'all weren't aware of this.  And if you really truly
> > > > > weren't aware of this quirk, than what exactly are you even testing!?!?
> > > > >
> > > > > C'mon.
> > > >
> > > > Yeah vfio_pci.disable_denylist=Y is required to use the Intel DSA SPR
> > > > device. This script is a great place to capture that previously hidden
> > > > requirement.
> > > >
> > > > Your proposed (a)-(e) sound good to me.
> > > 
> > > Another direction we could go in here would be to set disable_denylist
> > > to Y in setup.sh (if it is currently N) and set it back to N in
> > > cleanup.sh (after the last device is cleaned up and only if it was
> > > previously N). I was already thinking about doing something similar
> > > for setting enable_srio to Y for Raghu's new SR-IOV uAPI test.
> > > 
> > > The only issue is that disable_denylist is not currently writable. I
> > > don't see any functional reason why it can't be writable though. It is
> > > just sampled during probe. And from a security perspective, privileged
> > > users can already reload vfio-pci with different parameters if it is
> > > built as a module. But for built-ins, this would enable the denylist
> > > to be disabled.
> > 
> > IMO, any changes to setup.h are completely orthogonal.  list_supported_devices.sh
> > can and will be run independently, e.g. by people like me, and so absolutely needs
> > to claim a device is supported when it's obviously not.
> > 
> > Actually, that's a good amendment to (b) above.  Instead of *never* reporting
> > denylisted devices by default, have the script check disable_denylist and act
> > accordingly.  And then it's "just" a matter of communicating these details to
> > the user, e.g. so that a user can find devices that are supported by selftests,
> > but not by their currently loaded kernel+modules.
> 
> SGTM
> 
> Josh can you do this in v7? We'll probably need a flag to control
> whether the script lists devices not currently supported due to
> denylist, and how to convey all that to the user. I lean towards
> list_supported_devices.sh printing as much information as possible when
> run without arguments. So maybe a flag to hide denylisted devices.

Do we need then flag to hide denylisted devices? Instead, I think it should be
opposite (I think that what Sean is suggesting as amendment). If
the script finds vfio_pci.disable_denylist param value is:
 - Y, then just show those DSA devices if they are available on the
   host. Don't differenciate.
 - N, then don't show these denylist devices.

A flag can be added to show all of the VFIO selftests supported devices
present on the host with the warning next to denylisted devices or group
them in the output.

Flag case is for human consumption only.
