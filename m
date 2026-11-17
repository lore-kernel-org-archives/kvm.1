Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943670;
	b=MKosAiqgj5lDjbkuzWuWT09BpB8la+Vks6lucFSF8xquJ731O9ULB25mWlrjtgwVhqdS
	 35sLLmoaogdxZUwd5FqyWRIThNUkXVcfm9QdE2BWGvVcfLH9OmLX/K2oP2blyVgsPAdES
	 Oz5jz2FbyCIFs2ZDhPvqOflM4zSFHqIRVD2IBwljmm73IGNXpodwb8YT6ivdf7PblVMQI
	 41iADac5SvR81/zz0FsM+9t8tnagpI+2BtPy/Dq9lR1ayOB6AZK2Dwcf8HPzvYpxn+wu9
	 OzcMhEFPwdjsIODpirLO7jGw8ulOI+A2KMI/RnpovjUEFfs2hysz/iox3sRaW4RJIfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943670;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=+DQj5Rd8zqu4HARCi8rW0yj9HPFCT3iadFhwoSDGLHw=;
	b=2btWQF0HtiOPUVKBpyYKW8Un4wxCZV/FUG4XFVWsduxEbip37wOJGmfPyqlw5wDjPQlA
	 ewc+ZlmAl6R4JmAcNdhCwUKdlko4VqCd6L+eKelcDG1QWxonQVLwD4faJ0uFU5Bb0GaF1
	 T7E+oKeWHj//UTB4DDyP/cLTrtfEcRXmAK/TWn7KiQefVWWCK42V1yYUL6uY3zBMsSABh
	 m1RkN6zXjglxSDiHtSWxmfZZhDPp1esddQr36lKoVy08wDHQAZDq/LJ1YrL/d9zdeWR/f
	 IJSlQoWcITHSBFIrtc0EdvsN9Hhgn6UHVlwGqghQfUhKiklZPWPHXorLNBY1tiKh2dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cuGTmtlz;
	arc=none smtp.remote-ip=91.218.175.20
Received: from mta0.migadu.com (out-20.mta0.migadu.com [91.218.175.20])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBD7606A31C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 19:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EBD7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cuGTmtlz
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dKmJYX/63y+iQ1pYCnW01HTy/TWczwm2xVh0zs98/fA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794943667; v=1; x=1795548467;
 b=cuGTmtlzJrvoghDZWsKzpKAZTYeCAzQp7WHPyT9mTSqyMnKeUrP2Lshh1M9lePTOQi8K7gfn
 Tiq3ifrKMlEnMHtAXNfpjhw7A5+LQ1OSdRpLun8fLnEens8KMgxCMqiVVDFNY2xbz7VgSngvD9+
 Sgj/g3YMIhKCN3gAIaeXYQns=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 43a070ed31575274;
	Tue, 17 Nov 2026 19:27:47 +0000
X-Mizu-Trace-ID: 43a070ed31575274
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5c144eb2f43so1010e87.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 11:27:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGBxxgQsPwtUNS9uN5rSS38TCzsnoEya3yX88gf2WrAgIGouEVIvgsINHypSAwoAkqOwu0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YkusA11Q6NL9l7O+7+O1qwg0DIkLINFfhkPxI8vDqgZRJIgHm
	XJJHoOE2lwqxegE/MFWG3TXdErtcPGzp2qK83cRyDdCxCkLOJYU6HAEi72ReemghsHwIR0hpAZg
	I7Jtmi6PIHlvSv+q2EZyYgXbmhgnWIQWGDUnbS2Hg
X-Received: by 2002:a05:6512:304d:b0:5bf:f81a:f24e with SMTP id
 2adb3069b0e04-5c1a98e431bmr17685e87.10.1794943664222; Tue, 17 Nov 2026
 11:27:44 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109083205.806619-1-fuad.tabba@linux.dev> <20261109083205.806619-8-fuad.tabba@linux.dev>
 <avyZH2g3rrIVm-Fl@kernel.org>
In-Reply-To: <avyZH2g3rrIVm-Fl@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 17 Nov 2026 19:27:07 +0000
X-Gmail-Original-Message-ID: <CA+EHjTxsZFOwT5O5FfMf3wcTWrydR+x1TYVRDaCEF_FQX8giFw@mail.gmail.com>
X-Gm-Features: AclHuK_6wbUaiI-auzUUbuozU8SjWYXkCa76KeN8iu8Ffe01iC2J030eQ3Qa2QI
Message-ID: <CA+EHjTxsZFOwT5O5FfMf3wcTWrydR+x1TYVRDaCEF_FQX8giFw@mail.gmail.com>
Subject: Re: [PATCH 07/16] KVM: arm64: Compute a protected vCPU's fine-grained
 traps at EL2
To: Oliver Upton <oupton@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Vincent Donnefort <vdonnefort@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Oliver,

On Tue, 17 Nov 2026 18:12:47 +0000, Oliver Upton <oupton@kernel.org> wrote:
[...]
> > +#ifndef __KVM_NVHE_HYPERVISOR__
> >  static void __init check_feat_map(const struct reg_bits_to_feat_map *map,
> >                    int map_size, u64 resx, const char *str)
> >  {
[...]
> > +#endif
>
> We already have too much ifdeffery... It isn't mentioned in the
> changelog but I take it you're doing this to avoid the printk() in
> check_feat_map()?
>
> If yes then just upgrade that thing to a WARN() and carry on, it only
> ever runs at init.

Yes, it's because of the kvm_err(), as printk() isn't available in the
hyp object. WARN() calls __warn_printk(), which isn't available there
either. WARN_ON() works, so I'll use that in v2 and drop the ifdef.
The warning won't have the register's name or the bits, though.

I'll wait until next week before respinning, in case you or others
have more feedback.

Cheers,
/fuad
