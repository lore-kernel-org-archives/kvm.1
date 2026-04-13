Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77342303CAB
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092843; cv=none; b=ebhCdQyG1A26lYxXvdmN9KTyeUSezWVI1OpW/1zNb5jt1DUEY7vIgefd8a76D83pHPQeG3FKS3ExypYOOzW5VTEdf7KOv0s1HVEfJQQeh6vowE/NVVB0C5P8Y4CVe5lKkAvY9cgvGGkkKP89QJ3PLSVstpOnt1WEj5J5DqdHIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092843; c=relaxed/simple;
	bh=NewV9KVkNqeJ2QeuN3kw9Xl+IcU9micw1j7rae/XdQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZztrUaddEzf8PCKH3sXxKXkEWyiSMGAQlZENHELU3yE5kC3kCBzyPn90E3pRTX+nJ41NF6b44bakjuKGp9ceb4UcAGn48/NxUuyv/jZWTMcRc8d3AXwd4HIxUaaYVX/HXBv5keuQFcQU6o5DG0ONp8wI6C0WJyXJ/DzUZ3dorS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sT1WZBLp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sT1WZBLp"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82ce50e6e28so2612098b3a.2
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 08:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776092842; x=1776697642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BTPPnII55fTl2cCLZlpyrHfIkwQJqSFZt8g3ORfSnBw=;
        b=sT1WZBLpYlH3HQ6WwOz13h336wC3v3K5eBtiu62+e/UTjZOwrVOYJH4oFadNjeY2H/
         Ko5YP+6RhGflMdsbheoL7RC2/VGY5cD0TU2XJvBbKe/KKhqKYFCdsJrjlm0fcheOw24+
         aoqfJeUbYAU6Vs7lYQr6LBchQWrW3z+6tPIM6p7isFrWBSAdchGn/6LNMoDXzCLQUAt/
         Is40PUkJsnY9B2UUvNdQCB70y0P44V3CR721j+WP02nILX7LTjAlcgmAiWsisIiOnsqO
         7AH/zGmq0vMvx9d3sFl/pRfqyIQ2EZkQprSVC04Dn0knyeCIj/Jb1j4j1hBjR/+gwkKH
         EspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776092842; x=1776697642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTPPnII55fTl2cCLZlpyrHfIkwQJqSFZt8g3ORfSnBw=;
        b=pCRxvCQGBEA2NpBS7JlY572zrpbI6gUtzvZpzaFTvxK1+aymTUq0+KCE6rykxs62Iq
         Rh0L0MK8Kygscn+pa0phT5f0cjwwyMDhVU7tLNNqEv4VNm3wn8y1wY8GZJV0hTC6WMFU
         EUEIrna+xMd33FgL1h6qMgZ9vUUYa/VN4JzMoWTAGzmBHNNjGV0wGC4PoXdIqDYriObF
         gMNFutHdrXdsE3nd/Rkpaux1QgEwOgjlV/5G5s9bUde9uneLnfzroe6D+sj15NPSJ0Id
         IsgFK+xGuNycqST0vsIMGNmNVRQzgkgMXWlD4UPyLVw7DlzoJYiEg5weONjsn3c1455R
         X2fg==
X-Forwarded-Encrypted: i=1; AFNElJ/3ZDZ5256T8sMKhzDYAlf9zaTdC2Zm+9Pk/JaX76q3m0ohGQZ2eoRf3JTTdhd/sywyXFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAZecF9+0KVXs92HM2uDLDj1Aeo9tiB3UzWFK3eVDEHlxFNhxL
	EH1aPCEJVgksDffNSdKISpxBGojb2pKweUS+6rclgj+Ytia8KQph4qV6Da1Jyq2QUMid0VMXLDs
	A2dLBog==
X-Received: from pfbdw7.prod.google.com ([2002:a05:6a00:3687:b0:82f:4afa:eef2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e9d:b0:82f:48e:2421
 with SMTP id d2e1a72fcca58-82f0c29c84amr13850092b3a.24.1776092841533; Mon, 13
 Apr 2026 08:07:21 -0700 (PDT)
Date: Mon, 13 Apr 2026 08:07:20 -0700
In-Reply-To: <adl_nGI5IEc815fb@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409015139.2800185-1-jrhilke@google.com> <20260409015139.2800185-3-jrhilke@google.com>
 <adl_nGI5IEc815fb@google.com>
Message-ID: <ad0GqAsFpAgA6g5u@google.com>
Subject: Re: [PATCH 2/2] vfio: selftests: Automate setting up devices for testing
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Josh Hilke <jrhilke@google.com>, Alex Williamson <alex@shazbot.org>, 
	Vipin Sharma <vipinsh@google.com>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 10, 2026, David Matlack wrote:
> On 2026-04-09 01:51 AM, Josh Hilke wrote:
> > Update the VFIO selftest setup script to find a device that has a VFIO selftest
> > driver on the system, and set it up (i.e unbind that device from its driver, and
> > then bind that device to VFIO).
> 
> I am leaning toward putting this behind an explicit flag (maybe -p for
> pick_device or -a for automatic device setup?) that way we are sure the
> user is ok with letting the script start messing with devices on their
> system.

In the spirit of "do one thing and do it well", I would rather put "discovery" in
a separate script entirely, and then tweak setup.sh as necessary to allow piping
in a BDF from the discovery script.

The mechanics of configuring a device for VFIO (setup.sh) are largely generic,
i.e. not unique to the selftests, whereas print_supported_devices() is very much
tightly coupled to selftests.

And with respect to making sure the user actually wants the script to mess with
their system, the permissions required for each script can and should be different.
`lspci`, and discovery in general, typically doesn't require root, whereas most
systems will be configured to have things like "sriov_numvfs" writable only from
root.
