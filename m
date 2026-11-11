Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794432699;
	b=0wjXvO93L6YAhCYH+suye59cBYkF0TLk6aIsoykQJDAIPPYGNX26dOAekuO0HS5N81Zj
	 TLsT7fUshWsR5MiHCzwMC0OBbxmRgWwAcEVFMrCADUobbjY59UY9uKTu6nvJnNO+jHv39
	 LoJZX7PYN9ddkmB+LNwgL8lhr/QmnvHG641fkoFFKLRXqGeOsoR8JjN/66ANoWXMXEg/e
	 xCsMPIox8eavg2XfsmykrADVBOC9UtGDk34Hg4wQIyhkazPD0L0mKGGqxm6B8fDbVXJum
	 yz7bV8ZEsT52A2Ndf0f8xnp3cnm6RcZWsbgxHnas6sda09mofEr15AMeGthGk8ktSxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794432699;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=UVG/CGDtj+WnEdQHJR7jPrTzEBlnNFXUpNMHguIfMb4=;
	b=Q+NPfI7jXdPFh1pYO/6mDMESswU0z8tdiRBGz8UKnbUVs8QSFcx/GmV4DCJkJ+BRk/gw
	 pZyPeIxUNFzTPt9VNrvJ0b4fvptCLuMiEAX+ZT97xl819eINYTlCg3Si3qJ4gr0GWhuxV
	 nOhJQ89tktpPfKDHoehLJrnoFqoU/voLTGCsx7RwFa6Zl3vLLS6flzoL9BECSlE4nkBsh
	 VuF0HX4r1y0fdMKNkmP+ekYfw3y/v4yVk77fJCANsoMM87dJ+rJCQHSmZVnkJ9xGobf3m
	 KApdxxK3/0m17niH/fsPIrb57NDkGmoGwKMBFJVHEbbQky3V3LHO4ZFgmKEYeQ+fTWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b="Gz+KM/8E";
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3806D606A321;
	Wed, 11 Nov 2026 21:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3806D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Gz+KM/8E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=UVG/CGDtj+WnEdQHJR7jPrTzEBlnNFXUpNMHguIfMb4=; b=Gz+KM/8Efvp4Gv5jveINaF1L7U
	B2bI72LQUT+elW3NVEGKWQvbtDRb2WnF1FWV7f/QQ9VCM+eSUNYmPCQUGTrAEEeZboL45BxGTR3Wc
	hbEyYehDEk+qjUsuhPxmquHogbDfY3jtca9FJXkCe+gpMkZKdai5ZWFYEP5Z1pWOTt0/XmpaHvNr/
	4Rp/CcZkiVypa3kbL2gDuC27IkyBJhsGivGu7l3W8XgCySwdTjViNgsb6cB3V2GVTamUTm7yar4VB
	jTDT/Fi4uQlq5Pky2pFMVJvcCHNx05I7RdmgUK3g7JjEU0ZG/LQH0Q14L3z9o8Y4Do2IlFSTDtyMQ
	t1zYYAyQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFur-00000007p3u-2ymr;
	Wed, 11 Nov 2026 21:31:37 +0000
Message-ID: <15a3112f-5411-43b2-93f5-5f62d627c920@infradead.org>
Date: Wed, 11 Nov 2026 13:31:35 -0800
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
Subject: Re: [PATCH 5/7] KVM: Fix comments that refer to non-existent
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
 <20261111085448.1130701-6-fuad.tabba@linux.dev>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261111085448.1130701-6-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/26 12:54 AM, Fuad Tabba wrote:
> Comments in the generic KVM code and its headers refer to functions,
> structures, fields, capabilities and Kconfig symbols that have been
> misspelled or renamed. Use the current names.
> 
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  include/linux/kvm_dirty_ring.h | 2 +-
>  include/linux/kvm_host.h       | 4 ++--
>  include/linux/kvm_irqfd.h      | 4 ++--
>  include/uapi/linux/kvm.h       | 2 +-
>  virt/kvm/binary_stats.c        | 2 +-
>  virt/kvm/eventfd.c             | 2 +-
>  virt/kvm/kvm_main.c            | 2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)

-- 
~Randy
