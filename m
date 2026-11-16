Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794792649;
	b=iqPlLHIe8ZoZyjo5hlRVGCS1xQFU6TGEse/+BLLDP9jV5QDfu9xMAXeGI6A2rDovki9T
	 Jlckz+XmCEE0a+9ebYT1qRRJxyXwr17c5tZJgQZD/Hl9ggv5Pd8mxmXRWWRh7Zn/vbtmG
	 76HtbcLsUAb0A/Apv1kx98MENui0G4Ariu1POsYTkqeL6psDZ5Zks/EREAlN7wV8uVEq/
	 rY/haxZuBzUGKDDiWbi3TJM0chINu6lI56FpVjb7ZzzRF/01itTNKhiWAvuPwrKeigvn5
	 1kzp405vl9F5ib3l/rEjK9MHs7v3rvOF0yRxNcbxomU4u0P/uNC+Uym1k3IchHau65Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794792649;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ETxSB6+1Q8S129JltJ3UvkzP7H5ZCMsFruVoTDY5lTs=;
	b=XDYscW8oPYraqnjS6PHuV3EqUABk1HRfFGO2cG5ssG3WIFI/7/Jbh92HYBZZhv5sli8q
	 9+jzu/5d0t1uhclaAMLYb9TxcRN4T2UHTOhF7p1B/rS91LxHXb7ckxNrMTXHreQDTZ36S
	 xCZMmhmvVRZQPhgOv6MSS5NSKKwf8ZAG7uBjB94fQJHCYJ+hL2Hz4L+eLHJohNlfPMPKQ
	 kk3FhNMF2F+nPYFOPxNK28zv5eMGPDngm+x46DG8uLm1hlubtnmr7iFbKASqcBNkHkMW7
	 UdShdqwul2C+PLpDKrUvbmtrJ/EW3wYQpXF55nOgTK5sOnNJqzVxY18sultqHBJSW5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ghDBfQzp;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538B5606A31F;
	Mon, 16 Nov 2026 01:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 538B5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ghDBfQzp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ETxSB6+1Q8S129JltJ3UvkzP7H5ZCMsFruVoTDY5lTs=; b=ghDBfQzpPBRn4EQmWC1eVYv5HU
	WyJITSAv52kubnK9S48qquoOUAzweLgj67M2IwwdmTqoLmzYFKPR7ss9NvslSvhjY2Rih38u7q5p/
	bGgeTrWJVjwt6C0pam88xe/oT5mrwt/lPDrPSPPfC64XJf1ioK7xiQjfDLNe1s8A1ndlfD+aJiWDN
	6xh9xP/7AdvHMSSJ4fKxabgvvZCnXiUzYcRxHwcPMeLGU0fjg7PQ7UsgshT4EZU/lSEUpUOQ2eqMP
	VM4JrqXfMRyC4M2/lOvdG235trBgQUy1O34uAKknLH1eR4DqQD4FC82SyVJyBLl8MiXLP9k7tFO9M
	vAgYgV0Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSlYW-00000000rrs-2rri;
	Mon, 16 Nov 2026 01:30:48 +0000
Message-ID: <68254a9c-f521-46ee-a74f-6020e4689e1a@infradead.org>
Date: Sun, 15 Nov 2026 17:30:47 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] Documentation: KVM: Fix references to non-existent
 identifiers
To: Fuad Tabba <fuad.tabba@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org,
 Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>
References: <20261111085448.1130701-1-fuad.tabba@linux.dev>
 <20261111085448.1130701-2-fuad.tabba@linux.dev>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261111085448.1130701-2-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/26 12:54 AM, Fuad Tabba wrote:
> The KVM API documentation and the review checklist refer to
> non-existent ioctls, capabilities, structures, fields and constants.
> Use the names from the uAPI headers.
> 
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> ---
>  Documentation/virt/kvm/api.rst              | 40 ++++++++++-----------
>  Documentation/virt/kvm/review-checklist.rst |  2 +-
>  2 files changed, 21 insertions(+), 21 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

-- 
~Randy

