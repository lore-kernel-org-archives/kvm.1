Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622010;
	b=bdruHDwqlp3rvEjv+vZ0YuVL9tWN6asJv2iNSSTkqD3J6AjnMft5W8dSU5pSprvM1wRB
	 XZbLRJMgElOWhUIc2gnnm6nEuuAfpmCV21JoabUQHY4r+719jryyeh7PM/9lulxVXovfF
	 kOYa5iHVbWLglunU4TQa4zXe85hdIgGKIZ+6DbYnyHuAARvqeRzuVhi/IMh39ig2nm3kF
	 dGGrDIUzKZGqPOsDRqqrpEiPIsku0xnqwi6jTWZGGyJqHBWxxJvNiYu7+/Y2YU7HXI2BW
	 y1R6iJRcoTxAEoyp3wXnGXPUz9vI5LpmsEt8tQ1HHFp2fBjDBlkjEmYaxcNBg7Rtm1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622010;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=604SFvy4+RgSkLOg62spOBToZb/ngKE9hV/JFGFCqjU=;
	b=o6PZU304FLYzE3hyPA3X0MT6ljlVGnMGRjRtTKpWRj1WRwcKhMuxVzDeB50lk9dHuqQX
	 J0aPPfbHrPbS/QX5A235lDXcFwXslApS/ZO4y3t64rKTA3W87VsVx0BWtSNqC+SKPa3/D
	 PNXPApax74a8/wQM1XPVdw3q5Z7W+cXgkPP306FZXyNmCfvsiE34vvw7oDWgmQ57VpNFc
	 jCHWm/mmSNG6Pl52Nod+DzWZfvi8zxTV4rEDKw2eqVDc5P9XDPH7APJSO7HvkMzixWNnd
	 ithe9pNGG61uorgTLT0bv3vcDeO07d+J+Iu16VYgvtveds2KjseItg9e9HC59EKlBzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ti5hiOid;
	arc=none smtp.remote-ip=95.215.58.240
Received: from mta1.migadu.com (out-240.mta1.migadu.com [95.215.58.240])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE721606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE721606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ti5hiOid
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zzi6AwEaVyS7KWiqQ9UFdMnPQT3SvBIYY8OV76VYzEI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795622007; v=1; x=1796226807;
 b=Ti5hiOidrqSlZO5XyATn/9vbCR3DBS33hPTjS7zbHV2GouyyB4vPqYsxfzy5dTOKAWfiwwHT
 YywbwiXbR1UgUIVD+twrgmCC8HvMjweFe3DXRT76Fj7eXkKz/7V/PHso184lyIM82e+NK/2gocz
 hI1AVakDI0DQqsI7ygWmuPQk=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id acb605d70e47086b;
	Wed, 25 Nov 2026 15:53:27 +0000
X-Mizu-Trace-ID: acb605d70e47086b
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so37147e87.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 07:53:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHLsanfHJQ2Vv5oQJZxa7hj4rBkvkKeDbIPmvmIZBLlu1My3T1gOtPjucrI0hr1eKVPz3s=@vger.kernel.org
X-Gm-Message-State: APuU4Z91IOAhs9IGDhV2ewQQCTH/dzxKP7mZfnQwhgEyUKMSlPKS5tw5
	1eP47rLYXG5KicwKWyeBMVb8HxfH16mAV9sE1o7hvAs6dBAbp6/bmI96Upwc53R+Cs2zq9LAUwS
	crQdxuJYed8pRYeTtqPUMc8NehlzNUWYgjfKgRegB
X-Received: by 2002:a05:6512:2249:b0:5c1:ac5e:ee43 with SMTP id
 2adb3069b0e04-5c212394558mr542334e87.3.1795622005333; Wed, 25 Nov 2026
 07:53:25 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125153911.106793-1-fuad.tabba@linux.dev> <20261125153911.106793-3-fuad.tabba@linux.dev>
 <sashiko-outbox-233677@kernel.org>
In-Reply-To: <sashiko-outbox-233677@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 25 Nov 2026 15:52:49 +0000
X-Gmail-Original-Message-ID: <CA+EHjTxB4VBRFrwS5LVo2TrmwxLG8=Oyf9JTBWeCaXDfp7X_NA@mail.gmail.com>
X-Gm-Features: Aa3M54p_f3WBy9239pNU7mXjKEDGd8rPn5mPXG1-qpZx9rKsY0g4RHXqEgP4sNA
Message-ID: <CA+EHjTxB4VBRFrwS5LVo2TrmwxLG8=Oyf9JTBWeCaXDfp7X_NA@mail.gmail.com>
Subject: Re: [PATCH v2 02/20] KVM: arm64: Don't advertise the host's MTE_frac
 to protected VMs
To: sashiko-reviews@lists.linux.dev
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Nov 2026 at 15:49, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] KVM: arm64: missing Fixes trailer for commit 3d7ff00700d1
[...]
> [Severity: Low]
> Should this include a Fixes tag for the commit that added the MTE_frac
> entry to pvmid_aa64pfr1[]?
>
>   Fixes: 3d7ff00700d1 ("KVM: arm64: Rework specifying restricted features for protected VMs")

No. A protected VM doesn't have MTE, so the field isn't read, and the
wrong value doesn't cause a failure. The commit that added the entry
is in the commit message.

/fuad
