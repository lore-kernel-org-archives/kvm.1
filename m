Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416718;
	b=D2N3RSXe0S6h9KlPisAuMQ5TbKeI7K0JX/1Lc5Opt02iJzvI9rZJYfI7Shfx0k6Lkhfn
	 1+h0k8YRMUPYum3k2bNkJheqYWqPa/J49kzTcKiqrMZMAag+SB62EqqIInvwoXPcblKZ0
	 mDpWwsLOy9MxdLEJv5a4WsxXxNYNQKibOwOT775W7dSHXT5hSY1kboRVbs1DlaPBf2F0U
	 KqvuYqZORL9v+XXejjFrYRQKaqaIijSaGhSmj+jmwYjK+sXvwoI/EUUKmF5qr+GY8BX2o
	 M1cNBALkbRhOMjW038MmM0g7mq0A4FjYuLNXKvzHSFl4tq9SZRwfEITlNbp+2LiNzWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416718;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=tK+vLyDUhgkopqQwm3JAkAKRyXu43NIrxCF2GpZo5gI=;
	b=GWXYI0b7xIwKBvb3oxDi2cxqyWBNGmtY8/2mpdBPMh1K7XlF22GeG8t+j2gXt3uIUld6
	 yFxjMw181Tf6xHTw5bNALmPPFec7nM1IX5bHqKhtkNHk9i/9KH7yfPuHrPMDNO1S2JEVQ
	 mqjbVd/2M11CxM4GLctfSbVl3E4v5+VkIElP1vXNT1yt8OzEUKj5FcXXdRYVxBgGqeYum
	 RVtlBU8wo2Mz8UyIiPFA3oV+TVlA4KlglmwGZgZMPiM8Gp25JhklRd4lek6PEl9kygfRQ
	 EebVxs2EILyGbTnkv3cgdUouxt56J3VctcQtJe65uExMnIgkRbYxAhrLEoF5Ghd3XRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vuDNM5WF;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB9D606A31C;
	Wed, 11 Nov 2026 17:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAB9D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vuDNM5WF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tK+vLyDUhgkopqQwm3JAkAKRyXu43NIrxCF2GpZo5gI=; b=vuDNM5WFzMj/kWAKe7vbx2NswV
	/9ersGVOCAVdfbWnD2jQ3lxzvz6mMF0uZAtgkTP/CmriLWDA/0WuUo0pVJELw4sELVo/qs0XRh4RT
	3o3owQz9XXkC+/vNPFy7DpCzSLm74GhuQF4zrrwOJLKHBiU0in74N/ScGdYDwp2ZIKyGEo1kjsTeb
	oI+49AfCu7u64CLhHk83Cz3LxY08WmAHE4FjyqrLYFvnzwhBlt+6o89tNRL0XNp7HwCaS65S5Y6Cg
	pair/B7WOKKVwE7V11NmrNDt26QYUTzK6LC1EOp/4rj5lyzJbOcvV0S2nwrf9WQsgxKGfXspP7mPb
	GRdRc7qQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRBl7-00000007Gj3-02Fu;
	Wed, 11 Nov 2026 17:05:17 +0000
Message-ID: <b5927ae8-edef-4042-bf64-da873eff0117@infradead.org>
Date: Wed, 11 Nov 2026 09:05:16 -0800
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
Subject: Re: [PATCH 7/7] KVM: Fix typos in comments
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
 <20261111085448.1130701-8-fuad.tabba@linux.dev>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261111085448.1130701-8-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/26 12:54 AM, Fuad Tabba wrote:
> @@ -2526,7 +2526,7 @@ static inline int kvm_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
>  
>  /*
>   * If more than one page is being (un)accounted, @virt must be the address of
> - * the first page of a block of pages what were allocated together (i.e
> + * the first page of a block of pages that were allocated together (i.e

                                                                       i.e.
>   * accounted together).

Anyway, these changes look good.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.
-- 
~Randy
