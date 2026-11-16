Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793185;
	b=11zmBoTQ1XjtmYcSJCBQoi6GmJ66rkpSBzjTkXJQWyfzsuLvlwloy2Td60FNZcWS/M1u
	 iYq9WpSPujRMkwE2zAjcSoNHGEsj77hDu4g6KG9y/a4rY434TZ/kNSh3566rHs3a33ffA
	 7SnYFni1GPzi42vrh0r4JPb/PDxMZy+pVymmN7gWP45BjVigdOt28Hy13uNnZ6ConQV8g
	 qE1v1c3sf2NM0V9SLgaZCBRU+F1Ypzqb5XjubdjWxrTiP5wecH3r8yZ+1eXYZpqXfdMeK
	 kN3OU0en/yxCOVlsWudyv1WHDDgO22p0UnRFOw3Nj0x+js3uc2pJDKohA3T15RIfI0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793185;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=JysQz6CZtEevZBRMKq+wJkccgNZiYfQMuPgMbxIaGSM=;
	b=3ZRe1bnq6iZj2HxCC6Di47gaVNB9MFK/C3wcuwIqqgPtGRZp9tfrll0674XqXoq1KGvg
	 QT9wMAlhlR79NSWtL99680f1aZ9a+u+sfLleh24DWEW8Hygsr6K7ZJkw5M3dC7yoiZ18A
	 EVLVV1jdhExl5W8QknO3+dqWnxWTZEJVGn7cwVUSs7yFM4KOBhcXSlnpAgq20I1b/+tEL
	 vqIJyeqAO6ZLJ9/lf7yEEDtjCtkoScnUrzSzWJRC2oRRB3C6FOkAgWC16sniNGD+IHnaw
	 /KjjuR16Fo3owQERm2QGW7NwH+0w0Fw3uOkwXJpXlPda109ZBLRrTsOHviFj5AOIzGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SwJveGtN;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6C0606A31F;
	Mon, 16 Nov 2026 01:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA6C0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SwJveGtN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=JysQz6CZtEevZBRMKq+wJkccgNZiYfQMuPgMbxIaGSM=; b=SwJveGtNqn04m3MYoROpqoNFU/
	CS+l9mmQN+aP5u1WkpnJH/1RhvgUoo66X+cgieouf8yRUooKelPQL1wzjSbNtx7FGLzj+EnH3fXxa
	NhbnFK0HAPppb7qq9LSdITr+zrAIFfe9hTJ9W+CMHTetGc6YPRhaHdyUUFCz4czm8+0GLCpaIEGSw
	WmwBqjUMgSgXFC8YVK3WEX/1NBzDgiIwRDz642nAStUl6rMvBJKcrg3oJGiQ939a4rYKjhwBljDP9
	U9tTlj7cmF/9LIHW+5L7jAtZlNu0YS9C0WkNVbaLRlA7c/HO8Dw+BTQyMCdZw980x05tPHTrPn1Tr
	8V+wPx2w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSlh9-00000000tlg-3G1b;
	Mon, 16 Nov 2026 01:39:43 +0000
Message-ID: <f4063ec4-2f1e-40b4-bcfb-83c3caf98cb5@infradead.org>
Date: Sun, 15 Nov 2026 17:39:43 -0800
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
Subject: Re: [PATCH 4/7] Documentation: KVM: Drop the stale number of vCPU
 request flags
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
 <20261111085448.1130701-5-fuad.tabba@linux.dev>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261111085448.1130701-5-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/26 12:54 AM, Fuad Tabba wrote:
> vcpu-requests.rst states that only two request flags are defined, but
> KVM_REQUEST_NO_ACTION is a third. Drop the number.
> 
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/virt/kvm/vcpu-requests.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/vcpu-requests.rst b/Documentation/virt/kvm/vcpu-requests.rst
> index 06718b9bc9597..eedf338d47d6a 100644
> --- a/Documentation/virt/kvm/vcpu-requests.rst
> +++ b/Documentation/virt/kvm/vcpu-requests.rst
> @@ -141,8 +141,7 @@ KVM_REQUEST_MASK
>  
>  VCPU requests should be masked by KVM_REQUEST_MASK before using them with
>  bitops.  This is because only the lower 8 bits are used to represent the
> -request's number.  The upper bits are used as flags.  Currently only two
> -flags are defined.
> +request's number.  The upper bits are used as flags.
>  
>  VCPU Request Flags
>  ------------------

-- 
~Randy
