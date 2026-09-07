Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA734EA394
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787963; cv=none; b=jYGFOfFiqv+8lHRz/3l//ez3AV0PPjxpA+k2u+wIMlqwzcJQKyMC1wCmToBK//JPVFETMxsgWUPTUHEJV4qF7msURA6Xm4T4JQE2uIpdq1hQCjEdCmPms33QkF96FodLb86ybAuq/caGFyYxAYARtHdS8kuLugi95yFNGZb9mco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787963; c=relaxed/simple;
	bh=0pT1uhHZUI6j9EiOnapQKC65K1WMGcViCtAANcQ5YIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NLzUdBZWkOEvpUscbxzFM2vOGb4l1SGQnctw8MZQujQkll8JSsbcexeWq+jziCWhng+Hctl+vmVHom+USQh5yDaMg4P9O2tDy8a4QljyARaiyQEAZOK5tNwdfZWLMXGZ2DsmmvN2UXJTSceU3SpDWtB33vJPdGcsD7Pieltpmng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcspfst+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcspfst+"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c259e5c22ffso204503666b.1
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788787960; x=1789392760; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0pT1uhHZUI6j9EiOnapQKC65K1WMGcViCtAANcQ5YIc=;
        b=fcspfst+cKEKttJxoXIblPVVhdIeNgEGVKPmts4GHc/wfTg4hgWXcwVCzD5QZE+0T+
         XVoYKWC2zBnP/d+J0Db3m3cLrCbLHihAQy/H2WH7zSgjD7Z96oH1/PZ5bJmvs3RIvX+L
         sW7gNH+SkMUL8PTvgW8/AtzZaUB2a8AsE5QAOzQNAznnGoxEU/47pkj7xxJMW9MapgBx
         kBg1TzQ0IAoLp4yZqhuahfoJLn0iQkSUIa0Nw0uK2apX3V9FgbdJe39qDX7Z578b9c9J
         fuTvcQFPvsw8hvtJavfLFW4uxd7KXy02zcWkfxl3U00FPtWQbAxn3AmPjNZAiH2HJftv
         dq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788787960; x=1789392760;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0pT1uhHZUI6j9EiOnapQKC65K1WMGcViCtAANcQ5YIc=;
        b=rpSTAYbgEZ9g9s3IxvzGbDGBiVxVQ6O7rxorp42F4lb++jat2nQVHQifuVSIc3qUK1
         Vh6zBA+Qfsq48GnDZuqQS5fiLcHodlkT+XeXl3wG4v2l4qy7fUh4k699EX/HjqI1sDRd
         Q8SUra/v3ETRJxgwFSs5EtYdek+KQV+lTAbtYPHhSYQuKX9KeHLMk0SpyUBVHaykvGVZ
         7MTOZYT6UP+WFOppSh/BTGATG187+9FPKN7jmT6Slnp2FapPTJqqLUVxEJJ0SuIN74TL
         EKzS/TNRrKRVUg8/I86VCp5sAE4iIt4AlU3vKS3hCHclh+7u7PVUVhR1oWrVbaOenEQ8
         /vTg==
X-Forwarded-Encrypted: i=1; AKwUvBy06kBY5nkPHoslbGGUnNTPS+o6Dcyfm4xQWu2ufy8sq5oBpjWKsbwolUH+8Hltp6Ime3M=@vger.kernel.org
X-Gm-Message-State: AFuF++mD6loFC1GQ8J6oZWNXquVpX0nXH87ncZbXasEY9t7PgnFqufXP
	QnLCBIoWT3J6AyP6Hs3I7UzMdP4fQL5kewxUru1HR9Y7zl8dzplswADa
X-Gm-Gg: AYBFou1OQPqAgWdaYQeyLL9+GTjR+8apvpZAzqv63pQ1b43TARIB7f2vuTdFNPJJoh+
	ZeQlNjcRvGh50uqzUCqHOD2MxVqz3xSeQYTrKS+h7h63LspRLpOaTvgwDVVWPHPic1UPSqPeATm
	PENkv1Dwqe/ZM6EerSn6euHF7asV+ak3KM9CIb1YUAvIp6h4zD7Z06ZrenYb4eQkVPH8Sc01nbX
	MwMITz/iSxn3zETQfH13iyZtrdjCBXDhN7Hb70fRQ9UnvjbcbmmD/yi8I1p/2dHYAsixFOGyGK7
	g9pLwO5R3MvLGzL6YjKRCY0mWi2JgLVFOv/dqiLcpYXGws1HtGRizlTyUTXAbEehzHDfY+jkUmt
	8Q1uwMOLwA0J85TBFLAX1FJ6nDcYxL92tBSI6evHPBQQNlL8F7lq/G7rjO3ylC77C1PZqkRcHjk
	BECKnRVr5gM4R6Xly9LRYnCYtrZoIaSqd2fWBNmPj/dVosKJS+raOpLOgqanPluA==
X-Received: by 2002:a17:907:d10:b0:c26:1691:b369 with SMTP id a640c23a62f3a-c261691b941mr778156166b.34.1788787959821;
        Mon, 07 Sep 2026 06:32:39 -0700 (PDT)
Received: from [10.245.244.23] ([192.198.151.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68c3f00sm4298227a12.12.2026.09.07.06.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:32:39 -0700 (PDT)
Message-ID: <d25d652c34dedc209ccb3b758e7f624b9125eee5.camel@gmail.com>
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional
 KVM_CAP_LIVE_MIGRATION and KVM_MIGRATE_CMD
From: Artem Bityutskiy <dedekind1@gmail.com>
To: =?ISO-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>, Tony Lindgren
	 <tony.lindgren@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>,  Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,  Pankaj Gupta
 <pankaj.gupta@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, Marc
 Zyngier <maz@kernel.org>,  Oliver Upton <oliver.upton@linux.dev>, Steven
 Price <steven.price@arm.com>, Anup Patel <anup@brainfault.org>,  Samuel
 Ortiz <sameo@rivosinc.com>, Jakub =?UTF-8?Q?R=C5=AF=C5=BEi=C4=8Dka?=
 <jakub.ruzicka@matfyz.cz>,  Vishal Annapurve <vannapurve@google.com>, Elena
 Reshetova <elena.reshetova@intel.com>, Kai Huang <kai.huang@intel.com>, 
 Kishen Maloor <kishen.maloor@intel.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Peter Fang	 <peter.fang@intel.com>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li	 <xiaoyao.li@intel.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, 	kvm@vger.kernel.org
Date: Mon, 07 Sep 2026 16:32:33 +0300
In-Reply-To: <ap64dFXpiDb_Hqxl@8bytes.org>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
	 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
	 <ap6loazXtvSCqmpR@tlindgre-MOBL1> <ap64dFXpiDb_Hqxl@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-07 at 15:15 +0200, J=C3=B6rg R=C3=B6del wrote:
> The direction is always the same over a single live migration session, ri=
ght?
> So it could be a setup flag, on the other hand having separate KVM_EXPORT=
_CMD
> and KVM_IMPORT_CMD seems to be a cleaner ABI.

Yes, the source stays the source, and the destination stays the destination
for the entire session.

This is a special case of a broader question I keep coming back to:

** How much state should KVM keep about a migration session? **

For direction specifically, we could pass it to KVM on every call and let
KVM stay stateless about it, or KVM could record it once and remember it fo=
r
the rest of the session.

But in general. And this is addressed not just to J=C3=B6rg, but community.

Traditional VM migration is driven by QEMU. KVM provides building blocks
such as dirty page tracking and vCPU state get/set APIs, but it does not
track the overall migration session. The migration session state lives in
QEMU.

Our TDX live migration prototype keeps some per-migration state in KVM,
for example the direction, the migration phase (setup done,=C2=A0started,
paused, and so on). This lets use validate inputs and issue the correct TDX
module seamcalls from KVM.

A different uAPI could shift this balance either way.

In the **extreme** case, we could expose a uAPI for each migration
seamcall.=C2=A0KVM would then just pass inputs and outputs between the TDX
module and QEMU, staying a thin layer with no per-session state. We have
not=C2=A0tried this, but it illustrates the trade-off.

So where is the right boundary for migration state in KVM?

Should KVM manage none of it, or is some state acceptable?

Would be interesting to know what KVM community thinks on this.

Thanks,
Artem.
