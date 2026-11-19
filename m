Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048992;
	b=lLHcYCrtNc8JHfnYbIOLOtDTfjyWizvg02s6sCcwaHAQ2FM6lfcGNpxJezjs9/Llbkkb
	 urYdOZTRo6P1n61s3i8A1BxfYbpHqQ7I3PG72RsEdVPseG61NivByP5ji4EYCq+9oJCZ/
	 E6sCPxGc+Vzb11YgOuTN5cpnL12/tLxp4ih6ZPD6cGiJJVtETbcepOaWBHjnygSw2nKDD
	 46uVInPAkFpDpQ0RrmsficeDk+Y44Yu1E5eaIfGFaUNcpGiQd0ide2BBKaG32Yp6a0pOm
	 qCA0YnNxbneZJ/h2OTZ9D8gWopUod1jFHkjOsmbWZkYUAfUHeabfGvInnGWqOf8IiMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=rXGPcSA1LAN7NCQ0xg//sWiI3uTTDA49S1RmMjXykwc=;
	b=xK6cRm2H9X9aJLE1gBmaLvb2Qnur0TESfxByatWbQNFSpKyr0WvbUNd/okBkO/vkPgJ6
	 TrjLLopCtdb0ot8zyeCKdFAy4Qvtya2tAkQ/84uEAkyJkfA2vz+mO7Gz0a+A/gjEl/lDj
	 V1D6BfT7T+2y2D9WqqX+qqB79kqLHWCPzFcLKOnTlPqSdC+Ak+DVpWvlFu8eJOf33ZLzr
	 2MgV2OSS70+sXZPbdOS6Dm3MIj++39z5IbmqRPOLoStSI99FoQzdS6pdEFqs28iGQSWe4
	 k6KwlnTGc8vkKBuIRLt2G4XGUe88QTb0DvVu5PZSCJipwsud87LCTMQcTZtsREK8W0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LIPAilQv;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F97606A32F
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 00:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03F97606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LIPAilQv
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e9995ce866so13098455ad.0
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 16:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795048991; x=1795653791; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rXGPcSA1LAN7NCQ0xg//sWiI3uTTDA49S1RmMjXykwc=;
        b=LIPAilQvJZip+dNvCDt+jwWHOxTTJwBxK4WHMwkJtdslpQXa9vKtcLwza0BmGiflCG
         vR7u1/6PSH8ehBRSv/FqNaG3VIbKmkm2umJuQ0NvsDRFELLmSbYniTo4wtGYHjknJMmS
         6rnMkilATkEdzoQ79oSfop9eD+uYyLFOFVZLwY5rjVEuHbMpb7Twl3fGNNQ3Y7NF2AbZ
         RLWK4G/YGruAqz2iGuv79KBz7BCLI7n5BsCNhYqEaVqwOQJQSlF4UuTVh0/LEIRuPmW/
         FRxxDYqR5GwD28lkPzgZCcX8YqlL9ujMEJ7mc27zEwJ5QAZOXFXOgARXjFhN4ipvMOHW
         7xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795048991; x=1795653791;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rXGPcSA1LAN7NCQ0xg//sWiI3uTTDA49S1RmMjXykwc=;
        b=WqY6pH9XtO7s/C9JkPre7fjGl8NddTOs1XV8sgIAYtLKXFX7kgw5QDrlU4DVVk4rp5
         waju/fYF+DqLHYjadTwT+cijPjIlyTXzKomqLZ5BWwVIV7fv875VMSEhqExGM1GhpJQO
         ftC6c8pM8a4oYB4Q/3o3PloOKTwnXqi14cXX0udtY1wUnZKzuOgw3MUjNWKb4mo+kRCj
         2qKlOZC0XKIuRExR3vhupdbyMvVVGQlFfdXK84NswquLo6xrZCaYij8XpuuELOU22fNk
         BeAY9gxcr8CGAoma5fOBT4M6ajrKbQ0ucW/bnKcKRXemyMkAsP02tblgyLSjkoyBzAGu
         ytuw==
X-Forwarded-Encrypted: i=1; AL+hErHnVtaCVaGmfgi3go/95b8RAVn8d8ncXjB8xElfq9Q6KyjavcuXdlJvaU1mscju2s0Tkvc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dK8O0Quv0LkpvuSXXYpG1E9N4LrZIAUU3LhRqVhtxQVBpFMPB
	XS+F0HHiM1Azq3Mb1Dwy+aXl7E21C8b3dAv4B0hIH6rcBRmPH51M5/wpGZxt3cEWvg==
X-Gm-Gg: AZFdTZcoDELx37FMTTb1o0JgJcWPflxOcuR3Cj4jysyyXiPFRN9laljJdhNm+NcHRnC
	4w/muidM2gYog1RuK5tolv4GVk8RpozezuMdvmfrX4hnHHv6O4FEKvfjDNzjDw/jPWctwGR0ghQ
	XHgavJc2ugbN6olhQVROdulW7SPv52YH0EulhYmcWN7UWB7AkhWvl3rx9yX5QFhyLR80PkNwlim
	q+AmQkLBm9/fomAmdB/ezBlwVst+BtI2zKqK78TnjrmD12ofLFMZhNi/1PGdzNISOEiotpLy1jU
	9gFyOFvGQfLPZ1a5dZQeKrhtIG7xW9H8rmeSGY0kUWJZdqHH3YwUEiYZSu+kKmAHANii82Q5vMe
	cMdb9YCZAralFzwyePOOFgrIc6iwZ0M88Ah/6H8ANHUTuXExvprXUJhDxOcJq86iHHaWmtddBG4
	2YP4glxZ9hn65TwSkg6KqcZtqVv1jQq90/lBXNc1nHzRKziYrOPrA3mRq0kLd/vUnuzNrZZcoel
	T5OMisfv7C7kRS02/JzUoZkj34OuHeVJPjoeK/IVugPSLTln3n+ZFiKQYA2g1eV4zRws2jK798I
	rfZ49xRBIqnNVZo6LMTwRadhPOJ8p1KAyj6lrAXwOh3kTCWpfcaO3x7Y1XXu5DMk
X-Received: by 2002:a17:903:a8f:b0:2ed:205e:eabc with SMTP id d9443c01a7336-2eff7525970mr42302875ad.32.1795048989252;
        Wed, 18 Nov 2026 16:43:09 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6214cd8sm20785035ad.44.2026.11.18.16.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 16:43:08 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 16:43:07 -0800
Message-Id: <DMYRRCPO4FL8.HP2LYDQ286E0@google.com>
From: "David Matlack" <dmatlack@google.com>
To: "Josh Hilke" <jrhilke@google.com>, "Alex Williamson" <alex@shazbot.org>
Cc: "David Matlack" <dmatlack@google.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Sean Christopherson" <seanjc@google.com>,
 "Vipin Sharma" <vipinsh@google.com>
Subject: Re: [PATCH v8] vfio: selftests: Find devices that have VFIO
 selftest drivers
X-Mailer: aerc 0.21.0
References: <20261118064309.219592-1-jrhilke@google.com>
In-Reply-To: <20261118064309.219592-1-jrhilke@google.com>

On Tue Nov 17, 2026 at 10:43 PM PST, Josh Hilke wrote:
> +# Devices that have a driver in selftests/vfio/lib/drivers.
> +readonly DEVICES=3D(
> +	"8086:0b25,Intel DSA SPR"
> [...]
> +	"15b3:a2df,Mellanox BlueField-4 integrated ConnectX-8"
> +)

This is missing GPUs that are supported by the nv_falcon driver.

I saw in the v7 changelog that you left them out because
nv_falcon_probe() matches on PMC_BOOT_0 rather than PCI ID. But the
first thing nv_falcon_probe() does is check vendor =3D=3D 0x10de and base
class =3D=3D PCI_BASE_CLASS_DISPLAY, and the script can get both of those
from sysfs. And past that, nv_falcon_probe() only rejects GPUs with an
unknown architecture; unverified GPUs are accepted with a "possibly not
supported" message. So matching on vendor and class gets the script
about as close as the driver itself gets.

e.g. something like:

	read -r class < /sys/bus/pci/devices/${bdf}/class
	if [ "${vendor}" =3D "0x10de" ] && [ $((class >> 16)) -eq 3 ]; then
		...
	fi

Also, nv_falcon does not implement send_msi(), so on NVIDIA GPUs the
send_msi tests in vfio_pci_driver_test are skipped and kvm/irq_test
does not run at all. The script should make this clear when it reports
an NVIDIA GPU so users know they're getting reduced coverage.

Since the script can't check the GPU architecture itself, it would also
help to tell the user which architectures nv_falcon supports, so they
can check their GPU themselves. e.g. something like:

  Supported:
    0000:00:04.0 - Intel IOAT SKX [8086:2021]

  Possibly supported (depends on GPU architecture):
    0000:3b:00.0 - NVIDIA GPU [10de:1eb8]

    nv_falcon supports Kepler, Maxwell, Pascal, Volta, Turing, Ampere,
    Ada, and Hopper GPUs. It does not support send_msi().

Please add a comment next to the list of architectures pointing at
nv_gpu_arch_lookup() so the two stay in sync.

I think it's fine to include these GPUs in the -q output. If the GPU
turns out to be unsupported, vfio_pci_driver_test will just skip.

Printing the selftest driver name for each device might also help
here, and would make it easier to tie the list back to lib/drivers/.

> +function vfio_pci_loaded() {
> +	[ -d ${VFIO_PCI_DRIVER} ]
> +}
> +
> +function denylisted() {
> [...]
> +function denylist_enforced() {
> [...]
> +function is_blocked() {

Please consistently use is_*() for functions that check a condition,
e.g. is_vfio_pci_loaded(), is_denylisted(), is_denylist_enforced(), and
is_blocked(). That makes call sites like this one read more clearly:

	if [ "${all}" ] || ! is_blocked ${id}; then

> +	if [ ${#allowed_devices[@]} -gt 0 ]; then
> +		print_allowed_devices "${allowed_devices[@]}"
> +	fi
> +
> +	if [ ${#denylisted_devices[@]} -gt 0 ]; then
> +		print_denylisted_devices "${denylisted_devices[@]}"
> +	fi

nit: When both groups have devices, there's no blank line between the
last "Supported:" entry and the "Unusable ...:" header, which makes the
output harder to scan.
