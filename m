Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF5349690A
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710675; cv=none; b=Nc/h4WIEBDWm4H7HYhESmFW3mljXa8/K8ZkF7wqUeAnet7ZVRmeE3pc4oYIa1xE79fAKn7Z5m1i7I/1vowAjpkw7oIYjhcNCkgTyzpBYhk42THNl+pDwcJldjKEyghgScAONVm/XbLieq/czkRZ2IVZ6okzHghgNw5rTMfVu9hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710675; c=relaxed/simple;
	bh=bc69wBq2NH6ty+sum9MiAmxf6DzoX6x3UszNK/XTWKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5tyN5W2wr3tquVXnB+bOy9gxqB+3U+OM1dPWZ/e8D2LurmGDESJHZkFEJCwMZDyLt7xc/f7t/l7+RAcgss9bG3assEQgnvqrb7cb8AUgR7fnJMxCkiKyEmbvV/hVFOiyrZlsUz4ai+bL95uNoikJoLILTjBk8B0S4c3ByiVSiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ap2b3Btz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ap2b3Btz"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36d8b644473so5116464a91.3
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781710660; x=1782315460; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GKd6b+WufKYKVi+Itkm90GNjDyaZCJZDAg9Po0kQfu8=;
        b=ap2b3BtzVRRI4LctJJHwIyw2/FZY615ABdWsxogwNZEDeskSUWDxqfSsyx2YhkeITe
         BZtE4anWUYU2jLteqIyJr3jgrf85O3dD9lbMKuPlTvc1MkSY12mdtq4PPph+Yx0yMMST
         5llQGdoUpSwIURNyw9+LMO7qnc6QXjOjy/PEJV3g7tl4Lp6X0BSk2sYGTGbXFAjDoe0N
         CCJejm+/WhZR8E1zzTFUA/Tz+T5QMmKLKRDy8tFox6TbXYCTDjeUFII+SYwrv187lHeg
         OxvJr4FNq0vtsxsmvqtO69vYPOmuqoTBstppoqy9ikGNIB2By7Ac8LhnbbZDENSaPb1x
         Nwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781710660; x=1782315460;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKd6b+WufKYKVi+Itkm90GNjDyaZCJZDAg9Po0kQfu8=;
        b=px3feEiq59uqulDS/P7Mftq0za4zKvSsi6x7fc8vzuLGRXh6Rw0GpqEAIjV6etqNh3
         PUWjeLAfitOTD1gzZyj5pBz/YzNVYnzgsQhabYlXGGkgO5xByoAsr6npUr8qO5ygA1TS
         5UmMiKw9/uxl5ERyWQVFdV1BAViDxv0UWzElnWvAJmbUrDzaAUnzBzzj5BgB52g8JfcT
         Sj4AncbQF+tqXvUC1L+12B4oTqVUFmzxJGlt0yGT1z6jgKYAYcB5TNxVZj4H8N6dx/Kr
         jaBjr3WT2SuDWqd+hwUUv+PmCe/UZmaMppUoFK6RKuHaTNQJafsZW6JVfGwlhAWqafu2
         XQ7Q==
X-Forwarded-Encrypted: i=1; AFNElJ9G7W5ZnQT2bmrr0nD8fRSV2T+HspH02V30z7CDP/LzYW3xlXDHXwePDUZtIu+8OPlQOGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyihc6IabCzmNQk6rqf3nHvHIwNIVHRnJs5aeL4QLJUq4/nHAXz
	p6698V89EauBu5K0BeJ+59pxjblqg2MIkp+snpQwatBNRsvKZTZo90yrwI9tPNXuPw==
X-Gm-Gg: AfdE7ckxwWcAV7SrQ2IZDjF5LWHFsQwnqiarsXH2Zzkpu7hE/ScJTM5US/EVML2ZPEb
	cjyV/Juu8Mr4Cv/Cm4wcWL65bRVL6xtFDE7vObNPeIoKG/bWVJZTDwc5iFDjAY+hk1J1GMAANtb
	T8t9k/PBKU92yGtZ6vmRqQfZqhjj0RcyrY+2ecSt2IlWWsbE1IRm7V2c8KArjHr87SOeF9Eb/zb
	OgGuY0GayGU7/pMS3YypllqJt0F+iLqe+1prjuTAFhapDQis883TCd67iATf2MomNW6Jrvu7svd
	Sy59WVPwlAfATvBdJQQZnn4C1HaFp32b4McvpGTdGawGr8sAbN3UOzh6TLwg0C7M0IqxF8RBiij
	+ifMhgfL1tvFO7u6hRbuRvEJgJhSD5k+ooKZGdF2bNhjGJO+ja3j3MBYJY0qhCAn+nRWccF1DWb
	gXjMmipsV7thzb8/J6U018C4SVQ1zIOMYBOu6UiHp9ZQYUqb/vW/s=
X-Received: by 2002:a17:90b:568c:b0:36b:a0fa:ff96 with SMTP id 98e67ed59e1d1-37c9405031amr4063979a91.12.1781710659141;
        Wed, 17 Jun 2026 08:37:39 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c5222e07fsm6260474a91.17.2026.06.17.08.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:37:38 -0700 (PDT)
Date: Wed, 17 Jun 2026 15:37:35 +0000
From: David Matlack <dmatlack@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Josh Hilke <jrhilke@google.com>, Alex Williamson <alex@shazbot.org>,
	Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v6] vfio: selftests: Find devices that have VFIO selftest
 drivers
Message-ID: <ajK_P2AEGLvKD5US@google.com>
References: <20260602222941.3133236-1-jrhilke@google.com>
 <aiHW_1vBrukpuaW2@google.com>
 <CALzav=cb=SaTtkwdTpK32Nboq6Uj8WKiN_=wRfpO+zugdjLRCA@mail.gmail.com>
 <CALzav=dCjGHMfDaW87jKOhquUvY6uEns1i+wGY1Kbq2A7Pfreg@mail.gmail.com>
 <aiMTJa1KHHgpTbDq@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiMTJa1KHHgpTbDq@google.com>

On 2026-06-05 11:19 AM, Sean Christopherson wrote:
> On Fri, Jun 05, 2026, David Matlack wrote:
> > On Thu, Jun 4, 2026 at 1:30 PM David Matlack <dmatlack@google.com> wrote:
> > >
> > > On Thu, Jun 4, 2026 at 12:50 PM Sean Christopherson <seanjc@google.com> wrote:
> > > >
> > > > On Tue, Jun 02, 2026, Josh Hilke wrote:
> > > > > Add a new script, list_supported_devices.sh, which prints out the
> > > > > segment:bus:device.function (SBDF) numbers and names of devices on a
> > > > > machine that have a VFIO selftest driver. This makes it easier to
> > > > > determine if the system is capable of running VFIO selftests.
> > > > >
> > > > > Includes a -q (quiet) argument which prints just the SBDFs so that the
> > > > > output can be passed to tools/testing/selftests/vfio/scripts/setup.sh
> > > > > (e.g. via xargs) to bind the devices to VFIO to use in VFIO selftests.
> > > > >
> > > > > Examples:
> > > > >
> > > > > $ ./list_supported_devices.sh
> > > > > 0000:6a:01.0 - Intel DSA SPR [8086:0b25]
> > > > > 0000:6f:01.0 - Intel DSA SPR [8086:0b25]
> > > > > 0000:74:01.0 - Intel DSA SPR [8086:0b25]
> > > > >
> > > > > $ ./list_supported_devices.sh -q
> > > > > 0000:6a:01.0
> > > > > 0000:6f:01.0
> > > > > 0000:74:01.0
> > > > >
> > > > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > > > > Signed-off-by: Josh Hilke <jrhilke@google.com>
> > > >
> > > > NAK, until this stuff is fixed and properly documented.
> > > >
> > > > This script needs to (a) communicate that some of the devices may be on VFIO's
> > > > denylist, (b) NOT report them by default, (c) let the user report denylisted
> > > > devices, (d) make it *very* clear in the output that a device, and (e) ideally
> > > > provide the user with a hint of how that might be able to test a denied device,
> > > > e.g. by reloading vfio-pci with disable_denylist=1.
> > > >
> > > > Nothing in here so much as mentions that these "supported" devices may be
> > > > disallowed by the kernel, including the devices that's USED AS THE EXAMPLE.
> > > >
> > > > The DSA SPR devices has been on the naughty list since commit 95feb3160eef ("VFIO:
> > > > Add the SPR_DSA and SPR_IAX devices to the denylist") from 2024, so I have a
> > > > very hard time believing y'all weren't aware of this.  And if you really truly
> > > > weren't aware of this quirk, than what exactly are you even testing!?!?
> > > >
> > > > C'mon.
> > >
> > > Yeah vfio_pci.disable_denylist=Y is required to use the Intel DSA SPR
> > > device. This script is a great place to capture that previously hidden
> > > requirement.
> > >
> > > Your proposed (a)-(e) sound good to me.
> > 
> > Another direction we could go in here would be to set disable_denylist
> > to Y in setup.sh (if it is currently N) and set it back to N in
> > cleanup.sh (after the last device is cleaned up and only if it was
> > previously N). I was already thinking about doing something similar
> > for setting enable_srio to Y for Raghu's new SR-IOV uAPI test.
> > 
> > The only issue is that disable_denylist is not currently writable. I
> > don't see any functional reason why it can't be writable though. It is
> > just sampled during probe. And from a security perspective, privileged
> > users can already reload vfio-pci with different parameters if it is
> > built as a module. But for built-ins, this would enable the denylist
> > to be disabled.
> 
> IMO, any changes to setup.h are completely orthogonal.  list_supported_devices.sh
> can and will be run independently, e.g. by people like me, and so absolutely needs
> to claim a device is supported when it's obviously not.
> 
> Actually, that's a good amendment to (b) above.  Instead of *never* reporting
> denylisted devices by default, have the script check disable_denylist and act
> accordingly.  And then it's "just" a matter of communicating these details to
> the user, e.g. so that a user can find devices that are supported by selftests,
> but not by their currently loaded kernel+modules.

SGTM

Josh can you do this in v7? We'll probably need a flag to control
whether the script lists devices not currently supported due to
denylist, and how to convey all that to the user. I lean towards
list_supported_devices.sh printing as much information as possible when
run without arguments. So maybe a flag to hide denylisted devices.
