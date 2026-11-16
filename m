Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794803668;
	b=lBVXc/J42em9JHYBdSr22rDwP4vb6XXXgooD963isevEYBq4aqEHYj+aO/Z6LrVTlgsx
	 aRwe50WEREUDkyHJL1zj6QC7HZ/BizhoNzgoSGwkj6jqp9jgalZ4BAfGOzljvzGICxbaL
	 RmVaS1ZNYW7O2l2TbniMr6D34/RKsKzU+FYKzNDtwSQjW708KYhHlM1+xdfwY4YCdsfmI
	 +CtoTikSu34Sh1pBy+Ra82VguJ3Srg39eAtOJpNAE/gD6UVKrIXgmKIAGPk3EjZAeIWgB
	 +9X4o6fml5zZmjW0wJOhFi+pATjjOpFlUqm3ts4BKOfxUy7zP8ZwRsrngQDgJDubV+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794803668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=yb0ouDgf9S/OdWev3vcVfqdIAaKZrYAoDUUyKNG3AEU=;
	b=XaondU2KXN+cZi6iZmFKCgEdPqNzafFmZw34Wwr+T5Tl/bqrPrJvTxQfWyWmWrRLhjR5
	 hHdkW/hxTsTrdCVmf1otBkoS+HaDJZXzB0QYJsWyhJ7FSsYf28WLjUl7AGglKiBDi+HY3
	 Hw4a7CRUBkP4rO2K6KXJyIa2FHKVxfltePSUB1Bx+wp96o8U4Gn92t1tsQmLeoNlSfxQ6
	 sWRCM9VtZ4wXwuuaa3ezsWj7l+RLbjiI4bzxkxWf8Q5smCNlEuS9ZYeaaJvLUTcBP3MOy
	 lW6zNjl3JhNOi0oA1P+Y4pLo75tLFBu527GQmPkkWTrTWvBGzpsFeBIHm4tMm6APqjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Hf3+VtbD;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD75B606A329
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 04:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD75B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Hf3+VtbD
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-18818daa3e7so1356314c88.0
        for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 20:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794803667; x=1795408467; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yb0ouDgf9S/OdWev3vcVfqdIAaKZrYAoDUUyKNG3AEU=;
        b=Hf3+VtbDTfzgXLI/sO1VMbmiG3HjPWLPXQC9K/x0cUqbiQ8byVDXCgJVkDqWGH94aR
         b30c7OGKR5Ve2w8uFEu7hCMIH5aAu5hXb4FYyBCKKc8AKtr3mECcpxs948DTD0bMi/BB
         Zn5fcARDQKEQQ52hBvf9q416lDQQd52msqG+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794803667; x=1795408467;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yb0ouDgf9S/OdWev3vcVfqdIAaKZrYAoDUUyKNG3AEU=;
        b=sFrp1GhO/4uuMhmo746jJIqcwEwdTjY0IMcA+2FF2mj++KTXkwVBp4Rh0Ep4dt7JW5
         XeEng5x2e9h9bs5Ij4b5YfZg7+kt4dD51xO0YJAwQ7y4xaZKEyAZt6wdMUVms44lNuRo
         XDsVZ+2yxT1J4EEl0HiYxYnPRaPdbIIHEthwcQFcMBQN9R2LZGmLuO6DYHPTroPpomD8
         CyuCxGSqRn8wCxMasBgd3a+9tsYUq+FwR0xFdcW8Iyo4z9mnZ8YnuWANCP+FFQ3OhKH/
         OcZQA9azpNc0njy9+JGS1zXfMd6pFgpLof7wAgRER38ni4Bh9ECepR3SBGChePf+TsIZ
         RAPQ==
X-Forwarded-Encrypted: i=1; AL+hErFbnGRl8GD4REtY5NJfqB7WDCUr9GMILyqb2UTX+7hxGcQpz9zk2itRjiwbCIXr9Yay4MM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9j14zHHRbm6XdtEkF3i65UYtbDs4mxpIk6//uSyobSlrn5TwF3
	j1fvHWxCSEhJSdPadlHNOpEhKC4tHS45rjX/BgnwWhHATN1bLr4Jsd01S6IWN2Qxq20=
X-Gm-Gg: AYBFou20IOOX5J8z9y1RWdqcCstHdAG4dqt8gFT7QEH6A2eU0IL65I1g5MaYSOfNyjF
	k/B21AC07phL9VLUlC1BSCWcoiF1iD/ZmHNi2Yni8DaVQY3urhSrPzT77EP8XvQ/iDhJml1urSD
	jwiN9gvAHpQsWrjSrzgW6D1hHsJsGIXHXwiSLqUolCExjFr0TrnjOvuScqUAr9yvBojdTKtGVUd
	S0L3Y0+qFpL/J4w0q2BV6hQNxDXQ3aNCNnNjtiizU1OQjIbn019V7ZwiKzuEwmTBA+aaFlM3o8V
	V2RWyYadzw22mWwsJuRZxKECoFgtT5UmGzAkcQgxR66SPj648dz3w30Df2eIqIgREu9WA0vASRZ
	aDMnTqN2vwnldx6xhY+gWCLUneKrlU72Tszg3KuQejMMB9NxobufB3HkL9v2/t2wDkBVj0K0Zkg
	2X6eXni7NsydL89TTHcRyu2ci0nnXLZ8DW+yyQb60phQqijeZyPJJ13qSZxvvw8e32Iw7tsaFtn
	nl88sPbekaNLd94gGYhuR7iiMI+QU14uHOv1ODYssNK7Vh2zSGsS7YqcicjRhJy/cHe1Hrb3C2y
	wnmmPYaxkpCMkrEvD96QrJROP0Zvt+P9VqPgzaHBrTHkB+s/HLqzG7cEBNU50WBkxXnq5/YoCEO
	fdOh6Bg92t6CcAuys8+8Pb2ZwjGXp/+QuGArkRiJY26egzN1b9nmPhLkVhWfxg1FozB/8gm5UdG
	nHO4HTzmEaSuUl3gHXkQiAy0bbXQAvvr983AtvfnNOKbu5OzIXHkNGfIatNx2r52xR
X-Received: by 2002:a05:7022:b0c5:b0:181:6b8:31f1 with SMTP id a92af1059eb24-1b4f5f3475fmr11110443c88.10.1794803667022;
        Sun, 15 Nov 2026 20:34:27 -0800 (PST)
Received: from [172.18.0.2] ([172.56.232.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm38362148c88.9.2026.11.15.20.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 20:34:26 -0800 (PST)
Date: Sun, 15 Nov 2026 20:34:21 -0800
From: Chris Down <chris@chrisdown.name>
To: tarunsahu@google.com
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
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
	compatibility
In-Reply-To: <9huz5wy4tufo.fsf@tarunix.c.googlers.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-6-tarunsahu@google.com>
	<DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
	<9huz5wy4tufo.fsf@tarunix.c.googlers.com>
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
Message-ID: <20261115203421.38c206b35f5b12e6@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Tarun,

tarunsahu@google.com writes:
>Techinically this is just for readability.
>
>WDYT?

It doesn't help readability in the generated docs, though. kernel-doc
splits the parameter list on the comma inside the macro, so
kho_preserve_vmalloc() comes out as

     int kho_preserve_vmalloc (void *ptr, DECLARE_KHO_SER_HDR(kho_vmalloc# *fhdr))

and the struct memfd_luo_ser and struct luo_session_ser definitions in the
ABI docs end up with a member like

     DECLARE_KHO_SER_HDR(kho_vmalloc folios_fhdr;

I'd go with Pasha's suggestion and use struct kho_ser_hdr directly. The
pointer can then say which payload follows it with a comment.

Chris
