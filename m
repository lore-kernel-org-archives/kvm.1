Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461920;
	b=FCdHx090P1s+MTnFlWsuzeDu2K3bFcHRfpyxk8PVUbj1eKjIzjHwA6X6CCeq1XOwcdIx
	 wQGHc5lF9K/Q4CjCj0BG9H0s4iCw6ED66HhpnI+wGU2MMi1I0Q71Ytv/roQ4wSra9MDzS
	 Xbs8Mup4WgzlqI5PLUbkSyeTGQqGq8wETcTuxikPscFbU0VQ/ZRahRKxe/2PwLAB7xziZ
	 6VqI/c0meB0V9butIH9JD+7/GkBlGa+aTMcwxADM97vV/Hv0C2aNspg8ptJKBTIKyxuvn
	 0utloheXU6yp83sCVjjigxOSOVsT/bDod7z+xjCEtQDokH/O/eyA9321h+dkdXtEKoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Ivc+yZF1e+YkHBH2XdPHCIshByex18b++1Ftez3VniI=;
	b=0+kgozmhlXZmI3IhynPUO3Co3O2cN3lbsL4fxPdP89+CaLioDhxxHgP5CtkurUCh0dn2
	 xup9GEz+ATK6zLvjTop2nQdOw75CpaRP/OkCCkeokskj/NWKl3UKH2wPM+FgxKPopFp1M
	 2hRz1W/oR0eVUbKs7Oq8kbi4AEBxzc1MB83N1Ex9FRvaO/btDC1KT2QugATYyn7PJ9SRk
	 ekKve8n+yMQMd8JHiJ4IJuDzqXHUHF2ZzEqEUTLEvA3RXcDQRUzcLFAGCrX/GuAMn4JH7
	 FCqiE42yYzgqEC3it4KOijvDBSr/UEMllXn0LBSfarpTC6zjY6194Bp+SbMObzfEu5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0959606A31E
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 19:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0959606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a210470b49so36215905e9.2
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 11:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795461913; x=1796066713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ivc+yZF1e+YkHBH2XdPHCIshByex18b++1Ftez3VniI=;
        b=InABI5AX3pKbG9IQdQzgyiryQgftPzVdm8SbCVlAtvY6rv1Dbtd3WqRdOsoSQNuH4Q
         3Hds5U7UsF6QV8qA/kmA2nRBZ4Bo3v0/ytG7/lYk+1RArBNhdK7fiIVbuC3ll8By/hi0
         Ikf4sYbQPmXmxTlwH+35fLzxfkcgAfi/mw9Uzruc3wtQN/4hWf7yzDrpAKG5QdXETgzH
         sNJZq4jptTzE51wqCMmE0cg/8YPaNt+NCpP+wxH4fX2qT2bPokgyQ82oIdUI8kOOv1Kn
         mYJsZKAzW/NPFxLiVy/8eLQxuR2qnqfuuPnxRRk4prHaTeLuB49nvoqgY1OPh75ADAcZ
         CwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795461913; x=1796066713;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ivc+yZF1e+YkHBH2XdPHCIshByex18b++1Ftez3VniI=;
        b=esEvNgn5T9HpZYIPDaxi/nlwd4JRr/6KeeIL2CTSUb1PZlZels4cYmH+NMsUXGAT+K
         8RpEA85q3f8BDAZ30cjx0Lie7x29+UALQy2xPX8PPw0FVoQns1WAPYaztBQRPsyiSVTx
         ltTWkURG82fYDK/ZTocXfHYXUhdj4Y/WSoJTob9Op8dbPReajIp6n9cssH0g2Al9ATx/
         SEsmoQedJRzWNLdS1IOSxKw6Pq7jhyj4XmbHyNGKqL1TqXzaxHk9FekQmYAfuCiEMTWe
         WI41J3pTab0Gbix+WNCKGIk6iJu9l7JqujZK1x0RtOhNc+3qKxZ18n0CpirHlUb+DbzW
         8LFg==
X-Forwarded-Encrypted: i=1; AL+hErGIwa2hSBUmJ/l8HqFJ/6Ut0Ou7C3zq0y57z2tLulMN+DAAuEwRDwaJkj3BZr0NpCWlg9A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+n7naT6y0AX+qRIFzBwyD7CM/7pk8JNLYR3w2YvBAwO1qJt08G
	9HOu+piN3NEk8xupGsFctidbprhRj1N0Sf1BGC+VDMLVcsRpagYDmD3ywjDA7jzK5tk=
X-Gm-Gg: AZFdTZfesseEd4Rub+/c7tr3KlZvvNFU0vj5ZMvPRo2nm4z7+9X5JCK9t70u278vapI
	+b71Io+E/WR4VZxZ3egOwKza/NwCcnaENy7TL9StdFgDI8QbCdA74t3PEjKXnSLz/dLZj4HcKJi
	R/sqw3chpLiYDs2lTfHCIGmA/fBJdy02456yRjQJmkBht9HQSDJtjxcJnt5v5k5u0jK16oTW9rn
	29D1WGL0Jp8tU4mJheWdM52Cg/j7Ne13oQgII2VnQyakmO+9FQn+7ZjAUNlNN9RIIoFshJbe/KU
	kt2sHGe06rvQ3HP3DPJ3Rp/ot923SVE9XWkF0B5jAXjO0tS75pJl67wsbgNol/5Nd1JmFxNSu7p
	xx06wRtqSb0Ov63ABytkOx/Qa6nTFwvjv+7OZd78kUYgCOTANbuETj9XF7Hhhkl7Jj8smMmC3DH
	njWdWwl3kpH1ouDDwB8HPAwMPq1kjgYYJfjt5wIQZVBb2R9wjkAyAByYHSmgUkkZXF9CZMdrMPN
	9/C2PBmdv1mTW/BwGQV7AhK7i39nfYvNj6P39HuVnYmO7gt62XlRF4Bmfi8aNTGV4n1jG9pfg4C
	OmOR/tENhHgQzIXkduc=
X-Received: by 2002:a05:600c:670b:b0:4a6:30c3:1114 with SMTP id 5b1f17b1804b1-4bb88922df3mr240330235e9.12.1795461912931;
        Mon, 23 Nov 2026 11:25:12 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884911e3sm442986305e9.6.2026.11.23.11.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:25:12 -0800 (PST)
Date: Mon, 23 Nov 2026 22:25:09 +0300
From: Dan Carpenter <dan@pereq.eu>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: nv: Upgrade sub-page TTL hint to maximum size
Message-ID: <awSTFVxQQuz1tbk4@stanley.mountain>
References: <20261123182312.4842-1-maz@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123182312.4842-1-maz@kernel.org>

On Mon, Nov 23, 2026 at 06:23:12PM +0000, Marc Zyngier wrote:
> Should a guest be slightly foolish and submit a S2 TLBI with a TTL hint
> that describe a base granule size smaller than the host's page size,
> we take the resulting size at face value and feed it to the S2 unmapping
> code. Which legitimately screams about something not being page-aligned.
> 
> The architecture allows us to drop the TLBI on the floor, as we don't
> support a S2 granule size smaller than the host's page size. But it turns
> out that doing so is proving pretty hard (we call compute_tlb_inval_range
> from a number of places, none of which is amenable to an early out).
> 
> Instead, detect the annoying case, and pretend that we don't have a TTL
> hint at all, leaving the size upgrade mechanism to take place and use
> the largest possible size for the guest's S2 granule size.
> 
> This will still allow nonsensical stuff to get through, such as a 4kB
> level 2 (aka 2MB) from a guest with a 64kB S2 base granule size running
> on a 16kB page size host, but that's not worse than doing nothing, and
> the host code won't get shouty.
> 
> Reported-by: Dan Carpenter <dan@pereq.eu>
> Link: https://lore.kernel.org/r/20261123-inval_range-v1-1-815e15797089@pereq.eu
> Fixes: d1de1576dc21 ("KVM: arm64: nv: Handle FEAT_TTL hinted TLB operations")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> ---
> 
> Notes:
>     Reposting this as a first class patch, as I'd like to plug that one
>     as early as possible (and Dan has plenty of other patches in flight...)

Tested-by: Dan Carpenter <dan@pereq.eu>

Although obviously zero is handled on the next line so there wasn't
much call for testing, but I still did do the testing.

regards,
dan carpenter
