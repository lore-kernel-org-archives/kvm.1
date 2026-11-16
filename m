Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830197;
	b=SiHoAWsrszsNUoGKrcoOXLuhj+B6bbN6vMEt5mKBBoLE7y7sHAFenOqldn5FkCmuLML3
	 pMVH/lnbT5Lzn1R2pETRw3qz3D7ceJnZ8JlbpPh2CSTCNmw1yn8jG1ah30gUdSuk7LlgU
	 iwWSN6U7YSbWFu1NSCefn5ONUGSxYVRtQvQXxpxuEUZiVtWBcGzN03H4szHlHcNY+/VG4
	 nrWwyDnGqzA+YZox5RAHrwD1Z/oiKW1OZqX8JaOzoRCJRrtDwogBaKwlkJtQqMGyYEBkU
	 RJ4e8L06KgqRkLOQEJga9Q0HIUw3f47A86t4mDQ5ay76DdRLA8tdstkgtc3vKGkMZGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830197;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=GeVXqqtOBRanGI741BAYhJK/fg1GAPjaiJ5K9yFk9wM=;
	b=X4UNphJ/NQjLUC3Wpz6meA/6RIkEWAqzYD3ffNORPOpHM16QdkPiAUo/JvtuT4IBy+zK
	 HAfnH0sNLziaS4CkvDZtLnV4j5QUgOf8n9mKEF6PW+9HoKuEbT7CvxnF+9E+PB7n0wc7V
	 eJ+3FeOLYk045ds6P6XlmZVZ/FQVPWVJZtvd+v285GsTQOQZhTl1XNm9l2FC5aJ8pewfA
	 3P8nNS2AJ2UwDxB25trMA+1rB0dpZpFq6VeDnXnOI2H5n1KkClHWU7rKSwyvxzWmIbrfQ
	 Iv3Yz9tl6f67av/432KiT+YMWizQkRYK7cWSbC/NZGvEaMr5n9sf4tCm4kIzGM6uE9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=6jI6RStq;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB845606A323;
	Mon, 16 Nov 2026 11:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB845606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=6jI6RStq
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GeVXqqtOBRanGI741BAYhJK/fg1GAPjaiJ5K9yFk9wM=;
	b=6jI6RStqoCtlvQpe4IYTr3xlXv3TnYB2PW2fNNOWwVLG28g9WsqWYNxCahxVcveX3PWQ0OIWf
	OyarOUpcQmFb1UTa/vsBsjrhJboksjzWcNvt7LeAi68MEoF5/Ezhx3bbUvFY7eb9NuW1IB/sOSz
	Qp+hzZ9QZwTJ3AYuPZQbuQI=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jSmXr6Vqpz1cyPf;
	Mon, 16 Nov 2026 19:56:12 +0800 (CST)
Received: from whupemo200006.china.huawei.com (unknown [7.152.185.252])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BAEC4055B;
	Mon, 16 Nov 2026 19:56:31 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 whupemo200006.china.huawei.com (7.152.185.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 16 Nov 2026 19:56:29 +0800
Subject: Re: [PATCH 5/7] KVM: Fix comments that refer to non-existent
 identifiers
To: Fuad Tabba <fuad.tabba@linux.dev>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank
	<frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Huacai
 Chen <chenhuacai@kernel.org>, <linux-mips@vger.kernel.org>, Will Deacon
	<will@kernel.org>, Fuad Tabba <tabba@google.com>
References: <20261111085448.1130701-1-fuad.tabba@linux.dev>
 <20261111085448.1130701-6-fuad.tabba@linux.dev>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <4fb0e902-32c6-727f-7aaa-e1a7381dbe15@huawei.com>
Date: Mon, 16 Nov 2026 19:56:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261111085448.1130701-6-fuad.tabba@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemo200006.china.huawei.com (7.152.185.252)

On 2026/11/11 16:54, Fuad Tabba wrote:
> Comments in the generic KVM code and its headers refer to functions,
> structures, fields, capabilities and Kconfig symbols that have been
> misspelled or renamed. Use the current names.
> 
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> ---
>  include/linux/kvm_dirty_ring.h | 2 +-
>  include/linux/kvm_host.h       | 4 ++--
>  include/linux/kvm_irqfd.h      | 4 ++--
>  include/uapi/linux/kvm.h       | 2 +-
>  virt/kvm/binary_stats.c        | 2 +-
>  virt/kvm/eventfd.c             | 2 +-
>  virt/kvm/kvm_main.c            | 2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/kvm_dirty_ring.h b/include/linux/kvm_dirty_ring.h
> index eb10d87adf7d5..8679ba17bd1ff 100644
> --- a/include/linux/kvm_dirty_ring.h
> +++ b/include/linux/kvm_dirty_ring.h
> @@ -29,7 +29,7 @@ struct kvm_dirty_ring {
>  
>  #ifndef CONFIG_HAVE_KVM_DIRTY_RING
>  /*
> - * If CONFIG_HAVE_HVM_DIRTY_RING not defined, kvm_dirty_ring.o should
> + * If CONFIG_HAVE_KVM_DIRTY_RING not defined, kvm_dirty_ring.o should
>   * not be included as well, so define these nop functions for the arch.
>   */

The comment looks a bit obscure. We can rewrite it as

" If CONFIG_HAVE_KVM_DIRTY_RING is not defined, dirty_ring.o will not be
  built either, so define these nop functions for the arch. "

And personally I tend to remove it :-)

Thanks,
Zenghui
