Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795013741;
	b=s7E5+PRItGaCnNr/hlx19FncY3ejfZOj0ae+zHCyXCDL00jLNusehfzuseI8Af+Lj/I6
	 aRmGWbpEUYCMyfvVu3D29fUk6FWX63waHPNUb8zU1dqHHEtikvcJPP3e5CmO2SD7xNoIt
	 gJ7qVAfWc6ADymx72nxeOO3m33ANM/aeX0NBZYK82Boge7JuDQzr9DRTE6FmdM6FAeNqM
	 2rlAgk+e9GoVr7yxgYcewkbEciZ7m4pkPI/EOL/eoEP+laL9RoQAVcXMODVmoiqAEV/Et
	 9g5snu2w4715o2TLSPjLR1lDcvazwttHl6salr9mHFw7wdWoZcgQt7oqNR87siZTpeg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=A1AMia2vi1QSpUOJn8VNp1VkrqQ7LwCEUZO4G/j54mE=;
	b=wxNZoAesSXMuOAJPFMVHN/GsSU39sxDIIv3tvWv+3sKOfvtgWnJHr59yTZ5Kfq/tV2LQ
	 6l0yCOK6oZ/hRfreWqykG8p5/LsRs6DVztoP37cW+CcndvEeWpRfRUi6fZL6k5rTyZ8eB
	 RicrBvQhkLEtaVMb1ulcM97mD3iSRIy9AtsOM7H0J4OeQvdsZDhLjHfWWTxwcpLzRfYsg
	 +34lrm/iSaSp0qTOCTmJ8kI0EDTLxblcQ2B4S8Edrr2oJwqUN8iy79dZ/Xu06bnDaoN3W
	 Nnoi8O9FBw8Ywo+Sr1yvZvH5Mr9X8ekqBZls/aS6C5phion0tOvJS2ATY08I2B2u2eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flashbots.net;
	spf=pass smtp.mailfrom=flashbots.net;
	dkim=pass header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=cHd61Vja;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D5D606A336
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 14:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28D5D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flashbots.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flashbots.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=cHd61Vja
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8479f46ecd8so512359a34.0
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 06:55:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795013740; cv=none;
        d=google.com; s=arc-20260327;
        b=MXim402q9v65Wmn4VjUns3euZEjNlYvMzb2MVlctyRP3R0BGzvACW4pxlQ2C46gKOD
         FNjbzwhQUGTBnPC6RPKYmk1bdYaTqVwE8SRETPnGbunUXbzkHIJjpz7ladIK6/P+0kzd
         7A8PR/Uy8++YO2PAYZPScNHNBiSMCgyZySYm20sVLAkJGIHf8ANxSUS0TwIY1xpuu7vc
         F+xOHRYvC833o0CpLNMaYL2Pc2A/gSK6Z5cL/VxcUE1TAJmyxi5Kj1g/VizEQlQcoL6D
         hqTaG23r9oe4YNQ+a0Qf3Dh7QlCpOuFgICrdk8QXNQ8AJc4emwlWGt/UbmEdqsauTnIh
         FGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=A1AMia2vi1QSpUOJn8VNp1VkrqQ7LwCEUZO4G/j54mE=;
        fh=WNkXEsXkTjPjK3BnzXVuSEaeu66Oo9XAJixvxLYj0FY=;
        b=VFJi9nrwTUar235CqBcF/1HfuATT37NOzCBDJidO7uf0xuXTsp+dZd+hODR4bZ9+9U
         ngPK8P80kmCb5szPPozlbtRfpHrNHRzALOjlOOWw9pivZx7mXpI4zAqqFcA+/fNsKuP1
         qWba2Ia5TpNaWfD9dxOgBj2RR4hkZ1kJ5WYcxaYOskLifBK9TS+JZ0L74IJwFgzzqch2
         fLgm+ephAw0hruV0kFqbHphLQjNjKdRNrlcSOh1CS6hCWz6kERgWw7EaWFOc/CHjB2Zh
         PvYQPnh4VsX9Bbvwh8CPfnRQQ1N5OfP2Nym70Ucsj4R4QQDF2kWz8wk9hIcTDq9xfIfN
         2PDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flashbots.net; s=google; t=1795013740; x=1795618540; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A1AMia2vi1QSpUOJn8VNp1VkrqQ7LwCEUZO4G/j54mE=;
        b=cHd61VjaSggyMDg7PknLa0M83mt6nX1/AJyuZZRJIbyeE/cwFkK5TnaQSymRVutPAy
         P3WyQyTe4mvkz+/Z3jDryMZklVVB9VkUzzwGOm2j1R5OO+n3HeXA3x4aPuOh5C6oTAQX
         0mYxfq6rXZNh5YnvR8k4OHZHSpuUwE9y8lN6V5KoTo9qoDJjOZtZrjQjmM7NtMu2kNA4
         Bk+b3cSYrd74/4h5WhSoN82SLgAw7SbsPKQASWPpLeoh30jatTf+9Gs5gW7+tn0qfY5+
         ka70TBQyJr3QV4cG7sXL5vKXdrXEznDj+SJ6hhTRlgwYAt6vbEJWQ64uQgCjZb7hHKOf
         yOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795013740; x=1795618540;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A1AMia2vi1QSpUOJn8VNp1VkrqQ7LwCEUZO4G/j54mE=;
        b=lYJ34muFGLI669q6pNIWZrNuwy9gkleFqaP4NiD0GMyVQEvsB1MsoGJV9wv1fBrlXl
         vx0EhkSeUUExfV2yzgeDnetnIAZnrZdIDVlEpJopUde9jTqlSlq6LQRqRnZh56+HdU9t
         Gf5VMLzIMpFfoWy6IBpu7Tss1FoHzkSI5OZ/NZpqA5k4qJZjS0PbEoGxLj1AAaDYwtk1
         8zgvpcydQu60KWxxpseorsQplcz6fJAyGOC3cHRocVBjqH3WGx6/iLF+xUHMxg2wLuq4
         AvCPuEOrSgo3OSxQiMkArzwn2ZOD+VcQ03UBR4KIyz/Xh47h5yv2jm+Nynh5XWzpkreu
         20yw==
X-Forwarded-Encrypted: i=1; AL+hErG6LrLbxfuAzZFljlhRtHKCqHXFOYkgXE+kktTT0Np9vlKjyGqCnnLDZp+siRK3bGyqvUE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YdpRBnMVCgbTqvP1FAKrUTNPLKRY7cjHtpx1V4XRDq/hXpjOL
	XoDAU/uwk31X6at4U7YtMQMdVxa/cjuSITDcwvre95DtI/AQMIITUSulmaqzOcSSv2lOjJ/qNFl
	L/OwtsmtEsMwLHc7bb3tO8r1BTwnXfRD9gAY76xoyyw==
X-Gm-Gg: AYBFou2XhxiE6eBxPkpApmtqHaQ9usmklHXLuju9hVL6HeontwpwwlJuU4GaPoFOIUR
	7k4+4rGQMVCutH2iJUxcezlOsYd3J+HQOtUBC4bmBwSD9G/9rwHaACEK5eoVNIW1/94+RmA+GwQ
	u0dU3/h0aluWVculBwBYSPKXeX5pvR5RXKL4LRTjwI81cthGaC/Ut+M12nEZq7lpou1GS0RTIWX
	VmmPf+CllUwHMAGYY8G4stDL4Nu90vK5Ft/5CZ9w1t6DFuvMHQnVcYnxj4tUlj9E1D+6/9/HafL
	ZFX2Vjg44DOL9/9rwXgsAqpfpIwtUsFIz4vItP9QoX8qToxRqgytl/yHFspBIpvcJk1FKa7Xtap
	zT+K3r0pB478T5WIbnNYv15nI5IjtZOeKX15UCPpUfMW3qWqQL+mru/lY8U+KYZyTSDPh+uUMmE
	BhH5k31SaUaI6BZzMqU7dHYaWKKJYXfwUSHlNwF3zj5BMEL3nOQkn7Zcy2aOz70uUU43B8o7Ru
X-Received: by 2002:a05:6830:2b24:b0:844:4959:e856 with SMTP id
 46e09a7af769-862f08f6d8fmr2997887a34.11.1795013739853; Wed, 18 Nov 2026
 06:55:39 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
 <3b582cdcfe37f1d01ee71611ab2611f845261089.camel@intel.com>
 <CAKV3HMM9BKpmgWeFqRqamAsqqiofj+TG4DrOEHmbUyE0FjA7+w@mail.gmail.com>
 <0f9ba1a6acb57a8c126739175b4e38dafac08c9d.camel@intel.com>
 <CAKV3HMMfx4APmardWdtL8yhirXMuuBQMZ8xrtowHNRnTKXNRiw@mail.gmail.com> <86f99f3010775eeff6269fd9bb8f4edac10a7d85.camel@intel.com>
In-Reply-To: <86f99f3010775eeff6269fd9bb8f4edac10a7d85.camel@intel.com>
From: Moe Mahhouk <moe@flashbots.net>
Date: Wed, 18 Nov 2026 14:55:28 +0000
X-Gm-Features: AclHuK-d2hbNILXughUCStMRcZnLFB956aXQFG2DezCp6dotXFDkjtwD-G3N_ds
Message-ID: <CAKV3HMMjyHig6LTiCsXKLvgvsW+0GVitCc0ziBD9RNxH2TAuvA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5B=F0=9F=9A=A8ext=5D_Re=3A_=5BPATCH_v3_0=2F2=5D_virt=3A_tdx=2Dguest=3A_Fi?=
	=?UTF-8?Q?x_and_speed_up_the_wait_for_a_Quote?=
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "Miao, Jun" <jun.miao@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "djbw@kernel.org" <djbw@kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2026-11-18 at 01:28 +0000, Edgecombe, Rick P wrote:
> I'd think a simpler shortening of the time would be better than something more
> advanced. But...

OK. In v4, patch 2 will replace the backoff with a fixed 10 ms sleep.
Patch 1 stays as it is. It fixes the timeout check and is marked for
stable, so it could also go in on its own.

> Shouldn't attested TLS just be used to set up some other key such that
> subsequent connections can be as fast as normal TLS? 0.1s is still kind of slow.

The 0.1 s was the total for ten clients connecting at once. Each Quote
took about 8 ms with v3 of patch 2 (median of 120 back-to-back Quotes at
HZ=250), and quote_lock runs them one after the other.

Our HTTP proxy already does part of this. A client keeps its attested
connection open and sends all its requests over it, so it needs one
Quote per connection, not per request. What is left is the first
connection of each client. Many clients can arrive at once, for example
after the TD restarts. Today the last of N clients waits about N
seconds.

We don't trust a key from an earlier attestation for new connections.
If a later connection relied only on such a key, a leaked key would be
enough to pass as the TD without any Quote. The recent relay attacks on
attested TLS used this kind of gap. In CVE-2026-108269 (CVSS 9.1) the
Quote was bound to the TLS key and a client nonce but not to the
session, so an attacker with the TLS private key could relay a genuine
Quote onto its own connection. Binding each Quote to keying material
exported from that session closes this. The exported value is unique to
each handshake, so it also serves as the nonce.

> In the end I think quote based attested TLS is not normally expected to be fast.
> So is this trying to optimize the wrong thing?

It does not need to be as fast as plain TLS. But the second is not the
cost of attestation. With a local QGS the Quote is ready a few
milliseconds after the request, but the driver does not check again for
a full second. Any user of configfs-tsm on TDX pays that, whatever runs
on top. The patch shortens that wait. It does not try to make the Quote
itself faster.

If that works for you, I will send v4 with the fixed interval.
