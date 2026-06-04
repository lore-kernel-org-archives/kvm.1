Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30813A4F36
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602626; cv=none; b=nHALRtQwtC/NYNAw+JMTbZe1O4NwuaLsmjkOdEgZuDdApAassu9bV4XnaQntrQPQ5RDOwfZzIuXp+zTDtMzWQingHugRjoevJHHiCxrCvaXHd8V2vp0RCONOeUhd1UDS23tyED3jZ/v23xniwITf2/vvj/7qWF20x2VXfXU9/a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602626; c=relaxed/simple;
	bh=ic2/hkbfge8PsFO82Mv8ssuYX6K6uPVDs1MvBJftmeE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IRvFXGbfKmwuWA8i/Az7Ag/u5I73gMfU/IhS32Sl4ASbHUvQ0v+QwZRk4zS5VFVcpS/7mjRuM55yGaYW65cBmNXuw8DNG8QfY8OqucDcdyDZq8ZAVXy/hPuP8NY4TvV2VwBIl82dzfXSw6k7hik7l7FTCvnVk+HLbyWrkKZ24Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u34bC1/F; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u34bC1/F"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85a2f19558so709025a12.2
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 12:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780602624; x=1781207424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1SxHCAyR3xIqZaBnBGnA7YeiYcOFt5K745HlrH3mwaU=;
        b=u34bC1/FzIDcqfNS5gXT/bWVuDOAkU/f7sPI3wDyB7/GvwiS/g3dy7PzBLZsKEYmtI
         w4slEmXaP+ZpJKARx7Sy3Idb0ZVZ8G8ArlxyVwC6+UdMaUz2CTID+s15vzvxiC7FDDcw
         gB8yMzrkRCI7pH2LOV3xFxUyguXsgDhHv9ZnkPTPjkQ/HnHn7jlqUtiZyhKRy8DbXRSV
         TwpunS6p36CY7V5VPn0nuYqOpgcKAbV++oJ/JzP16AgVhTPO+p+/WN9XkMtUh/DfR62H
         teYoUDJOrWVEmMT7+jQZCOAmdaQu/uLxLcMTPVpEwALXMxOlendcar66O7dsnBQ8rfE6
         rsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602624; x=1781207424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SxHCAyR3xIqZaBnBGnA7YeiYcOFt5K745HlrH3mwaU=;
        b=SsjHWs13/acR0qSVCgqknc1F1Wqm2HxYNM86efgDFj/gS+FSULl1lcrLeD04s+zniB
         Pr4rrZdfuLfRWYnUJtZIg1gczrRHLZB4pZN71l/k/09Qsx+bKf7QfAabZfgkm4QbO3v9
         M1tnRhba23bsQ44MTVhI4PFiAGxFkP10+tN2CNEjKjMNp1voHwBbOD8vYg6bV/DSSRds
         UhoE5sFfR9jnB5wwrEDYutQZ2gRR9Pah0vuhmwrxxXaRrgLIHn6qGBGXmbC/feTk4+P0
         jCHxWry6RlTrH54izSq+oEjq3Q88rfiFIk2yattvlfNQESF6nSuH8sPF0UBEuN4uLGVm
         smjw==
X-Forwarded-Encrypted: i=1; AFNElJ+5NqzvN+INdCsSSVITw/K+ndXGcGJGMVLuCj6l7TbHsN/caQOdvKgPv2eG1awEAoSPlIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyiksbsBgTn7mg/ZorjxadqkWSm6v8qs/unw3JSb7RHElZt0I9
	QybtZhTiCGramWegOgOk2OxvKcFAGL2ARezKw3dnrDRSFRnmzIzHh50PXccQ+KmknUx7xZ1ShPN
	bD49pkg==
X-Received: from pgvc19.prod.google.com ([2002:a65:6193:0:b0:c85:9c9a:ab5b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e04:b0:3b3:2703:110
 with SMTP id adf61e73a8af0-3b4ccd1b49cmr652884637.4.1780602623951; Thu, 04
 Jun 2026 12:50:23 -0700 (PDT)
Date: Thu, 4 Jun 2026 12:50:23 -0700
In-Reply-To: <20260602222941.3133236-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602222941.3133236-1-jrhilke@google.com>
Message-ID: <aiHW_1vBrukpuaW2@google.com>
Subject: Re: [PATCH v6] vfio: selftests: Find devices that have VFIO selftest drivers
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 02, 2026, Josh Hilke wrote:
> Add a new script, list_supported_devices.sh, which prints out the
> segment:bus:device.function (SBDF) numbers and names of devices on a
> machine that have a VFIO selftest driver. This makes it easier to
> determine if the system is capable of running VFIO selftests.
> 
> Includes a -q (quiet) argument which prints just the SBDFs so that the
> output can be passed to tools/testing/selftests/vfio/scripts/setup.sh
> (e.g. via xargs) to bind the devices to VFIO to use in VFIO selftests.
> 
> Examples:
> 
> $ ./list_supported_devices.sh
> 0000:6a:01.0 - Intel DSA SPR [8086:0b25]
> 0000:6f:01.0 - Intel DSA SPR [8086:0b25]
> 0000:74:01.0 - Intel DSA SPR [8086:0b25]
> 
> $ ./list_supported_devices.sh -q
> 0000:6a:01.0
> 0000:6f:01.0
> 0000:74:01.0
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Josh Hilke <jrhilke@google.com>

NAK, until this stuff is fixed and properly documented.

This script needs to (a) communicate that some of the devices may be on VFIO's
denylist, (b) NOT report them by default, (c) let the user report denylisted
devices, (d) make it *very* clear in the output that a device, and (e) ideally
provide the user with a hint of how that might be able to test a denied device,
e.g. by reloading vfio-pci with disable_denylist=1.

Nothing in here so much as mentions that these "supported" devices may be
disallowed by the kernel, including the devices that's USED AS THE EXAMPLE.

The DSA SPR devices has been on the naughty list since commit 95feb3160eef ("VFIO:
Add the SPR_DSA and SPR_IAX devices to the denylist") from 2024, so I have a
very hard time believing y'all weren't aware of this.  And if you really truly
weren't aware of this quirk, than what exactly are you even testing!?!?

C'mon.
