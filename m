Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633977;
	b=K+S1R3e+nLtixZOsc4YjpXSsLl0VWt3jPnKX1hWmbI+JVuaGIWjT5ZNTVM3k+Q9clTSs
	 8IGn4c0+wKIFgPZOJ+EFpf9Mnskzzl1p4qBrX8/PBFrC6vspAPDQXRL/dojaEvr6yjahX
	 NUX5Fw5CYKOC7d2XXNg52YhgA3PqBDYHrkQBR8mzCaKclTsTcMqKloIVNAJL2JLjuO15V
	 Qq34NZQCqezk3tmJZO8r7nHod9caVL4zz272x7CbbLsarCShUsu8TMqZQJyjllUK8lIae
	 M0bAxwtVO00XoWluutDPS6150IMFSPLf4DZ/dK/cE24nRgz8wtWsKuh1M9jgIsFwuDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=YB4Gj/bwdtqKdimiyrXCpXIQgGLQ/u8w3QhowIhVaN4=;
	b=M2moideUUzxj2AruBc3+DmjRwT48PIlr1JDD1y6h639GRilIIt9o+EyUJYvgWpq8/80m
	 zTxVhgtiyIHsCw6cZXlqXvx/NjB8ADez97OSpdTO7ZxywzbRcyQEKq4wHPe7RmdxlMIQS
	 oF6U+YAr1AjINq06FsKoQ6Jhprl7s4JekchAUnzLTKCbrVqEx9HxcOl/f5kxrwa01BZDd
	 4NE0hGWmrPPsJw2kDvcs+WGFb7M63L900N1YULUNXbiG8XXvkZa6ssqz9fcAZFONqmY8c
	 d7WVWVePgf2tCibUyl481JJSSst8+Kqntaban24MRtoHOhD5Ibwu9qJiXxeHRDVuuhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eLYv0AW7;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F26606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 19:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4F26606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eLYv0AW7
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f0213202fdso33154845ad.3
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795633976; x=1796238776; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YB4Gj/bwdtqKdimiyrXCpXIQgGLQ/u8w3QhowIhVaN4=;
        b=eLYv0AW75oPkxDz7XIhHggBJrokrS2krA0nKG8wbqCscce9LdPSEboCOTk7g13G7FI
         qXBVgqH4SjzCIodnE4eOn7zmayfvCnHhNlcAwo5hQwdEk3lPn850rvQTEuuFcWCZkpVc
         hDZ/uBu2bf4HcMwKr1HxD8dxh9/EgppDnM9IwnexfsS30EKly3iMwSm6lALM1o0HsLJS
         IbiQZ/tanUcljgdSPHjdzPcs4FEMpa43NPbCQKw3AKKZU2XtYjqBGAU/OpEk+FpGvzpj
         aj90gm4ZCMw0mWuvcnQGjsNhJg9Hlrz1Gj3XAHkkP7ZcFCENcLF+Cys+XE9i2SES5bTJ
         Q7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633976; x=1796238776;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YB4Gj/bwdtqKdimiyrXCpXIQgGLQ/u8w3QhowIhVaN4=;
        b=RWchYY9HuHbAttpzQ1Qd+pJ2PPn7FywaGc1UZJCU+GSM0PzOvhvnlihApkySrnIzJ9
         So1i6iTA6W2sSelIqwP8C4PuHdAM97fzmsgr8YMH9xtamfVdWcgM2qzO2qfyb46Uhw8P
         yclyMP81JnAdaKqSRhhQwhC5rgsRKHmQ31UFeF0SNWP0C4H6q292MAMrFT9sPSfFLvX6
         tLrCyPCAFAqfFmzIntV9h9xrLn3qVkABeRwDKnfwl83MgTWhqFoW2034fQYsqNj0+v2N
         nCl/+ow/8ZfPzPq0WnldINJV8VwyyIBHxFZValZ4m9lVfQ6IstpePU8Kg4Uuw7mc2vin
         cu3Q==
X-Forwarded-Encrypted: i=1; AL+hErFkBxBolKJR4RChwobhh31bcNCc03dKt4vP7nq5/ZyaNpYcNSnVYpMhH0tmLxb0Ew1e7hY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qidpCz5RHyRMpSr0STgT+d1LGyB716YdUHc+Q7tP49qKyxER2
	XnOGVXNqbH2ivr7aDpUW2yYYkpoKTAY18bpPiTDF3cXeMn0jteuC/AM4Pxm7fWGvjA==
X-Gm-Gg: AZFdTZe06tlIJYOnIa7gbwkQMYjpnOmwb1wx9/poLBYxHC/voWj0Uv6eSQkcNS+KL4w
	UB6AGEnc0On57qiUf4jPX4uLFUCbWouk7TqHpElZxfBVCJ6ZtWl9AB/Sn8Cyw//sviLp6mOXFnj
	5o2LI9J9hN7eNX4ciEcCvgAi5WajvKyptLGiO2PCFk2rJ+zBNNYZwV7qha82sf8Y1nH9n2eEDNC
	UvRca8hjGzXVzzrvQUcx1sJZylVikQ7LpbL3WKV+LVSO0p7jsMftnlZiEfPbx39LjO8SmvyJzAn
	ZczXKMi5vRBgO4782j/BpE49PUUqcVetN5+5xeiFFlbdjLRvrmN34h06ziSuvTwrTnuvM663/x4
	vZomRYIjDuJ2hGLqgoE9WiNBQRQOngmPgwBDXHLdeHtasjnwrl6AAGbb7dDP7QPwnnYKaTuHGJD
	y1bEuANYihovw0ijPzQ2XJ+8I7ub1yDO4cLtC2xe7mctNe4PfkFKF9uYyWJPSws6CFcZZjzvZx6
	wWaxbf9jAlNHFyk5/ZJae/+RcOKLLVg2MYh5P+hbyTH1402uqLta6apJemPMUqoOo5BACSDs6dy
	oDzyXxAX9e81wthqS8JDrlX9DYT4fJlObXoq2OB+HXPW2qWBcb6v9CFhdVcW29pj
X-Received: by 2002:a17:903:2283:b0:2f0:7707:228e with SMTP id d9443c01a7336-2f077072aeamr126105065ad.32.1795633975347;
        Wed, 25 Nov 2026 11:12:55 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0b5647b94sm39776055ad.14.2026.11.25.11.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 11:12:54 -0800 (PST)
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
Date: Wed, 25 Nov 2026 11:12:53 -0800
Message-Id: <DN4J4BQK3N90.2WVQBRV6SRNXF@google.com>
Cc: "David Matlack" <dmatlack@google.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Sean Christopherson" <seanjc@google.com>,
 "Vipin Sharma" <vipinsh@google.com>
Subject: Re: [PATCH v9] vfio: selftests: Find devices that have VFIO
 selftest drivers
From: "David Matlack" <dmatlack@google.com>
To: "Josh Hilke" <jrhilke@google.com>, "Alex Williamson" <alex@shazbot.org>
X-Mailer: aerc 0.21.0
References: <20261120012553.3745742-1-jrhilke@google.com>
In-Reply-To: <20261120012553.3745742-1-jrhilke@google.com>

On Thu Nov 19, 2026 at 5:25 PM PST, Josh Hilke wrote:
> Add -q to print only the PCI addresses of usable devices so the output
> can go straight to setup.sh. Add -a for use with -q to include unusable
> devices as well.

Feeding the output straight into setup.sh worries me a bit. -q prints
every matching device, including ones the host is actively using, e.g.
the ConnectX NIC carrying the host's network connection or the GPU
driving the display. And once the NVMe driver lands, that could include
the boot disk. setup.sh will happily unbind all of them.

I don't think list_supported_devices.sh should try to filter these out,
but it should at least show the user what each device is currently bound
to (see below). The real protection belongs in setup.sh, since that's
the script that actually unbinds devices, regardless of how the user
picked the BDF. Please add a patch before this one that makes setup.sh
refuse to set up a device that is bound to a driver (other than
vfio-pci) unless -f is passed, e.g.

  $ ./setup.sh 0000:00:04.0
  0000:00:04.0 is bound to ioatdma, pass -f to unbind it.

Devices that are unbound or already bound to vfio-pci should not
require -f.

[...]

> +# Devices that have a driver in selftests/vfio/lib/drivers. NVIDIA GPUs =
are
> +# matched separately in is_nv_gpu() because nv_falcon_probe() matches on
> +# vendor, PCI class, and PMC_BOOT_0 rather than PCI device ID.
> +readonly DEVICES=3D(

Please add a comment that this list must be kept in sync with the probe()
routines in lib/drivers/, similar to what you did for
print_nv_falcon_note(). Otherwise the next device ID added to e.g.
mlx5.c is going to get missed here.

> +# Devices in DEVICES that are also on the vfio-pci denylist. The denylis=
t is
> +# in vfio_pci_dev_in_denylist() in drivers/vfio/pci/vfio_pci.c.

Same here, s/The denylist is in/Keep in sync with/.

[...]

> +function print_denylist_note() {
> +	echo
> +	echo "  To use denylisted devices, load vfio-pci with disable_denylist=
=3D1"
> +	echo "  (or boot the kernel with vfio_pci.disable_denylist=3D1)."
> +}

The script checks for "Y" when reading disable_denylist, so please use
disable_denylist=3DY here too, to keep things consistent.

[...]

> +	while getopts "qa" opt; do
> +		case "${opt}" in
> +			q) quiet=3D"true" ;;
> +			a) all=3D"true" ;;
> +			\?) usage ;;
> +		esac
> +	done

Please add a -h option to print the usage. Right now -h works by
accident, but getopts prints a confusing "illegal option -- h" first.
-h should also exit 0, since asking for help isn't an error.

[...]

> +		IFS=3D',' read -r name driver <<< "${entry}"
> +		line=3D"${bdf} - ${name} [${id}] - lib/drivers/${driver}/${driver}.c"

Please also print the kernel driver the device is currently bound to (if
any), so users can see at a glance which devices are in use by the host
before handing them to setup.sh. e.g.

  Supported:
    0000:00:04.0 - Intel IOAT SKX [8086:2021] - lib/drivers/ioat/ioat.c (bo=
und to ioatdma)
    0000:00:04.1 - Intel IOAT SKX [8086:2021] - lib/drivers/ioat/ioat.c (bo=
und to vfio-pci)
    0000:00:04.2 - Intel IOAT SKX [8086:2021] - lib/drivers/ioat/ioat.c (un=
bound)

Please source lib.sh and use get_driver() for this rather than
open-coding it, like the other scripts do.

Note that "driver" is already used in this script to refer to the
selftest driver, so you'll want a different name for the kernel driver
variable.

[...]

> +	if [ -z "${printed}" ]; then
> +		echo "No devices with a VFIO selftest driver found." >&2
> +	fi
> +}

Please print this with -q as well, since the message goes to stderr
anyway and won't get mixed in with the BDFs. Right now -q silently
prints nothing, e.g. when vfio-pci isn't loaded, which leaves the user
guessing.

And in both cases the script should exit with a non-zero status when it
doesn't find any devices, so callers can tell the difference. This
should include the case where devices are found but none of them are
usable (e.g. -q without -a when vfio-pci isn't loaded or the devices
are all denylisted), since -q prints nothing in that case either.

Lastly, please update Documentation/driver-api/vfio-selftests.rst. The
"Picking a Device" section says it "will be expanded in the future to
guide developers on how to find a device with a supported driver", which
is exactly what this script does. Please describe the script there, and
update the "Setting up Devices" section to cover the new -f option for
setup.sh.
