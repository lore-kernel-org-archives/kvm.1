Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559495;
	b=Go6qNEZK+KArKSuHuUO6u1X03tl7PQ1UEIxslr50S1xpdlVXBysIhpMhQFh2KBUAIKgn
	 iUSB8DO0BkL3jAdXrtpgvpbhH2g/CMuhGTcRPUEOjmNPPkrJqRQnObVwUTc2kk5C34Wr0
	 FbqbaobpnS/JL4ewatROKICds9sHtS76sSS2OH4cK8GpXfhdiF5cupol8yp8oSbCAxbko
	 byeI1mDcC9kMr8ZAhoFXEox5RjrWSENYLih7up/PTwCh/stblbM38gf0Qdk3VnK6UpTmq
	 9go/Huvjy3uY7JlHryM9Uwff9fJWRE/duONy4d+BLSgc4+leMHyBFJBvi0Gkm5mEsGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559495;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=35X5/39DGlK4vVgt3yjbOmExblr5OIYpDLCti5rn1Hk=;
	b=NJM+mwFzTpkOEml6YddXfPoRotuU1X1FHKJbOjArPFol0NkvexkpqfKadbZ6pXWt3WFa
	 w8PIrQzMh5MpVAwURktwMlqapmuvqju4PUtq1ysjw8cM0DUgabsM3OGvrosEZ9g3tCFG9
	 YbcS6u7Kidd4OVb39Yu76itka5CcC065V2XsXYCd5PFHOEYsc0UU630+wAa2S0MJMTsUX
	 692VSswSUVREx11hq0wScz0yyLNsk1zeBXjYlDmsIDPSb+PKxHPRdRmO3v5ya65tGgIwd
	 pIoS71TIa28up5GvpSwzlI6Gh4gOAaOpTjlJufW/sn8fdjrxprdGqdZ/0HkpB8vRtYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=oGSe2YE+;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F22606A33A;
	Fri, 13 Nov 2026 08:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76F22606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=oGSe2YE+
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xRmtj-00760H-21; Fri, 13 Nov 2026 09:44:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=35X5/39DGlK4vVgt3yjbOmExblr5OIYpDLCti5rn1Hk=; b=oGSe2YE+jbOYv4Jk/U6zrtgtmz
	sLPbPjmfDgxRFHdpk9MuGDIea9wv9juscvego0b2ixIR92xocAUKANt2RPGJzR+Szb6aDLFKQ6V9K
	3IzFPe8Q5YkKogwCel1vobsqxBaBsHSEMRMHw+dfA0De0b3/esaqAzf2eTbdC6Vb/YmUjHyMsUb1A
	VhKtzfs6qj6vf/LhlO9HXi+QVc7AIJOZDQ4fJ3d+K2eLnrrPV54ISa1YeLW/zkkrqa3EqYDqVgPwf
	+YMfPGSvCe5d/LJKAaXINZRDX5CTtj4zCeqv8I6WIrJLBGGXdGqFLxgS78PMpT6TF+57ewoj7b9p4
	Ee5ZldNA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xRmtY-0001ns-3Y; Fri, 13 Nov 2026 09:44:28 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xRmtH-008Vgn-9V;
	Fri, 13 Nov 2026 09:44:11 +0100
Message-ID: <76d24fdd-ec12-4686-9c22-167aae8975c0@rbox.co>
Date: Fri, 13 Nov 2026 09:44:09 +0100
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
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net] vhost/vsock: Fix socket state constant
To: netdev-bot+sinfo@kernel.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261112-transport-reset-state-fix-v1-1-5698375f52a9@rbox.co>
 <179447976386.2168702.18392043659968828325@kernel.org>
 <b4dbeace-95ad-4b0e-8f13-a418ab59e8df@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <b4dbeace-95ad-4b0e-8f13-a418ab59e8df@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>>  - Whether the issue was actually triggered, or is only theoretical
>>    (e.g. found by LLM and not proven at runtime). If it was triggered
>>    please include the symptoms, like the stack trace or kernel messages.
> 
> Not triggered at runtime. It's a correctness fix, I didn't try to work out
> what could/would actually go wrong.

I don't see any way this could really affect the kernel. Will re-post to
net-next along with some other cleanups. Sorry for the noise.

pw-bot: cr
