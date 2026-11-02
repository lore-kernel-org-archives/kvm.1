Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622577;
	b=GmzJS1GcLqjVA29WB7rd0xKf5mbemGFrXbW1jRHZqmEycjorHXh7AyAC/BtokBl/LlQ4
	 8YQgJ5up7wKhTqBc6i+h8jCrE3+4o/pa3qr855gf7pNg7TvBzpNQ3viZLS5nBr6n5ti4X
	 CB6eDhIy+d0hzWyoDM4PsOx+NvxfVE4jfdeNjfiOiTqGFqx2DHHcLvmWLldy5PpfWzhxq
	 MurZIpA+fuLlmGq66mraIf5JCcAafbYZ0R01YW9O91uuQyjQrzDrNpa9yZLMPJeyChpkd
	 IcUT9pRS+kEJ4WT+9R+ZONzMGrRjjzJgjQHscL/sS39sntvXbB48k9RQUUKtZiqr+AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622577;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IXXGa8xeqcfH04r8FcOwpoXwrqPAtaIbRm220MXW6II=;
	b=bTGwE/sPzxlHtNzym/OXlu/oV44qosXY3/B93CSfrvfPbINsuaXzsw6mscMhaQqW7qdZ
	 mXgWYO1EHiunB8r3C5gggUZwXP3XM73DvRXANxb+vc0ma/dtW3iHcm721vZlCuE66oFzc
	 kSgoXEYuqflw7XRAZgpUgoF/BLzuiRdJ/4XY7j/cm51O7Bq7hWmQiEbzMHkUQ1ZrFc/Nf
	 xmi2hBG3+9NTp4ElCrfTErsbJOJTRkdS0Q5PdIkoAjgS6IdG3ofk1m4D0WSZi9atGsVQL
	 fTNlGNBGPJSZetG9HQa932v3mkLFZqY/S+nJGXF60lI7A8AL0EfGNR63UYYgJstuvdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A49B606A327
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 12:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A49B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a0027ad06761c59e6b3.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:27ad:676:1c59:e6b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 81A5024350C;
	Mon,  2 Nov 2026 13:29:35 +0100 (CET)
Date: Mon, 2 Nov 2026 13:29:34 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v3 3/8] KVM: SVM: Hold SRCU while reloading guest-owned
 VMSAs
Message-ID: <auiB-cIMF-ybdvFn@8bytes.org>
References: <20261102114137.1198982-1-joro@8bytes.org>
 <20261102114137.1198982-4-joro@8bytes.org>
 <sashiko-outbox-193356@kernel.org>
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
In-Reply-To: <sashiko-outbox-193356@kernel.org>

On Mon, Nov 02, 2026 at 11:53:36AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] KVM: SVM: redundant nested srcu_read_lock() in __sev_snp_reload_vmsa()

This is true, I will drop the patch, thanks.

