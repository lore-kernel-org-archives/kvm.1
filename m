Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415869;
	b=UKo7gGCPxP56u7rUcQUBaqGV3jvQM62YumIMCwss2RCKCGswUtivGlU94Ac0XYqgDj3B
	 OBB6GyRXw2DBww9r1JGi0RuwZH8NbGqODLD/D+72gQkzHZ+ohwjoX+LN+VD+4Q3eaYsYt
	 OcRCGcimEJsC3ZeWDxWfwNPqBVo7Z7hDUiS/2XMHbfCk4PME6OFyCNUNHJ3sUwlysuc2m
	 /OpAoXJde1PdAAQCTfw9giWyA4bj6PtTdfR1EEpirshUB7KbeTz7WhG+CQTfX3NksOio2
	 OJ99RnZtm1r4db1SecqKEW/LtrH4vFeef2NdJaHETpJ3YZNt4UbTU6/DhAw1v+O0HZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=gg3re7vfdE1PsPwfbeOVGKGJ4XbC0yjKrXDhwXuaVP4=;
	b=Af4eb5F8W4lEuaG5ZzTLKc819IJsSqSmiRZtoaIXNqnelKdO1TgUvtUnY14LaRgQw01m
	 4vQiFFZjC9gRYE/pL7ZadNhvXJEuOn3hx+IaIIEwA/8qx8nomUJQ5Cix9FkR1tMDHtdd6
	 7umWAD0fBMSn5TWOdcmdejpGEOcw4esrkUqzbQY2C0sjMhbIC6VkkPDspSPBbSD25r75G
	 h6/qLDQuBi1nExX9cpsRBnVMPLMYbBFqX/aMcO6tk3psiRKHZXydAUH0Gmw8eI5XOseIC
	 uDvsKlHFIt+T3oov7uZrcPwzOawg5m1rRPx7f/KvygU/0NZTxHcyNjvAtQsPJbNRcmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DpFIQAw4;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10D606A32A
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 16:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A10D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DpFIQAw4
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad53f538d2so2775934a91.3
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 08:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794415869; x=1795020669; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gg3re7vfdE1PsPwfbeOVGKGJ4XbC0yjKrXDhwXuaVP4=;
        b=DpFIQAw4llDvNG5hev7PFtpFHBY0O0Gx1r2iMDRF3rDzmMVzBttMpdTyEIIC/a817f
         kPw3q+yaFWD6wKP92abhdMfT1k1wfhjBi4n8FLvonfw/Rova2XV8BU8A1L2PI5CrRVSe
         YMFYI82jrSpje3YIjTWlAQkiwI0Cl7gQy5LX3P5D60tSbDgRPcuqdbDgQk35QBohd0Kf
         gjCps2EGCxVFY5zFSr6AsqnFy1pAxoglo4mWLkw8CbCXpbG2Yxg0MxIj2sjiNceSnzUe
         xSfAIS1MEtVqQ7rHC8C1ZluanraXLIGOsbeX46MD/MWVd54NkgnGBgIOKOQ/DuXMKJ5s
         gb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415869; x=1795020669;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gg3re7vfdE1PsPwfbeOVGKGJ4XbC0yjKrXDhwXuaVP4=;
        b=NGoZnsAgMkEkBEr44A9h3zZWtl8pJh2iWy38RlfShQVi93BHbZo18K7qME/03HQwX6
         /O/eYITq5x4yik6vZTvamEL5NKCIsxu/Fm49Wla4o+MxybgvhtUmDaRfwb9NF7uEH3JI
         Guu/ajmZ9pbW1B0cM5zAP6K1hfQDmrWCjr6Cv9CT1gZbczp1p0M7J6b3y6Sx2oIxNVL9
         NET4tVPz5MyOkjOSEUZN+11IkSl8jmmflxcRoV2V96CDMXH3YwW9YfEeEY+lNDChphZi
         bg6hAF1nkOJtdil2jhWfmVWAFDUTs2pHlZLPX2usr4jy3AKZ8GlMmr6g7AxSGxGf8t1G
         ITXA==
X-Forwarded-Encrypted: i=1; AL+hErHxFajVdAKVohxScFsmJO3HyRKwXa5mqWfmtt92RDLtXJaQQYSRnn/znF8vUlAwykkNbX0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xDRV7p/KuhuHkP6YO0zOlakPXJs+0rdnUEyx3m10YDMciV2Hd
	tJxK53axAT/Vexvn/AvteTe+3damOTXhS9+naSIcm61zt7AGuUArAS9zcRySbCZF6UZdEFLl+IR
	LoZaLdA==
X-Received: from pjbev6.prod.google.com ([2002:a17:90a:eac6:b0:3b0:e553:8f2c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1647:b0:3a8:c0cd:57f9
 with SMTP id 98e67ed59e1d1-3b182f26a0emr3165414a91.25.1794415868591; Wed, 11
 Nov 2026 08:51:08 -0800 (PST)
Date: Wed, 11 Nov 2026 08:51:07 -0800
In-Reply-To: <20261106051726.3964374-1-jrhilke@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106051726.3964374-1-jrhilke@google.com>
Message-ID: <avSc-7J5JpEamGGl@seanjc-mac.roam.internal>
Subject: Re: [PATCH v7] vfio: selftests: Find devices that have VFIO selftest drivers
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 06, 2026, Josh Hilke wrote:
> Add a new script, list_supported_devices.sh, which prints out the
> segment:bus:device.function (SBDF) numbers and names of devices on a
> machine that have a VFIO selftest driver. This makes it easier to
> determine if the system is capable of running VFIO selftests.
> 
> Some of these devices are on the vfio-pci denylist, so vfio-pci refuses
> to bind them unless vfio_pci.disable_denylist=Y. The script marks such
> devices as DENYLISTED and prints how to enable them, so the user is not
> left wondering why the selftests cannot use a "supported" device.
> 
> Includes a -q (quiet) argument which prints just the SBDFs of devices
> that vfio-pci can bind, so that the output can be passed directly to
> tools/testing/selftests/vfio/scripts/setup.sh. Does not print the SBDF
> of a device on the denylist.
> 
> Examples on a host with eight Intel DSA devices:
> 
> $ cat /sys/module/vfio_pci/parameters/disable_denylist
> N
> 
> $ ./list_supported_devices.sh
> 0000:6a:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED)
> 0000:6f:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED)
> ...
> vfio-pci does not bind DENYLISTED devices while
> vfio_pci.disable_denylist=N. To use them, reload vfio-pci:
>   modprobe -r vfio-pci
>   modprobe vfio-pci disable_denylist=1
> If vfio-pci is built into the kernel, boot with
> vfio_pci.disable_denylist=1 instead.
> 
> With vfio_pci.disable_denylist=Y, the script lists the same devices with
> "(DENYLISTED, but vfio_pci.disable_denylist=Y)", prints no hint, and
> includes them in the -q output:

Sorry for dragging this on, but I still find the output painful to read.

To me, this does not make it obvious that the devices are usable/available:

  # ./list_supported_devices.sh
  0000:6a:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED, but vfio_pci.disable_denylist=Y)
  0000:6f:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED, but vfio_pci.disable_denylist=Y)
  0000:74:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED, but vfio_pci.disable_denylist=Y)
  0000:79:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED, but vfio_pci.disable_denylist=Y)
  0000:e7:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED, but vfio_pci.disable_denylist=Y)
  0000:ec:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED, but vfio_pci.disable_denylist=Y)
  0000:f1:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED, but vfio_pci.disable_denylist=Y)
  0000:f6:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED, but vfio_pci.disable_denylist=Y)

Especially if I glance at the output of the "bad" state:

  # ./list_supported_devices.sh
  0000:6a:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED)
  0000:6f:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED)
  0000:74:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED)
  0000:79:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED)
  0000:e7:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED)
  0000:ec:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED)
  0000:f1:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED)
  0000:f6:01.0 - Intel DSA SPR [8086:0b25] (DENYLISTED)
  vfio-pci does not bind DENYLISTED devices while
  vfio_pci.disable_denylist=N. To use them, reload vfio-pci:
    modprobe -r vfio-pci
    modprobe vfio-pci disable_denylist=1
  If vfio-pci is built into the kernel, boot with
  vfio_pci.disable_denylist=1 instead.

IMO, the blurb at the end is also unnecessarily noisy.  I don't think we need to
tell the user how to manage kernel modules.  I realize I'm setting a double
standard with respect to assumed knowledge, but IMO knowing how to load kernel
modules is table stakes for anyone running this script.

The blurb (and strictly speaking, the scirpt as a whole) is also somewhat
misleading because it doesn't actually verify that vfio-pci is loaded.

Rather than squish everything into a the per-device output, what if we organize
the devices so that it's more obvious what is what, and so that the output isn't
as noisy/redundant.  E.g. something like the below.  And for the -q output, it
probably makes sense to also provide a flag to show/hide unusable devices.  Probably
to show?  i.e. have -q output show only fully supported devices by default?  And
maybe fail -q outright if vfio-pci isn't loaded?  Dunno about that last one, not
sure what would be the least confusing.

If vfio-pci is loaded with disable_denylist=1 and there are both allowed and
denied-by-default devices (ignore that they're all the same device):

# ./list_supported_devices.sh
Supported
  0000:6a:01.0 - Intel DSA SPR [8086:0b25]
  0000:6f:01.0 - Intel DSA SPR [8086:0b25]
  0000:74:01.0 - Intel DSA SPR [8086:0b25]
  0000:79:01.0 - Intel DSA SPR [8086:0b25]
  0000:e7:01.0 - Intel DSA SPR [8086:0b25]
  0000:ec:01.0 - Intel DSA SPR [8086:0b25]
  0000:f1:01.0 - Intel DSA SPR [8086:0b25]
  0000:f6:01.0 - Intel DSA SPR [8086:0b25]

Supported (on denylist, but denylist disabled)
  0000:6a:01.0 - Intel DSA SPR [8086:0b25]
  0000:6f:01.0 - Intel DSA SPR [8086:0b25]
  0000:74:01.0 - Intel DSA SPR [8086:0b25]
  0000:79:01.0 - Intel DSA SPR [8086:0b25]
  0000:e7:01.0 - Intel DSA SPR [8086:0b25]
  0000:ec:01.0 - Intel DSA SPR [8086:0b25]
  0000:f1:01.0 - Intel DSA SPR [8086:0b25]
  0000:f6:01.0 - Intel DSA SPR [8086:0b25]

Versus if vfio-pci is loaded with disable_denylist=0:

# ./list_supported_devices.sh
Supported
  0000:6a:01.0 - Intel DSA SPR [8086:0b25]
  0000:6f:01.0 - Intel DSA SPR [8086:0b25]
  0000:74:01.0 - Intel DSA SPR [8086:0b25]
  0000:79:01.0 - Intel DSA SPR [8086:0b25]
  0000:e7:01.0 - Intel DSA SPR [8086:0b25]
  0000:ec:01.0 - Intel DSA SPR [8086:0b25]
  0000:f1:01.0 - Intel DSA SPR [8086:0b25]
  0000:f6:01.0 - Intel DSA SPR [8086:0b25]

Unusable (available, but denylisted by the kernel):
  0000:6a:01.0 - Intel DSA SPR [8086:0b25]
  0000:6f:01.0 - Intel DSA SPR [8086:0b25]
  0000:74:01.0 - Intel DSA SPR [8086:0b25]
  0000:79:01.0 - Intel DSA SPR [8086:0b25]
  0000:e7:01.0 - Intel DSA SPR [8086:0b25]
  0000:ec:01.0 - Intel DSA SPR [8086:0b25]
  0000:f1:01.0 - Intel DSA SPR [8086:0b25]
  0000:f6:01.0 - Intel DSA SPR [8086:0b25]

  To use denylisted devices, load vfio-pci with disable_denylist=1
  (or boot the kernel with vfio_pci.disable_denylist=1).

Versus if vfio-pci isn't loaded at all:

# ./list_supported_devices.sh
Unusable (available, but vfio-pci not loaded)
  0000:6a:01.0 - Intel DSA SPR [8086:0b25]
  0000:6f:01.0 - Intel DSA SPR [8086:0b25]
  0000:74:01.0 - Intel DSA SPR [8086:0b25]
  0000:79:01.0 - Intel DSA SPR [8086:0b25]
  0000:e7:01.0 - Intel DSA SPR [8086:0b25]
  0000:ec:01.0 - Intel DSA SPR [8086:0b25]
  0000:f1:01.0 - Intel DSA SPR [8086:0b25]
  0000:f6:01.0 - Intel DSA SPR [8086:0b25]

Unusable (available, but vfio-pci not loaded, and denylisted by the kernel):
  0000:6a:01.0 - Intel DSA SPR [8086:0b25]
  0000:6f:01.0 - Intel DSA SPR [8086:0b25]
  0000:74:01.0 - Intel DSA SPR [8086:0b25]
  0000:79:01.0 - Intel DSA SPR [8086:0b25]
  0000:e7:01.0 - Intel DSA SPR [8086:0b25]
  0000:ec:01.0 - Intel DSA SPR [8086:0b25]
  0000:f1:01.0 - Intel DSA SPR [8086:0b25]
  0000:f6:01.0 - Intel DSA SPR [8086:0b25]

  To use denylisted devices, load vfio-pci with disable_denylist=1
  (or boot the kernel with vfio_pci.disable_denylist=1).
