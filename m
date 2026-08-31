Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CB33AE18A;
	Mon, 31 Aug 2026 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165242; cv=none; b=C7KB0ZqNSsZhfmX2t9li7jrqrvHx1RDdo4mOj31I22NKYPNeCAvodxHur6nf1eAoZCJPAqIZDMUjycEmaKhokm1pmjEXiyhlOayVSc2boQnon4YKo3OytmX0Sog1qq+uEIdy/tSmNLC59bNEHqEajXlO3OSwC64pxqQvpOaQwaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165242; c=relaxed/simple;
	bh=fwFFIqVPng0FWB2Lx9Y4U6/a8WISTMZbjmkj3/3M/bo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pdtJIBC/3X3PS9d75IESZ4ESigGfMUFjd+FdKa6xqz2voBCOmGzS/5KFXojJOCeOK3Z9/Q+YJmK5sRRWCZjJMZkzybuT6HhxT/9KZsaYnxVDnOE5sCp46zLAwtDOsZcUgDS31TGwd3HODIu5bvr2wiNBiHu/3pQdWaXdXHBola8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D/LoRkGM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D/LoRkGM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=fwFFIqVPng0FWB2Lx9Y4U6/a8WISTMZbjmkj3/3M/bo=; b=D/LoRkGMPMWcvC1tfmgmSsxHUl
	7+eV1p2HvRNRdog29xhoCX7RSM0cYJ5dF6PraNmaZLyZMdgd4smlIoIL/E6YzjQ3J39wCCZOvyiGT
	pRHdlI8nCo09EGRj1Gty75vHN+hi3KlZ1dx3HTH/foJ6VhuobFEDTCM+dC/1+YHrVCCPGxou8rArY
	MqQ2Ue1bcIFA9JVdYN8XbUQHdxSBP/IGneOOOG8g9wLBg12IT5/WABmh8QEZiN4cJNY5niz3jnIdV
	VbB8NtU70JEm6auQoiI4RI7f6zcjlvW6f89YBpox+mKTaaUc8Cw5P3yL5RVOFUCJFY+yZz8x732Px
	VGcWnh5g==;
Received: from [172.31.31.139] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x0xSh-00000009fo0-2qMu;
	Mon, 31 Aug 2026 08:33:52 +0000
Date: Mon, 31 Aug 2026 09:33:52 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: =?UTF-8?B?RnVya2FuIMOHYWzEscWfa2Fu?= <frn1furkan10@gmail.com>,
 linux-kernel@vger.kernel.org
CC: kvm@vger.kernel.org, x86@kernel.org, seanjc@google.com, pbonzini@redhat.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, paul@xen.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH] KVM: x86/xen: Convert evtchn_ports from IDR to XArray
User-Agent: K-9 Mail for Android
In-Reply-To: <85c66385-7a28-4779-96d4-6b34f53b5994@gmail.com>
References: <20260706081311.13633-1-frn1furkan10@gmail.com> <efe39d24a2621ce23f9d53471b3b587feaaa8526.camel@infradead.org> <85c66385-7a28-4779-96d4-6b34f53b5994@gmail.com>
Message-ID: <B9710C21-8127-4DC1-8DFF-D6551EE09AE5@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 31 August 2026 06:59:50 BST, "Furkan =C3=87al=C4=B1=C5=9Fkan" <frn1furka=
n10@gmail=2Ecom> wrote:
>
>
>On 7/7/26 12:16, David Woodhouse wrote:
>> On Mon, 2026-07-06 at 11:13 +0300, Furkan Caliskan wrote:
>>> IDR is deprecated in favor of XArray: see
>>> Documentation/core-api/idr=2Erst=2E Convert evtchn_ports accordingly=
=2E
>>>
>>> kvm_xen_eventfd_assign()'s single-slot idr_alloc() becomes
>>> xa_insert(), since it was really an insert-at-index, not an
>>> allocation: -EBUSY replaces -ENOSPC, still mapped to -EEXIST=2E
>>>
>>> kvm_xen_hcall_evtchn_send() drops its explicit rcu_read_lock(),
>>> since xa_load() takes its own RCU read-side section internally=2E
>>> evtchnfd's lifetime is still guaranteed by kvm->srcu=2E
>>>
>>> xen_lock is left in place: it protects state beyond the map itself=2E
>>>
>>> Signed-off-by: Furkan Caliskan <frn1furkan10@gmail=2Ecom>
>>=20
>> Reviewed-by: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>=20
>> Thanks=2E
>
>Ping?

I have a pile of Xen cleanups outstanding; I'll tack it on the end of that=
 series so it doesn't get lost=2E Thanks=2E

