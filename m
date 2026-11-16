Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794803663;
	b=lUcaSnaKHqya4BMOW19KF2iay1c4uG8DSGVZAMqZKqKbLS5oT2LuE09sorgf/D2Vv5j0
	 v44lFzjjUQFtdUc97bYk0Hc2HEzWx3lsI3q9dTB40kexm4b+/gdd8nQMMYdGRi44hLBFG
	 qM56IiXiGgEIyVFONgEQY2/kaBeBPcw3mdd5uJ2EDPMvMtM0pVGSR+kWfYd6lkZM/S2SG
	 iZuxi16eYJx+fQTGfAYBLePExfXke7BaTcmnIG/9bB/fmE+kzTBwms+IHn9bnpzOTT6+y
	 eb3wK2Tg0nIskv3ykT2UDIUejY4lWj4omZhAIsUjQM3+8eWMccS/XOjoIabCCz+oZxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794803663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=0RTPkBSn8aHOwll0NIb+MH6Rxh2TXo2nlFC6RRntyeU=;
	b=y3pqqVS5nsA1X4GIFse/smtVTScl8AEidCwsh+VMqcngbxH+EwfFVV0+1sCeSkg53pps
	 AfGLiNVtnRAru2HxFcHOQqXJ2FPkB5xgTlQ9VOAKNlD7qW7p0sDhm2FDUGZCPZuLV1yo1
	 29oSHzc+5LKMus0zu0OEUIDQBNNQrgmxOphkCL/Y9d93oYSgJu43UTSiMsQ0Q3vzPYVTF
	 gQ5Jtg9HbOrruUUPEeDNPnZ8y/6lstJMy6XpfWH/pEAD/ZWVLHbhAf4ltSm4NL/UezK3S
	 34Tj+bmh59dACnasRBWCsMuSWyQgWjDmusChsChnOvzI8o2DoCfaMpWfOBPKyzCZOLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=IvrpsDuj;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D9606A31C
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 04:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 004D9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=IvrpsDuj
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-170135e43c7so4781837c88.0
        for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 20:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794803662; x=1795408462; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0RTPkBSn8aHOwll0NIb+MH6Rxh2TXo2nlFC6RRntyeU=;
        b=IvrpsDujkb8+xQxkW8bH57B/Njtz9j5nrLpeGfuYrBi6nX1JKFJylBRC6sdQEERIVw
         HtGcx7CHi/CiN1Fk2bHltHeShULSWGB/FJStMTLzNEcxESGvjONp2O5O4N9PClo7TcFu
         4beF6ymkhsh8+wfAWm4UkR+WNqUZfV0HV7UcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794803662; x=1795408462;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0RTPkBSn8aHOwll0NIb+MH6Rxh2TXo2nlFC6RRntyeU=;
        b=rL/OZ+xRBJo1PlfptsxX2e6tHJqBLWs+2MyOYd6Ak/VpnUACjr4ReuugeFtxCodIzu
         Jvs8Ey0sfRNwt+CuDVchBoTlIJ6x+gcqy6WRdYvx/KOgcrxkD9Jnz7FbxkXKQSabBKyT
         KSwSzCHazUfNhUxSvfsX/wl45FWncukbJ4HTsKBkdaFjS5K8g4OafvKID1DsD8N9nN5F
         DfYEsrCohVxMZIYXJU/Ic32UQuoUlui5vA81h2E2kQsjSXkLU/XgVtuUNcwQGjCeFjOg
         0icwLIsISf5/EhZ+8cEadnLxwTkUnQLfWF9snuD6YFzsjlIOI0hzuUQuBvi9SH0R8UDt
         kB6A==
X-Forwarded-Encrypted: i=1; AL+hErFGEyhzXm+czBzS0/H0W9EZplRNl/9QX0ukwZlGcTTRrD9gKeWkwZtITVVyoE5Fk5Zh1Z4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MA9kn3vzuaspqDtgpmTULyjqDxLqsNAyJIuk+d7VHx5BYLUUT
	PE6NJSmIdNi8UrWnSxWXZESEROfG+9OZLbLVGGpZl5rCv7Eqyk9N/Z0wrZYWFYlUfCY=
X-Gm-Gg: AYBFou03kJdhGmdS5Kp9CmYthZ4ehJLrhiuWi1wGadVGv9cSYRiioGv1e8/fChBhSTu
	q3kFRsV0i905/Wmggt2E3FN6KcimLJm4+91e6Gpav+aIbMkcd4ovFeRs9et7dEvzyXndyEkkt4j
	hjt+5PDChVeTIVFgvCizH/5vqfAL2elsa3ZvcokqfKWlto143I4VvG11L7eYLwveAwAXv+0uM2J
	b0n4LtQ9W3t1x+7qOK40lImMpATPvWPvGkcMtgVY2iIU/+8rxmkHgONqjIjERwcF1RIpGyMq+ST
	8QJ4Zzv40vtHCYPxMWCrWhQjjtf9FCfRQIvvBuL6plYEqd5rzt5nzK1k2Pk875lZ9F5uoO+rUZA
	cQDHqnXdDxz0GAumhZoVQioJOH8cVgs+HtcfBBChAeWPAbh0aZ+d5OLWlAjqP6i9FU9l1a6uA+Y
	8iVkVVMfD5Hmas2CP9SxIRPGifWbLjUkNYUBcRUXb4nN5SypCJGsLVk7WvtrDd3aEMVW6cBucif
	N+rRSOrRphXPhkhHTZFhcq6qWjtoKKrXO4GnpTuOHiO/fpSiyQrqvrHE27KFbcO0tlv7CdvuiJI
	YhMZ4dxEXJNx0KOx6fkAq6qHSmqzJErkWn35ux2eg8OwpsPnB6hCr8teyr8scQQAehiyXUK9gXJ
	SwLNXxtRV/PUQ9ou8w1QY1V2x3lJ6HgxRSet56YO1TxNlsCoOkmWNjgMmdhyTB6hknyA8NLs3zg
	3eA2cIj7PpLcGOj4R+k8vf1YOzUi+ZZsfDGhjs8otC4kCV4QEdHDLXYJobsj8MpZbA
X-Received: by 2002:a05:701b:4508:20b0:194:9e7a:3ba2 with SMTP id a92af1059eb24-1b50306c4d3mr9813315c88.2.1794803662025;
        Sun, 15 Nov 2026 20:34:22 -0800 (PST)
Received: from [172.18.0.2] ([172.56.232.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5329ec87bsm2576204c88.0.2026.11.15.20.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 20:34:21 -0800 (PST)
Date: Sun, 15 Nov 2026 20:34:13 -0800
From: Chris Down <chris@chrisdown.name>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org,
	will@kernel.org, David Matlack <dmatlack@google.com>,
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com,
	loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com,
	joro@8bytes.org, kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, skhawaja@google.com, sagis@google.com,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/19] liveupdate: Add feature header to struct
	luo_flb_ser
In-Reply-To: <20261110050202.529473-15-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-15-tarunsahu@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261115203413.eaa54fcba43adc22@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Tarun,

Tarun Sahu writes:
>+	for (u64 i = 0; i < fh->header_ser->count;
>+	     i++, fhdr = (void *)fhdr + fhdr->size) {
>+		struct luo_flb_ser *ser;
>+
>+		err = kho_ser_validate(fhdr, luo_flb_ser);
>+		if (err)
>+			return err;

I think there's a problem with returning this error as it is. For an
unknown required feature kho_ser_validate() returns -EOPNOTSUPP, but
callers of liveupdate_flb_get_incoming() already take -EOPNOTSUPP to mean
that live update is disabled. pci_liveupdate_flb_get_incoming() returns
NULL for it, so instead of panicking, PCI carries on as if nothing was
preserved, even though those devices may still be doing DMA.

 From a quick test with an outgoing kernel hacked to set an unknown
required bit on its luo_flb_ser entries, that is what happens after the
kexec, in that the PCI FLB is never retrieved and boot carries on.

Could you validate the entries once in luo_flb_setup_incoming() instead?
They are all written with the same header by luo_flb_serialize(), so
there's no need to check them on every lookup. Going by the code, a
failure there would panic through luo_restore_fail(), like a bad
luo_flb_header_ser already does. If the per-entry headers end up going
away as David suggested, then this check goes away with them, of course.

Thanks!

Chris
